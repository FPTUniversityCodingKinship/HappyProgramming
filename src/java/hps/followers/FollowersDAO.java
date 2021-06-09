
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
}
