
package hps.users;

import hps.utilities.DBHelper;
import java.io.Serializable;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;

/**
 *
 * @author DELL
 */
public class UsersDAO implements Serializable {

    public UsersDTO newMentee(String username, String email, String password,
            String fullname, String phone, String address, Date dob, String sex,
            String image, boolean status, boolean emailStatus)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            //1. Make connection.
            con = DBHelper.makeConnection();
            if (con != null) {
                //2.Create SQL String.
                String sql = "Insert Into "
                        + "users(username, email, password, fullname, phone, "
                        + "address, dob, sex, image, status, emailStatus) "
                        + "Values( ?, ?, ?, ?)";

                //3. Create Statement and assign Parameter(s) if any.
                stm = con.prepareStatement(sql);
                stm.setString(1, username);
                stm.setString(2, email);
                stm.setString(3, password);
                stm.setString(4, fullname);
                stm.setString(5, phone);
                stm.setString(6, address);
                stm.setDate(7, dob);
                stm.setString(8, sex);
                stm.setString(9, image);
                stm.setBoolean(10, status);
                stm.setBoolean(11, emailStatus);
                //4. Execute Query.
                ResultSet rs = stm.executeQuery();

                //5. Process resultSet.
                if (rs != null) {
                    UsersDTO newUser = new UsersDTO();
                    newUser.setUsername(username);
                    newUser.setEmail(email);
                    newUser.setPassword(password);
                    newUser.setStatus(status);
                    newUser.setEmailStatus(emailStatus);
                    return newUser;
                }
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return null;
    }

