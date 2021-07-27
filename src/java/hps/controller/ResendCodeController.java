/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.controller;

import hps.users.UsersDAO;
import hps.users.UsersDTO;
import hps.utilities.MailHandler;
import hps.verify.VerifyDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ResendCodeController", urlPatterns = {"/ResendCodeController"})
public class ResendCodeController extends HttpServlet {
    private static final String INACTIVE_PAGE = "MailVerificationPage";
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
        
        MailHandler sm;
        VerifyDTO verifier = null;
        UsersDTO user;
        String url = INACTIVE_PAGE;
        
        try {
            HttpSession session = request.getSession();
            user = (UsersDTO) session.getAttribute("CURRENT_USER");
            
            ServletContext context = getServletContext();
            // check if there is already a code in the context
            List<VerifyDTO> verifyList = (List<VerifyDTO>)
                                context.getAttribute("VERIFY_LIST");
            if (verifyList != null) {
                for (VerifyDTO entry : verifyList) {
                    //if email existed, use it, don't send
                    if (entry.getEmail().equals(user.getEmail())) {
                        verifier = entry;
                        break;
                    }
                }
                if (verifier != null)
                    verifyList.remove(verifier);
                else
                    System.out.println("Wrong code");
            }
            
            //create and send mail
            sm = new MailHandler();
            //get the 6-digit code
            String code = sm.getVerifyCode();
            //get the date time at the sendding
            String time = sm.getCurrentDateTime();
            verifier = new VerifyDTO(user.getEmail(), code, time);
            // add to list
            verifyList.add(verifier);

            boolean isSend = sm.sendEmail(verifier);
            System.out.println("[UserVerify] isSend:" + isSend);

            //re-up list onto context Scope's attribute
            context.setAttribute("VERIFY_LIST", verifyList);
            
            url = INACTIVE_PAGE;
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
                rd.forward(request, response);
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
