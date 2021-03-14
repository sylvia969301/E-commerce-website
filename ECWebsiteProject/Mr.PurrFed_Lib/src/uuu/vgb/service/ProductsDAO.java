package uuu.vgb.service;

import java.util.List;
import uuu.vgb.entity.Product;
import uuu.vgb.entity.VGBException;
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import uuu.vgb.entity.Outlet;

//將資料庫的程式另外寫進不同的class中(1.2步驟)
class ProductsDAO {

    private static final String SELECT_PRODUCTS_BY_CATEGORY = "SELECT id,name,unit_price,stock,"
            + "description,photo_url,class_type,discount,category FROM products WHERE category = ?";

    //依類別查詢商品selectProductsByCategory()
    public List<Product> selectProductsByCategory(String category, String... categoryArray ) throws VGBException {
        List<Product> list = new ArrayList<>();
        String sql = SELECT_PRODUCTS_BY_CATEGORY;
        if(categoryArray!=null && categoryArray.length>0){
            for(String cat:categoryArray){
                sql += " OR category=?";
            }
        }
        try (
                //1+2.載入Driver+建立資料庫連線
                Connection connection = RDBConnection.getConnection();
                //3.準備指令
                PreparedStatement pstmt = connection.prepareStatement(sql);) {
            //3.1傳入第一個category
            pstmt.setString(1, category);
            //3.2檢查有無兩個以上的category並以陣列型態傳入
            if(categoryArray!=null && categoryArray.length>0){
                for(int i=0;i<categoryArray.length;i++){
                    pstmt.setString(i+2, categoryArray[i]);
                }
            }
            //4.執行指令
            try (
                    ResultSet rs = pstmt.executeQuery();) {
                //5.處理rs(resultSet)
                while (rs.next()) {
                    Product p;
                    String classType = rs.getString("class_type");
                    String className = Product.class.getName();
                    if (classType != null && classType.length() > 0) {
                        className = className.replaceAll("Product", classType);
                    }
                    try {
                        p = (Product) Class.forName(className).newInstance();
                    } catch (Exception ex) {
                        p = new Product();
                    }
                    p.setId(rs.getInt("id"));
                    p.setName(rs.getString("name"));
                    p.setUnitPrice(rs.getDouble("unit_price"));
                    p.setStock(rs.getInt("stock"));
                    p.setDescription(rs.getString("description"));
                    p.setPhotoURL(rs.getString("photo_url"));
                    p.setCategory(rs.getString("category"));
                    if (p instanceof Outlet) {
                        ((Outlet) p).setDiscount(rs.getInt("discount"));
                    }
                    //將查詢結果加到集合中，前端才能查詢此集合並秀出給使用者看
                    list.add(p);
                }
            }
        } catch (SQLException ex) {
            //通知前端錯誤訊息
            throw new VGBException("By Category查詢產品資料失敗:", ex);
        }
        return list;
    }

    private static final String SELECT_ALL_PRODUCTS = "SELECT id,name,unit_price,stock,"
            + "description,photo_url,class_type,discount,category FROM products WHERE name LIKE ?";

    //查詢商品selectProducts()
    public List<Product> selectProducts(String search) throws VGBException {
        List<Product> list = new ArrayList<>();
        try (
                //1+2.載入Driver+建立資料庫連線
                Connection connection = RDBConnection.getConnection();
                //3.準備指令
                PreparedStatement pstmt = connection.prepareStatement(SELECT_ALL_PRODUCTS);) {
            //3.1傳入?的值
            pstmt.setString(1, '%' + search + '%');
            //4.執行指令
            try (
                    ResultSet rs = pstmt.executeQuery();) {
                //5.處理rs(resultSet)
                while (rs.next()) {
                    Product p;
                    String classType = rs.getString("class_type");
                    String className = Product.class.getName();
                    if (classType != null && classType.length() > 0) {
                        className = className.replaceAll("Product", classType);
                    }
                    try {
                        p = (Product) Class.forName(className).newInstance();
                    } catch (Exception ex) {
                        p = new Product();
                    }
                    p.setId(rs.getInt("id"));
                    p.setName(rs.getString("name"));
                    p.setUnitPrice(rs.getDouble("unit_price"));
                    p.setStock(rs.getInt("stock"));
                    p.setDescription(rs.getString("description"));
                    p.setPhotoURL(rs.getString("photo_url"));
                    p.setCategory(rs.getString("category"));
                    if (p instanceof Outlet) {
                        ((Outlet) p).setDiscount(rs.getInt("discount"));
                    }
                    //將查詢結果加到集合中，前端才能查詢此集合並秀出給使用者看
                    list.add(p);
                }
            }
        } catch (SQLException ex) {
            //通知前端錯誤訊息
            throw new VGBException("查詢產品資料失敗:", ex);
        }
        return list;
    }

