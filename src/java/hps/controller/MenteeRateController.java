/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.controller;

import hps.comments.CommentsDAO;
import hps.comments.CommentsError;
import hps.requests.RequestsDAO;
import hps.users.UsersDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Map;
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
@WebServlet(name = "MenteeRateController", urlPatterns = {"/MenteeRateController"})
public class MenteeRateController extends HttpServlet {
private final String ERROR_PAGE = "MenteeRatePage";
private final String SUCCESS_PAGE = "MenteeHomePage";
private final String LOGIN_PAGE = "LoginPage";
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
        
        String url = ERROR_PAGE;
        try{
            HttpSession session = request.getSession();
            UsersDTO user = (UsersDTO)session.getAttribute("CURRENT_USER");
            if(user == null){
                url = LOGIN_PAGE;
            }else{
                String menteeID = user.getUserID();
                RequestsDAO reqDAO = new RequestsDAO();
                Map<String,String> reqInfo = (Map)reqDAO.loadRequestForRating(menteeID);
                if(!reqInfo.isEmpty()){
                    session.setAttribute("REQ_INFO_FOR_RATING", reqInfo);
                    String requestID = request.getParameter("requestID");
                    String mentorID = request.getParameter("mentorID");
                    if(!requestID.isEmpty()){
                        ArrayList<String> ratingInfo = new ArrayList<>();
                        ratingInfo.add(requestID); 
                        ratingInfo.add(menteeID); 
                        ratingInfo.add(mentorID);
                        session.setAttribute("RATING_INFO", ratingInfo);
                        int rate = Integer.parseInt(request.getParameter("rate").replace(" ", ""));
                        String comments = request.getParameter("comments");
                        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
                        LocalDateTime now = LocalDateTime.now();
                        String timestamp = dtf.format(now);
                        boolean isError = false;
                        CommentsError errors = new CommentsError();

                        if(rate < 0 || rate > 5){
                            isError = true;
                            errors.setRateOutOfBoundError("Please rate from 1-5 stars");
                        }
                        if(comments.length() < 1){
                            isError = true;
                            errors.setCommentLengthError("Please leave a comment.");
                        }
                        if(isError){
                            request.setAttribute("RATE_ERROR", errors);
                        }else{
                            CommentsDAO cmDAO = new CommentsDAO();
                            boolean result = cmDAO.addComment(requestID.substring(0,6), 
                                    menteeID, mentorID, rate, comments, timestamp);
                            if(result){
                                url = SUCCESS_PAGE;
                                session.removeAttribute("RATING_INFO");
                            }
                        }
                    }
                }
            }  
        }catch (NamingException ex) {
            log("MenteeRateController NamingException: " + ex.getMessage());
        } catch (SQLException ex) {
            log("MenteeRateController SQLException: " + ex.getMessage());
            if(ex.getMessage().contains("Violation")){
                CommentsError errors = new CommentsError();
                errors.setRatedError("Sorry, this request has been rated."
                        + " Choose another one or back to home page.");
                request.setAttribute("RATE_ERROR", errors);
            }
        } catch(Exception ex){
            if(ex.getMessage().contains("For input")){
                CommentsError errors = new CommentsError();
                errors.setRateOutOfBoundError("Please rate from 1-5 stars");
                request.setAttribute("RATE_ERROR", errors);
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
