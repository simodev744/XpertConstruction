<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.xpertaconstruction.models.Projet" %>

<%
    List<Projet> projets = (List<Projet>) request.getAttribute("projets");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Projets</title>
    </style>
</head>
<body class=" bg-cover bg-center bg-construction-bg   ">
<%@ include file="../includes/header.jsp" %>

<main class="   container mx-auto px-4 py-8">
    <div class="flex justify-between items-center mb-4">
        <h2 class="text-2xl shadow bg-white  font-bold bg--500 py-2 px-4 rounded-lg">Liste des Projets</h2>
        <a href="<%= request.getContextPath() %>/ProjetServlet?action=showAddForm" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline">
            <i class="fas fa-plus mr-1"></i>  Ajouter un Projet
        </a>
    </div>


    <% if (projets != null && !projets.isEmpty()) { %>
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
        <% for (Projet projet : projets) { %>
        <div class="bg-white rounded-lg shadow-md overflow-hidden">
            <div class="p-4">
                <h3 class="text-xl font-semibold mb-2"><%= projet.getNom() %></h3>
                <p class="text-gray-600 mb-4"><%= projet.getDescription() %></p>
                <p class="text-sm"><strong>Date de Début:</strong> <%= projet.getDateDebut() %></p>
                <p class="text-sm"><strong>Date de Fin:</strong> <%= projet.getDateFin() %></p>
                <p class="text-sm"><strong>Budget:</strong> <%= projet.getBudget() %> €</p>
                <p class="text-sm"><strong>Statut:</strong>
                    <span class="inline-flex items-center rounded-md px-2 py-1 text-xs font-medium ring-1 ring-inset
                            <%= projet.getStatut().equals("En cours") ? "bg-green-50 text-green-700 ring-green-600/20" : "" %>
                            <%= projet.getStatut().equals("Terminé") ? "bg-blue-50 text-blue-700 ring-blue-700/10" : "" %>
                            <%= projet.getStatut().equals("En attente") ? "bg-yellow-50 text-yellow-800 ring-yellow-600/20" : "" %>
                            <%= projet.getStatut().equals("Annulé") ? "bg-red-50 text-red-700 ring-red-600/10" : "" %>
                           "
                    ><%= projet.getStatut() %></span></p>
            </div>

            <div class="border-t border-gray-200 px-4 py-3 bg-gray-50">
                <div class="flex flex-wrap space-x-2">
                    <a href="<%= request.getContextPath() %>/TacheServlet?action=list&projetId=<%= projet.getId() %>" class="text-blue-600 hover:text-blue-800" aria-label="Afficher les Tâches">
                        <i class="fas fa-tasks"></i>
                    </a>
                    <a href="<%= request.getContextPath() %>/ProjetServlet?action=showUpdateForm&id=<%= projet.getId() %>" class="text-yellow-600 hover:text-yellow-800"  aria-label="Modifier le Projet"><i class="fas fa-edit"></i></a>
                    <a href="<%= request.getContextPath() %>/ProjetServlet?action=delete&id=<%= projet.getId() %>" class="text-red-600 hover:text-red-800" onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce projet ?')" aria-label="Supprimer le projet"><i class="fas fa-trash-alt"></i></a>
                </div>
            </div>
        </div>
        <% } %>
    </div>
    <% } else { %>
    <p class="text-gray-600">Aucun projet trouvé.</p>
    <% } %>

    <div class="mt-6">
        <a href="<%= request.getContextPath() %>/views/admin/dashboard.jsp" class="inline-block text-construction-blue hover:underline"><i class="fas fa-arrow-left mr-1"></i> Retour au Tableau de Bord</a>
    </div>

</main>


<%@ include file="../includes/footer.jsp" %>
</body>
</html>