
package uuu.vgb.entity;

public class Feedback {
   
    private String userEmail;//PKey
    private String userName;
    private String text;

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String user_email)throws VGBException {
         if (user_email != null && user_email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            this.userEmail = user_email;
        } else {
            throw new VGBException("email格式不正確，請重新輸入");
        }
    }

    public String getUserName() {
        return userName;
    }

    @Override
    public String toString() {
        return "Feedback{" + "使用者Email=" + userEmail + ", 使用者姓名=" + userName + ", 內容=" + text + '}';
    }

    public void setUserName(String user_name) {
        this.userName = user_name;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }
}
