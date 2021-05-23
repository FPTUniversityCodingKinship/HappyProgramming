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
public class SkillsDTO implements Serializable {
    private String skillID;
    private String skillName;
    private boolean status;

    public SkillsDTO() {
    }

    public SkillsDTO(String skillID, String skillName, boolean status) {
        this.skillID = skillID;
        this.skillName = skillName;
        this.status = status;
    }

    public String getSkillID() {
        return skillID;
    }

    public void setSkillID(String skillID) {
        this.skillID = skillID;
    }

    public String getSkillName() {
        return skillName;
    }

    public void setSkillName(String skillName) {
        this.skillName = skillName;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
    
    
}
