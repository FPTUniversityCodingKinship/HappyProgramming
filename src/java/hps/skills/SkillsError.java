/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.skills;

import java.io.Serializable;

/**
 *
 * @author ADMIN
 */
public class SkillsError implements Serializable{
    private String skillNameNotFound;
    private String skillQuantityError;

    public SkillsError() {
    }

    /**
     * @return the skillNameNotFound
     */
    public String getSkillNameNotFound() {
        return skillNameNotFound;
    }

    /**
     * @param skillNameNotFound the skillNameNotFound to set
     */
    public void setSkillNameNotFound(String skillNameNotFound) {
        this.skillNameNotFound = skillNameNotFound;
    }

    /**
     * @return the skillQuantityError
     */
    public String getSkillQuantityError() {
        return skillQuantityError;
    }

    /**
     * @param skillQuantityError the skillQuantityError to set
     */
    public void setSkillQuantityError(String skillQuantityError) {
        this.skillQuantityError = skillQuantityError;
    }
    
    
}