    //用商品id查詢商品
    private static final String SELECT_PRODUCTS_BY_ID = "SELECT id,name,unit_price,stock,"
            + "description,photo_url,class_type,discount,category FROM products WHERE id = ?";

    public Product selectProductById(int id) throws VGBException {
        Product p = null;
        try (
                //1+2.載入Driver+建立資料庫連線
                Connection connection = RDBConnection.getConnection();
                //3.準備指令
                PreparedStatement pstmt = connection.prepareStatement(SELECT_PRODUCTS_BY_ID);) {
            //3.1傳入?的值
            pstmt.setInt(1, id);
            //4.執行指令
            try (
                    ResultSet rs = pstmt.executeQuery();) {
                //5.處理rs(resultSet)
                while (rs.next()) {

                    String classType = rs.getString("class_type");
                    String className = Product.class.getName();
                    if (classType != null && classType.length() > 0) {
                        className = className.replaceAll("Product", classType);
                    }
                    try {
                        p = (Product) Class.forName(className).newInstance();
                    } catch (Exception ex) {
                        p = new Product();
                    }
                    p.setId(rs.getInt("id"));
                    p.setName(rs.getString("name"));
                    p.setUnitPrice(rs.getDouble("unit_price"));
                    p.setStock(rs.getInt("stock"));
                    p.setDescription(rs.getString("description"));
                    p.setPhotoURL(rs.getString("photo_url"));
                    p.setCategory(rs.getString("category"));
                    if (p instanceof Outlet) {
                        ((Outlet) p).setDiscount(rs.getInt("discount"));
                    }
                }
                return p;
            }
        } catch (SQLException ex) {
            //通知前端錯誤訊息
            throw new VGBException("查詢產品資料失敗:", ex);
        }
    }

    //建立Product資料
    private static final String INSERT_PRODUCTS = "INSERT INTO products "
            + "(id, name,unit_price,stock,description,photo_url,class_type,discount) "
            + "VALUES (?,?,?,?,?,?,?,?)";

    public void insertProducts(Product p) throws VGBException {

        try (
                //1+2載入driver+建立資料庫連線
                Connection connection = RDBConnection.getConnection();
                //3.準備指令
                PreparedStatement pstmt = connection.prepareStatement(INSERT_PRODUCTS);) {

            //3.1傳入?的值
            pstmt.setInt(1, p.getId());
            pstmt.setString(2, p.getName());
            pstmt.setDouble(3, p.getUnitPrice());
            pstmt.setInt(4, p.getStock());
            pstmt.setString(5, p.getDescription());
            pstmt.setString(6, p.getPhotoURL());
            pstmt.setString(7, p.getClass().getSimpleName());
            if (p instanceof Outlet) {
                pstmt.setInt(8, ((Outlet) p).getDiscount());
            } else {
                pstmt.setInt(8, 0);
            }
            //4.執行指令(新增的動作要用.executeUpdate()
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            throw new VGBException("新增產品失敗:", ex);
        }
    }

    public static void main(String[] args) {
        try {
            //測試查詢商品 selectProducts()
            ProductsDAO dao = new ProductsDAO();
            List<Product> list = dao.selectProductsByCategory("recipe");
            System.out.println("list=" + list);
            //測試新增商品 insertProducts()
//            Product newInsert = new Product();
//            newInsert.setId(28);
//            newInsert.setName("好味貓漢堡 綜合口味 3件組 ");
//            newInsert.setUnitPrice(269);
//            newInsert.setStock(12);
//            newInsert.setDescription("三種口味一次滿足，堅持新鮮食材製作，營養均衡，給您的毛小孩最健康的呵護‧");
//            newInsert.setPhotoURL("https://shoplineimg.com/58a81a0d72fdc0ec2700333f/5ae44f0c10abb9af59008969/2000x.webp?source_format=jpg");
//            
//            dao.insertProducts(newInsert);
//            System.out.println("products=" + newInsert);
        } catch (VGBException ex) {
            Logger.getLogger(ProductsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

}
