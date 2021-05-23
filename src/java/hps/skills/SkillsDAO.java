/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.skills;

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
public class SkillsDAO implements Serializable {

    /**
     * Get a list of skills name based on a String containing some skills ID.
     * @param skillsID
     * @return an Array List of skills
     * @throws java.sql.SQLException
     * @throws javax.naming.NamingException
     */
    public List<SkillsDTO> getSkillsList(String skillsID) 
        throws SQLException, NamingException {
        List<SkillsDTO> listSkills = new ArrayList<>();
        
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            con = DBHelper.makeConnection();
            
            if (con != null) {
                String[] arrSkillsID = skillsID.split(",");
                String sql = "SELECT skillID, skillName "
                        + "FROM skills "
                        + "WHERE skillID = ?"; // TODO Code // Status ?
                for (String skillID : arrSkillsID) {
                    stmt = con.prepareStatement(sql);
                    stmt.setString(1, skillID);
                    rs = stmt.executeQuery();
                    if (rs.next()) {
                        SkillsDTO skill = new SkillsDTO(
                                rs.getString("skillID"), 
                                rs.getNString("skillName"), 
                                rs.getBoolean("status")
                        );
                        listSkills.add(skill);
                    }
                    if (stmt != null) {
                        stmt.close();
                    }
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
        
        return listSkills;
    }
}
