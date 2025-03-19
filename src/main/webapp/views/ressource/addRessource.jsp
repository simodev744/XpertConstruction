
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.xpertaconstruction.models.Fournisseur" %>

<%
    List<Fournisseur> fournisseurs = (List<Fournisseur>) request.getAttribute("fournisseurs");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Ressource</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/bootstrap.min.css">    <style>
        body { padding-top: 20px; }
    </style>
</head>
<body>

<div >
    <h2>Ajouter Ressource</h2>

    <% if (request.getAttribute("error") != null) { %>

        <%= request.getAttribute("error") %>

    <% } %>

    <form action="<%= request.getContextPath() %>/RessourceServlet" method="post">
        <input type="hidden" name="action" value="add">

        <div >
            <label for="nom">Nom:</label>
            <input type="text"  id="nom" name="nom" required>
        </div>
        <div >
            <label for="type">Type:</label>
            <input type="text"  id="type" name="type" required>
        </div>
        <div >
            <label for="quantite">Quantite:</label>
            <input type="number"  id="quantite" name="quantite" required>
        </div>
        <div >
            <label for="unite">Unite:</label>
            <input type="text"  id="unite" name="unite" required>
        </div>
        <div>
            <label for="description">Description:</label>
            <textarea  id="description" name="description"></textarea>
        </div>
        <div >
            <label for="fournisseurId">Fournisseur:</label>
            <select class="form-control" id="fournisseurId" name="fournisseurId" required>
                <% for (Fournisseur fournisseur : fournisseurs) { %>
                <option value="<%= fournisseur.getId() %>"><%= fournisseur.getNom() %></option>
                <% } %>
            </select>
        </div>

        <button type="submit" >Ajouter Ressource</button>
        <a href="<%= request.getContextPath() %>/RessourceServlet?action=list" >Cancel</a>
    </form>
</div>
</body>
</html>