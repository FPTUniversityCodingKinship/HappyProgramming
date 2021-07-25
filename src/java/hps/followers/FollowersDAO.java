
package hps.followers;

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
    public List<String> getListFollowers(String mentorID) 
        throws SQLException, NamingException {
        List<String> listFollowers = new ArrayList<>();
        
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT menteeID "
                        + "FROM followers "
                        + "WHERE mentorID = ?";
                stmt = con.prepareStatement(sql);
                stmt.setString(1, mentorID);
                rs = stmt.executeQuery();
                while (rs.next()) {
                    listFollowers.add(rs.getString("menteeID"));
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
    public List<String> getListFollowedMentors(String menteeID) 
        throws SQLException, NamingException {
        List<String> listFollowedMentors = new ArrayList<>();
        
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT mentorID "
                        + "FROM followers "
                        + "WHERE menteeID = ?";
                stmt = con.prepareStatement(sql);
                stmt.setString(1, menteeID);
                rs = stmt.executeQuery();
                while (rs.next()) {
                    listFollowedMentors.add(rs.getString("mentorID"));
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
        return listFollowedMentors;
    }
    public boolean addNewFollow(String menteeID, String mentorID, String timestamp)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Insert into followers "
                        + "values(?,?,?,?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, menteeID + "_" + mentorID);
                stm.setString(2, menteeID);
                stm.setString(3, mentorID);
                stm.setString(4, timestamp);
                
                int row = stm.executeUpdate();
                if( row > 0) return true;
            }
        }
        finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }
    public boolean removeFollow(String menteeID, String mentorID)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Delete "
                        + "From followers "
                        + "Where menteeID = ? and mentorID = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, menteeID);
                stm.setString(2, mentorID);
                
                int row = stm.executeUpdate();
                if( row > 0) return true;
            }
        }
        finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }
}
