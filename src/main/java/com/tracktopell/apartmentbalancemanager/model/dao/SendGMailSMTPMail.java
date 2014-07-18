package com.tracktopell.apartmentbalancemanager.model.dao;

import com.tracktopell.util.Base64Coder;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendGMailSMTPMail {

    static String username = "apartmentbalancemanager@gmail.com",
        d_password = "nonex123",
        d_host = "smtp.gmail.com",
        d_port = "465",
        m_to = "",
        m_subject = "Confirmacion de cuenta",
        m_text = "Esta es la liga de confirmacion:";
    public static void sendVerificationEmail(final String sendTo,final String context) {
        new Thread(){

            @Override
            public void run() {
                sendVerificationEmailInThread(username, m_text);
            }
            
        }.start();
    }
    
    public static void sendVerificationEmailInThread(String sendTo, String context) {
        Properties props = new Properties();
        props.put("mail.smtp.user", username);
        props.put("mail.smtp.host", d_host);
        props.put("mail.smtp.port", d_port);
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.auth", "true");
        //props.put("mail.smtp.debug", "true");
        props.put("mail.smtp.socketFactory.port", d_port);
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.socketFactory.fallback", "false");

        SecurityManager security = System.getSecurityManager();

        try {
            Authenticator auth = new SMTPAuthenticator();
            Session session = Session.getInstance(props, auth);
            //session.setDebug(true);

            MimeMessage msg = new MimeMessage(session);
            
            String sm1  = "/vu/";
            String allParams = "email="+sendTo;
            String sm64 = new String(Base64Coder.encode(allParams.getBytes()));
            String smE  = sm1 + sm64;
            
            final String linkConfirmation = m_text + context + smE;
            System.out.println("->LinkConfirmation:["+linkConfirmation+"]");
            msg.setText(linkConfirmation);
            msg.setSubject(m_subject);
            msg.setFrom(new InternetAddress(username));
            msg.addRecipient(Message.RecipientType.TO, new InternetAddress(sendTo));
            Transport.send(msg);
        } catch (Exception mex) {
            mex.printStackTrace();
        }
    }

    public static void main(String[] args) {
        SendGMailSMTPMail blah = new SendGMailSMTPMail();
    }

    private static class SMTPAuthenticator extends javax.mail.Authenticator {

        public PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(username, d_password);
        }
    }
}
