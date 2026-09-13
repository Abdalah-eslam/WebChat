<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="DTO.massagedto" %>
<%@ page import="DTO.Userdto" %>
<%@ page import="DTO.ConvesartionData" %>


<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>WbChat</title>


    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }


        :root {

            --bg: #11141b;

            --panel: #171b24;

            --panel-light: #1d222d;

            --border: #252a35;

            --gold: #e8b75a;

            --gold-dark: #c99b3e;

            --text: #f5f5f5;

            --text-muted: #9298a5;

            --message-other: #202630;

            --message-me: #e8b75a;
        }


        body {

            font-family: Arial, sans-serif;

            background: var(--bg);

            color: var(--text);

            height: 100vh;

            overflow: hidden;
        }


        /* =========================
           MAIN CHAT LAYOUT
        ========================== */

        .chat-page {

            width: 100%;

            height: 100vh;

            display: grid;

            grid-template-columns: 1fr 280px;
        }


        /* =========================
           CHAT MAIN
        ========================== */

        .chat-main {

            min-width: 0;

            min-height: 0;

            display: flex;

            flex-direction: column;

            background: var(--bg);
        }


        /* =========================
           CHAT HEADER
        ========================== */

        .chat-header {

            height: 70px;

            flex-shrink: 0;

            display: flex;

            align-items: center;

            justify-content: space-between;

            padding: 0 25px;

            background: var(--panel);

            border-bottom: 1px solid var(--border);
        }


        .chat-title {

            display: flex;

            align-items: center;

            gap: 12px;
        }


        .chat-avatar {

            width: 42px;

            height: 42px;

            border-radius: 50%;

            background: var(--gold);

            color: #111;

            display: flex;

            align-items: center;

            justify-content: center;

            font-weight: bold;

            font-size: 18px;
        }


        .chat-info h2 {

            font-size: 17px;

            margin-bottom: 4px;
        }


        .chat-info span {

            color: var(--text-muted);

            font-size: 12px;
        }


        /* =========================
           MESSAGES AREA
        ========================== */

        .messages-container {

            flex: 1;

            min-height: 0;

            overflow-y: auto;

            padding: 25px;

            display: flex;

            flex-direction: column;

            gap: 14px;
        }


        /* Scrollbar */

        .messages-container::-webkit-scrollbar {

            width: 7px;
        }


        .messages-container::-webkit-scrollbar-track {

            background: transparent;
        }


        .messages-container::-webkit-scrollbar-thumb {

            background: #303642;

            border-radius: 10px;
        }


        /* =========================
           MESSAGE
        ========================== */

        .message {

            position: relative;

            display: flex;

            align-items: flex-end;

            gap: 9px;

            max-width: 70%;
        }


        .message.other {

            align-self: flex-start;
        }


        .message.me {

            align-self: flex-end;

            flex-direction: row-reverse;
        }


        /* =========================
           AVATAR
        ========================== */

        .message-avatar {

            width: 34px;

            height: 34px;

            flex-shrink: 0;

            border-radius: 50%;

            background: #303642;

            color: white;

            display: flex;

            align-items: center;

            justify-content: center;

            font-size: 13px;

            font-weight: bold;
        }


        .message.me .message-avatar {

            background: var(--gold);

            color: #111;
        }


        /* =========================
           MESSAGE CONTENT
        ========================== */

        .message-content {

            position: relative;

            display: flex;

            flex-direction: column;

            gap: 5px;
        }


        /* Sender */

        .sender-name {

            color: var(--text-muted);

            font-size: 11px;

            margin-left: 4px;
        }


        .message.me .sender-name {

            text-align: right;

            margin-right: 4px;
        }


        /* =========================
           MESSAGE BUBBLE
        ========================== */

        .message-bubble {

            padding: 10px 14px;

            border-radius: 12px;

            background: var(--message-other);

            color: var(--text);

            font-size: 14px;

            line-height: 1.5;

            word-break: break-word;
        }


        .message.me .message-bubble {

            background: var(--message-me);

            color: #111;

            border-bottom-right-radius: 3px;
        }


        .message.other .message-bubble {

            border-bottom-left-radius: 3px;
        }


        /* Time */

        .message-time {

            font-size: 10px;

            color: var(--text-muted);

            margin-left: 5px;
        }


        .message.me .message-time {

            text-align: right;

            margin-right: 5px;
        }


        /* =========================
           EDIT / DELETE MENU
        ========================== */

        .message-actions {

            display: none;

            position: absolute;

            right: 0;

            bottom: calc(100% + 7px);

            z-index: 50;

            gap: 5px;

            padding: 5px;

            background: var(--panel);

            border: 1px solid var(--border);

            border-radius: 7px;

            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.35);
        }


        .message.selected .message-actions {

            display: flex;
        }


        .message-actions form {

            margin: 0;
        }


        .message-action {

            border: none;

            padding: 6px 10px;

            border-radius: 5px;

            background: var(--panel-light);

            color: var(--text);

            cursor: pointer;

            font-size: 11px;
        }


        .message-action:hover {

            background: #2a303c;
        }


        .message-action.delete {

            color: #ff7777;
        }


        /* =========================
           MESSAGE INPUT
        ========================== */

        .input-area {

            flex-shrink: 0;

            padding: 15px 20px;

            background: var(--panel);

            border-top: 1px solid var(--border);
        }


        .message-form {

            width: 100%;

            display: flex;

            align-items: center;

            gap: 10px;
        }


        .message-input {

            flex: 1;

            height: 45px;

            border: 1px solid var(--border);

            border-radius: 10px;

            outline: none;

            padding: 0 15px;

            background: var(--bg);

            color: var(--text);

            font-size: 14px;
        }


        .message-input::placeholder {

            color: var(--text-muted);
        }


        .message-input:focus {

            border-color: var(--gold);
        }


        .send-button {

            height: 45px;

            padding: 0 20px;

            border: none;

            border-radius: 10px;

            background: var(--gold);

            color: #111;

            font-weight: bold;

            cursor: pointer;
        }


        .send-button:hover {

            background: var(--gold-dark);
        }


        /* =========================
           RIGHT MEMBERS SIDEBAR
        ========================== */

        .members-sidebar {

            min-height: 0;

            background: var(--panel);

            border-left: 1px solid var(--border);

            display: flex;

            flex-direction: column;
        }


        .members-header {

            height: 70px;

            flex-shrink: 0;

            display: flex;

            align-items: center;

            padding: 0 20px;

            border-bottom: 1px solid var(--border);
        }


        .members-header h3 {

            font-size: 15px;
        }


        .members-count {

            margin-left: 7px;

            color: var(--text-muted);

            font-size: 12px;
        }


        .members-list {

            flex: 1;

            min-height: 0;

            overflow-y: auto;

            padding: 15px;
        }


        .member {

            display: flex;

            align-items: center;

            gap: 10px;

            padding: 9px;

            border-radius: 8px;
        }


        .member:hover {

            background: var(--panel-light);
        }


        .member-avatar {

            position: relative;

            width: 35px;

            height: 35px;

            flex-shrink: 0;

            border-radius: 50%;

            background: #303642;

            display: flex;

            align-items: center;

            justify-content: center;

            font-size: 12px;

            font-weight: bold;
        }


        .member-info {

            min-width: 0;

            flex: 1;
        }


        .member-name {

            font-size: 13px;

            white-space: nowrap;

            overflow: hidden;

            text-overflow: ellipsis;
        }


        .online-dot {

            width: 8px;

            height: 8px;

            border-radius: 50%;

            background: #4da6ff;

            position: absolute;

            right: 0;

            bottom: 0;

            border: 2px solid var(--panel);
        }


        /* =========================
           EMPTY MESSAGES
        ========================== */

        .empty-messages {

            margin: auto;

            color: var(--text-muted);

            font-size: 14px;
        }


        /* =========================
           EDIT MODAL
        ========================== */

        .edit-modal {

            display: none;

            position: fixed;

            inset: 0;

            z-index: 1000;

            background: rgba(0, 0, 0, 0.65);

            align-items: center;

            justify-content: center;
        }


        .edit-modal.active {

            display: flex;
        }


        .edit-modal-box {

            width: 450px;

            max-width: calc(100% - 30px);

            background: var(--panel);

            border: 1px solid var(--border);

            border-radius: 12px;

            padding: 20px;

            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.5);

            animation: modalAppear 0.15s ease;
        }


        @keyframes modalAppear {

            from {

                opacity: 0;

                transform: scale(0.95);
            }

            to {

                opacity: 1;

                transform: scale(1);
            }
        }


        .edit-modal-header {

            display: flex;

            align-items: center;

            justify-content: space-between;

            margin-bottom: 18px;
        }


        .edit-modal-header h3 {

            font-size: 17px;
        }


        .close-modal {

            width: 30px;

            height: 30px;

            border: none;

            border-radius: 6px;

            background: transparent;

            color: var(--text-muted);

            font-size: 22px;

            cursor: pointer;
        }


        .close-modal:hover {

            background: var(--panel-light);

            color: white;
        }


        #editMessageContent {

            width: 100%;

            min-height: 120px;

            resize: vertical;

            padding: 12px;

            border-radius: 8px;

            border: 1px solid var(--border);

            outline: none;

            background: var(--bg);

            color: var(--text);

            font-family: inherit;

            font-size: 14px;
        }


        #editMessageContent:focus {

            border-color: var(--gold);
        }


        .edit-modal-actions {

            display: flex;

            justify-content: flex-end;

            gap: 8px;

            margin-top: 15px;
        }


        .cancel-edit {

            padding: 9px 15px;

            border: none;

            border-radius: 7px;

            background: var(--panel-light);

            color: var(--text);

            cursor: pointer;
        }


        .save-edit {

            padding: 9px 15px;

            border: none;

            border-radius: 7px;

            background: var(--gold);

            color: #111;

            font-weight: bold;

            cursor: pointer;
        }


        .save-edit:hover {

            background: var(--gold-dark);
        }


        /* =========================
           RESPONSIVE
        ========================== */

        @media (max-width: 800px) {

            .chat-page {

                grid-template-columns: 1fr;
            }


            .members-sidebar {

                display: none;
            }


            .message {

                max-width: 85%;
            }
        }

    </style>

