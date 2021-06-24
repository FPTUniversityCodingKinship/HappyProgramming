
package hps.controller;

import hps.users.UserUpdateError;
import hps.users.UsersDAO;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import static java.nio.file.StandardCopyOption.REPLACE_EXISTING;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;

/**
 *
 * @author DELL
 */
@WebServlet(name = "UpdateProfileServlet", urlPatterns = {"/UpdateProfileServlet"})
public class UpdateProfileServlet extends HttpServlet {

    private static final String PROFILE_PAGE = "UpdateProfilePage";

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
        String url = PROFILE_PAGE;
        try {
            String userID = request.getParameter("txtUserID");
            String username = request.getParameter("txtUsername");
            String password = request.getParameter("txtPassword");
            String fullname = request.getParameter("txtFullname");
            String phone = request.getParameter("txtPhone");
            String address = request.getParameter("txtAddress");
            String dob = request.getParameter("txtDob");
            String sex = request.getParameter("txtSex");
            //User's avatar sent as comparmentalised data
            Part filePart = request.getPart("imageFile");
            String fileName = request.getParameter("txtUserImg");
            UsersDAO dao = new UsersDAO();
            boolean foundErr = false;
            boolean result = false;
            UserUpdateError err = new UserUpdateError();

            request.setAttribute("ERR", err);
            if (username.trim().length() < 6 || username.trim().length() > 30) {
                foundErr = true;
                err.setUsernameLengthErr("Username must be between 6 and 30 characters only!");
            }
            if (password.trim().length() < 6 || password.trim().length() > 30) {
                foundErr = true;
                err.setPasswordLengthErr("Password must be between 6 and 30 characters only!");
            }
            if (fullname.trim().length() < 2 || fullname.trim().length() > 50) {
                foundErr = true;
                err.setFullnameLengthErr("Please provide input ranging from 2 to 50 characters only\n "
                        + "If that was your real name, please contact an Administrator for further help!");
            }
            if (dao.checkUsername(username, userID) == true) {
                foundErr = true;
                err.setUsernameIsExisted("This username has been taken! "
                        + "Please try another one!");
            }

            SimpleDateFormat sDobFormat = new SimpleDateFormat("yyyy-MM-dd");
            //Prevent values out of range
            sDobFormat.setLenient(false);
            try {
                sDobFormat.parse(dob);
            } catch (ParseException ex) {
                log(ex.getMessage());
                foundErr = true;
                err.setDateOfBirthInvalidError("Invalid date! "
                        + "Please submit a real date!");
            }

            //Update if the parameters are not null
            if (!foundErr) {
                //Convert to .jpg (hard-coded in the jsp and html pages)
                fileName = userID + ".jpg";
                Date dob_date = Date.valueOf(dob);
                if (filePart.getSize() != 0) {
                    //Retrive the uploading directory
                    ServletContext ctx = this.getServletContext();
                    File uploadDir = (File) ctx.getAttribute("DIR_FILE");
                    //Retrieve the file sent in parts from the jsp page
                    //The new avatar's ID, set automatically

                    //Write file to the predetermined server path
                    /*Set up a new File object to represent the uploading directory 
                    (A File object can represent both files or pathnames)*/
                    File uploads = new File(uploadDir.getAbsolutePath());
                    //Create a new File Object with the given name to contain the incoming data
                    File f = new File(fileName);
                    //Combine the pathname and the new file's name into one unified File instance
                    File file = new File(uploads, f.getName());
                    //Retrieve inputStream from the obtained data parts
                    InputStream input = filePart.getInputStream();
                    //Copy all bytes from the input stream to the specified file (path)
                    try {
                        Files.copy(input, file.toPath(), REPLACE_EXISTING);
                    } finally {
                        //Close the input stream
                        input.close();
                    }
                    //Runing directly with NetBean
                    File backupDir = (File) ctx.getAttribute("BAK_FILE");
                    if (backupDir != null) {
                        File bakUploads = new File(backupDir.getAbsolutePath());
                        File backupFile = new File(bakUploads, f.getName());
                        InputStream backupInput = filePart.getInputStream();
                        try {
                            Files.copy(backupInput, backupFile.toPath(), REPLACE_EXISTING);
                        } finally {
                            backupInput.close();
                        }
                    }
                }
                result = dao.updateProfile(userID, username, password,
                        fullname, phone, address, dob_date, sex, userID + ".jpg");
                if (result) {
                    request.setAttribute("UPDATE_STATUS", "Profile Updated");
                }
            }

            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
        } catch (SQLException ex) {
            log(ex.getMessage());
            request.setAttribute("UPDATE_STATUS", "Error, Please try again");
        } catch (NamingException ex) {
            log(ex.getMessage());
            request.setAttribute("UPDATE_STATUS", "Error, Please try again");
        } finally {
            if (out != null) {
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
