/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.users;

import hps.utilities.DBHelper;
import java.io.Serializable;
import java.sql.*;
import javax.naming.NamingException;

/**
 *
 * @author DELL
 */
public class UsersDAO implements Serializable {

    /**
     * Check if the account has been registered
     * @param username
     * @param password
     * @return 
     * @throws javax.naming.NamingException 
     */
//    public boolean checkLogin(String username, String password)
//            throws NamingException, SQLException {
//        Connection con = null;
//        PreparedStatement stm = null;
//        ResultSet rs = null;
//        try {
//            //1.Establish Connection
//            con = DBHelper.makeConnection();
//            if (con != null) {
//                //2. Prepare sql string
//                String sql = "SELECT * "
//                        + "FROM users "
//                        + "WHERE username = ? AND password = ?";
//                stm = con.prepareStatement(sql);
//                stm.setString(1, username);
//                stm.setString(2, password);
//                //3. Store in ResultSet
//                rs = stm.executeQuery();
//                if (rs.next()) {
//                    return true;
//                }
//            }
//        } finally {
//            if (stm != null) {
//                stm.close();
//            }
//            if (con != null) {
//                con.close();
//            }
//        }
//
//        return false;
//    }
  
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
                String sql = "SELECT userID "
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
                            rs.getString("password"), rs.getString("email"),
                            rs.getString("fullname"), rs.getString("phone"),
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
}
