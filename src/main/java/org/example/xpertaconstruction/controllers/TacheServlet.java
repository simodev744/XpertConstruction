package org.example.xpertaconstruction.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.xpertaconstruction.dao.ProjetDao;
import org.example.xpertaconstruction.dao.RessourceDao;
import org.example.xpertaconstruction.dao.TacheDao;
import org.example.xpertaconstruction.models.Projet;
import org.example.xpertaconstruction.models.Ressource;
import org.example.xpertaconstruction.models.RessourceTache;
import org.example.xpertaconstruction.models.Tache;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/TacheServlet")
public class TacheServlet extends HttpServlet {
    private TacheDao tacheDao;
    private ProjetDao projetDao;
    private RessourceDao ressourceDao;

    @Override
    public void init() throws ServletException {
        tacheDao = new TacheDao();
        projetDao = new ProjetDao();
        ressourceDao = new RessourceDao();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "list":
                    listTaches(request, response);
                    break;
                case "showAddForm":
                    showAddForm(request, response);
                    break;
                case "showUpdateForm":
                    showUpdateForm(request, response);
                    break;
                case "delete":
                    deleteTache(request, response);
                    break;
                case "showAssignResourceForm":
                    showAssignResourceForm(request, response);
                    break;
                case "listAssignedResources":
                    listAssignedResources(request,response);
                    break;
                default:
                    listTaches(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Db connectionn error", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");



        try {
            switch (action) {
                case "add":
                    addTache(request, response);
                    break;
                case "update":
                    updateTache(request, response);
                    break;
                case "assignResource":
                    assignResource(request, response);
                    break;
                default:
                      return;
            }
        } catch (SQLException e) {
            throw new ServletException("Database access error", e);
        }
    }

    private void listTaches(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        int projetId = Integer.parseInt(request.getParameter("projetId"));
        Projet projet = projetDao.getProjetById(projetId);
        if (projet == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Projet not found");
            return;
        }
        List<Tache> taches = tacheDao.getAllTachesByProjetId(projetId);

        request.setAttribute("projet", projet);
        request.setAttribute("taches", taches);
        request.getRequestDispatcher("/views/tache/listTaches.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        int projetId = Integer.parseInt(request.getParameter("projetId"));
        Projet projet = projetDao.getProjetById(projetId);
        if (projet == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Projet not found");
            return;
        }
        request.setAttribute("projet", projet);
        request.getRequestDispatcher("/views/tache/addTache.jsp").forward(request, response);
    }

    private void addTache(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        int projetId = Integer.parseInt(request.getParameter("projetId"));
        String description = request.getParameter("description");
        Date dateDebut = Date.valueOf(request.getParameter("dateDebut"));
        Date dateFin = Date.valueOf(request.getParameter("dateFin"));
        String statut = request.getParameter("statut");


        if (description == null || description.isEmpty() || dateDebut == null || dateFin == null || statut == null || statut.isEmpty()) {
            request.setAttribute("error", "All fields are required.");
            Projet projet = projetDao.getProjetById(projetId);
            request.setAttribute("projet", projet);
            request.getRequestDispatcher("/views/tache/addTache.jsp").forward(request, response);
            return;
        }

        Tache tache = new Tache();
        tache.setProjetId(projetId);
        tache.setDescription(description);
        tache.setDateDebut(dateDebut);
        tache.setDateFin(dateFin);
        tache.setStatut(statut);

        // Add to database
        tacheDao.addTache(tache);


        response.sendRedirect(request.getContextPath() + "/TacheServlet?action=list&projetId=" + projetId);
    }

    private void showUpdateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        Tache tache = tacheDao.getTacheById(id);
        if (tache == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Tache not found");
            return;
        }

        Projet projet = projetDao.getProjetById(tache.getProjetId());
        if (projet == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Projet not found");
            return;
        }
        request.setAttribute("tache", tache);
        request.setAttribute("projet", projet);
        request.getRequestDispatcher("/views/tache/updateTache.jsp").forward(request, response);
    }

