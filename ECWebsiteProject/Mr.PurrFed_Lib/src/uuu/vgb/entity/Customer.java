package uuu.vgb.entity;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.Date;
import java.util.Objects;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Customer {

    private String email;//PKey,需用Regular Expression驗證檢查
    private int id;//PKey
    private String name;//必要
    private String password;//必要,長度6~20個字元
    private String address;//
    private String phone;//
    private char gender;//非必要，'M':男 'F':女
    private LocalDate birthday;//需要import java.time.LocalDate ,JDK 8開始才能使用此類別

    public Customer() {
    }

    public Customer(int id, String name, String password) throws VGBException {
        this.setId(id);
        this.setName(name);
        this.setPassword(password);
    }

    public Customer(int id, String name, String password, char gender, String email, String birthday) throws VGBException {
        this.email = email;
        this.id = id;
        this.name = name;
        this.password = password;
        this.gender = gender;
    }

    public void setId(int id) throws VGBException {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    //提供setName(...)讓其他類別的程式可以呼叫此方法來設定name的屬性值
    public void setName(String arg) throws VGBException {//做屬性的修改不用回傳值 使用void
        if (arg != null && arg.length() > 0) {
            name = arg;
        } else {
            throw new VGBException("必須填寫客戶姓名");
        }
    }

    //提供getName(...)讓其他類別可呼叫此方法來取得name的屬性值
    public String getName() {
        return name;
    }

    public int getAge() {//要回傳int值 
        int age = 0;
        if (getBirthday() != null) { //當客戶有填寫生日資料
            int thisYear = LocalDate.now().getYear();//取得現在的日期
            int birthYear = getBirthday().getYear();//取得客戶生日的那年
            age = thisYear - birthYear;
            return age;//回傳(今年-客戶出生年)即為客戶的年齡
        } else { //當客戶沒有填寫生日資料
            return 0;
        }
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) throws VGBException {
        if (email != null && email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            this.email = email;
        } else {
            throw new VGBException("email格式不正確，請重新輸入");
        }
    }

    public String getPassword() {
        return password;
    }
    public static final int PASSWORD_MIN_LENGTH = 6;
    public static final int PASSWORD_MAX_LENGTH = 20;

    public void setPassword(String password) throws VGBException {
        if (password != null && password.length() >= PASSWORD_MIN_LENGTH
                && password.length() <= PASSWORD_MAX_LENGTH) {
            this.password = password;
        } else {
            throw new VGBException("密碼格式不正確，密碼長度必須在6~20個字元");
        }
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public char getGender() {
        return gender;
    }

    public static final char MALE = 'M';
    public static final char FEMALE = 'F';

    public void setGender(char gender) throws VGBException {
        if (gender == MALE || gender == FEMALE) {
            this.gender = gender;
        } else {
            throw new VGBException("性別資料不正確");
        }
    }

    public LocalDate getBirthday() {
        return birthday;
    }

    public void setBirthday(LocalDate birthday) throws VGBException {
        if (birthday != null && birthday.isBefore(LocalDate.now())) {
            this.birthday = birthday;
        } else {
            throw new VGBException("客戶生日不正確,生日必須早於今天");
        }
    }

    public void setBirthday(String dateStr) throws VGBException {//多載方法 可以宣告多支同名的方法，只需參數不同
        try {
            LocalDate date = LocalDate.parse(dateStr);
            this.setBirthday(date);
        } catch (DateTimeParseException ex) {
            System.out.println("客戶日期格式或資料不正確:" + ex);
            throw new VGBException("客戶日期格式或資料不正確!", ex);
        }
    }

    public void setBirthday(int year, int month, int day) throws VGBException {//將生日封裝成setBirthday方法，以便檢查及維護 void不需回傳值
        //TODO:第十三章要來加Exception Handling
        LocalDate date = LocalDate.of(year, month, day);
        if (LocalDate.now().isAfter(date)) {
            this.setBirthday(date);
        }
    }

    @Override
    public String toString() {
        return this.getClass().getName() + "\n=============" + "\nemail=" + email
                + "\n編號=" + id
                + "\n名稱=" + name
                + "\n密碼=" + password
                + "\n地址=" + address
                + "\n電話=" + phone
                + "\n性別=" + gender
                + "\n生日=" + birthday
                + "\n=============";
    }

    @Override
    public int hashCode() {
        int hash = 3;
        hash = 59 * hash + Objects.hashCode(this.id);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {//一定要先做的檢查
            return true;
        }
        if (obj == null) {//一定要先做的檢查
            return false;
        }
//       if(this.getClass() !=  obj.getClass() ) 這樣寫會抓不到子類別 如Customer對上VIP
        if (!(obj instanceof Customer)) {//檢查obj是否為Customer類別 或是否是有繼承關係的子類別
            return false;
        }
        final Customer other = (Customer) obj;
//        if (! Objects.equals(this.id, other.id)) JDK 7以上才有此寫法
//        if(this.id==null || !this.id.equals(other.id)) 若JDK 6以下 必須用此方法比較
        if (!Objects.equals(this.id, other.id)) {
            return false;
        }
        return true;
    }

}
