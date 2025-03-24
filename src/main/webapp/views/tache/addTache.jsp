<%@ page import="org.example.xpertaconstruction.models.Projet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Projet projet = (Projet) request.getAttribute("projet");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ajouter une Tâche</title>
    <style>

    </style>
</head>
<body class="bg-gray-100">

<%@ include file="../includes/header.jsp" %>

<main class="container mx-auto px-4 py-8">
    <h2 class="text-2xl font-bold mb-4">Ajouter une Tâche au Projet : <%= projet != null ? projet.getNom() : "N/A" %></h2>

    <% if (request.getAttribute("error") != null) { %>
    <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4" role="alert">
        <strong class="font-bold">Erreur!</strong>
        <%= request.getAttribute("error") %>
    </div>
    <% } %>

    <form action="<%= request.getContextPath() %>/TacheServlet" method="post" class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
        <input type="hidden" name="action" value="add">
        <input type="hidden" name="projetId" value="<%=  projet.getId() %>">

        <div class="mb-4">
            <label for="description" class="block text-gray-700 text-sm font-bold mb-2">Description :</label>
            <textarea id="description" name="description" required
                      class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline h-32"></textarea>
        </div>
        <div class="mb-4">
            <label for="dateDebut" class="block text-gray-700 text-sm font-bold mb-2">Date de Début :</label>
            <input type="date" id="dateDebut" name="dateDebut" required
                   class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
        </div>
        <div class="mb-4">
            <label for="dateFin" class="block text-gray-700 text-sm font-bold mb-2">Date de Fin :</label>
            <input type="date" id="dateFin" name="dateFin" required
                   class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
        </div>
        <div class="mb-4">
            <label for="statut" class="block text-gray-700 text-sm font-bold mb-2">Statut :</label>
            <select id="statut" name="statut" required
                    class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                <option value="À faire">À faire</option>
                <option value="En cours">En cours</option>
                <option value="Terminée">Terminée</option>
            </select>
        </div>

        <div class="flex items-center justify-between">
            <button type="submit"
                    class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline">
                <i class="fas fa-plus mr-2"></i> Ajouter la Tâche
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