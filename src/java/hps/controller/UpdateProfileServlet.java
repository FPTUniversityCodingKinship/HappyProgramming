/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.controller;

import hps.users.UsersDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;

/**
 *
 * @author DELL
 */
@WebServlet(name = "UpdateProfileServlet", urlPatterns = {"/UpdateProfileServlet"})
public class UpdateProfileServlet extends HttpServlet {

    private static final String PROFILE_PAGE = "UpdateProfile";

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
        String url = PROFILE_PAGE;
        try {
            String userID = request.getParameter("txtUserID");
            
            String username = request.getParameter("txtUsername");
            String password = request.getParameter("txtPassword");
            String fullname = request.getParameter("txtFullname");
            String phone = request.getParameter("txtPhone");
            String address = request.getParameter("txtAddress");
            String dob = request.getParameter("txtDob");

            String sex = request.getParameter("txtSex");
            //User's avatar
            Part filePart = request.getPart("imageFile");
            //TO-DO Code
            //Update if the parameters are not null
            if (!username.trim().isEmpty()
                    && !password.trim().isEmpty()
                    && !fullname.trim().isEmpty()
                    && !phone.trim().isEmpty()
                    && !address.trim().isEmpty()
                    && !dob.trim().isEmpty()) {
                Date dob_date = Date.valueOf(dob);
                UsersDAO dao = new UsersDAO();
                boolean result = dao.updateProfile(userID, username, password,
                        fullname, phone, address, dob_date, sex);
                if (result) {
                    request.setAttribute("UPDATE_STATUS", "Profile Updated");
                }
            }

        } catch (SQLException ex) {
            log(ex.getMessage());
            request.setAttribute("UPDATE_STATUS", "Error, Please try again");
        } catch (NamingException ex) {
            log(ex.getMessage());
        } finally {
            if (out != null) {
                out.close();
            }
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
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
