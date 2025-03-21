<%@ page import="org.example.xpertaconstruction.models.Tache" %>
<%@ page import="org.example.xpertaconstruction.models.Projet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Tache tache = (Tache) request.getAttribute("tache");
    Projet projet = (Projet) request.getAttribute("projet");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Modifier une Tâche</title>
</head>
<body>

<h2>Modifier la Tâche : <%= tache.getDescription() %></h2>
<h4>(Projet : <%= projet.getNom() %>)</h4>

<% if (request.getAttribute("error") != null) { %>
<p style="color: red;"><%= request.getAttribute("error") %></p>
<% } %>

<form action="<%= request.getContextPath() %>/TacheServlet" method="post">
    <input type="hidden" name="action" value="update">
    <input type="hidden" name="id" value="<%= tache.getId() %>">
    <input type="hidden" name="projetId" value="<%= projet.getId() %>">

    <label for="description">Description :</label><br>
    <textarea id="description" name="description" required><%= tache.getDescription() %></textarea><br><br>

    <label for="dateDebut">Date de début :</label><br>
    <input type="date" id="dateDebut" name="dateDebut" value="<%= tache.getDateDebut() %>" required><br><br>

    <label for="dateFin">Date de fin :</label><br>
    <input type="date" id="dateFin" name="dateFin" value="<%= tache.getDateFin() %>" required><br><br>

    <label for="statut">Statut :</label><br>
    <select id="statut" name="statut" required>
        <option value="À faire" <%= tache.getStatut().equals("À faire") ? "selected" : "" %>>À faire</option>
        <option value="En cours" <%= tache.getStatut().equals("En cours") ? "selected" : "" %>>En cours</option>
        <option value="Terminée" <%= tache.getStatut().equals("Terminée") ? "selected" : "" %>>Terminée</option>
    </select><br><br>

    <button type="submit">Mettre à jour</button>
    <a href="<%= request.getContextPath() %>/TacheServlet?action=list&projetId=<%= projet.getId() %>">Annuler</a>
</form>

</body>
</html>
