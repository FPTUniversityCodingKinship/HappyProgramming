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
    public List<RequestsDTO> getFollowingRequestsList(List<UsersDTO> listFollowers)
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
                        + "WHERE menteeID = ? AND status = ?";

                for (UsersDTO follower : listFollowers) {
                    String menteeID = follower.getUserID();
                    stmt = con.prepareStatement(sql);
                    stmt.setString(1, menteeID);
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
}
