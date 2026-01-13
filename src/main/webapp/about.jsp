<%-- 
    Document   : about.jsp
    Created on : Dec 26, 2025
    Author     : kenas
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tentang Kami - Beans & Brew Professional</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary-dark: #2d1b14;
            --accent-color: #d4a373; /* Warna Gold Coffee */
            --text-light: #fefae0;
            --bg-light: #fafafa;
            --transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--bg-light);
            color: #333;
            overflow-x: hidden;
        }

        /* --- Hero Section with Parallax Effect --- */
        .hero {
            height: 80vh;
            background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), 
                        url('https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?auto=format&fit=crop&q=80&w=2070');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            color: white;
            padding: 0 20px;
        }

        .hero h1 {
            font-family: 'Playfair Display', serif;
            font-size: clamp(3rem, 8vw, 5rem);
            margin-bottom: 1rem;
            letter-spacing: 2px;
        }

        .hero p {
            font-size: 1.2rem;
            max-width: 700px;
            font-weight: 300;
            letter-spacing: 1px;
        }

        /* --- Content Container --- */
        .container {
            max-width: 1200px;
            margin: -100px auto 0;
            padding: 0 20px 100px;
            position: relative;
            z-index: 10;
        }

        /* --- About Section Glassmorphism --- */
        .glass-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 30px;
            padding: 60px;
            box-shadow: 0 20px 50px rgba(0,0,0,0.1);
            margin-bottom: 50px;
        }

        .section-title {
            font-family: 'Playfair Display', serif;
            font-size: 2.5rem;
            color: var(--primary-dark);
            margin-bottom: 30px;
            text-align: center;
            position: relative;
        }

        .section-title::after {
            content: "";
            display: block;
            width: 60px;
            height: 3px;
            background: var(--accent-color);
            margin: 15px auto;
        }

        /* --- Story Grid --- */
        .story-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
            margin-top: 50px;
        }

        .story-card {
            padding: 40px;
            border: 1px solid #eee;
            border-radius: 20px;
            transition: var(--transition);
            background: #fff;
        }

        .story-card:hover {
            transform: translateY(-10px);
            border-color: var(--accent-color);
            box-shadow: 0 15px 30px rgba(212, 163, 115, 0.2);
        }

        .year-label {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--accent-color);
            margin-bottom: 10px;
            display: block;
        }

        /* --- Team Grid --- */
        .team-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 40px;
        }

        .team-member {
            text-align: center;
            group: hover;
        }

        .avatar-wrapper {
            width: 180px;
            height: 180px;
            margin: 0 auto 20px;
            border-radius: 50%;
            overflow: hidden;
            border: 5px solid white;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            transition: var(--transition);
        }

        .team-member:hover .avatar-wrapper {
            transform: scale(1.05);
            border-color: var(--accent-color);
        }

        .team-info h3 {
            font-family: 'Playfair Display', serif;
            font-size: 1.4rem;
            color: var(--primary-dark);
        }

        .role {
            color: var(--accent-color);
            text-transform: uppercase;
            font-size: 0.8rem;
            font-weight: 600;
            letter-spacing: 2px;
            margin-bottom: 10px;
            display: block;
        }

        /* --- Contact Bar --- */
        .contact-bar {
            background: var(--primary-dark);
            color: white;
            padding: 40px;
            border-radius: 20px;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 30px;
            text-align: center;
        }

        .contact-item h4 {
            color: var(--accent-color);
            margin-bottom: 10px;
        }

        /* --- CTA Button --- */
        .btn-premium {
            background: var(--accent-color);
            color: white;
            padding: 18px 45px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            display: inline-block;
            transition: var(--transition);
            border: 2px solid transparent;
            margin-top: 30px;
        }

        .btn-premium:hover {
            background: transparent;
            border-color: var(--accent-color);
            color: var(--accent-color);
            transform: scale(1.05);
        }

        footer {
            background: #1a1a1a;
            color: #777;
            padding: 50px 20px;
            text-align: center;
            font-size: 0.9rem;
        }

        /* --- Animations --- */
        [data-aos] {
            opacity: 0;
            transform: translateY(30px);
            transition: 1s ease-out;
        }

        [data-aos].appeared {
            opacity: 1;
            transform: translateY(0);
        }

        @media (max-width: 768px) {
            .glass-card { padding: 30px; }
            .container { margin-top: -50px; }
        }
    </style>
