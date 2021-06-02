/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.mentorSkills;

import hps.utilities.DBHelper;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;

/**
 *
 * @author Tran Phong <phongntse150974@fpt.edu.vn>
 */
public class MentorSkillsDAO implements Serializable {
    
    public String generateMentorSkillID() 
            throws SQLException, NamingException, NumberFormatException {
        String mentorSkillID = "";
        String lastMentorSkillID = "";
        int digit = 1;
        
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select max(mentorSkillID) as mentorSkillID from mentorSkills";
                stmt = con.prepareStatement(sql);
                rs = stmt.executeQuery();
                if (rs.next()) {
                    if (rs.getString("mentorSkillID") != null) {
                        lastMentorSkillID = rs.getString("mentorSkillID");
                        digit = Integer.valueOf(lastMentorSkillID.substring(2, 8)) + 1;
                    }
                }
//                digit++;
                mentorSkillID = "MS" + String.format("%06d", digit);
                
            }
            
        } finally {
            if (stmt != null) {
                stmt.close();
            }
            if (con != null) {
                con.close();
            }
        }
        
        return mentorSkillID;
    }
     
    public boolean addMentorSkills(MentorSkillsDTO mentorSkill) 
            throws SQLException, NamingException {
        boolean result = false;
        
        Connection con = null;
        PreparedStatement stmt = null;
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "INSERT INTO mentorSkills "
                        + "(mentorSkillID, mentorID, skillID, yearsExperience, rate) "
                        + "VALUES (?, ?, ?, ?, ?)";
                stmt = con.prepareStatement(sql);
                stmt.setString(1, mentorSkill.getMentorSkillID());
                stmt.setString(2, mentorSkill.getMentorID());
                stmt.setString(3, mentorSkill.getSkillID());
                stmt.setInt(4, mentorSkill.getYearsExperience());
                stmt.setInt(5, mentorSkill.getRate());
                
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
    
    public boolean deleteMentorSkills(String mentorID) 
            throws NamingException, SQLException {
        boolean result = false;
        
        Connection con = null;
        PreparedStatement stmt = null;
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "DELETE FROM mentorSkills "
                        + "WHERE mentorID = ?";
                stmt = con.prepareStatement(sql);
                stmt.setString(1, mentorID);
                
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