    public UsersDTO checkLogin(String username, String password)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        UsersDTO user = null;
        try {
            //1.Establish Connection
            con = DBHelper.makeConnection();
            if (con != null) {
                //2. Prepare sql string
                String sql = "SELECT * "
                        + "FROM users "
                        + "WHERE username = ? AND password = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, username);
                stm.setString(2, password);
                //3. Store in ResultSet
                rs = stm.executeQuery();
                if (rs.next()) {
                    user = new UsersDTO(
                            rs.getString("userID"), rs.getString("username"),
                            rs.getString("email"), rs.getString("password"),
                            rs.getString("fullname"), rs.getString("phone"),
                            rs.getString("address"), rs.getDate("dob"),
                            rs.getString("sex"), rs.getString("image"),
                            rs.getBoolean("status"), rs.getBoolean("emailStatus"));
                    return user;
                }
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return null;
    }
    
    public UsersDTO checkLoginByMail(String mail) 
                throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        UsersDTO dto;
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT * "
                            + "FROM users "
                            + "WHERE email = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, mail);
                
                rs = stm.executeQuery();
                
                if (rs.next()) {
                    dto = new UsersDTO(
                                rs.getString("userID"), rs.getString("username"),
                                rs.getString("email"), rs.getString("password"),
                                rs.getString("fullname"), rs.getString("phone"),
                                rs.getString("address"), rs.getDate("dob"),
                                rs.getString("sex"), rs.getString("image"),
                                rs.getBoolean("status"), rs.getBoolean("emailStatus")
                    );
                    return dto;
                }
            }
        }
        finally {
            if (rs != null)
                rs.close();
            if (stm != null)
                stm.close();
            if (con != null)
                con.close();
        }
        return null;
    }

    public boolean checkUsername(String username, String userID)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs;
        try {
            //1.Establish Connection
            con = DBHelper.makeConnection();
            if (con != null) {
                //2. Prepare sql string
                String sql = "SELECT * "
                        + "FROM users "
                        + "WHERE username = ? AND userID != ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, username);
                stm.setString(2, userID);
                //3. Store in ResultSet
                rs = stm.executeQuery();
                if (rs.next()) {
                    return true;
                }
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }
    
    public UsersDTO verifyUser(String email) 
                throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "UPDATE users "
                            + "SET emailStatus = 1 "
                            + "WHERE email = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, email);
                
                int row = stm.executeUpdate();
                
                if (row > 0)
                    return getUser(email);
            }
        }
        finally {
            if (stm != null)
                stm.close();
            if (con != null)
                con.close();
        }
        return null;
    }
    public UsersDTO verifyUserSignUp(String email) 
                throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "UPDATE users "
                            + "SET emailStatus = 1, status = 1 "
                            + "WHERE email = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, email);
                
                int row = stm.executeUpdate();
                
                if (row > 0)
                    return getUser(email);
            }
        }
        finally {
            if (stm != null)
                stm.close();
            if (con != null)
                con.close();
        }
        return null;
    }
    
    public UsersDTO getUser(String email) 
                throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        UsersDTO dto;
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT * "
                            + "FROM users "
                            + "WHERE email = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, email);
                
                rs = stm.executeQuery();
                
                if (rs.next()) {
                    dto = new UsersDTO(
                            rs.getString("userID"),
                            rs.getString("username"),
                            rs.getString("email"),
                            rs.getString("password"),
                            rs.getNString("fullname"),
                            rs.getString("phone"),
                            rs.getString("address"),
                            rs.getDate("dob"),
                            rs.getString("sex"),
                            rs.getString("image"),
                            rs.getBoolean("status"),
                            rs.getBoolean("emailStatus"));
                    return dto;
                }
            }
        }
        finally {
            if (rs != null)
                rs.close();
            if (stm != null)
                stm.close();
            if (con != null)
                con.close();
        }
        return null;
    }

    public UsersDTO getProfile(String userID) throws NamingException, SQLException {

        //1. Establish DB Connection
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                //2. Prepare sql string
                String sql = "SELECT * FROM users WHERE userID = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, userID);
                //3. Store in ResultSet
                rs = stm.executeQuery();
                if (rs.next()) {
                    UsersDTO dto = new UsersDTO(
                            rs.getString("userID"),
                            rs.getString("username"),
                            rs.getString("email"),
                            rs.getString("password"),
                            rs.getNString("fullname"),
                            rs.getString("phone"),
                            rs.getString("address"),
                            rs.getDate("dob"),
                            rs.getString("sex"),
                            rs.getString("image"),
                            rs.getBoolean("status")
                    );
                    return dto;
                }
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return null;
    }

    public boolean updateProfile(String userID, String username, String password,
            String fullname, String phone, String address, Date dob, String sex, String image)
            throws SQLException, NamingException {

        //1. Establish DB connection
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                //2. Prepare SQL string
                String sql = "UPDATE users "
                        + "SET username = ?, password = ?, fullname = ?, "
                        + "phone = ?, address = ?, dob = ? , sex = ?, image = ? "
                        + "WHERE userID = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, username);
                stm.setString(2, password);
                stm.setNString(3, fullname);
                stm.setString(4, phone);
                stm.setString(5, address);
                stm.setDate(6, dob);
                stm.setString(7, sex);
                stm.setString(8, image);
                stm.setString(9, userID);
                int result = stm.executeUpdate();
                if (result > 0) {
                    return true;
                }
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }

    public UsersDTO getUserData(String userID)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            //1.Establish Connection
            con = DBHelper.makeConnection();
            if (con != null) {
                //2. Prepare sql string
                String sql = "SELECT * "
                        + "FROM users "
                        + "WHERE userID = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, userID);
                //3. Store in ResultSet
                rs = stm.executeQuery();
                if (rs.next()) {
                    UsersDTO dto = new UsersDTO();
                    dto = new UsersDTO(
                            rs.getString("userID"), rs.getString("username"),
                            rs.getString("email"), rs.getString("password"),
                            rs.getNString("fullname"), rs.getString("phone"),
                            rs.getString("address"), rs.getDate("dob"),
                            rs.getString("sex"), rs.getString("image"),
                            rs.getBoolean("status"), rs.getBoolean("emailStatus")
                    );
                    return dto;
                }
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return null;
    }

    public UsersDTO newUser(String username, String password) {
        return null;
    }

    public int countTotalRows(String searchValue)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int count = 0;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select count(*) as totalRows "
                        + "From (Select * From users Where userID like 'MT%') as f "
                        + "Where userID like ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, "%" + searchValue + "%");
                rs = stm.executeQuery();

                if (rs.next()) {
                    count = Integer.parseInt(rs.getString("totalRows"));
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return count;
    }

    public List<String> getMentorIDs(String searchValue, int pageID, int total)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<String> mentorIDs = new ArrayList<>();

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select userID From (\n"
                        + "	Select *, ROW_NUMBER() over (order by userID) as numRow\n"
                        + "	From (Select * From users Where userID like 'MT%') as mentor\n"
                        + "	Where userID like ?\n"
                        + ") as m  \n"
                        + "Where ? <= m.numRow  and m.numRow < ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, "%" + searchValue + "%");
                stm.setInt(2, (pageID - 1) * total + 1);
                stm.setInt(3, pageID * total + 1);
                rs = stm.executeQuery();

                while (rs.next()) {
                    mentorIDs.add(rs.getString("userID"));
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return mentorIDs;
    }

    public String getMentorFullname(String mentorID)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String fullname = "";

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select fullname "
                        + "From users "
                        + "Where userID = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, mentorID);
                rs = stm.executeQuery();

                if (rs.next()) {
                    fullname = rs.getString("fullname");
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return fullname;
    }

    public String getMentorUsername(String mentorID)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String username = "";

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select username "
                        + "From users "
                        + "Where userID = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, mentorID);
                rs = stm.executeQuery();

                if (rs.next()) {
                    username = rs.getString("username");
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return username;
    }

    public int getStatus(String mentorID)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int status = 0;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select status "
                        + "From users "
                        + "Where userID = ? ";
                stm = con.prepareStatement(sql);
                stm.setString(1, mentorID);
                rs = stm.executeQuery();

                if (rs.next()) {
                    status = Integer.parseInt(rs.getString("status"));

                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return status;
    }

    public boolean setStatus(String mentorID, int status)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Update users "
                        + "Set status = ? "
                        + "Where userID = ? ";
                stm = con.prepareStatement(sql);
                stm.setInt(1, status);
                stm.setString(2, mentorID);
                int row = stm.executeUpdate();

                if (row > 0) {
                    return true;
                }
            }
        } finally {

            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }

        }
        return false;
    }

    public boolean updateProfile(String userID, String fullname, String address,
            Date dob, String sex)
            throws SQLException, NamingException {

        //1. Establish DB connection
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                //2. Prepare SQL string
                String sql = "UPDATE users "
                        + "SET fullname = ?, address = ?, "
                        + "dob = ? , sex = ? "
                        + "WHERE userID = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, fullname);
                stm.setString(2, address);
                stm.setDate(3, dob);
                stm.setString(4, sex);
                stm.setString(5, userID);
                int result = stm.executeUpdate();
                if (result > 0) {

                    return true;
                }
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }
    
    public boolean updateProfile(String userID, String fullname, String address,
            Date dob, String sex, String image)
            throws SQLException, NamingException {

        //1. Establish DB connection
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                //2. Prepare SQL string
                String sql = "UPDATE users "
                        + "SET fullname = ?, address = ?, "
                        + "dob = ?, sex = ?, image = ? "
                        + "WHERE userID = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, fullname);
                stm.setString(2, address);
                stm.setDate(3, dob);
                stm.setString(4, sex);
                stm.setString(5, image);
                stm.setString(6, userID);
                int result = stm.executeUpdate();
                if (result > 0) {

                    return true;
                }
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }
    
    public List<UsersDTO> getMenteeList() 
            throws SQLException, NamingException {
        List<UsersDTO> menteeList = new ArrayList<>();
        
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT userID, username, email, password, fullname, "
                        + "phone, address, dob, sex, image, status, emailStatus "
                        + "FROM users "
                        + "WHERE userID LIKE ? "
//                        + "GROUP BY fullname "
                        + "ORDER BY fullname";
                stmt = con.prepareStatement(sql);
                stmt.setString(1, "ME%");
                rs = stmt.executeQuery();
                while (rs.next()) {
                    UsersDTO mentee = new UsersDTO(
                            rs.getString("userID"), 
                            rs.getString("username"),
                            rs.getString("email"), 
                            rs.getString("password"),
                            rs.getString("fullname"), 
                            rs.getString("phone"),
                            rs.getString("address"), 
                            rs.getDate("dob"),
                            rs.getString("sex"), 
                            rs.getString("image"),
                            rs.getBoolean("status"),
                            rs.getBoolean("emailStatus")
                    );
                    menteeList.add(mentee);
                }
            }
        }
        finally {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return menteeList;
    }
    public List<UsersDTO> getMentorList() 
            throws SQLException, NamingException {
        List<UsersDTO> mentorList = new ArrayList<>();
        
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT userID, username, email, password, fullname, "
                        + "phone, address, dob, sex, image, status, emailStatus "
                        + "FROM users "
                        + "WHERE userID LIKE ? ";
                stmt = con.prepareStatement(sql);
                stmt.setString(1, "MT%");
                rs = stmt.executeQuery();
                while (rs.next()) {
                    UsersDTO mentor = new UsersDTO(
                            rs.getString("userID"), 
                            rs.getString("username"),
                            rs.getString("email"), 
                            rs.getString("password"),
                            rs.getString("fullname"), 
                            rs.getString("phone"),
                            rs.getString("address"), 
                            rs.getDate("dob"),
                            rs.getString("sex"), 
                            rs.getString("image"),
                            rs.getBoolean("status"),
                            rs.getBoolean("emailStatus")
                    );
                    mentorList.add(mentor);
                }
            }
        }
        finally {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return mentorList;
    }
}
