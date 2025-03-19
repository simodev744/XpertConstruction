package org.example.xpertaconstruction.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.xpertaconstruction.dao.ProjetDao;
import org.example.xpertaconstruction.models.Administrateur;
import org.example.xpertaconstruction.models.Projet;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/ProjetServlet")
public class ProjetServlet extends HttpServlet {
    private ProjetDao projetDao;
    @Override
    public void init() throws ServletException {
        projetDao = new ProjetDao();
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
                    listProjets(request, response);
                    break;
                case "showAddForm":
                    showAddForm(request, response);
                    break;
                case "showUpdateForm":
                    showUpdateForm(request, response);
                    break;
                case "delete":
                    deleteProjet(request, response);
                    break;
                default:
                    listProjets(request, response);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "add":
                    addProjet(request, response);
                    break;
                case "update":
                    updateProjet(request, response);
                    break;
                default:
                   response.sendRedirect("ProjetServlet");
            }
        } catch (SQLException e) {
            throw new ServletException("Db connection error", e);
        }
    }
    private void listProjets(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        List<Projet> projets = projetDao.getAllProjets();
        request.setAttribute("projets", projets);
        request.getRequestDispatcher("/views/projet/listProjets.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/projet/addProjet.jsp").forward(request, response);
    }

    private void addProjet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String nom = request.getParameter("nom");
        String description = request.getParameter("description");
        Date dateDebut = Date.valueOf(request.getParameter("dateDebut"));
        Date dateFin = Date.valueOf(request.getParameter("dateFin"));
        double budget = Double.parseDouble(request.getParameter("budget"));
        String statut = request.getParameter("statut");


        if (nom == null || nom.isEmpty() || description == null || description.isEmpty()
                || dateDebut == null || dateFin == null || statut == null || statut.isEmpty()) {
            request.setAttribute("error", "tous les champs sont  obligatoires.");
            request.getRequestDispatcher("/views/projet/addProjet.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {

            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        Administrateur admin = (Administrateur) session.getAttribute("admin");
        int administrateurId = admin.getId();


        Projet projet = new Projet();
        projet.setNom(nom);
        projet.setDescription(description);
        projet.setDateDebut(dateDebut);
        projet.setDateFin(dateFin);
        projet.setBudget(budget);
        projet.setStatut(statut);
        projet.setAdministrateurId(administrateurId);


        projetDao.addProjet(projet);


        response.sendRedirect(request.getContextPath() + "/ProjetServlet?action=list");
    }

    private void showUpdateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        Projet projet = projetDao.getProjetById(id);
        if (projet == null) {
            System.out.println("projet introuvable");
            return;
        }
        request.setAttribute("projet", projet);
        request.getRequestDispatcher("/views/projet/updateProjet.jsp").forward(request, response);
    }

    private void updateProjet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        String nom = request.getParameter("nom");
        String description = request.getParameter("description");
        Date dateDebut = Date.valueOf(request.getParameter("dateDebut"));
        Date dateFin = Date.valueOf(request.getParameter("dateFin"));
        double budget = Double.parseDouble(request.getParameter("budget"));
        String statut = request.getParameter("statut");

        if (nom == null || nom.isEmpty() || description == null || description.isEmpty()
                || dateDebut == null || dateFin == null || statut == null || statut.isEmpty()) {
            request.setAttribute("error", "All fields are required.");
            Projet existingProjet = projetDao.getProjetById(id);
            request.setAttribute("projet", existingProjet);
            request.getRequestDispatcher("/views/projet/updateProjet.jsp").forward(request, response);
            return;
        }

        Projet projet = new Projet();
        projet.setId(id);
        projet.setNom(nom);
        projet.setDescription(description);
        projet.setDateDebut(dateDebut);
        projet.setDateFin(dateFin);
        projet.setBudget(budget);
        projet.setStatut(statut);

        projetDao.updateProjet(projet);
        response.sendRedirect(request.getContextPath() + "/ProjetServlet?action=list");
    }

    private void deleteProjet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        projetDao.deleteProjet(id);
        response.sendRedirect(request.getContextPath() + "/ProjetServlet?action=list");
    }

}