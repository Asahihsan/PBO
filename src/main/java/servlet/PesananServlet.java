package servlet;

import config.Koneksi;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

@WebServlet("/checkout")
public class PesananServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        res.setContentType("application/json");
        res.setCharacterEncoding("UTF-8");

        try {
            // Baca JSON dari request body
            StringBuilder sb = new StringBuilder();
            BufferedReader reader = req.getReader();
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }

            JSONObject jsonData = new JSONObject(sb.toString());

            String nama = jsonData.getString("nama");
            String telp = jsonData.getString("telp");
            String metode = jsonData.getString("metode");
            double total = jsonData.getDouble("total");
            JSONArray cart = jsonData.getJSONArray("cart");

            // Ambil user dari session (jika login)
            HttpSession session = req.getSession(false);
            User user = null;
            if (session != null) {
                user = (User) session.getAttribute("user");
            }

            Connection conn = Koneksi.getConnection();

            // 1. Insert ke table pesanan
            String queryPesanan = "INSERT INTO pesanan (id_user, nama_pelanggan, email_pelanggan, no_telp, total, metode_pembayaran, status) "
                    + "VALUES (?, ?, ?, ?, ?, ?, 'pending')";

            PreparedStatement psPesanan = conn.prepareStatement(queryPesanan, Statement.RETURN_GENERATED_KEYS);

            if (user != null && !"guest".equals(user.getRole())) {
                psPesanan.setInt(1, user.getId());
                psPesanan.setString(2, user.getNama());
                psPesanan.setString(3, user.getEmail());
            } else {
                psPesanan.setNull(1, java.sql.Types.INTEGER);
                psPesanan.setString(2, nama);
                psPesanan.setNull(3, java.sql.Types.VARCHAR);
            }

            psPesanan.setString(4, telp);
            psPesanan.setDouble(5, total);
            psPesanan.setString(6, metode);

            int result = psPesanan.executeUpdate();

            if (result > 0) {
                // Ambil id_pesanan yang baru di-insert
                ResultSet rs = psPesanan.getGeneratedKeys();
                int idPesanan = 0;
                if (rs.next()) {
                    idPesanan = rs.getInt(1);
                }
                rs.close();

                // 2. Insert ke table detail_pesanan
                String queryDetail = "INSERT INTO detail_pesanan (id_pesanan, id_menu, id_kategori, jumlah, subtotal) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement psDetail = conn.prepareStatement(queryDetail);

                for (int i = 0; i < cart.length(); i++) {
                    JSONObject item = cart.getJSONObject(i);
                    int idMenu = item.getInt("id");
                    int quantity = item.getInt("quantity");
                    double price = item.getDouble("price");
                    double subtotal = price * quantity;

                    // Ambil kategoriId dari item (default 1 = Dingin kalau tidak ada)
                    int kategoriId = item.optInt("kategoriId", 1);

                    psDetail.setInt(1, idPesanan);
                    psDetail.setInt(2, idMenu);
                    psDetail.setInt(3, kategoriId);
                    psDetail.setInt(4, quantity);
                    psDetail.setDouble(5, subtotal);
                    psDetail.addBatch();
                }

                psDetail.executeBatch();
                psDetail.close();

                // Response sukses
                JSONObject response = new JSONObject();
                response.put("success", true);
                response.put("message", "Pesanan berhasil dibuat");
                response.put("id_pesanan", idPesanan);

                res.getWriter().write(response.toString());
            } else {
                // Response gagal
                JSONObject response = new JSONObject();
                response.put("success", false);
                response.put("message", "Gagal membuat pesanan");

                res.getWriter().write(response.toString());
            }

            psPesanan.close();

        } catch (Exception e) {
            e.printStackTrace();

            JSONObject response = new JSONObject();
            response.put("success", false);
            response.put("message", "Error: " + e.getMessage());

            res.getWriter().write(response.toString());
        }
    }
}
