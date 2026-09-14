
<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isErrorPage="false" %>

<%
    String error = (String) request.getAttribute("error");

    String prevEmail = request.getParameter("email");

    if (prevEmail == null) {
        prevEmail = "";
    }
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>WbChat</title>


    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@400;500;600;700&family=Inter:wght@400;500;600&display=swap"
          rel="stylesheet">


    <style>

        :root {

            --bg: #11141b;
            --panel: #171b24;
            --border: #252a35;
            --border-soft: #1e222c;

            --accent: #e8b75a;
            --accent-dim: #b98f43;

            --text: #f3f1ec;
            --text-muted: #8b909c;
            --text-faint: #565b67;

            --danger: #e8735a;

        }


        * {
            box-sizing: border-box;
        }


        html,
        body {

            margin: 0;
            padding: 0;

            background: var(--bg);
            color: var(--text);

            font-family:
                'Inter',
                -apple-system,
                BlinkMacSystemFont,
                'Segoe UI',
                sans-serif;

            min-height: 100vh;

        }


        body {

            display: grid;

            grid-template-columns:
                minmax(280px, 38%) 1fr;

            min-height: 100vh;

        }


        /* =========================
           Left Brand Panel
           ========================= */

        .brand-panel {

            position: relative;

            background:
                radial-gradient(
                    circle at 20% 15%,
                    rgba(232, 183, 90, 0.09),
                    transparent 45%
                ),
                var(--panel);

            border-right:
                1px solid var(--border);

            padding: 56px 48px;

            display: flex;

            flex-direction: column;

            justify-content: space-between;

        }


        .brand-mark {

            display: flex;

            align-items: center;

            gap: 10px;

            font-family:
                'Space Grotesk',
                sans-serif;

            font-size: 17px;

            font-weight: 600;

            letter-spacing: 0.01em;

        }


        .brand-mark .dot {

            width: 9px;
            height: 9px;

            background: var(--accent);

            border-radius: 50%;

            flex-shrink: 0;

        }


        .brand-copy {

            max-width: 34ch;

        }


        .brand-copy h1 {

            font-family:
                'Space Grotesk',
                sans-serif;

            font-size: 34px;

            line-height: 1.2;

            font-weight: 600;

            margin: 0 0 18px;

            letter-spacing: -0.01em;

        }


        .brand-copy p {

            font-size: 15px;

            line-height: 1.65;

            color: var(--text-muted);

            margin: 0;

        }


        .brand-rule {

            width: 40px;
            height: 2px;

            background: var(--accent);

            margin-bottom: 22px;

        }


        .brand-footer {

            font-size: 13px;

            color: var(--text-faint);

        }


        /* =========================
           Right Form Panel
           ========================= */

        .form-panel {

            display: flex;

            align-items: center;

            justify-content: center;

            padding: 48px 32px;

        }


        .form-wrap {

            width: 100%;

            max-width: 380px;

        }


        .form-wrap h2 {

            font-family:
                'Space Grotesk',
                sans-serif;

            font-size: 24px;

            font-weight: 600;

            margin: 0 0 8px;

        }


        .form-sub {

            font-size: 14px;

            color: var(--text-muted);

            margin: 0 0 32px;

        }


        .form-sub a {

            color: var(--accent);

            text-decoration: none;

        }


        .form-sub a:hover {

            text-decoration: underline;

        }


        /* =========================
           Error Alert
           ========================= */

        .alert {

            display: flex;

            gap: 10px;

            align-items: flex-start;

            background:
                rgba(232, 115, 90, 0.08);

            border:
                1px solid rgba(232, 115, 90, 0.35);

            color: #f0a493;

            font-size: 13.5px;

            line-height: 1.5;

            padding: 12px 14px;

            margin-bottom: 24px;

        }


        /* =========================
           Fields
           ========================= */

        .field {

            margin-bottom: 20px;

        }


        .field label {

            display: block;

            font-size: 13px;

            color: var(--text-muted);

            margin-bottom: 7px;

        }


        .field input {

            width: 100%;

            background: var(--bg);

            border: 1px solid var(--border);

            color: var(--text);

            font-family:
                'Inter',
                sans-serif;

            font-size: 14.5px;

            padding: 12px 14px;

            border-radius: 3px;

            outline: none;

            transition:
                border-color 0.15s ease;

        }


        .field input::placeholder {

            color: var(--text-faint);

        }


        .field input:focus {

            border-color: var(--accent);

        }


        .field input:focus-visible {

            outline:
                2px solid var(--accent);

            outline-offset: 1px;

        }


        /* =========================
           Email Row
           ========================= */

        .field-row-between {

            display: flex;

            align-items: center;

            justify-content: space-between;

            margin-bottom: 7px;

        }


        .field-row-between label {

            margin-bottom: 0;

        }


        .field-row-between a {

            font-size: 12.5px;

            color: var(--accent);

            text-decoration: none;

        }


        .field-row-between a:hover {

            text-decoration: underline;

        }


        /* =========================
           Remember Me
           ========================= */

        .remember {

            display: flex;

            align-items: center;

            gap: 9px;

            margin: 4px 0 28px;

        }


        .remember input[type="checkbox"] {

            accent-color: var(--accent);

            width: 15px;
            height: 15px;

            flex-shrink: 0;

        }


        .remember label {

            font-size: 13px;

            color: var(--text-muted);

        }


        /* =========================
           Login Button
           ========================= */

        .login-btn {

            width: 100%;

            background: var(--accent);

            color: #17130a;

            border: none;

            font-family:
                'Inter',
                sans-serif;

            font-size: 14.5px;

            font-weight: 600;

            padding: 13px 16px;

            border-radius: 3px;

            cursor: pointer;

            display: flex;

            align-items: center;

            justify-content: center;

            gap: 9px;

            transition:
                background 0.15s ease,
                opacity 0.15s ease;

        }


        .login-btn:hover {

            background: #f0c273;

        }


        .login-btn:focus-visible {

            outline:
                2px solid var(--accent);

            outline-offset: 2px;

        }


        .login-btn:disabled {

            cursor: not-allowed;

            opacity: 0.75;

        }


        /* =========================
           Loading Spinner
           ========================= */

        .spinner {

            width: 17px;
            height: 17px;

            border:
                2px solid rgba(23, 19, 10, 0.30);

            border-top-color:
                #17130a;

            border-radius: 50%;

            animation:
                spin 0.7s linear infinite;

            flex-shrink: 0;

        }


        @keyframes spin {

            to {

                transform: rotate(360deg);

            }

        }


        /* =========================
           Divider
           ========================= */

        .divider {

            display: flex;

            align-items: center;

            gap: 12px;

            margin: 28px 0;

            color: var(--text-faint);

            font-size: 12px;

        }


        .divider::before,
        .divider::after {

            content: "";

            flex: 1;

            height: 1px;

            background: var(--border-soft);

        }


        /* =========================
           Sign In Line
           ========================= */

        .signin-line {

            text-align: center;

            font-size: 13.5px;

            color: var(--text-muted);

        }


        .signin-line a {

            color: var(--text);

            text-decoration: none;

            border-bottom:
                1px solid var(--accent);

            padding-bottom: 1px;

        }


        /* =========================
           Responsive
           ========================= */

        @media (max-width: 860px) {

            body {

                grid-template-columns: 1fr;

            }


            .brand-panel {

                border-right: none;

                border-bottom:
                    1px solid var(--border);

                padding: 36px 28px;

            }


            .brand-copy h1 {

                font-size: 26px;

            }


            .brand-footer {

                display: none;

            }


            .form-panel {

                padding: 40px 24px;

            }

        }


        /* =========================
           Reduced Motion
           ========================= */

        @media (prefers-reduced-motion: reduce) {

            * {

                transition: none !important;

                animation: none !important;

            }

        }

    </style>

