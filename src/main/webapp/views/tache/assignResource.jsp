<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.xpertaconstruction.models.Tache" %>
<%@ page import="org.example.xpertaconstruction.models.Projet" %>
<%@ page import="org.example.xpertaconstruction.models.Ressource" %>

<%
    Tache tache = (Tache) request.getAttribute("tache");
    Projet projet = (Projet) request.getAttribute("projet");
    List<Ressource> ressources = (List<Ressource>) request.getAttribute("ressources");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Assigner une Ressource à la Tâche</title>
</head>
<body>


<h2>Assigner une Ressource à la Tâche :</h2>
<h4><%= tache.getDescription() %> (Projet : <%= projet.getNom() %>)</h4>

<% if (request.getAttribute("error") != null) { %>
<div>
    <strong>Erreur :</strong> <%= request.getAttribute("error") %>
</div>
<% } %>

<form action="<%= request.getContextPath() %>/TacheServlet" method="post">
    <input type="hidden" name="action" value="assignResource">
    <input type="hidden" name="tacheId" value="<%= tache.getId() %>">

    <label for="ressourceId">Ressource :</label>
    <select id="ressourceId" name="ressourceId" required>
        <% for (Ressource ressource : ressources) { %>
        <option value="<%= ressource.getId() %>">
            <%= ressource.getNom() %> (<%= ressource.getQuantite() %> <%= ressource.getUnite() %> disponibles)
        </option>
        <% } %>
    </select>
    <br>

    <label for="quantiteUtilisee">Quantité à utiliser :</label>
    <input type="number" id="quantiteUtilisee" name="quantiteUtilisee" min="1" required>
    <br>

    <button type="submit">Assigner Ressource</button>
    <a href="<%= request.getContextPath() %>/TacheServlet?action=list&projetId=<%= projet.getId() %>">Annuler</a>
</form>

</body>
</html>
