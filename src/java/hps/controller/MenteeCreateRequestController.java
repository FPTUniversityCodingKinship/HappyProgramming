
package hps.controller;

import hps.requests.RequestError;
import hps.requests.RequestsDAO;
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
@WebServlet(name = "MenteeCreateRequestController", urlPatterns = {"/MenteeCreateRequestController"})
public class MenteeCreateRequestController extends HttpServlet {
private final String REQUEST_SUCCESS = "MenteeCreateRequestPage";
private final String REQUEST_ERROR = "MenteeCreateRequestPage";
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
        
        String title = request.getParameter("title");
        String reqContent = request.getParameter("reqContent");
        String mentorID = request.getParameter("mentorID");
        if(mentorID.trim().length() == 0){
            mentorID = null;
        }
        String[] skillsName = request.getParameterValues("ckb");
        String status = "P";
        
        String deadlineDate = request.getParameter("deadlineDate");
        String deadlineHour = request.getParameter("deadlineHour");
        String deadline = deadlineDate + " " + deadlineHour ;
        
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        LocalDateTime now = LocalDateTime.now();
        String openedTime = dtf.format(now);
        boolean isError = false;
        RequestError errors = new RequestError();
        
        String url = REQUEST_ERROR;
        try{
            HttpSession session = request.getSession();
            UsersDTO user = (UsersDTO)session.getAttribute("CURRENT_USER");
            String menteeID = user.getUserID();
            RequestsDAO requestsDAO = new RequestsDAO();
            SkillsDAO skillsDAO = new SkillsDAO();
            
            String skillsID = skillsDAO.getSkillsID(skillsName);
            String requestID = requestsDAO.generateRequestID(skillsName);
            
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
                request.setAttribute("REQUEST_ERROR", errors);
            }else{
                boolean result = requestsDAO.menteeCreateRequest(requestID , menteeID, 
                    mentorID, skillsID, deadline, title, reqContent, status, openedTime);
                if(result){
                    url = REQUEST_SUCCESS;
                }
            }
        } catch (NamingException ex) {
            log("MenteeCreateRequestController NamingException: " + ex.getMessage());
        } catch (SQLException ex) {
            log("MenteeCreateRequestController SQLException: " + ex.getMessage());
            if(ex.getMessage().contains("conflicted")){
                errors.setMentorIDConflictError("Not a valid mentor");
                request.setAttribute("REQUEST_ERROR", errors);
            }
        } catch (Exception ex){
            log("MenteeCreateRequestController Exception: " + ex.getMessage());
            if(ex.getMessage().contains("For input string")){
                errors.setDeadlineDateError("Date: year-month-day, Time: hour:minute");
                request.setAttribute("REQUEST_ERROR", errors);
            }
            if(ex.getMessage().contains("Exceed 3")){
                errors.setDeadlineDateError("Date must follow: year-month-day");
                request.setAttribute("REQUEST_ERROR", errors);
            }
            if(ex.getMessage().contains("Not valid date")){
                errors.setDeadlineDateError("Not a valid date");
                request.setAttribute("REQUEST_ERROR", errors);
            }
            if(ex.getMessage().contains("Overdue deadline year")){
                errors.setDeadlineDateError("Overdue deadline year");
                request.setAttribute("REQUEST_ERROR", errors);
            }
            if(ex.getMessage().contains("Overdue deadline month")){
                errors.setDeadlineDateError("Overdue deadline month");
                request.setAttribute("REQUEST_ERROR", errors);
            }
            if(ex.getMessage().contains("Overdue deadline day")){
                errors.setDeadlineDateError("Overdue deadline day");
                request.setAttribute("REQUEST_ERROR", errors);
            }
            if(ex.getMessage().contains("Exceed 2")){
                errors.setDeadlineTimeError("Time must follow: hour:minute");
                request.setAttribute("REQUEST_ERROR", errors);
            }
            if(ex.getMessage().contains("Not valid hour")){
                errors.setDeadlineTimeError("Not valid hour");
                request.setAttribute("REQUEST_ERROR", errors);
            }
            if(ex.getMessage().contains("Not valid minute")){
                errors.setDeadlineTimeError("Not valid minute");
                request.setAttribute("REQUEST_ERROR", errors);
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
