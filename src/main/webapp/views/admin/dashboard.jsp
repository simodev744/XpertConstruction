<%@ page import="org.example.xpertaconstruction.models.Administrateur" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Administrateur admin = (Administrateur) session.getAttribute("admin");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de Bord Admin</title>
    <script src="<%= request.getContextPath() %>/views/includes/tailwind.js"></script>
    <script src="<%= request.getContextPath() %>/views/includes/all.min.js"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        'primary': '#1a237e',
                        'secondary': '#6c757d',
                        'accent': '#ffc107',
                        'gray-custom': '#e5e7eb',
                        'construction-blue': '#1565c0',
                        'construction-gray': '#616161',
                        'projet-bg': '#f8f9fa',
                        'projet-border': '#dee2e6',
                        'projet-text': '#343a40',
                        'projet-icon': '#1565c0',
                        'fournisseur-bg': '#fff3cd',
                        'fournisseur-border': '#ffeeba',
                        'fournisseur-text': '#856404',
                        'fournisseur-icon': '#ffc107',
                        'ressource-bg': '#e0f2f1',
                        'ressource-border': '#b2dfdb',
                        'ressource-text': '#00695c',
                        'ressource-icon': '#009688',
                        'deconnexion-bg': '#f8d7da',
                        'deconnexion-border': '#f5c6cb',
                        'deconnexion-text': '#721c24',
                        'deconnexion-icon': '#dc3545',

                    },
                    backgroundImage: {
                        'construction-bg': "url('../includes/construction-background.jpg')",
                    }
                }
            }
        }
    </script>
</head>
<body class="bg-construction-bg bg-no-repeat bg-center bg-cover bg-fixed">

<header class="bg-primary shadow-md py-4">
    <div class="container mx-auto px-4 flex items-center justify-between">
        <div class="flex items-center">
            <img  class="rounded-xl mx-2 "  src="<%= request.getContextPath() %>/views/includes/logo.PNG" alt="logo" width="60" height="60">
            <a href="#" class="text-xl font-bold text-white">XpertConstruction</a>
        </div>
        <nav>
            <ul class="hidden md:flex space-x-6">
                <li><a href="<%= request.getContextPath() %>/ProjetServlet?action=list" class="hover:text-gray-300 text-white"><i class="fas fa-project-diagram mr-1"></i> Projets</a></li>
                <li><a href="<%= request.getContextPath() %>/FournisseurServlet?action=list" class="hover:text-gray-300 text-white"><i class="fas fa-truck mr-1"></i> Fournisseurs</a></li>
                <li><a href="<%= request.getContextPath() %>/RessourceServlet?action=list" class="hover:text-gray-300 text-white"><i class="fas fa-tools mr-1"></i> Ressources</a></li>
                <li><a href="<%= request.getContextPath() %>/AdminServlet?action=logout" class="hover:text-red-300 text-white"><i class="fas fa-sign-out-alt mr-1"></i> Déconnexion</a></li>

            </ul>
        </nav>

        <div class="md:hidden">
            <button id="menu-toggle" class="text-white hover:text-gray-300 focus:outline-none">
                <i class="fas fa-bars text-2xl"></i>
            </button>
        </div>
    </div>

    <div id="mobile-menu" class="md:hidden bg-primary shadow-md absolute w-full left-0  hidden">
        <ul class="flex flex-col">
            <li><a href="<%= request.getContextPath() %>/ProjetServlet?action=list" class="block px-4 py-2 hover:bg-indigo-700 text-white"><i class="fas fa-project-diagram mr-1"></i> Projets</a></li>
            <li><a href="<%= request.getContextPath() %>/FournisseurServlet?action=list" class="block px-4 py-2 hover:bg-indigo-700 text-white"><i class="fas fa-truck mr-1"></i> Fournisseurs</a></li>
            <li><a href="<%= request.getContextPath() %>/RessourceServlet?action=list" class="block px-4 py-2 hover:bg-indigo-700 text-white"><i class="fas fa-tools mr-1"></i> Ressources</a></li>
            <li><a href="<%= request.getContextPath() %>/AdminServlet?action=logout" class="block px-4 py-2 hover:bg-indigo-700 text-white"><i class="fas fa-sign-out-alt mr-1"></i> Déconnexion</a></li>
        </ul>
    </div>
</header>



<main class="container mx-auto px-4 py-10">
    <h1 class=" bg-white rounded px-4 mb-4 text-black text-4xl font-bold">Bienvenue, <%= admin != null ? admin.getNomUtilisateur() : "Admin" %>!</h1>


    <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
        <div class="mb-0">
            <div class="card bg-projet-bg border border-projet-border text-projet-text rounded-xl shadow-lg p-6 hover:shadow-xl transition duration-300 transform hover:-translate-y-1">
                <div class="card-body text-center">
                    <a href="<%= request.getContextPath() %>/ProjetServlet?action=list" class="block text-inherit no-underline hover:text-inherit">
                        <i class="fas fa-project-diagram text-5xl mb-4 text-projet-icon"></i>
                        <h5 class="card-title font-semibold text-2xl">Gérer les Projets</h5>
                        <p class="card-text text-base">Créer, mettre à jour et supprimer des projets.</p>
                    </a>
                </div>
            </div>
        </div>
        <div class="mb-0">
            <div class="card bg-fournisseur-bg border border-fournisseur-border text-fournisseur-text rounded-xl shadow-lg p-6 hover:shadow-xl transition duration-300 transform hover:-translate-y-1">
                <div class="card-body text-center">
                    <a href="<%= request.getContextPath() %>/FournisseurServlet?action=list" class="block text-inherit no-underline hover:text-inherit">
                        <i class="fas fa-truck text-5xl mb-4 text-fournisseur-icon"></i>
                        <h5 class="card-title font-semibold text-2xl">Gérer les Fournisseurs</h5>
                        <p class="card-text text-base">Gérer les informations des fournisseurs.</p>
                    </a>
                </div>
            </div>
        </div>
        <div class="mb-0">
            <div class="card bg-ressource-bg border border-ressource-border text-ressource-text rounded-xl shadow-lg p-6 hover:shadow-xl transition duration-300 transform hover:-translate-y-1">
                <div class="card-body text-center">
                    <a href="<%= request.getContextPath() %>/RessourceServlet?action=list" class="block text-inherit no-underline hover:text-inherit">
                        <i class="fas fa-tools text-5xl mb-4 text-ressource-icon"></i>
                        <h5 class="card-title font-semibold text-2xl">Gérer les Ressources</h5>
                        <p class="card-text text-base">Ajouter, mettre à jour et supprimer des ressources.</p>
                    </a>
                </div>
            </div>
        </div>
        <div class="mb-0">
            <div class="card bg-deconnexion-bg border border-deconnexion-border text-deconnexion-text rounded-xl shadow-lg p-6 hover:shadow-xl transition duration-300 transform hover:-translate-y-1">
                <div class="card-body text-center">
                    <a href="<%= request.getContextPath() %>/AdminServlet?action=logout" class="block text-inherit no-underline hover:text-inherit">
                        <i class="fas fa-sign-out-alt text-5xl mb-4 text-deconnexion-icon"></i>
                        <h5 class="card-title font-semibold text-2xl">Déconnexion</h5>
                        <p class="card-text text-base">Se déconnecter en toute sécurité.</p>
                    </a>
                </div>
            </div>
        </div>
    </div>
</main>

<%@ include file="../includes/footer.jsp" %>
<script>
    document.getElementById('menu-toggle').addEventListener('click', function() {
        document.getElementById('mobile-menu').classList.toggle('hidden');
    });
</script>
</body>
</html>