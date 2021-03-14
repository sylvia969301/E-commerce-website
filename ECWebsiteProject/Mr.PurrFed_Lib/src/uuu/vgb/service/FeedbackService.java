
package uuu.vgb.service;

import uuu.vgb.entity.Feedback;
import uuu.vgb.entity.VGBException;


public class FeedbackService {
    private FeedbackDAO dao = new FeedbackDAO();
    public void create(Feedback feedback)throws VGBException{
        dao.insert(feedback);
    }
}
