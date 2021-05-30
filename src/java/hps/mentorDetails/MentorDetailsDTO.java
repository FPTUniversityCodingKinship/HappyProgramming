/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.mentorDetails;

import java.io.Serializable;

/**
 *
 * @author ADMIN
 */
public class MentorDetailsDTO implements Serializable{
    private String mentorID;
    private String facebook;
    private String github;
    private String profession;
    private String language;
    private String introduction;
    private String serviceDescription;
    private String achievementDescription;

    public MentorDetailsDTO() {
    }

    public MentorDetailsDTO(String mentorID, String facebook, String github, String profession, String language, String introduction, String serviceDescription, String achievementDescription) {
        this.mentorID = mentorID;
        this.facebook = facebook;
        this.github = github;
        this.profession = profession;
        this.language = language;
        this.introduction = introduction;
        this.serviceDescription = serviceDescription;
        this.achievementDescription = achievementDescription;
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
     * @return the facebook
     */
    public String getFacebook() {
        return facebook;
    }

    /**
     * @param facebook the facebook to set
     */
    public void setFacebook(String facebook) {
        this.facebook = facebook;
    }

    /**
     * @return the github
     */
    public String getGithub() {
        return github;
    }

    /**
     * @param github the github to set
     */
    public void setGithub(String github) {
        this.github = github;
    }

    /**
     * @return the profession
     */
    public String getProfession() {
        return profession;
    }

    /**
     * @param profession the profession to set
     */
    public void setProfession(String profession) {
        this.profession = profession;
    }

    /**
     * @return the language
     */
    public String getLanguage() {
        return language;
    }

    /**
     * @param language the language to set
     */
    public void setLanguage(String language) {
        this.language = language;
    }

    /**
     * @return the introduction
     */
    public String getIntroduction() {
        return introduction;
    }

    /**
     * @param introduction the introduction to set
     */
    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }

    /**
     * @return the serviceDescription
     */
    public String getServiceDescription() {
        return serviceDescription;
    }

    /**
     * @param serviceDescription the serviceDescription to set
     */
    public void setServiceDescription(String serviceDescription) {
        this.serviceDescription = serviceDescription;
    }

    /**
     * @return the achievementDescription
     */
    public String getAchievementDescription() {
        return achievementDescription;
    }

    /**
     * @param achievementDescription the achievementDescription to set
     */
    public void setAchievementDescription(String achievementDescription) {
        this.achievementDescription = achievementDescription;
    }
    
    
}
