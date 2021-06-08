/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.controller;

import hps.skills.SkillsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Tran Phong <phongntse150974@fpt.edu.vn>
 */
@WebServlet(name = "AdminViewSkillsUpdateStatusController", urlPatterns = {"/AdminViewSkillsUpdateStatusController"})
public class AdminViewSkillsUpdateStatusController extends HttpServlet {

    private static final String VIEW_SKILL_CONTROLLER = "AdminViewSkillsList";

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

        String url = VIEW_SKILL_CONTROLLER;

        try {
            String skillID = request.getParameter("skillID");
            String updatedStatus = request.getParameter("updatedStatus");
            boolean status = "active".equals(updatedStatus);

            SkillsDAO skillsDAO = new SkillsDAO();
            boolean isUpdated = skillsDAO.updateSkill(skillID, status);
            
            if (isUpdated) {
                request.setAttribute("SKILL_UPDATE_STATUS_SUCCESS", 
                        (status ? "Activate" : "Inactivate") + " skill successfully!");
                url = VIEW_SKILL_CONTROLLER;
            } else {
                request.setAttribute("SKILL_UPDATE_STATUS_ERROR", 
                        "The skill doesn't exist! Please check again!");
                url = VIEW_SKILL_CONTROLLER;
            }
        } catch (SQLException ex) {
            log("Error at AdminViewSkillsUpdateStatusController: " + ex.getMessage());
            request.setAttribute("SKILL_UPDATE_STATUS_ERROR", "An error has occured! Please contact the web owner for more details!!");
            url = VIEW_SKILL_CONTROLLER;
        } catch (NamingException ex) {
            log("Error at AdminViewSkillsUpdateStatusController: " + ex.getMessage());
            request.setAttribute("SKILL_UPDATE_STATUS_ERROR", "An error has occured! Please contact the web owner for more details!!");
            url = VIEW_SKILL_CONTROLLER;
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
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
