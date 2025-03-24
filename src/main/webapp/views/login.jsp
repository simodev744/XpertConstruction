<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion - xpertConstruction</title>
    <script src="<%= request.getContextPath() %>/views/includes/tailwind.js"></script>
    <script src="<%= request.getContextPath() %>/views/includes/all.min.js"></script>

    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        'primary': '#4F46E5',
                        'secondary': '#A855F7',
                    },
                    backgroundImage: {
                        <%--'login-background': "url('<%=request.getContextPath()%>/views/includes/login-bg2.jpg')",  --%>
                        'login-background': "url('<%=request.getContextPath()%>/views/includes/login-bg.jpg')",
                    }
                }
            }
        }
    </script>

</head>
<body class=" bg-cover bg- bg-login-background   bg-gray-100 flex items-center justify-center min-h-screen">

<div class="bg-white rounded-lg shadow-xl p-8 w-full max-w-md">
    <div class="flex items-center justify-center flex-col mb-6">
        <img    src="<%= request.getContextPath() %>/views/includes/logo.PNG" alt="Logo"  class="w-[100px] h-[100px] rounded-xl">
         <h1 class="text-2xl font-bold text-gray-800">XpertConstruction</h1>
    </div>


    <% if (request.getAttribute("error") != null) { %>
    <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4" role="alert">
        <strong class="font-bold">Erreur!</strong>
        <span class="block sm:inline"><%= request.getAttribute("error") %></span>
    </div>
    <% } %>

    <form action="<%= request.getContextPath() %>/AdminServlet" method="post" class="space-y-4">
        <input type="hidden" name="action" value="login">

        <div>
            <label for="username" class="block text-sm font-medium text-gray-700">Nom d'utilisateur</label>
            <div class="mt-1 relative rounded-md shadow-sm">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <i class="fas fa-user text-gray-400"></i>
                </div>
                <input type="text" id="username" name="username" placeholder="Admin" required
                       class="focus:ring-construction-blue focus:border-construction-blue block w-full pl-10 pr-12 sm:text-sm border-gray-300 rounded-md">
            </div>
        </div>

        <div>
            <label for="password" class="block text-sm font-medium text-gray-700">Mot de passe</label>
            <div class="mt-1 relative rounded-md shadow-sm">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <i class="fas fa-lock text-gray-400"></i>
                </div>
                <input type="password" id="password" name="password" required
                       class=" focus:border-construction-blue block w-full  pl-10 pr-12 sm:text-sm border-gray-300 rounded-md">
            </div>

        </div>

        <div>
            <button type="submit"
                    class="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-500 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-construction-blue">
                <i class="fas fa-sign-in-alt mr-2"></i>
                Se connecter
            </button>
        </div>
    </form>
    <div class="mt-6 text-center">
        <a href="#" class="text-sm bg-blue hover:underline">Mot de passe oublié ?</a>
    </div>
</div>

</body>
</html>