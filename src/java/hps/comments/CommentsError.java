/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.comments;

import java.io.Serializable;

/**
 *
 * @author ADMIN
 */
public class CommentsError implements Serializable{
    private String rateOutOfBoundError;
    private String commentLengthError;
    private String ratedError;

    public CommentsError() {
    }

    /**
     * @return the rateOutOfBoundError
     */
    public String getRateOutOfBoundError() {
        return rateOutOfBoundError;
    }

    /**
     * @param rateOutOfBoundError the rateOutOfBoundError to set
     */
    public void setRateOutOfBoundError(String rateOutOfBoundError) {
        this.rateOutOfBoundError = rateOutOfBoundError;
    }

    /**
     * @return the commentLengthError
     */
    public String getCommentLengthError() {
        return commentLengthError;
    }

    /**
     * @param commentLengthError the commentLengthError to set
     */
    public void setCommentLengthError(String commentLengthError) {
        this.commentLengthError = commentLengthError;
    }

    /**
     * @return the ratedError
     */
    public String getRatedError() {
        return ratedError;
    }

    /**
     * @param ratedError the ratedError to set
     */
    public void setRatedError(String ratedError) {
        this.ratedError = ratedError;
    }
    
    
}
