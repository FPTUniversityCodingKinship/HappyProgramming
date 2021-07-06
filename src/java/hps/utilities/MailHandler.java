
package hps.utilities;

import hps.users.UsersDTO;
import hps.verify.VerifyDTO;
import java.io.UnsupportedEncodingException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Properties;
import java.util.Random;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MailHandler {
    private final String hostUsername = "fptucodingkinship.hps.noreply@gmail.com";
    private final String appPassword = "alkqtoyshbajeyls";
    
    //generate vrification code
    public String getVerifyCode() {
        Random rnd = new Random();
        int number = rnd.nextInt(999999);
        return String.format("%06d", number);
    }
    public String getCurrentDateTime() {    
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
        LocalDateTime now = LocalDateTime.now();  
        return dtf.format(now);
    }

    //send email to the user email
    public boolean sendEmail(VerifyDTO verifier) {
        boolean state = false;
        
        String toEmail = verifier.getEmail();
        String fromEmail = hostUsername;
        String password = appPassword;
        
        try {
            // your host email smtp server details
            Properties pr = new Properties();
            pr.setProperty("mail.smtp.host", "smtp.gmail.com");
            pr.setProperty("mail.smtp.port", "587");
            pr.setProperty("mail.smtp.auth", "true");
            pr.setProperty("mail.smtp.starttls.enable", "true");
            //pr.put("mail.smtp.socketFactory.port", "587");
            //pr.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
 
            //get session to authenticate the host email address and password
            Session session = Session.getInstance(pr, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(fromEmail, password);
                }
            });

            //set email message details
            Message msg = new MimeMessage(session);

            //set from email address
            msg.setFrom(new InternetAddress(fromEmail, "noreply@nowhere.com"));
            //set to email address or destination email address
            msg.setRecipient(Message.RecipientType.TO, 
                        new InternetAddress(toEmail));
            //set email subject
            msg.setSubject("User's Email Verification for Happy Programming System");
            //set message text
            msg.setContent(mailContent(verifier.getCode()), "text/html");
            //send the message
            Transport.send(msg);
            //set succeed state
            state = true;
        } catch (UnsupportedEncodingException | MessagingException e) {
            e.printStackTrace();
        }

        return state;
    }
    
    private static String mailContent(String code) { 
        return
            "<p>\n" +
            "    Congratulations! You have successfully signed in to our system. <br/>\n" +
            "    To Verify your email:\n" +
            "    <a href=\"https://whjack-chanfong-marvellous-henryvo-h3ps91swp.netlify.app/?zAn2crx5C_AGSmmkGTRSP_ArxSl34=" + code + "\">\n" +
            "        CLICK HERE!\n" +
            "    </a>\n" +
            "</p>";
    }
}