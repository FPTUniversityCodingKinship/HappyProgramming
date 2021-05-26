/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.requests;

import hps.utilities.DBHelper;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
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
                        + "WHERE menteeID = ? AND (status = ? OR status = ?)";
                
                for (String follower : listFollowers) {
                    String menteeID = follower;
                    stmt = con.prepareStatement(sql);
                    stmt.setString(1, menteeID);
                    stmt.setString(2, "P");
                    stmt.setString(3, "A");
                    
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
    
    public boolean approveRequest(String requestID) 
            throws SQLException, NamingException {
        boolean result = false;
        
        Connection con = null;
        PreparedStatement stmt = null;
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "UPDATE requests "
                        + "SET status = ?, approvedTime = ? "
                        + "WHERE requestID = ?";
                stmt = con.prepareStatement(sql);
                stmt.setString(1, "A");
                stmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
                stmt.setString(3, requestID);
                
                boolean iCheck = stmt.execute();
                if (iCheck) {
                    result = true;
                }
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
    
    public boolean rejectRequest(String requestID) 
            throws SQLException, NamingException {
        boolean result = false;
        
        Connection con = null;
        PreparedStatement stmt = null;
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "UPDATE requests "
                        + "SET status = ?, canceledTime = ? "
                        + "WHERE requestID = ?";
                stmt = con.prepareStatement(sql);
                stmt.setString(1, "R");
                stmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
                stmt.setString(3, requestID);
                
                boolean iCheck = stmt.execute();
                if (iCheck) {
                    result = true;
                }
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
