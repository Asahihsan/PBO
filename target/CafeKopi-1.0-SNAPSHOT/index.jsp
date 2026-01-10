
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Beans & Brew - Your Perfect Coffee Moment</title>
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

        .logo-icon {
            width: 40px;
            height: 40px;
            object-fit: contain;
        }

        nav ul {
            display: flex;
            list-style: none;
            gap: 2rem;
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

        /* Carousel */
        .carousel {
            margin-top: 70px;
            height: 600px;
            position: relative;
            overflow: hidden;
        }

        .carousel-container {
            display: flex;
            height: 100%;
            transition: transform 0.5s ease-in-out;
        }

        .carousel-slide {
            min-width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            background-size: cover;
            background-position: center;
        }

        .slide1 {
            background: linear-gradient(rgba(62, 39, 35, 0.6), rgba(62, 39, 35, 0.6)),
                        url('assets/img/carousel1.webp') center/cover;
        }

        .slide2 {
            background: linear-gradient(rgba(93, 64, 55, 0.6), rgba(93, 64, 55, 0.6)),
                        url('assets/img/carousel2.webp') center/cover;
        }

        .slide3 {
            background: linear-gradient(rgba(78, 52, 46, 0.6), rgba(78, 52, 46, 0.6)),
                        url('assets/img/carousel3.webp') center/cover;
        }
        

        .carousel-content {
            text-align: center;
            color: white;
            z-index: 2;
            padding: 2rem;
        }

        .carousel-content h1 {
            font-size: 4rem;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 8px rgba(0,0,0,0.5);
            animation: fadeInUp 1s ease-out;
        }

        .carousel-content p {
            font-size: 1.5rem;
            margin-bottom: 2rem;
            text-shadow: 1px 1px 4px rgba(0,0,0,0.5);
            animation: fadeInUp 1s ease-out 0.2s backwards;
        }

        .cta-button {
            display: inline-block;
            padding: 1rem 2.5rem;
            background: #ff6f00;
            color: white;
            text-decoration: none;
            border-radius: 50px;
            font-size: 1.2rem;
            font-weight: bold;
            transition: all 0.3s;
            animation: fadeInUp 1s ease-out 0.4s backwards;
            box-shadow: 0 4px 15px rgba(255, 111, 0, 0.4);
        }

        .cta-button:hover {
            background: #ff8f00;
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(255, 111, 0, 0.6);
        }

        /* Carousel Navigation */
        .carousel-nav {
            position: absolute;
            bottom: 30px;
            left: 50%;
            transform: translateX(-50%);
            display: flex;
            gap: 15px;
            z-index: 3;
        }

        .carousel-dot {
            width: 15px;
            height: 15px;
            border-radius: 50%;
            background: rgba(255,255,255,0.5);
            cursor: pointer;
            transition: all 0.3s;
        }

        .carousel-dot.active {
            background: #ff6f00;
            width: 40px;
            border-radius: 10px;
        }

        /* Arrows */
        .carousel-arrow {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            background: rgba(255,255,255,0.3);
            color: white;
            border: none;
            font-size: 2rem;
            padding: 1rem 1.5rem;
            cursor: pointer;
            transition: all 0.3s;
            z-index: 3;
            border-radius: 5px;
        }

        .carousel-arrow:hover {
            background: rgba(255,111,0,0.8);
        }

        .carousel-arrow.left {
            left: 20px;
        }

        .carousel-arrow.right {
            right: 20px;
        }

        /* Features Section */
        .features {
            padding: 5rem 5%;
            background: #f5f5f5;
        }

        .features h2 {
            text-align: center;
            font-size: 2.5rem;
            margin-bottom: 3rem;
            color: #3e2723;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 2rem;
            max-width: 1400px;
            margin: 0 auto;
        }

        .feature-card {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }

        .feature-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
        }

        .feature-card h3 {
            color: #5d4037;
            margin-bottom: 1rem;
        }

        /* Menu Preview */
        .menu-preview {
            padding: 5rem 5%;
            background: white;
        }

        .menu-preview h2 {
            text-align: center;
            font-size: 2.5rem;
            margin-bottom: 3rem;
            color: #3e2723;
        }

        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            max-width: 1400px;
            margin: 0 auto;
        }

        .menu-item {
            background: #fafafa;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }

        .menu-item:hover {
            transform: scale(1.05);
        }

        .menu-item-image {
            width: 100%;
            height: 250px;
            background: linear-gradient(135deg, #6d4c41 0%, #5d4037 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 5rem;
        }

        .menu-item-content {
            padding: 1.5rem;
        }

        .menu-item h3 {
            color: #3e2723;
            margin-bottom: 0.5rem;
        }

        .menu-item p {
            color: #666;
            margin-bottom: 1rem;
        }

        .menu-item .price {
            font-size: 1.5rem;
            color: #ff6f00;
            font-weight: bold;
        }

        /* Footer */
        footer {
            background: #3e2723;
            color: white;
            text-align: center;
            padding: 2rem;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Responsive */
        @media (max-width: 768px) {
            nav ul {
                gap: 1rem;
            }

            .carousel-content h1 {
                font-size: 2.5rem;
            }

            .carousel-content p {
                font-size: 1.2rem;
            }

            .carousel {
                height: 500px;
            }
        }
    </style>
</head>
<body>
    <%@ include file="navbar-component.jsp" %>

    <!-- Carousel -->
    <div class="carousel">
        <button class="carousel-arrow left" onclick="moveSlide(-1)">‹</button>
        <button class="carousel-arrow right" onclick="moveSlide(1)">›</button>
        
        <div class="carousel-container" id="carouselContainer">
            <div class="carousel-slide slide1">
                <div class="carousel-content">
                    <h1>Where Every Bean Tells a Story</h1>
                    <p>Crafted with passion, served with love</p>
                    <a href="menu" class="cta-button">Explore Menu</a>
                </div>
            </div>
            <div class="carousel-slide slide2">
                <div class="carousel-content">
                    <h1>Brew Your Perfect Moment</h1>
                    <p>From sunrise to sunset, we're here for you</p>
                    <a href="menu" class="cta-button">Order Now</a>
                </div>
            </div>
            <div class="carousel-slide slide3">
                <div class="carousel-content">
                    <h1>More Than Just Coffee</h1>
                    <p>A community, a vibe, a home away from home</p>
                    <a href="about.jsp" class="cta-button">Learn More</a>
                </div>
            </div>
        </div>

        <div class="carousel-nav">
            <div class="carousel-dot active" onclick="goToSlide(0)"></div>
            <div class="carousel-dot" onclick="goToSlide(1)"></div>
            <div class="carousel-dot" onclick="goToSlide(2)"></div>
        </div>
    </div>

    <!-- Features -->
    <section class="features">
        <h2>Why Choose Beans & Brew?</h2>
        <div class="features-grid">
            <div class="feature-card">
                <div class="feature-icon">☕</div>
                <h3>Premium Quality</h3>
                <p>Carefully selected beans from the finest coffee regions around the world</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">👨‍🍳</div>
                <h3>Expert Baristas</h3>
                <p>Passionate baristas crafting your perfect cup every single time</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">🏠</div>
                <h3>Cozy Atmosphere</h3>
                <p>A warm and welcoming space to relax, work, or catch up with friends</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">🍰</div>
                <h3>Delicious Treats</h3>
                <p>Freshly baked pastries and snacks to complement your coffee</p>
            </div>
        </div>
    </section>

    <!-- Menu Preview -->
    <section class="menu-preview">
        <h2>Popular Menu</h2>
        <div class="menu-grid">
            <div class="menu-item">
                <div class="menu-item-image">☕</div>
                <div class="menu-item-content">
                    <h3>Signature Iced Coffee</h3>
                    <p>Rich, bold, and perfectly balanced</p>
                    <div class="price">Rp 25.000</div>
                </div>
            </div>
            <div class="menu-item">
                <div class="menu-item-image">🥤</div>
                <div class="menu-item-content">
                    <h3>Caramel Macchiato</h3>
                    <p>Sweet and creamy perfection</p>
                    <div class="price">Rp 35.000</div>
                </div>
            </div>
            <div class="menu-item">
                <div class="menu-item-image">🍰</div>
                <div class="menu-item-content">
                    <h3>Vanilla Latte</h3>
                    <p>Smooth, sweet, and refreshing</p>
                    <div class="price">Rp 33.000</div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        <p>&copy; 2024 Beans & Brew. All rights reserved. Made with ❤️ and ☕</p>
    </footer>

    <script>
        let currentSlide = 0;
        const slides = document.querySelectorAll('.carousel-slide');
        const dots = document.querySelectorAll('.carousel-dot');
        const container = document.getElementById('carouselContainer');

        function updateCarousel() {
            container.style.transform = `translateX(-${currentSlide * 100}%)`;
            dots.forEach((dot, index) => {
                dot.classList.toggle('active', index === currentSlide);
            });
        }

        function moveSlide(direction) {
            currentSlide += direction;
            if (currentSlide < 0) currentSlide = slides.length - 1;
            if (currentSlide >= slides.length) currentSlide = 0;
            updateCarousel();
        }

        function goToSlide(index) {
            currentSlide = index;
            updateCarousel();
        }

        // Initialize cart badge on page load
        document.addEventListener('DOMContentLoaded', function() {
            updateCartBadge();
        });

        // Auto-slide every 5 seconds
        setInterval(() => {
            moveSlide(1);
        }, 5000);

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
    </script>
</body>
</html>