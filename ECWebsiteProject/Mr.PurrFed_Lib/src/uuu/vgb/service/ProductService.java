package uuu.vgb.service;

import java.util.List;
import uuu.vgb.entity.Product;
import uuu.vgb.entity.VGBException;

public class ProductService {

    private ProductsDAO dao = new ProductsDAO();

    public List<Product> searchProducts(String search) throws VGBException {
        List<Product> list = dao.selectProducts(search);
        return list;
    }
     public Product getProductById(int id) throws VGBException {
        Product p = dao.selectProductById(id);
        return p;
    }

    public List<Product> searchProductsByCategory(String category,String... categoryArray) throws VGBException {
        return dao.selectProductsByCategory(category,categoryArray);
    }
    
    
}
