/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.users;

/**
 *
 * @author DELL
 */
public class UserUpdateError {

    private String usernameLengthError;
    private String passwordLengthError;
    private String fullnameLengthError;
    private String usernameAlreadyExistError;
    private String dateOfBirthInvalidError;

    public UserUpdateError() {
    }

    public UserUpdateError(String usernameLengthError, String passwordLengthError,
            String fullnameLengthError, String usernameAlreadyExistError,
            String dateOfBirthInvalidError) {
        this.usernameLengthError = usernameLengthError;
        this.passwordLengthError = passwordLengthError;
        this.fullnameLengthError = fullnameLengthError;
        this.usernameAlreadyExistError = usernameAlreadyExistError;
        this.dateOfBirthInvalidError = dateOfBirthInvalidError;
    }

    public String getUsernameLengthError() {
        return usernameLengthError;
    }

    public void setUsernameLengthError(String usernameLengthError) {
        this.usernameLengthError = usernameLengthError;
    }

    public String getPasswordLengthError() {
        return passwordLengthError;
    }

    public void setPasswordLengthError(String passwordLengthError) {
        this.passwordLengthError = passwordLengthError;
    }

    public String getFullnameLengthError() {
        return fullnameLengthError;
    }

    public void setFullnameLengthError(String fullnameLengthError) {
        this.fullnameLengthError = fullnameLengthError;
    }

    public String getUsernameAlreadyExistError() {
        return usernameAlreadyExistError;
    }

    public void setUsernameAlreadyExistError(String usernameAlreadyExistError) {
        this.usernameAlreadyExistError = usernameAlreadyExistError;
    }

    public String getDateOfBirthInvalidError() {
        return dateOfBirthInvalidError;
    }

    public void setDateOfBirthInvalidError(String dateOfBirthInvalidError) {
        this.dateOfBirthInvalidError = dateOfBirthInvalidError;
    }

}
