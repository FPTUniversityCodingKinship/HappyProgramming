/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.utilities;

import java.sql.*;
import java.io.Serializable;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 *
 * @author DELL
 */
public class DBHelper implements Serializable {

    public static Connection makeConnection()
            throws NamingException, SQLException {
        //Retrieve current context
        Context curCtx = new InitialContext();
        //Retrieve Tomcat's context
        Context tomcatCtx = (Context) curCtx.lookup("java:comp/env");
        //Retrieved DataSource
        DataSource ds = (DataSource) tomcatCtx.lookup("DBContext");
        Connection con = ds.getConnection();
        return con;
    }
    
    public static String generateUserID(Connection con) throws SQLException {
        //1. get last user ID
        int MAX_INDEX = 999999;
        String lastID = getLastUserID(con);
        String newID = "";
        
        if (!lastID.isEmpty()) {
            int lastNum = Integer.parseInt(lastID.substring(2, 6));
            if (lastNum > 0) {
                //increase 1
                lastNum++;
                int digits = 6;
                if (lastNum > MAX_INDEX)
                    newID = "OVER_STACK_FOUND";
                else {
                    while (lastNum > 0) {
                        newID = String.valueOf(lastNum % 10) + newID;
                        lastNum /= 10;
                        digits--;
                    }
                    if (digits > 0)
                        for (int i = 0; i < digits; i++)
                            newID = "0" + newID;
                }
            }
            else {
                newID = "WRONG_ID_FOUND";
            }
        }
        else {
            newID = "NO_ID_FOUND";
        }
        
        return newID;
    }
    
    private static String getLastUserID(Connection con) throws SQLException {
        //connection existed.
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            //2. Make query string
            String sql = "SELECT TOP 1 userID " +
                         "FROM users " +
                         "WHERE userID like 'ME%' " +
                         "ORDER BY userID DESC";
            stm = con.prepareStatement(sql);
            rs = stm.executeQuery();
            
            if (rs != null)
                return rs.getString("userID");
        } finally {
            if (rs != null)
                rs.close();
            if (stm != null)
                stm.close();
        }
        return "";
    }
}
