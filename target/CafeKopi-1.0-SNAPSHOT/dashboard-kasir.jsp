<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.sql.*, config.Koneksi, model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"kasir".equals(user.getRole())) {
        response.sendRedirect("login.jsp?error=required");
        return;
    }

    List<Map<String, Object>> pesananList = new ArrayList<>();
    try {
        Connection conn = Koneksi.getConnection();
        String query = "SELECT p.*, "
            + "(SELECT COUNT(*) FROM detail_pesanan WHERE id_pesanan = p.id_pesanan) as jumlah_item, "
            + "(SELECT STRING_AGG(DISTINCT k.nama_kategori, ', ') "
            + " FROM detail_pesanan dp "
            + " JOIN menu m ON dp.id_menu = m.id_menu "
            + " JOIN kategori k ON dp.id_kategori = k.id_kategori "
            + " WHERE dp.id_pesanan = p.id_pesanan) as kategori_list, "
            + "(SELECT STRING_AGG(m.nama_menu, ', ') "
            + " FROM detail_pesanan dp "
            + " JOIN menu m ON dp.id_menu = m.id_menu "
            + " WHERE dp.id_pesanan = p.id_pesanan) as menu_list "
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
            pesanan.put("menu_list", rs.getString("menu_list")); 
            pesanan.put("kategori", rs.getString("kategori_list"));
            pesananList.add(pesanan);
        }
        rs.close(); stmt.close();
    } catch (Exception e) { e.printStackTrace(); }
