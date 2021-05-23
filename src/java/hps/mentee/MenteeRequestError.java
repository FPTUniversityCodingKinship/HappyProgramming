/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.mentee;

import java.io.Serializable;

/**
 *
 * @author ADMIN
 */
public class MenteeRequestError implements Serializable{
    private String mentorIDConflictError;
    private String contentLengthError;
    private String titleLengthError;
    private String deadlineDateTimeError;
    private String deadlineError;
    private String ckbError;

    public MenteeRequestError() {
    }

    /**
     * @return the mentorIDConflictError
     */
    public String getMentorIDConflictError() {
        return mentorIDConflictError;
    }

    /**
     * @param mentorIDConflictError the mentorIDConflictError to set
     */
    public void setMentorIDConflictError(String mentorIDConflictError) {
        this.mentorIDConflictError = mentorIDConflictError;
    }

    /**
     * @return the contentLengthError
     */
    public String getContentLengthError() {
        return contentLengthError;
    }

    /**
     * @param contentLengthError the contentLengthError to set
     */
    public void setContentLengthError(String contentLengthError) {
        this.contentLengthError = contentLengthError;
    }

    /**
     * @return the titleLengthError
     */
    public String getTitleLengthError() {
        return titleLengthError;
    }

    /**
     * @param titleLengthError the titleLengthError to set
     */
    public void setTitleLengthError(String titleLengthError) {
        this.titleLengthError = titleLengthError;
    }

    /**
     * @return the deadlineDateTimeError
     */
    public String getDeadlineDateTimeError() {
        return deadlineDateTimeError;
    }

    /**
     * @param deadlineDateTimeError the deadlineDateTimeError to set
     */
    public void setDeadlineDateTimeError(String deadlineDateTimeError) {
        this.deadlineDateTimeError = deadlineDateTimeError;
    }

    /**
     * @return the deadlineError
     */
    public String getDeadlineError() {
        return deadlineError;
    }

    /**
     * @param deadlineError the deadlineError to set
     */
    public void setDeadlineError(String deadlineError) {
        this.deadlineError = deadlineError;
    }

    /**
     * @return the ckbError
     */
    public String getCkbError() {
        return ckbError;
    }

    /**
     * @param ckbError the ckbError to set
     */
    public void setCkbError(String ckbError) {
        this.ckbError = ckbError;
    }

    
    
}
