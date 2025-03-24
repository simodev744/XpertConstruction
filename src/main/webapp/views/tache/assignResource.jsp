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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assigner une Ressource à la Tâche</title>

</head>
<body class="bg-gray-100">

<%@ include file="../includes/header.jsp" %>

<main class="container mx-auto px-4 py-8">
    <h2 class="text-2xl font-bold mb-2">Assigner une Ressource à la Tâche :</h2>
    <h4 class="text-lg mb-4"><%= tache != null ? tache.getDescription() : "Détails de la tâche" %> (Projet : <%= projet != null ? projet.getNom() : "N/A" %>)</h4>

    <% if (request.getAttribute("error") != null) { %>
    <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4" role="alert">
        <strong class="font-bold">Erreur!</strong>
        <%= request.getAttribute("error") %>
    </div>
    <% } %>

    <form action="<%= request.getContextPath() %>/TacheServlet" method="post" class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
        <input type="hidden" name="action" value="assignResource">
        <input type="hidden" name="tacheId" value="<%= tache.getId()  %>">

        <div class="mb-4">
            <label for="ressourceId" class="block text-gray-700 text-sm font-bold mb-2">Ressource :</label>
            <select id="ressourceId" name="ressourceId" required
                    class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                <% if (ressources != null) {
                    for (Ressource ressource : ressources) { %>
                <option value="<%= ressource.getId() %>">
                    <%= ressource.getNom() %> (<%= ressource.getQuantite() %> <%= ressource.getUnite() %> disponibles)
                </option>
                <%  }
                } %>
            </select>
        </div>

        <div class="mb-4">
            <label for="quantiteUtilisee" class="block text-gray-700 text-sm font-bold mb-2">Quantité à utiliser :</label>
            <input type="number" id="quantiteUtilisee" name="quantiteUtilisee" min="1" required
                   class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
        </div>

        <div class="flex items-center justify-between">
            <button type="submit"
                    class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline">
                <i class="fas fa-user-plus mr-2"></i> Assigner la Ressource
            </button>
            <a href="<%= request.getContextPath() %>/TacheServlet?action=list&projetId=<%=  projet.getId()  %>"
               class="inline-block align-baseline font-bold text-sm text-construction-blue hover:text-blue-800">
                <i class="fas fa-times mr-2"></i> Annuler
            </a>
        </div>
    </form>
</main>

<%@ include file="../includes/footer.jsp" %>

</body>
</html>