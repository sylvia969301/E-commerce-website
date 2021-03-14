package uuu.vgb.entity;

public class Product {

    private int id;//必要，Pkey,auto-increment
    private String name;//必要
    private double unitPrice;//必要,定價 也是售價
    private String description;//必要
    private String photoURL;//必要
    private int stock = 10;//必要
    private String category;//產品分類(frozen,normal,seasoning,recipe,soap,toys)

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public Product() {
    }

    public Product(int id, String name, double unitPrice) {
        this.id = id;
        this.name = name;
        this.unitPrice = unitPrice;
    }

    public Product(int id, String name, double unitPrice, int stock) {
        this.id = id;
        this.name = name;
        this.unitPrice = unitPrice;
        this.stock = stock;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
//查詢定價(售價)

    public double getUnitPrice() {
        return unitPrice;
    }
//修改售價(定價)

    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPhotoURL() {
        return photoURL;
    }

    public void setPhotoURL(String photoURL) {
        if(photoURL!=null){
            photoURL = photoURL.replace("webp?source_format=", "");
        }        
        this.photoURL = photoURL;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    @Override
    public String toString() {
         return  "產品編號：" + id
                + ",\n名稱：" + this.name
                ;

    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (obj instanceof Product) {
            Product other = (Product) obj;
            return this.id == other.id;
//       return this.id==((Product)obj).id;
        } else {
            return false;
        }
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 97 * hash + this.id;
        return hash;
    }

}