</head>


<body>


    <!-- =========================
         Left Brand Panel
         ========================= -->

    <section class="brand-panel">


        <div class="brand-mark">

            <span class="dot"></span>

            WbChat

        </div>


        <div class="brand-copy">


            <div class="brand-rule"></div>


            <h1>

                Good to see you again

            </h1>


            <p>

                Pick up where you left off —
                your chats are exactly where
                you left them.

            </p>

        </div>


        <div class="brand-footer">

            &copy;

            <%= java.time.Year.now().getValue() %>

            WbChat.

            Built for people who finish things.

        </div>


    </section>


    <!-- =========================
         Right Form Panel
         ========================= -->

    <section class="form-panel">


        <div class="form-wrap">


            <h2>

                Sign in

            </h2>


            <p class="form-sub">

                New here?

                <a href="register.jsp">

                    Create an account

                </a>

            </p>


            <!-- =========================
                 Error Message
                 ========================= -->

            <%
                if (error != null
                        && !error.trim().isEmpty()) {
            %>

                <div class="alert">

                    ⚠

                    <span>

                        <%= error %>

                    </span>

                </div>

            <%
                }
            %>


            <!-- =========================
                 Login Form
                 ========================= -->

            <form
                action="login"
                method="post"
                id="loginForm"
                novalidate>


                <!-- Email -->

                <div class="field">


                    <label for="email">

                        Email

                    </label>


                    <input
                        type="text"
                        id="email"
                        name="email"
                        placeholder="WbChat ...for example"
                        value="<%= prevEmail %>"
                        required
                        autocomplete="email">

                </div>


                <!-- Password -->

                <div class="field">


                    <div class="field-row-between">


                        <label for="password">

                            Password

                        </label>


                        <a href="forgot-password.jsp">

                            Forgot it?

                        </a>


                    </div>


                    <input
                        type="password"
                        id="password"
                        name="password"
                        placeholder="••••••••"
                        required
                        autocomplete="current-password">

                </div>


                <!-- Remember Me -->

                <div class="remember">


                    <input
                        type="checkbox"
                        id="rememberMe"
                        name="rememberMe">


                    <label for="rememberMe">

                        Keep me signed in

                    </label>


                </div>


                <!-- Login Button -->

                <button
                    type="submit"
                    class="login-btn"
                    id="loginButton">

                    <span id="buttonText">

                        Sign in

                    </span>

                </button>


            </form>


            <!-- Divider -->

            <div class="divider">

                or

            </div>


            <!-- Register -->

            <p class="signin-line">

                Don't have an account?

                <a href="register.jsp">

                    Create one

                </a>

            </p>


        </div>

    </section>


    <!-- =========================
         JavaScript
         ========================= -->

    <script>

        const loginForm =
            document.getElementById("loginForm");

        const loginButton =
            document.getElementById("loginButton");


        loginForm.addEventListener(
            "submit",
            function (event) {

                /*
                 * Browser validation happens
                 * before the submit event when
                 * using normal HTML validation.
                 */

                loginButton.disabled = true;


                loginButton.innerHTML = `
                    <span class="spinner"></span>
                    <span>Signing in...</span>
                `;

            }
        );
        
        
        window.addEventListener("pageshow", function () { loginButton.disabled = false; loginButton.innerHTML = ` <span>Sign in</span> `; });

    </script>


</body>

</html>