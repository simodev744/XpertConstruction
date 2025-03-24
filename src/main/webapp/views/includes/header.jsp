
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <script src=""></script>

<script src="<%= request.getContextPath() %>/views/includes/tailwind.js"></script>
<script src="<%= request.getContextPath() %>/views/includes/all.min.js"></script>
    <style>
        .card-icon {
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }
    </style>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        'primary': '#4F46E5',
                        'secondary': '#A855F7',
                        'accent': '#F59E0B',
                        'gray-custom': '#E5E7EB',
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
                        'construction-bg': "url('<%=request.getContextPath()%>/views/includes/construction-background.jpg')",
                    }
                }
            }
        }
    </script>
</head>

<header class="bg-white shadow-md w-full">
    <div class="container mx-auto px-4 py-2 flex items-center justify-between">
        <div class="flex items-center">
            <img  class="rounded-xl mx-2 "  src="<%= request.getContextPath() %>/views/includes/logo.PNG" alt="logo" width="60" height="60">
            <a href="#" class="text-xl font-bold text-gray-800">XpertConstruction</a>
        </div>

        <nav>
            <ul class="hidden md:flex space-x-4">
                <li><a href="<%= request.getContextPath() %>/ProjetServlet?action=list" class="hover:text-primary  px-2 py-1 rounded transition duration-200"><i class="fas fa-project-diagram mr-1"></i>Projets</a></li>
                <li><a href="<%= request.getContextPath() %>/FournisseurServlet?action=list" class="hover:text-primary px-2 py-1 rounded transition duration-200"><i class="fas fa-truck mr-1"></i>Fournisseurs</a></li>
                <li><a href="<%= request.getContextPath() %>/RessourceServlet?action=list" class="hover:text-primary px-2 py-1 rounded transition duration-200"><i class="fas fa-tools mr-1"></i>Ressources</a></li>
                <li><a href="<%= request.getContextPath() %>/AdminServlet?action=logout" class="hover:text-red-500  px-2 py-1 rounded transition duration-200"><i class="fas fa-sign-out-alt mr-1"></i>Déconnexion</a></li>
            </ul>
        </nav>

        <div class="md:hidden">
            <button id="menu-toggle" class="text-gray-700 hover:text-primary focus:outline-none">
                <i class="fas fa-bars text-2xl"></i>
            </button>
        </div>
    </div>


    <div id="mobile-menu" class="md:hidden bg-white shadow-md absolute w-full left-0 hidden">
        <ul class="flex flex-col">
            <li><a href="<%= request.getContextPath() %>/ProjetServlet?action=list" class="block px-4 py-2 hover:bg-gray-100"><i class="fas fa-project-diagram mr-1"></i>Projets</a></li>
            <li><a href="<%= request.getContextPath() %>/FournisseurServlet?action=list" class="block px-4 py-2 hover:bg-gray-100"><i class="fas fa-truck mr-1"></i>Fournisseurs</a></li>
            <li><a href="<%= request.getContextPath() %>/RessourceServlet?action=list" class="block px-4 py-2 hover:bg-gray-100"><i class="fas fa-tools mr-1"></i>Ressources</a></li>
            <li><a href="<%= request.getContextPath() %>/AdminServlet?action=logout" class="block px-4 py-2 hover:bg-gray-100 text-red-500"><i class="fas fa-sign-out-alt mr-1"></i>Déconnexion</a></li>

        </ul>
    </div>
</header>

<main class="container mx-auto px-4 py-6">
    <h1 class="text-3xl  bg-white rounded-lg  hover:shadow-lg transition duration-200 px-4  font-bold text-gray-800 mb-4">Tableau de Bord</h1>
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <div class="col-md-6 col-lg-4 mb-4">
            <div class="card card-projet bg-white rounded-lg shadow-md p-4 transition duration-300 transform hover:-translate-y-1">
                <div class="card-body text-center">
                    <a href="<%= request.getContextPath() %>/ProjetServlet?action=list" class="text-gray-700 hover:text-primary">
                        <i class="fas fa-project-diagram card-icon text-primary"></i>
                        <h5 class="card-title font-semibold text-lg">Gérer les Projets</h5>
                        <p class="card-text text-gray-600">Créer, mettre à jour et supprimer des projets.</p>
                    </a>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-lg-4 mb-4">
            <div class="card card-fournisseur bg-white rounded-lg shadow-md p-4 transition duration-300 transform hover:-translate-y-1">
                <div class="card-body text-center">
                    <a href="<%= request.getContextPath() %>/FournisseurServlet?action=list"  class="text-gray-700 hover:text-primary">
                        <i class="fas fa-truck card-icon text-primary"></i>
                        <h5 class="card-title font-semibold text-lg">Gérer les Fournisseurs</h5>
                        <p class="card-text text-gray-600">Gérer les informations des fournisseurs.</p>
                    </a>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-lg-4 mb-4">
            <div class="card card-ressource  bg-white rounded-lg shadow-md p-4 transition duration-300 transform hover:-translate-y-1">
                <div class="card-body text-center">
                    <a href="<%= request.getContextPath() %>/RessourceServlet?action=list" class="text-gray-700 hover:text-primary">
                        <i class="fas fa-tools card-icon text-primary"></i>
                        <h5 class="card-title font-semibold text-lg">Gérer les Ressources</h5>
                        <p class="card-text text-gray-600">Ajouter, mettre à jour et supprimer des ressources.</p>
                    </a>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-lg-4 mb-4">
            <div class="card card-deconnexion bg-white rounded-lg shadow-md p-4 transition duration-300 transform hover:-translate-y-1">
                <div class="card-body text-center">
                    <a href="<%= request.getContextPath() %>/AdminServlet?action=logout" class="text-gray-700 hover:text-red-500">
                        <i class="fas fa-sign-out-alt card-icon text-red-500"></i>
                        <h5 class="card-title font-semibold text-lg">Déconnexion</h5>
                        <p class="card-text text-gray-600">Se déconnecter en toute sécurité.</p>
                    </a>
                </div>
            </div>
        </div>
    </div>
</main>



<script>
    document.getElementById('menu-toggle').addEventListener('click', function() {
        document.getElementById('mobile-menu').classList.toggle('hidden');
    });
</script>
