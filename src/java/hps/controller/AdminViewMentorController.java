
package hps.controller;

import hps.comments.CommentsDAO;
import hps.mentorDetails.MentorDetailsDAO;
import hps.requests.RequestsDAO;
import hps.users.UsersDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
 * @author ADMIN
 */
@WebServlet(name = "AdminViewMentorController", urlPatterns = {"/AdminViewMentorController"})
public class AdminViewMentorController extends HttpServlet {
private final String VIEW = "AdminViewMentorPage";
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
        
        String url = VIEW;
        try{
            String searchValue = request.getParameter("searchValue");
            String pageID = request.getParameter("pageID");
            if(searchValue == null){
                searchValue = (String)request.getAttribute("SEARCH_VALUE");
                if(searchValue == null)
                    searchValue = "";
            }
            if(pageID == null){
                pageID = "1";
            }
            HttpSession session = request.getSession();
            //total rows of one page
            int total = 5;
            UsersDAO uDao = new UsersDAO();
            CommentsDAO cDao = new CommentsDAO();
            RequestsDAO rDao = new RequestsDAO();
            MentorDetailsDAO mDao = new MentorDetailsDAO();
            List<String> listMentorIDs = uDao.getMentorIDs(searchValue, Integer.parseInt(pageID), total);
            int totalRow = uDao.countTotalRows(searchValue);
            int numOfPages = (int)Math.ceil((double)totalRow/total);
            session.setAttribute("NUM_OF_PAGES", numOfPages);
            
            
            List<String> mentorIDs = new ArrayList<>();
            for(String mentor : listMentorIDs){
                mentorIDs.add(mentor.split(",")[0]);
            }
            Map<String,String> map = new HashMap<>();
            for(String mentorID : mentorIDs){
                map.put(mentorID, uDao.getMentorFullname(mentorID) 
                        + "," + uDao.getMentorUsername(mentorID) 
                        + "," + mDao.getProfession(mentorID) 
                        + "," + String.valueOf(rDao.getNumOfApprovedReq(mentorID)) 
                        + "," + String.valueOf(rDao.getNumOfApprovedReq(mentorID) == 0 
                                ? "No request accepted yet" 
                                : ((double)rDao.getNumOfCompletedReq(mentorID)/rDao.getNumOfApprovedReq(mentorID))*100) 
                        + "," + String.valueOf(cDao.getRateStar(mentorID) == 0 ? "Not rated yet" : cDao.getRateStar(mentorID)) 
                        + "," + uDao.getStatus(mentorID)
                );
            }
            session.setAttribute("MENTOR_INFO", map);
        } catch (NamingException ex) {
            log("AdminViewMentorController NamingException: " + ex.getMessage());
        } catch (SQLException ex) {
            log("AdminViewMentorController SQLException: " + ex.getMessage());
        }finally{
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
            if(out != null){
                out.close();
            }
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
