/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.controller;

import hps.mentorSkills.MentorSkillsDAO;
import hps.requests.RequestsDAO;
import hps.requests.RequestsDTO;
import hps.skills.SkillsDAO;
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
@WebServlet(name = "MenteeShowRequestController", urlPatterns = {"/MenteeShowRequestController"})
public class MenteeShowRequestController extends HttpServlet {
private final String SUCCESS_PAGE = "MenteeLoadRequest";
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
        request.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        String url = "";
        String requestID = request.getParameter("requestID");
        
        try{
            RequestsDAO dao = new RequestsDAO();
            RequestsDTO requestInfo = dao.getRequestByRequestID(requestID);
            HttpSession session = request.getSession();
            session.setAttribute("REQUEST_INFO", requestInfo);
            String skillsID = requestInfo.getSkillsID();
            SkillsDAO sDAO = new SkillsDAO();
            String skillsName = sDAO.getSkillsName(skillsID);
            session.setAttribute("SKILLS_NAME", skillsName);
            MentorSkillsDAO msDAO = new MentorSkillsDAO();
            List<String> mappingMentorsID = msDAO.getMappingMentorId(skillsID);
            session.setAttribute("MAPPING_MENTORS_ID", mappingMentorsID);
            url = SUCCESS_PAGE;
        } catch (NamingException ex) {
            log("MenteeShowRequestController NamingException: " + ex.getMessage());
        } catch (SQLException ex) {
            log("MenteeShowRequestController SQLException: " + ex.getMessage());
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
