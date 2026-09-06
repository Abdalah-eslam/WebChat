<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="false" %>
<%
    String error = (String) request.getAttribute("error");
    String prevEmail = request.getParameter("email");
    if (prevEmail == null) prevEmail = "";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>WbChat</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@400;500;600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
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

  * { box-sizing: border-box; }

  html, body {
    margin: 0;
    padding: 0;
    background: var(--bg);
    color: var(--text);
    font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
    min-height: 100vh;
  }

  body {
    display: grid;
    grid-template-columns: minmax(280px, 38%) 1fr;
    min-height: 100vh;
  }

  /* -------- Left brand panel -------- */
  .brand-panel {
    position: relative;
    background:
      radial-gradient(circle at 20% 15%, rgba(232, 183, 90, 0.09), transparent 45%),
      var(--panel);
    border-right: 1px solid var(--border);
    padding: 56px 48px;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
  }

  .brand-mark {
    display: flex;
    align-items: center;
    gap: 10px;
    font-family: 'Space Grotesk', sans-serif;
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
    font-family: 'Space Grotesk', sans-serif;
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

  /* -------- Right form panel -------- */
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
    font-family: 'Space Grotesk', sans-serif;
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

  .form-sub a:hover { text-decoration: underline; }

  .alert {
    display: flex;
    gap: 10px;
    align-items: flex-start;
    background: rgba(232, 115, 90, 0.08);
    border: 1px solid rgba(232, 115, 90, 0.35);
    color: #f0a493;
    font-size: 13.5px;
    line-height: 1.5;
    padding: 12px 14px;
    margin-bottom: 24px;
  }

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
    font-family: 'Inter', sans-serif;
    font-size: 14.5px;
    padding: 12px 14px;
    border-radius: 3px;
    outline: none;
    transition: border-color 0.15s ease;
  }

  .field input::placeholder { color: var(--text-faint); }

  .field input:focus {
    border-color: var(--accent);
  }

  .field input:focus-visible {
    outline: 2px solid var(--accent);
    outline-offset: 1px;
  }

  .field-row-between {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 7px;
  }

  .field-row-between label { margin-bottom: 0; }

  .field-row-between a {
    font-size: 12.5px;
    color: var(--accent);
    text-decoration: none;
  }

  .field-row-between a:hover { text-decoration: underline; }

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

  button[type="submit"] {
    width: 100%;
    background: var(--accent);
    color: #17130a;
    border: none;
    font-family: 'Inter', sans-serif;
    font-size: 14.5px;
    font-weight: 600;
    padding: 13px 16px;
    border-radius: 3px;
    cursor: pointer;
    transition: background 0.15s ease;
  }

  button[type="submit"]:hover { background: #f0c273; }
  button[type="submit"]:focus-visible {
    outline: 2px solid var(--accent);
    outline-offset: 2px;
  }

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

  .signin-line {
    text-align: center;
    font-size: 13.5px;
    color: var(--text-muted);
  }

  .signin-line a {
    color: var(--text);
    text-decoration: none;
    border-bottom: 1px solid var(--accent);
    padding-bottom: 1px;
  }

  @media (prefers-reduced-motion: reduce) {
    * { transition: none !important; }
  }

  @media (max-width: 860px) {
    body { grid-template-columns: 1fr; }
    .brand-panel {
      border-right: none;
      border-bottom: 1px solid var(--border);
      padding: 36px 28px;
    }
    .brand-copy h1 { font-size: 26px; }
    .brand-footer { display: none; }
    .form-panel { padding: 40px 24px; }
  }
</style>
</head>
<body>

  <section class="brand-panel">
    <div class="brand-mark"><span class="dot"></span>WbChat</div>

    <div class="brand-copy">
      <div class="brand-rule"></div>
      <h1>Good to see you again</h1>
      <p>Pick up where you left off — your chats are exactly where you left them.</p>
    </div>

    <div class="brand-footer">&copy; <%= java.time.Year.now().getValue() %> WbChat. Built for people who finish things.</div>
  </section>

  <section class="form-panel">
    <div class="form-wrap">
      <h2>Sign in</h2>
      <p class="form-sub">New here? <a href="register.jsp">Create an account</a></p>

      <% if (error != null && !error.trim().isEmpty()) { %>
        <div class="alert">⚠ <span><%= error %></span></div>
      <% } %>

      <form action="login" method="post" novalidate>

        <div class="field">
          <label for="email">Email</label>
          <input type="text" id="email" name="email" placeholder="WbChat ...for example"
                 value="<%= prevEmail %>" required autocomplete="email">
        </div>

        <div class="field">
          <div class="field-row-between">
            <label for="password">Password</label>
            <a href="forgot-password.jsp">Forgot it?</a>
          </div>
          <input type="password" id="password" name="password" placeholder="••••••••"
                 required autocomplete="current-password">
        </div>

        <div class="remember">
          <input type="checkbox" id="rememberMe" name="rememberMe">
          <label for="rememberMe">Keep me signed in</label>
        </div>

        <button type="submit">Sign in</button>
      </form>

      <div class="divider">or</div>
      <p class="signin-line">Don't have an account? <a href="register.jsp">Create one</a></p>
    </div>
  </section>

</body>
</html>
