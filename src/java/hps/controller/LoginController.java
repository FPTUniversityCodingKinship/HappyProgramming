/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.controller;


import hps.users.UsersCreateError;

import hps.users.UsersDAO;
import hps.users.UsersDTO;
import hps.utilities.MailHandler;
import hps.verify.VerifyDTO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpSession;

/**
 *
 * @author DELL
 */
@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {
    private static final String MENTEE_PAGE = "MenteeStartUp";
    private static final String MENTOR_PAGE = "MentorHomePage";
//    private static final String ADMIN_PAGE = "AdminHomePage";
    private static final String ADMIN_PAGE = "AdminViewRequestsListPage";
    private static final String INACTIVE_PAGE = "MailVerificationPage";
    private static final String ERROR_PAGE = "LoginPage";


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
        String gmail = request.getParameter("txtGmail");
        String remember = request.getParameter("chkCookie");
        UsersCreateError err = new UsersCreateError();
        MailHandler sm = null;
        VerifyDTO verifier = null;
        boolean flag = false;
        String url = ERROR_PAGE;
        String sout = "";
        boolean existCode = false;
        
        try {
            // check type of login is google or traditional
            if (gmail == null) {
                gmail = "";
                if (username.isEmpty()) {
                    flag = true;
                    err.setUsernameLengthErr("Username is empty");
                }
                if (password.isEmpty()) {
                    flag = true;
                    err.setPasswordLengthErr("Password is empty");
                }
            }
            // if param is good, call DAO
            if (flag == false) {
                UsersDAO dao = new UsersDAO();
                UsersDTO user;
                if (!gmail.isEmpty())
                    user = dao.checkLoginByMail(gmail);
                else
                    user = dao.checkLogin(username, password);
                if (user != null) {
                    HttpSession session = request.getSession();
                    session.setAttribute("CURRENT_USER", user);
                    if (remember != null && gmail.isEmpty()) {
                        String key = "HPSWA-" + username;
                        Cookie cookie = new Cookie(key, password);
                        cookie.setMaxAge(60*60*24);
                        response.addCookie(cookie);
                    }
                    
                    if (user.isEmailStatus()) {
                        String role = user.getUserID().substring(0, 2);
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
                        sm = new MailHandler();
                        //get the 6-digit code
                        String code = sm.getVerifyCode();
                        //get the date time at the sendding
                        String time = sm.getCurrentDateTime();
                        verifier = new VerifyDTO(user.getEmail(), code, time);
                        //add verify code to context
                        ServletContext context = getServletContext();
                        ArrayList<VerifyDTO> verifyList = (ArrayList<VerifyDTO>) 
                                    context.getAttribute("VERIFY_LIST");
                        if (verifyList != null) {
                            verifyList.add(verifier);
                            for (VerifyDTO entry : verifyList) {
                                //if email existed, replace time and code
                                if (entry.getEmail().equals(verifier.getEmail())) {
                                    if (verifyList.remove(entry)) {
                                        System.out.println("[UserVerify] remove:" 
                                                    + entry.toString());
                                    }
                                    if (verifyList.add(verifier)) {
                                        System.out.println("[UserVerify] add:" 
                                                    + verifier.toString());
                                    }
                                    existCode = true;
                                    break;
                                }
                            }
                            if (!existCode) {
                                verifyList.add(verifier);
                            }

                        }
                        //re-up list onto context Scope's attribute
                        context.setAttribute("VERIFY_LIST", verifyList);
                        url = INACTIVE_PAGE;
                        sout += "Activation Status of ["
                                    + user.getUsername() + "] is [false]";
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
                RequestDispatcher rd = request.getRequestDispatcher(url);
                rd.forward(request, response);
            }
            else {
                response.sendRedirect(url);
            }
        } catch (NamingException ex) {
            log(ex.getMessage());
            sout = "NamingException was caught.";
        } catch (SQLException ex) {
            log(ex.getMessage());
            sout = "SQLException was caught.";
        } finally {
            if (verifier != null && sm != null) {
                boolean isSend = sm.sendEmail(verifier);
                System.out.println("[UserVerify] isSend:" + isSend);
            }
            System.out.println("[LoginController] " + sout);
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