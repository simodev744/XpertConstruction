<%@ page import="org.example.xpertaconstruction.models.Fournisseur" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Fournisseur fournisseur = (Fournisseur) request.getAttribute("fournisseur");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Modifier Fournisseur</title>
</head>
<body>
<div>
    <h2>Modifier Fournisseur</h2>

    <% if (request.getAttribute("error") != null) { %>
    <div>
        <p><%= request.getAttribute("error") %></p>
    </div>
    <% } %>

    <form action="<%= request.getContextPath() %>/FournisseurServlet" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="<%= fournisseur.getId() %>">

        <div>
            <label for="nom">Nom :</label>
            <input type="text" id="nom" name="nom" value="<%= fournisseur.getNom() %>" required>
        </div>
        <div>
            <label for="contact">Contact :</label>
            <input type="text" id="contact" name="contact" value="<%= fournisseur.getContact() != null ? fournisseur.getContact() : "" %>">
        </div>
        <div>
            <label for="email">Email :</label>
            <input type="email" id="email" name="email" value="<%= fournisseur.getEmail() %>" required>
        </div>
        <div>
            <label for="telephone">Téléphone :</label>
            <input type="text" id="telephone" name="telephone" value="<%= fournisseur.getTelephone() != null ? fournisseur.getTelephone() : "" %>">
        </div>
        <div>
            <label for="adresse">Adresse :</label>
            <textarea id="adresse" name="adresse"><%= fournisseur.getAdresse() != null ? fournisseur.getAdresse() : "" %></textarea>
        </div>

        <button type="submit">Modifier</button>
        <a href="<%= request.getContextPath() %>/FournisseurServlet?action=list">Annuler</a>
    </form>
</div>
</body>
</html>
