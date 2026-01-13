<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.sql.*, config.Koneksi, model.Menu, model.User" %>
<%
    User currentUser = (User) session.getAttribute("user");
    boolean isLoggedIn = (currentUser != null);

    List<Menu> menuList = (List<Menu>) request.getAttribute("menu");
    if (menuList == null) {
        menuList = new ArrayList<>();
    }

    List<Map<String, Object>> kategoriList = new ArrayList<>();
    try {
        Connection conn = Koneksi.getConnection();
        ResultSet rs = conn.createStatement().executeQuery("SELECT * FROM kategori ORDER BY id_kategori");
        while (rs.next()) {
            Map<String, Object> kat = new HashMap<>();
            kat.put("id", rs.getInt("id_kategori"));
            kat.put("nama", rs.getString("nama_kategori"));
            kategoriList.add(kat);
        }
        rs.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu - Beans & Brew</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #3e2723;
            --accent: #ff6f00;
            --bg-body: #fbfbfb;
            --card-shadow: 0 10px 30px rgba(0,0,0,0.05);
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Plus Jakarta Sans', sans-serif;
        }

        body {
            background-color: var(--bg-body);
            color: #333;
            line-height: 1.6;
        }

        /* Container & Layout */
        .menu-section {
            padding: 120px 5% 60px;
            max-width: 1300px;
            margin: 0 auto;
        }

        .menu-header {
            text-align: center;
            margin-bottom: 60px;
        }

        .menu-header h2 {
            font-size: 2.8rem;
            color: var(--primary);
            font-weight: 800;
            letter-spacing: -1px;
            margin-bottom: 12px;
        }

        .menu-header p {
            color: #777;
            font-size: 1.1rem;
        }

        /* Grid & Cards */
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 30px;
        }

        .menu-card {
            background: #fff;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: var(--card-shadow);
            transition: var(--transition);
            border: 1px solid rgba(0,0,0,0.03);
            position: relative;
        }

        .menu-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        }

        .menu-image {
            width: 100%;
            height: 250px;
            object-fit: cover;
            transition: var(--transition);
        }

        .menu-card:hover .menu-image {
            transform: scale(1.05);
        }

        .menu-content {
            padding: 24px;
        }

        .menu-name {
            font-size: 1.3rem;
            color: var(--primary);
            font-weight: 700;
            margin-bottom: 8px;
        }

        .menu-description {
            color: #888;
            font-size: 0.9rem;
            margin-bottom: 24px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .menu-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 15px;
            border-top: 1px solid #f0f0f0;
        }

        .menu-price {
            font-size: 1.25rem;
            color: #222;
            font-weight: 800;
        }

        /* Buttons */
        .add-to-cart-btn {
            background: var(--primary);
            color: white;
            border: none;
            width: 45px;
            height: 45px;
            border-radius: 12px;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
        }

        .add-to-cart-btn:hover {
            background: var(--accent);
            transform: rotate(90deg);
        }

        /* Modal Modern */
        .kategori-modal {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.4);
            backdrop-filter: blur(5px);
            z-index: 2000;
            align-items: center;
            justify-content: center;
        }

        .kategori-modal.show { display: flex; }

        .kategori-modal-content {
            background: white;
            padding: 35px;
            border-radius: 24px;
            width: 90%;
            max-width: 400px;
            text-align: center;
            box-shadow: 0 25px 50px rgba(0,0,0,0.2);
        }

        .kategori-options {
            display: flex;
            gap: 12px;
            margin: 25px 0;
        }

        .kategori-btn {
            flex: 1;
            padding: 15px;
            border: 2px solid #f0f0f0;
            background: #fff;
            border-radius: 15px;
            cursor: pointer;
            font-weight: 600;
            transition: var(--transition);
        }

        .kategori-btn.selected {
            background: var(--primary);
            color: #fff;
            border-color: var(--primary);
        }

        .modal-action-btn {
            width: 100%;
            padding: 14px;
            border-radius: 12px;
            font-weight: 700;
            cursor: pointer;
            border: none;
            margin-top: 10px;
        }

        .btn-confirm { background: var(--accent); color: white; }
        .btn-cancel { background: transparent; color: #888; }

        /* Toast */
        .toast {
            position: fixed;
            bottom: 30px;
            right: 30px;
            background: #2d3436;
            color: #fff;
            padding: 16px 28px;
            border-radius: 16px;
            display: none;
            z-index: 3000;
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
        }

        .toast.show { display: flex; animation: slideUp 0.4s ease; }

        @keyframes slideUp {
            from { transform: translateY(100px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        footer {
            background: #fff;
            padding: 40px;
            text-align: center;
            border-top: 1px solid #eee;
            color: #888;
            font-size: 0.9rem;
        }

        @media (max-width: 768px) {
            .menu-header h2 { font-size: 2rem; }
            .menu-grid { grid-template-columns: repeat(auto-fill, minmax(240px, 1fr)); }
        }
    </style>
</head>
<body>
    <%@ include file="navbar-component.jsp" %>

    <section class="menu-section">
        <div class="menu-header">
            <h2>Coffee Menu</h2>
            <p>Pilihan biji kopi terbaik yang dikurasi khusus untuk Anda.</p>
        </div>

        <% if (menuList.isEmpty()) { %>
        <div style="text-align: center; padding: 60px;">
            <h3 style="color: #ccc;">Belum ada menu tersedia</h3>
        </div>
        <% } else { %>
        <div class="menu-grid">
            <% for (Menu menu : menuList) {%>
            <div class="menu-card">
                <img src="<%= menu.getGambar()%>" alt="<%= menu.getNama()%>" class="menu-image" onerror="this.src='assets/img/placeholder.jpg'">
                <div class="menu-content">
                    <h3 class="menu-name"><%= menu.getNama()%></h3>
                    <p class="menu-description">Nikmati sensasi rasa autentik dari Beans & Brew yang dibuat dengan sepenuh hati.</p>
                    <div class="menu-footer">
                        <span class="menu-price">Rp <%= String.format("%,d", menu.getHarga())%></span>
                        <button class="add-to-cart-btn" onclick="handleAddToCart(<%= menu.getId()%>, '<%= menu.getNama()%>', <%= menu.getHarga()%>, <%= isLoggedIn%>)">
                            +
                        </button>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
        <% } %>
    </section>

    <div class="toast" id="toast">
        <span id="toastMessage">Item ditambahkan!</span>
    </div>

    <div class="kategori-modal" id="kategoriModal">
        <div class="kategori-modal-content">
            <h3 style="color: var(--primary); font-size: 1.4rem;">Pilih Penyajian</h3>
            <div class="kategori-options">
                <% for (Map<String, Object> kat : kategoriList) {
                    int katId = (Integer) kat.get("id");
                    String katNama = (String) kat.get("nama");
                    String selectedClass = katId == 1 ? "selected" : "";
                %>
                <button class="kategori-btn <%= selectedClass%>" id="btnKat<%= katId%>" onclick="selectKategori(<%= katId%>, '<%= katNama%>')">
                    <%= katNama%>
                </button>
                <% }%>
            </div>
            <button class="modal-action-btn btn-confirm" onclick="confirmAddToCart()">Konfirmasi</button>
            <button class="modal-action-btn btn-cancel" onclick="closeKategoriModal()">Batal</button>
        </div>
    </div>

    <footer>
        <p>&copy; 2024 Beans & Brew. Crafting moments, one cup at a time.</p>
    </footer>

    <script>
        // Logika JavaScript Asli (Tidak diubah)
        let tempCartItem = null;
        let selectedKategoriId = 1;
        let selectedKategoriNama = 'Dingin';

        function getCart() {
            const cart = sessionStorage.getItem('cart');
            return cart ? JSON.parse(cart) : [];
        }

        function saveCart(cart) {
            sessionStorage.setItem('cart', JSON.stringify(cart));
            updateCartBadge();
        }

        function updateCartBadge() {
            const cart = getCart();
            const totalItems = cart.reduce((sum, item) => sum + item.quantity, 0);
            const badge = document.getElementById('cartBadge');
            if(badge) {
                badge.textContent = totalItems;
                badge.style.display = totalItems > 0 ? 'flex' : 'none';
            }
        }

        function handleAddToCart(id, name, price, isLoggedIn) {
            if (!isLoggedIn) {
                alert('⚠️ Silakan login terlebih dahulu untuk menambahkan item ke keranjang!');
                window.location.href = 'login.jsp';
                return;
            }
            tempCartItem = {id, name, price};
            selectedKategoriId = 1;
            selectedKategoriNama = 'Dingin';
            document.querySelectorAll('.kategori-btn').forEach(btn => btn.classList.remove('selected'));
            const btnDingin = document.getElementById('btnKat1');
            if (btnDingin) btnDingin.classList.add('selected');
            document.getElementById('kategoriModal').classList.add('show');
        }

        function selectKategori(id, nama) {
            selectedKategoriId = id;
            selectedKategoriNama = nama;
            document.querySelectorAll('.kategori-btn').forEach(btn => btn.classList.remove('selected'));
            document.getElementById('btnKat' + id).classList.add('selected');
        }

        function closeKategoriModal() {
            document.getElementById('kategoriModal').classList.remove('show');
            tempCartItem = null;
        }

        function confirmAddToCart() {
            if (!tempCartItem) return;
            let cart = getCart();
            const existingItem = cart.find(item =>
                item.id === tempCartItem.id && item.kategoriId === selectedKategoriId
            );
            if (existingItem) {
                existingItem.quantity += 1;
            } else {
                cart.push({
                    id: tempCartItem.id,
                    name: tempCartItem.name,
                    price: tempCartItem.price,
                    kategoriId: selectedKategoriId,
                    kategoriNama: selectedKategoriNama,
                    quantity: 1
                });
            }
            saveCart(cart);
            showToast(tempCartItem.name + ' (' + selectedKategoriNama + ') ditambahkan!');
            closeKategoriModal();
        }

        function showToast(message) {
            const toast = document.getElementById('toast');
            const toastMessage = document.getElementById('toastMessage');
            toastMessage.textContent = message;
            toast.classList.add('show');
            setTimeout(() => toast.classList.remove('show'), 3000);
        }

        document.addEventListener('DOMContentLoaded', updateCartBadge);
    </script>
</body>
</html>