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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Tâches - <%= projet != null ? projet.getNom() : "Projet" %></title>
</head>
<body class="bg-gray-100">

<%@ include file="../includes/header.jsp" %>

<main class="container mx-auto px-4 py-8">
    <div class="flex justify-between items-center mb-4">
        <h2 class="text-2xl font-bold">Tâches du Projet : <strong><%= projet != null ? projet.getNom() : "Projet" %></strong></h2>
        <% if (projet != null) { %>
        <a href="<%= request.getContextPath() %>/TacheServlet?action=showAddForm&projetId=<%= projet.getId() %>" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline">
            <i class="fas fa-plus mr-1"></i> Ajouter une Tâche
        </a>
        <% } %>
    </div>


    <% if (taches != null && !taches.isEmpty()) { %>
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
        <% for (Tache tache : taches) { %>
        <div class="bg-white rounded-lg shadow-md p-4">
            <p class="text-gray-600 mb-4"><%= tache.getDescription() %></p>
            <p class="text-sm"><strong>Date de Début:</strong> <%= tache.getDateDebut() %></p>
            <p class="text-sm"><strong>Date de Fin:</strong> <%= tache.getDateFin() %></p>
            <p class="text-sm"><strong>Statut:</strong>
                <span class="inline-flex items-center rounded-md px-2 py-1 text-xs font-medium ring-1 ring-inset
                            <%= tache.getStatut().equals("En cours") ? "bg-green-50 text-green-700 ring-green-600/20" : "" %>
                            <%= tache.getStatut().equals("Terminée") ? "bg-blue-50 text-blue-700 ring-blue-700/10" : "" %>
                            <%= tache.getStatut().equals("À faire") ? "bg-yellow-50 text-yellow-800 ring-yellow-600/20" : "" %>

                           "
                ><%= tache.getStatut() %></span></p>

            <div class="mt-4 flex flex-wrap space-x-2">
                <a href="<%= request.getContextPath() %>/TacheServlet?action=listAssignedResources&tacheId=<%= tache.getId() %>" class="text-blue-600 hover:text-blue-800" aria-label="Voir Ressources">
                    <i class="fas fa-users"></i>
                </a>
                <a href="<%= request.getContextPath() %>/TacheServlet?action=showAssignResourceForm&tacheId=<%= tache.getId()%>" class="text-green-600 hover:text-green-800" aria-label="Assigner Ressource">
                    <i class="fas fa-user-plus"></i>
                </a>
                <a href="<%= request.getContextPath() %>/TacheServlet?action=showUpdateForm&id=<%= tache.getId() %>" class="text-yellow-600 hover:text-yellow-800" aria-label="Modifier">
                    <i class="fas fa-edit"></i>
                </a>
                <a href="<%= request.getContextPath() %>/TacheServlet?action=delete&id=<%= tache.getId() %>" class="text-red-600 hover:text-red-800" onclick="return confirm('Voulez-vous vraiment supprimer cette tâche ?')" aria-label="Supprimer">
                    <i class="fas fa-trash-alt"></i>
                </a>
            </div>
        </div>
        <% } %>
    </div>
    <% } else { %>
    <p class="text-gray-600">Aucune tâche trouvée pour ce projet.</p>
    <% } %>

    <div class="mt-6">
        <a href="<%= request.getContextPath() %>/ProjetServlet?action=list" class="inline-block text-construction-blue hover:underline">
            <i class="fas fa-arrow-left mr-1"></i> Retour à la liste des projets
        </a>
    </div>
</main>

<%@ include file="../includes/footer.jsp" %>

</body>
</html>