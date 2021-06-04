/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.controller;

import hps.skills.SkillsDAO;
import hps.skills.SkillsError;
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
 * @author ADMIN
 */
@WebServlet(name = "AdminUpdateSkillController", urlPatterns = {"/AdminUpdateSkillController"})
public class AdminUpdateSkillController extends HttpServlet {
private final String ERROR_PAGE = "AdminUpdateSkillPage";
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
            String skillID = request.getParameter("skillID");
            String skillName = request.getParameter("txtSkillName");
            String strStatus = request.getParameter("status");
            String currentSkillName = request.getParameter("currentSkillName");
            int status = strStatus.equals("Active")? 1 : 0;
            SkillsError error = new SkillsError();
            boolean isError = false;
            SkillsDAO dao = new SkillsDAO();
            
            if(skillName.equalsIgnoreCase(currentSkillName)){
                
            }else if(dao.checkSkillNameExisted(skillName)){
                isError = true;
                error.setSkillNameExisted("Skill name existed");
            }
            
            if(skillName.isEmpty()){
                isError = true;
                error.setSkillNameLengthErr("Skill name must be at least 1 character");
            }
            
            if(isError){
                request.setAttribute("UPDATE_SKILL_ERROR", error);
            }else{
                boolean result = dao.updateSkill(skillID, skillName, status);
                if(result){
                    url = SUCCESS_PAGE;
                    HttpSession session = request.getSession();
                    session.removeAttribute("LIST_ALL_SKILLS");
                    session.removeAttribute("SKILL_INFO");
                }
            }
            
        } catch (NamingException ex) {
            log("AdminUpdateSkillController NamingException: " + ex.getMessage());
        } catch (SQLException ex) {
            log("AdminUpdateSkillController SQLException: " + ex.getMessage());
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
