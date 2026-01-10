package servlet;

import config.Koneksi;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONObject;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/update-status")
public class UpdateStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        res.setContentType("application/json");
        res.setCharacterEncoding("UTF-8");

        String idStr = req.getParameter("id");
        String status = req.getParameter("status");

        JSONObject response = new JSONObject();

        try {
            int id = Integer.parseInt(idStr);

            Connection conn = Koneksi.getConnection();
            String query = "UPDATE pesanan SET status = ? WHERE id_pesanan = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, status);
            ps.setInt(2, id);

            int result = ps.executeUpdate();
            ps.close();

            if (result > 0) {
                response.put("success", true);
                response.put("message", "Status berhasil diupdate");
            } else {
                response.put("success", false);
                response.put("message", "Gagal update status");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "Error: " + e.getMessage());
        }

        res.getWriter().write(response.toString());
    }
}
