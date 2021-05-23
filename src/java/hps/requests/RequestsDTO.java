/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.requests;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 *
 * @author Tran Phong <phongntse150974@fpt.edu.vn>
 */
public class RequestsDTO implements Serializable {
    private String requestID;
    private String menteeID;
    private String mentorID;
    private String skillsID;
    private Timestamp deadline;
    private String title;
    private String reqContent;
    private String status;
    private Timestamp openedTime;
    private Timestamp approvedTime;
    private Timestamp canceledTime;
    private Timestamp closedTime;

    public RequestsDTO() {
    }

    public RequestsDTO(String requestID, String menteeID, String mentorID, String skillsID, Timestamp deadline, String title, String content, String status, Timestamp openedTime, Timestamp approvedTime, Timestamp canceledTime, Timestamp closedTime) {
        this.requestID = requestID;
        this.menteeID = menteeID;
        this.mentorID = mentorID;
        this.skillsID = skillsID;
        this.deadline = deadline;
        this.title = title;
        this.reqContent = content;
        this.status = status;
        this.openedTime = openedTime;
        this.approvedTime = approvedTime;
        this.canceledTime = canceledTime;
        this.closedTime = closedTime;
    }

    public String getRequestID() {
        return requestID;
    }

    public void setRequestID(String requestID) {
        this.requestID = requestID;
    }

    public String getMenteeID() {
        return menteeID;
    }

    public void setMenteeID(String menteeID) {
        this.menteeID = menteeID;
    }

    public String getMentorID() {
        return mentorID;
    }

    public void setMentorID(String mentorID) {
        this.mentorID = mentorID;
    }

    public String getSkillsID() {
        return skillsID;
    }

    public void setSkillsID(String skillsID) {
        this.skillsID = skillsID;
    }

    public Timestamp getDeadline() {
        return deadline;
    }

    public void setDeadline(Timestamp deadline) {
        this.deadline = deadline;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getReqContent() {
        return reqContent;
    }

    public void setReqContent(String reqContent) {
        this.reqContent = reqContent;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getOpenedTime() {
        return openedTime;
    }

    public void setOpenedTime(Timestamp openedTime) {
        this.openedTime = openedTime;
    }

    public Timestamp getApprovedTime() {
        return approvedTime;
    }

    public void setApprovedTime(Timestamp approvedTime) {
        this.approvedTime = approvedTime;
    }

    public Timestamp getCanceledTime() {
        return canceledTime;
    }

    public void setCanceledTime(Timestamp canceledTime) {
        this.canceledTime = canceledTime;
    }

    public Timestamp getClosedTime() {
        return closedTime;
    }

    public void setClosedTime(Timestamp closedTime) {
        this.closedTime = closedTime;
    }
    
    
}