</head>


<body>


<%

    String conversationId =
            request.getParameter("chatId");


    if (conversationId == null) {

        conversationId =
                (String) session.getAttribute("chatId");
    }


    ConvesartionData conversationdata =
    		(ConvesartionData) request.getAttribute("ConversationData");


   


    ArrayList<massagedto> massages =
            (ArrayList<massagedto>)
            request.getAttribute("massages");


    List<Userdto> members =
            (List<Userdto>)
            request.getAttribute("Members");


    String currentUsername =
            (String) session.getAttribute("username");

%>


<div class="chat-page">


    <!-- =================================
         MAIN CHAT
    ================================== -->

    <main class="chat-main">


        <!-- CHAT HEADER -->

        <header class="chat-header">

            <div class="chat-title">


                <div class="chat-avatar">

                    <%

                        if (conversationdata != null) {

                    %>

                        <%= conversationdata.getName()
                                .substring(0, 1)
                                .toUpperCase() %>

                    <%

                        } else {

                    %>

                        C

                    <%

                        }

                    %>

                </div>


                <div class="chat-info">

                    <h2>

                        <%= conversationdata.getName() != null
                                ? conversationdata.getName()
                                : "Conversation" %>

                    </h2>


                    <span>

                        <%= conversationdata.getUsercount() > 0
                                ? conversationdata.getUsercount()
                                : 0 %> members

                    </span>

                </div>

            </div>

        </header>



        <!-- =================================
             MESSAGES
        ================================== -->

        <div
            class="messages-container"
            id="messagesContainer"
        >


            <%

                if (massages != null &&
                    !massages.isEmpty()) {


                    for (massagedto message : massages) {


                        boolean isMe =
                                currentUsername != null &&
                                currentUsername.equals(
                                    message.getSender_username()
                                );


                        String senderName =
                                message.getSender_username();


                        String firstLetter =
                                senderName != null &&
                                !senderName.isEmpty()

                                ? senderName
                                    .substring(0, 1)
                                    .toUpperCase()

                                : "?";

            %>


                <div
                    class="message <%= isMe ? "me" : "other" %>"
                    data-message-id="<%= message.getId() %>"
                >


                    <!-- AVATAR -->

                    <div class="message-avatar">

                        <%= firstLetter %>

                    </div>



                    <!-- CONTENT -->

                    <div class="message-content">


                        <!-- SENDER -->

                        <div class="sender-name">

                            <%= senderName %>

                        </div>



                        <!-- MESSAGE -->

                        <div class="message-bubble">

                            <%= message.getContent() %>

                        </div>



                        <!-- TIME -->

                        <div class="message-time">

                            <%= message.getCreated_at() %>

                        </div>



                        <!-- =================================
                             EDIT / DELETE
                        ================================== -->

                        <%

                            if (isMe) {

                        %>


                            <div class="message-actions">


                                <!-- EDIT -->

                                <button
                                    type="button"
                                    class="message-action edit-button"
                                    data-message-id="<%= message.getId() %>"
                                    data-content="<%= message.getContent() %>"
                                >

                                    Edit

                                </button>



                                <!-- DELETE -->

                                <form
                                    action="deletemassage"
                                    method="post"
                                >


                                    <input
                                        type="hidden"
                                        name="messageId"
                                        value="<%= message.getId() %>"
                                    >


                                    <input
                                        type="hidden"
                                        name="conversationId"
                                        value="<%= conversationId %>"
                                    >


                                    <button
                                        type="submit"
                                        class="message-action delete"
                                    >

                                        Delete

                                    </button>


                                </form>


                            </div>


                        <%

                            }

                        %>


                    </div>

                </div>


            <%

                    }

                } else {

            %>


                <div class="empty-messages">

                    No messages yet. Start the conversation.

                </div>


            <%

                }

            %>


        </div>



        <!-- =================================
             MESSAGE INPUT
        ================================== -->

        <div class="input-area">


            <form
                class="message-form"
                action="Sendmassage"
                method="post"
            >


                <input
                    type="hidden"
                    name="conversationId"
                    value="<%= conversationId %>"
                >


                <input
                    type="text"
                    name="content"
                    class="message-input"
                    placeholder="Write a message..."
                    autocomplete="off"
                    required
                >


                <button
                    type="submit"
                    class="send-button"
                >

                    Send

                </button>


            </form>


        </div>


    </main>



    <!-- =================================
         MEMBERS SIDEBAR
    ================================== -->

    <aside class="members-sidebar">


        <div class="members-header">

            <h3>Members</h3>


            <span class="members-count">

                <%= conversationdata.getUsercount() > 0
                        ? conversationdata.getUsercount()
                        : 0 %>

            </span>

        </div>



        <div class="members-list">


            <%

                if (members != null &&
                    !members.isEmpty()) {


                    for (Userdto member : members) {


                        String username =
                                member.getUsername();


                        String firstLetter =
                                username != null &&
                                !username.isEmpty()

                                ? username
                                    .substring(0, 1)
                                    .toUpperCase()

                                : "?";

            %>


                <div class="member">


                    <div class="member-avatar">

                        <%= firstLetter %>


                        <span class="online-dot"></span>

                    </div>


                    <div class="member-info">


                        <div class="member-name">

                            <%= username %>

                        </div>


                    </div>


                </div>


            <%

                    }

                } else {

            %>


                <div
                    style="
                        color: var(--text-muted);
                        font-size: 13px;
                        padding: 10px;
                    "
                >

                    No members found.

                </div>


            <%

                }

            %>


        </div>


    </aside>


