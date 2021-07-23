
package hps.controller;

import hps.requests.RequestError;
import hps.requests.RequestsDAO;
import hps.skills.SkillsDAO;
import hps.skills.SkillsError;
import hps.validation.Validation;
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

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "MenteeUpdateRequestController", urlPatterns = {"/MenteeUpdateRequestController"})
public class MenteeUpdateRequestController extends HttpServlet {
private final String MENTEE_UPDATE_SUCCESS = "MenteeListRequest";
private final String MENTEE_UPDATE_ERROR = "MenteeListRequest";
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
        
        String requestID = request.getParameter("requestID");
        String title = request.getParameter("title");
        String reqContent = request.getParameter("reqContent");
        String[] skillsName = request.getParameter("skillsName").replace(" ", "").split(",");
        
        String deadlineDate = request.getParameter("deadlineDate");
        String deadlineHour = request.getParameter("deadlineHour");
        String deadline = deadlineDate + " " + deadlineHour ;
        
        boolean isError = false;
        RequestError errors = new RequestError();
        SkillsError skillsError = new SkillsError();
        
        String url = MENTEE_UPDATE_ERROR;
        try{
            RequestsDAO requestsDAO = new RequestsDAO();
            //Get the skillsID from skillsName
            SkillsDAO skillsDAO = new SkillsDAO();
            
            if(skillsName.length > 3){
                isError = true;
                skillsError.setSkillQuantityError("Skills exceed 3");
            }
            if(skillsName.length == 0){
                isError = true;
                skillsError.setSkillQuantityError("Please enter at least 1 skill.");
            }
            String skillsID = skillsDAO.getSkillsID(skillsName);
            if(skillsID.isEmpty()){
                isError = true;
                skillsError.setSkillNameNotFound("Skill(s) not found (Tips: use comma to seperate skills)");
            }
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
                url = MENTEE_UPDATE_ERROR;
                request.setAttribute("UPDATE_REQUEST_ERROR", errors);
                request.setAttribute("UPDATE_SKILL_ERROR", skillsError);
            }else{
                boolean result = requestsDAO.menteeUpdateRequest(requestID, title, deadline, reqContent, skillsID);
                if(result){
                    url = MENTEE_UPDATE_SUCCESS;
                }
            }
        } catch (NamingException ex) {
            log("MenteeUpdateRequestController NamingException: " + ex.getMessage());
        } catch (SQLException ex) {
            log("MenteeUpdateRequestController SQLException: " + ex.getMessage());         
        } catch (Exception ex){
            log("MenteeUpdateRequestController Exception: " + ex.getMessage());
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
