/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.controller;

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
            UsersDAO dao = new UsersDAO();
            List<String> listMentorIDs = dao.getMentorIDs(searchValue, Integer.parseInt(pageID), total);
            int totalRow = dao.countTotalRows(searchValue);
            int numOfPages = (int)Math.ceil((double)totalRow/total);
            session.setAttribute("NUM_OF_PAGES", numOfPages);
            
            
            List<String> mentorIDs = new ArrayList<>();
            for(String mentor : listMentorIDs){
                mentorIDs.add(mentor.split(",")[0]);
            }
            Map<String,String> map = new HashMap<>();
            for(String mentorID : mentorIDs){
                map.put(mentorID, dao.getMentorFullname(mentorID) 
                        + "," + dao.getMentorUsername(mentorID) 
                        + "," + dao.getProfession(mentorID) 
                        + "," + String.valueOf(dao.getNumOfApprovedReq(mentorID)) 
                        + "," + String.valueOf(dao.getNumOfApprovedReq(mentorID) == 0 
                                ? "No request accepted yet" 
                                : ((double)dao.getNumOfCompletedReq(mentorID)/dao.getNumOfApprovedReq(mentorID))*100) 
                        + "," + String.valueOf(dao.getRateStar(mentorID) == 0 ? "Not rated yet" : dao.getRateStar(mentorID)) 
                        + "," + dao.getStatus(mentorID)
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
