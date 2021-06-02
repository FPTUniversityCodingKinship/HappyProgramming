/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.mentorDetails;

import hps.utilities.DBHelper;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.naming.NamingException;

/**
 *
 * @author Tran Phong <phongntse150974@fpt.edu.vn>
 */
public class MentorDetailsDAO implements Serializable {
    public boolean createCV(MentorDetailsDTO mentorDetails) 
            throws NamingException, SQLException {
        boolean result = false;
        
        Connection con = null;
        PreparedStatement stmt = null;
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "INSERT INTO mentorDetails "
                        + "(mentorID, facebook, github, profession, language, "
                        + "introduction, serviceDescription, achievementDescription) "
                        + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                stmt = con.prepareStatement(sql);
                stmt.setString(1, mentorDetails.getMentorID());
                stmt.setNString(2, mentorDetails.getFacebook());
                stmt.setNString(3, mentorDetails.getGithub());
                stmt.setNString(4, mentorDetails.getProfession());
                stmt.setNString(5, mentorDetails.getLanguage());
                stmt.setNString(6, mentorDetails.getIntroduction());
                stmt.setNString(7, mentorDetails.getServiceDescription());
                stmt.setNString(8, mentorDetails.getAchievementDescription());
                
                result = stmt.executeUpdate() > 0;
            }
        } finally {
            if (stmt != null) {
                stmt.close();
            }
            if (con != null) {
                con.close();
            }
        }
        
        return result;
    }
}
