/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
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
                                String fullname, boolean role)
        throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        
        try {
            //1. Make connection.
            con = DBHelper.makeConnection();
            if (con != null) {
                //2.Create SQL String.
                String sql = "Insert Into "
                            + "users(username, email, password, fullname, status) "
                            + "Values( ?, ?, ?, ?)";
                
                //3. Create Statement and assign Parameter(s) if any.
                stm = con.prepareStatement(sql);
                stm.setString(1, username);
                stm.setString(2, email);
                stm.setString(3, password);
                stm.setString(4, fullname);
                stm.setBoolean(5, role);
                //4. Execute Query.
                ResultSet rs = stm.executeQuery();
                
                //5. Process resultSet.
                if (rs != null) {
                    UsersDTO newUser = new UsersDTO();
                    newUser.setUsername(username);
                    newUser.setEmail(email);
                    newUser.setPassword(password);
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
                    user = new UsersDTO(rs.getString("userID"), rs.getString("username"),
                            rs.getString("password"), rs.getString("email"),
                            rs.getString("fullname"), rs.getString("phone"),
                            rs.getString("address"), rs.getDate("dob"),
                            rs.getString("sex"), rs.getString("image") ,
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
            String fullname, String phone, String address, Date dob, String sex)
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
                        + "phone = ?, address = ?, dob = ? , sex = ? "
                        + "WHERE userID = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, username);
                stm.setString(2, password);
                stm.setNString(3, fullname);
                stm.setString(4, phone);
                stm.setString(5, address);
                stm.setDate(6, dob);
                stm.setString(7, sex);
                stm.setString(8, userID);
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
                            rs.getString("sex"), rs.getString("image") ,
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
    
    public List<String> loadAllMentorsID()
            throws NamingException, SQLException{
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<String> mentorsID = new ArrayList<>();
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select userID "
                        + "From users "
                        + "Where userID like 'MT%'";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                
                while(rs.next()){
                    mentorsID.add(rs.getString("userID"));
                }
            }
        } finally {
            if (rs != null){
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return mentorsID;
    }
}
