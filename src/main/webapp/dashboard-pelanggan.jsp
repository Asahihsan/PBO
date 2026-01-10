<%-- 
    Document   : dashboard-pelanggan
    Created on : Jan 7, 2026, 11:20:46 AM
    Author     : kenas
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.sql.*, config.Koneksi, model.User" %>
<%
    // Cek apakah user sudah login
    User user = (User) session.getAttribute("user");
    if (user == null || "guest".equals(user.getRole())) {
        response.sendRedirect("login.jsp?error=required");
        return;
    }

    // Ambil pesanan user ini
    List<Map<String, Object>> pesananList = new ArrayList<>();
    try {
        Connection conn = Koneksi.getConnection();
        String query = "SELECT p.*, "
                + "(SELECT COUNT(*) FROM detail_pesanan WHERE id_pesanan = p.id_pesanan) as jumlah_item "
                + "FROM pesanan p WHERE p.id_user = ? ORDER BY p.tanggal DESC";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setInt(1, user.getId());
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Map<String, Object> pesanan = new HashMap<>();
            pesanan.put("id", rs.getInt("id_pesanan"));
            pesanan.put("total", rs.getInt("total"));
            pesanan.put("metode", rs.getString("metode_pembayaran"));
            pesanan.put("status", rs.getString("status"));
            pesanan.put("tanggal", rs.getTimestamp("tanggal"));
            pesanan.put("jumlah_item", rs.getInt("jumlah_item"));
            pesananList.add(pesanan);
        }

        rs.close();
        ps.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="id">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Riwayat Pesanan - Beans & Brew</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: #f5f5f5;
                color: #2c2c2c;
            }
        </style>
    </head>
    <body>
        <%@ include file="navbar-component.jsp" %>

        <div style="margin-top: 90px; padding: 2rem 5%; max-width: 1200px; margin-left: auto; margin-right: auto;">
            <h1 style="font-size: 2.5rem; color: #3e2723; margin-bottom: 2rem;">📋 Riwayat Pesanan</h1>

            <% if (pesananList.isEmpty()) { %>
            <div style="background: white; border-radius: 15px; padding: 4rem; text-align: center; box-shadow: 0 3px 15px rgba(0,0,0,0.1);">
                <div style="font-size: 4rem; margin-bottom: 1rem;">📭</div>
                <h3 style="color: #666; margin-bottom: 1rem;">Belum ada pesanan</h3>
                <p style="color: #999; margin-bottom: 2rem;">Mulai pesan kopi favoritmu sekarang!</p>
                <a href="menu" style="display: inline-block; background: #ff6f00; color: white; padding: 1rem 2rem; border-radius: 50px; text-decoration: none; font-weight: bold;">Lihat Menu</a>
            </div>
            <% } else { %>
            <div style="display: grid; gap: 1.5rem;">
                <%
                    for (Map<String, Object> pesanan : pesananList) {
                        int id = (Integer) pesanan.get("id");
                        int total = (Integer) pesanan.get("total");
                        String metode = (String) pesanan.get("metode");
                        String status = (String) pesanan.get("status");
                        Timestamp tanggal = (Timestamp) pesanan.get("tanggal");
                        int jumlahItem = (Integer) pesanan.get("jumlah_item");

                        String statusColor = "";
                        String statusBg = "";
                        if ("pending".equals(status)) {
                            statusBg = "#fff3e0";
                            statusColor = "#f57c00";
                        } else if ("progress".equals(status)) {
                            statusBg = "#e3f2fd";
                            statusColor = "#1976d2";
                        } else if ("selesai".equals(status)) {
                            statusBg = "#e8f5e9";
                            statusColor = "#388e3c";
                        } else {
                            statusBg = "#ffebee";
                            statusColor = "#d32f2f";
                        }
                %>
                <div style="background: white; border-radius: 15px; padding: 2rem; box-shadow: 0 3px 15px rgba(0,0,0,0.1);">
                    <div style="display: flex; justify-content: space-between; align-items: start; margin-bottom: 1.5rem;">
                        <div>
                            <h3 style="font-size: 1.5rem; color: #3e2723; margin-bottom: 0.5rem;">Pesanan #<%= id%></h3>
                            <p style="color: #999; font-size: 0.9rem;"><%= tanggal%></p>
                        </div>
                        <span style="background: <%= statusBg%>; color: <%= statusColor%>; padding: 0.5rem 1.5rem; border-radius: 50px; font-weight: bold; font-size: 0.9rem;">
                            <%= status.toUpperCase()%>
                        </span>
                    </div>

                    <div style="border-top: 2px solid #f0f0f0; padding-top: 1rem; display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem;">
                        <div>
                            <p style="color: #999; font-size: 0.9rem; margin-bottom: 0.3rem;">Jumlah Item</p>
                            <p style="font-weight: bold; font-size: 1.1rem;"><%= jumlahItem%> item</p>
                        </div>
                        <div>
                            <p style="color: #999; font-size: 0.9rem; margin-bottom: 0.3rem;">Total Bayar</p>
                            <p style="font-weight: bold; font-size: 1.3rem; color: #ff6f00;">Rp <%= String.format("%,d", total)%></p>
                        </div>
                        <div>
                            <p style="color: #999; font-size: 0.9rem; margin-bottom: 0.3rem;">Metode Pembayaran</p>
                            <p style="font-weight: bold; font-size: 1.1rem;"><%= metode%></p>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
            <% }%>
        </div>

        <footer style="background: #3e2723; color: white; text-align: center; padding: 2rem; margin-top: 3rem;">
            <p>&copy; 2024 Beans & Brew. All rights reserved. Made with ❤️ and ☕</p>
        </footer>

        <script>
            function updateCartBadge() {
                const cart = sessionStorage.getItem('cart');
                const cartArray = cart ? JSON.parse(cart) : [];
                const totalItems = cartArray.reduce((sum, item) => sum + item.quantity, 0);
                const badge = document.getElementById('cartBadge');
                if (badge) {
                    badge.textContent = totalItems;
                    badge.style.display = totalItems > 0 ? 'flex' : 'none';
                }
            }

            document.addEventListener('DOMContentLoaded', updateCartBadge);
        </script>
    </body>
</html>
