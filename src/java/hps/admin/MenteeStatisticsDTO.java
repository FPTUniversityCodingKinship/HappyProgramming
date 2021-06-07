/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.admin;

import java.io.Serializable;

/**
 *
 * @author Tran Phong <phongntse150974@fpt.edu.vn>
 */
public class MenteeStatisticsDTO implements Serializable {
    //  Name of Mentee, accountname, Nummber of Mentor, Total hours of all request, Total of skills of all requests.
    private String menteeName;
    private String username;
    private String numMentor;
    private String requestTotalHour;
    private int totalSkills;

    public MenteeStatisticsDTO() {
    }

    public MenteeStatisticsDTO(String menteeName, String username, String numMentor, String requestTotalHour, int totalSkills) {
        this.menteeName = menteeName;
        this.username = username;
        this.numMentor = numMentor;
        this.requestTotalHour = requestTotalHour;
        this.totalSkills = totalSkills;
    }

    public String getMenteeName() {
        return menteeName;
    }

    public void setMenteeName(String menteeName) {
        this.menteeName = menteeName;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getNumMentor() {
        return numMentor;
    }

    public void setNumMentor(String numMentor) {
        this.numMentor = numMentor;
    }

    public String getRequestTotalHour() {
        return requestTotalHour;
    }

    public void setRequestTotalHour(String requestTotalHour) {
        this.requestTotalHour = requestTotalHour;
    }

    public int getTotalSkills() {
        return totalSkills;
    }

    public void setTotalSkills(int totalSkills) {
        this.totalSkills = totalSkills;
    }

    
}
