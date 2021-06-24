
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
@WebServlet(name = "VerifyCode", urlPatterns = {"/VerifyCode"})
public class MailVerifyController extends HttpServlet {
    private final String WELCOME_PAGE = "Login";
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
                for (VerifyDTO verifier : verifyList) {
                    if (verifier.getEmail().equals(user.getEmail())) {
                        if (code.equals(verifier.getCode())) {
                            // Call DAO
                            UsersDAO dao = new UsersDAO();
                            user = dao.verifyUser(user.getUsername());
                            // Check email status
                            if (user.isEmailStatus()) {
                                //set the url
                                url = WELCOME_PAGE;
                                // kick the entry out of the list
                                verifyList.remove(verifier);
                                // update list
                                context.setAttribute("VERIFY_LIST", verifyList);
                                session.setAttribute("CURRENT_USER", user);
                                break;
                            }
                            else
                                flag = true;
                        }
                        else
                            flag = true;
                    }
                    else
                        flag = true;
                }
            }
            if (flag) {
                String wrongCode = "You have entered a wrong verify code!"
                            + " Please enter again.";
                request.setAttribute("WRONG_VERIFY", wrongCode);
                RequestDispatcher rd = request.getRequestDispatcher(url);
                rd.forward(request, response);
            }
            else
                response.sendRedirect(url);
        }
        catch (NamingException | SQLException ex) {
            Logger.getLogger(MailVerifyController
                        .class.getName())
                        .log(Level.SEVERE, null, ex);
        }
        finally {
            System.out.println("[MailVerifyController] " + msg);
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
