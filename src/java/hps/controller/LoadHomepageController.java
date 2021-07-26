/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.controller;

import hps.comments.CommentsDAO;
import hps.mentorDetails.MentorDetailsDAO;
import hps.mentorDetails.MentorDetailsDTO;
import hps.mentorDetails.MentorHomepageDTO;
import hps.mentorSkills.MentorSkillsDAO;
import hps.mentorSkills.MentorSkillsDTO;
import hps.skills.SkillsDAO;
import hps.users.UsersDAO;
import hps.users.UsersDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
@WebServlet(name = "LoadHomepageController", urlPatterns = {"/LoadHomepageController"})
public class LoadHomepageController extends HttpServlet {

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
        List<MentorHomepageDTO> listLoad = new ArrayList<>();
        
        try {
            CommentsDAO cDao = new CommentsDAO();
            List<String> listID = cDao.getBestMentor();
            
            if (listID.size() > 0) {
                UsersDAO uDao = new UsersDAO();
                MentorSkillsDAO msDao = new MentorSkillsDAO();
                for (String id : listID) {
                    UsersDTO mentor = uDao.getProfile(id);
                    List<MentorSkillsDTO> skills = msDao.getMentorSkills(id);
                    if (skills != null && mentor != null) {
                        String skillString = "";
                        SkillsDAO skDao = new SkillsDAO();
                        
                        for (MentorSkillsDTO skill : skills) {
                            skillString += skDao.getSkillsName(skill.getSkillID()) + ", ";
                        }
                        skillString += "...";
                        
                        listLoad.add(new MentorHomepageDTO(id, mentor.getFullname(),
                                    mentor.getImage(), skillString));
                    }
                }
                
                request.setAttribute("MENTOR_LIST", listLoad);
            }
        } catch (SQLException | NamingException ex) {
            Logger.getLogger(LoadHomepageController.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
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
