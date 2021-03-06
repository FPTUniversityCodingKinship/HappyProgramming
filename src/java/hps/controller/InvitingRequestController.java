
package hps.controller;

import hps.requests.RequestsDAO;
import hps.requests.RequestsDTO;
import hps.users.UsersDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
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
@WebServlet(name = "InvitingRequestController", urlPatterns = {"/InvitingRequestController"})
public class InvitingRequestController extends HttpServlet {

    private static final String VIEW_PAGE = "ViewInvitingRequestPage";
    private static final String LOGIN_PAGE = "/";
    
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

        String url = VIEW_PAGE;

        try {
            HttpSession session = request.getSession(false);
            if (session == null) {
                url = LOGIN_PAGE;
            } else {
                UsersDTO curMentor = (UsersDTO) session.getAttribute("CURRENT_USER"); // TODO code
                if (curMentor == null) {
                    url = LOGIN_PAGE;
                } else {
                    String mentorID = curMentor.getUserID();
                    if (!mentorID.startsWith("MT")) {
                        url = LOGIN_PAGE;
                    } else {
                        RequestsDAO requestsDAO = new RequestsDAO();
                        List<RequestsDTO> listInvitingRequets = requestsDAO.getInvitingRequestsList(mentorID);

                        request.setAttribute("INVITING_REQUESTS", listInvitingRequets);
                        url = VIEW_PAGE;
                    }
                }
            }
        } catch (SQLException ex) {
            log("Error at InvitingRequestController: " + ex.getMessage());
            request.setAttribute("INVITING_ERROR", "An error has occured when we try to connect to the database!"
                    + " Please contact the web owner for more details!!");
            url = VIEW_PAGE;
        } catch (NamingException ex) {
            log("Error at InvitingRequestController: " + ex.getMessage());
            request.setAttribute("INVITING_ERROR", "A system error has occured! Please contact the web owner for more details!!");
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