</div>



<!-- =================================
     EDIT MESSAGE MODAL
================================== -->

<div
    class="edit-modal"
    id="editModal"
>


    <div class="edit-modal-box">


        <div class="edit-modal-header">


            <h3>

                Edit Message

            </h3>


            <button
                type="button"
                class="close-modal"
                id="closeEditModal"
            >

                ×

            </button>


        </div>



        <form
            action="editMassage"
            method="post"
            id="editMessageForm"
        >


            <!-- MESSAGE ID -->

            <input
                type="hidden"
                name="messageId"
                id="editMessageId"
            >


            <!-- CONVERSATION ID -->

            <input
                type="hidden"
                name="conversationId"
                value="<%= conversationId %>"
            >


            <!-- MESSAGE CONTENT -->

            <textarea
                name="content"
                id="editMessageContent"
                required
            ></textarea>



            <div class="edit-modal-actions">


                <button
                    type="button"
                    class="cancel-edit"
                    id="cancelEdit"
                >

                    Cancel

                </button>


                <button
                    type="submit"
                    class="save-edit"
                >

                    Save Changes

                </button>


            </div>


        </form>


    </div>


</div>



<script>


    /* =================================
       CLICK OWN MESSAGE
    ================================== */

    const ownMessages =
        document.querySelectorAll(".message.me");


    ownMessages.forEach(message => {


        message.addEventListener(
            "click",
            function(event) {


                /*
                 * Don't close the menu when
                 * clicking Edit/Delete
                 */

                if (
                    event.target.closest(".message-actions")
                ) {

                    return;

                }


                /*
                 * Close all other messages
                 */

                ownMessages.forEach(
                    otherMessage => {

                        if (
                            otherMessage !== message
                        ) {

                            otherMessage
                                .classList
                                .remove("selected");

                        }

                    }
                );


                /*
                 * Toggle current message
                 */

                message.classList.toggle("selected");

            }
        );

    });



    /* =================================
       CLOSE ACTIONS OUTSIDE MESSAGE
    ================================== */

    document.addEventListener(
        "click",
        function(event) {


            if (
                !event.target.closest(".message.me")
            ) {


                ownMessages.forEach(
                    message => {

                        message.classList.remove(
                            "selected"
                        );

                    }
                );

            }

        }
    );



    /* =================================
       EDIT MODAL
    ================================== */

    const editModal =
        document.getElementById("editModal");


    const editMessageId =
        document.getElementById("editMessageId");


    const editMessageContent =
        document.getElementById(
            "editMessageContent"
        );


    const closeEditModal =
        document.getElementById(
            "closeEditModal"
        );


    const cancelEdit =
        document.getElementById(
            "cancelEdit"
        );


    const editButtons =
        document.querySelectorAll(
            ".edit-button"
        );



    /* =================================
       OPEN EDIT MODAL
    ================================== */

    editButtons.forEach(button => {


        button.addEventListener(
            "click",
            function(event) {


                event.stopPropagation();


                /*
                 * Get message ID
                 */

                const messageId =
                    this.dataset.messageId;


                /*
                 * Get old content
                 */

                const content =
                    this.dataset.content;


                /*
                 * Put values inside modal
                 */

                editMessageId.value =
                    messageId;


                editMessageContent.value =
                    content;


                /*
                 * Open modal
                 */

                editModal.classList.add(
                    "active"
                );


                /*
                 * Focus textarea
                 */

                editMessageContent.focus();

            }
        );

    });



    /* =================================
       CLOSE MODAL
    ================================== */

    function closeModal() {

        editModal.classList.remove(
            "active"
        );

    }



    closeEditModal.addEventListener(
        "click",
        closeModal
    );


    cancelEdit.addEventListener(
        "click",
        closeModal
    );



    /* =================================
       CLICK OUTSIDE MODAL
    ================================== */

    editModal.addEventListener(
        "click",
        function(event) {


            if (
                event.target === editModal
            ) {

                closeModal();

            }

        }
    );



    /* =================================
       SCROLL TO LAST MESSAGE
    ================================== */

    const messagesContainer =
        document.getElementById(
            "messagesContainer"
        );


    if (messagesContainer) {

        messagesContainer.scrollTop =
            messagesContainer.scrollHeight;

    }

</script>


</body>

</html>