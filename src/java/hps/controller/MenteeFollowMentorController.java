
package hps.controller;

import hps.followers.FollowersDAO;
import hps.mentorDetails.MentorDetailsDAO;
import hps.users.UsersDAO;
import hps.users.UsersDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
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
@WebServlet(name = "MenteeFollowMentorController", urlPatterns = {"/MenteeFollowMentorController"})
public class MenteeFollowMentorController extends HttpServlet {
private final String VIEW = "MenteFollowMentorPage";
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
            UsersDAO uDAO = new UsersDAO();
            MentorDetailsDAO mDAO = new MentorDetailsDAO();
            FollowersDAO fDAO = new FollowersDAO();
            List<UsersDTO> mentorList = uDAO.getMentorList();
            Map<String,String> professtionList = new HashMap<>();
            for(UsersDTO mentor : mentorList){
                professtionList.put(mentor.getUserID(),
                    mDAO.getProfession(mentor.getUserID()));
            }
            HttpSession session = request.getSession();
            session.setAttribute("MENTOR_LIST", mentorList);
            session.setAttribute("PROFESSION_LIST", professtionList);
            
            UsersDTO currentUser = (UsersDTO)session.getAttribute("CURRENT_USER");
            String userID = currentUser.getUserID();
            List<String> followedMentor = fDAO.getListFollowedMentors(userID);
            session.setAttribute("FOLLOWED_MENTORS", followedMentor);
            
        } catch (SQLException ex) {
            log("MenteeFollowMentorController SQLException: " + ex.getMessage());
        } catch (NamingException ex) {
            log("MenteeFollowMentorController NamingException: " + ex.getMessage());
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
