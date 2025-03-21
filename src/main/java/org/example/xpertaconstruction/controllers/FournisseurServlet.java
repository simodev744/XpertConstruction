package org.example.xpertaconstruction.controllers;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.xpertaconstruction.dao.FournisseurDao;
import org.example.xpertaconstruction.models.Fournisseur;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "FournisseurServlet", value = "/FournisseurServlet")
public class FournisseurServlet extends HttpServlet {
    private FournisseurDao fournisseurDao;

    @Override
    public void init() throws ServletException {
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
                    listFournisseurs(request, response);
                    break;
                case "showAddForm":
                    showAddForm(request, response);
                    break;
                case "showUpdateForm":
                    showUpdateForm(request, response);
                    break;
                case "delete":
                    deleteFournisseur(request, response);
                    break;
                default:
                    listFournisseurs(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Db access error", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "add":
                    addFournisseur(request, response);
                    break;
                case "update":
                    updateFournisseur(request, response);
                    break;
                default:
                   return;
            }

        } catch (SQLException e) {
            throw new ServletException("Db acesss erreur", e);
        }
    }

    private void listFournisseurs(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        List<Fournisseur> fournisseurs = fournisseurDao.getAllFournisseurs();
        request.setAttribute("fournisseurs", fournisseurs);
        request.getRequestDispatcher("/views/fournisseur/listFournisseurs.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/fournisseur/addFournisseur.jsp").forward(request, response);
    }

    private void addFournisseur(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String nom = request.getParameter("nom");
        String contact = request.getParameter("contact");
        String email = request.getParameter("email");
        String telephone = request.getParameter("telephone");
        String adresse = request.getParameter("adresse");


        if (nom == null || nom.isEmpty() || email == null || email.isEmpty()) {
            request.setAttribute("error", "Name and email are required.");
            request.getRequestDispatcher("/views/fournisseur/addFournisseur.jsp").forward(request, response);
            return;
        }

        Fournisseur fournisseur = new Fournisseur();
        fournisseur.setNom(nom);
        fournisseur.setContact(contact);
        fournisseur.setEmail(email);
        fournisseur.setTelephone(telephone);
        fournisseur.setAdresse(adresse);

        fournisseurDao.addFournisseur(fournisseur);
        response.sendRedirect(request.getContextPath() + "/FournisseurServlet?action=list"); // Redirect to list
    }

    private void showUpdateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        Fournisseur fournisseur = fournisseurDao.getFournisseurById(id);
        if (fournisseur == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Fournisseur not found");
            return;
        }
        request.setAttribute("fournisseur", fournisseur);
        request.getRequestDispatcher("/views/fournisseur/updateFournisseur.jsp").forward(request, response);
    }

    private void updateFournisseur(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        String nom = request.getParameter("nom");
        String contact = request.getParameter("contact");
        String email = request.getParameter("email");
        String telephone = request.getParameter("telephone");
        String adresse = request.getParameter("adresse");

        if (nom == null || nom.isEmpty() || email == null || email.isEmpty()) {
            request.setAttribute("error", "Name and email are required.");
            Fournisseur existingFournisseur = fournisseurDao.getFournisseurById(id);
            request.setAttribute("fournisseur", existingFournisseur);
            request.getRequestDispatcher("/views/fournisseur/updateFournisseur.jsp").forward(request, response);
            return;
        }

        Fournisseur fournisseur = new Fournisseur();
        fournisseur.setId(id);
        fournisseur.setNom(nom);
        fournisseur.setContact(contact);
        fournisseur.setEmail(email);
        fournisseur.setTelephone(telephone);
        fournisseur.setAdresse(adresse);

        fournisseurDao.updateFournisseur(fournisseur);
        response.sendRedirect(request.getContextPath() + "/FournisseurServlet?action=list");
    }

    private void deleteFournisseur(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        fournisseurDao.deleteFournisseur(id);
        response.sendRedirect(request.getContextPath() + "/FournisseurServlet?action=list");
    }
}