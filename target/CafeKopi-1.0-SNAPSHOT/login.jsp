<%-- 
    Document   : login
    Created on : Jan 7, 2026, 8:50:57 AM
    Author     : kenas
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login - Beans & Brew</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #3e2723 0%, #5d4037 100%);
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 2rem;
            }

            .login-container {
                background: white;
                border-radius: 20px;
                box-shadow: 0 10px 40px rgba(0,0,0,0.3);
                max-width: 450px;
                width: 100%;
                padding: 3rem;
                animation: slideIn 0.5s ease-out;
            }

            @keyframes slideIn {
                from {
                    opacity: 0;
                    transform: translateY(-30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .logo-section {
                text-align: center;
                margin-bottom: 2rem;
            }

            .logo-icon {
                font-size: 4rem;
                margin-bottom: 1rem;
            }

            .logo-text {
                font-size: 2rem;
                font-weight: bold;
                color: #3e2723;
            }

            .logo-tagline {
                color: #666;
                margin-top: 0.5rem;
            }

            .form-title {
                font-size: 1.8rem;
                color: #3e2723;
                margin-bottom: 2rem;
                text-align: center;
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

            .form-group input {
                width: 100%;
                padding: 1rem;
                border: 2px solid #e0e0e0;
                border-radius: 10px;
                font-size: 1rem;
                transition: all 0.3s;
            }

            .form-group input:focus {
                outline: none;
                border-color: #ff6f00;
                box-shadow: 0 0 0 3px rgba(255, 111, 0, 0.1);
            }

            .login-btn {
                width: 100%;
                background: #ff6f00;
                color: white;
                border: none;
                padding: 1rem;
                border-radius: 50px;
                font-size: 1.1rem;
                font-weight: bold;
                cursor: pointer;
                transition: all 0.3s;
                margin-bottom: 1rem;
            }

            .login-btn:hover {
                background: #ff8f00;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(255, 111, 0, 0.3);
            }

            .guest-btn {
                width: 100%;
                background: white;
                color: #ff6f00;
                border: 2px solid #ff6f00;
                padding: 1rem;
                border-radius: 50px;
                font-size: 1.1rem;
                font-weight: bold;
                cursor: pointer;
                transition: all 0.3s;
                margin-bottom: 1.5rem;
            }

            .guest-btn:hover {
                background: #ff6f00;
                color: white;
            }

            .divider {
                text-align: center;
                margin: 1.5rem 0;
                position: relative;
            }

            .divider::before {
                content: '';
                position: absolute;
                top: 50%;
                left: 0;
                width: 100%;
                height: 1px;
                background: #e0e0e0;
            }

            .divider span {
                background: white;
                padding: 0 1rem;
                position: relative;
                color: #999;
            }

            .register-link {
                text-align: center;
                color: #666;
            }

            .register-link a {
                color: #ff6f00;
                text-decoration: none;
                font-weight: bold;
            }

            .register-link a:hover {
                text-decoration: underline;
            }

            .back-home {
                text-align: center;
                margin-top: 1.5rem;
            }

            .back-home a {
                color: #ff6f00;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
            }

            .back-home a:hover {
                text-decoration: underline;
            }

            .error-message {
                background: #ffebee;
                color: #c62828;
                padding: 1rem;
                border-radius: 10px;
                margin-bottom: 1.5rem;
                display: none;
            }

            .error-message.show {
                display: block;
            }

            @media (max-width: 480px) {
                .login-container {
                    padding: 2rem;
                }
            }
        </style>
    </head>
    <body>
        <div class="login-container">
            <div class="logo-section">
                <div class="logo-icon">☕</div>
                <div class="logo-text">Beans & Brew</div>
                <div class="logo-tagline">Your Perfect Coffee Moment</div>
            </div>

            <h2 class="form-title">Login</h2>

            <div class="error-message" id="errorMessage"></div>

            <form action="login" method="POST" onsubmit="return validateForm()">
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" placeholder="masukkan email Anda" required>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="masukkan password Anda" required>
                </div>

                <button type="submit" class="login-btn">Login</button>
            </form>

            <div class="divider">
                <span>ATAU</span>
            </div>

            <form action="login" method="POST">
                <input type="hidden" name="guest" value="true">
                <button type="submit" class="guest-btn">🚶 Login sebagai Guest</button>
            </form>

            <div class="register-link">
                Belum punya akun? <a href="register.jsp">Daftar sekarang</a>
            </div>

            <div class="back-home">
                <a href="index.jsp">← Kembali ke Home</a>
            </div>
        </div>

        <script>
            function validateForm() {
                const email = document.getElementById('email').value.trim();
                const password = document.getElementById('password').value.trim();

                if (!email || !password) {
                    showError('Email dan password harus diisi!');
                    return false;
                }

                return true;
            }

            function showError(message) {
                const errorDiv = document.getElementById('errorMessage');
                errorDiv.textContent = message;
                errorDiv.classList.add('show');

                setTimeout(() => {
                    errorDiv.classList.remove('show');
                }, 5000);
            }

            // Check if there's error from server
            window.onload = function () {
                const urlParams = new URLSearchParams(window.location.search);
                const error = urlParams.get('error');

                if (error === 'invalid') {
                    showError('Email atau password salah!');
                } else if (error === 'required') {
                    showError('Silakan login terlebih dahulu!');
                }
            }
        </script>
    </body>
</html>