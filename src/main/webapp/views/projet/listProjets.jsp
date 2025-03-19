
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.xpertaconstruction.models.Projet" %>

<%
    List<Projet> projets = (List<Projet>) request.getAttribute("projets");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>List Projets</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/bootstrap.min.css">    <style>
        body { padding-top: 20px; }
    </style>
</head>
<body>
<div class="container">
    <h2>List Projets</h2>
    <a href="<%= request.getContextPath() %>/ProjetServlet?action=showAddForm" class="btn btn-primary mb-3">Ajouter un Projet</a>

    <% if (projets != null && !projets.isEmpty()) { %>
    <table class="table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Nom</th>
            <th>Description</th>
            <th>Date Debut</th>
            <th>Date Fin</th>
            <th>Budget</th>
            <th>Statut</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% for (Projet projet : projets) { %>
        <tr>
            <td><%= projet.getId() %></td>
            <td><%= projet.getNom() %></td>
            <td><%= projet.getDescription() %></td>
            <td><%= projet.getDateDebut() %></td>
            <td><%= projet.getDateFin() %></td>
            <td><%= projet.getBudget() %></td>
            <td><%= projet.getStatut() %></td>
            <td>
                <a href="<%= request.getContextPath() %>/TacheServlet?action=list&projetId=<%= projet.getId() %>" >View Taches</a>
                <a href="<%= request.getContextPath() %>/ProjetServlet?action=showUpdateForm&id=<%= projet.getId() %>">Update</a>
                <a href="<%= request.getContextPath() %>/ProjetServlet?action=delete&id=<%= projet.getId() %>"  onclick="return confirm('vous etes sure ?')">Delete</a>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <% } else { %>
    <p>aucun projets.</p>
    <% } %>
    <a href="<%= request.getContextPath() %>/views/admin/dashboard.jsp" > Dashboard</a>
</div>
</body>
</html>