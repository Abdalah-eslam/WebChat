<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>WbChat</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

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

            min-height: 100vh;

            background: var(--bg);
            color: var(--text);

            font-family: 'Inter',
            -apple-system,
            BlinkMacSystemFont,
            'Segoe UI',
            sans-serif;
        }

        body {
            min-height: 100vh;
        }

        /* =========================
           Header
           ========================= */

        .header {

            height: 72px;

            display: flex;
            align-items: center;
            justify-content: space-between;

            padding: 0 48px;

            background: var(--panel);

            border-bottom: 1px solid var(--border);
        }

        .brand-mark {

            display: flex;
            align-items: center;

            gap: 10px;

            font-family: 'Space Grotesk', sans-serif;

            font-size: 17px;
            font-weight: 600;
        }

        .brand-mark .dot {

            width: 9px;
            height: 9px;

            background: var(--accent);

            border-radius: 50%;

            flex-shrink: 0;
        }

        .user-area {

            display: flex;
            align-items: center;

            gap: 12px;
        }

        .username {

            font-size: 13.5px;

            color: var(--text-muted);
        }

        .avatar {

            width: 34px;
            height: 34px;

            display: flex;
            align-items: center;
            justify-content: center;

            background: var(--bg);

            border: 1px solid var(--border);

            border-radius: 50%;

            color: var(--accent);

            font-family: 'Space Grotesk', sans-serif;

            font-size: 13px;
            font-weight: 600;
        }


        /* =========================
           Main
           ========================= */

        .main {

            max-width: 1050px;

            margin: 0 auto;

            padding: 70px 32px 60px;
        }


        /* =========================
           Hero
           ========================= */

        .hero {

            margin-bottom: 48px;
        }

        .hero-rule {

            width: 40px;
            height: 2px;

            background: var(--accent);

            margin-bottom: 20px;
        }

        .hero h1 {

            margin: 0 0 12px;

            font-family: 'Space Grotesk', sans-serif;

            font-size: 34px;

            line-height: 1.2;

            font-weight: 600;

            letter-spacing: -0.01em;
        }

        .hero p {

            margin: 0;

            max-width: 550px;

            font-size: 15px;

            line-height: 1.65;

            color: var(--text-muted);
        }


        /* =========================
           Section Header
           ========================= */

        .section-header {

            display: flex;

            align-items: center;
            justify-content: space-between;

            margin-bottom: 18px;
        }

        .section-title {

            margin: 0;

            font-family: 'Space Grotesk', sans-serif;

            font-size: 17px;

            font-weight: 600;
        }

        .section-count {

            font-size: 12px;

            color: var(--text-faint);
        }


        /* =========================
           Chats Grid
           ========================= */

        .chats-grid {

            display: grid;

            grid-template-columns: repeat(2, 1fr);

            gap: 14px;
        }


        /* =========================
           Chat Card
           ========================= */

        .chat-card {

            display: block;

            padding: 24px;

            background: var(--panel);

            border: 1px solid var(--border);

            text-decoration: none;

            color: var(--text);

            transition:
                border-color 0.15s ease,
                transform 0.15s ease,
                background 0.15s ease;
        }

        .chat-card:hover {

            border-color: var(--accent-dim);

            background: #191e27;

            transform: translateY(-2px);
        }

        .chat-top {

            display: flex;

            align-items: center;
            justify-content: space-between;

            margin-bottom: 18px;
        }

        .chat-icon {

            width: 40px;
            height: 40px;

            display: flex;
            align-items: center;
            justify-content: center;

            background: rgba(232, 183, 90, 0.08);

            border: 1px solid rgba(232, 183, 90, 0.18);

            color: var(--accent);

            font-family: 'Space Grotesk', sans-serif;

            font-size: 17px;

            border-radius: 3px;
        }

        .arrow {

            color: var(--text-faint);

            font-size: 18px;

            transition: color 0.15s ease;
        }

        .chat-card:hover .arrow {

            color: var(--accent);
        }

        .chat-name {

            margin: 0 0 8px;

            font-family: 'Space Grotesk', sans-serif;

            font-size: 18px;

            font-weight: 600;
        }

        .chat-description {

            margin: 0;

            max-width: 480px;

            font-size: 13.5px;

            line-height: 1.55;

            color: var(--text-muted);
        }

        .chat-bottom {

            display: flex;

            align-items: center;

            justify-content: space-between;

            margin-top: 22px;

            padding-top: 15px;

            border-top: 1px solid var(--border-soft);
        }

        .members {

            font-size: 12px;

            color: var(--text-faint);
        }

        .public-label {

            font-size: 11px;

            color: var(--accent-dim);

            text-transform: uppercase;

            letter-spacing: 0.08em;
        }


        /* =========================
           Footer
           ========================= */

        .footer {

            margin-top: 55px;

            padding-top: 20px;

            border-top: 1px solid var(--border-soft);

            text-align: center;

            font-size: 12px;

            color: var(--text-faint);
        }


        /* =========================
           Responsive
           ========================= */

        @media (max-width: 700px) {

            .header {
                padding: 0 24px;
            }

            .main {
                padding: 50px 20px 40px;
            }

            .hero h1 {
                font-size: 28px;
            }

            .chats-grid {
                grid-template-columns: 1fr;
            }

            .username {
                display: none;
            }
        }


        @media (prefers-reduced-motion: reduce) {

            * {
                transition: none !important;
            }
        }

    </style>

