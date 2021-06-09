
package hps.comments;

import hps.utilities.DBHelper;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import javax.naming.NamingException;

/**
 *
 * @author ADMIN
 */
public class CommentsDAO implements Serializable{
    public boolean addComment(String commentID, String menteeID, String mentorID, 
            int rate, String comments, String datetime) 
            throws NamingException, SQLException{
        Connection con = null;
        PreparedStatement stm = null;
        
        try{
            con = DBHelper.makeConnection();
            if(con != null){
                String sql = "Insert into comments "
                        + "Values(?,?,?,?,?,?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, commentID);
                stm.setString(2, menteeID);
                stm.setString(3, mentorID);
                stm.setInt(4, rate);
                stm.setString(5, comments);
                stm.setString(6, datetime);
                int row = stm.executeUpdate();
                if(row > 0){
                    return true;
                }
            }
        } finally{
            if(stm != null){
                stm.close();
            }
            if(con != null){
                con.close();
            }
        }
        return false;
    }
    
    public float getAvgStar(String mentorID) 
            throws NamingException, SQLException{
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        float avg = -1;
        try{
            con = DBHelper.makeConnection();
            if(con != null){
                String sql = "Select AVG(CAST(rate as float)) as avgStar "
                        + "From comments "
                        + "Where mentorID = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, mentorID);
                rs = stm.executeQuery();
                
                if(rs.next()){
                    if(rs.getString("avgStar") != null){
                        avg = Float.parseFloat(rs.getString("avgStar"));
                    }
                }
            }
        } finally{
            if(rs != null){
                rs.close();
            }
            if(stm != null){
                stm.close();
            }
            if(con != null){
                con.close();
            }
        }
        return avg;
    }
    public int getRateStar(String mentorID)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int rate = 0;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select Ceiling(Avg(rate)) as star "
                        + "From comments "
                        + "Where mentorID = ? ";
                stm = con.prepareStatement(sql);
                stm.setString(1, mentorID);
                rs = stm.executeQuery();

                if (rs.next()) {
                    if (rs.getString("star") != null) {
                        rate = Integer.parseInt(rs.getString("star"));
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
        return rate;
    }
}
