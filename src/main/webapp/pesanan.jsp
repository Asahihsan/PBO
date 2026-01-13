<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Keranjang - Beans & Brew</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #3e2723;
            --accent: #ff6f00;
            --bg-body: #f8f9fa;
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
            color: #2d3436;
            line-height: 1.6;
        }

        .main-content {
            margin-top: 100px;
            padding: 2rem 5%;
            max-width: 1200px;
            margin-left: auto;
            margin-right: auto;
            min-height: calc(100vh - 200px);
        }

        .page-title {
            font-size: 2.2rem;
            color: var(--primary);
            margin-bottom: 2.5rem;
            font-weight: 800;
            text-align: left;
            letter-spacing: -1px;
        }

        .cart-container {
            display: grid;
            grid-template-columns: 1fr 400px;
            gap: 2.5rem;
            align-items: start;
        }

        /* List Items Area */
        .cart-items {
            background: white;
            border-radius: 24px;
            padding: 1.5rem;
            box-shadow: var(--card-shadow);
        }

        .cart-item {
            display: flex;
            gap: 1.5rem;
            padding: 1.5rem;
            border-bottom: 1px solid #f1f1f1;
            align-items: center;
            transition: var(--transition);
        }

        .cart-item:last-child { border-bottom: none; }

        .item-details { flex: 1; }

        .item-name {
            font-size: 1.15rem;
            font-weight: 700;
            color: var(--primary);
            margin-bottom: 4px;
        }

        .item-price {
            color: #777;
            font-size: 1rem;
            font-weight: 500;
        }

        /* Controls */
        .item-controls {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }

        .quantity-control {
            display: flex;
            align-items: center;
            gap: 1rem;
            background: #f8f9fa;
            padding: 6px 12px;
            border-radius: 12px;
            border: 1px solid #eee;
        }

        .qty-btn {
            background: white;
            color: var(--primary);
            border: 1px solid #ddd;
            width: 32px;
            height: 32px;
            border-radius: 8px;
            font-size: 1.2rem;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: var(--transition);
            font-weight: bold;
        }

        .qty-btn:hover {
            background: var(--primary);
            color: white;
            border-color: var(--primary);
        }

        .qty-number {
            font-weight: 700;
            font-size: 1rem;
            min-width: 25px;
            text-align: center;
        }

        .remove-btn {
            background: #fff0f0;
            color: #ff4757;
            border: none;
            padding: 10px 16px;
            border-radius: 12px;
            cursor: pointer;
            transition: var(--transition);
            font-weight: 600;
            font-size: 0.85rem;
        }

        .remove-btn:hover {
            background: #ff4757;
            color: white;
        }

        /* Checkout Card */
        .checkout-section {
            background: white;
            border-radius: 24px;
            padding: 2rem;
            box-shadow: var(--card-shadow);
            position: sticky;
            top: 110px;
        }

        .checkout-title {
            font-size: 1.4rem;
            color: var(--primary);
            margin-bottom: 1.5rem;
            font-weight: 700;
        }

        .form-group { margin-bottom: 1.2rem; }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 600;
            font-size: 0.9rem;
        }

        .form-group input, .form-group select {
            width: 100%;
            padding: 12px 16px;
            border: 1.5px solid #eee;
            border-radius: 12px;
            font-size: 0.95rem;
            transition: var(--transition);
            background: #fcfcfc;
        }

        .form-group input:focus {
            outline: none;
            border-color: var(--accent);
            background: white;
        }

        .order-summary {
            margin: 1.5rem 0;
            padding-top: 1.5rem;
            border-top: 1.5px dashed #eee;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-size: 0.95rem;
            color: #666;
        }

        .summary-row.total {
            font-size: 1.3rem;
            font-weight: 800;
            color: var(--primary);
            margin-top: 15px;
            padding-top: 10px;
        }

        .checkout-btn {
            width: 100%;
            background: var(--accent);
            color: white;
            border: none;
            padding: 16px;
            border-radius: 14px;
            font-size: 1rem;
            font-weight: 700;
            cursor: pointer;
            transition: var(--transition);
            box-shadow: 0 8px 20px rgba(255, 111, 0, 0.2);
        }

        .checkout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 25px rgba(255, 111, 0, 0.3);
        }

        /* Empty State */
        .empty-cart {
            text-align: center;
            padding: 5rem 2rem;
            background: white;
            border-radius: 24px;
            box-shadow: var(--card-shadow);
        }

        .empty-cart-icon { font-size: 4rem; margin-bottom: 1.5rem; display: block; }
        .empty-cart h2 { color: var(--primary); margin-bottom: 10px; font-weight: 800; }
        .empty-cart p { color: #888; margin-bottom: 2rem; }

        .back-to-menu-btn {
            display: inline-block;
            background: var(--primary);
            color: white;
            padding: 14px 32px;
            border-radius: 12px;
            text-decoration: none;
            font-weight: 700;
            transition: var(--transition);
        }

        /* Success Modal */
        .modal {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.5);
            backdrop-filter: blur(8px);
            z-index: 2000;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .modal.show { display: flex; }

        .modal-content {
            background: white;
            padding: 3rem;
            border-radius: 30px;
            text-align: center;
            max-width: 450px;
            width: 100%;
            animation: modalPop 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        @keyframes modalPop {
            from { transform: scale(0.8); opacity: 0; }
            to { transform: scale(1); opacity: 1; }
        }

        .modal-icon { font-size: 5rem; margin-bottom: 1rem; }
        .modal-content h2 { color: #2d3436; margin-bottom: 1rem; font-weight: 800; }
        .modal-content p { color: #636e72; margin-bottom: 2rem; }

        .modal-btn {
            background: var(--accent);
            color: white;
            border: none;
            padding: 14px 40px;
            border-radius: 12px;
            font-weight: 700;
            cursor: pointer;
            transition: var(--transition);
        }

        footer {
            background: white;
            text-align: center;
            padding: 3rem;
            margin-top: 4rem;
            border-top: 1px solid #eee;
            color: #888;
        }

        @media (max-width: 968px) {
            .cart-container { grid-template-columns: 1fr; }
            .checkout-section { position: static; }
            .cart-item { flex-direction: column; text-align: center; }
        }
    </style>
</head>
<body>
    <%@ include file="navbar-component.jsp" %>

    <div class="main-content">
        <h1 class="page-title">Pesanan Anda</h1>
        <div id="cartContent"></div>
    </div>

    <div class="modal" id="successModal">
        <div class="modal-content">
            <div class="modal-icon">?</div>
            <h2>Berhasil Terkirim!</h2>
            <p>Pesanan Anda telah kami terima dan sedang disiapkan oleh barista kami.</p>
            <button class="modal-btn" onclick="backToMenu()">Sip, Terima Kasih!</button>
        </div>
    </div>

    <footer>
        <p>&copy; 2024 Beans & Brew. Crafting moments, one cup at a time. ??</p>
    </footer>

    <script>
        // FUNGSI JAVASCRIPT (Sama persis seperti aslinya)
        function getCart() {
            const cart = sessionStorage.getItem('cart');
            return cart ? JSON.parse(cart) : [];
        }

        function saveCart(cart) {
            sessionStorage.setItem('cart', JSON.stringify(cart));
            renderCart();
            updateCartBadge();
        }

        function updateCartBadge() {
            const cart = getCart();
            const totalItems = cart.reduce((sum, item) => sum + item.quantity, 0);
            const badge = document.getElementById('cartBadge');
            if (badge) {
                badge.textContent = totalItems;
                badge.style.display = totalItems > 0 ? 'flex' : 'none';
            }
        }

        function updateQuantity(index, change) {
            let cart = getCart();
            if (cart[index]) {
                cart[index].quantity += change;
                if (cart[index].quantity <= 0) {
                    cart.splice(index, 1);
                }
                saveCart(cart);
            }
        }

        function removeItem(index) {
            let cart = getCart();
            cart.splice(index, 1);
            saveCart(cart);
        }

        function calculateTotal() {
            const cart = getCart();
            return cart.reduce((total, item) => total + (item.price * item.quantity), 0);
        }

        function renderCart() {
            const cart = getCart();
            const container = document.getElementById('cartContent');

            if (cart.length === 0) {
                container.innerHTML =
                    '<div class="empty-cart">' +
                    '<span class="empty-cart-icon">?</span>' +
                    '<h2>Wah, keranjang masih kosong!</h2>' +
                    '<p>Aroma kopi kami sudah menunggumu. Yuk, pilih menu favoritmu sekarang.</p>' +
                    '<a href="menu" class="back-to-menu-btn">Mulai Pesan</a>' +
                    '</div>';
                return;
            }

            const total = calculateTotal();
            const totalItems = cart.reduce((sum, item) => sum + item.quantity, 0);

            var cartItemsHTML = '';
            for (var i = 0; i < cart.length; i++) {
                var item = cart[i];
                var kategoriIcon = '??';
                var kategoriNama = 'Dingin';

                if (item.kategoriNama) {
                    kategoriNama = item.kategoriNama;
                    kategoriIcon = item.kategoriNama === 'Panas' ? '?' : '??';
                }

                cartItemsHTML +=
                    '<div class="cart-item">' +
                    '<div class="item-details">' +
                    '<div class="item-name">' + item.name + '</div>' +
                    '<div class="item-price">' + kategoriNama + ' - Rp ' + item.price.toLocaleString('id-ID') + '</div>' +
                    '</div>' +
                    '<div class="item-controls">' +
                    '<div class="quantity-control">' +
                    '<button class="qty-btn" onclick="updateQuantity(' + i + ', -1)">-</button>' +
                    '<span class="qty-number">' + item.quantity + '</span>' +
                    '<button class="qty-btn" onclick="updateQuantity(' + i + ', 1)">+</button>' +
                    '</div>' +
                    '<button class="remove-btn" onclick="removeItem(' + i + ')">Hapus</button>' +
                    '</div>' +
                    '</div>';
            }

            container.innerHTML =
                '<div class="cart-container">' +
                '<div class="cart-items">' +
                cartItemsHTML +
                '</div>' +
                '<div class="checkout-section">' +
                '<h2 class="checkout-title">Konfirmasi Pesanan</h2>' +
                '<div class="form-group">' +
                '<label>Nama Penerima</label>' +
                '<input type="text" id="customerName" placeholder="Masukkan nama Anda" required>' +
                '</div>' +
                '<div class="form-group">' +
                '<label>Nomor Telepon (WhatsApp)</label>' +
                '<input type="tel" id="customerPhone" placeholder="08xxxxxxxxxx" required>' +
                '</div>' +
                '<div class="form-group">' +
                '<label>Metode Pembayaran</label>' +
                '<select id="paymentMethod">' +
                '<option value="cash">? Tunai di Kasir</option>' +
                '<option value="transfer">? Transfer Bank</option>' +
                '<option value="gopay">? GoPay / QRIS</option>' +
                '<option value="dana">? DANA</option>' +
                '</select>' +
                '</div>' +
                '<div class="order-summary">' +
                '<div class="summary-row">' +
                '<span>Total Item</span>' +
                '<span>' + totalItems + ' Produk</span>' +
                '</div>' +
                '<div class="summary-row total">' +
                '<span>Total Bayar</span>' +
                '<span>Rp ' + total.toLocaleString('id-ID') + '</span>' +
                '</div>' +
                '</div>' +
                '<button class="checkout-btn" onclick="checkout()">Selesaikan Pesanan</button>' +
                '</div>' +
                '</div>';
        }

        function checkout() {
            const name = document.getElementById('customerName').value.trim();
            const phone = document.getElementById('customerPhone').value.trim();
            const payment = document.getElementById('paymentMethod').value;

            if (!name || !phone) {
                alert('Mohon lengkapi nama dan nomor telepon untuk memproses pesanan!');
                return;
            }

            const cart = getCart();
            const total = calculateTotal();

            const orderData = {
                nama: name,
                telp: phone,
                metode: payment,
                cart: cart,
                total: total
            };

            fetch('checkout', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(orderData)
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    sessionStorage.removeItem('cart');
                    updateCartBadge();
                    document.getElementById('successModal').classList.add('show');
                } else {
                    alert('Gagal: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Terjadi kesalahan koneksi!');
            });
        }

        function backToMenu() {
            window.location.href = 'menu';
        }

        document.addEventListener('DOMContentLoaded', function () {
            renderCart();
            updateCartBadge();
        });
    </script>
</body>
</html>