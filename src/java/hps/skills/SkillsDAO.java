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
//                        String id = rs.getString("skillID");
//                        String name = rs.getNString("skillName");
//                        boolean stt = rs.getBoolean("status");
                        SkillsDTO skill = new SkillsDTO(
                                rs.getString("skillID"), 
                                rs.getNString("skillName"), 
                                true
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
    public String getSkillsID(String[] skillsName)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String skillsID = "";
        try {
            //1.Establish Connection
            con = DBHelper.makeConnection();
            if (con != null) {
                //2. Prepare sql string
                for (int i = 0; i < skillsName.length; i++) {
                    if (i == skillsName.length - 1) {
                        String sql = "SELECT skillID "
                                + "FROM skills "
                                + "WHERE skillName like ?";
                        stm = con.prepareStatement(sql);
                        stm.setString(1, skillsName[i]);
                        //3. Store in ResultSet
                        rs = stm.executeQuery();
                        if (rs.next()) {
                            skillsID += rs.getString("skillID");
                        }
                    } else {
                        String sql = "SELECT skillID "
                                + "FROM skills "
                                + "WHERE skillName like ?";
                        stm = con.prepareStatement(sql);
                        stm.setString(1, skillsName[i]);
                        //3. Store in ResultSet
                        rs = stm.executeQuery();
                        if (rs.next()) {
                            skillsID += rs.getString("skillID") + ", ";
                        }
                    }
                }
                return skillsID;
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return null;
    }
    
    public String getSkillsName(String skillID)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String skillsName = "";
        String[] skillsID = skillID.replace(" ","").split(",");
        try {
            //1.Establish Connection
            con = DBHelper.makeConnection();
            if (con != null) {
                //2. Prepare sql string
                for (int i = 0; i < skillsID.length; i++) {
                    if (i == skillsID.length - 1) {
                        String sql = "SELECT skillName "
                                + "FROM skills "
                                + "WHERE skillID like ?";
                        stm = con.prepareStatement(sql);
                        stm.setString(1, skillsID[i]);
                        //3. Store in ResultSet
                        rs = stm.executeQuery();
                        if (rs.next()) {
                            skillsName += rs.getString("skillName");
                        }
                    } else {
                        String sql = "SELECT skillName "
                                + "FROM skills "
                                + "WHERE skillID like ?";
                        stm = con.prepareStatement(sql);
                        stm.setString(1, skillsID[i]);
                        //3. Store in ResultSet
                        rs = stm.executeQuery();
                        if (rs.next()) {
                            skillsName += rs.getString("skillName") + ", ";
                        }
                    }
                }
                return skillsName;
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return null;
    }
    
    public List<SkillsDTO> loadSkills() 
            throws NamingException, SQLException{
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<SkillsDTO> skillList = new ArrayList<>();
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select skillID, skillName, status "
                        + "From skills "
                        + "Where status = '1' ";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                
                while(rs.next()){
                    skillList.add(new SkillsDTO(rs.getString("skillID"), 
                            rs.getString("skillName"), rs.getBoolean("status")));
                }
            }
        } finally {
            if(rs != null){
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return skillList;
    }
}
