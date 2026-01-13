<%@ page import="model.User" %>

<nav>
    <div class="container">
        <a href="index.jsp" class="logo">
            <img src="assets/img/logo.png" alt="Logo" style="width: 45px; height: 45px; object-fit: contain; border-radius: 50%;">
            Beans & Brew
        </a>
        <ul>
            <li><a href="index.jsp">Home</a></li>
            <li><a href="menu">Menu</a></li>
            <li class="cart-link">
                <a href="pesanan.jsp">
                    <i class="fas fa-shopping-cart"></i> Pesanan
                    <span class="cart-badge" id="cartBadge">0</span>
                </a>
            </li>
            <li><a href="about.jsp">About</a></li>

            <%
                User navUser = (User) session.getAttribute("user");
                boolean navIsLoggedIn = (navUser != null);
            %>

            <% if (navIsLoggedIn) { %>
                <% if ("kasir".equals(navUser.getRole())) { %>
                    <li><a href="dashboard-kasir.jsp">Dashboard</a></li>
                <% } else if ("pelanggan".equals(navUser.getRole())) { %>
                    <li><a href="dashboard-pelanggan.jsp">Riwayat</a></li>
                <% }%>
                <li>
                    <span style="color: white; margin-right: 0.5rem; font-weight: 600;">
                        <%= navUser.getNama()%>
                    </span>
                </li>
                <li><a href="logout" style="background: #ff6f00; padding: 0.5rem 1.5rem; border-radius: 50px; font-weight: bold;">Logout</a></li>
            <% } else { %>
                <li><a href="login.jsp" style="background: #ff6f00; padding: 0.5rem 1.5rem; border-radius: 50px; font-weight: bold;">Login</a></li>
            <% }%>
        </ul>
    </div>
</nav>

<style>
    /* Tambahan agar logo dan teks sejajar rapi */
    .logo {
        display: flex;
        align-items: center;
        gap: 12px; /* Jarak antara gambar logo dan tulisan */
        font-family: 'Playfair Display', serif;
    }

    nav {
        background: linear-gradient(135deg, #3e2723 0%, #5d4037 100%);
        padding: 0.8rem 5%; /* Sedikit lebih ramping */
        position: fixed;
        width: 100%;
        top: 0;
        z-index: 1000;
        box-shadow: 0 4px 20px rgba(0,0,0,0.4);
    }

    nav .container {
        display: flex;
        justify-content: space-between;
        align-items: center;
        max-width: 1400px;
        margin: 0 auto;
    }

    .logo {
        font-size: 1.6rem;
        font-weight: bold;
        color: #fff;
        text-decoration: none;
    }

    nav ul {
        display: flex;
        list-style: none;
        gap: 1.5rem;
        align-items: center;
    }

    nav ul li a {
        color: #fff;
        text-decoration: none;
        font-size: 1rem;
        transition: all 0.3s;
        padding: 0.5rem 0.8rem;
        border-radius: 5px;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    nav ul li a:hover {
        background: rgba(255,255,255,0.1);
        color: #d4a373; /* Warna accent emas */
    }

    .cart-link {
        position: relative;
    }

    .cart-badge {
        position: absolute;
        top: -5px;
        right: -5px;
        background: #ff3333;
        color: white;
        border-radius: 50%;
        width: 20px;
        height: 20px;
        display: none; /* Akan muncul via JS jika ada isi */
        align-items: center;
        justify-content: center;
        font-size: 0.75rem;
        font-weight: bold;
        border: 2px solid #3e2723;
    }

    @media (max-width: 992px) {
        nav ul { gap: 0.5rem; }
        .logo { font-size: 1.2rem; }
        .logo img { width: 35px; height: 35px; }
    }
</style>