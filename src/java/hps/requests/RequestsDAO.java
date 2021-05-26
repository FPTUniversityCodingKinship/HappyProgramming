/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.requests;

import hps.users.UsersDTO;
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
public class RequestsDAO implements Serializable {

    /**
     * Get a list of requests that come from mentees who follow the mentor
     *
     * @param listFollowers
     * @return an Array List of Requests
     * @throws java.sql.SQLException
     * @throws javax.naming.NamingException
     */
    public List<RequestsDTO> getFollowingRequestsList(List<String> listFollowers) 
        throws SQLException, NamingException {

        List<RequestsDTO> listRequests = new ArrayList<>();

        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            con = DBHelper.makeConnection();

            if (con != null) {
                String sql = "SELECT requestID, menteeID, mentorID, skillsID, "
                        + "deadline, title, reqContent, status, openedTime, "
                        + "approvedTime, canceledTime, closedTime "
                        + "FROM requests "
                        + "WHERE menteeID = ? AND status = ?";

                
                for (String follower : listFollowers) {
                    String menteeID = follower;
                    stmt = con.prepareStatement(sql);
                    stmt.setString(1, menteeID);
                    stmt.setString(2, "P");
                    

                    rs = stmt.executeQuery();
                    while (rs.next()) {
                        RequestsDTO request = new RequestsDTO(
                                rs.getString("requestID"),
                                rs.getString("menteeID"),
                                rs.getString("mentorID"),
                                rs.getString("skillsID"),
                                rs.getTimestamp("deadline"),
                                rs.getNString("title"),
                                rs.getNString("reqContent"),
                                rs.getString("status"),
                                rs.getTimestamp("openedTime"),
                                rs.getTimestamp("approvedTime"),
                                rs.getTimestamp("canceledTime"),
                                rs.getTimestamp("closedTime")
                        );
                        listRequests.add(request);
                    }
                    if (stmt != null) {
                        stmt.close();
                    }
                }
            }
        } finally {
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

        return listRequests;
    }

