<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.xpertaconstruction.models.Tache" %>
<%@ page import="org.example.xpertaconstruction.models.Projet" %>

<%
    List<Tache> taches = (List<Tache>) request.getAttribute("taches");
    Projet projet = (Projet) request.getAttribute("projet");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Liste des Tâches - <%= projet.getNom() %></title>
</head>
<body>

<h2>Tâches du Projet : <strong><%= projet.getNom() %></strong></h2>

<a href="<%= request.getContextPath() %>/TacheServlet?action=showAddForm&projetId=<%= projet.getId() %>">
    Ajouter une Tâche
</a>

<% if (taches != null && !taches.isEmpty()) { %>
<table border="1">
    <thead>
    <tr>
        <th>ID</th>
        <th>Description</th>
        <th>Date Début</th>
        <th>Date Fin</th>
        <th>Statut</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <% for (Tache tache : taches) { %>
    <tr>
        <td><%= tache.getId() %></td>
        <td><%= tache.getDescription() %></td>
        <td><%= tache.getDateDebut() %></td>
        <td><%= tache.getDateFin() %></td>
        <td><%= tache.getStatut() %></td>
        <td>
            <a href="<%= request.getContextPath() %>/TacheServlet?action=listAssignedResources&tacheId=<%= tache.getId() %>">
                Voir Ressources
            </a>
            |
            <a href="<%= request.getContextPath() %>/TacheServlet?action=showAssignResourceForm&tacheId=<%= tache.getId()%>">
                Assigner Ressource
            </a>
            |
            <a href="<%= request.getContextPath() %>/TacheServlet?action=showUpdateForm&id=<%= tache.getId() %>">
                Modifier
            </a>
            |
            <a href="<%= request.getContextPath() %>/TacheServlet?action=delete&id=<%= tache.getId() %>"
               onclick="return confirm('Voulez-vous vraiment supprimer cette tâche ?')">
                Supprimer
            </a>
        </td>
    </tr>
    <% } %>
    </tbody>
</table>
<% } else { %>
<p>Aucune tâche trouvée pour ce projet.</p>
<% } %>

<a href="<%= request.getContextPath() %>/ProjetServlet?action=list">Retour à la liste des projets</a>

</body>
</html>
