/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.controller;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import hps.mentorDetails.ReturnResultDTO;
import hps.mentorSkills.MentorSkillsDAO;
import hps.mentorSkills.MentorSkillsDTO;
import hps.skills.SkillsJSONDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Tran Phong <phongntse150974@fpt.edu.vn>
 */
@WebServlet(name = "AddMentorSkillsController", urlPatterns = {"/AddMentorSkillsController"})
public class AddMentorSkillsController extends HttpServlet {

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
        Gson gson = new Gson();

        List<SkillsJSONDTO> skillsList = new ArrayList<>();
        
        ReturnResultDTO returnResult = new ReturnResultDTO();

        try {
            String mentorID = request.getParameter("mentorID");
            String skillsListJSON = request.getParameter("skillsList");
            
            Type type = new TypeToken<List<SkillsJSONDTO>>(){}.getType();
            skillsList = gson.fromJson(skillsListJSON, type);
            
            boolean isAdded = false;

            if (skillsList != null && !skillsList.isEmpty()) {
                MentorSkillsDAO mentorSkillsDAO = new MentorSkillsDAO();

                for (SkillsJSONDTO skill : skillsList) {
                    String mentorSkillID = mentorSkillsDAO.generateMentorSkillID();
                    MentorSkillsDTO skillsDTO = new MentorSkillsDTO(
                                                        mentorSkillID,
                                                        mentorID,
                                                        skill.getSkillID(),
                                                        skill.getYearsExperience(),
                                                        skill.getRate()
                                                );
                    isAdded = mentorSkillsDAO.addMentorSkills(skillsDTO);
                    if (!isAdded) {
                        break;
                    }
                }
                if (isAdded) {
                    returnResult.setSuccess(true);
                    returnResult.setMessage("Skills are added successfully!!");
                }
                else {
                    returnResult.setSuccess(false);
                    returnResult.setMessage("There has been an error while we are "
                            + "trying to add your skills! Please contact the web owners "
                            + "for more details.");
                }
                
            }
        } catch (SQLException ex) {
            log("Error at AddMentorSkillsController: " + ex.getMessage());
            returnResult.setSuccess(false);
            returnResult.setMessage("There has been an error while we are "
                    + "trying to create your profile! Please contact the web owners "
                    + "for more details.");
        } catch (NamingException ex) {
            log("Error at AddMentorSkillsController: " + ex.getMessage());
            returnResult.setSuccess(false);
            returnResult.setMessage("There has been an error while we are "
                    + "trying to create your profile! Please contact the web owners "
                    + "for more details.");
        } catch (NumberFormatException ex) {
            log("Error at AddMentorSkillsController: " + ex.getMessage());
        } 
        finally {
            String resultStr = gson.toJson(returnResult);
            out.print(resultStr);
            out.flush();
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
