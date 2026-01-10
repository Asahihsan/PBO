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
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                color: #2c2c2c;
                line-height: 1.6;
                background: #f5f5f5;
            }

            .menu-section {
                margin-top: 90px;
                padding: 3rem 5%;
                max-width: 1400px;
                margin-left: auto;
                margin-right: auto;
            }

            .menu-header {
                text-align: center;
                margin-bottom: 3rem;
            }

            .menu-header h2 {
                font-size: 2.5rem;
                color: #3e2723;
                margin-bottom: 0.5rem;
            }

            .menu-header p {
                color: #666;
                font-size: 1.1rem;
            }

            .menu-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
                gap: 2rem;
            }

            .menu-card {
                background: white;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
                transition: all 0.3s;
            }

            .menu-card:hover {
                transform: translateY(-10px);
                box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            }

            .menu-image {
                width: 100%;
                height: 280px;
                object-fit: cover;
                background: #e0e0e0;
            }

            .menu-content {
                padding: 1.5rem;
            }

            .menu-name {
                font-size: 1.5rem;
                color: #3e2723;
                margin-bottom: 0.5rem;
                font-weight: bold;
            }

            .menu-description {
                color: #666;
                margin-bottom: 1rem;
                font-size: 0.95rem;
                line-height: 1.5;
            }

            .menu-footer {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-top: 1rem;
            }

            .menu-price {
                font-size: 1.8rem;
                color: #ff6f00;
                font-weight: bold;
            }

            .add-to-cart-btn {
                background: #ff6f00;
                color: white;
                border: none;
                padding: 0.8rem 1.5rem;
                border-radius: 50px;
                font-size: 1rem;
                font-weight: bold;
                cursor: pointer;
                transition: all 0.3s;
                display: flex;
                align-items: center;
                gap: 0.5rem;
                box-shadow: 0 4px 15px rgba(255, 111, 0, 0.3);
            }

            .add-to-cart-btn:hover {
                background: #ff8f00;
                transform: scale(1.05);
                box-shadow: 0 6px 20px rgba(255, 111, 0, 0.5);
            }

            .toast {
                position: fixed;
                bottom: 30px;
                right: 30px;
                background: #4caf50;
                color: white;
                padding: 1rem 2rem;
                border-radius: 10px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.3);
                display: none;
                align-items: center;
                gap: 1rem;
                animation: slideIn 0.3s ease-out;
                z-index: 2000;
            }

            .toast.show {
                display: flex;
            }

            @keyframes slideIn {
                from {
                    transform: translateX(400px);
                    opacity: 0;
                }
                to {
                    transform: translateX(0);
                    opacity: 1;
                }
            }

            .toast-icon {
                font-size: 1.5rem;
            }

            .kategori-modal {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0,0,0,0.7);
                z-index: 2000;
                align-items: center;
                justify-content: center;
            }

            .kategori-modal.show {
                display: flex;
            }

            .kategori-modal-content {
                background: white;
                padding: 2.5rem;
                border-radius: 20px;
                text-align: center;
                max-width: 400px;
                animation: modalSlideIn 0.3s ease-out;
            }

            @keyframes modalSlideIn {
                from {
                    transform: translateY(-50px);
                    opacity: 0;
                }
                to {
                    transform: translateY(0);
                    opacity: 1;
                }
            }

            .kategori-modal h3 {
                color: #3e2723;
                margin-bottom: 1.5rem;
                font-size: 1.5rem;
            }

            .kategori-options {
                display: flex;
                gap: 1rem;
                margin-bottom: 1.5rem;
            }

            .kategori-btn {
                flex: 1;
                padding: 1rem;
                border: 3px solid #e0e0e0;
                background: white;
                border-radius: 15px;
                cursor: pointer;
                transition: all 0.3s;
                font-size: 1.1rem;
                font-weight: bold;
            }

            .kategori-btn:hover {
                border-color: #ff6f00;
                transform: scale(1.05);
            }

            .kategori-btn.selected {
                background: #ff6f00;
                color: white;
                border-color: #ff6f00;
            }

            .kategori-actions {
                display: flex;
                gap: 1rem;
            }

            .modal-action-btn {
                flex: 1;
                padding: 1rem;
                border: none;
                border-radius: 50px;
                font-weight: bold;
                cursor: pointer;
                transition: all 0.3s;
            }

            .btn-cancel {
                background: #e0e0e0;
                color: #666;
            }

            .btn-cancel:hover {
                background: #d0d0d0;
            }

            .btn-confirm {
                background: #ff6f00;
                color: white;
            }

            .btn-confirm:hover {
                background: #ff8f00;
            }

            .empty-state {
                text-align: center;
                padding: 4rem 2rem;
            }

            .empty-state h3 {
                color: #666;
                font-size: 1.5rem;
                margin-bottom: 1rem;
            }

            footer {
                background: #3e2723;
                color: white;
                text-align: center;
                padding: 2rem;
                margin-top: 3rem;
            }

            @media (max-width: 768px) {
                .menu-grid {
                    grid-template-columns: 1fr;
                }
            }
        </style>
    </head>
    <body>
        <%@ include file="navbar-component.jsp" %>

        <section class="menu-section">
            <div class="menu-header">
                <h2>☕ Coffee Menu</h2>
                <p>Kopi terbaik untuk menemani harimu</p>
            </div>

            <% if (menuList.isEmpty()) { %>
            <div class="empty-state">
                <h3>😔 Menu belum tersedia</h3>
                <p>Silakan hubungi admin untuk menambahkan menu</p>
            </div>
            <% } else { %>
            <div class="menu-grid">
                <% for (Menu menu : menuList) {%>
                <div class="menu-card">
                    <img src="<%= menu.getGambar()%>" alt="<%= menu.getNama()%>" class="menu-image" onerror="this.src='assets/img/placeholder.jpg'">
                    <div class="menu-content">
                        <h3 class="menu-name"><%= menu.getNama()%></h3>
                        <p class="menu-description">Kopi pilihan terbaik dari Beans & Brew</p>
                        <div class="menu-footer">
                            <span class="menu-price">Rp <%= String.format("%,d", menu.getHarga())%></span>
                            <button class="add-to-cart-btn" onclick="handleAddToCart(<%= menu.getId()%>, '<%= menu.getNama()%>', <%= menu.getHarga()%>, <%= isLoggedIn%>)">
                                <span>➕</span> Keranjang
                            </button>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
            <% } %>
        </section>

        <div class="toast" id="toast">
            <span class="toast-icon">✅</span>
            <span id="toastMessage">Item berhasil ditambahkan ke keranjang!</span>
        </div>

        <div class="kategori-modal" id="kategoriModal">
            <div class="kategori-modal-content">
                <h3>Pilih Kategori</h3>
                <div class="kategori-options">
                    <% for (Map<String, Object> kat : kategoriList) {
                            int katId = (Integer) kat.get("id");
                            String katNama = (String) kat.get("nama");
                            String icon = "Dingin".equals(katNama) ? "🧊" : "🔥";
                            String selectedClass = katId == 1 ? "selected" : "";
                    %>
                    <button class="kategori-btn <%= selectedClass%>" id="btnKat<%= katId%>" onclick="selectKategori(<%= katId%>, '<%= katNama%>')">
                        <%= icon%> <%= katNama%>
                    </button>
                    <% }%>
                </div>
                <div class="kategori-actions">
                    <button class="modal-action-btn btn-cancel" onclick="closeKategoriModal()">Batal</button>
                    <button class="modal-action-btn btn-confirm" onclick="confirmAddToCart()">Tambah</button>
                </div>
            </div>
        </div>

        <footer>
            <p>&copy; 2024 Beans & Brew. All rights reserved. Made with ❤️ and ☕</p>
        </footer>

        <script>
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
                badge.textContent = totalItems;
                badge.style.display = totalItems > 0 ? 'flex' : 'none';
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
                if (btnDingin)
                    btnDingin.classList.add('selected');

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
                if (!tempCartItem)
                    return;

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
                        kategoriId: selectedKategoriId, // INI PENTING!
                        kategoriNama: selectedKategoriNama, // INI JUGA!
                        quantity: 1
                    });
                }

                saveCart(cart);
                showToast(tempCartItem.name + ' (' + selectedKategoriNama + ') berhasil ditambahkan!');
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