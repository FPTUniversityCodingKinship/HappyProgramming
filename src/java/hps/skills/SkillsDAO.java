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
    
    public List<SkillsDTO> loadAllSkills() 
            throws NamingException, SQLException{
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<SkillsDTO> skillList = new ArrayList<>();
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select skillID, skillName, status "
                        + "From skills ";
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
    public String generateSkillID(String skillType) 
            throws NamingException, SQLException{
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String skillID = "";
        int digit = 0;
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select MAX(f.skillID) as maxSkillID " +
                            "From (Select * From skills Where skillID like ? ) as f ";
                stm = con.prepareStatement(sql);
                stm.setString(1, skillType + "%");
                rs = stm.executeQuery();
                
                if(rs.next()){
                    digit = Integer.parseInt(rs.getString("maxSkillID").substring(2,rs.getString("maxSkillID").length()));
                }
                digit++;
                skillID = skillType + String.format("%06d", digit);
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
        return skillID;
    }
    
    public boolean checkSkillNameExisted(String skillName)
            throws NamingException, SQLException{
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select * "
                        + "From skills "
                        + "Where skillName = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, skillName);
                rs = stm.executeQuery();
                
                if(rs.next()){
                    return true;
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
        return false;
    }
    
    public boolean addNewSkill(String skillID, String skillName, int status)
            throws NamingException, SQLException{
        Connection con = null;
        PreparedStatement stm = null;
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Insert into skills "
                        + "Values(?,?,?) ";
                stm = con.prepareStatement(sql);
                stm.setString(1, skillID);
                stm.setString(2, skillName);
                stm.setInt(3, status);
                
                int row = stm.executeUpdate();
                if(row > 0){
                    return true;
                }
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }
    
    public SkillsDTO getSkillInfo(String skillName)
            throws NamingException, SQLException{
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        SkillsDTO skillInfo = null;
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select skillID, skillName, status "
                        + "From skills "
                        + "Where skillName = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, skillName);
                rs = stm.executeQuery();
                
                if(rs.next()){
                    skillInfo = new SkillsDTO(rs.getString("skillID"), 
                            rs.getString("skillName"), rs.getBoolean("status"));
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
        return skillInfo;
    }
    
    public boolean updateSkill(String skillID, String skillName, int status)
            throws NamingException, SQLException{
        Connection con = null;
        PreparedStatement stm = null;
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Update skills "
                        + "Set skillName = ?, status = ? "
                        + "Where skillID = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, skillName);
                stm.setInt(2, status);
                stm.setString(3, skillID);
                
                int row = stm.executeUpdate();
                if(row > 0){
                    return true;
                }
            }
        } finally {
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
