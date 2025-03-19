
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="org.example.xpertaconstruction.models.Ressource" %>
<%@ page import="org.example.xpertaconstruction.models.Fournisseur" %>

<%
    Ressource ressource = (Ressource) request.getAttribute("ressource");
    List<Fournisseur> fournisseurs = (List<Fournisseur>) request.getAttribute("fournisseurs");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>mise a jour  Ressource</title>
</head>
<body>

<div >
    <h2>mise a jour Ressource</h2>

    <% if (request.getAttribute("error") != null) { %>

        <%= request.getAttribute("error") %>

    <% } %>

    <form action="<%= request.getContextPath() %>/RessourceServlet" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="<%= ressource.getId() %>">

        <div >
            <label for="nom">Nom:</label>
            <input type="text"  id="nom" name="nom" value="<%= ressource.getNom() %>" required>
        </div>
        <div >
            <label for="type">Type:</label>
            <input type="text"  id="type" name="type" value="<%= ressource.getType() %>" required>
        </div>
        <div >
            <label for="quantite">Quantite:</label>
            <input type="number"  id="quantite" name="quantite" value="<%= ressource.getQuantite() %>" required>
        </div>
        <div >
            <label for="unite">Unite:</label>
            <input type="text"  id="unite" name="unite" value="<%= ressource.getUnite() %>" required>
        </div>
        <div >
            <label for="description">Description:</label>
            <textarea  id="description" name="description"><%= ressource.getDescription() != null ? ressource.getDescription() : "" %></textarea>
        </div>
        <div >
            <label for="fournisseurId">Fournisseur:</label>
            <select  id="fournisseurId" name="fournisseurId" required>
                <% for (Fournisseur fournisseur : fournisseurs) { %>
                <option value="<%= fournisseur.getId() %>" <%= ressource.getFournisseurId() == fournisseur.getId() ? "selected" : "" %>><%= fournisseur.getNom() %></option>
                <% } %>
            </select>
        </div>

        <button type="submit" >mise a jour Ressource</button>
        <a href="<%= request.getContextPath() %>/RessourceServlet?action=list" >annuler</a>
    </form>
</div>
</body>
</html>