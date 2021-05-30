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
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;

/**
 *
 * @author ADMIN
 */
public class MentorSkillsDAO implements Serializable{
    
    public List<String> getMappingMentorId(String skillsID) 
            throws NamingException, SQLException{
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String[] listSkillsID = skillsID.replace(" ", "").split(",");
        List<String> mentorsID = new ArrayList<>();
        
        try{
            con = DBHelper.makeConnection();
            if(con != null){
                for(String skillID : listSkillsID){
                    String sql = "Select mentorID "
                        + "From mentorSkills "
                        + "Where skillID like ?";
                    stm = con.prepareStatement(sql);
                    stm.setString(1, skillID);
                    rs = stm.executeQuery();
                    while(rs.next()){
                        if(!mentorsID.contains(rs.getString("mentorID"))){
                            mentorsID.add(rs.getString("mentorID"));
                        }
                    }
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
        return mentorsID;
    }
}
