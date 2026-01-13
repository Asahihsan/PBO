<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Beans & Brew - Artisanal Coffee Experience</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;600;700;800&family=Playfair+Display:wght@700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    
    <style>
        :root {
            --primary: #2d1b14;
            --primary-light: #5d4037;
            --accent: #d4a373;
            --accent-hover: #bc8a5f;
            --text-dark: #1e293b;
            --text-muted: #64748b;
            --bg-light: #fdfaf7;
            --white: #ffffff;
            --transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
            --shadow-lg: 0 25px 50px -12px rgba(45, 27, 20, 0.15);
        }

        /* --- PERBAIKAN CSS LOGO AGAR MENGGUNAKAN GAMBAR --- */
        .logo-container {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 25px;
        }
        .logo-img {
            width: 50px; /* Ukuran logo */
            height: 50px;
            object-fit: contain;
            border-radius: 50%; /* Membuat logo Kopi Deli terlihat rapi */
            background: white; /* Memberi kontras jika background footer gelap */
            padding: 2px;
        }
        /* -------------------------------------------------- */

        * { margin: 0; padding: 0; box-sizing: border-box; scroll-behavior: smooth; }
        body { font-family: 'Plus Jakarta Sans', sans-serif; color: var(--text-dark); background-color: var(--white); overflow-x: hidden; }
        h1, h2, h3, .brand-font { font-family: 'Playfair Display', serif; }
        .section-padding { padding: 120px 8%; }
        .text-center { text-align: center; }
        .section-title { font-size: 3.5rem; color: var(--primary); margin-bottom: 20px; line-height: 1.2; }
        .section-subtitle { color: var(--accent); font-weight: 800; text-transform: uppercase; letter-spacing: 4px; font-size: 0.85rem; margin-bottom: 15px; display: block; }
        .hero { height: 100vh; position: relative; display: flex; align-items: center; justify-content: center; background-image: url('https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?q=80&w=1920'); background-size: cover; background-position: center; background-attachment: fixed; }
        .hero::after { content: ''; position: absolute; inset: 0; background: linear-gradient(to bottom, rgba(0,0,0,0.3), rgba(0,0,0,0.7)); }
        .hero-content { position: relative; z-index: 10; color: white; text-align: center; max-width: 1000px; padding: 0 20px; }
        .hero-content h1 { font-size: 5.5rem; font-weight: 900; margin-bottom: 1.5rem; letter-spacing: -1px; }
        .hero-content p { font-size: 1.4rem; margin-bottom: 3rem; opacity: 0.8; font-weight: 300; }
        .cta-btn { padding: 20px 45px; background: var(--accent); color: white; text-decoration: none; border-radius: 100px; font-weight: 700; transition: var(--transition); display: inline-block; box-shadow: 0 10px 30px rgba(212, 163, 115, 0.3); }
        .cta-btn:hover { transform: translateY(-5px) scale(1.05); background: var(--accent-hover); box-shadow: 0 15px 35px rgba(212, 163, 115, 0.5); }
        .identity { display: flex; align-items: center; gap: 80px; background: var(--bg-light); position: relative; }
        .identity::before { content: 'BREW'; position: absolute; right: 0; top: 20%; font-size: 15rem; font-weight: 900; color: rgba(0,0,0,0.02); z-index: 0; font-family: 'Playfair Display'; }
        .identity-img { flex: 1; position: relative; z-index: 1; }
        .identity-img img { width: 100%; border-radius: 40px 40px 200px 40px; box-shadow: var(--shadow-lg); }
        .identity-text { flex: 1; z-index: 1; }
        .identity-text p { margin-bottom: 25px; color: var(--text-muted); font-size: 1.15rem; line-height: 1.8; }
        .stat-box { display: flex; gap: 40px; margin-top: 40px; padding-top: 30px; border-top: 1px solid rgba(0,0,0,0.05); }
        .stat-item h3 { color: var(--primary); font-size: 2.2rem; font-weight: 800; }
        .stat-item small { color: var(--accent); font-weight: 700; text-transform: uppercase; font-size: 0.75rem; }
        .team-grid { display: grid; grid-template-columns: repeat(5, 1fr); gap: 25px; margin-top: 60px; }
        .team-card { background: white; padding: 30px 20px; border-radius: 30px; transition: var(--transition); box-shadow: 0 10px 30px rgba(0,0,0,0.03); }
        .team-card:hover { transform: translateY(-15px); box-shadow: var(--shadow-lg); }
        .team-img-wrapper { width: 140px; height: 140px; margin: 0 auto 25px; border-radius: 50%; overflow: hidden; border: 4px solid var(--bg-light); transition: var(--transition); }
        .team-card:hover .team-img-wrapper { border-color: var(--accent); transform: scale(1.1); }
        .team-img-wrapper img { width: 100%; height: 100%; object-fit: cover; }
        footer { background: var(--primary); color: white; padding: 100px 8% 40px; position: relative; }
        .footer-grid { display: grid; grid-template-columns: 1.5fr 1fr 1fr 1.5fr; gap: 60px; margin-bottom: 60px; }
        .footer-links h4 { margin-bottom: 30px; font-size: 1.1rem; text-transform: uppercase; letter-spacing: 2px; }
        .footer-links a { color: rgba(255,255,255,0.5); text-decoration: none; transition: 0.3s; font-size: 0.95rem; }
        .footer-links a:hover { color: var(--accent); transform: translateX(10px); display: inline-block; }
        .footer-bottom { text-align: center; padding-top: 40px; border-top: 1px solid rgba(255,255,255,0.05); font-size: 0.9rem; color: rgba(255,255,255,0.3); }
        .map-container { border-radius: 25px; overflow: hidden; height: 220px; filter: grayscale(1) invert(1) opacity(0.5); }
        @media (max-width: 1200px) { .team-grid { grid-template-columns: repeat(3, 1fr); } .footer-grid { grid-template-columns: 1fr 1fr; } .hero-content h1 { font-size: 4rem; } }
        @media (max-width: 768px) { .section-title { font-size: 2.5rem; } .identity { flex-direction: column; gap: 40px; } .team-grid { grid-template-columns: 1fr 1fr; } }
    </style>
