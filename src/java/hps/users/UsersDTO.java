/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.users;

import java.io.Serializable;
import java.util.Date;

/**
 *
 * @author DELL
 */
public class UsersDTO implements Serializable{
    private String userID;
    private String username;
    private String email;
    private String password;
    private String fullname;
    private String phone;
    private String address;
    private Date dob;
    private String sex;
    private String image;
    private boolean status;
    private boolean emailStatus;

    public UsersDTO() {
    }


    public UsersDTO(String userID, String username, String email, String password, String fullname, String phone, String address, Date dob, String sex, String image, boolean status) {
        this.userID = userID;
        this.username = username;
        this.email = email;
        this.password = password;
        this.fullname = fullname;
        this.phone = phone;
        this.address = address;
        this.dob = dob;
        this.sex = sex;
        this.image = image;
        this.status = status;
    }

    public UsersDTO(String userID, String username, String email, String password, String fullname, String phone, String address, Date dob, String sex, String image, boolean status, boolean emailStatus) {
        this.userID = userID;
        this.username = username;
        this.email = email;
        this.password = password;
        this.fullname = fullname;
        this.phone = phone;
        this.address = address;
        this.dob = dob;
        this.sex = sex;
        this.image = image;
        this.status = status;
        this.emailStatus = emailStatus;
    }
    

    

    /**
     * @return the userID
     */
    public String getUserID() {
        return userID;
    }

    /**
     * @param userID the userID to set
     */
    public void setUserID(String userID) {
        this.userID = userID;
    }

    /**
     * @return the username
     */
    public String getUsername() {
        return username;
    }

    /**
     * @param username the username to set
     */
    public void setUsername(String username) {
        this.username = username;
    }

    /**
     * @return the email
     */
    public String getEmail() {
        return email;
    }

    /**
     * @param email the email to set
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * @return the password
     */
    public String getPassword() {
        return password;
    }

    /**
     * @param password the password to set
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * @return the fullname
     */
    public String getFullname() {
        return fullname;
    }

    /**
     * @param fullname the fullname to set
     */
    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    /**
     * @return the phone
     */
    public String getPhone() {
        return phone;
    }

    /**
     * @param phone the phone to set
     */
    public void setPhone(String phone) {
        this.phone = phone;
    }

    /**
     * @return the address
     */
    public String getAddress() {
        return address;
    }

    /**
     * @param address the address to set
     */
    public void setAddress(String address) {
        this.address = address;
    }

    /**
     * @return the dob
     */
    public Date getDob() {
        return dob;
    }

    /**
     * @param dob the dob to set
     */
    public void setDob(Date dob) {
        this.dob = dob;
    }

    /**
     * @return the sex
     */
    public String getSex() {
        return sex;
    }

    /**
     * @param sex the sex to set
     */
    public void setSex(String sex) {
        this.sex = sex;
    }

    /**

     * @return the image

     */
    public String getImage() {
        return image;
    }

    /**
     * @param image the image to set
     */
    public void setImage(String image) {
        this.image = image;
    }
  
    /**
     * @return the status
     */
    public boolean isStatus() {
        return status;
    }

    /**
     * @param status the status to set
     */
    public void setStatus(boolean status) {
        this.status = status;
    }

    /**
     *
     * @return email is confirmed or not
     */
    public boolean isEmailStatus() {
        return emailStatus;
    }

    /**
     * @param emailStatus the emailStatus to set
     */
    public void setEmailStatus(boolean emailStatus) {
        this.emailStatus = emailStatus;
    }

    @Override
    public String toString() {
        return "UsersDTO{" + "userID = " + userID + ", username=" + username + ", password=" + password + 
                ", email=" + email + ", fullname=" + fullname + ", phone=" + phone + 
                ", address=" + address + ", dob=" + dob + ", sex=" + sex +  ", status=" + status + ", emailStatus = " + emailStatus + "}";

    }

    
}
