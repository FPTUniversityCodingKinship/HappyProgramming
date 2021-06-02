/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.controller;

import hps.requests.RequestsDAO;
import hps.requests.RequestsDTO;
import hps.skills.SkillsDAO;
import hps.skills.SkillsError;
import hps.users.UsersDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
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
@WebServlet(name = "AdminCreateSkillController", urlPatterns = {"/AdminCreateSkillController"})
public class AdminCreateSkillController extends HttpServlet {
private final String ERROR_PAGE = "AdminCreateSkillPage";
private final String SUCCESS_PAGE = "AdminHomePage";
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
        
        String url = ERROR_PAGE;
        try{
            String skillName = request.getParameter("skillName");
            String skillType = request.getParameter("skillType");
            SkillsDAO dao = new SkillsDAO();
            boolean isError = false;
            SkillsError error = new SkillsError();
            
            boolean existedSkillName = dao.checkSkillNameExisted(skillName);
            if(existedSkillName){
                isError = true;
                error.setSkillNameExisted("Skill name existed");
            }
            
            if(isError){
                request.setAttribute("SKILL_NAME_ERROR", error);
            }else{
                String skillID = dao.generateSkillID(skillType);
                boolean result = dao.addNewSkill(skillID, skillName, 1);
                if(result){
                    url = SUCCESS_PAGE;
                }
            }
        } catch (NamingException ex) {
            log("AdminCreateSkillController NamingException: " + ex.getMessage());
        } catch (SQLException ex) {
            log("AdminCreateSkillController SQLException: " + ex.getMessage());
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
