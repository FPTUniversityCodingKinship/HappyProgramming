/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.requests;

import java.io.Serializable;

/**
 *
 * @author ADMIN
 */
public class RequestError implements Serializable{
    private String mentorIDConflictError;
    private String contentLengthError;
    private String titleLengthError;
//    private String deadlineDateTimeError;
//    private String deadlineError;
    private String deadlineDateError;
    private String deadlineTimeError;
    private String ckbError;

    public RequestError() {
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
//    public String getDeadlineDateTimeError() {
//        return deadlineDateTimeError;
//    }
//
//    /**
//     * @param deadlineDateTimeError the deadlineDateTimeError to set
//     */
//    public void setDeadlineDateTimeError(String deadlineDateTimeError) {
//        this.deadlineDateTimeError = deadlineDateTimeError;
//    }
//
//    /**
//     * @return the deadlineError
//     */
//    public String getDeadlineError() {
//        return deadlineError;
//    }
//
//    /**
//     * @param deadlineError the deadlineError to set
//     */
//    public void setDeadlineError(String deadlineError) {
//        this.deadlineError = deadlineError;
//    }
    
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

    /**
     * @return the deadlineDateError
     */
    public String getDeadlineDateError() {
        return deadlineDateError;
    }

    /**
     * @param deadlineDateError the deadlineDateError to set
     */
    public void setDeadlineDateError(String deadlineDateError) {
        this.deadlineDateError = deadlineDateError;
    }

    /**
     * @return the deadlineTimeError
     */
    public String getDeadlineTimeError() {
        return deadlineTimeError;
    }

    /**
     * @param deadlineTimeError the deadlineTimeError to set
     */
    public void setDeadlineTimeError(String deadlineTimeError) {
        this.deadlineTimeError = deadlineTimeError;
    }

    
    
}
