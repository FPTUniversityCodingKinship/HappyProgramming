/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.requests;

import hps.utilities.DBHelper;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Period;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.naming.NamingException;

/**
 *
 * @author Tran Phong <phongntse150974@fpt.edu.vn>
 */
public class RequestsDAO implements Serializable {

    public static final String STATUS_ACCEPTED = "A";
    public static final String STATUS_REJECTED = "R";
    public static final String STATUS_CLOSED = "C";

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
                        + "WHERE menteeID = ? AND (status = ? OR status = ?) "
                        + "ORDER BY openedTime DESC";

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
                listRequests.sort(new Comparator<RequestsDTO>() {
                    @Override
                    public int compare(RequestsDTO o1, RequestsDTO o2) {
                        return - (o1.getOpenedTime().compareTo(o2.getOpenedTime())); //To change body of generated lambdas, choose Tools | Templates.
                    }
                });
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
                        + "deadline, title, reqContent, status, openedTime, "
                        + "approvedTime, canceledTime, closedTime "
                        + "FROM requests "
                        + "WHERE mentorID = ? AND (status = ? OR status = ?)";

                stmt = con.prepareStatement(sql);
                stmt.setString(1, mentorID);
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
                listRequests.sort(new Comparator<RequestsDTO>() {
                    @Override
                    public int compare(RequestsDTO o1, RequestsDTO o2) {
                        return - (o1.getOpenedTime().compareTo(o2.getOpenedTime())); //To change body of generated lambdas, choose Tools | Templates.
                    }
                });
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
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<RequestsDTO> listRequests = new ArrayList<>();

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select requestID, menteeID, mentorID, skillsID, "
                        + "deadline, title, reqContent, status, openedTime, "
                        + "approvedTime, canceledTime, closedTime "
                        + "From requests "
                        + "Where menteeID = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, userID);
                rs = stm.executeQuery();

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

