/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.controller;

import hps.skills.SkillsDAO;
import hps.users.UsersDTO;
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
 * @author Tran Phong <phongntse150974@fpt.edu.vn>
 */
@WebServlet(name = "AdminViewSkillsUpdateNameController", urlPatterns = {"/AdminViewSkillsUpdateNameController"})
public class AdminViewSkillsUpdateNameController extends HttpServlet {

    private static final String VIEW_SKILL_CONTROLLER = "AdminViewSkillsList";
    private static final String LOGIN_PAGE = "/";

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
            HttpSession session = request.getSession(false);
            if (session == null) {
                url = LOGIN_PAGE;
            } else {
                UsersDTO curMentor = (UsersDTO) session.getAttribute("CURRENT_USER"); // TODO code
                if (curMentor == null || !curMentor.getUserID().startsWith("AD")) {
                    url = LOGIN_PAGE;
                } else {
                    String skillID = request.getParameter("skillID");
                    String skillName = request.getParameter("skillName");
                    String currentSkillName = request.getParameter("currentSkillName");

                    SkillsDAO skillsDAO = new SkillsDAO();

                    if (!skillName.equals(currentSkillName)) {
                        if (skillName.trim().isEmpty()) {
                            request.setAttribute("SKILL_UPDATE_NAME_ERROR",
                                    "The updated Skill's Name requires input more than 1 characters. Please try with another name...");
                            url = VIEW_SKILL_CONTROLLER;
                        } else if (skillsDAO.checkSkillNameExisted(skillName)) {
                            request.setAttribute("SKILL_UPDATE_NAME_ERROR",
                                    "The updated Skill's Name is existed! Please try with another name...");
                            url = VIEW_SKILL_CONTROLLER;
                        } else {
                            boolean result = skillsDAO.updateSkill(skillID, skillName);
                            if (result) {
                                request.setAttribute("SKILL_UPDATE_NAME_SUCCESS",
                                        "Update Skill's Name successfully!!");
                                url = VIEW_SKILL_CONTROLLER;
                            }
                        }
                    }
                }
            }

        } catch (SQLException ex) {
            log("Error at AdminViewSkillsUpdateNameController: " + ex.getMessage());
            request.setAttribute("SKILL_UPDATE_NAME_ERROR", "An error has occured while we are trying connect to the database! Please contact the web owner for more details!!");
            url = VIEW_SKILL_CONTROLLER;
        } catch (NamingException ex) {
            log("Error at AdminViewSkillsUpdateNameController: " + ex.getMessage());
            request.setAttribute("SKILL_UPDATE_NAME_ERROR", "A system error has occured! Please contact the web owner for more details!!");
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
