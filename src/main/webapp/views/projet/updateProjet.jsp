<%@ page import="org.example.xpertaconstruction.models.Projet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Projet projet = (Projet) request.getAttribute("projet");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>mise a jour Projet</title>

</head>
<body>

<div >
    <h2>mise a jour Projet</h2>
        <% if (request.getAttribute("error") != null) { %>
        <%= request.getAttribute("error") %>
        <% } %>
    <form action="<%= request.getContextPath() %>/ProjetServlet" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="<%= projet.getId() %>">

        <div >
            <label for="nom">Nom:</label>
            <input type="text"  id="nom" name="nom" value="<%= projet.getNom() %>" required>
        </div>
        <div >
            <label for="description">Description:</label>
            <textarea  id="description" name="description" required><%= projet.getDescription() %></textarea>
        </div>
        <div >
            <label for="dateDebut">Date Debut:</label>
            <input type="date" id="dateDebut" name="dateDebut" value="<%= projet.getDateDebut() %>" required>
        </div>
        <div class="form-group">
            <label for="dateFin">Date Fin:</label>
            <input type="date"  id="dateFin" name="dateFin" value="<%= projet.getDateFin() %>" required>
        </div>
        <div >
            <label for="budget">Budget:</label>
            <input type="number" step="0.01"  id="budget" name="budget" value="<%= projet.getBudget() %>" required>
        </div>
        <div >
            <label for="statut">Statut:</label>
            <select  id="statut" name="statut" required>
                <option value="En attente" <%= projet.getStatut().equals("En attente") ? "selected" : "" %>>En attente</option>
                <option value="En cours" <%= projet.getStatut().equals("En cours") ? "selected" : "" %>>En cours</option>
                <option value="Terminé" <%= projet.getStatut().equals("Terminé") ? "selected" : "" %>>Terminé</option>
                <option value="Annulé" <%= projet.getStatut().equals("Annulé") ? "selected" : "" %>>Annulé</option>
            </select>
        </div>

        <button type="submit" >mise a jour  Projet</button>
        <a href="<%= request.getContextPath() %>/ProjetServlet?action=list" class="btn btn-secondary">annuler</a>
    </form>
</div>
</body>
</html>