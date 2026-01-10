<%-- 
    Document   : about.jsp
    Created on : Dec 26, 2025, 10:44:06 AM
    Author     : kenas
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About - Beans & Brew</title>
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

        /* Navbar */
        nav {
            background: linear-gradient(135deg, #3e2723 0%, #5d4037 100%);
            padding: 1rem 5%;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            box-shadow: 0 2px 10px rgba(0,0,0,0.3);
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
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .logo::before {
            content: "☕";
            font-size: 2rem;
        }

        nav ul {
            display: flex;
            list-style: none;
            gap: 2rem;
            align-items: center;
        }

        nav ul li a {
            color: #fff;
            text-decoration: none;
            font-size: 1.1rem;
            transition: color 0.3s;
            padding: 0.5rem 1rem;
            border-radius: 5px;
        }

        nav ul li a:hover {
            background: rgba(255,255,255,0.1);
            color: #ffcc80;
        }

        .cart-link {
            position: relative;
        }

        .cart-badge {
            position: absolute;
            top: -8px;
            right: -8px;
            background: #ff3333;
            color: white;
            border-radius: 50%;
            width: 24px;
            height: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.85rem;
            font-weight: bold;
            box-shadow: 0 2px 8px rgba(255, 51, 51, 0.5);
        }

        /* Hero Section */
        .hero {
            margin-top: 70px;
            background: linear-gradient(135deg, #3e2723 0%, #5d4037 100%);
            padding: 5rem 5%;
            text-align: center;
            color: white;
        }

        .hero h1 {
            font-size: 3.5rem;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 8px rgba(0,0,0,0.3);
        }

        .hero p {
            font-size: 1.5rem;
            opacity: 0.9;
            max-width: 800px;
            margin: 0 auto;
        }

        /* About Content */
        .about-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 4rem 5%;
        }

        .about-section {
            background: white;
            border-radius: 20px;
            padding: 3rem;
            margin-bottom: 3rem;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }

        .about-section h2 {
            font-size: 2.5rem;
            color: #3e2723;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .about-section p {
            font-size: 1.2rem;
            color: #555;
            margin-bottom: 1rem;
            line-height: 1.8;
        }

        /* Story Grid */
        .story-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-top: 3rem;
        }

        .story-card {
            background: #f9f9f9;
            padding: 2rem;
            border-radius: 15px;
            text-align: center;
            transition: transform 0.3s;
        }

        .story-card:hover {
            transform: translateY(-10px);
        }

        .story-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
        }

        .story-card h3 {
            color: #3e2723;
            margin-bottom: 1rem;
            font-size: 1.5rem;
        }

        .story-card p {
            color: #666;
            font-size: 1rem;
        }

        /* Values Section */
        .values-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }

        .value-item {
            text-align: center;
            padding: 2rem;
        }

        .value-icon {
            font-size: 3.5rem;
            margin-bottom: 1rem;
        }

        .value-item h3 {
            color: #3e2723;
            margin-bottom: 0.5rem;
            font-size: 1.3rem;
        }

        .value-item p {
            color: #666;
            font-size: 1rem;
        }

        /* Team Section */
        .team-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }

        .team-member {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            text-align: center;
            box-shadow: 0 3px 15px rgba(0,0,0,0.1);
            transition: all 0.3s;
        }

        .team-member:hover {
            transform: translateY(-10px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }

        .team-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            margin: 0 auto 1rem;
            background: linear-gradient(135deg, #ff6f00, #ff8f00);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            color: white;
        }

        .team-member h3 {
            color: #3e2723;
            margin-bottom: 0.5rem;
        }

        .team-role {
            color: #ff6f00;
            font-weight: bold;
            margin-bottom: 1rem;
        }

        .team-member p {
            color: #666;
            font-size: 0.95rem;
        }

        /* Contact Section */
        .contact-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }

        .contact-card {
            background: #f9f9f9;
            padding: 2rem;
            border-radius: 15px;
            text-align: center;
        }

        .contact-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
        }

        .contact-card h3 {
            color: #3e2723;
            margin-bottom: 0.5rem;
        }

        .contact-card p {
            color: #666;
            font-size: 1.1rem;
        }

        /* CTA Section */
        .cta-section {
            background: linear-gradient(135deg, #3e2723 0%, #5d4037 100%);
            color: white;
            text-align: center;
            padding: 4rem 2rem;
            border-radius: 20px;
            margin-top: 3rem;
        }

        .cta-section h2 {
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }

        .cta-section p {
            font-size: 1.3rem;
            margin-bottom: 2rem;
            opacity: 0.9;
        }

        .cta-button {
            display: inline-block;
            background: #ff6f00;
            color: white;
            padding: 1rem 3rem;
            border-radius: 50px;
            text-decoration: none;
            font-size: 1.2rem;
            font-weight: bold;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(255, 111, 0, 0.4);
        }

        .cta-button:hover {
            background: #ff8f00;
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(255, 111, 0, 0.6);
        }

        /* Footer */
        footer {
            background: #3e2723;
            color: white;
            text-align: center;
            padding: 2rem;
            margin-top: 3rem;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .hero h1 {
                font-size: 2.5rem;
            }

            .about-section {
                padding: 2rem;
            }

            .about-section h2 {
                font-size: 2rem;
            }

            nav ul {
                gap: 0.5rem;
            }

            nav ul li a {
                padding: 0.5rem;
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>
    <%@ include file="navbar-component.jsp" %>

    <!-- Hero Section -->
    <div class="hero">
        <h1>☕ Tentang Beans & Brew</h1>
        <p>Lebih dari sekadar kopi, kami adalah komunitas yang berbagi passion untuk kualitas dan kehangatan</p>
    </div>

    <!-- About Content -->
    <div class="about-content">
        <!-- Our Story -->
        <div class="about-section">
            <h2>📖 Cerita Kami</h2>
            <p>Beans & Brew didirikan pada tahun 2020 dengan visi sederhana: menyajikan kopi berkualitas tinggi dengan suasana yang hangat dan ramah. Berawal dari kecintaan kami terhadap kopi dan keinginan untuk berbagi pengalaman terbaik dengan setiap pelanggan.</p>
            <p>Kami percaya bahwa setiap cangkir kopi memiliki cerita - dari petani yang menanam biji kopi, barista yang meraciknya, hingga Anda yang menikmatinya. Itulah mengapa kami hanya menggunakan biji kopi pilihan terbaik dan melatih barista kami dengan standar internasional.</p>
            
            <div class="story-grid">
                <div class="story-card">
                    <div class="story-icon">🌱</div>
                    <h3>2020</h3>
                    <p>Beans & Brew pertama kali dibuka dengan satu outlet kecil dan mimpi besar</p>
                </div>
                <div class="story-card">
                    <div class="story-icon">☕</div>
                    <h3>2021</h3>
                    <p>Meluncurkan signature menu Iced Coffee yang langsung jadi favorit pelanggan</p>
                </div>
                <div class="story-card">
                    <div class="story-icon">🏆</div>
                    <h3>2024</h3>
                    <p>Melayani lebih dari 50,000 pelanggan dan terus berkembang</p>
                </div>
            </div>
        </div>

        <!-- Our Values -->
        <div class="about-section">
            <h2>💎 Nilai-Nilai Kami</h2>
            <div class="values-grid">
                <div class="value-item">
                    <div class="value-icon">⭐</div>
                    <h3>Kualitas Premium</h3>
                    <p>Hanya menggunakan biji kopi terbaik dari berbagai penjuru dunia</p>
                </div>
                <div class="value-item">
                    <div class="value-icon">❤️</div>
                    <h3>Pelayanan Terbaik</h3>
                    <p>Setiap pelanggan adalah bagian dari keluarga Beans & Brew</p>
                </div>
                <div class="value-item">
                    <div class="value-icon">🌍</div>
                    <h3>Berkelanjutan</h3>
                    <p>Komitmen terhadap lingkungan dan petani kopi lokal</p>
                </div>
                <div class="value-item">
                    <div class="value-icon">🎨</div>
                    <h3>Inovasi</h3>
                    <p>Terus berinovasi menghadirkan menu dan pengalaman baru</p>
                </div>
            </div>
        </div>

        <!-- Our Team -->
        <div class="about-section">
            <h2>👥 Tim Kami</h2>
            <p>Dibalik setiap cangkir kopi yang sempurna, ada tim yang passionate dan berdedikasi</p>
            
            <div class="team-grid">
                <div class="team-member">
                    <div class="team-avatar">👨‍💼</div>
                    <h3>Arif Wijaya</h3>
                    <div class="team-role">Founder & CEO</div>
                    <p>Pencinta kopi yang bermimpi membawa pengalaman kopi terbaik ke Indonesia</p>
                </div>
                <div class="team-member">
                    <div class="team-avatar">👩‍🍳</div>
                    <h3>Sarah Lestari</h3>
                    <div class="team-role">Head Barista</div>
                    <p>Ahli dalam seni meracik kopi dengan pengalaman internasional</p>
                </div>
                <div class="team-member">
                    <div class="team-avatar">👨‍🔬</div>
                    <h3>Budi Santoso</h3>
                    <div class="team-role">Coffee Sourcing Manager</div>
                    <p>Memastikan setiap biji kopi yang kami gunakan adalah yang terbaik</p>
                </div>
            </div>
        </div>

        <!-- Contact Info -->
        <div class="about-section">
            <h2>📍 Hubungi Kami</h2>
            <div class="contact-info">
                <div class="contact-card">
                    <div class="contact-icon">📍</div>
                    <h3>Alamat</h3>
                    <p>Jl. Kopi Nikmat No. 123<br>Jakarta Selatan, 12345</p>
                </div>
                <div class="contact-card">
                    <div class="contact-icon">📞</div>
                    <h3>Telepon</h3>
                    <p>+62 812-3456-7890<br>+62 21-1234-5678</p>
                </div>
                <div class="contact-card">
                    <div class="contact-icon">📧</div>
                    <h3>Email</h3>
                    <p>hello@beansbrew.com<br>info@beansbrew.com</p>
                </div>
                <div class="contact-card">
                    <div class="contact-icon">⏰</div>
                    <h3>Jam Buka</h3>
                    <p>Senin - Jumat: 07:00 - 22:00<br>Sabtu - Minggu: 08:00 - 23:00</p>
                </div>
            </div>
        </div>

        <!-- CTA Section -->
        <div class="cta-section">
            <h2>Siap Mencoba Kopi Kami?</h2>
            <p>Kunjungi kami atau pesan online sekarang!</p>
            <a href="menu" class="cta-button">Lihat Menu</a>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <p>&copy; 2024 Beans & Brew. All rights reserved. Made with ❤️ and ☕</p>
    </footer>

    <script>
        function updateCartBadge() {
            const cart = sessionStorage.getItem('cart');
            const cartArray = cart ? JSON.parse(cart) : [];
            const totalItems = cartArray.reduce((sum, item) => sum + item.quantity, 0);
            const badge = document.getElementById('cartBadge');
            badge.textContent = totalItems;
            
            if (totalItems > 0) {
                badge.style.display = 'flex';
            } else {
                badge.style.display = 'none';
            }
        }

        document.addEventListener('DOMContentLoaded', function() {
            updateCartBadge();
        });
    </script>
</body>
</html>