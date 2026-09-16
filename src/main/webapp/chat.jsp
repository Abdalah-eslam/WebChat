<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="DTO.massagedto" %>
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
       MAIN CHAT
    ========================== */

    .chat-page {
        width: 100%;
        height: 100vh;
    }

    .chat-main {
        width: 100%;
        height: 100vh;
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

    /*
     * When the same user sends multiple
     * messages consecutively.
     */
    .message.continued {
        margin-top: -10px;
    }

    .message.continued .message-avatar {
        visibility: hidden;
    }

    .message.continued .sender-name {
        display: none;
    }

    .message.continued .message-content {
        gap: 0;
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

    /*
     * Make consecutive messages look connected.
     */

    .message.continued.me .message-bubble {
        border-top-right-radius: 3px;
    }

    .message.continued.other .message-bubble {
        border-top-left-radius: 3px;
    }

    /* =========================
       TIME
    ========================== */

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
       EMPTY MESSAGES
    ========================== */

    .empty-messages {
        margin: auto;

        color: var(--text-muted);
        font-size: 14px;
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

        .message {
            max-width: 85%;
        }

        .messages-container {
            padding: 18px;
        }

        .chat-header {
            padding: 0 18px;
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

String currentUsername =
        (String) session.getAttribute("username");

Integer currentUserId =
        (Integer) session.getAttribute("id");

%>

<div class="chat-page">

<main class="chat-main">

    <!-- =================================
         CHAT HEADER
    ================================== -->

    <header class="chat-header">

        <div class="chat-title">

            <div class="chat-avatar">

                <%
                    if (conversationdata != null &&
                        conversationdata.getName() != null &&
                        !conversationdata.getName().isEmpty()) {
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

                    <%
                        if (conversationdata != null &&
                            conversationdata.getName() != null) {
                    %>

                        <%= conversationdata.getName() %>

                    <%
                        } else {
                    %>

                        Conversation

                    <%
                        }
                    %>

                </h2>

                <span>

                    <%
                        if (conversationdata != null) {
                    %>

                        <%= conversationdata.getUsercount() > 0
                                ? conversationdata.getUsercount()
                                : 0 %>

                        members

                    <%
                        }
                    %>

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

                String previousSender =
                        null;

                for (massagedto message : massages) {

                    String senderName =
                            message.getSender_username();

                    boolean isMe =
                            currentUsername != null &&
                            currentUsername.equals(senderName);

                    boolean continued =
                            previousSender != null &&
                            previousSender.equals(senderName);

                    String firstLetter =
                            senderName != null &&
                            !senderName.isEmpty()
                            ? senderName
                                .substring(0, 1)
                                .toUpperCase()
                            : "?";

        %>

            <div
                class="message <%= isMe ? "me" : "other" %> <%= continued ? "continued" : "" %>"
                data-message-id="<%= message.getId() %>"
                data-sender-id="<%= message.getSenderId() %>"
            >

                <div class="message-avatar">

                    <%= firstLetter %>

                </div>


                <div class="message-content">

                    <div class="sender-name">

                        <%= senderName %>

                    </div>


                    <div class="message-bubble">

                        <%= message.getContent() %>

                    </div>


                    <div class="message-time">

                        <%
        String time = "";

        if (message.getCreated_at() != null) {
            String rawTime = message.getCreated_at().toString();

            if (rawTime.length() >= 16) {
                time = rawTime.substring(11, 16);
            }
        }
    %>

    <%= time %>

                    </div>


                    <%

                        if (isMe) {

                    %>

                        <div class="message-actions">

                            <button
                                type="button"
                                class="message-action edit-button"
                                data-message-id="<%= message.getId() %>"
                                data-content="<%= message.getContent() %>"
                            >

                                Edit

                            </button>


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

                    previousSender =
                            senderName;
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
            id="messageForm"
        >

            <input
                type="text"
                id="messageInput"
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
```

</div>

<!-- =================================
     EDIT MESSAGE MODAL
================================== -->

<div
    class="edit-modal"
    id="editModal"
>

```
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

        <input
            type="hidden"
            name="messageId"
            id="editMessageId"
        >


        <input
            type="hidden"
            name="conversationId"
            value="<%= conversationId %>"
        >


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
   CURRENT USER
================================== */

const currentUserId =
    <%= currentUserId != null ? currentUserId : 0 %>;

const currentUsername =
    "<%= currentUsername != null ? currentUsername : "" %>";


/* =================================
   WEBSOCKET CONNECTION
================================== */

const urlParams =
    new URLSearchParams(window.location.search);

const chatId =
    urlParams.get("chatId");

let socket = null;


if (!chatId) {

    console.error(
        "Chat ID was not found in the URL."
    );

} else {

    const protocol =
        window.location.protocol === "https:"
            ? "wss:"
            : "ws:";


    socket = new WebSocket(
        protocol +
        "//" +
        window.location.host +
        "/WbChat/ws?chatId=" +
        encodeURIComponent(chatId)
    );


    socket.onopen = function () {

        console.log(
            "WebSocket connected successfully."
        );

        console.log(
            "Chat ID:",
            chatId
        );

    };


    /*
     * Receive JSON from WebSocket
     */

    socket.onmessage = function (event) {

        try {

            const message =
                JSON.parse(event.data);

            console.log(
                "Message received:",
                message
            );


            addMessageToUI(message);


        } catch (error) {

            console.error(
                "Invalid WebSocket JSON:",
                error
            );

        }

    };


    socket.onerror = function (error) {

        console.error(
            "WebSocket error:",
            error
        );

    };


    socket.onclose = function () {

        console.log(
            "WebSocket connection closed."
        );

    };

}


/* =================================
   ADD MESSAGE TO UI
================================== */

function addMessageToUI(message) {

    const messagesContainer =
        document.getElementById(
            "messagesContainer"
        );


    if (!messagesContainer) {
        return;
    }


    /*
     * Remove empty message text
     * when the first message arrives.
     */

    const emptyMessage =
        messagesContainer.querySelector(
            ".empty-messages"
        );


    if (emptyMessage) {

        emptyMessage.remove();

    }


    const senderId =
        Number(message.senderId);


    const isMe =
        senderId === Number(currentUserId);


    const senderName =
        message.senderUsername ||
        (isMe ? currentUsername : "User");


    /*
     * Check the previous message.
     */

    const previousMessage =
        messagesContainer.lastElementChild;


    let continued = false;


    if (
        previousMessage &&
        previousMessage.classList.contains("message")
    ) {

        const previousSenderId =
            Number(
                previousMessage.dataset.senderId
            );


        if (
            previousSenderId === senderId
        ) {

            continued = true;

        }

    }


    /*
     * Create main message element.
     */

    const messageElement =
        document.createElement("div");


    messageElement.classList.add(
        "message"
    );


    messageElement.classList.add(
        isMe ? "me" : "other"
    );


    if (continued) {

        messageElement.classList.add(
            "continued"
        );

    }


    /*
     * Save useful data.
     */

    if (message.id != null) {

        messageElement.dataset.messageId =
            message.id;

    }


    messageElement.dataset.senderId =
        senderId;


    /*
     * Avatar
     */

    const avatar =
        document.createElement("div");

    avatar.classList.add(
        "message-avatar"
    );


    avatar.textContent =
        senderName &&
        senderName.length > 0
            ? senderName
                .substring(0, 1)
                .toUpperCase()
            : "?";


    /*
     * Message content container
     */

    const messageContent =
        document.createElement("div");

    messageContent.classList.add(
        "message-content"
    );


    /*
     * Sender name
     */

    const senderNameElement =
        document.createElement("div");

    senderNameElement.classList.add(
        "sender-name"
    );

    senderNameElement.textContent =
        senderName;


    /*
     * Message bubble
     */

    const messageBubble =
        document.createElement("div");

    messageBubble.classList.add(
        "message-bubble"
    );

    messageBubble.textContent =
        message.content;


    /*
     * Time
     */

    const messageTime =
        document.createElement("div");

    messageTime.classList.add(
        "message-time"
    );

    const rawTime =
        message.createdAt || "";

    messageTime.textContent =
        rawTime
            ? rawTime.split("T")[1].substring(0, 5)
            : "";

    /*
     * Add elements.
     */

    messageContent.appendChild(
        senderNameElement
    );

    messageContent.appendChild(
        messageBubble
    );

    messageContent.appendChild(
        messageTime
    );


    /*
     * Own message actions.
     */

    if (isMe) {

        const actions =
            document.createElement("div");

        actions.classList.add(
            "message-actions"
        );


        /*
         * Edit button
         */

        if (message.id != null) {

            const editButton =
                document.createElement("button");

            editButton.type =
                "button";

            editButton.classList.add(
                "message-action",
                "edit-button"
            );

            editButton.dataset.messageId =
                message.id;

            editButton.dataset.content =
                message.content;

            editButton.textContent =
                "Edit";


            actions.appendChild(
                editButton
            );


            /*
             * Delete form
             */

            const deleteForm =
                document.createElement("form");

            deleteForm.action =
                "deletemassage";

            deleteForm.method =
                "post";


            const messageIdInput =
                document.createElement("input");

            messageIdInput.type =
                "hidden";

            messageIdInput.name =
                "messageId";

            messageIdInput.value =
                message.id;


            const conversationIdInput =
                document.createElement("input");

            conversationIdInput.type =
                "hidden";

            conversationIdInput.name =
                "conversationId";

            conversationIdInput.value =
                chatId;


            const deleteButton =
                document.createElement("button");

            deleteButton.type =
                "submit";

            deleteButton.classList.add(
                "message-action",
                "delete"
            );

            deleteButton.textContent =
                "Delete";


            deleteForm.appendChild(
                messageIdInput
            );

            deleteForm.appendChild(
                conversationIdInput
            );

            deleteForm.appendChild(
                deleteButton
            );


            actions.appendChild(
                deleteForm
            );

        }


        messageContent.appendChild(
            actions
        );

    }


    messageElement.appendChild(
        avatar
    );

    messageElement.appendChild(
        messageContent
    );


    messagesContainer.appendChild(
        messageElement
    );


    /*
     * Attach click event
     * to own message.
     */

    if (isMe) {

        addOwnMessageClick(
            messageElement
        );

    }


    /*
     * Attach edit event.
     */

    const newEditButton =
        messageElement.querySelector(
            ".edit-button"
        );


    if (newEditButton) {

        newEditButton.addEventListener(
            "click",
            openEditModal
        );

    }


    /*
     * Scroll to bottom.
     */

    messagesContainer.scrollTop =
        messagesContainer.scrollHeight;

}


/* =================================
   SEND MESSAGE WITH WEBSOCKET
================================== */

const messageForm =
    document.getElementById(
        "messageForm"
    );


const messageInput =
    document.getElementById(
        "messageInput"
    );


messageForm.addEventListener(
    "submit",
    function(event) {

        event.preventDefault();


        const content =
            messageInput.value.trim();


        if (!content) {
            return;
        }


        if (
            !socket ||
            socket.readyState !== WebSocket.OPEN
        ) {

            console.error(
                "WebSocket is not connected."
            );

            return;

        }


        socket.send(content);


        console.log(
            "Message sent:",
            content
        );


        messageInput.value = "";


        messageInput.focus();

    }
);


/* =================================
   OWN MESSAGE CLICK
================================== */

function addOwnMessageClick(message) {

    message.addEventListener(
        "click",
        function(event) {

            if (
                event.target.closest(
                    ".message-actions"
                )
            ) {

                return;

            }


            document
                .querySelectorAll(
                    ".message.me"
                )
                .forEach(
                    otherMessage => {

                        if (
                            otherMessage !== message
                        ) {

                            otherMessage.classList.remove(
                                "selected"
                            );

                        }

                    }
                );


            message.classList.toggle(
                "selected"
            );

        }
    );

}


/*
 * Existing messages
 */

document
    .querySelectorAll(".message.me")
    .forEach(
        message => {

            addOwnMessageClick(
                message
            );

        }
    );


/* =================================
   CLOSE ACTIONS OUTSIDE MESSAGE
================================== */

document.addEventListener(
    "click",
    function(event) {

        if (
            !event.target.closest(
                ".message.me"
            )
        ) {

            document
                .querySelectorAll(
                    ".message.me"
                )
                .forEach(
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
    document.getElementById(
        "editModal"
    );


const editMessageId =
    document.getElementById(
        "editMessageId"
    );


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


/* =================================
   OPEN EDIT MODAL
================================== */

function openEditModal(event) {

    event.stopPropagation();


    const button =
        event.currentTarget;


    const messageId =
        button.dataset.messageId;


    const content =
        button.dataset.content;


    editMessageId.value =
        messageId;


    editMessageContent.value =
        content;


    editModal.classList.add(
        "active"
    );


    editMessageContent.focus();

}


/*
 * Existing edit buttons
 */

document
    .querySelectorAll(
        ".edit-button"
    )
    .forEach(
        button => {

            button.addEventListener(
                "click",
                openEditModal
            );

        }
    );


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
   INITIAL SCROLL
================================== */

const messagesContainer =
    document.getElementById(
        "messagesContainer"
    );


if (messagesContainer) {

    requestAnimationFrame(
        function() {

            messagesContainer.scrollTop =
                messagesContainer.scrollHeight;

        }
    );

}

</script>

</body>

</html>
