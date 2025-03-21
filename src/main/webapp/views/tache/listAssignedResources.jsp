<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.xpertaconstruction.models.Tache" %>
<%@ page import="org.example.xpertaconstruction.models.Projet" %>
<%@ page import="org.example.xpertaconstruction.models.RessourceTache" %>
<%@ page import="org.example.xpertaconstruction.models.Ressource" %>

<%
    Tache tache = (Tache) request.getAttribute("tache");
    Projet projet = (Projet) request.getAttribute("projet");
    List<RessourceTache> assignedResources = (List<RessourceTache>) request.getAttribute("assignedResources");
    List<Ressource> resourceDetails = (List<Ressource>) request.getAttribute("resourceDetails");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Ressources assignées à la tâche</title>
</head>
<body>



<h2>Ressources assignées à la tâche :</h2>
<h4><%= tache.getDescription() %> (Projet : <%= projet.getNom() %>)</h4>

<% if (assignedResources != null && !assignedResources.isEmpty()) { %>

<table border="1">
    <thead>
    <tr>
        <th>Nom de la ressource</th>
        <th>Quantité utilisée</th>
        <th>Date d'assignation</th>
    </tr>
    </thead>
    <tbody>

    <%
        for (int i = 0; i < assignedResources.size(); i++) {
            RessourceTache assignment = assignedResources.get(i);
            Ressource ressource = resourceDetails.get(i);
    %>

    <tr>
        <td><%= ressource.getNom() %></td>
        <td><%= assignment.getQuantiteUtilisee() %></td>
        <td><%= assignment.getDateAssignation() %></td>
    </tr>

    <% } %>
    </tbody>
</table>

<% } else { %>
<p>Aucune ressource n'a été assignée à cette tâche.</p>
<% } %>

<a href="<%= request.getContextPath() %>/TacheServlet?action=list&projetId=<%= projet.getId() %>">Retour à la liste des tâches</a>

</body>
</html>
