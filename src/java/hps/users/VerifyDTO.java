/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.users;

import java.io.Serializable;

/**
 *
 * @author Admin
 */
public class VerifyDTO implements Serializable {
    private String email;
    private String code;
    private String dateTime;

    public VerifyDTO(String email, String code, String dateTime) {
        this.email = email;
        this.code = code;
        this.dateTime = dateTime;
    }

    public VerifyDTO() {
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getDateTime() {
        return dateTime;
    }

    public void setDateTime(String dateTime) {
        this.dateTime = dateTime;
    }

    @Override
    public String toString() {
        return "[" + email + "]:[" + code + "]:[" + dateTime + "]";
    }
    
}
