/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.controller;

import hps.requests.RequestError;
import hps.requests.RequestsDAO;
import hps.requests.RequestsDTO;
import hps.skills.SkillsDAO;
import hps.users.UsersDTO;
import hps.validation.Validation;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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
@WebServlet(name = "MenteeUpdateRequestSeparatelyController", urlPatterns = {"/MenteeUpdateRequestSeparatelyController"})
public class MenteeUpdateRequestSeparatelyController extends HttpServlet {
private final String UPDATE_REQUEST_SUCCESS_PAGE = "MenteeHomePage";
private final String UPDATE_REQUEST_ERROR_PAGE = "MenteeUpdateRequestPage";
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
        String url = UPDATE_REQUEST_ERROR_PAGE;
        
        HttpSession session = request.getSession();
        RequestsDTO requestInfo = (RequestsDTO)session.getAttribute("REQUEST_INFO");
        String requestID = requestInfo.getRequestID();
        
        String title = request.getParameter("title");
        String deadlineDate = request.getParameter("deadlineDate");
        String deadlineHour = request.getParameter("deadlineHour");
        String deadline = deadlineDate + " " + deadlineHour ;
        String reqContent = request.getParameter("reqContent");
        String mentorID = request.getParameter("mentorID");
        if(mentorID.trim().length() == 0){
            mentorID = null;
        }
        String[] skillsName = request.getParameterValues("ckb");
        boolean isError = false;
        RequestError errors = new RequestError();

        try{
            RequestsDAO requestsDAO = new RequestsDAO();
            SkillsDAO skillsDAO = new SkillsDAO();
            
            String skillsID = skillsDAO.getSkillsID(skillsName);
            if(reqContent.trim().length()<2 || reqContent.trim().length()>500){
                isError = true;
                errors.setContentLengthError("Content must be 2-500 characters");
            }
            if(title.trim().length()<1 || title.trim().length()>100){
                isError = true;
                errors.setTitleLengthError("Title must be 1-100 characters");
            }
            Validation.validDate(deadlineDate);
            Validation.validTime(deadlineHour);
            
            if(isError){
                request.setAttribute("UPDATE_REQUEST_ERROR", errors);
            }else{
                boolean result = requestsDAO.menteeUpdateRequestSeparately(requestID, 
                        title, deadline, reqContent, skillsID, mentorID);
                if(result){
                    url = UPDATE_REQUEST_SUCCESS_PAGE;
                    session.removeAttribute("REQUEST_INFO");
                }
            }
            
        } catch (NamingException ex) {
            log("MenteeRequestController NamingException: " + ex.getMessage());
        } catch (SQLException ex) {
            log("MenteeRequestController SQLException: " + ex.getMessage());
            if(ex.getMessage().contains("conflicted")){
                errors.setMentorIDConflictError("Not a valid mentor");
                request.setAttribute("UPDATE_REQUEST_ERROR", errors);
            }
        } catch (Exception ex){
            log("MenteeRequestController Exception: " + ex.getMessage());
            if(ex.getMessage().contains("For input string")){
                errors.setDeadlineDateError("Date: year-month-day, Time: hour:minute");
                request.setAttribute("UPDATE_REQUEST_ERROR", errors);
            }
            if(ex.getMessage().contains("Exceed 3")){
                errors.setDeadlineDateError("Date must follow: year-month-day");
                request.setAttribute("UPDATE_REQUEST_ERROR", errors);
            }
            if(ex.getMessage().contains("Not valid date")){
                errors.setDeadlineDateError("Not a valid date");
                request.setAttribute("UPDATE_REQUEST_ERROR", errors);
            }
            if(ex.getMessage().contains("Overdue deadline year")){
                errors.setDeadlineDateError("Overdue deadline year");
                request.setAttribute("UPDATE_REQUEST_ERROR", errors);
            }
            if(ex.getMessage().contains("Overdue deadline month")){
                errors.setDeadlineDateError("Overdue deadline month");
                request.setAttribute("UPDATE_REQUEST_ERROR", errors);
            }
            if(ex.getMessage().contains("Overdue deadline day")){
                errors.setDeadlineDateError("Overdue deadline day");
                request.setAttribute("UPDATE_REQUEST_ERROR", errors);
            }
            if(ex.getMessage().contains("Exceed 2")){
                errors.setDeadlineTimeError("Time must follow: hour:minute");
                request.setAttribute("UPDATE_REQUEST_ERROR", errors);
            }
            if(ex.getMessage().contains("Not valid hour")){
                errors.setDeadlineTimeError("Not valid hour");
                request.setAttribute("UPDATE_REQUEST_ERROR", errors);
            }
            if(ex.getMessage().contains("Not valid minute")){
                errors.setDeadlineTimeError("Not valid minute");
                request.setAttribute("UPDATE_REQUEST_ERROR", errors);
            }
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
