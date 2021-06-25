package hps.mentorSkills;

import hps.utilities.DBHelper;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
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

    public List<String> getMappingMentorId(String skillsID)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String[] listSkillsID = skillsID.replace(" ", "").split(",");
        List<String> mentorsID = new ArrayList<>();

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                for (String skillID : listSkillsID) {
                    String sql = "Select mentorID "
                            + "From mentorSkills "
                            + "Where skillID like ?";
                    stm = con.prepareStatement(sql);
                    stm.setString(1, skillID);
                    rs = stm.executeQuery();
                    while (rs.next()) {
                        if (!mentorsID.contains(rs.getString("mentorID"))) {
                            mentorsID.add(rs.getString("mentorID"));
                        }
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
        return mentorsID;
    }

    public List<MentorSkillsDTO> getMentorSkills(String mentorID)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<MentorSkillsDTO> mentorSkills = new ArrayList<>();

        try {
            con = DBHelper.makeConnection();
            if (con != null) {

                String sql = "SELECT mentorSkillID, mentorID, skillID, yearsExperience, rate "
                        + "FROM mentorSkills "
                        + "WHERE mentorID = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, mentorID);
                rs = stm.executeQuery();
                while (rs.next()) {
                    MentorSkillsDTO dto = new MentorSkillsDTO(
                            rs.getString("mentorSkillID"),
                            rs.getString("mentorID"),
                            rs.getString("skillID"),
                            rs.getInt("yearsExperience"),
                            rs.getInt("rate")
                    );
                    mentorSkills.add(dto);
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
        return mentorSkills;
    }

    
}
