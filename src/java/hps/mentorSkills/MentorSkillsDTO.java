/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.mentorSkills;

import java.io.Serializable;

/**
 *
 * @author Tran Phong <phongntse150974@fpt.edu.vn>
 */
public class MentorSkillsDTO implements Serializable {
    private String mentorSkillID;
    private String mentorID;
    private String skillID;
    private int yearsExperience;
    private int rate;

    public MentorSkillsDTO() {
    }

    public MentorSkillsDTO(String mentorSkillID, String mentorID, String skillID, int yearsExperience, int rate) {
        this.mentorSkillID = mentorSkillID;
        this.mentorID = mentorID;
        this.skillID = skillID;
        this.yearsExperience = yearsExperience;
        this.rate = rate;
    }

    public String getMentorSkillID() {
        return mentorSkillID;
    }

    public void setMentorSkillID(String mentorSkillID) {
        this.mentorSkillID = mentorSkillID;
    }

    public String getMentorID() {
        return mentorID;
    }

    public void setMentorID(String mentorID) {
        this.mentorID = mentorID;
    }

    public String getSkillID() {
        return skillID;
    }

    public void setSkillID(String skillID) {
        this.skillID = skillID;
    }

    public int getYearsExperience() {
        return yearsExperience;
    }

    public void setYearsExperience(int yearsExperience) {
        this.yearsExperience = yearsExperience;
    }

    public int getRate() {
        return rate;
    }

    public void setRate(int rate) {
        this.rate = rate;
    }
    
    
}
