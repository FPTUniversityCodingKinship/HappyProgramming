/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
@WebServlet(name = "StartUpController", urlPatterns = {"/StartUpController"})
public class StartUpController extends HttpServlet {
    private final String HOME_PAGE = "HomePage";
    private final String LOGIN_CONTROLLER = "Login";
    
    
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
        
        Cookie[] cookies = null;
        String msg = "";
        String url = HOME_PAGE;
        
        try {
            cookies = request.getCookies();
            if (cookies != null) {
                msg = "Cookies file was found. ";
                String username = "";
                String password = "";
                for (Cookie info : cookies) {
                    String[] key = info.getName().split("-", 2);
                    if (key[0].equals("HPSWA")) {
                        username = key[1];
                        password = info.getValue();
                    }
                }

                if (!username.equals("") && !password.equals("")) {
                    msg += "Redirect to [LoginController]. ";
                    url = LOGIN_CONTROLLER + "?"
                                + "txtUsername=" + username + "&"
                                + "txtPassword=" + password;
                } else {
                    msg += "Wrong cookie or logged out. ";
                }
            }
        }
        finally {
            response.sendRedirect(url);
            if (cookies != null)
                System.out.println("[StartUpController] " + msg);
            if (out != null)
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