    /**
     * Get a list of requests that come from mentees who chose the mentor
     *
     * @param mentorID
     * @return an Array List of Requests
     * @throws java.sql.SQLException
     * @throws javax.naming.NamingException
     */
    public List<RequestsDTO> getInvitingRequestsList(String mentorID)
            throws SQLException, NamingException {
        List<RequestsDTO> listRequests = new ArrayList<>();

        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            con = DBHelper.makeConnection();

            if (con != null) {
                String sql = "SELECT requestID, menteeID, mentorID, skillsID, "
                        + "deadline, title, content, status, openedTime, "
                        + "approvedTime, canceledTime, closedTime "
                        + "FROM requests "
                        + "WHERE mentorID = ? AND status = ?";

                stmt = con.prepareStatement(sql);
                stmt.setString(1, mentorID);
                stmt.setString(3, "P");

                rs = stmt.executeQuery();
                while (rs.next()) {
                    RequestsDTO request = new RequestsDTO(
                            rs.getString("requestID"),
                            rs.getString("menteeID"),
                            rs.getString("mentorID"),
                            rs.getString("skillsID"),
                            rs.getTimestamp("deadline"),
                            rs.getNString("title"),
                            rs.getNString("reqContent"),
                            rs.getString("status"),
                            rs.getTimestamp("openedTime"),
                            rs.getTimestamp("approvedTime"),
                            rs.getTimestamp("canceledTime"),
                            rs.getTimestamp("closedTime")
                    );
                    listRequests.add(request);
                }
                if (stmt != null) {
                    stmt.close();
                }
            }
        } finally {
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

        return listRequests;
    }
    public boolean menteeCreateRequest(String requestID, String menteeID, String mentorID,
            String skillsID, String deadline, String title, String reqContent, String status,
            String openedTime) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            //1.Establish Connection
            con = DBHelper.makeConnection();
            if (con != null) {
                //2. Prepare sql string
                String sql = "Insert into requests(requestID,menteeID,mentorID,"
                        + "skillsID,deadline,title,reqContent,status,openedTime) "
                        + "values (?,?,?,?,?,?,?,?,?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, requestID);
                stm.setString(2, menteeID);
                stm.setString(3, mentorID);
                stm.setString(4, skillsID);
                stm.setString(5, deadline);
                stm.setNString(6, title);
                stm.setString(7, reqContent);
                stm.setString(8, status);
                stm.setString(9, openedTime);
                //3. Store in ResultSet
                int row = stm.executeUpdate();
                if (row > 0) {
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

    public String generateRequestID(String[] skills) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String lastRequestID = "";
        String requestID = "";
        int digit = 0;
        try {
            // 1.Establish Connection
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select max(requestID) as requestID from requests";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                if (rs.next()) {
                    if (rs.getString("requestID") != null) {
                        lastRequestID = rs.getString("requestID");
                        digit = Integer.parseInt(lastRequestID.substring(0, Math.min(lastRequestID.length(), 6)));
                    }
                }
                digit++;
                requestID = String.format("%06d", digit);
                if (skills.length == 1) {
                    requestID += skills[0].toUpperCase();
                } else {
                    for (int i = 0; i < skills.length; i++) {
                        if (i == skills.length - 1) {
                            requestID += skills[i].toUpperCase();
                        } else {
                            requestID += skills[i].toUpperCase() + "_";
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
        return requestID;
    }
    
    public List<RequestsDTO> getMenteeListRequest(String userID) 
            throws SQLException, NamingException{
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<RequestsDTO> listRequests = new ArrayList<>();
        
        try{
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select requestID, menteeID, mentorID, skillsID, "+ 
                            "deadline, title, reqContent, status, openedTime, "+ 
                            "approvedTime, canceledTime, closedTime " +
                            "From requests " +
                            "Where menteeID like ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, userID);
                rs = stm.executeQuery();
                
                while(rs.next()){
                    RequestsDTO request = new RequestsDTO(
                                rs.getString("requestID"),
                                rs.getString("menteeID"),
                                rs.getString("mentorID"),
                                rs.getString("skillsID"),
                                rs.getTimestamp("deadline"),
                                rs.getNString("title"),
                                rs.getNString("reqContent"),
                                rs.getString("status"),
                                rs.getTimestamp("openedTime"),
                                rs.getTimestamp("approvedTime"),
                                rs.getTimestamp("canceledTime"),
                                rs.getTimestamp("closedTime"));
                    listRequests.add(request);
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
        return listRequests;
    }
    
    public boolean menteeDeleteRequest(String requestID) 
            throws SQLException, NamingException{
        Connection con = null;
        PreparedStatement stm = null;
        
        try{
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Delete From requests Where requestID like ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, requestID);
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
    
    public boolean menteeUpdateRequest(String requestID, String title, String deadline,
            String reqContent, String skillsID)throws SQLException, NamingException{
        Connection con = null;
        PreparedStatement stm = null;
        
        try{
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Update requests "
                        + "Set title = ? , deadline = ? , "
                        + "reqContent = ? , skillsID = ? "
                        + "Where requestID like ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, title);
                stm.setString(2, deadline);
                stm.setString(3, reqContent);
                stm.setString(4, skillsID);
                stm.setString(5, requestID);
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
    
    public ArrayList<String> getRequestTitle(String menteeID) 
            throws NamingException, SQLException{
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ArrayList<String> titles = new ArrayList<>();
        
        try{
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select title "
                        + "From requests "
                        + "Where menteeID like ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, menteeID);
                rs = stm.executeQuery();
                
                while(rs.next()){
                    titles.add(rs.getString("title"));
                }
            }
        } finally {
            if(rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return titles;
    }
    
    public String getTotalNumberOfRequest(String menteeID) 
            throws NamingException, SQLException{
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String totalRequest = "";
        
        try{
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select count(*) as totalRequest "
                        + "From requests "
                        + "Where menteeID like ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, menteeID);
                rs = stm.executeQuery();
                
                if(rs.next()){
                    totalRequest = rs.getString("totalRequest");
                }
            }
        } finally {
            if(rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return totalRequest;
    }
    
    public String getTotalHoursOfRequest(String menteeID) 
            throws NamingException, SQLException{
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int total = 0;
        String totalHours = "";
        
        try{
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select DATEDIFF(second,approvedTime,closedTime)/(60*60) as hours " 
                        + "From requests " 
                        + "Where menteeID like ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, menteeID);
                rs = stm.executeQuery();
                
                while(rs.next()){
                    total += Integer.parseInt(rs.getString("hours"));
                }
                totalHours = String.valueOf(total);
            }
        } finally {
            if(rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return totalHours;
    }
    public String getTotalMentor(String menteeID) 
            throws NamingException, SQLException{
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int total = 0;
        String totalMentor = "";
        
        try{
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select COUNT(DISTINCT(mentorID)) as totalMentor " 
                        + "From requests " 
                        + "Where menteeID like ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, menteeID);
                rs = stm.executeQuery();
                
                if(rs.next()){
                    total = Integer.parseInt(rs.getString("totalMentor"));
                }
                totalMentor = String.valueOf(total);
            }
        } finally {
            if(rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return totalMentor;
    }
}
