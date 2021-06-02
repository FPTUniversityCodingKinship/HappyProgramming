/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.controller;

import hps.comments.CommentsDAO;
import hps.mentorDetails.MentorDetailsDAO;
import hps.mentorDetails.MentorDetailsDTO;
import hps.requests.RequestsDAO;
import hps.users.UsersDAO;
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
 * @author ADMIN
 */
@WebServlet(name = "ShowMentorDetailsController", urlPatterns = {"/ShowMentorDetailsController"})
public class ShowMentorDetailsController extends HttpServlet {
private final String LIST_SUGGESTION_PAGE = "MenteeListSuggestionPage";
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
        
        String url = LIST_SUGGESTION_PAGE;
        String mentorID = request.getParameter("mentorID");
        try{
            UsersDAO userDAO = new UsersDAO();
            String fullname = userDAO.getProfile(mentorID).getFullname();
            String username = userDAO.getProfile(mentorID).getUsername();
            CommentsDAO cDAO = new CommentsDAO();
            float avgStar = cDAO.getAvgStar(mentorID);
            String star = "";
            if(avgStar != -1){
                star = String.valueOf(avgStar);
            }else{
                star = "Have not been rated yet";
            }
            RequestsDAO rDAO = new RequestsDAO();
            String numReq = String.valueOf(rDAO.getNumberOfRequest(mentorID));
            String mentorInfo = fullname + "," + username + "," + star + "," + numReq ;
            HttpSession session = request.getSession();
            session.setAttribute("MENTOR_INFO", mentorInfo);
            session.setAttribute("CHOSEN_MENTOR_ID", mentorID);
        } catch (NamingException ex) {
            log("ShowMentorDetailsController NamingException: " + ex.getMessage());
        } catch (SQLException ex) {
            log("ShowMentorDetailsController SQLException: " + ex.getMessage());
        } 
        finally{
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
