
package hps.controller;

import hps.comments.CommentsDAO;
import hps.requests.RequestsDAO;
import hps.requests.RequestsStatisticsDTO;
import hps.users.UsersDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Tran Phong <phongntse150974@fpt.edu.vn>
 */
@WebServlet(name = "RequestsStatisticsController", urlPatterns = {"/RequestsStatisticsController"})
public class RequestsStatisticsController extends HttpServlet {

    private static final String VIEW_PAGE = "RequestsStatisticsPage";
    private static final String LOGIN_PAGE = "LoginPage";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        PrintWriter out = response.getWriter();
        String url = LOGIN_PAGE;

        try {
//              number of currently accepted request, 
//              nummber of currently invited request, 
//              number of canceled request, 
//              percentage of cancel request, 
//              percentage of completed request, 
//              rating star
            HttpSession session = request.getSession(false);
            if (session == null) {
                url = LOGIN_PAGE;
            } else {
                UsersDTO curMentor = (UsersDTO) session.getAttribute("CURRENT_USER"); // TODO code
                if (curMentor == null || !curMentor.getUserID().startsWith("MT")) {
                    url = LOGIN_PAGE;
                } else {
                    UsersDTO mentor = (UsersDTO) session.getAttribute("CURRENT_USER");
                    String mentorID = mentor.getUserID();

                    RequestsDAO dao = new RequestsDAO();
                    // No. of currently accepted request
                    int numAccepted = dao.getNumberOfRequest(mentorID, RequestsDAO.STATUS_ACCEPTED);
                    // No. of currently invited request
                    int numRequests = dao.getNumberOfRequest(mentorID);
                    // No. of canceled request
                    int numRejected = dao.getNumberOfRequest(mentorID, RequestsDAO.STATUS_REJECTED);
                    // No. of completed request
                    int numClosed = dao.getNumberOfRequest(mentorID, RequestsDAO.STATUS_CLOSED);

                    // Percentage of cancel request
                    float percentRejected = (float) numRejected / numRequests * 100;
                    // Percentage of completed request
                    float percentClosed = (float) numClosed / numRequests * 100;

                    // Rating star
                    CommentsDAO commentsDAO = new CommentsDAO();
                    float rate = commentsDAO.getAvgStar(mentorID);

                    RequestsStatisticsDTO returnDTO = new RequestsStatisticsDTO(numAccepted, numRequests, numRejected, percentRejected, percentClosed, rate);

                    request.setAttribute("REQUESTS_STATISTICS_DATA", returnDTO);
                    request.setAttribute("REQUESTS_STATISTICS_DATA_STAR", (int)rate);
                    url = VIEW_PAGE;

                }
            }

        } catch (SQLException ex) {
            log("Error at RequestsStatisticsController: " + ex.getMessage());
            request.setAttribute("STATISTICS_ERROR", "An error has occured! Please contact the web owner for more details!!");
            url = VIEW_PAGE;
        } catch (NamingException ex) {
            log("Error at RejectRequestController: " + ex.getMessage());
            request.setAttribute("STATISTICS_ERROR", "An error has occured! Please contact the web owner for more details!!");
            url = VIEW_PAGE;
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
