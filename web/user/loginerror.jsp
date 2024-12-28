
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <style>
        body {
            margin: 0;
            font-family: 'Arial', sans-serif;
            background: linear-gradient(rgba(10, 6, 136, 0.283), rgba(2, 11, 134, 0.753)),
                        url('https://wallpaper.forfun.com/fetch/38/383cc8d3db5388017fc7aabc0de6c003.jpeg') no-repeat center center fixed;
            background-size: cover;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .container {
            background: rgba(255, 255, 255, 0.95);
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.3);
            text-align: center;
            max-width: 400px;
            width: 90%;
            backdrop-filter: blur(10px);
        }

        .icon {
            width: 80px;
            height: 80px;
            background: #e6f0ff;
            border-radius: 50%;
            margin: 0 auto 1.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .icon svg {
            width: 40px;
            height: 40px;
            fill: #0052cc;
        }

        h1 {
            color: #172b4d;
            margin-bottom: 1rem;
            font-size: 24px;
        }

        p {
            color: #5e6c84;
            margin-bottom: 2rem;
            line-height: 1.5;
        }

        .btn {
            background: #0052cc;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s;
            text-decoration: none;
            display: inline-block;
        }

        .btn:hover {
            background: #0047b3;
        }

        .help-link {
            display: block;
            margin-top: 1rem;
            color: #0052cc;
            text-decoration: none;
            font-size: 14px;
        }

        .help-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="icon">
            <svg viewBox="0 0 24 24">
                <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-2h2v2zm0-4h-2V7h2v6z"/>
            </svg>
        </div>
        <h1>Login Failed</h1>
        <p>Sorry, we couldn't log you in. Please check your username and password and try again.</p>
        <a href="Userlogin.jsp" class="btn">Back to Login</a>
        <a href="contactus.jsp" class="help-link">Need help?</a>
    </div>
</body>
</html>
