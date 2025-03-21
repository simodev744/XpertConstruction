<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Ajouter un Fournisseur</title>
</head>
<body>
<div>
    <h2>Ajouter un Fournisseur</h2>

    <% if (request.getAttribute("error") != null) { %>
    <div>
        <p><%= request.getAttribute("error") %></p>
    </div>
    <% } %>

    <form action="<%= request.getContextPath() %>/FournisseurServlet" method="post">
        <input type="hidden" name="action" value="add">
        <div>
            <label for="nom">Nom :</label>
            <input type="text" id="nom" name="nom" required>
        </div>
        <div>
            <label for="contact">Contact :</label>
            <input type="text" id="contact" name="contact">
        </div>
        <div>
            <label for="email">Email :</label>
            <input type="email" id="email" name="email" required>
        </div>
        <div>
            <label for="telephone">Téléphone :</label>
            <input type="text" id="telephone" name="telephone">
        </div>
        <div>
            <label for="adresse">Adresse :</label>
            <textarea id="adresse" name="adresse"></textarea>
        </div>
        <button type="submit">Ajouter Fournisseur</button>
        <a href="<%= request.getContextPath() %>/FournisseurServlet?action=list">Annuler</a>
    </form>
</div>
</body>
</html>
