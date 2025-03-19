
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Ajouter Projet</title>

</head>
<body>

<div class="container">
    <h2>Ajouter Projet</h2>
    <% if (request.getAttribute("error") != null) { %>

        <%= request.getAttribute("error") %>

    <% } %>

    <form action="<%= request.getContextPath() %>/ProjetServlet" method="post">
        <input type="hidden" name="action" value="add">

        <div>
            <label for="nom">Nom:</label>
            <input type="text"  id="nom" name="nom" required>
        </div>
        <div >
            <label for="description">Description:</label>
            <textarea  id="description" name="description" required></textarea>
        </div>
        <div >
            <label for="dateDebut">Date Debut:</label>
            <input type="date"  id="dateDebut" name="dateDebut" required>
        </div>
        <div class="form-group">
            <label for="dateFin">Date Fin:</label>
            <input type="date"  id="dateFin" name="dateFin" required>
        </div>
        <div >
            <label for="budget">Budget:</label>
            <input type="number" step="0.01"  id="budget" name="budget" required>
        </div>
        <div >
            <label for="statut">Statut:</label>
            <select  id="statut" name="statut" required>
                <option value="En attente">En attente</option>
                <option value="En cours">En cours</option>
                <option value="Terminé">Terminé</option>
                <option value="Annulé">Annulé</option>
            </select>
        </div>

        <button type="submit" >Ajouter Projet</button>
        <a href="<%= request.getContextPath() %>/ProjetServlet?action=list" >Cancel</a>
    </form>
</div>
</body>
</html>