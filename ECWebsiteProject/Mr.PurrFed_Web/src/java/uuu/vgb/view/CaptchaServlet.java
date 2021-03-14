package uuu.vgb.view;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Random;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CaptchaServlet extends HttpServlet {

    private int len = 6, width = 16 * 2 + 12 * len, height = 35;

    @Override
    public void init() {
        String len = this.getInitParameter("len");
        if (len != null && len.matches("\\d+")) {// "\\d+"代表整數(regular expression)
            this.len = Integer.parseInt(len);
            width = 16 * 2 + 12 * this.len;
        }
    }

    private BufferedImage generateImage(String rand, int width, int height) {
        //開始建立圖片
        BufferedImage image
                = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics g = image.getGraphics();   //取得影像繪圖區
        //畫出背景方塊
        g.setColor(getRandomColor(200, 250)); //設定繪圖區背景色
        g.fillRect(0, 0, width, height);    //在繪圖區畫個長方型
        //畫干擾線讓背景雜亂
        Random random = new Random();
        g.setColor(getRandomColor(170, 210));
        for (int i = 0; i < 155; i++) {
            int x = random.nextInt(width);
            int y = random.nextInt(height);
            int xl = random.nextInt(12);
            int yl = random.nextInt(12);
            g.drawLine(x, y, x + xl, y + yl);
        }
        //畫出認證文字
        g.setFont(new Font("Arial", Font.PLAIN, 18));//設定字體
        g.setColor(getRandomColor(20, 140));
        //將認證文字畫到image中
        g.drawString(rand, 15, 25);
        g.dispose();
        return image;
    }

    private Color getRandomColor(int fc, int bc) {

        //在參數設定的範圍內，隨機產生顏色
        Random random = new Random();

        if (fc > 255) {
            fc = 255;
        }

        if (bc > 255) {
            bc = 255;
        }

        int r = fc + random.nextInt(bc - fc);

        int g = fc + random.nextInt(bc - fc);

        int b = fc + random.nextInt(bc - fc);

        return new Color(r, g, b);

    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //1.取得request中的資料(無)
        System.out.println("");
        //2.執行商業邏輯:用亂數產生len(6)個英數字的驗證碼
        String rand = "";
        Random r = new Random();
        for (int i = 0; i < len; i++) {
            int data = r.nextInt(35);//35個:0-9數字+A-Z大寫字母
            rand += (data < 10 ? (char) (data + '0') : (char) (data - 10 + 'A'));
        }
        //使用getServletName()(寫在web.xml中)登入及註冊的驗證碼就不會互相干擾
        request.getSession().setAttribute(getServletName(),rand);
        // 用generateImage方法將這個字串繪製為image
        BufferedImage image = generateImage(rand, width, height);
        //3.產生JPEG image的回應
        response.setContentType("image/jpeg");//HTTP的多媒體格式(MIME type)規定的
        try (OutputStream out = response.getOutputStream()) {//取得位元串流
            //將image以jpeg格式輸出到out
            ImageIO.write(image, "JPEG", out);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
