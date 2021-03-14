
package uuu.vgb.test;

import uuu.vgb.entity.Feedback;
import uuu.vgb.entity.VGBException;

public class TestFeedback {
    public static void main(String[] args) throws VGBException {
        Feedback feedback = new Feedback();
        feedback.setUserEmail("n969301@gmail.com");
        feedback.setUserName("Sylva");
        feedback.setText("測試123");
        
        System.out.println("feedback = " + feedback);
    }
}