</head>


<body>


<!-- =========================
     Header
     ========================= -->

<header class="header">

    <div class="brand-mark">

        <span class="dot"></span>

        WbChat

    </div>


    <div class="user-area">

        <span class="username">
            Welcome back
        </span>

        <div class="avatar">
            A
        </div>

    </div>

</header>



<!-- =========================
     Main Content
     ========================= -->

<main class="main">


    <!-- Hero -->

    <section class="hero">

        <div class="hero-rule"></div>

        <h1>
            Find your conversation
        </h1>

        <p>
            Choose a public chat and join the conversation.
            Everyone is welcome.
        </p>

    </section>



    <!-- Chats -->

    <section>

        <div class="section-header">

            <h2 class="section-title">
                Public chats
            </h2>

            <span class="section-count">
                4 available
            </span>

        </div>



        <div class="chats-grid">


            <!-- General -->

            <a href="chat?chatId=1" class="chat-card">

                <div class="chat-top">

                    <div class="chat-icon">
                        #
                    </div>

                    <span class="arrow">
                        →
                    </span>

                </div>


                <h3 class="chat-name">
                    General
                </h3>

                <p class="chat-description">
                    A place to talk about anything,
                    meet people and start conversations.
                </p>


                <div class="chat-bottom">

                    <span class="members">
                        128 members
                    </span>

                    <span class="public-label">
                        Public
                    </span>

                </div>

            </a>



            <!-- Java -->

            <a href="chat?chatId=2" class="chat-card">

                <div class="chat-top">

                    <div class="chat-icon">
                        #
                    </div>

                    <span class="arrow">
                        →
                    </span>

                </div>


                <h3 class="chat-name">
                    Java
                </h3>

                <p class="chat-description">
                    Discuss Java, OOP, Collections,
                    JDBC, Servlets and everything Java.
                </p>


                <div class="chat-bottom">

                    <span class="members">
                        74 members
                    </span>

                    <span class="public-label">
                        Public
                    </span>

                </div>

            </a>



            <!-- Spring Boot -->

            <a href="chat?chatId=3" class="chat-card">

                <div class="chat-top">

                    <div class="chat-icon">
                        #
                    </div>

                    <span class="arrow">
                        →
                    </span>

                </div>


                <h3 class="chat-name">
                    Spring Boot
                </h3>

                <p class="chat-description">
                    Backend development, Spring Boot,
                    REST APIs and server-side discussions.
                </p>


                <div class="chat-bottom">

                    <span class="members">
                        51 members
                    </span>

                    <span class="public-label">
                        Public
                    </span>

                </div>

            </a>



            <!-- Random -->

            <a href="chat?chatId=4" class="chat-card">

                <div class="chat-top">

                    <div class="chat-icon">
                        #
                    </div>

                    <span class="arrow">
                        →
                    </span>

                </div>


                <h3 class="chat-name">
                    Random
                </h3>

                <p class="chat-description">
                    Anything goes. Share ideas,
                    casual conversations and random topics.
                </p>


                <div class="chat-bottom">

                    <span class="members">
                        32 members
                    </span>

                    <span class="public-label">
                        Public
                    </span>

                </div>

            </a>


        </div>

    </section>



    <!-- Footer -->

    <footer class="footer">

        © <%= java.time.Year.now().getValue() %>
        WbChat. Built for people who finish things.

    </footer>


</main>


</body>

</html>
