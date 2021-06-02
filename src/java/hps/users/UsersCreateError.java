
package hps.users;

/**
 *
 * @author Admin
 */
public class UsersCreateError {
    //register
    private String usernameLengthErr;
    private String emailInvalid;
    private String passwordLengthErr;
    private String confirmNotMatch;
    private String fullnameLengthErr;
    private String usernameIsExisted;
    private String phoneInvalid;
    private String addressInvalid;
    private String dobInvalid;
    
    //login
    private String loginInfoNotMatch;

    public UsersCreateError() {
        
    }

    /**
     * @return the usernameLengthErr
     */
    public String getUsernameLengthErr() {
        return usernameLengthErr;
    }

    /**
     * @param usernameLengthErr the usernameLengthErr to set
     */
    public void setUsernameLengthErr(String usernameLengthErr) {
        this.usernameLengthErr = usernameLengthErr;
    }

    /**
     * @return the emailInvalid
     */
    public String getEmailInvalid() {
        return emailInvalid;
    }

    /**
     * @param emailInvalid the emailInvalid to set
     */
    public void setEmailInvalid(String emailInvalid) {
        this.emailInvalid = emailInvalid;
    }

    /**
     * @return the passwordLengthErr
     */
    public String getPasswordLengthErr() {
        return passwordLengthErr;
    }

    /**
     * @param passwordLengthErr the passwordLengthErr to set
     */
    public void setPasswordLengthErr(String passwordLengthErr) {
        this.passwordLengthErr = passwordLengthErr;
    }

    /**
     * @return the confirmNotMatch
     */
    public String getConfirmNotMatch() {
        return confirmNotMatch;
    }

    /**
     * @param confirmNotMatch the confirmNotMatch to set
     */
    public void setConfirmNotMatch(String confirmNotMatch) {
        this.confirmNotMatch = confirmNotMatch;
    }

    /**
     * @return the fullnameLengthErr
     */
    public String getFullnameLengthErr() {
        return fullnameLengthErr;
    }

    /**
     * @param fullnameLengthErr the fullnameLengthErr to set
     */
    public void setFullnameLengthErr(String fullnameLengthErr) {
        this.fullnameLengthErr = fullnameLengthErr;
    }

    /**
     * @return the usernameIsExisted
     */
    public String getUsernameIsExisted() {
        return usernameIsExisted;
    }

    /**
     * @param usernameIsExisted the usernameIsExisted to set
     */
    public void setUsernameIsExisted(String usernameIsExisted) {
        this.usernameIsExisted = usernameIsExisted;
    }

    /**
     * @return the phoneInvalid
     */
    public String getPhoneInvalid() {
        return phoneInvalid;
    }

    /**
     * @param phoneInvalid the phoneInvalid to set
     */
    public void setPhoneInvalid(String phoneInvalid) {
        this.phoneInvalid = phoneInvalid;
    }

    /**
     * @return the addressInvalid
     */
    public String getAddressInvalid() {
        return addressInvalid;
    }

    /**
     * @param addressInvalid the addressInvalid to set
     */
    public void setAddressInvalid(String addressInvalid) {
        this.addressInvalid = addressInvalid;
    }

    /**
     * @return the dobInvalid
     */
    public String getDobInvalid() {
        return dobInvalid;
    }

    /**
     * @param dobInvalid the dobInvalid to set
     */
    public void setDobInvalid(String dobInvalid) {
        this.dobInvalid = dobInvalid;
    }

    /**
     * @return the loginInfoNotMatch
     */
    public String getLoginInfoNotMatch() {
        return loginInfoNotMatch;
    }

    /**
     * @param loginInfoNotMatch the loginInfoNotMatch to set
     */
    public void setLoginInfoNotMatch(String loginInfoNotMatch) {
        this.loginInfoNotMatch = loginInfoNotMatch;
    }
    
}
