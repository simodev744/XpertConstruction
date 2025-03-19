
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.xpertaconstruction.models.Ressource" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Listes des Ressources</title>

</head>
<body>
<div >
    <h2>List Ressources</h2>
    <a href="<%= request.getContextPath() %>/RessourceServlet?action=showAddForm" class="btn btn-primary mb-3">Add New Ressource</a>

    <% if (request.getAttribute("ressources") != null) { %>
    <% List<Ressource> ressources = (List<Ressource>) request.getAttribute("ressources"); %>
    <% if (!ressources.isEmpty()) { %>
    <table class="table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Nom</th>
            <th>Type</th>
            <th>Quantite</th>
            <th>Unite</th>
            <th>Description</th>
            <th>Fournisseur ID</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% for (Ressource ressource : ressources) { %>
        <tr>
            <td><%= ressource.getId() %></td>
            <td><%= ressource.getNom() %></td>
            <td><%= ressource.getType() %></td>
            <td><%= ressource.getQuantite() %></td>
            <td><%= ressource.getUnite() %></td>
            <td><%= ressource.getDescription() != null ? ressource.getDescription() : "" %></td>
            <td><%= ressource.getFournisseurId() %></td>
            <td>
                <a href="<%= request.getContextPath() %>/RessourceServlet?action=showUpdateForm&id=<%= ressource.getId() %>" class="btn btn-sm btn-info">Update</a>
                <a href="<%= request.getContextPath() %>/RessourceServlet?action=delete&id=<%= ressource.getId() %>" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure?')">Delete</a>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <% } else { %>
    <p>aucun ressources.</p>
    <% } %>
    <% } else { %>
    <p>aucun ressources.</p>
    <% } %>

    <a href="<%= request.getContextPath() %>/views/admin/dashboard.jsp" > Dashboard</a>
</div>
</body>
</html>