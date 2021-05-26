/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.controller;

import hps.users.UsersCreateError;
import hps.users.UsersDAO;
import hps.users.UsersDTO;
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
import javax.servlet.http.HttpSession;

/**
 *
 * @author DELL
 */
@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {
    private static final String MENTEE_PAGE = "MenteeHomePage";
    private static final String MENTOR_PAGE = "MentorHomePage";
    private static final String ADMIN_PAGE = "AdminHomePage";
    private static final String INACTIVE_PAGE = "MailVerificationPage";
    private static final String ERROR_PAGE = "";

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
        String username = request.getParameter("txtUsername");
        String password = request.getParameter("txtPassword");
        String remember = request.getParameter("chkCookie");
        UsersCreateError err = new UsersCreateError();
        boolean flag = false;
        String url = ERROR_PAGE;
        String sout = "";
        
        try {
            if (username.isEmpty()) {
                flag = true;
                err.setUsernameLengthErr("Username is empty");
            }
            if (password.isEmpty()) {
                flag = true;
                err.setUsernameLengthErr("Password is empty");
            }
            if (flag == false) {
                UsersDAO usersDao = new UsersDAO();
                UsersDTO result = usersDao.checkLogin(username, password);
                if (result != null) {
                    HttpSession session = request.getSession();
                    session.setAttribute("CURRENT_USER", result);
                    String role = result.getUserID().substring(0, 2);
                    if (result.isStatus()) {
                        switch (role) {
                            case "ME":
                                url = MENTEE_PAGE;
                                sout = "Logged in as Mentee. ";
                                break;
                            case "MT":
                                url = MENTOR_PAGE;
                                sout = "Logged in as Mentor. ";
                                break;
                            case "AD":
                                url = ADMIN_PAGE;
                                sout = "Logged in as Admin. ";
                                break;
                        }
                    }
                    else {
                        url = INACTIVE_PAGE;
                        sout += "Activation Status of ["
                                    + result.getUsername() + "] is [false]";
                    }
                } 
                else {
                    flag = true;
                    err.setLoginInfoNotMatch("Username or Password is incorrect");
                }
            }
            if (flag == true) {
                request.setAttribute("LOGIN_ERROR", err);
                sout = "Failed to Login. ";
            }
        } catch (NamingException ex) {
            log(ex.getMessage());
            sout = "NamingException was caught.";
        } catch (SQLException ex) {
            log(ex.getMessage());
            sout = "SQLException was caught.";
        } finally {
            System.out.println("[LoginController] " + sout);
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
