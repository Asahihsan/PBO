<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.sql.*, config.Koneksi, model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || "guest".equals(user.getRole())) {
        response.sendRedirect("login.jsp?error=required");
        return;
    }

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
        rs.close(); ps.close();
    } catch (Exception e) { e.printStackTrace(); }
%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders - Beans & Brew</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;600;700&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --primary: #2d1b14;
            --accent: #d4a373;
            --bg-body: #f8f9fa;
            --white: #ffffff;
            --text-main: #1a1a1a;
            --text-muted: #718096;
            --shadow: 0 10px 30px rgba(0,0,0,0.05);
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg-body);
            color: var(--text-main);
            line-height: 1.6;
        }

        .container {
            max-width: 1000px;
            margin: 120px auto 60px;
            padding: 0 20px;
        }

        .header-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
        }

        .header-section h1 {
            font-family: 'Playfair Display', serif;
            font-size: 2.5rem;
            color: var(--primary);
        }

        /* --- Empty State --- */
        .empty-state {
            background: var(--white);
            border-radius: 24px;
            padding: 80px 40px;
            text-align: center;
            box-shadow: var(--shadow);
        }
        .empty-state i { font-size: 4rem; color: var(--accent); opacity: 0.5; margin-bottom: 20px; }
        .empty-state h3 { font-size: 1.5rem; margin-bottom: 10px; }
        .btn-order {
            display: inline-block;
            background: var(--accent);
            color: white;
            padding: 14px 32px;
            border-radius: 100px;
            text-decoration: none;
            font-weight: 700;
            margin-top: 20px;
            transition: 0.3s;
        }
        .btn-order:hover { transform: translateY(-3px); box-shadow: 0 10px 20px rgba(212,163,115,0.3); }

        /* --- Order Card --- */
        .order-card {
            background: var(--white);
            border-radius: 20px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: var(--shadow);
            transition: 0.3s;
            border: 1px solid transparent;
        }
        .order-card:hover { border-color: var(--accent); transform: translateY(-2px); }

        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 20px;
            border-bottom: 1px dashed #edf2f7;
            margin-bottom: 20px;
        }

        .order-id { font-weight: 700; color: var(--primary); font-size: 1.1rem; }
        .order-date { color: var(--text-muted); font-size: 0.85rem; }

        .status-badge {
            padding: 6px 16px;
            border-radius: 100px;
            font-size: 0.75rem;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        /* Status Colors */
        .status-pending { background: #fffaf0; color: #d69e2e; }
        .status-progress { background: #ebf8ff; color: #3182ce; }
        .status-selesai { background: #f0fff4; color: #38a169; }
        .status-batal { background: #fff5f5; color: #e53e3e; }

        .order-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 20px;
        }

        .detail-item span {
            display: block;
            font-size: 0.8rem;
            color: var(--text-muted);
            margin-bottom: 4px;
        }
        .detail-item p { font-weight: 600; color: var(--primary); }

        .total-price { color: var(--accent) !important; font-size: 1.2rem !important; }

        footer {
            text-align: center;
            padding: 40px;
            color: var(--text-muted);
            font-size: 0.9rem;
        }

        @media (max-width: 768px) {
            .header-section { flex-direction: column; align-items: flex-start; gap: 10px; }
            .order-header { flex-direction: column; align-items: flex-start; gap: 10px; }
            .status-badge { align-self: flex-start; }
        }
    </style>
</head>
<body>

    <%@ include file="navbar-component.jsp" %>

    <div class="container">
        <div class="header-section">
            <div>
                <span style="color: var(--accent); font-weight: 700; text-transform: uppercase; font-size: 0.8rem; letter-spacing: 2px;">Dashboard</span>
                <h1>Riwayat Pesanan</h1>
            </div>
            <div style="text-align: right;">
                <p style="font-weight: 600;">Halo, <%= user.getNama() %>!</p>
                <p style="font-size: 0.85rem; color: var(--text-muted);">Cek status kopimu di sini.</p>
            </div>
        </div>

        <% if (pesananList.isEmpty()) { %>
            <div class="empty-state">
                <i class="fas fa-mug-hot"></i>
                <h3>Belum Ada Pesanan</h3>
                <p>Sepertinya kamu belum memesan apapun hari ini.</p>
                <a href="menu" class="btn-order">Pesan Sekarang</a>
            </div>
        <% } else { %>
            <div class="order-list">
                <%
                    for (Map<String, Object> pesanan : pesananList) {
                        int id = (Integer) pesanan.get("id");
                        int total = (Integer) pesanan.get("total");
                        String metode = (String) pesanan.get("metode");
                        String status = (String) pesanan.get("status").toString().toLowerCase();
                        Timestamp tanggal = (Timestamp) pesanan.get("tanggal");
                        int jumlahItem = (Integer) pesanan.get("jumlah_item");
                        
                        // Format tanggal yang lebih cantik
                        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd MMM yyyy, HH:mm");
                        String formattedDate = sdf.format(tanggal);
                %>
                <div class="order-card">
                    <div class="order-header">
                        <div>
                            <p class="order-id">#ORD-<%= id %></p>
                            <p class="order-date"><i class="far fa-calendar-alt" style="margin-right: 5px;"></i> <%= formattedDate %></p>
                        </div>
                        <span class="status-badge status-<%= status %>">
                            <%= status %>
                        </span>
                    </div>

                    <div class="order-details">
                        <div class="detail-item">
                            <span>Jumlah Menu</span>
                            <p><%= jumlahItem %> Item</p>
                        </div>
                        <div class="detail-item">
                            <span>Pembayaran</span>
                            <p><%= metode %></p>
                        </div>
                        <div class="detail-item">
                            <span>Total Tagihan</span>
                            <p class="total-price">Rp <%= String.format("%,d", total) %></p>
                        </div>
                        <div class="detail-item" style="text-align: right;">
                             <a href="detail-pesanan.jsp?id=<%= id %>" style="color: var(--accent); text-decoration: none; font-size: 0.9rem; font-weight: 700;">
                                Lihat Detail <i class="fas fa-chevron-right" style="font-size: 0.7rem; margin-left: 5px;"></i>
                             </a>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
        <% } %>
    </div>

    <footer>
        <p>&copy; 2024 Beans & Brew Coffee Roasters. All rights reserved.</p>
    </footer>

    <script>
        // Update Cart Badge from previous logic
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