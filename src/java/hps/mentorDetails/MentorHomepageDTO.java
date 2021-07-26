/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.mentorDetails;

import java.io.Serializable;

/**
 *
 * @author Admin
 */
public class MentorHomepageDTO implements Serializable {
    private String mentorID;
    private String fullname;
    private String image;
    private String skills;

    public MentorHomepageDTO(String mentorID, String fullname, String image, String skills) {
        this.mentorID = mentorID;
        this.fullname = fullname;
        this.image = image;
        this.skills = skills;
    }

    public String getMentorID() {
        return mentorID;
    }

    public void setMentorID(String mentorID) {
        this.mentorID = mentorID;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getSkills() {
        return skills;
    }

    public void setSkills(String skills) {
        this.skills = skills;
    }
}
