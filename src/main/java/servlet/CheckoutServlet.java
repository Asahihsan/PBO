package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {

    // Konfigurasi PostgreSQL
    private static final String DB_URL = "jdbc:postgresql://localhost:5432/cafe_kopi";
    private static final String DB_USER = "postgres";
    private static final String DB_PASSWORD = "121334"; // Ganti dengan password PostgreSQL Anda

    private Connection getConnection() throws Exception {
        Class.forName("org.postgresql.Driver");
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println(">>> Servlet Checkout Berhasil Dipanggil!");

        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Baca data JSON dari request
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = request.getReader().readLine()) != null) {
                sb.append(line);
            }

            JSONObject jsonData = new JSONObject(sb.toString());

            // Ambil data dari JSON
            String customerName = jsonData.getString("name");
            String customerPhone = jsonData.getString("phone");
            String paymentMethod = jsonData.getString("payment");
            int totalAmount = (int) jsonData.getDouble("total");
            JSONArray items = jsonData.getJSONArray("items");

            // Simpan ke database
            Connection conn = getConnection();

            // Insert ke table pesanan - sesuai dengan struktur database Anda
            String sqlPesanan = "INSERT INTO pesanan (nama_pelanggan, total, tanggal, metode_pembayaran, no_telp, status) "
                    + "VALUES (?, ?, ?, ?, ?, ?) RETURNING id_pesanan";
            PreparedStatement psPesanan = conn.prepareStatement(sqlPesanan);

            psPesanan.setString(1, customerName);
            psPesanan.setInt(2, totalAmount);
            psPesanan.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
            psPesanan.setString(4, paymentMethod);
            psPesanan.setString(5, customerPhone);
            psPesanan.setString(6, "pending");

            // Eksekusi dan ambil ID yang baru dibuat
            ResultSet rs = psPesanan.executeQuery();
            int pesananId = 0;
            if (rs.next()) {
                pesananId = rs.getInt(1);
            }

            if (pesananId == 0) {
                throw new Exception("Gagal menyimpan pesanan.");
            }

            // Insert detail pesanan untuk setiap item
            String sqlDetail = "INSERT INTO detail_pesanan (id_pesanan, id_menu, jumlah, subtotal) VALUES (?, ?, ?, ?)";
            PreparedStatement psDetail = conn.prepareStatement(sqlDetail);

            for (int i = 0; i < items.length(); i++) {
                JSONObject item = items.getJSONObject(i);

                int menuId = item.getInt("id");
                int quantity = item.getInt("quantity");
                int price = item.getInt("price");
                int subtotal = quantity * price;

                psDetail.setInt(1, pesananId);
                psDetail.setInt(2, menuId);
                psDetail.setInt(3, quantity);
                psDetail.setInt(4, subtotal);
                psDetail.addBatch();
            }

            psDetail.executeBatch();

            // Close connections
            rs.close();
            psDetail.close();
            psPesanan.close();
            conn.close();

            // Kirim response sukses
            JSONObject responseJson = new JSONObject();
            responseJson.put("success", true);
            responseJson.put("message", "Pesanan berhasil disimpan");
            responseJson.put("orderId", pesananId);

            out.print(responseJson.toString());

        } catch (Exception e) {
            e.printStackTrace();
            JSONObject responseJson = new JSONObject();
            responseJson.put("success", false);
            responseJson.put("message", "Gagal menyimpan pesanan: " + e.getMessage());
            out.print(responseJson.toString());
        } finally {
            out.close();
        }
    }
}
