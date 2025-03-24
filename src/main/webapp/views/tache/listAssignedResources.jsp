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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ressources Assignées à la Tâche</title>
    <script src="<%= request.getContextPath() %>/includes/tailwind.js"></script>
    <script src="<%= request.getContextPath() %>/includes/all.min.js"></script>

</head>
<body class="bg-gray-100">

<%@ include file="../includes/header.jsp" %>

<main class="container mx-auto px-4 py-8">
    <h2 class="text-2xl font-bold mb-2">Ressources Assignées à la Tâche :</h2>
    <h4 class="text-lg mb-4"><%= tache != null ? tache.getDescription() : "Détails de la tâche" %> (Projet : <%= projet != null ? projet.getNom() : "N/A" %>)</h4>

    <% if (assignedResources != null && !assignedResources.isEmpty() && resourceDetails != null && !resourceDetails.isEmpty() && assignedResources.size() == resourceDetails.size()) { %>
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
        <% for (int i = 0; i < assignedResources.size(); i++) {
            RessourceTache assignment = assignedResources.get(i);
            Ressource ressource = resourceDetails.get(i);
        %>
        <div class="bg-white rounded-lg shadow-md p-4">
            <p class="text-lg font-semibold mb-2"><%= ressource.getNom() %></p>
            <p class="text-gray-600"><strong>Quantité utilisée:</strong> <%= assignment.getQuantiteUtilisee() %></p>
            <p class="text-gray-600"><strong>Date d'assignation:</strong> <%= assignment.getDateAssignation() %></p>
        </div>
        <% } %>
    </div>
    <% } else { %>
    <p class="text-gray-600">Aucune ressource n'a été assignée à cette tâche.</p>
    <% } %>

    <div class="mt-6">
        <a href="<%= request.getContextPath() %>/TacheServlet?action=list&projetId=<%= projet.getId()  %>" class="inline-block text-construction-blue hover:underline">
            <i class="fas fa-arrow-left mr-1"></i> Retour à la liste des tâches
        </a>
    </div>
</main>

<%@ include file="../includes/footer.jsp" %>

</body>
</html>