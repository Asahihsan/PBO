package servlet;

import config.Koneksi;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String guest = req.getParameter("guest");

        // Login sebagai Guest
        if ("true".equals(guest)) {
            HttpSession session = req.getSession();
            User guestUser = new User(0, "Guest", null, "guest");
            session.setAttribute("user", guestUser);
            res.sendRedirect("menu");
            return;
        }

        // Login dengan email & password
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        try {
            Connection conn = Koneksi.getConnection();
            String query = "SELECT * FROM users WHERE email = ? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Login berhasil
                User user = new User();
                user.setId(rs.getInt("id_user"));
                user.setNama(rs.getString("nama"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));

                HttpSession session = req.getSession();
                session.setAttribute("user", user);

                // Redirect berdasarkan role
                if ("kasir".equals(user.getRole())) {
                    res.sendRedirect("dashboard-kasir.jsp");
                } else {
                    res.sendRedirect("menu");
                }
            } else {
                // Login gagal
                res.sendRedirect("login.jsp?error=invalid");
            }

            rs.close();
            ps.close();

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("login.jsp?error=invalid");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        res.sendRedirect("login.jsp");
    }
}
