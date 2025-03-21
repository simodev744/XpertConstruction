<%@ page import="org.example.xpertaconstruction.models.Projet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Projet projet = (Projet) request.getAttribute("projet");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Ajouter une Tâche</title>
</head>
<body>

<div>
    <h2>Ajouter une Tâche au Projet : <%= projet.getNom() %></h2>

    <% if (request.getAttribute("error") != null) { %>
    <div>
        <%= request.getAttribute("error") %>
    </div>
    <% } %>

    <form action="<%= request.getContextPath() %>/TacheServlet" method="post">
        <input type="hidden" name="action" value="add">
        <input type="hidden" name="projetId" value="<%= projet.getId() %>">

        <div>
            <label for="description">Description :</label>
            <textarea id="description" name="description" required></textarea>
        </div>
        <div>
            <label for="dateDebut">Date de Début :</label>
            <input type="date" id="dateDebut" name="dateDebut" required>
        </div>
        <div>
            <label for="dateFin">Date de Fin :</label>
            <input type="date" id="dateFin" name="dateFin" required>
        </div>
        <div>
            <label for="statut">Statut :</label>
            <select id="statut" name="statut" required>
                <option value="À faire">À faire</option>
                <option value="En cours">En cours</option>
                <option value="Terminée">Terminée</option>
            </select>
        </div>

        <button type="submit">Ajouter Tâche</button>
        <a href="<%= request.getContextPath() %>/TacheServlet?action=list&projetId=<%= projet.getId() %>">Annuler</a>
    </form>
</div>
</body>
</html>
