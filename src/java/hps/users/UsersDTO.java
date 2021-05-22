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
public class UsersDTO implements Serializable {
    private String userID;
    private String username;
    private String password;
    private String email;
    private String fullname;
    private String phone;
    private String address;
    private Date dob;
    private String sex;
    // image
    private String image;
//    private String roleID;
    private boolean status;
    //email status
    private boolean emailStatus;

    public UsersDTO() {
    }

    public UsersDTO(String userID, String username, String password, String email, String fullname, String phone, String address, Date dob, String sex, String image, boolean status, boolean emailStatus) {
        this.userID = userID;
        this.username = username;
        this.password = password;
        this.email = email;
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
     * @return userID
     */
    public String getUserID() {
        return userID;
    }

    /**
     *
     * @param userID the user ID to set
     */
    public void setUserID(String userID) {
        this.userID = userID;
    }

    /**
     *
     * @return image url
     */
    public String getImage() {
        return image;
    }

    /**
     *
     * @param image image url to set
     */
    public void setImage(String image) {
        this.image = image;
    }

    /**
     *
     * @return email is confirmed or not
     */
    public boolean isEmailStatus() {
        return emailStatus;
    }

    /**
     *
     * @param emailStatus is confirmed or not
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
