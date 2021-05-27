/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.controller;

import hps.requests.RequestsDAO;
import hps.users.UsersDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
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
@WebServlet(name = "MenteeStatisticRequestController", urlPatterns = {"/MenteeStatisticRequestController"})
public class MenteeStatisticRequestController extends HttpServlet {
private final String SUCCESS_PAGE = "MenteeStatisticRequestPage";
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
        String url = SUCCESS_PAGE;
        
        try{
            HttpSession session = request.getSession();
            UsersDTO user = (UsersDTO)session.getAttribute("CURRENT_USER");
            String menteeID = user.getUserID();
            RequestsDAO dao = new RequestsDAO();
            ArrayList<String> titles = (ArrayList)dao.getRequestTitle(menteeID);
            if(!titles.isEmpty()){
                request.setAttribute("REQUESTS_TITLE", titles);
            }
            String totalRequest = dao.getTotalNumberOfRequest(menteeID);
            request.setAttribute("TOTAL_REQUEST", totalRequest);
            String totalHours = dao.getTotalHoursOfRequest(menteeID);
            request.setAttribute("TOTAL_HOUR", totalHours);
            String totalMentor = dao.getTotalMentor(menteeID);
            request.setAttribute("TOTAL_MENTOR", totalMentor);
        }catch (NamingException ex) {
            log("MenteeStatisticRequestController NamingException: " + ex.getMessage());
        } catch (SQLException ex) {
            log("MenteeStatisticRequestController SQLException: " + ex.getMessage());
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
