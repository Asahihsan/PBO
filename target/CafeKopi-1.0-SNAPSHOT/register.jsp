<%-- 
    Document   : register
    Created on : Jan 7, 2026, 8:51:30 AM
    Author     : kenas
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register - Beans & Brew</title>
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

            .register-container {
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

            .register-btn {
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
                margin-top: 1rem;
            }

            .register-btn:hover {
                background: #ff8f00;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(255, 111, 0, 0.3);
            }

            .login-link {
                text-align: center;
                margin-top: 1.5rem;
                color: #666;
            }

            .login-link a {
                color: #ff6f00;
                text-decoration: none;
                font-weight: bold;
            }

            .login-link a:hover {
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

            .error-message, .success-message {
                padding: 1rem;
                border-radius: 10px;
                margin-bottom: 1.5rem;
                display: none;
            }

            .error-message {
                background: #ffebee;
                color: #c62828;
            }

            .success-message {
                background: #e8f5e9;
                color: #2e7d32;
            }

            .error-message.show, .success-message.show {
                display: block;
            }

            .password-hint {
                font-size: 0.85rem;
                color: #999;
                margin-top: 0.3rem;
            }

            @media (max-width: 480px) {
                .register-container {
                    padding: 2rem;
                }
            }
        </style>
    </head>
    <body>
        <div class="register-container">
            <div class="logo-section">
                <div class="logo-icon">☕</div>
                <div class="logo-text">Beans & Brew</div>
                <div class="logo-tagline">Your Perfect Coffee Moment</div>
            </div>

            <h2 class="form-title">Daftar Akun</h2>

            <div class="error-message" id="errorMessage"></div>
            <div class="success-message" id="successMessage"></div>

            <form action="register" method="POST" onsubmit="return validateForm()">
                <div class="form-group">
                    <label for="nama">Nama Lengkap</label>
                    <input type="text" id="nama" name="nama" placeholder="Masukkan nama lengkap" required>
                </div>

                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" placeholder="example@email.com" required>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Minimal 6 karakter" required>
                    <div class="password-hint">Minimal 6 karakter</div>
                </div>

                <div class="form-group">
                    <label for="confirmPassword">Konfirmasi Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Ulangi password" required>
                </div>

                <button type="submit" class="register-btn">Daftar</button>
            </form>

            <div class="login-link">
                Sudah punya akun? <a href="login.jsp">Login di sini</a>
            </div>

            <div class="back-home">
                <a href="index.jsp">← Kembali ke Home</a>
            </div>
        </div>

        <script>
            function validateForm() {
                const nama = document.getElementById('nama').value.trim();
                const email = document.getElementById('email').value.trim();
                const password = document.getElementById('password').value;
                const confirmPassword = document.getElementById('confirmPassword').value;

                if (!nama || !email || !password || !confirmPassword) {
                    showError('Semua field harus diisi!');
                    return false;
                }

                if (password.length < 6) {
                    showError('Password minimal 6 karakter!');
                    return false;
                }

                if (password !== confirmPassword) {
                    showError('Password dan konfirmasi password tidak sama!');
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

            function showSuccess(message) {
                const successDiv = document.getElementById('successMessage');
                successDiv.textContent = message;
                successDiv.classList.add('show');

                setTimeout(() => {
                    window.location.href = 'login.jsp';
                }, 2000);
            }

            // Check if there's message from server
            window.onload = function () {
                const urlParams = new URLSearchParams(window.location.search);
                const error = urlParams.get('error');
                const success = urlParams.get('success');

                if (error === 'exists') {
                    showError('Email sudah terdaftar!');
                } else if (error === 'failed') {
                    showError('Pendaftaran gagal. Silakan coba lagi!');
                } else if (success === 'true') {
                    showSuccess('Pendaftaran berhasil! Silakan login.');
                }
            }
        </script>
    </body>
</html>