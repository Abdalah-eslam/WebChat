<%@page import="Models.Conversation"%>
<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="DTO.ConvesartionData" %>

<%
    Integer count = (Integer) request.getAttribute("Count");

    List<ConvesartionData> conversations =
            (List<ConvesartionData>) request.getAttribute("ConversationData");

    String Username = (String) session.getAttribute("username");

    Integer Id = (Integer) session.getAttribute("id");

    if (Username == null) {
        Username = "User";
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

            font-family:
                'Inter',
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


        /* =========================
           User Area
           ========================= */

        .user-area {

            display: flex;

            align-items: center;

            gap: 12px;

        }


        .username {

            display: flex;

            align-items: center;

            gap: 7px;

            font-size: 13.5px;

            color: var(--text-muted);

        }


        .username strong {

            color: var(--text);

            font-weight: 500;

        }


        .active-dot {

            width: 7px;
            height: 7px;

            background: #3b82f6;

            border-radius: 50%;

            box-shadow:
                0 0 0 3px rgba(59, 130, 246, 0.12);

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
           Create Conversation Card
           ========================= */

        .create-card {

            display: block;

            width: 100%;

            padding: 24px;

            background: var(--panel);

            border: 1px dashed var(--accent-dim);

            text-decoration: none;

            color: var(--text);

            text-align: left;

            font-family: inherit;

            cursor: pointer;

            transition:
                border-color 0.15s ease,
                transform 0.15s ease,
                background 0.15s ease;

        }


        .create-card:hover {

            border-color: var(--accent);

            background: #191e27;

            transform: translateY(-2px);

        }


        .create-card .chat-icon {

            background: rgba(232, 183, 90, 0.12);

        }


        /* =========================
           Empty State
           ========================= */

        .empty-state {

            grid-column: 1 / -1;

            padding: 45px 24px;

            text-align: center;

            background: var(--panel);

            border: 1px solid var(--border);

        }


        .empty-state h3 {

            margin: 0 0 8px;

            font-family: 'Space Grotesk', sans-serif;

            font-size: 18px;

        }


        .empty-state p {

            margin: 0;

            color: var(--text-muted);

            font-size: 13.5px;

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
           Create Modal
           ========================= */

        .modal-overlay {

            position: fixed;

            inset: 0;

            display: flex;

            align-items: center;

            justify-content: center;

            background: rgba(0, 0, 0, 0.65);

            z-index: 1000;

            opacity: 0;

            visibility: hidden;

            transition:
                opacity 0.2s ease,
                visibility 0.2s ease;

        }


        .modal-overlay.active {

            opacity: 1;

            visibility: visible;

        }


        .modal {

            width: min(500px, calc(100% - 40px));

            background: var(--panel);

            border: 1px solid var(--border);

            padding: 28px;

            box-shadow:
                0 20px 60px rgba(0, 0, 0, 0.45);

            transform: translateY(10px);

            transition: transform 0.2s ease;

        }


        .modal-overlay.active .modal {

            transform: translateY(0);

        }


        /* =========================
           Modal Header
           ========================= */

        .modal-header {

            display: flex;

            align-items: flex-start;

            justify-content: space-between;

            margin-bottom: 28px;

        }


        .modal-header h2 {

            margin: 0 0 6px;

            font-family: 'Space Grotesk', sans-serif;

            font-size: 21px;

            font-weight: 600;

        }


        .modal-header p {

            margin: 0;

            font-size: 13px;

            color: var(--text-muted);

        }


        .close-btn {

            border: none;

            background: transparent;

            color: var(--text-faint);

            font-size: 25px;

            cursor: pointer;

            line-height: 1;

            padding: 0;

        }


        .close-btn:hover {

            color: var(--text);

        }


        /* =========================
           Form
           ========================= */

        .form-group {

            margin-bottom: 20px;

        }


        .form-group label {

            display: block;

            margin-bottom: 8px;

            font-size: 12px;

            color: var(--text-muted);

            font-weight: 500;

        }


        .form-group input,
        .form-group textarea {

            width: 100%;

            padding: 12px 13px;

            background: var(--bg);

            border: 1px solid var(--border);

            color: var(--text);

            font-family: 'Inter', sans-serif;

            font-size: 13.5px;

            outline: none;

            border-radius: 3px;

            transition: border-color 0.15s ease;

        }


        .form-group textarea {

            resize: vertical;

            min-height: 100px;

        }


        .form-group input:focus,
        .form-group textarea:focus {

            border-color: var(--accent-dim);

        }


        .form-group input::placeholder,
        .form-group textarea::placeholder {

            color: var(--text-faint);

        }


        /* =========================
           Visibility
           ========================= */

        .visibility-row {

            display: flex;

            align-items: center;

            justify-content: space-between;

            padding: 15px;

            margin-top: 8px;

            background: var(--bg);

            border: 1px solid var(--border);

        }


        .visibility-info {

            display: flex;

            flex-direction: column;

            gap: 4px;

        }


        .visibility-title {

            font-size: 13px;

            color: var(--text);

        }


        .visibility-description {

            font-size: 11.5px;

            color: var(--text-faint);

        }


        /* =========================
           Switch
           ========================= */

        .switch {

            position: relative;

            width: 42px;

            height: 23px;

            flex-shrink: 0;

        }


        .switch input {

            opacity: 0;

            width: 0;

            height: 0;

        }


        .slider {

            position: absolute;

            inset: 0;

            cursor: pointer;

            background: var(--border);

            border-radius: 20px;

            transition: 0.2s;

        }


        .slider::before {

            content: "";

            position: absolute;

            width: 17px;

            height: 17px;

            left: 3px;

            top: 3px;

            background: var(--text-muted);

            border-radius: 50%;

            transition: 0.2s;

        }


        .switch input:checked + .slider {

            background: var(--accent-dim);

        }


        .switch input:checked + .slider::before {

            transform: translateX(19px);

            background: var(--text);

        }


        /* =========================
           Modal Buttons
           ========================= */

        .modal-actions {

            display: flex;

            justify-content: flex-end;

            gap: 10px;

            margin-top: 25px;

        }


        .cancel-btn,
        .create-btn {

            padding: 11px 17px;

            border-radius: 3px;

            font-family: 'Inter', sans-serif;

            font-size: 12.5px;

            font-weight: 500;

            cursor: pointer;

        }


        .cancel-btn {

            background: transparent;

            border: 1px solid var(--border);

            color: var(--text-muted);

        }


        .cancel-btn:hover {

            color: var(--text);

            border-color: var(--text-faint);

        }


        .create-btn {

            background: var(--accent);

            border: 1px solid var(--accent);

            color: #11141b;

        }


        .create-btn:hover {

            background: #f0c46b;

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

                <span class="active-dot"></span>

                <strong><%= Username %></strong>

            </span>


            <div class="avatar">

                <%= Username.charAt(0) %>

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

                    <%= count != null ? count : 0 %>

                    available

                </span>

            </div>



            <div class="chats-grid">


                <!-- =========================
                     Create Conversation
                     ========================= -->

                <button
                    type="button"
                    class="create-card"
                    onclick="openCreateModal()">


                    <div class="chat-top">

                        <div class="chat-icon">
                            +
                        </div>

                        <span class="arrow">
                            →
                        </span>

                    </div>


                    <h3 class="chat-name">
                        Create Conversation
                    </h3>


                    <p class="chat-description">

                        Create a new public conversation
                        and start talking with others.

                    </p>


                    <div class="chat-bottom">

                        <span class="members">
                            Start something new
                        </span>

                        <span class="public-label">
                            Create
                        </span>

                    </div>


                </button>



                <!-- =========================
                     Conversations
                     ========================= -->

					               <%
					    if (conversations != null && !conversations.isEmpty()) {
					
					        for (ConvesartionData conversation : conversations) {
					        
					%>
					
					            <a href="chat?chatId=<%= conversation.getId() %>"
					               class="chat-card">
					
					                <div class="chat-top">
					
					                    <div class="chat-icon">
					                        #
					                    </div>
					
					                    <span class="arrow">
					                        →
					                    </span>
					
					                </div>
					
					                <h3 class="chat-name">
					                    <%=
					                    conversation.getName()
					                    %>
					                </h3>
					
					                <p class="chat-description">
					                    <%= conversation.getDescription() %>
					                </p>
					
					                <div class="chat-bottom">
					
					                    <span class="members">
					                        <%= conversation.getUsercount() %> members
					                    </span>
					
					                    <span class="public-label">
					                        Public
					                    </span>
					                </div>
					
					            </a>
					            
					            
					
					<%
					
					
					        }
					
					    } else {
					%>
					
					        <div class="empty-state">
					
					            <h3>No conversations yet</h3>
					ء
					            <p>
					                There are no public conversations available.
					                Create the first one and start chatting.
					            </p>
					
					        </div>
					
					<%
					    }
					%>


                    <!-- Empty State -->

                    <div class="empty-state">

                        <h3>
                            No conversations yet
                        </h3>

                        <p>

                            There are no public conversations available.
                            Create the first one and start chatting.

                        </p>

                    </div>


            </div>

        </section>



        <!-- Footer -->

        <footer class="footer">

            © <%= java.time.Year.now().getValue() %>

            WbChat. Built for people who finish things.

        </footer>


    </main>



    <!-- =========================
         Create Conversation Modal
         ========================= -->

    <div
        class="modal-overlay"
        id="createModal">


        <div class="modal">


            <!-- Modal Header -->

            <div class="modal-header">

                <div>

                    <h2>
                        Create Conversation
                    </h2>

                    <p>
                        Start a new conversation with others.
                    </p>

                </div>


                <button
                    type="button"
                    class="close-btn"
                    onclick="closeCreateModal()">

                    ×

                </button>

            </div>



            <!-- Form -->

            <form
                action="create_Conversation"
                method="post">


                <!-- Conversation Name -->

                <div class="form-group">

                    <label for="conversationName">
                        Conversation Name
                    </label>


                    <input
                        type="text"
                        id="conversationName"
                        name="name"
                        placeholder="e.g. Java Developers"
                        required>

                </div>



                <!-- Description -->

                <div class="form-group">

                    <label for="conversationDescription">
                        Description
                    </label>


                    <textarea
                        id="conversationDescription"
                        name="description"
                        placeholder="What is this conversation about?"
                        rows="4"
                        required></textarea>

                </div>



                <!-- Public / Private -->

                <div class="visibility-row">


                    <div class="visibility-info">

                        <span class="visibility-title">
                            Public conversation
                        </span>


                        <span class="visibility-description">
                            Anyone can join this conversation
                        </span>

                    </div>



                    <label class="switch">


                        <input
                            type="checkbox"
                            name="isPublic"
                            value="true"
                            checked>


                        <span class="slider"></span>


                    </label>


                </div>



                <!-- Buttons -->

                <div class="modal-actions">


                    <button
                        type="button"
                        class="cancel-btn"
                        onclick="closeCreateModal()">

                        Cancel

                    </button>


                    <button
                        type="submit"
                        class="create-btn">

                        Create Conversation

                    </button>


                </div>


            </form>


        </div>

    </div>



    <!-- =========================
         JavaScript
         ========================= -->

    <script>


        function openCreateModal() {

            document
                .getElementById("createModal")
                .classList.add("active");

        }



        function closeCreateModal() {

            document
                .getElementById("createModal")
                .classList.remove("active");

        }



        // Close modal when clicking outside

        document
            .getElementById("createModal")
            .addEventListener("click", function(event) {

                if (event.target === this) {

                    closeCreateModal();

                }

            });



        // Close modal with Escape

        document.addEventListener("keydown", function(event) {

            if (event.key === "Escape") {

                closeCreateModal();

            }

        });


    </script>


</body>

</html>