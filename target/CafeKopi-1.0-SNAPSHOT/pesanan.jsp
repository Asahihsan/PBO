<!DOCTYPE html>
<html lang="id">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Pesanan - Beans & Brew</title>
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

            .main-content {
                margin-top: 90px;
                padding: 2rem 5%;
                max-width: 1200px;
                margin-left: auto;
                margin-right: auto;
                min-height: calc(100vh - 200px);
            }

            .page-title {
                font-size: 2.5rem;
                color: #3e2723;
                margin-bottom: 2rem;
                text-align: center;
            }

            .cart-container {
                display: grid;
                grid-template-columns: 1fr 400px;
                gap: 2rem;
            }

            .cart-items {
                background: white;
                border-radius: 15px;
                padding: 2rem;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            }

            .cart-item {
                display: flex;
                gap: 1.5rem;
                padding: 1.5rem;
                border-bottom: 1px solid #e0e0e0;
                align-items: center;
            }

            .cart-item:last-child {
                border-bottom: none;
            }

            .item-details {
                flex: 1;
            }

            .item-name {
                font-size: 1.3rem;
                font-weight: bold;
                color: #3e2723;
                margin-bottom: 0.5rem;
            }

            .item-price {
                color: #ff6f00;
                font-size: 1.1rem;
                font-weight: bold;
            }

            .item-controls {
                display: flex;
                align-items: center;
                gap: 1rem;
            }

            .quantity-control {
                display: flex;
                align-items: center;
                gap: 0.8rem;
                background: #f5f5f5;
                padding: 0.5rem 1rem;
                border-radius: 50px;
            }

            .qty-btn {
                background: #ff6f00;
                color: white;
                border: none;
                width: 30px;
                height: 30px;
                border-radius: 50%;
                font-size: 1.2rem;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.3s;
            }

            .qty-btn:hover {
                background: #ff8f00;
                transform: scale(1.1);
            }

            .qty-number {
                font-weight: bold;
                font-size: 1.1rem;
                min-width: 30px;
                text-align: center;
            }

            .remove-btn {
                background: #f44336;
                color: white;
                border: none;
                padding: 0.5rem 1rem;
                border-radius: 50px;
                cursor: pointer;
                transition: all 0.3s;
                font-weight: bold;
            }

            .remove-btn:hover {
                background: #d32f2f;
                transform: scale(1.05);
            }

            .checkout-section {
                background: white;
                border-radius: 15px;
                padding: 2rem;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
                height: fit-content;
                position: sticky;
                top: 110px;
            }

            .checkout-title {
                font-size: 1.5rem;
                color: #3e2723;
                margin-bottom: 1.5rem;
                padding-bottom: 1rem;
                border-bottom: 2px solid #e0e0e0;
            }

            .form-group {
                margin-bottom: 1.5rem;
            }

            .form-group label {
                display: block;
                margin-bottom: 0.5rem;
                color: #555;
                font-weight: 500;
            }

            .form-group input,
            .form-group select {
                width: 100%;
                padding: 0.8rem;
                border: 2px solid #e0e0e0;
                border-radius: 8px;
                font-size: 1rem;
                transition: border 0.3s;
            }

            .form-group input:focus,
            .form-group select:focus {
                outline: none;
                border-color: #ff6f00;
            }

            .order-summary {
                margin: 1.5rem 0;
                padding: 1rem 0;
                border-top: 2px solid #e0e0e0;
                border-bottom: 2px solid #e0e0e0;
            }

            .summary-row {
                display: flex;
                justify-content: space-between;
                margin-bottom: 0.8rem;
                font-size: 1.1rem;
            }

            .summary-row.total {
                font-size: 1.5rem;
                font-weight: bold;
                color: #3e2723;
                margin-top: 1rem;
            }

            .checkout-btn {
                width: 100%;
                background: #ff6f00;
                color: white;
                border: none;
                padding: 1rem;
                border-radius: 50px;
                font-size: 1.2rem;
                font-weight: bold;
                cursor: pointer;
                transition: all 0.3s;
                box-shadow: 0 4px 15px rgba(255, 111, 0, 0.3);
            }

            .checkout-btn:hover {
                background: #ff8f00;
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(255, 111, 0, 0.5);
            }

            .empty-cart {
                text-align: center;
                padding: 4rem 2rem;
                background: white;
                border-radius: 15px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            }

            .empty-cart-icon {
                font-size: 5rem;
                margin-bottom: 1rem;
            }

            .empty-cart h2 {
                color: #666;
                margin-bottom: 1rem;
            }

            .empty-cart p {
                color: #999;
                margin-bottom: 2rem;
            }

            .back-to-menu-btn {
                display: inline-block;
                background: #ff6f00;
                color: white;
                padding: 1rem 2rem;
                border-radius: 50px;
                text-decoration: none;
                font-weight: bold;
                transition: all 0.3s;
            }

            .back-to-menu-btn:hover {
                background: #ff8f00;
                transform: translateY(-2px);
            }

            .modal {
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

            .modal.show {
                display: flex;
            }

            .modal-content {
                background: white;
                padding: 3rem;
                border-radius: 20px;
                text-align: center;
                max-width: 500px;
                animation: modalSlideIn 0.3s ease-out;
            }

            @keyframes modalSlideIn {
                from {
                    transform: translateY(-100px);
                    opacity: 0;
                }
                to {
                    transform: translateY(0);
                    opacity: 1;
                }
            }

            .modal-icon {
                font-size: 5rem;
                margin-bottom: 1rem;
            }

            .modal-content h2 {
                color: #4caf50;
                margin-bottom: 1rem;
            }

            .modal-content p {
                color: #666;
                margin-bottom: 2rem;
                font-size: 1.1rem;
            }

            .modal-btn {
                background: #ff6f00;
                color: white;
                border: none;
                padding: 1rem 3rem;
                border-radius: 50px;
                font-size: 1.1rem;
                font-weight: bold;
                cursor: pointer;
                transition: all 0.3s;
            }

            .modal-btn:hover {
                background: #ff8f00;
                transform: scale(1.05);
            }

            footer {
                background: #3e2723;
                color: white;
                text-align: center;
                padding: 2rem;
                margin-top: 3rem;
            }

            @media (max-width: 968px) {
                .cart-container {
                    grid-template-columns: 1fr;
                }
                .checkout-section {
                    position: static;
                }
                .cart-item {
                    flex-direction: column;
                    text-align: center;
                }
                .item-controls {
                    flex-direction: column;
                }
            }
        </style>
    </head>
    <body>
        <%@ include file="navbar-component.jsp" %>

        <div class="main-content">
            <h1 class="page-title">? Keranjang Pesanan</h1>
            <div id="cartContent"></div>
        </div>

        <div class="modal" id="successModal">
            <div class="modal-content">
                <div class="modal-icon">?</div>
                <h2>Pesanan Berhasil!</h2>
                <p>Terima kasih telah memesan di Beans & Brew. Pesanan Anda sedang diproses.</p>
                <button class="modal-btn" onclick="backToMenu()">Kembali ke Menu</button>
            </div>
        </div>

        <footer>
            <p>&copy; 2024 Beans & Brew. All rights reserved. Made with ?? and ?</p>
        </footer>

        <script>
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
                            '<div class="empty-cart-icon">?</div>' +
                            '<h2>Keranjang Kosong</h2>' +
                            '<p>Belum ada item di keranjang. Yuk, mulai pesan kopi favoritmu!</p>' +
                            '<a href="menu" class="back-to-menu-btn">Lihat Menu</a>' +
                            '</div>';
                    return;
                }

                const total = calculateTotal();
                const totalItems = cart.reduce((sum, item) => sum + item.quantity, 0);

                var cartItemsHTML = '';
                for (var i = 0; i < cart.length; i++) {
                    var item = cart[i];
                    var kategoriIcon = '?';
                    var kategoriNama = 'Dingin';

                    if (item.kategoriNama) {
                        kategoriNama = item.kategoriNama;
                        kategoriIcon = item.kategoriNama === 'Panas' ? '?' : '?';
                    }

                    cartItemsHTML +=
                            '<div class="cart-item">' +
                            '<div class="item-details">' +
                            '<div class="item-name">' + item.name + ' ' + kategoriIcon + ' (' + kategoriNama + ')</div>' +
                            '<div class="item-price">Rp ' + item.price.toLocaleString('id-ID') + '</div>' +
                            '</div>' +
                            '<div class="item-controls">' +
                            '<div class="quantity-control">' +
                            '<button class="qty-btn" onclick="updateQuantity(' + i + ', -1)">?</button>' +
                            '<span class="qty-number">' + item.quantity + '</span>' +
                            '<button class="qty-btn" onclick="updateQuantity(' + i + ', 1)">+</button>' +
                            '</div>' +
                            '<button class="remove-btn" onclick="removeItem(' + i + ')">?? Hapus</button>' +
                            '</div>' +
                            '</div>';
                }

                container.innerHTML =
                        '<div class="cart-container">' +
                        '<div class="cart-items">' +
                        cartItemsHTML +
                        '</div>' +
                        '<div class="checkout-section">' +
                        '<h2 class="checkout-title">Detail Pesanan</h2>' +
                        '<div class="form-group">' +
                        '<label for="customerName">Nama Lengkap</label>' +
                        '<input type="text" id="customerName" placeholder="Masukkan nama Anda" required>' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="customerPhone">No. Telepon</label>' +
                        '<input type="tel" id="customerPhone" placeholder="08xxxxxxxxxx" required>' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="paymentMethod">Metode Pembayaran</label>' +
                        '<select id="paymentMethod">' +
                        '<option value="cash">? Cash</option>' +
                        '<option value="transfer">? Transfer Bank</option>' +
                        '<option value="gopay">? GoPay</option>' +
                        '<option value="ovo">? OVO</option>' +
                        '<option value="dana">? DANA</option>' +
                        '</select>' +
                        '</div>' +
                        '<div class="order-summary">' +
                        '<div class="summary-row">' +
                        '<span>Jumlah Item:</span>' +
                        '<span>' + totalItems + ' item</span>' +
                        '</div>' +
                        '<div class="summary-row total">' +
                        '<span>Total:</span>' +
                        '<span>Rp ' + total.toLocaleString('id-ID') + '</span>' +
                        '</div>' +
                        '</div>' +
                        '<button class="checkout-btn" onclick="checkout()">Checkout Sekarang</button>' +
                        '</div>' +
                        '</div>';
            }

            function checkout() {
                const name = document.getElementById('customerName').value.trim();
                const phone = document.getElementById('customerPhone').value.trim();
                const payment = document.getElementById('paymentMethod').value;

                if (!name || !phone) {
                    alert('Mohon lengkapi nama dan nomor telepon!');
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

                console.log('Sending order data:', orderData);

                fetch('checkout', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(orderData)
                })
                        .then(response => response.json())
                        .then(data => {
                            console.log('Server response:', data);
                            if (data.success) {
                                sessionStorage.removeItem('cart');
                                updateCartBadge();
                                document.getElementById('successModal').classList.add('show');
                            } else {
                                alert('Gagal membuat pesanan: ' + data.message);
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('Terjadi kesalahan saat membuat pesanan!');
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