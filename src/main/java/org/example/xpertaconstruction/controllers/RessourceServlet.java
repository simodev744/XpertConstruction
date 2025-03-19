package org.example.xpertaconstruction.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.xpertaconstruction.dao.FournisseurDao;
import org.example.xpertaconstruction.dao.RessourceDao;
import org.example.xpertaconstruction.models.Fournisseur;
import org.example.xpertaconstruction.models.Ressource;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "RessourceServlet", value = "/RessourceServlet")
public class RessourceServlet extends HttpServlet {

    private RessourceDao ressourceDao;
    private FournisseurDao fournisseurDao;

    @Override
    public void init() throws ServletException {
        ressourceDao = new RessourceDao();
        fournisseurDao = new FournisseurDao();
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
                    listRessources(request, response);
                    break;
                case "showAddForm":
                    showAddForm(request, response);
                    break;
                case "showUpdateForm":
                    showUpdateForm(request, response);
                    break;
                case "delete":
                    deleteRessource(request, response);
                    break;
                default:
                    listRessources(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("probleme conn base de donnee ", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");


        try {
            switch (action) {
                case "add":
                    addRessource(request, response);
                    break;
                case "update":
                    updateRessource(request, response);
                    break;
                default:
                    return;
            }
        } catch (SQLException e) {
            throw new ServletException("Db access error", e);
        }
    }

    private void listRessources(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        List<Ressource> ressources = ressourceDao.getAllRessources();
        request.setAttribute("ressources", ressources);
        request.getRequestDispatcher("/views/ressource/listRessources.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        List<Fournisseur> fournisseurs = fournisseurDao.getAllFournisseurs();
        request.setAttribute("fournisseurs", fournisseurs);
        request.getRequestDispatcher("/views/ressource/addRessource.jsp").forward(request, response);
    }
    private void addRessource(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String nom = request.getParameter("nom");
        String type = request.getParameter("type");
        int quantite = Integer.parseInt(request.getParameter("quantite"));
        String unite = request.getParameter("unite");
        String description = request.getParameter("description");
        int fournisseurId = Integer.parseInt(request.getParameter("fournisseurId")); // Get from dropdown


        if (nom == null || nom.isEmpty() || type == null || type.isEmpty() || unite == null || unite.isEmpty()) {
            request.setAttribute("error", "Name, type,  unit est oblig.");
            List<Fournisseur> fournisseurs = fournisseurDao.getAllFournisseurs();
            request.setAttribute("fournisseurs", fournisseurs);
            request.getRequestDispatcher("/views/ressource/addRessource.jsp").forward(request, response);
            return;
        }

        Ressource ressource = new Ressource();
        ressource.setNom(nom);
        ressource.setType(type);
        ressource.setQuantite(quantite);
        ressource.setUnite(unite);
        ressource.setDescription(description);
        ressource.setFournisseurId(fournisseurId);

        ressourceDao.addRessource(ressource);
        response.sendRedirect(request.getContextPath() + "/RessourceServlet?action=list");
    }

    private void showUpdateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        Ressource ressource = ressourceDao.getRessourceById(id);
        if (ressource == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Ressource n'est pas trouve");
            return;
        }


        List<Fournisseur> fournisseurs = fournisseurDao.getAllFournisseurs();

        request.setAttribute("ressource", ressource);
        request.setAttribute("fournisseurs", fournisseurs);
        request.getRequestDispatcher("/views/ressource/updateRessource.jsp").forward(request, response);
    }

    private void updateRessource(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        int id = Integer.parseInt(request.getParameter("id"));
        String nom = request.getParameter("nom");
        String type = request.getParameter("type");
        int quantite = Integer.parseInt(request.getParameter("quantite"));
        String unite = request.getParameter("unite");
        String description = request.getParameter("description");
        int fournisseurId = Integer.parseInt(request.getParameter("fournisseurId"));


        if (nom == null || nom.isEmpty() || type == null || type.isEmpty() || unite == null || unite.isEmpty()) {
            request.setAttribute("error", "Name, type, and unit are required.");
            Ressource existingRessource = ressourceDao.getRessourceById(id);
            List<Fournisseur> fournisseurs = fournisseurDao.getAllFournisseurs();
            request.setAttribute("ressource", existingRessource);
            request.setAttribute("fournisseurs", fournisseurs);
            request.getRequestDispatcher("/views/ressource/updateRessource.jsp").forward(request, response);
            return;
        }

        Ressource ressource = new Ressource();
        ressource.setId(id);
        ressource.setNom(nom);
        ressource.setType(type);
        ressource.setQuantite(quantite);
        ressource.setUnite(unite);
        ressource.setDescription(description);
        ressource.setFournisseurId(fournisseurId);

        ressourceDao.updateRessource(ressource);
        response.sendRedirect(request.getContextPath() + "/RessourceServlet?action=list");
    }
    private void deleteRessource(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        ressourceDao.deleteRessource(id);
        response.sendRedirect(request.getContextPath() + "/RessourceServlet?action=list");
    }
}