
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
</head>
<body>
<div>
    <form  action="<%= request.getContextPath() %>/AdminServlet" method="post">
        <input type="hidden" name="action" value="login">
        <h2 >connection</h2>
        <% if (request.getAttribute("error") != null) { %>

         erreur--   <%= request.getAttribute("error") %>

        <% } %>
        <label >Username</label>
        <input type="text" id="username" name="username"  placeholder="Admin" required >
        <label for="password" >Mot de passe</label>
        <input type="password" id="password" name="password" required>
        <button type="submit">connection</button>
    </form>
</div>
</body>
</html>