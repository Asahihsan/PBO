    <%-- 
    Document   : login.jsp
    Created on : Jan 7, 2026
    Author     : kenas
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Beans & Brew Professional</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        :root {
            --primary-dark: #2d1b14;
            --accent-color: #d4a373; /* Gold Coffee */
            --glass-bg: rgba(255, 255, 255, 0.9);
            --transition: all 0.3s cubic-bezier(0.165, 0.84, 0.44, 1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            /* Background Image dengan Overlay Gelap */
            background: linear-gradient(rgba(45, 27, 20, 0.8), rgba(45, 27, 20, 0.8)), 
                        url('https://images.unsplash.com/photo-1497933322477-911066fa7c63?auto=format&fit=crop&q=80&w=2071');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .login-card {
            background: var(--glass-bg);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            border-radius: 30px;
            box-shadow: 0 25px 50px rgba(0,0,0,0.4);
            max-width: 450px;
            width: 100%;
            padding: 3rem;
            position: relative;
            overflow: hidden;
            animation: fadeIn 0.8s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Dekorasi Aksen */
        .login-card::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: var(--accent-color);
        }

        .logo-section {
            text-align: center;
            margin-bottom: 2.5rem;
        }

        .logo-icon {
            font-size: 3rem;
            color: var(--primary-dark);
            margin-bottom: 0.5rem;
            display: inline-block;
            filter: drop-shadow(0 4px 6px rgba(0,0,0,0.1));
        }

        .logo-text {
            font-family: 'Playfair Display', serif;
            font-size: 2.2rem;
            color: var(--primary-dark);
            letter-spacing: 1px;
        }

        .logo-tagline {
            font-size: 0.85rem;
            color: #888;
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-top: 5px;
        }

        .form-group {
            margin-bottom: 1.5rem;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: var(--primary-dark);
            font-weight: 600;
            font-size: 0.9rem;
        }

        .input-wrapper {
            position: relative;
        }

        .input-wrapper i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #aaa;
            transition: var(--transition);
        }

        .form-group input {
            width: 100%;
            padding: 12px 15px 12px 45px;
            border: 1.5px solid #ddd;
            border-radius: 12px;
            font-size: 1rem;
            background: #fff;
            transition: var(--transition);
        }

        .form-group input:focus {
            outline: none;
            border-color: var(--accent-color);
            box-shadow: 0 0 15px rgba(212, 163, 115, 0.2);
        }

        .form-group input:focus + i {
            color: var(--accent-color);
        }

        .login-btn {
            width: 100%;
            background: var(--primary-dark);
            color: white;
            border: none;
            padding: 14px;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            margin-top: 10px;
        }

        .login-btn:hover {
            background: #4a2c1f;
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.15);
        }

        .divider {
            text-align: center;
            margin: 2rem 0;
            position: relative;
        }

        .divider::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 0;
            width: 100%;
            height: 1px;
            background: #ddd;
        }

        .divider span {
            background: #fbfbfb; /* Menyamai warna bg card */
            padding: 0 15px;
            position: relative;
            color: #999;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .guest-btn {
            width: 100%;
            background: transparent;
            color: var(--primary-dark);
            border: 2px solid var(--primary-dark);
            padding: 12px;
            border-radius: 12px;
            font-size: 0.95rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
        }

        .guest-btn:hover {
            background: var(--primary-dark);
            color: white;
        }

        .register-link {
            text-align: center;
            margin-top: 2rem;
            font-size: 0.9rem;
            color: #666;
        }

        .register-link a {
            color: var(--accent-color);
            text-decoration: none;
            font-weight: 700;
        }

        .register-link a:hover {
            text-decoration: underline;
        }

        .back-home {
            text-align: center;
            margin-top: 1.5rem;
        }

        .back-home a {
            color: #888;
            text-decoration: none;
            font-size: 0.85rem;
            transition: var(--transition);
        }

        .back-home a:hover {
            color: var(--primary-dark);
        }

        .error-message {
            background: #fdeaea;
            color: #d9534f;
            padding: 12px;
            border-radius: 10px;
            margin-bottom: 1.5rem;
            font-size: 0.85rem;
            text-align: center;
            display: none;
            border: 1px solid #f5c6cb;
        }

        .error-message.show {
            display: block;
            animation: shake 0.4s ease-in-out;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }
    </style>
</head>
<body>

    <div class="login-card">
        <div class="logo-section">
            <div class="logo-icon"><i class="fas fa-coffee"></i></div>
            <h1 class="logo-text">Beans & Brew</h1>
            <p class="logo-tagline">Exquisite Coffee Experience</p>
        </div>

        <div class="error-message" id="errorMessage"></div>

        <form action="login" method="POST" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="email">Email Address</label>
                <div class="input-wrapper">
                    <input type="email" id="email" name="email" placeholder="example@mail.com" required>
                    <i class="fas fa-envelope"></i>
                </div>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <div class="input-wrapper">
                    <input type="password" id="password" name="password" placeholder="••••••••" required>
                    <i class="fas fa-lock"></i>
                </div>
            </div>

            <button type="submit" class="login-btn">Sign In</button>
        </form>

        <div class="divider">
            <span>OR</span>
        </div>

        <form action="login" method="POST">
            <input type="hidden" name="guest" value="true">
            <button type="submit" class="guest-btn">
                <i class="fas fa-user-secret" style="margin-right: 8px;"></i> Continue as Guest
            </button>
        </form>

        <p class="register-link">
            Don't have an account? <a href="register.jsp">Create One</a>
        </p>

        <div class="back-home">
            <a href="index.jsp"><i class="fas fa-arrow-left"></i> Back to Home</a>
        </div>
    </div>

    <script>
        function validateForm() {
            const email = document.getElementById('email').value.trim();
            const password = document.getElementById('password').value.trim();

            if (!email || !password) {
                showError('Email and Password are required!');
                return false;
            }
            return true;
        }

        function showError(message) {
            const errorDiv = document.getElementById('errorMessage');
            errorDiv.textContent = message;
            errorDiv.classList.add('show');
            setTimeout(() => { errorDiv.classList.remove('show'); }, 5000);
        }

        window.onload = function () {
            const urlParams = new URLSearchParams(window.location.search);
            const error = urlParams.get('error');
            if (error === 'invalid') {
                showError('Incorrect Email or Password!');
            } else if (error === 'required') {
                showError('Please login to continue.');
            }
        }
    </script>
</body>
</html>