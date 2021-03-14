
package uuu.vgb.entity;

public enum ShippingType {
  STORE("便利店取貨",60),HOME("送貨到府",100);
    
    private final String description;//中文名稱
    private final double fee;
//建立建構子(範圍設定成private)
    private ShippingType(String description) {//面交
//        this(description,0);
        this.description = description;
        this.fee=0;//面交不須負擔運費       
    }
    private ShippingType(String description, double fee) {
        this.description = description;
        this.fee = fee;
    }  
    public String getDesciption() {//中文名稱
        return description;
    }
    public double getFee() {
        return fee;
    }
    @Override
    public String toString() {
        return description +(fee>0 ? ","+fee+'元' : ""); //To change body of generated methods, choose Tools | Templates.
    }//三元運算子

    
    
}
