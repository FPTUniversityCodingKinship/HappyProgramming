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
import java.sql.ResultSet;
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
/**
 *
 * @author ADMIN
 */
    

    public MentorDetailsDTO getMentorDetails(String mentorID) 
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        MentorDetailsDTO detail = null;
        try{
            con = DBHelper.makeConnection();
            if(con != null){
                String sql = "Select mentorID, facebook, github, profession, "
                        + "language, introduction, serviceDescription, achievementDescription "
                        + "From mentorDetails "
                        + "Where mentorID like ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, mentorID);
                rs = stm.executeQuery();
                
                if(rs.next()){
                    detail = new MentorDetailsDTO(
                            rs.getString("mentorID"),
                            rs.getString("facebook"), 
                            rs.getString("github"), 
                            rs.getString("profession"), 
                            rs.getString("language"), 
                            rs.getString("introduction"), 
                            rs.getString("serviceDescription"), 
                            rs.getString("achievementDescription"));
                }
            }
        }finally{
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
        return detail;
    }
    
    public boolean updateCV(MentorDetailsDTO mentorDetails) 
            throws NamingException, SQLException {
        boolean result = false;
        
        Connection con = null;
        PreparedStatement stmt = null;
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "UPDATE mentorDetails "
                        + "SET facebook = ?, github = ?, profession = ?, language = ?, "
                        + "introduction = ?, serviceDescription = ?, achievementDescription = ? "
                        + "WHERE mentorID = ?";
                stmt = con.prepareStatement(sql);
                
                stmt.setNString(1, mentorDetails.getFacebook());
                stmt.setNString(2, mentorDetails.getGithub());
                stmt.setNString(3, mentorDetails.getProfession());
                stmt.setNString(4, mentorDetails.getLanguage());
                stmt.setNString(5, mentorDetails.getIntroduction());
                stmt.setNString(6, mentorDetails.getServiceDescription());
                stmt.setNString(7, mentorDetails.getAchievementDescription());
                stmt.setString(8, mentorDetails.getMentorID());
                
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
    public String getProfession(String mentorID)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String profession = "";

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select profession "
                        + "From mentorDetails "
                        + "Where mentorID = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, mentorID);
                rs = stm.executeQuery();

                if (rs.next()) {
                    profession = rs.getString("profession");
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
        return profession;
    }
}