</head>
<body>

    <%@ include file="navbar-component.jsp" %>

    <section class="hero">
        <div class="hero-content" data-aos="fade-up" data-aos-duration="1500">
            <span class="section-subtitle" style="color: white; opacity: 0.8;">Premium Roastery</span>
            <h1>The Art of Perfect Brewing</h1>
            <p>Experience the magic in every drop, crafted from the finest Indonesian beans.</p>
            <a href="menu" class="cta-btn">Explore Collections</a>
        </div>
    </section>

    <section id="about" class="section-padding identity">
        <div class="identity-img" data-aos="fade-right">
            <img src="https://images.unsplash.com/photo-1442512595331-e89e73853f31?q=80&w=800" alt="Coffee Identity">
        </div>
        <div class="identity-text" data-aos="fade-left">
            <span class="section-subtitle">Since 2024</span>
            <h2 class="section-title">The Soul of Beans & Brew</h2>
            <p>Beans & Brew lahir dari rasa hormat yang mendalam terhadap perjalanan panjang kopi—mulai dari pemilihan biji yang teliti (Beans) hingga presisi pada hasil ekstraksi akhir (Brew).</p>
            <p>Kami percaya bahwa kopi adalah bahasa universal yang menghubungkan setiap jiwa. Setiap cangkir dikurasi langsung oleh para barista ahli kami untuk memastikan standar tertinggi bagi para penikmat kopi sejati.</p>
            
            <div class="stat-box">
                <div class="stat-item"><h3>15+</h3><small>Coffee Blends</small></div>
                <div class="stat-item"><h3>10k</h3><small>Coffee Lovers</small></div>
                <div class="stat-item"><h3>5</h3><small>Top Baristas</small></div>
            </div>
        </div>
    </section>

    <section class="section-padding text-center">
        <div data-aos="fade-up">
            <span class="section-subtitle">Crafting Your Cup</span>
            <h2 class="section-title">The Masters Behind The Bar</h2>
        </div>
        
        <div class="team-grid">
            <div class="team-card" data-aos="fade-up" data-aos-delay="100">
                <div class="team-img-wrapper"><img src="assets/img/harun.jpeg" alt="Harun Yahya"></div>
                <h3 style="margin-bottom: 5px;">Harun Yahya</h3>
                <span>Founder</span>
            </div>
            <div class="team-card" data-aos="fade-up" data-aos-delay="200">
                <div class="team-img-wrapper"><img src="assets/img/anisa.jpeg" alt="Anisa"></div>
                <h3>Anisa</h3>
                <span>Lead Barista</span>
            </div>
            <div class="team-card" data-aos="fade-up" data-aos-delay="300">
                <div class="team-img-wrapper"><img src="assets/img/isan.jpeg" alt="Isan"></div>
                <h3>Isan</h3>
                <span>Roaster</span>
            </div>
            <div class="team-card" data-aos="fade-up" data-aos-delay="400">
                <div class="team-img-wrapper"><img src="assets/img/pras.jpeg" alt="Maya"></div>
                <h3>Prass</h3>
                <span>Pastry Chef</span>
            </div>
            <div class="team-card" data-aos="fade-up" data-aos-delay="500">
                <div class="team-img-wrapper"><img src="assets/img/lino.jpeg" alt="Rizky"></div>
                <h3>Sabyan</h3>
                <span>Manager</span>
            </div>
        </div>
    </section>

    <footer>
        <div class="footer-grid">
            <div class="footer-about">
                <div class="logo-container">
                    <img src="assets/img/logo.png" alt="Logo Kopi Deli" class="logo-img">
                    <h2 class="brand-font" style="margin-bottom: 0;">Beans & Brew.</h2>
                </div>
                <p style="color: rgba(255,255,255,0.4); line-height: 1.8;">The ultimate destination for coffee enthusiasts seeking quality, comfort, and inspiration in every single cup.</p>
                <div style="display: flex; gap: 20px; margin-top: 30px;">
                    <a href="#" style="color: var(--accent); font-size: 1.4rem;"><i class="fab fa-instagram"></i></a>
                    <a href="#" style="color: var(--accent); font-size: 1.4rem;"><i class="fab fa-facebook"></i></a>
                    <a href="#" style="color: var(--accent); font-size: 1.4rem;"><i class="fab fa-tiktok"></i></a>
                </div>
            </div>
            
            <div class="footer-links">
                <h4>Discovery</h4>
                <ul style="list-style: none;">
                    <li><a href="/">Home</a></li>
                    <li><a href="menu">Our Menu</a></li>
                    <li><a href="#">Our Story</a></li>
                    <li><a href="#">Locations</a></li>
                </ul>
            </div>

            <div class="footer-links">
                <h4>Support</h4>
                <ul style="list-style: none;">
                    <li style="color: rgba(255,255,255,0.4); font-size: 0.9rem; margin-bottom: 10px;"><i class="fas fa-envelope" style="color: var(--accent); margin-right: 10px;"></i> hello@beansbrew.com</li>
                    <li style="color: rgba(255,255,255,0.4); font-size: 0.9rem;"><i class="fas fa-phone" style="color: var(--accent); margin-right: 10px;"></i> +62 812 3456 7890</li>
                </ul>
            </div>

            <div class="footer-map">
                <h4>Roastery Location</h4>
                <div class="map-container">
                    <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3966.2946282928543!2d106.8246473!3d-6.2248231!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x0!2zNsKwMTMnMjkuNCJTIDEwNiw0OScyOC43IkU!5e0!3m2!1sid!2sid!4v1625000000000!5m2!1sid!2sid" width="100%" height="100%" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
                </div>
            </div>
        </div>
        
        <div class="footer-bottom">
            <p>© 2024 Beans & Brew Coffee Roasters. Crafted with passion for coffee lovers.</p>
        </div>
    </footer>

    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
        AOS.init({ duration: 1000, once: true });
    </script>
</body>
</html>