<%@ page import="model.User" %>

<!-- Navigation -->
<nav>
    <div class="container">
        <a href="index.jsp" class="logo">
            ? Beans & Brew
        </a>
        <ul>
            <li><a href="index.jsp">Home</a></li>
            <li><a href="menu">Menu</a></li>
            <li class="cart-link">
                <a href="pesanan.jsp">
                    ? Pesanan
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
                <span style="color: white; margin-right: 0.5rem;">
                    <%= navUser.getNama()%>
                </span>
            </li>
            <li><a href="logout" style="background: #ff6f00; padding: 0.5rem 1.5rem; border-radius: 50px;">Logout</a></li>
                <% } else { %>
            <li><a href="login.jsp" style="background: #ff6f00; padding: 0.5rem 1.5rem; border-radius: 50px;">Login</a></li>
                <% }%>
        </ul>
    </div>
</nav>

<style>
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
        display: none;
        align-items: center;
        justify-content: center;
        font-size: 0.85rem;
        font-weight: bold;
        box-shadow: 0 2px 8px rgba(255, 51, 51, 0.5);
        animation: pulse 2s infinite;
    }

    @keyframes pulse {
        0%, 100% {
            transform: scale(1);
        }
        50% {
            transform: scale(1.1);
        }
    }

    @media (max-width: 768px) {
        nav ul {
            gap: 0.5rem;
        }
        nav ul li a {
            padding: 0.5rem;
            font-size: 0.9rem;
        }
    }
</style>