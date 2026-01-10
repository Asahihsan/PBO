package servlet;

import config.Koneksi;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String nama = req.getParameter("nama");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        try {
            Connection conn = Koneksi.getConnection();

            // Cek apakah email sudah terdaftar
            String checkQuery = "SELECT COUNT(*) FROM users WHERE email = ?";
            PreparedStatement checkPs = conn.prepareStatement(checkQuery);
            checkPs.setString(1, email);
            var rs = checkPs.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                // Email sudah terdaftar
                res.sendRedirect("register.jsp?error=exists");
                rs.close();
                checkPs.close();
                return;
            }

            rs.close();
            checkPs.close();

            // Insert user baru dengan role 'pelanggan'
            String insertQuery = "INSERT INTO users (nama, email, password, role) VALUES (?, ?, ?, 'pelanggan')";
            PreparedStatement ps = conn.prepareStatement(insertQuery);
            ps.setString(1, nama);
            ps.setString(2, email);
            ps.setString(3, password);

            int result = ps.executeUpdate();
            ps.close();

            if (result > 0) {
                // Registrasi berhasil
                res.sendRedirect("register.jsp?success=true");
            } else {
                // Registrasi gagal
                res.sendRedirect("register.jsp?error=failed");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            res.sendRedirect("register.jsp?error=failed");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        res.sendRedirect("register.jsp");
    }
}
