package org.example.xpertaconstruction.controllers;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.xpertaconstruction.dao.AdminDao;
import org.example.xpertaconstruction.models.Administrateur;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {
    private AdminDao adminDao;

    @Override
    public void init() throws ServletException {
        adminDao = new AdminDao();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("login".equals(action)) {
            try {
                login(request, response);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        } else if ("logout".equals(action)) {
            logout(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if("logout".equals(action)) {
            logout(request, response);
        }else{
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
        }
    }

    private void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("error", "pseudo et mot de pass sont obligatoires");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
            return;
        }


        try {
            Administrateur admin = adminDao.getAdminByUsername(username);
            if (admin != null && password.equals(admin.getMotDePasse())) {

                HttpSession session = request.getSession();
                session.setAttribute("admin", admin);
                response.sendRedirect(request.getContextPath() + "/views/admin/dashboard.jsp");
            } else {
                request.setAttribute("error", "Invalid pseudo ou mot de passe.");
                request.getRequestDispatcher("/views/login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Db error: " + e.getMessage());
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        }
    }


    private void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/views/login.jsp");
    }
}