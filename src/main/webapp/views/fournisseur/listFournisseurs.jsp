<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.xpertaconstruction.models.Fournisseur" %>

<%
    List<Fournisseur> fournisseurs = (List<Fournisseur>) request.getAttribute("fournisseurs");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Fournisseurs</title>
    <script src="<%= request.getContextPath() %>/includes/tailwind.js"></script>
    <script src="<%= request.getContextPath() %>/includes/all.min.js"></script>
</head>
<body class="bg-gray-100 bg-construction-bg">

<%@ include file="../includes/header.jsp" %>

<main class="container mx-auto px-4 py-8">
    <div class="flex justify-between items-center mb-4">
        <h2 class="text-2xl shadow bg-white  font-bold bg--500 py-2 px-4 rounded-lg">Liste des Fournisseurs</h2>
        <a href="<%= request.getContextPath() %>/FournisseurServlet?action=showAddForm" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline">
            <i class="fas fa-plus mr-1"></i>  Ajouter un Fournisseur
        </a>
    </div>

    <% if (fournisseurs != null && !fournisseurs.isEmpty()) { %>
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
        <% for (Fournisseur fournisseur : fournisseurs) { %>
        <div class="bg-white rounded-lg shadow-md p-4">
            <h3 class="text-xl font-semibold mb-2"><%= fournisseur.getNom() %></h3>
            <p class="text-gray-600 mb-2">Contact: <%= fournisseur.getContact() != null ? fournisseur.getContact() : "N/A" %></p>
            <p class="text-sm"><strong>Email:</strong> <%= fournisseur.getEmail() %></p>
            <p class="text-sm"><strong>Téléphone:</strong> <%= fournisseur.getTelephone() != null ? fournisseur.getTelephone() : "N/A" %></p>
            <p class="text-sm"><strong>Adresse:</strong> <%= fournisseur.getAdresse() != null ? fournisseur.getAdresse() : "N/A" %></p>

            <div class="mt-4 flex space-x-2">
                <a href="<%= request.getContextPath() %>/FournisseurServlet?action=showUpdateForm&id=<%= fournisseur.getId() %>" class="text-yellow-600 hover:text-yellow-800" aria-label="Modifier">
                    <i class="fas fa-edit"></i>
                </a>
                <a href="<%= request.getContextPath() %>/FournisseurServlet?action=delete&id=<%= fournisseur.getId() %>" class="text-red-600 hover:text-red-800" onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce fournisseur ?')" aria-label="Supprimer">
                    <i class="fas fa-trash-alt"></i>
                </a>
            </div>
        </div>
        <% } %>
    </div>
    <% } else { %>
    <p class="text-gray-600">Aucun fournisseur trouvé.</p>
    <% } %>
    <div class="mt-6">
        <a href="<%= request.getContextPath() %>/views/admin/dashboard.jsp" class="inline-block text-blue-500 hover:underline">
            <i class="fas fa-arrow-left mr-1"></i> Retour au Tableau de Bord
        </a>
    </div>
</main>

<%@ include file="../includes/footer.jsp" %>

</body>
</html>