<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.xpertaconstruction.models.Fournisseur" %>

<%
    List<Fournisseur> fournisseurs = (List<Fournisseur>) request.getAttribute("fournisseurs");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Liste des Fournisseurs</title>
</head>
<body>
<%@ include file="../includes/header.jsp" %>
<div>
    <h2>Liste des Fournisseurs</h2>
    <a href="<%= request.getContextPath() %>/FournisseurServlet?action=showAddForm">Ajouter un Fournisseur</a>

    <% if (fournisseurs != null && !fournisseurs.isEmpty()) { %>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Nom</th>
            <th>Contact</th>
            <th>Email</th>
            <th>Téléphone</th>
            <th>Adresse</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% for (Fournisseur fournisseur : fournisseurs) { %>
        <tr>
            <td><%= fournisseur.getId() %></td>
            <td><%= fournisseur.getNom() %></td>
            <td><%= fournisseur.getContact() != null ? fournisseur.getContact() : "N/A" %></td>
            <td><%= fournisseur.getEmail() %></td>
            <td><%= fournisseur.getTelephone() != null ? fournisseur.getTelephone() : "N/A" %></td>
            <td><%= fournisseur.getAdresse() != null ? fournisseur.getAdresse() : "N/A" %></td>
            <td>
                <a href="<%= request.getContextPath() %>/FournisseurServlet?action=showUpdateForm&id=<%= fournisseur.getId() %>">Modifier</a>
                <a href="<%= request.getContextPath() %>/FournisseurServlet?action=delete&id=<%= fournisseur.getId() %>" onclick="return confirm('Êtes-vous sûr de vouloir supprimer ?')">Supprimer</a>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <% } else { %>
    <p>Aucun fournisseur trouvé.</p>
    <% } %>
    <a href="<%= request.getContextPath() %>/views/admin/dashboard.jsp">Retour au Tableau de Bord</a>
</div>
</body>
</html>
