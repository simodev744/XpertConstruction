<%@ page import="org.example.xpertaconstruction.models.Fournisseur" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Fournisseur fournisseur = (Fournisseur) request.getAttribute("fournisseur");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifier le Fournisseur</title>
    <script src="<%= request.getContextPath() %>/includes/tailwind.js"></script>
    <script src="<%= request.getContextPath() %>/includes/all.min.js"></script>
</head>
<body class="bg-gray-100">

<%@ include file="../includes/header.jsp" %>

<main class="container mx-auto px-4 py-8">
    <h2 class="text-2xl font-bold mb-4">Modifier le Fournisseur</h2>

    <% if (request.getAttribute("error") != null) { %>
    <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4" role="alert">
        <strong class="font-bold">Erreur!</strong>
        <%= request.getAttribute("error") %>
    </div>
    <% } %>

    <form action="<%= request.getContextPath() %>/FournisseurServlet" method="post" class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="<%= fournisseur.getId()  %>">

        <div class="mb-4">
            <label for="nom" class="block text-gray-700 text-sm font-bold mb-2">Nom :</label>
            <input type="text" id="nom" name="nom" value="<%= fournisseur.getNom()  %>" required
                   class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
        </div>
        <div class="mb-4">
            <label for="contact" class="block text-gray-700 text-sm font-bold mb-2">Contact :</label>
            <input type="text" id="contact" name="contact" value="<%= fournisseur.getContact()  %>"
                   class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
        </div>
        <div class="mb-4">
            <label for="email" class="block text-gray-700 text-sm font-bold mb-2">Email :</label>
            <input type="email" id="email" name="email" value="<%=  fournisseur.getEmail()  %>" required
                   class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
        </div>
        <div class="mb-4">
            <label for="telephone" class="block text-gray-700 text-sm font-bold mb-2">Téléphone :</label>
            <input type="text" id="telephone" name="telephone" value="<%= fournisseur.getTelephone()  %>"
                   class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
        </div>
        <div class="mb-4">
            <label for="adresse" class="block text-gray-700 text-sm font-bold mb-2">Adresse :</label>
            <textarea id="adresse" name="adresse"
                      class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline h-32"><%= fournisseur.getAdresse()  %></textarea>
        </div>

        <div class="flex items-center justify-between">
            <button type="submit"
                    class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline">
                <i class="fas fa-save mr-2"></i> Enregistrer les Modifications
            </button>
            <a href="<%= request.getContextPath() %>/FournisseurServlet?action=list"
               class="inline-block align-baseline font-bold text-sm text-construction-blue hover:text-blue-800">
                <i class="fas fa-times mr-2"></i> Annuler
            </a>
        </div>
    </form>
</main>

<%@ include file="../includes/footer.jsp" %>

</body>
</html>