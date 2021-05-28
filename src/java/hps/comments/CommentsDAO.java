/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.comments;

import hps.utilities.DBHelper;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import javax.naming.NamingException;

/**
 *
 * @author ADMIN
 */
public class CommentsDAO implements Serializable{
    public boolean addComment(String commentID, String menteeID, String mentorID, 
            int rate, String comments, String datetime) 
            throws NamingException, SQLException{
        Connection con = null;
        PreparedStatement stm = null;
        
        try{
            con = DBHelper.makeConnection();
            if(con != null){
                String sql = "Insert into comments "
                        + "Values(?,?,?,?,?,?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, commentID);
                stm.setString(2, menteeID);
                stm.setString(3, mentorID);
                stm.setInt(4, rate);
                stm.setString(5, comments);
                stm.setString(6, datetime);
                int row = stm.executeUpdate();
                if(row > 0){
                    return true;
                }
            }
        } finally{
            if(stm != null){
                stm.close();
            }
            if(con != null){
                con.close();
            }
        }
        return false;
    }
}
