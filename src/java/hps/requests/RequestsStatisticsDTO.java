/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.requests;

import java.io.Serializable;

/**
 *
 * @author Tran Phong <phongntse150974@fpt.edu.vn>
 */
public class RequestsStatisticsDTO implements Serializable {
    private int numAccepted;
    private int numRequests;
    private int numRejected;
    private float percentRejected;
    private float percentClosed;
    private float rate;

    public RequestsStatisticsDTO() {
    }

    public RequestsStatisticsDTO(int numAccepted, int numRequests, int numRejected, float percentRejected, float percentClosed, float rate) {
        this.numAccepted = numAccepted;
        this.numRequests = numRequests;
        this.numRejected = numRejected;
        this.percentRejected = percentRejected;
        this.percentClosed = percentClosed;
        this.rate = rate;
    }

    public int getNumAccepted() {
        return numAccepted;
    }

    public void setNumAccepted(int numAccepted) {
        this.numAccepted = numAccepted;
    }

    public int getNumRequests() {
        return numRequests;
    }

    public void setNumRequests(int numRequests) {
        this.numRequests = numRequests;
    }

    public int getNumRejected() {
        return numRejected;
    }

    public void setNumRejected(int numRejected) {
        this.numRejected = numRejected;
    }

    public String getPercentRejected() {
        return String.format("%.2f", percentRejected);
    }

    public void setPercentRejected(float percentRejected) {
        this.percentRejected = percentRejected;
    }

    public String getPercentClosed() {
        return String.format("%.2f", percentClosed);
    }

    public void setPercentClosed(float percentClosed) {
        this.percentClosed = percentClosed;
    }

    public String getRate() {
        return String.format("%.2f", rate);
    }

    public void setRate(float rate) {
        this.rate = rate;
    }

//    public float getPercentRejected() {
//        return percentRejected;
//    }
//
//    public float getPercentClosed() {
//        return percentClosed;
//    }
//
//    public float getRate() {
//        return rate;
//    }
    
    
}
