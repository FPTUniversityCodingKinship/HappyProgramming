/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.controller;

import hps.users.UsersDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;

/**
 *
 * @author DELL
 */
@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {
<<<<<<< Updated upstream
    
    private static final String LOGIN_SUCCESS = "LoginSuccess";
=======
    private static final String MENTEE_PAGE = "MenteeHomePage";
    private static final String MENTOR_PAGE = "MentorHomePage";
    private static final String ADMIN_PAGE = "AdminHomePage";
>>>>>>> Stashed changes

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String url = "";
        try {
            if (!username.isEmpty() && !password.isEmpty()) {
                
                UsersDAO usersDao = new UsersDAO();
<<<<<<< Updated upstream
                boolean result = usersDao.checkLogin(username, password);
                if (result) {
                    url = LOGIN_SUCCESS;
=======
                UsersDTO result = usersDao.checkLogin(username, password);
                if (result != null) {
                    HttpSession session = request.getSession();
                    session.setAttribute("CURRENT_USER", result);
                    url = MENTEE_PAGE;
>>>>>>> Stashed changes
                }
            }
        } catch (NamingException ex) {
            log(ex.getMessage());
        } catch (SQLException ex) {
            log(ex.getMessage());
        } finally {
//            String uri = request.getRequestURI();
//            System.out.println("URL:" + url);
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
            if (out != null) {
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
