/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.controller;

import hps.users.UsersDAO;
import hps.users.UsersDTO;
import hps.verify.VerifyDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
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
@WebServlet(name = "VerifyCodeController", urlPatterns = {"/VerifyCodeController"})
public class VerifyCodeController extends HttpServlet {
    private final String LOGIN_CONTROLLER = "Login";
    private final String DEFAULT_PAGE = "MailVerificationPage";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String code = request.getParameter("authCode");
        String url = DEFAULT_PAGE;
        
        String msg = "";
        boolean flag = false;
        
        try {
            HttpSession session = request.getSession();
            ServletContext context = getServletContext();
            List<VerifyDTO> verifyList = (List<VerifyDTO>) context.getAttribute("VERIFY_LIST");
            UsersDTO user = (UsersDTO) session.getAttribute("CURRENT_USER");
            
            if (verifyList != null && user != null) {
                for (VerifyDTO entry : verifyList) {
                    if (entry.getEmail().equals(user.getEmail())) {
                        if (code.equals(entry.getCode())) {
                            // Call DAO
                            UsersDAO dao = new UsersDAO();
                            user = dao.verifyUser(user.getEmail());
                            if (user != null)
                                if (user.isEmailStatus()) {
                                    //set the url
                                    url = LOGIN_CONTROLLER + "?txtGmail=" 
                                                + user.getEmail();
                                    
                                    // kick the entry out of the list
                                    verifyList.remove(entry);
                                    // update list
                                    context.setAttribute("VERIFY_LIST", verifyList);
                                    break;
                                }
                        }
                        else {
                            flag = true;
                            String wrongCode = "You have entered a wrong verification code!";
                            request.setAttribute("WRONG_VERIFY", wrongCode);
                            break;
                        }
                    }
                }
            }
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
        }
        catch (NamingException ex) {
            Logger.getLogger(VerifyCodeController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(VerifyCodeController.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally {
            System.out.println("[VerifyCode] " + msg);
            if (out != null)
                out.close();
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
}
