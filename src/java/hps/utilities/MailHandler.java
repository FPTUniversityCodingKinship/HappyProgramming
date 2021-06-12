
package hps.utilities;

import hps.users.UsersDTO;
import hps.users.VerifyDTO;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Properties;
import java.util.Random;
import javax.mail.Authenticator;
import javax.mail.Message;
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
            Message mess = new MimeMessage(session);

            //set from email address
            mess.setFrom(new InternetAddress(fromEmail, "noreply@nowhere.com"));
            //set to email address or destination email address
            mess.setRecipient(Message.RecipientType.TO, 
                        new InternetAddress(toEmail));
            //set email subject
            mess.setSubject("User Email Verification");
            //set message text
            mess.setText(mailContent(verifier.getCode()));
            //send the message
            Transport.send(mess);
            //set succeed state
            state = true;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return state;
    }
    
    private static String mailContent(String code) { 
        return "Congratulations! You have successfully signed in to our system."
             + "Your Verify Code here: " + code;
    }
    
    private static String mailContentGraphic(String code) { 
        return
            "<html>\n" +
            "<head>\n" +
            "    <title>Verification Mail</title>\n" +
            "    <meta charset=\"UTF-8\">\n" +
            "    <meta name=\"viewport\" content=\"width=device-width, "
                            + "initial-scale=1.0\">\n" +
            "    <style>\n" +
            "        * {\n" +
            "            text-align: center;\n" +
            "            font-family: monospace;\n" +
            "        }\n" +
            "        h1 {\n" +
            "            text-transform: uppercase;\n" +
            "        }\n" +
            "        h2 {\n" +
            "            font-size: 32px;\n" +
            "        }\n" +
            "        table {\n" +
            "            width: 800px;\n" +
            "            height: 600px;\n" +
            "            float: left;\n" +
            "            margin: 10% 20%;\n" +
            "            background-color: beige;\n" +
            "        }\n" +
            "        tr:first-of-type {\n" +
            "            height: 100px;\n" +
            "            background-color: aquamarine;\n" +
            "        }\n" +
            "        tr:last-of-type {\n" +
            "            height: 100px;\n" +
            "            background-color: aliceblue;\n" +
            "        }\n" +
            "        .ads {\n" +
            "            width: 120px;\n" +
            "            background-color: burlywood;\n" +
            "        }\n" +
            "    </style>\n" +
            "</head>\n" +
            "<body>\n" +
            "<center>\n" +
            "    <table>\n" +
            "        <tr>\n" +
            "            <td colspan=\"3\">\n" +
            "                <h2>LO CMN GO</h2>\n" +
            "            </td>\n" +
            "        </tr>\n" +
            "        <tr>\n" +
            "            <td class=\"ads\">\n" +
            "                <h1>\n" +
            "                    Ads here\n" +
            "                </h1>\n" +
            "            </td>\n" +
            "            <td>\n" +
            "                <h3>\n" +
            "                    Thank you for signing up for Happy Programming System! ÒwÓ\n" +
            "                </h3>\n" +
            "                <p>\n" +
            "                    The entire team here at HPS does not welcome you aboard :)          <br/>\n" +
            "                    But your account is ready to go. All you need to do is Activate it. <br/>\n" +
            "                    By clicking the link below, you will be joined in our communication.<br/>\n" +
            "                </p>\n" +
            "            </td>\n" +
            "            <td class=\"ads\">\n" +
            "                <h1>\n" +
            "                    Ads here\n" +
            "                </h1>\n" +
            "            </td>\n" +
            "        </tr>\n" +
            "        <tr>\n" +
            "            <td colspan=\"3\">\n" + code +
            "            </td>\n" +
            "        </tr>\n" +
            "    </table>\n" +
            "</center>\n" +
            "</body>\n" +
            "</html>";
    }
}