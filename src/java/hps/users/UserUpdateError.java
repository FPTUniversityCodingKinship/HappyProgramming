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
public class UserUpdateError extends UsersCreateError {

    private String dateOfBirthInvalidError;

    public UserUpdateError() {
        super();
    }

    public String getDateOfBirthInvalidError() {
        return dateOfBirthInvalidError;
    }

    public void setDateOfBirthInvalidError(String dateOfBirthInvalidError) {
        this.dateOfBirthInvalidError = dateOfBirthInvalidError;
    }

}
