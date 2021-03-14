package uuu.vgb.entity;
//付款方式
public enum PaymentType {
    //因為付款方式沒有無參數建構式，故建立時要先給參數(enum陣列每個都是物件)
    ATM("ATM轉帳", ShippingType.HOME, ShippingType.STORE),
    HOME("貨到付款", 50, ShippingType.HOME),
    STORE("便利店取貨付款", ShippingType.STORE),
    CARD("信用卡", ShippingType.HOME, ShippingType.STORE);

   
    private final String description;
    private final double fee;
    private final ShippingType[] shippingTypeArray;

    private PaymentType(String description, ShippingType... shippingTypeArray) {//"..."可變動參數(要宣告在最後一個)
        this(description, 0,shippingTypeArray);
    }

    private PaymentType(String description, double fee, ShippingType... shippingTypeArray) {
        this.description = description;
        this.fee = fee;
        this.shippingTypeArray = shippingTypeArray;
    }

    public String getDescription() {
        return description;
    }

    public double getFee() {
        return fee;
    }
    public ShippingType[] getShippingTypeArray() {
        return shippingTypeArray;
    }
    @Override
    public String toString() {
        return description + (fee == 0 ? "" : ", 運費:" + fee+"元");
    }

}
