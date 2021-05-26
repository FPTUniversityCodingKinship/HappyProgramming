/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.validation;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;

/**
 *
 * @author ADMIN
 */
public class Validation implements Serializable{
    //https://github.com/yukiakira269/java-validation/blob/master/Validation.java
    public static boolean isLeapYear(int year) {
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.YEAR, year);
        return cal.getActualMaximum(Calendar.DAY_OF_YEAR) > 365;
    }
    //https://github.com/yukiakira269/java-validation/blob/master/Validation.java
    public static boolean has31Days(int month) {
        switch (month) {
            case 4:
            case 6:
            case 9:
            case 10:
                return false;
            default:
                return true;
        }
    }
    //https://github.com/yukiakira269/java-validation/blob/master/Validation.java
    public static boolean IsValidDate(int year, int month, int day) {
        if (month == 2 && day <= 28 && !isLeapYear(year) && month >= 1 && day >= 1 && year >= 0) {
            return true;
        } else if (month == 2 && day <= 29 && isLeapYear(year) && month >= 1 && day >= 1 && year >= 0) {
            return true;
        } else if (month != 2 && has31Days(month) && day <= 31 && month >= 1 && day >= 1 && year >= 0) {
            return true;
        } else if (month != 2 && !has31Days(month) && day <= 30 && month >= 1 && day >= 1 && year >= 0) {
            return true;
        } else {
            return false;
        }
    }
    
    public static boolean validDate(String deadlineDate) throws Exception{
        String[] str = deadlineDate.replace(" ", "").split("-");
        if(str.length > 3) {
            throw new Exception("Exceed 3");
        }
        int year = Integer.parseInt(str[0]);
        int month = Integer.parseInt(str[1]);
        int day = Integer.parseInt(str[2]);
        boolean result = IsValidDate(year, month, day);
        if(!result){
            throw new Exception("Not valid date");
        }
        LocalDate now = LocalDate.now();
        int currentYear = now.getYear();
        int currentMonth = now.getMonthValue();
        int currentDay = now.getDayOfMonth();
        if(currentYear > year){
            throw new Exception("Overdue deadline year");
        }else if(currentYear == year){
            if(currentMonth > month){
                throw new Exception("Overdue deadline month");
            }else if(currentMonth == month){
                if(currentDay > day){
                    throw new Exception("Overdue deadline day");
                }
            }
        }
        return true;
    }
    
    public static boolean validTime(String deadlineHour) throws Exception{
        String[] str = deadlineHour.replace(" ", "").split(":");
        if(str.length > 2) {
            throw new Exception("Exceed 2");
        }
        int hour = Integer.parseInt(str[0]);
        int minute = Integer.parseInt(str[1]);
        boolean check = false;
        for(int i=0; i<=23; i++){
            if(hour == i) check = true;
        }
        if(!check){
            throw new Exception("Not valid hour");
        }
        check = false;
        for(int i=0; i<=60; i++){
            if(minute == i) check = true;
        }
        if(!check){
            throw new Exception("Not valid minute");
        }
        
        return true;
    }
}
