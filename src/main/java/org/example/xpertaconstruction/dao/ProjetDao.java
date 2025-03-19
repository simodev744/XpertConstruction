package org.example.xpertaconstruction.dao;

import org.example.xpertaconstruction.db.DBConnection;
import org.example.xpertaconstruction.models.Projet;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProjetDao {
    public void addProjet(Projet projet) throws SQLException {
        String sql = "INSERT INTO projet (nom, description, date_debut, date_fin, budget, statut, administrateur_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, projet.getNom());
            pstmt.setString(2, projet.getDescription());
            pstmt.setDate(3, projet.getDateDebut());
            pstmt.setDate(4, projet.getDateFin());
            pstmt.setDouble(5, projet.getBudget());
            pstmt.setString(6, projet.getStatut());
            pstmt.setInt(7, projet.getAdministrateurId());
            pstmt.executeUpdate();
        }catch (SQLException e) {
            throw new SQLException("Error ajouter un projet: " + e.getMessage(), e);
        }
    }

    public List<Projet> getAllProjets() throws SQLException {
        List<Projet> projets = new ArrayList<>();
        String sql = "SELECT * FROM projet";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Projet projet = new Projet();
                projet.setId(rs.getInt("id"));
                projet.setNom(rs.getString("nom"));
                projet.setDescription(rs.getString("description"));
                projet.setDateDebut(rs.getDate("date_debut"));
                projet.setDateFin(rs.getDate("date_fin"));
                projet.setBudget(rs.getDouble("budget"));
                projet.setStatut(rs.getString("statut"));
                projet.setDateCreation(rs.getTimestamp("date_creation"));
                projet.setAdministrateurId(rs.getInt("administrateur_id"));
                projets.add(projet);
            }
        }catch (SQLException e) {
            throw new SQLException("Error obtenir tous les champs des projets: " + e.getMessage(), e);
        }
        return projets;
    }

    public Projet getProjetById(int id) throws SQLException {
        String sql = "SELECT * FROM projet WHERE id = ?";
        Projet projet = null;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    projet = new Projet();
                    projet.setId(rs.getInt("id"));
                    projet.setNom(rs.getString("nom"));
                    projet.setDescription(rs.getString("description"));
                    projet.setDateDebut(rs.getDate("date_debut"));
                    projet.setDateFin(rs.getDate("date_fin"));
                    projet.setBudget(rs.getDouble("budget"));
                    projet.setStatut(rs.getString("statut"));
                    projet.setDateCreation(rs.getTimestamp("date_creation"));
                    projet.setAdministrateurId(rs.getInt("administrateur_id"));
                }
            }
        }catch (SQLException e) {
            throw new SQLException("Error obtenir projet par id: " + e.getMessage(), e);
        }
        return projet;
    }

    public void updateProjet(Projet projet) throws SQLException {
        String sql = "UPDATE projet SET nom = ?, description = ?, date_debut = ?, date_fin = ?, budget = ?, statut = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, projet.getNom());
            pstmt.setString(2, projet.getDescription());
            pstmt.setDate(3, projet.getDateDebut());
            pstmt.setDate(4, projet.getDateFin());
            pstmt.setDouble(5, projet.getBudget());
            pstmt.setString(6, projet.getStatut());
            pstmt.setInt(7, projet.getId());
            pstmt.executeUpdate();
        }catch (SQLException e) {
            throw new SQLException("Error mise a jour projet: " + e.getMessage(), e);
        }
    }

    public void deleteProjet(int id) throws SQLException {
        String sql = "DELETE FROM projet WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        }catch (SQLException e) {
            throw new SQLException("Error supprimer projet: " + e.getMessage(), e);
        }
    }
}