/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.controller;

import hps.mentorDetails.MentorDetailsDAO;
import hps.mentorDetails.MentorDetailsDTO;
import hps.mentorSkills.MentorSkillsDAO;
import hps.mentorSkills.MentorSkillsDTO;
import hps.users.UsersDAO;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import static java.nio.file.StandardCopyOption.REPLACE_EXISTING;
import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author Tran Phong <phongntse150974@fpt.edu.vn>
 */
@WebServlet(name = "UpdateCVController", urlPatterns = {"/UpdateCVController"})
public class UpdateCVController extends HttpServlet {

    private static final String UPDATE_CV_PAGE = "UpdateCVPage";

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

        String url = UPDATE_CV_PAGE;

        try {
            // Get Parameter
            String userID = request.getParameter("userID");
            if (userID != null && !userID.isBlank()) {

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
                String image = "";
                String fileImageInput = request.getParameter("imageFile");

                //User's avatar sent as comparmentalised data
                Part filePart = request.getPart("imageFile");
                String header = filePart.getHeader("content-disposition");
                if (header.contains("filename")) {

                    //Retrive the uploading directory
                    ServletContext ctx = this.getServletContext();
                    File uploadDir = (File) ctx.getAttribute("DIR_FILE");
                    System.out.println("UPLOAD DIR:" + uploadDir);
                    //Retrieve the file sent in parts from the jsp page
                    //The new avatar's ID, set automatically
                    //Convert to .png (hard-coded in the jsp and html pages)
                    String fileName = userID + ".jpg";
                    //Write file to the predetermined server path
                    /*Set up a new File object to represent the uploading directory 
                (A File object can represent both files or pathnames)*/
                    File uploads = new File(uploadDir.getAbsolutePath());
                    //Create a new File Object with the given name to contain the incoming data
                    File f = new File(fileName);
                    //Combine the pathname and the new file's name into one unified File instance
                    File file = new File(uploads, f.getName());
                    //Retrieve inputStream from the obtained data parts
                    InputStream input = filePart.getInputStream();
                    //Copy all bytes from the input stream to the specified file (path)
                    try {
                        Files.copy(input, file.toPath(), REPLACE_EXISTING);
                    } finally {
                        //Close the input stream
                        input.close();
                    }
                    //Runing directly with NetBean
                    File backupDir = (File) ctx.getAttribute("BAK_FILE");
                    if (backupDir != null) {
                        File bakUploads = new File(backupDir.getAbsolutePath());
                        File backupFile = new File(bakUploads, f.getName());
                        InputStream backupInput = filePart.getInputStream();
                        try {
                            Files.copy(backupInput, backupFile.toPath(), REPLACE_EXISTING);
                        } finally {
                            backupInput.close();
                        }
                    }

                    image = fileName;
                }

                // Update user Profile
                UsersDAO usersDAO = new UsersDAO();
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                dateFormat.setLenient(false);
                dateFormat.parse(dob);
                Date dobDate = Date.valueOf(dob);

                boolean isUpdatedProfile = false;
                if (image.isBlank()) {
                    isUpdatedProfile = usersDAO.updateProfile(userID, fullname, address, dobDate, sex);
                } else {
                    isUpdatedProfile = usersDAO.updateProfile(userID, fullname, address, dobDate, sex, image);
                }
                if (isUpdatedProfile) {
                    MentorDetailsDAO mentorDAO = new MentorDetailsDAO();
                    MentorDetailsDTO dto = new MentorDetailsDTO(userID, facebook, github, profession, language, proDescription, serDescription, achDescription);
                    boolean isUpdatedDetails = mentorDAO.updateCV(dto);
                    if (isUpdatedDetails) {
                        int numSkills = Integer.parseInt(request.getParameter("numSkills"));
                        MentorSkillsDAO mentorSkillsDAO = new MentorSkillsDAO();

                        mentorSkillsDAO.deleteMentorSkills(userID);
                        boolean isAdded = false;

                        for (int i = 1; i <= numSkills; i++) {
                            String mentorSkillID = mentorSkillsDAO.generateMentorSkillID();
                            String skillID = request.getParameter("skill" + i);
                            int year = Integer.parseInt(request.getParameter("years" + i));
                            int rate = Integer.parseInt(request.getParameter("rate" + i));
                            MentorSkillsDTO mentorSkill = new MentorSkillsDTO(mentorSkillID, userID, skillID, year, rate);
                            isAdded = mentorSkillsDAO.addMentorSkills(mentorSkill);

                            if (!isAdded) {
                                break;
                            }
                        }
                        if (isAdded) {
                            request.setAttribute("UPDATE_CV_SUCCESS", "Update your CV successfully!!");
                        } else {
                            request.setAttribute("UPDATE_CV_ERROR", "There has been an error while we are "
                                    + "trying to add your skills! Please contact the web owners "
                                    + "for more details.");
                        }
                    } else {
                        request.setAttribute("UPDATE_CV_ERROR", "There has been an error while we are "
                                + "trying to update your CV! Please contact the web owners "
                                + "for more details.");
                    }
                } else {
                    request.setAttribute("UPDATE_CV_ERROR", "There has been an error while we are "
                            + "trying to update your profile! Please contact the web owners "
                            + "for more details.");
                }
            }
        } catch (ParseException ex) {
            log("Error at UpdateCVController: " + ex.getMessage());
            request.setAttribute("UPDATE_CV_ERROR", "Your Date of Birth is in wrong format!!");
        } catch (SQLException ex) {
            log("Error at UpdateCVController: " + ex.getMessage());
            request.setAttribute("UPDATE_CV_ERROR", "There has been an error while we are "
                    + "trying to update your profile! Please contact the web owners "
                    + "for more detreails.");

        } catch (NamingException ex) {
            log("Error at UpdateCVController: " + ex.getMessage());
            request.setAttribute("UPDATE_CV_ERROR", "There has been an error while we are "
                    + "trying to update your profile! Please contact the web owners "
                    + "for more details.");
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
