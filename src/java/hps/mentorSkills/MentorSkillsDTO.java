/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.mentorSkills;

import java.io.Serializable;

/**
 *
 * @author ADMIN
 */
public class MentorSkillsDTO implements Serializable{
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


    
    /**
     * @return the mentorSkillID
     */

    public String getMentorSkillID() {
        return mentorSkillID;
    }


    /**
     * @param mentorSkillID the mentorSkillID to set
     */

    public void setMentorSkillID(String mentorSkillID) {
        this.mentorSkillID = mentorSkillID;
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
     * @return the skillID
     */

    public String getSkillID() {
        return skillID;
    }


    /**
     * @param skillID the skillID to set
     */

    public void setSkillID(String skillID) {
        this.skillID = skillID;
    }


    /**
     * @return the yearsExperience
     */

    public int getYearsExperience() {
        return yearsExperience;
    }


    /**
     * @param yearsExperience the yearsExperience to set
     */

    public void setYearsExperience(int yearsExperience) {
        this.yearsExperience = yearsExperience;
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
    
    
}