    private void updateTache(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        int id = Integer.parseInt(request.getParameter("id"));
        int projetId = Integer.parseInt(request.getParameter("projetId"));
        String description = request.getParameter("description");
        Date dateDebut = Date.valueOf(request.getParameter("dateDebut"));
        Date dateFin = Date.valueOf(request.getParameter("dateFin"));
        String statut = request.getParameter("statut");

        if (description == null || description.isEmpty() || dateDebut == null || dateFin == null || statut == null || statut.isEmpty()) {
            request.setAttribute("error", "tous les champs sont obligatoires.");
            Tache existingTache = tacheDao.getTacheById(id);
            Projet projet = projetDao.getProjetById(projetId);
            request.setAttribute("tache", existingTache);
            request.setAttribute("projet", projet);
            request.getRequestDispatcher("/views/tache/updateTache.jsp").forward(request, response);
            return;
        }

        Tache tache = new Tache();
        tache.setId(id);
        tache.setProjetId(projetId);
        tache.setDescription(description);
        tache.setDateDebut(dateDebut);
        tache.setDateFin(dateFin);
        tache.setStatut(statut);

        tacheDao.updateTache(tache);
        response.sendRedirect(request.getContextPath() + "/TacheServlet?action=list&projetId=" + projetId);
    }
    private void deleteTache(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        Tache tache = tacheDao.getTacheById(id);
        if(tache == null){
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Tache not found");
            return;
        }
        int projetId = tache.getProjetId();
        tacheDao.deleteTache(id);
        response.sendRedirect(request.getContextPath() + "/TacheServlet?action=list&projetId=" + projetId);
    }


    private void showAssignResourceForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        int tacheId = Integer.parseInt(request.getParameter("tacheId"));

        Tache tache = tacheDao.getTacheById(tacheId);
        if(tache == null){
            System.out.println("tache introuvalble");
            return;
        }

        Projet projet = projetDao.getProjetById(tache.getProjetId());
        if (projet == null) {
            System.out.println("projet introuvalble");
            return;
        }

        List<Ressource> ressources = ressourceDao.getAllRessources();

        request.setAttribute("tache", tache);
        request.setAttribute("projet", projet);
        request.setAttribute("ressources", ressources);
        request.getRequestDispatcher("/views/tache/assignResource.jsp").forward(request, response);
    }

    private void assignResource(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        int tacheId = Integer.parseInt(request.getParameter("tacheId"));
        int ressourceId = Integer.parseInt(request.getParameter("ressourceId"));
        int quantiteUtilisee = Integer.parseInt(request.getParameter("quantiteUtilisee"));


        Tache tache = tacheDao.getTacheById(tacheId);
        Ressource ressource = ressourceDao.getRessourceById(ressourceId);


        if (tache == null || ressource == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Tache ou Ressource introuvable");
            return;
        }

        if (ressource.getQuantite() < quantiteUtilisee) {
            request.setAttribute("error", "Quantité insuffisante pour la ressource: " + ressource.getNom());

            List<Ressource> ressources = ressourceDao.getAllRessources();
            Projet projet = projetDao.getProjetById(tache.getProjetId());

            request.setAttribute("tache", tache);
            request.setAttribute("projet", projet);
            request.setAttribute("ressources", ressources);
            request.getRequestDispatcher("/views/tache/assignResource.jsp").forward(request, response);
            return;
        }

        try {
            tacheDao.assignResourceToTask(tacheId, ressourceId, quantiteUtilisee);
            response.sendRedirect(request.getContextPath() + "/TacheServlet?action=listAssignedResources&tacheId=" + tacheId);

        }catch (SQLException e){

            request.setAttribute("error", "Error assigner resource: " + e.getMessage());


            List<Ressource> ressources = ressourceDao.getAllRessources();
            Projet projet = projetDao.getProjetById(tache.getProjetId());

            request.setAttribute("tache", tache);
            request.setAttribute("projet", projet);
            request.setAttribute("ressources", ressources);
            request.getRequestDispatcher("/views/tache/assignResource.jsp").forward(request, response);

        }
    }

    private void listAssignedResources(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        int tacheId = Integer.parseInt(request.getParameter("tacheId"));


        Tache tache = tacheDao.getTacheById(tacheId);
        if (tache == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Tache n'est pas trouvé");
            return;
        }
        Projet projet = projetDao.getProjetById(tache.getProjetId());
        if (projet == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Projet n'est pas trouvé");
            return;
        }

        List<RessourceTache> assignedResources = tacheDao.getAssignedResourcesForTask(tacheId);

        List<Ressource> resourceDetails = new ArrayList<>();
        for (RessourceTache assignment : assignedResources) {
            Ressource ressource = ressourceDao.getRessourceById(assignment.getRessourceId());
            if(ressource != null){
                resourceDetails.add(ressource);
            }
        }

        request.setAttribute("tache", tache);
        request.setAttribute("projet", projet);
        request.setAttribute("assignedResources", assignedResources);
        request.setAttribute("resourceDetails", resourceDetails);
        request.getRequestDispatcher("/views/tache/listAssignedResources.jsp").forward(request, response);
    }
}