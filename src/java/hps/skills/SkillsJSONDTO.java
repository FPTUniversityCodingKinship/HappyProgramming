/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.skills;

import java.io.Serializable;

/**
 *
 * @author Tran Phong <phongntse150974@fpt.edu.vn>
 */
public class SkillsJSONDTO implements Serializable {
    private String skillID;
    private int yearsExperience;
    private int rate;

    public SkillsJSONDTO() {
    }

    public SkillsJSONDTO(String skillID, int yearExperience, int rate) {
        this.skillID = skillID;
        this.yearsExperience = yearExperience;
        this.rate = rate;
    }
    
    public SkillsJSONDTO(String skillID, String yearExperience, String rate) {
        this.skillID = skillID;
        this.yearsExperience = Integer.parseInt(yearExperience);
        this.rate = Integer.parseInt(rate);
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
    public void setYearsExperience(String yearsExperience) {
        this.yearsExperience = Integer.parseInt(yearsExperience);
    }

    public int getRate() {
        return rate;
    }

    public void setRate(int rate) {
        this.rate = rate;
    }
    public void setRate(String rate) {
        this.rate = Integer.parseInt(rate);
    }
    
    
}
