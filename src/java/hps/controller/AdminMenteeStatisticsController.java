/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.controller;

import hps.admin.MenteeStatisticsDTO;
import hps.requests.RequestsDAO;
import hps.users.UsersDAO;
import hps.users.UsersDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
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
 * @author Tran Phong <phongntse150974@fpt.edu.vn>
 */
@WebServlet(name = "AdminMenteeStatisticsController", urlPatterns = {"/AdminMenteeStatisticsController"})
public class AdminMenteeStatisticsController extends HttpServlet {

    private static final String VIEW_PAGE = "AdminMenteeStatisticsPage";
    private static final String LOGIN_PAGE = "/";

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

        String url = VIEW_PAGE;

        List<MenteeStatisticsDTO> statisticsData = new ArrayList<>();

        try {
            HttpSession session = request.getSession(false);
            if (session == null) {
                url = LOGIN_PAGE;
            } else {
                UsersDTO curMentor = (UsersDTO) session.getAttribute("CURRENT_USER"); // TODO code
                if (curMentor == null || !curMentor.getUserID().startsWith("AD")) {
                    url = LOGIN_PAGE;
                } else {
                    //  Name of Mentee, accountname, Nummber of Mentor, Total hours of all request, Total of skills of all requests.
                    // Mentee
                    UsersDAO usersDAO = new UsersDAO();
                    List<UsersDTO> menteeList = usersDAO.getMenteeList();

                    RequestsDAO requestsDAO = new RequestsDAO();

                    for (UsersDTO mentee : menteeList) {
                        String menteeName = mentee.getFullname();
                        String username = mentee.getUsername();
                        String numMentor = requestsDAO.getTotalMentor(mentee.getUserID());
                        String requestTotalHour = requestsDAO.getRequestsTotalHours(mentee.getUserID());
                        int totalSkills = requestsDAO.getTotalSkills(mentee.getUserID());
                        MenteeStatisticsDTO statisticsDTO = new MenteeStatisticsDTO(menteeName, username, numMentor, requestTotalHour, totalSkills);
                        statisticsData.add(statisticsDTO);
                    }

                    request.setAttribute("MENTEE_STATISTICS_DATA", statisticsData);
                    url = VIEW_PAGE;
                }
            }
        } catch (SQLException ex) {
            log("Error at AdminMenteeStatisticsController: " + ex.getMessage());
            request.setAttribute("MENTEE_STATISTICS_ERROR", "An error has occured! Please contact the web owner for more details!!");
            url = VIEW_PAGE;
        } catch (NamingException ex) {
            log("Error at AdminMenteeStatisticsController: " + ex.getMessage());
            request.setAttribute("MENTEE_STATISTICS_ERROR", "An error has occured! Please contact the web owner for more details!!");
            url = VIEW_PAGE;
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
