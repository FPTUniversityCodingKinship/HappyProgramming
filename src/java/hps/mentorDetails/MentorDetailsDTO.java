/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.mentorDetails;

import java.io.Serializable;

/**
 *
 * @author Tran Phong <phongntse150974@fpt.edu.vn>
 */
public class MentorDetailsDTO implements Serializable {
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

    public String getMentorID() {
        return mentorID;
    }

    public void setMentorID(String mentorID) {
        this.mentorID = mentorID;
    }

    public String getFacebook() {
        return facebook;
    }

    public void setFacebook(String facebook) {
        this.facebook = facebook;
    }

    public String getGithub() {
        return github;
    }

    public void setGithub(String github) {
        this.github = github;
    }

    public String getProfession() {
        return profession;
    }

    public void setProfession(String profession) {
        this.profession = profession;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }

    public String getServiceDescription() {
        return serviceDescription;
    }

    public void setServiceDescription(String serviceDescription) {
        this.serviceDescription = serviceDescription;
    }

    public String getAchievementDescription() {
        return achievementDescription;
    }

    public void setAchievementDescription(String achievementDescription) {
        this.achievementDescription = achievementDescription;
    }

}
