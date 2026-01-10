<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.sql.*, config.Koneksi, model.User" %>
<%
    // Cek apakah user sudah login dan role kasir
    User user = (User) session.getAttribute("user");
    if (user == null || !"kasir".equals(user.getRole())) {
        response.sendRedirect("login.jsp?error=required");
        return;
    }

    // Ambil semua pesanan dengan detail kategori
    List<Map<String, Object>> pesananList = new ArrayList<>();
    try {
        Connection conn = Koneksi.getConnection();
        String query = "SELECT p.*, "
                + "(SELECT COUNT(*) FROM detail_pesanan WHERE id_pesanan = p.id_pesanan) as jumlah_item, "
                + "(SELECT STRING_AGG(DISTINCT k.nama_kategori, ', ') "
                + " FROM detail_pesanan dp "
                + " JOIN menu m ON dp.id_menu = m.id_menu "
                + " JOIN kategori k ON dp.id_kategori = k.id_kategori "
                + " WHERE dp.id_pesanan = p.id_pesanan) as kategori_list "
                + "FROM pesanan p ORDER BY p.tanggal DESC";
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(query);

        while (rs.next()) {
            Map<String, Object> pesanan = new HashMap<>();
            pesanan.put("id", rs.getInt("id_pesanan"));
            pesanan.put("nama", rs.getString("nama_pelanggan"));
            pesanan.put("telp", rs.getString("no_telp"));
            pesanan.put("total", rs.getInt("total"));
            pesanan.put("metode", rs.getString("metode_pembayaran"));
            pesanan.put("status", rs.getString("status"));
            pesanan.put("tanggal", rs.getTimestamp("tanggal"));
            pesanan.put("jumlah_item", rs.getInt("jumlah_item")); 
            pesanan.put("kategori", rs.getString("kategori_list"));
            pesananList.add(pesanan);
        }

        rs.close();
        stmt.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="id">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard Kasir - Beans & Brew</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: #f5f5f5;
            }

            /* Navbar */
            nav {
                background: linear-gradient(135deg, #3e2723 0%, #5d4037 100%);
                padding: 1rem 5%;
                box-shadow: 0 2px 10px rgba(0,0,0,0.3);
                position: sticky;
                top: 0;
                z-index: 100;
            }

            nav .container {
                display: flex;
                justify-content: space-between;
                align-items: center;
                max-width: 1400px;
                margin: 0 auto;
            }

            .logo {
                font-size: 1.8rem;
                font-weight: bold;
                color: #fff;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .logo::before {
                content: "☕";
                font-size: 2rem;
            }

            .user-info {
                display: flex;
                align-items: center;
                gap: 1.5rem;
                color: white;
            }

            .welcome {
                font-size: 1.1rem;
            }

            .logout-btn {
                background: #ff6f00;
                color: white;
                border: none;
                padding: 0.7rem 1.5rem;
                border-radius: 50px;
                font-weight: bold;
                cursor: pointer;
                text-decoration: none;
                transition: all 0.3s;
            }

            .logout-btn:hover {
                background: #ff8f00;
                transform: translateY(-2px);
            }

            /* Main Content */
            .main-content {
                max-width: 1400px;
                margin: 0 auto;
                padding: 2rem 5%;
            }

            .page-header {
                margin-bottom: 2rem;
            }

            .page-header h1 {
                font-size: 2.5rem;
                color: #3e2723;
                margin-bottom: 0.5rem;
            }

            .page-header p {
                color: #666;
                font-size: 1.1rem;
            }

            /* Stats Cards */
            .stats-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 1.5rem;
                margin-bottom: 2rem;
            }

            .stat-card {
                background: white;
                padding: 1.5rem;
                border-radius: 15px;
                box-shadow: 0 3px 15px rgba(0,0,0,0.1);
                display: flex;
                align-items: center;
                gap: 1rem;
            }

            .stat-icon {
                font-size: 3rem;
            }

            .stat-info h3 {
                color: #666;
                font-size: 0.9rem;
                font-weight: normal;
                margin-bottom: 0.3rem;
            }

            .stat-info .stat-value {
                font-size: 2rem;
                font-weight: bold;
                color: #3e2723;
            }

            /* Filter Tabs */
            .filter-tabs {
                display: flex;
                gap: 1rem;
                margin-bottom: 2rem;
                flex-wrap: wrap;
            }

            .tab-btn {
                padding: 0.8rem 1.5rem;
                border: 2px solid #e0e0e0;
                background: white;
                border-radius: 50px;
                cursor: pointer;
                transition: all 0.3s;
                font-weight: bold;
            }

            .tab-btn.active {
                background: #ff6f00;
                color: white;
                border-color: #ff6f00;
            }

            .tab-btn:hover {
                border-color: #ff6f00;
            }

            /* Pesanan Table */
            .pesanan-container {
                background: white;
                border-radius: 15px;
                padding: 2rem;
                box-shadow: 0 3px 15px rgba(0,0,0,0.1);
            }

            .pesanan-table {
                width: 100%;
                border-collapse: collapse;
            }

            .pesanan-table thead {
                background: #f5f5f5;
            }

            .pesanan-table th {
                padding: 1rem;
                text-align: left;
                font-weight: bold;
                color: #3e2723;
            }

            .pesanan-table td {
                padding: 1rem;
                border-bottom: 1px solid #e0e0e0;
            }

            .pesanan-table tr:hover {
                background: #f9f9f9;
            }

            .status-badge {
                padding: 0.4rem 1rem;
                border-radius: 50px;
                font-size: 0.85rem;
                font-weight: bold;
                display: inline-block;
            }

            .status-pending {
                background: #fff3e0;
                color: #f57c00;
            }

            .status-progress {
                background: #e3f2fd;
                color: #1976d2;
            }

            .status-selesai {
                background: #e8f5e9;
                color: #388e3c;
            }

            .status-batal {
                background: #ffebee;
                color: #d32f2f;
            }

            .action-btn {
                padding: 0.5rem 1rem;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                font-weight: bold;
                margin-right: 0.5rem;
                transition: all 0.3s;
            }

            .btn-detail {
                background: #2196f3;
                color: white;
            }

            .btn-detail:hover {
                background: #1976d2;
            }

            .btn-progress {
                background: #ff9800;
                color: white;
            }

            .btn-progress:hover {
                background: #f57c00;
            }

            .btn-selesai {
                background: #4caf50;
                color: white;
            }

            .btn-selesai:hover {
                background: #388e3c;
            }

            .btn-batal {
                background: #f44336;
                color: white;
            }

            .btn-batal:hover {
                background: #d32f2f;
            }

            .empty-state {
                text-align: center;
                padding: 3rem;
                color: #999;
            }

            .empty-state-icon {
                font-size: 4rem;
                margin-bottom: 1rem;
            }

            /* Responsive */
            @media (max-width: 968px) {
                .pesanan-table {
                    display: block;
                    overflow-x: auto;
                }
            }
        </style>
    </head>
    <body>
        <!-- Navbar -->
        <nav>
            <div class="container">
                <div class="logo">Beans & Brew - Kasir</div>
                <div class="user-info">
                    <span class="welcome">👋 Halo, <%= user.getNama()%></span>
                    <a href="logout" class="logout-btn">Logout</a>
                </div>
            </div>
        </nav>

        <!-- Main Content -->
        <div class="main-content">
            <div class="page-header">
                <h1>Dashboard Kasir</h1>
                <p>Kelola pesanan pelanggan di sini</p>
            </div>

            <!-- Stats -->
            <div class="stats-grid">
                <%
                    int totalPesanan = pesananList.size();
                    int pending = 0, progress = 0, selesai = 0;
                    int totalPendapatan = 0;

                    for (Map<String, Object> p : pesananList) {
                        String status = (String) p.get("status");
                        if ("pending".equals(status)) {
                            pending++;
                        } else if ("progress".equals(status)) {
                            progress++;
                        } else if ("selesai".equals(status)) {
                            selesai++;
                            totalPendapatan += (Integer) p.get("total");
                        }
                    }
                %>
                <div class="stat-card">
                    <div class="stat-icon">📋</div>
                    <div class="stat-info">
                        <h3>Total Pesanan</h3>
                        <div class="stat-value"><%= totalPesanan%></div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">⏳</div>
                    <div class="stat-info">
                        <h3>Pending</h3>
                        <div class="stat-value"><%= pending%></div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">🔄</div>
                    <div class="stat-info">
                        <h3>Progress</h3>
                        <div class="stat-value"><%= progress%></div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">✅</div>
                    <div class="stat-info">
                        <h3>Selesai</h3>
                        <div class="stat-value"><%= selesai%></div>
                    </div>
                </div>
            </div>

            <!-- Filter Tabs -->
            <div class="filter-tabs">
                <button class="tab-btn active" onclick="filterStatus('all')">Semua (<%= totalPesanan%>)</button>
                <button class="tab-btn" onclick="filterStatus('pending')">Pending (<%= pending%>)</button>
                <button class="tab-btn" onclick="filterStatus('progress')">Progress (<%= progress%>)</button>
                <button class="tab-btn" onclick="filterStatus('selesai')">Selesai (<%= selesai%>)</button>
            </div>

            <!-- Pesanan Table -->
            <div class="pesanan-container">
                <% if (pesananList.isEmpty()) { %>
                <div class="empty-state">
                    <div class="empty-state-icon">📭</div>
                    <h3>Belum ada pesanan</h3>
                    <p>Pesanan akan muncul di sini</p>
                </div>
                <% } else { %>
                <table class="pesanan-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Pelanggan</th>
                            <th>Telepon</th>
                            <th>Item</th>
                            <th>Kategori</th>
                            <th>Total</th>
                            <th>Metode</th>
                            <th>Status</th>
                            <th>Aksi</th>
                        </tr>
                    </thead>
                    <tbody id="pesananTable">
                        <%
                            for (Map<String, Object> pesanan : pesananList) {
                                int id = (Integer) pesanan.get("id");
                                String nama = (String) pesanan.get("nama");
                                String telp = (String) pesanan.get("telp");
                                int total = (Integer) pesanan.get("total");
                                String metode = (String) pesanan.get("metode");
                                String status = (String) pesanan.get("status");
                                int jumlahItem = (Integer) pesanan.get("jumlah_item");
                                String kategori = (String) pesanan.get("kategori");

                                // Icon untuk kategori
                                String kategoriDisplay = "";
                                if (kategori != null) {
                                    if (kategori.contains("Panas") && kategori.contains("Dingin")) {
                                        kategoriDisplay = "🔥🧊 Mix";
                                    } else if (kategori.contains("Panas")) {
                                        kategoriDisplay = "🔥 Panas";
                                    } else if (kategori.contains("Dingin")) {
                                        kategoriDisplay = "🧊 Dingin";
                                    }
                                }
                        %>
                        <tr data-status="<%= status%>">
                            <td>#<%= id%></td>
                            <td><%= nama%></td>
                            <td><%= telp%></td>
                            <td><%= jumlahItem%> item</td>
                            <td><%= kategoriDisplay%></td>
                            <td>Rp <%= String.format("%,d", total)%></td>
                            <td><%= metode%></td>
                            <td>
                                <span class="status-badge status-<%= status%>">
                                    <%= status.toUpperCase()%>
                                </span>
                            </td>
                            <td>
                                <% if ("pending".equals(status)) {%>
                                <button class="action-btn btn-progress" onclick="updateStatus(<%= id%>, 'progress')">
                                    Proses
                                </button>
                                <% } else if ("progress".equals(status)) {%>
                                <button class="action-btn btn-selesai" onclick="updateStatus(<%= id%>, 'selesai')">
                                    Selesai
                                </button>
                                <% } %>
                                <% if (!"selesai".equals(status) && !"batal".equals(status)) {%>
                                <button class="action-btn btn-batal" onclick="updateStatus(<%= id%>, 'batal')">
                                    Batal
                                </button>
                                <% } %>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <% }%>
            </div>
        </div>

        <script>
            function filterStatus(status) {
                const rows = document.querySelectorAll('#pesananTable tr');
                const tabs = document.querySelectorAll('.tab-btn');

                tabs.forEach(tab => tab.classList.remove('active'));
                event.target.classList.add('active');

                rows.forEach(row => {
                    if (status === 'all') {
                        row.style.display = '';
                    } else {
                        if (row.dataset.status === status) {
                            row.style.display = '';
                        } else {
                            row.style.display = 'none';
                        }
                    }
                });
            }

            function updateStatus(id, newStatus) {
                if (!confirm('Yakin ingin mengubah status pesanan ini?')) {
                    return;
                }

                fetch('update-status', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'id=' + id + '&status=' + newStatus
                })
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                alert('Status berhasil diupdate!');
                                location.reload();
                            } else {
                                alert('Gagal update status!');
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('Terjadi kesalahan!');
                        });
            }
        </script>
    </body>
</html>