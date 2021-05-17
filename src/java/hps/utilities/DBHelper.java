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

}