%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cashier Workspace - Beans & Brew</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --primary: #2d1b14;
            --accent: #d4a373;
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --info: #3b82f6;
            --bg-body: #f8fafc;
            --sidebar-width: 260px;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Inter', sans-serif; background: var(--bg-body); color: #1e293b; display: flex; min-height: 100vh; }

        /* Sidebar Navigation */
        .sidebar {
            width: var(--sidebar-width);
            background: var(--primary);
            color: white;
            padding: 2rem 1.5rem;
            position: fixed;
            height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .sidebar-brand { font-size: 1.5rem; font-weight: 700; margin-bottom: 3rem; display: flex; align-items: center; gap: 12px; }
        .nav-menu { list-style: none; flex-grow: 1; }
        .nav-item { margin-bottom: 0.5rem; }
        .nav-link { 
            display: flex; align-items: center; gap: 12px; padding: 12px 16px; 
            color: #a8a29e; text-decoration: none; border-radius: 12px; transition: 0.3s;
        }
        .nav-link.active { background: var(--accent); color: white; }
        .nav-link:hover:not(.active) { background: rgba(255,255,255,0.05); color: white; }

        /* Main Content Area */
        .main-wrapper { margin-left: var(--sidebar-width); width: calc(100% - var(--sidebar-width)); padding: 2rem 3rem; }

        .top-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 2.5rem; }
        .user-profile { display: flex; align-items: center; gap: 15px; background: white; padding: 8px 20px; border-radius: 50px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05); }

        .tooltip-container {
            position: relative;
            display: inline-block;
            cursor: pointer;
        }

        .tooltip-box {
            visibility: hidden;
            opacity: 0;
            width: 220px;
            background: #1e293b;
            color: #fff;
            text-align: left;
            border-radius: 8px;
            padding: 10px 12px;
            position: absolute;
            z-index: 99;
            bottom: 120%;
            left: 50%;
            transform: translateX(-50%);
            transition: 0.2s;
            font-size: 0.75rem;
            line-height: 1.4;
            box-shadow: 0 10px 15px rgba(0,0,0,0.2);
        }

        .tooltip-box::after {
            content: "";
            position: absolute;
            top: 100%;
            left: 50%;
            transform: translateX(-50%);
            border-width: 6px;
            border-style: solid;
            border-color: #1e293b transparent transparent transparent;
        }

        .tooltip-container:hover .tooltip-box {
            visibility: visible;
            opacity: 1;
        }

        /* Stats Section */
        .stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 1.5rem; margin-bottom: 2.5rem; }
        .stat-card { background: white; padding: 1.5rem; border-radius: 20px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05); display: flex; align-items: center; gap: 1rem; }
        .stat-icon { width: 50px; height: 50px; border-radius: 14px; display: flex; align-items: center; justify-content: center; font-size: 1.25rem; }
        .val { font-size: 1.5rem; font-weight: 700; display: block; }
        .label { font-size: 0.85rem; color: #64748b; font-weight: 500; }

        /* Table Design */
        .data-card { background: white; border-radius: 24px; padding: 1.5rem; box-shadow: 0 10px 15px -3px rgba(0,0,0,0.05); }
        .table-controls { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem; padding: 0 10px; }
        
        .tab-group { background: #f1f5f9; padding: 5px; border-radius: 12px; display: flex; gap: 5px; }
        .tab-btn { border: none; padding: 8px 16px; border-radius: 8px; cursor: pointer; background: transparent; color: #64748b; font-weight: 600; font-size: 0.85rem; transition: 0.3s; }
        .tab-btn.active { background: white; color: var(--primary); box-shadow: 0 2px 4px rgba(0,0,0,0.05); }

        .styled-table { width: 100%; border-collapse: collapse; font-size: 0.9rem; }
        .styled-table th { text-align: left; padding: 15px; border-bottom: 2px solid #f1f5f9; color: #64748b; font-weight: 600; }
        .styled-table td { padding: 18px 15px; border-bottom: 1px solid #f1f5f9; vertical-align: middle; }
        
        /* Status Badges */
        .badge { padding: 6px 12px; border-radius: 8px; font-size: 0.75rem; font-weight: 700; text-transform: uppercase; }
        .badge-pending { background: #fef3c7; color: #d97706; }
        .badge-progress { background: #dbeafe; color: #2563eb; }
        .badge-selesai { background: #d1fae5; color: #059669; }
        .badge-batal { background: #fee2e2; color: #dc2626; }

        /* Action Buttons */
        .action-btns { display: flex; gap: 8px; }
        .btn-circle { width: 35px; height: 35px; border-radius: 10px; border: none; display: flex; align-items: center; justify-content: center; cursor: pointer; transition: 0.2s; color: white; }
        .btn-circle:hover { transform: translateY(-2px); opacity: 0.9; }

        .btn-p { background: var(--warning); }
        .btn-s { background: var(--success); }
        .btn-b { background: #f1f5f9; color: #64748b; }

        @media (max-width: 1200px) { .stats-grid { grid-template-columns: repeat(2, 1fr); } }
    </style>
</head>
<body>

    <aside class="sidebar">
        <div class="sidebar-brand">
            <i class="fas fa-mug-hot text-accent"></i> Beans & Brew
        </div>
        <ul class="nav-menu">
            <li class="nav-item"><a href="#" class="nav-link active"><i class="fas fa-th-large"></i> Dashboard</a></li>
        </ul>
        <div style="border-top: 1px solid rgba(255,255,255,0.1); padding-top: 20px;">
            <a href="logout" class="nav-link" style="color: #ef4444;"><i class="fas fa-sign-out-alt"></i> Keluar Sistem</a>
        </div>
    </aside>

    <main class="main-wrapper">
        <header class="top-header">
            <div>
                <h1 style="font-size: 1.8rem; font-weight: 700;">Workspace Kasir</h1>
                <p style="color: #64748b;">Pantau dan proses pesanan pelanggan secara real-time.</p>
            </div>
            <div class="user-profile">
                <div style="text-align: right">
                    <span style="display: block; font-weight: 600; font-size: 0.9rem;"><%= user.getNama()%></span>
                    <span style="font-size: 0.75rem; color: #64748b;">Kasir On-Duty</span>
                </div>
                <img src="https://ui-avatars.com/api/?name=<%= user.getNama()%>&background=d4a373&color=fff" style="width: 40px; border-radius: 50%" alt="">
            </div>
        </header>

        <%
            int total = pesananList.size();
            int pnd = 0, prg = 0, sls = 0;
            for (Map<String, Object> p : pesananList) {
                String s = (String) p.get("status");
                if ("pending".equals(s)) pnd++;
                else if ("progress".equals(s)) prg++;
                else if ("selesai".equals(s)) sls++;
            }
        %>
        <section class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon" style="background: #f1f5f9; color: var(--primary)"><i class="fas fa-shopping-cart"></i></div>
                <div><span class="label">Total Order</span><span class="val"><%= total %></span></div>
            </div>
            <div class="stat-card">
                <div class="stat-icon" style="background: #fffbeb; color: #d97706;"><i class="fas fa-clock"></i></div>
                <div><span class="label">Pending</span><span class="val"><%= pnd %></span></div>
            </div>
            <div class="stat-card">
                <div class="stat-icon" style="background: #eff6ff; color: #2563eb;"><i class="fas fa-spinner"></i></div>
                <div><span class="label">On Progress</span><span class="val"><%= prg %></span></div>
            </div>
            <div class="stat-card">
                <div class="stat-icon" style="background: #ecfdf5; color: #059669;"><i class="fas fa-check-circle"></i></div>
                <div><span class="label">Completed</span><span class="val"><%= sls %></span></div>
            </div>
        </section>

        <section class="data-card">
            <div class="table-controls">
                <h3 style="font-weight: 700;">Daftar Pesanan Terkini</h3>
                <div class="tab-group">
                    <button class="tab-btn active" onclick="filterStatus('all')">Semua</button>
                    <button class="tab-btn" onclick="filterStatus('pending')">Pending</button>
                    <button class="tab-btn" onclick="filterStatus('progress')">Proses</button>
                    <button class="tab-btn" onclick="filterStatus('selesai')">Selesai</button>
                </div>
            </div>

            <table class="styled-table">
                <thead>
                    <tr>
                        <th>ORDER ID</th>
                        <th>PELANGGAN</th>
                        <th>JENIS MENU</th>
                        <th>TOTAL BAYAR</th>
                        <th>METODE</th>
                        <th>STATUS</th>
                        <th style="text-align: center;">AKSI</th>
                    </tr>
                </thead>
                <tbody id="pesananTable">
                    <% for (Map<String, Object> p : pesananList) { 
                        String status = (String) p.get("status");
                        int id = (Integer) p.get("id");
                    %>
                    <tr data-status="<%= status %>">
                        <td style="font-weight: 700; color: var(--accent);">#ORD-<%= id %></td>
                        <td>
                            <div style="font-weight: 600;"><%= p.get("nama") %></div>
                            <div style="font-size: 0.75rem; color: #94a3b8;"><%= p.get("telp") %></div>
                        </td>
                        <td>
                            <div class="tooltip-container">
                                <span style="font-size: 0.8rem; font-weight: 600;">
                                    <%= p.get("jumlah_item") %> item
                                </span>
                                <div style="font-size: 0.7rem; color: #64748b;">
                                    <%= p.get("kategori") != null ? p.get("kategori") : "-" %>
                                </div>

                                <!-- TOOLTIP -->
                                <div class="tooltip-box">
                                    <strong>Daftar Menu:</strong><br>
                                    <%= p.get("menu_list") != null ? p.get("menu_list") : "Tidak ada data" %>
                                </div>
                            </div>
                        </td>
                        <td style="font-weight: 600;">Rp <%= String.format("%,d", p.get("total")) %></td>
                        <td><span style="font-size: 0.8rem; color: #64748b;"><i class="fas fa-credit-card"></i> <%= p.get("metode") %></span></td>
                        <td><span class="badge badge-<%= status %>"><%= status %></span></td>
                        <td>
                            <div class="action-btns" style="justify-content: center;">
                                <% if ("pending".equals(status)) { %>
                                    <button class="btn-circle btn-p" title="Proses Pesanan" onclick="updateStatus(<%= id %>, 'progress')"><i class="fas fa-play"></i></button>
                                <% } else if ("progress".equals(status)) { %>
                                    <button class="btn-circle btn-s" title="Selesaikan" onclick="updateStatus(<%= id %>, 'selesai')"><i class="fas fa-check"></i></button>
                                <% } %>
                                <% if (!"selesai".equals(status) && !"batal".equals(status)) { %>
                                    <button class="btn-circle btn-b" title="Batalkan" onclick="updateStatus(<%= id %>, 'batal')"><i class="fas fa-times"></i></button>
                                <% } %>
                            </div>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </section>
    </main>

    <script>
        function filterStatus(status) {
            const rows = document.querySelectorAll('#pesananTable tr');
            const btns = document.querySelectorAll('.tab-btn');
            
            btns.forEach(b => b.classList.remove('active'));
            event.target.classList.add('active');

            rows.forEach(row => {
                row.style.display = (status === 'all' || row.dataset.status === status) ? '' : 'none';
            });
        }

        function updateStatus(id, newStatus) {
            if (confirm('Konfirmasi perubahan status pesanan #' + id + '?')) {
                fetch('update-status', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: 'id=' + id + '&status=' + newStatus
                })
                .then(res => res.json())
                .then(data => {
                    if (data.success) location.reload();
                    else alert('Gagal memperbarui status.');
                });
            }
        }
    </script>
</body>
</html>