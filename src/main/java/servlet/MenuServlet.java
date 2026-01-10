package servlet;

import config.Koneksi;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Menu;

@WebServlet("/menu")
public class MenuServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        List<Menu> list = new ArrayList<>();

        try {
            Connection c = Koneksi.getConnection();

            // Query dengan JOIN untuk ambil nama kategori
            String query = "SELECT m.id_menu, m.nama_menu, m.harga, m.gambar, m.id_kategori, k.nama_kategori "
                    + "FROM menu m "
                    + "JOIN kategori k ON m.id_kategori = k.id_kategori "
                    + "ORDER BY m.id_menu";

            ResultSet rs = c.createStatement().executeQuery(query);

            while (rs.next()) {
                Menu m = new Menu();
                m.setId(rs.getInt("id_menu"));
                m.setNama(rs.getString("nama_menu"));
                m.setHarga(rs.getInt("harga"));
                m.setGambar(rs.getString("gambar"));
                m.setIdKategori(rs.getInt("id_kategori"));
                m.setNamaKategori(rs.getString("nama_kategori"));
                list.add(m);
            }

            rs.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        req.setAttribute("menu", list);
        req.getRequestDispatcher("menu.jsp").forward(req, res);
    }
}
