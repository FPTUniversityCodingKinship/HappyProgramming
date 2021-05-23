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
     *
     * @param username
     * @param password
     * @return
     * @throws javax.naming.NamingException
     */
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
                            rs.getString("sex"), rs.getBoolean("status"));
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

    public String getSkillsID(String[] skills)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String skillsID = "";
        try {
            //1.Establish Connection
            con = DBHelper.makeConnection();
            if (con != null) {
                //2. Prepare sql string
                for (int i = 0; i < skills.length; i++) {
                    if (i == skills.length - 1) {
                        String sql = "SELECT skillID "
                                + "FROM skills "
                                + "WHERE skillName like ?";
                        stm = con.prepareStatement(sql);
                        stm.setString(1, skills[i]);
                        //3. Store in ResultSet
                        rs = stm.executeQuery();
                        if (rs.next()) {
                            skillsID += rs.getString("skillID");
                        }
                    } else {
                        String sql = "SELECT skillID "
                                + "FROM skills "
                                + "WHERE skillName like ?";
                        stm = con.prepareStatement(sql);
                        stm.setString(1, skills[i]);
                        //3. Store in ResultSet
                        rs = stm.executeQuery();
                        if (rs.next()) {
                            skillsID += rs.getString("skillID") + ", ";
                        }
                    }
                }
                return skillsID;
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

    public boolean menteeCreateRequest(String requestID, String menteeID, String mentorID,
            String skillsID, String deadline, String title, String content, String status,
            String openedTime) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            //1.Establish Connection
            con = DBHelper.makeConnection();
            if (con != null) {
                //2. Prepare sql string
                String sql = "Insert into requests(requestID,menteeID,mentorID,"
                        + "skillsID,deadline,title,content,status,openedTime) "
                        + "values (?,?,?,?,?,?,?,?,?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, requestID);
                stm.setString(2, menteeID);
                stm.setString(3, mentorID);
                stm.setString(4, skillsID);
                stm.setString(5, deadline);
                stm.setString(6, title);
                stm.setString(7, content);
                stm.setString(8, status);
                stm.setString(9, openedTime);
                //3. Store in ResultSet
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

    public String generateRequestID(String[] skills) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String lastRequestID = "";
        String requestID = "";
        int digit = 0;
        try {
            // 1.Establish Connection
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select max(requestID) as requestID from requests";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                if (rs.next()) {
                    if (rs.getString("requestID") != null) {
                        lastRequestID = rs.getString("requestID");
                        digit = Integer.parseInt(lastRequestID.substring(0, Math.min(lastRequestID.length(), 6)));
                    }
                }
                digit++;
                requestID = String.format("%06d", digit);
                if (skills.length == 1) {
                    requestID += skills[0].toUpperCase();
                } else {
                    for (int i = 0; i < skills.length; i++) {
                        if (i == skills.length - 1) {
                            requestID += skills[i].toUpperCase();
                        } else {
                            requestID += skills[i].toUpperCase() + "_";
                        }
                    }
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
        return requestID;
    }

}
