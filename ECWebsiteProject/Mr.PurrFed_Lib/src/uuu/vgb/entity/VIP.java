package uuu.vgb.entity;

public class VIP extends Customer {

    private int discount = 10;// 10% off:打九折

    public VIP() {
    }

    public VIP(int id, String name, String password) throws VGBException {
        super(id, name, password);
    }

    public VIP(int id, String name, String password, char gender, String email, String birthday) throws VGBException {
        super(id, name, password, gender, email, birthday);
    }

    public VIP(int id, String name, String password, int discount) throws VGBException {
        super(id, name, password);
        this.discount = discount;
    }

    public int getDiscount() {
        return discount;
    }

    public void setDiscount(int discount) {
        this.discount = discount;
    }

    public String getDiscountString() {
        int discount = 100 - this.discount;
        if (discount % 10 != 0) {
            return discount + "折";
        } else {
            return discount / 10 + "折";
        }
    }

    @Override
    public String toString() {
        return super.toString() + "\nVIP折扣=" + getDiscountString();

    }

}
