/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.comments;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 *
 * @author ADMIN
 */
public class CommentsDTO implements Serializable{
    private String commentID;
    private String menteeID;
    private String mentorID;
    private int rate;
    private String comments;
    private Timestamp timestamp;

    public CommentsDTO() {
    }

    public CommentsDTO(String commentID, String menteeID, String mentorID, int rate, String comments, Timestamp timestamp) {
        this.commentID = commentID;
        this.menteeID = menteeID;
        this.mentorID = mentorID;
        this.rate = rate;
        this.comments = comments;
        this.timestamp = timestamp;
    }

    /**
     * @return the commentID
     */
    public String getCommentID() {
        return commentID;
    }

    /**
     * @param commentID the commentID to set
     */
    public void setCommentID(String commentID) {
        this.commentID = commentID;
    }

    /**
     * @return the menteeID
     */
    public String getMenteeID() {
        return menteeID;
    }

    /**
     * @param menteeID the menteeID to set
     */
    public void setMenteeID(String menteeID) {
        this.menteeID = menteeID;
    }

    /**
     * @return the mentorID
     */
    public String getMentorID() {
        return mentorID;
    }

    /**
     * @param mentorID the mentorID to set
     */
    public void setMentorID(String mentorID) {
        this.mentorID = mentorID;
    }

    /**
     * @return the rate
     */
    public int getRate() {
        return rate;
    }

    /**
     * @param rate the rate to set
     */
    public void setRate(int rate) {
        this.rate = rate;
    }

    /**
     * @return the comments
     */
    public String getComments() {
        return comments;
    }

    /**
     * @param comments the comments to set
     */
    public void setComments(String comments) {
        this.comments = comments;
    }

    /**
     * @return the timestamp
     */
    public Timestamp getTimestamp() {
        return timestamp;
    }

    /**
     * @param timestamp the timestamp to set
     */
    public void setTimestamp(Timestamp timestamp) {
        this.timestamp = timestamp;
    }
    
    
}
