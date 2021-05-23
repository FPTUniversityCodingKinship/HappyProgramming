/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.followers;

import hps.users.UsersDTO;
import hps.utilities.DBHelper;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;

/**
 *
 * @author Tran Phong <phongntse150974@fpt.edu.vn>
 */
public class FollowersDAO implements Serializable {

    /**
     * Get a list of mentees that are following the specific mentor
     * @param mentorID
     * @return an ArrayList of mentees
     * @throws java.sql.SQLException
     * @throws javax.naming.NamingException
     */
    public List<UsersDTO> getListFollowers(String mentorID) 
        throws SQLException, NamingException {
        List<UsersDTO> listFollowers = new ArrayList<>();
        
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT menteeUsername "
                        + "FROM followers "
                        + "WHERE mentorUsername = ?";
                stmt = con.prepareStatement(sql);
                stmt.setString(1, mentorID);
                rs = stmt.executeQuery();
                while (rs.next()) {
                    UsersDTO mentee = new UsersDTO(
                            rs.getString("userID"), 
                            rs.getString("username"), 
                            rs.getString("password"), 
                            rs.getString("email"), 
                            rs.getNString("fullname"), 
                            rs.getString("phone"), 
                            rs.getNString("address"), 
                            rs.getDate("dob"), 
                            rs.getString("sex"), 
                            rs.getNString("image"), 
                            rs.getBoolean("status"), 
                            rs.getBoolean("emailStatus")
                    );
                    listFollowers.add(mentee);
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
        
        return listFollowers;
    }
}