</head>
<body>

    <%@ include file="navbar-component.jsp" %>

    <section class="hero">
        <h1 data-aos>Crafting Memories</h1>
        <p data-aos>Setiap biji kopi membawa cerita, setiap seduhan menciptakan keajaiban. Selamat datang di dunia Beans & Brew.</p>
    </section>

    <div class="container">
        <div class="glass-card" data-aos>
            <h2 class="section-title">Warisan Kami</h2>
            <div style="max-width: 800px; margin: 0 auto; text-align: center; line-height: 2;">
                <p>Didirikan dengan gairah untuk menghadirkan cita rasa otentik ke tengah kota yang sibuk. Kami berkelana melintasi pegunungan untuk menemukan petani lokal yang berdedikasi tinggi, memastikan setiap cangkir yang Anda nikmati adalah bentuk penghargaan bagi mereka.</p>
            </div>
            
            <div class="story-grid">
                <div class="story-card">
                    <span class="year-label">2020</span>
                    <h3>The Seed</h3>
                    <p>Memulai perjalanan dari sebuah kedai kecil di sudut Jakarta dengan mimpi besar.</p>
                </div>
                <div class="story-card">
                    <span class="year-label">2022</span>
                    <h3>The Roast</h3>
                    <p>Membangun fasilitas roasting sendiri untuk menjaga standar kesegaran biji kopi.</p>
                </div>
                <div class="story-card">
                    <span class="year-label">2024</span>
                    <h3>The Community</h3>
                    <p>Tumbuh bersama 10+ cabang dan menjadi rumah bagi ribuan penikmat kopi.</p>
                </div>
            </div>
        </div>

        <div class="glass-card" data-aos>
            <h2 class="section-title">Para Kurator Rasa</h2>
            <div class="team-grid">
                <div class="team-member">
                    <div class="avatar-wrapper">
                        <img src="https://i.pravatar.cc/200?u=arif" alt="CEO" style="width:100%; filter: grayscale(20%);">
                    </div>
                    <div class="team-info">
                        <span class="role">Founder & CEO</span>
                        <h3>Arif Wijaya</h3>
                    </div>
                </div>
                <div class="team-member">
                    <div class="avatar-wrapper">
                        <img src="https://i.pravatar.cc/200?u=sarah" alt="Barista" style="width:100%; filter: grayscale(20%);">
                    </div>
                    <div class="team-info">
                        <span class="role">Head of Barista</span>
                        <h3>Sarah Lestari</h3>
                    </div>
                </div>
                <div class="team-member">
                    <div class="avatar-wrapper">
                        <img src="https://i.pravatar.cc/200?u=budi" alt="Sourcing" style="width:100%; filter: grayscale(20%);">
                    </div>
                    <div class="team-info">
                        <span class="role">Coffee Specialist</span>
                        <h3>Budi Santoso</h3>
                    </div>
                </div>
            </div>
        </div>

        <div class="contact-bar" data-aos>
            <div class="contact-item">
                <h4>Kunjungi Kami</h4>
                <p>Senopati, Jakarta Selatan</p>
            </div>
            <div class="contact-item">
                <h4>Jam Operasional</h4>
                <p>07:00 - 22:00 WIB</p>
            </div>
            <div class="contact-item">
                <h4>Reservasi</h4>
                <p>+62 812 3456 789</p>
            </div>
        </div>

        <div style="text-align: center; margin-top: 50px;">
            <h2 style="font-family: 'Playfair Display', serif; font-size: 2rem;">Ingin merasakan aromanya?</h2>
            <a href="menu.jsp" class="btn-premium">PESAN SEKARANG</a>
        </div>
    </div>

    <footer>
        <p>&copy; 2026 Beans & Brew. Crafted with Excellence.</p>
    </footer>

    <script>
        // Simple Scroll Animation Observer
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('appeared');
                }
            });
        }, { threshold: 0.1 });

        document.querySelectorAll('[data-aos]').forEach((el) => observer.observe(el));
    </script>
</body>
</html>