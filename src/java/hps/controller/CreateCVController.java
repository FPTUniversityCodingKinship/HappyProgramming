/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.controller;

import com.google.gson.Gson;
import hps.mentorDetails.MentorDetailsDAO;
import hps.mentorDetails.MentorDetailsDTO;
import hps.mentorDetails.ReturnResultDTO;
import hps.users.UsersDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
@WebServlet(name = "CreateCVController", urlPatterns = {"/CreateCVController"})
public class CreateCVController extends HttpServlet {

//    private static final String CREATE_CV_PAGE = "CreateCVPage";
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

//        String url = CREATE_CV_PAGE;
        ReturnResultDTO returnResult = new ReturnResultDTO();

        try {
            // Get Parameter
            String userID = request.getParameter("userID");
            String fullname = request.getParameter("fullname");
            String dob = request.getParameter("dob");
//            String email = request.getParameter("email");
            String sex = request.getParameter("sex");
            String address = request.getParameter("address");
            String facebook = request.getParameter("facebook");
            String github = request.getParameter("github");
            String language = request.getParameter("language");
            String profession = request.getParameter("profession");
            String proDescription = request.getParameter("proDescription");
            String serDescription = request.getParameter("serDescription");
            String achDescription = request.getParameter("achDescription");

            // Update user Profile
            UsersDAO usersDAO = new UsersDAO();
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/mm/yyyy");
            Date dobDate = new Date(dateFormat.parse(dob).getTime());
            boolean isUpdated = usersDAO.updateProfile(userID, fullname, address, dobDate, sex);
            if (isUpdated) {
                MentorDetailsDAO mentorDAO = new MentorDetailsDAO();
                MentorDetailsDTO dto = new MentorDetailsDTO(userID, facebook, github, profession, language, proDescription, serDescription, achDescription);
                boolean isCreated = mentorDAO.createCV(dto);
                if (isCreated) {
                    returnResult.setSuccess(true);
                    returnResult.setMessage("CV is created successfully!!");
                } else {
                    returnResult.setSuccess(false);
                    returnResult.setMessage("There has been an error while we are "
                            + "trying to create your CV! Please contact the web owners "
                            + "for more details.");
                }
            } else {
                returnResult.setSuccess(false);
                returnResult.setMessage("There has been an error while we are "
                        + "trying to update your profile! Please contact the web owners "
                        + "for more details.");
            }
        } catch (ParseException ex) {
            log("Error at CreateCVController: " + ex.getMessage());
            returnResult.setSuccess(false);
            returnResult.setMessage("Your Date of Birth is in wrong format!!");
        } catch (SQLException ex) {
            log("Error at CreateCVController: " + ex.getMessage());
            returnResult.setSuccess(false);
            if (ex.getMessage().contains("duplicate")) {
                returnResult.setMessage("Your CV has been already created before! "
                        + "If you want to update your Profile, <a href='UpdateCVPage'>click here</a>");
            } else {
                returnResult.setMessage("There has been an error while we are "
                        + "trying to create your profile! Please contact the web owners "
                        + "for more details.");
            }
        } catch (NamingException ex) {
            log("Error at CreateCVController: " + ex.getMessage());
            returnResult.setSuccess(false);
            returnResult.setMessage("There has been an error while we are "
                    + "trying to create your profile! Please contact the web owners "
                    + "for more details.");
        } finally {
            Gson gson = new Gson();
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
