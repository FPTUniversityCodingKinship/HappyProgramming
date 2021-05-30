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
 * @author ADMIN
 */
public class MentorDetailsDAO implements Serializable{
    
    public MentorDetailsDTO getMentorDetails(String mentorID) 
            throws NamingException, SQLException{
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
}
