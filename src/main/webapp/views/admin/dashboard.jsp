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
</head>
<body>
<div>
    <h1>Bienvenue, <%= admin.getNomUtilisateur() %>!</h1>
    <p>Ceci est le tableau de bord administrateur.</p>
    <div>
        <div>
            <div>
                <div>
                    <a href="<%= request.getContextPath() %>/ProjetServlet?action=list">
                        <h5>Gérer les Projets</h5>
                        <p>Créer, mettre à jour et supprimer des projets.</p>
                    </a>
                </div>
            </div>
        </div>
        <div>
            <div>
                <div>
                    <a href="<%= request.getContextPath() %>/FournisseurServlet?action=list">
                        <h5>Gérer les Fournisseurs</h5>
                        <p>Gérer les informations des fournisseurs.</p>
                    </a>
                </div>
            </div>
        </div>
        <div>
            <div>
                <div>
                    <a href="<%= request.getContextPath() %>/RessourceServlet?action=list">
                        <h5>Gérer les Ressources</h5>
                        <p>Ajouter, mettre à jour et supprimer des ressources.</p>
                    </a>
                </div>
            </div>
        </div>
        <div>
            <div>
                <div>
                    <a href="<%= request.getContextPath() %>/AdminServlet?action=logout">
                        <h5>Déconnexion</h5>
                        <p>Se déconnecter en toute sécurité.</p>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
