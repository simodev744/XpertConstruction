<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.xpertaconstruction.models.Ressource" %>
<%@ page import="org.example.xpertaconstruction.models.Fournisseur" %>

<%
    Ressource ressource = (Ressource) request.getAttribute("ressource");
    List<Fournisseur> fournisseurs = (List<Fournisseur>) request.getAttribute("fournisseurs");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifier la Ressource</title>
</head>
<body class="bg-gray-100">

<%@ include file="../includes/header.jsp" %>

<main class="container mx-auto px-4 py-8">
    <h2 class="text-2xl font-bold mb-4">Modifier la Ressource</h2>

    <% if (request.getAttribute("error") != null) { %>
    <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4" role="alert">
        <strong class="font-bold">Erreur!</strong>
        <%= request.getAttribute("error") %>
    </div>
    <% } %>

    <form action="<%= request.getContextPath() %>/RessourceServlet" method="post" class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="<%= ressource.getId() %>">

        <div class="mb-4">
            <label for="nom" class="block text-gray-700 text-sm font-bold mb-2">Nom:</label>
            <input type="text" id="nom" name="nom" value="<%= ressource.getNom()  %>" required
                   class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
        </div>
        <div class="mb-4">
            <label for="type" class="block text-gray-700 text-sm font-bold mb-2">Type:</label>
            <input type="text" id="type" name="type" value="<%=  ressource.getType() %>" required
                   class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
        </div>
        <div class="mb-4">
            <label for="quantite" class="block text-gray-700 text-sm font-bold mb-2">Quantité:</label>
            <input type="number" id="quantite" name="quantite" value="<%=  ressource.getQuantite()  %>" required
                   class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
        </div>
        <div class="mb-4">
            <label for="unite" class="block text-gray-700 text-sm font-bold mb-2">Unité:</label>
            <input type="text" id="unite" name="unite" value="<%= ressource.getUnite()  %>" required
                   class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
        </div>
        <div class="mb-4">
            <label for="description" class="block text-gray-700 text-sm font-bold mb-2">Description:</label>
            <textarea id="description" name="description"
                      class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline h-32"><%= ressource != null ? (ressource.getDescription() != null ? ressource.getDescription() : "") : "" %></textarea>
        </div>
        <div class="mb-4">
            <label for="fournisseurId" class="block text-gray-700 text-sm font-bold mb-2">Fournisseur:</label>
            <select id="fournisseurId" name="fournisseurId" required
                    class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                <% if (fournisseurs != null) {
                    for (Fournisseur fournisseur : fournisseurs) { %>
                <option value="<%= fournisseur.getId() %>" <%= (ressource != null && ressource.getFournisseurId() == fournisseur.getId()) ? "selected" : "" %>><%= fournisseur.getNom() %></option>
                <%  }
                } %>
            </select>
        </div>

        <div class="flex items-center justify-between">
            <button type="submit"
                    class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline">
                <i class="fas fa-save mr-2"></i> Enregistrer les Modifications
            </button>
            <a href="<%= request.getContextPath() %>/RessourceServlet?action=list"
               class="inline-block align-baseline font-bold text-sm text-construction-blue hover:text-blue-800">
                <i class="fas fa-times mr-2"></i> Annuler
            </a>
        </div>
    </form>
</main>

<%@ include file="../includes/footer.jsp" %>

</body>
</html>