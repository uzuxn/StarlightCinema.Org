//package Starlight.user.services;
//
//import com.twilio.Twilio;
//import com.twilio.rest.api.v2010.account.Message;
//import com.twilio.type.PhoneNumber;
//
//public class SMSService {
//    // Hardcoded credentials (Replace with your actual Twilio credentials)
//    private static final String ACCOUNT_SID = "AC6d1febf073b83cfa6e02f5003886a1f4";
//    private static final String AUTH_TOKEN = "e27ad4fc2f5b444559ec41ade2dc4f12";
//    private static final String TWILIO_PHONE_NUMBER = "+16202992659"; // Twilio phone number
//
//    static {
//        // Initialize Twilio
//        Twilio.init(ACCOUNT_SID, AUTH_TOKEN);
//    }
//
//    public static boolean sendSMS(String toPhoneNumber, String messageBody) {
//        try {
//            Message message = Message.creator(
//                    new PhoneNumber(toPhoneNumber),        // Recipient's phone number
//                    new PhoneNumber(TWILIO_PHONE_NUMBER), // Twilio phone number
//                    messageBody                           // Message body
//            ).create();
//
//            System.out.println("Message sent successfully. SID: " + message.getSid());
//            return true; // Indicate success
//        } catch (Exception e) {
//            System.err.println("Error sending SMS: " + e.getMessage());
//            return false; // Indicate failure
//        }
//    }
//}

//import org.apache.http.client.methods.CloseableHttpResponse;
//import org.apache.http.client.methods.HttpPost;
//import org.apache.http.entity.StringEntity;
//import org.apache.http.impl.client.CloseableHttpClient;
//import org.apache.http.impl.client.HttpClients;
//import org.apache.http.util.EntityUtils;
//
//public class SMSService {
//
//    private static final String API_KEY = "NTQ0NTMyNTA2ZDUzNmMzMzc3NzY1YTcxNDkzNzY3MzA="; // Replace with your Textlocal API key
//    private static final String SENDER_NAME = "STARLIGHT"; // Replace with your sender name
//
//    public boolean sendSms(String message, String phoneNumber) {
//        String url = "https://api.textlocal.in/send/";
//        try (CloseableHttpClient client = HttpClients.createDefault()) {
//            HttpPost post = new HttpPost(url);
//
//            String payload = String.format(
//                "apikey=%s&numbers=%s&sender=%s&message=%s",
//                API_KEY,
//                phoneNumber,
//                SENDER_NAME,
//                message
//            );
//
//            post.setHeader("Content-Type", "application/x-www-form-urlencoded");
//            post.setEntity(new StringEntity(payload));
//
//            try (CloseableHttpResponse response = client.execute(post)) {
//                String responseBody = EntityUtils.toString(response.getEntity());
//                System.out.println("Response: " + responseBody);
//                return response.getStatusLine().getStatusCode() == 200;
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return false;
//    }
//}