    public boolean approveRequest(String requestID, String mentorID)
            throws SQLException, NamingException {
        boolean result = false;

        Connection con = null;
        PreparedStatement stmt = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "UPDATE requests "
                        + "SET mentorID = ?, status = ?, approvedTime = ? "
                        + "WHERE requestID = ?";
                stmt = con.prepareStatement(sql);
                stmt.setString(1, mentorID);
                stmt.setString(2, "A");
                stmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
                stmt.setString(4, requestID);

                int iCheck = stmt.executeUpdate();
                if (iCheck > 0) {
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

    public boolean menteeDeleteRequest(String requestID)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Delete From requests Where requestID = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, requestID);
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

    public boolean menteeUpdateRequest(String requestID, String title, String deadline,
            String reqContent, String skillsID) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Update requests "
                        + "Set title = ? , deadline = ? , "
                        + "reqContent = ? , skillsID = ? "
                        + "Where requestID = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, title);
                stm.setString(2, deadline);
                stm.setString(3, reqContent);
                stm.setString(4, skillsID);
                stm.setString(5, requestID);
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

    public boolean menteeUpdateRequestSeparately(String requestID, String title, String deadline,
            String reqContent, String skillsID, String mentorID) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Update requests "
                        + "Set title = ? , deadline = ? , "
                        + "reqContent = ? , skillsID = ?, mentorID = ? "
                        + "Where requestID = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, title);
                stm.setString(2, deadline);
                stm.setString(3, reqContent);
                stm.setString(4, skillsID);
                stm.setString(5, mentorID);
                stm.setString(6, requestID);
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

    public boolean rejectRequest(String requestID, String mentorID)
            throws SQLException, NamingException {
        boolean result = false;

        Connection con = null;
        PreparedStatement stmt = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "UPDATE requests "
                        + "SET mentorID = ?, status = ?, canceledTime = ? "
                        + "WHERE requestID = ?";
                stmt = con.prepareStatement(sql);
                stmt.setString(1, mentorID);
                stmt.setString(2, "R");
                stmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
                stmt.setString(4, requestID);

                int iCheck = stmt.executeUpdate();
                if (iCheck > 0) {
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

    public ArrayList<String> getRequestTitle(String menteeID)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ArrayList<String> titles = new ArrayList<>();

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select title "
                        + "From requests "
                        + "Where menteeID = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, menteeID);
                rs = stm.executeQuery();

                while (rs.next()) {
                    titles.add(rs.getString("title"));
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
        return titles;
    }

    public String getTotalNumberOfRequest(String menteeID)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String totalRequest = "";

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select count(*) as totalRequest "
                        + "From requests "
                        + "Where menteeID = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, menteeID);
                rs = stm.executeQuery();

                if (rs.next()) {
                    totalRequest = rs.getString("totalRequest");
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
        return totalRequest;
    }

    public String getTotalHoursOfRequest(String menteeID)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int total = 0;
        String totalHours = "";

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select DATEDIFF(second,approvedTime,closedTime)/(60*60) as hours "
                        + "From requests "
                        + "Where menteeID = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, menteeID);
                rs = stm.executeQuery();

                while (rs.next()) {
                    if (rs.getString("hours") != null) {
                        total += Integer.parseInt(rs.getString("hours"));
                    }
                }
                totalHours = String.valueOf(total);
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

        return totalHours;
    }

    public String getTotalMentor(String menteeID)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int total = 0;
        String totalMentor = "";

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select COUNT(DISTINCT(mentorID)) as totalMentor "
                        + "From requests "
                        + "Where menteeID = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, menteeID);
                rs = stm.executeQuery();

                if (rs.next()) {
                    total = Integer.parseInt(rs.getString("totalMentor"));
                }
                totalMentor = String.valueOf(total);
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
        return totalMentor;
    }

    public List<RequestsDTO> loadListRequest(String menteeID)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<RequestsDTO> listRequest = new ArrayList<>();
        try {
            //1.Establish Connection
            con = DBHelper.makeConnection();
            if (con != null) {
                //2. Prepare sql string
                String sql = "Select requestID, menteeID, mentorID, skillsID, "
                        + "deadline, title, reqContent, status, openedTime, "
                        + "approvedTime, canceledTime, closedTime "
                        + "From requests "
                        + "Where menteeID = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, menteeID);

                //3. Store in ResultSet
                rs = stm.executeQuery();

                while (rs.next()) {
                    listRequest.add(new RequestsDTO(rs.getString("requestID"),
                            rs.getString("menteeID"), rs.getString("mentorID"),
                            rs.getString("skillsID"), rs.getTimestamp("deadline"),
                            rs.getString("title"), rs.getString("reqContent"),
                            rs.getString("status"), rs.getTimestamp("openedTime"),
                            rs.getTimestamp("approvedTime"), rs.getTimestamp("canceledTime"),
                            rs.getTimestamp("closedTime")));
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

        return listRequest;
    }

    public RequestsDTO getRequestByRequestID(String requestID)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        RequestsDTO request = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                //2. Prepare sql string
                String sql = "Select requestID, menteeID, mentorID, skillsID, "
                        + "deadline, title, reqContent, status, openedTime, "
                        + "approvedTime, canceledTime, closedTime "
                        + "From requests "
                        + "Where requestID = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, requestID);

                //3. Store in ResultSet
                rs = stm.executeQuery();

                if (rs.next()) {
                    request = new RequestsDTO(rs.getString("requestID"),
                            rs.getString("menteeID"), rs.getString("mentorID"),
                            rs.getString("skillsID"), rs.getTimestamp("deadline"),
                            rs.getString("title"), rs.getString("reqContent"),
                            rs.getString("status"), rs.getTimestamp("openedTime"),
                            rs.getTimestamp("approvedTime"), rs.getTimestamp("canceledTime"),
                            rs.getTimestamp("closedTime"));
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
        return request;
    }

    public boolean closeRequest(String requestID)
            throws SQLException, NamingException {
        boolean result = false;

        Connection con = null;
        PreparedStatement stmt = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "UPDATE requests "
                        + "SET status = ?, closedTime = ? "
                        + "WHERE requestID = ?";
                stmt = con.prepareStatement(sql);
                stmt.setString(1, "C");
                stmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
                stmt.setString(3, requestID);

                int iCheck = stmt.executeUpdate();
                if (iCheck > 0) {
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

    public Map<String, String> loadRequestForRating(String menteeID)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        Map<String, String> reqInfo = new HashMap<>();

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select requestID, title, mentorID "
                        + "From requests "
                        + "Where closedTime is not null AND mentorID is not null "
                        + "AND menteeID = ? ";
                stm = con.prepareStatement(sql);
                stm.setString(1, menteeID);
                rs = stm.executeQuery();
                while (rs.next()) {
                    reqInfo.put(rs.getString("requestID"), rs.getString("title")
                            + "," + rs.getString("mentorID"));
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
        return reqInfo;
    }

    public int getNumberOfRequest(String mentorID)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int num = 0;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select count(*) as numReq "
                        + "From requests "
                        + "Where mentorID = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, mentorID);
                rs = stm.executeQuery();

                if (rs.next()) {
                    num = Integer.parseInt(rs.getString("numReq"));
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
        return num;
    }

    public boolean inviteMentor(String requestID, String mentorID)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Update requests "
                        + "Set mentorID = ? "
                        + "Where requestID = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, mentorID);
                stm.setString(2, requestID);
                int row = stm.executeUpdate();
                if (row > 0) {
                    return true;
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
        return false;
    }

    public int getNumberOfRequest(String mentorID, String status)
            throws NamingException, SQLException {

        int totalRequest = 0;

        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        if (status.equals(STATUS_ACCEPTED) || status.equals(STATUS_CLOSED) || status.equals(STATUS_REJECTED)) {
            try {
                con = DBHelper.makeConnection();

                if (con != null) {
                    String sql = "SELECT count(*) AS totalRequest "
                            + "FROM requests "
                            + "WHERE mentorID = ? AND status = ?";

                    stmt = con.prepareStatement(sql);
                    stmt.setString(1, mentorID);
                    stmt.setString(2, status);

                    rs = stmt.executeQuery();
                    if (rs.next()) {
                        totalRequest = rs.getInt("totalRequest");
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
        } else {
            totalRequest = -1;
        }

        return totalRequest;
    }

    public int getTotalSkills(String menteeID)
            throws NamingException, SQLException {

        int totalSkills = 0;

        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                Set<String> skillSet = new HashSet<>();
                String sql = "SELECT skillsID "
                        + "FROM requests "
                        + "WHERE menteeID = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, menteeID);
                rs = stm.executeQuery();
                while (rs.next()) {
                    String[] skillArr = rs.getString("skillsID").split(",");
                    skillSet.addAll(Arrays.asList(skillArr));
                }
                totalSkills = skillSet.size();
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
        return totalSkills;
    }

    private static float findDifference(String start_date, String end_date) {

        // SimpleDateFormat converts the
        // string format to date object
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        float result = 0;
        // Try Block
        try {
            // parse method is used to parse
            // the text from a string to
            // produce the date
            java.util.Date d1 = sdf.parse(start_date);
            java.util.Date d2 = sdf.parse(end_date);

            // Calucalte time difference
            // in milliseconds
            long difference_In_Time
                    = d2.getTime() - d1.getTime();

            // Calucalte time difference in
            // seconds, minutes, hours, years,
            // and days
            long difference_In_Seconds
                    = (difference_In_Time
                    / 1000)
                    % 60;

            long difference_In_Minutes
                    = (difference_In_Time
                    / (1000 * 60))
                    % 60;

            long difference_In_Hours
                    = (difference_In_Time
                    / (1000 * 60 * 60))
                    % 24;

            long difference_In_Years
                    = (difference_In_Time
                    / (1000l * 60 * 60 * 24 * 365));

            long difference_In_Days
                    = (difference_In_Time
                    / (1000 * 60 * 60 * 24))
                    % 365;

            // Print the date difference in
            // years, in days, in hours, in
            // minutes, and in seconds
            result = (float) (difference_In_Seconds + difference_In_Minutes * 60
                    + difference_In_Hours * 60 * 60 + difference_In_Days * 24 * 60 * 60
                    + difference_In_Years * 365 * 24 * 60 * 60) / 3600;

        } // Catch the Exception
        catch (ParseException e) {
            e.printStackTrace();
        }
        return result;
    }

    public String getRequestsTotalHours(String menteeID)
            throws NamingException, SQLException {

        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        float total = 0;
        String strTotal = "";
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT approvedTime, closedTime "
                        + "FROM requests "
                        + "WHERE menteeID = ? AND status = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, menteeID);
                stm.setString(2, STATUS_CLOSED);

                rs = stm.executeQuery();

                while (rs.next()) {
                    if (rs.getString("closedTime") != null) {
                        Timestamp approvedTime = rs.getTimestamp("approvedTime");
                        Timestamp closedTime = rs.getTimestamp("closedTime");
                        total = findDifference(approvedTime.toString(), closedTime.toString());
                        strTotal = String.format("%.2f", total);
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
        return strTotal;
    }

    public int getNumOfApprovedReq(String mentorID)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int aReq = 0;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select count(*) as numReq "
                        + "From requests "
                        + "Where approvedTime is not null AND mentorID = ? ";
                stm = con.prepareStatement(sql);
                stm.setString(1, mentorID);
                rs = stm.executeQuery();

                if (rs.next()) {
                    aReq = Integer.parseInt(rs.getString("numReq"));
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
        return aReq;
    }

    public int getNumOfCompletedReq(String mentorID)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int cReq = 0;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select count(*) as numReq "
                        + "From requests "
                        + "Where approvedTime is not null AND "
                        + "closedTime is not null AND mentorID = ? ";
                stm = con.prepareStatement(sql);
                stm.setString(1, mentorID);
                rs = stm.executeQuery();
                if (rs.next()) {
                    cReq = Integer.parseInt(rs.getString("numReq"));
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
        return cReq;
    }

    public int getNumberOfRequests(String searchValue, String[] status,
            Date startDate, Date endDate) throws SQLException, NamingException {

        int result = 0;

        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT count(*) as totalRows "
                        + "FROM requests "
                        + "WHERE ";
                
                if (!searchValue.trim().isEmpty()) {
                    sql += "reqContent LIKE '%" + searchValue + "%' ";
                }
                if (status != null && status.length > 0) {
                    if (!searchValue.trim().isEmpty()) {
                        sql += "AND ";
                    }
                    sql += "(";
                    for (int i = 0; i < status.length; i++) {
                        String checkStatus = status[i];
                        if (i == status.length - 1) {
                            sql += "status = '" + checkStatus + "' ";
                        } else {
                            sql += "status = '" + checkStatus + "' OR ";
                        }
                    }
                    sql += ") ";
                }
                if (startDate != null) {
                    if (!searchValue.trim().isEmpty() || (status != null && status.length > 0)) {
                        sql += "AND ";
                    }
                    if (endDate != null) {
                        sql += "openedTime >= '" + startDate + "' AND (closedTime <= '" + endDate + "' OR canceledTime <= '" + endDate + "')";
                    } else {
                        sql += "openedTime >= '" + startDate + "'";
                    }
                } else {
                    if (endDate != null) {
                        if (!searchValue.trim().isEmpty() || (status != null && status.length > 0)) {
                            sql += "AND ";
                        }
                        sql += "(closedTime <= '" + endDate + "' OR canceledTime <= '" + endDate + "')";
                    }
                }
                stmt = con.prepareStatement(sql);
                rs = stmt.executeQuery();
                if (rs.next()) {
                    result = rs.getInt("totalRows");
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

        return result;
    }
    public List<RequestsDTO> getRequestsList(String searchValue, String[] status,
            Date startDate, Date endDate, int pageID, int total)
            throws SQLException, NamingException {

        List<RequestsDTO> requestsList = new ArrayList<>();

        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT requestID, menteeID, title, status "
                        + "FROM ("
                        + "SELECT requestID, menteeID, title, status, ROW_NUMBER() OVER (ORDER by requestID) as numRow "
                        + "FROM requests "
                        + "WHERE ";
                if (!searchValue.trim().isEmpty()) {
                    sql += "reqContent LIKE '%" + searchValue + "%' ";
                }
                if (status != null && status.length > 0) {
                    if (!searchValue.trim().isEmpty()) {
                        sql += " AND ";
                    }
                    sql += "(";
                    for (int i = 0; i < status.length; i++) {
                        String checkStatus = status[i];
                        if (i == status.length - 1) {
                            sql += "status = '" + checkStatus + "' ";
                        } else {
                            sql += "status = '" + checkStatus + "' OR ";
                        }
                    }
                    sql += ") ";
                }
                if (startDate != null) {
                    if (!searchValue.trim().isEmpty() || (status != null && status.length > 0)) {
                        sql += "AND ";
                    }
                    if (endDate != null) {
                        sql += "openedTime >= '" + startDate + "' AND (closedTime <= '" + endDate + "' OR canceledTime <= '" + endDate + "')";
                    } else {
                        sql += "openedTime >= '" + startDate + "'";
                    }
                    
                } else {
                    if (endDate != null) {
                        if (!searchValue.trim().isEmpty() || (status != null && status.length > 0) || startDate != null) {
                            sql += " AND ";
                        }
                        sql += "(closedTime <= '" + endDate + "' OR canceledTime <= '" + endDate + "')";
                    }
                }
                sql += ") as m "
                        + "WHERE m.numRow > ? AND m.numRow < ?";
                stmt = con.prepareStatement(sql);
                stmt.setInt(1, (pageID - 1)*total);
                stmt.setInt(2, pageID * total + 1);
                rs = stmt.executeQuery();
                while (rs.next()) {
                    RequestsDTO dto = new RequestsDTO(
                            rs.getString("requestID"),
                            rs.getString("menteeID"),
                            "",
                            "",
                            null,
                            rs.getNString("title"),
                            "",
                            rs.getString("status"),
                            null,
                            null,
                            null,
                            null
                    );
                    requestsList.add(dto);
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

        return requestsList;
    }
}
