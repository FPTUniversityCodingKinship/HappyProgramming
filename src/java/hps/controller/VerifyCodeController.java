
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
        
        try {
            HttpSession session = request.getSession();
            ServletContext context = getServletContext();
            List<VerifyDTO> verifyList = (List<VerifyDTO>) context.getAttribute("VERIFY_LIST");
            UsersDTO user = (UsersDTO) session.getAttribute("CURRENT_USER");
            
            if (verifyList != null && user != null) {
                String email = user.getEmail();
                for (VerifyDTO entry : verifyList) {
                    if (email != null && entry.getEmail().equals(email)) {
                        if (code.equals(entry.getCode())) {
                            // Call DAO
                            UsersDAO dao = new UsersDAO();
                            if (user.isStatus())
                                // this pass condition  for signing in but inactive
                                user = dao.verifyUser(email);
                            else
                                // this pass condition  for signing up
                                user = dao.verifyUserSignUp(email);
                            if (user != null)
                                if (user.isEmailStatus()) {
                                    //set the param for url
                                    url += "?txtGmail=" + email;
                                    //set success state
                                    request.setAttribute("SUCCESS_VERIFY", user);
                                    // kick the entry out of the list
                                    verifyList.remove(entry);
                                    // update list
                                    context.setAttribute("VERIFY_LIST", verifyList);
                                    msg = url;
                                    break;
                                }
                        }
                        else {
                            String wrongCode = 
                                        "You have entered a wrong verification code!"
                                        + "Please recheck and enter again:";
                            request.setAttribute("WRONG_VERIFY", wrongCode);
                            break;
                        }
                    }
                    else msg = "No email found in verify list on system.";
                }
            }
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
        }
        catch (NamingException | SQLException ex) {
            Logger.getLogger(VerifyCodeController.class.getName())
                        .log(Level.SEVERE, null, ex);
        }
        finally {
            System.out.println("[VerifyCode] " + msg);
            if (out != null)
                out.close();
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
        processRequest(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
        processRequest(request, response);
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
    
}
