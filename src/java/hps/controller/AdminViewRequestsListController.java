/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.controller;

import hps.requests.RequestsDAO;
import hps.requests.RequestsDTO;
import hps.users.UsersDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
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
 * @author Tran Phong <phongntse150974@fpt.edu.vn>
 */
@WebServlet(name = "AdminViewRequestsListController", urlPatterns = {"/AdminViewRequestsListController"})
public class AdminViewRequestsListController extends HttpServlet {

    private static final String VIEW_REQUEST_PAGE = "AdminViewRequestsListPage";
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

        String url = VIEW_REQUEST_PAGE;
        int limit = 10;

        try {
            HttpSession session = request.getSession(false);
            if (session == null) {
                url = LOGIN_PAGE;
            } else {
                UsersDTO curMentor = (UsersDTO) session.getAttribute("CURRENT_USER"); // TODO code
                if (curMentor == null || !curMentor.getUserID().startsWith("AD")) {
                    url = LOGIN_PAGE;
                } else {
                    String searchValue = request.getParameter("searchValue");
                    String[] status = request.getParameterValues("status");
                    String startDateStr = request.getParameter("startDate");
                    String endDateStr = request.getParameter("endDate");

                    String strPageId = request.getParameter("page");
                    if (strPageId == null) {
                        strPageId = "1";
                    }
                    int pageId = Integer.parseInt(strPageId);

//            if (pageId > 1) {
//                pageId = pageId - 1;
//                pageId = pageId*limit + 1;
//            }
                    if (((startDateStr == null && endDateStr == null) || (startDateStr.trim().isEmpty() && endDateStr.trim().isEmpty()))
                            && searchValue.trim().isEmpty() && (status == null || status.length == 0)) {
                        request.setAttribute("VIEW_REQUESTS_LIST_ERROR", "Please enter at least 1 criteria to filter requests!!!");
                        url = VIEW_REQUEST_PAGE;
                    } else {
                        Date startDate = null;
                        Date endDate = null;
                        if (startDate != null && !startDateStr.trim().isEmpty()) {
                            startDate = java.sql.Date.valueOf(startDateStr);
                        }
                        if (endDate != null && !endDateStr.trim().isEmpty()) {
                            endDate = java.sql.Date.valueOf(endDateStr);
                        }

                        RequestsDAO requestsDAO = new RequestsDAO();
                        List<RequestsDTO> requestsList = requestsDAO.getRequestsList(searchValue, status, startDate, endDate, pageId, limit);

                        int totalRequest = requestsDAO.getNumberOfRequests(searchValue, status, startDate, endDate);
                        int numOfPages = (int) Math.ceil((double) totalRequest / limit);
                        request.setAttribute("NUM_PAGES", numOfPages);

                        request.setAttribute("REQUESTS_LIST", requestsList);
                        url = VIEW_REQUEST_PAGE;
                    }
                }
            }

        } catch (NumberFormatException ex) {
            log("Error at AdminViewRequestsListController: " + ex.getMessage());
            request.setAttribute("VIEW_REQUESTS_LIST_ERROR", "Page number is not valid!!! Please check and try again...");
            url = VIEW_REQUEST_PAGE;
        } catch (SQLException ex) {
            log("Error at AdminViewRequestsListController: " + ex.getMessage());
            request.setAttribute("VIEW_REQUESTS_LIST_ERROR", "An error has occured when we try to connect to the database! Please contact the web owner for more details!!");
            url = VIEW_REQUEST_PAGE;
        } catch (NamingException ex) {
            log("Error at AdminViewRequestsListController: " + ex.getMessage());
            request.setAttribute("VIEW_REQUESTS_LIST_ERROR", "An error has occured with the web server! Please contact the web owner for more details!!");
            url = VIEW_REQUEST_PAGE;
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
