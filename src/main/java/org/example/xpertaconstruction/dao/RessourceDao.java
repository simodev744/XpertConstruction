
package org.example.xpertaconstruction.dao;


import org.example.xpertaconstruction.db.DBConnection;
import org.example.xpertaconstruction.models.Ressource;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RessourceDao {

    public void addRessource(Ressource ressource) throws SQLException {
        String sql = "INSERT INTO ressource (nom, type, quantite, unite, description, fournisseur_id) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, ressource.getNom());
            pstmt.setString(2, ressource.getType());
            pstmt.setInt(3, ressource.getQuantite());
            pstmt.setString(4, ressource.getUnite());
            pstmt.setString(5, ressource.getDescription());
            pstmt.setInt(6, ressource.getFournisseurId());
            pstmt.executeUpdate();
        }catch (SQLException e) {
            throw new SQLException("Error ajouter ressource: " + e.getMessage(), e);
        }
    }
    public List<Ressource> getAllRessources() throws SQLException {
        List<Ressource> ressources = new ArrayList<>();
        String sql = "SELECT * FROM ressource";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Ressource ressource = new Ressource();
                ressource.setId(rs.getInt("id"));
                ressource.setNom(rs.getString("nom"));
                ressource.setType(rs.getString("type"));
                ressource.setQuantite(rs.getInt("quantite"));
                ressource.setUnite(rs.getString("unite"));
                ressource.setDescription(rs.getString("description"));
                ressource.setFournisseurId(rs.getInt("fournisseur_id"));
                ressource.setDateCreation(rs.getTimestamp("date_creation"));
                ressources.add(ressource);
            }
        }catch (SQLException e) {
            throw new SQLException("Error trouve tous les ressources: " + e.getMessage(), e);
        }
        return ressources;
    }

    public Ressource getRessourceById(int id) throws SQLException {
        String sql = "SELECT * FROM ressource WHERE id = ?";
        Ressource ressource = null;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    ressource = new Ressource();
                    ressource.setId(rs.getInt("id"));
                    ressource.setNom(rs.getString("nom"));
                    ressource.setType(rs.getString("type"));
                    ressource.setQuantite(rs.getInt("quantite"));
                    ressource.setUnite(rs.getString("unite"));
                    ressource.setDescription(rs.getString("description"));
                    ressource.setFournisseurId(rs.getInt("fournisseur_id"));
                    ressource.setDateCreation(rs.getTimestamp("date_creation"));
                }
            }
        }catch (SQLException e) {
            throw new SQLException("Error trouver ressource par id: " + e.getMessage(), e);
        }
        return ressource;
    }

    public void updateRessource(Ressource ressource) throws SQLException {
        String sql = "UPDATE ressource SET nom = ?, type = ?, quantite = ?, unite = ?, description = ?, fournisseur_id = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, ressource.getNom());
            pstmt.setString(2, ressource.getType());
            pstmt.setInt(3, ressource.getQuantite());
            pstmt.setString(4, ressource.getUnite());
            pstmt.setString(5, ressource.getDescription());
            pstmt.setInt(6, ressource.getFournisseurId());
            pstmt.setInt(7, ressource.getId());
            pstmt.executeUpdate();
        }catch (SQLException e) {
            throw new SQLException("Error mise a jour ressource: " + e.getMessage(), e);
        }
    }

    public void deleteRessource(int id) throws SQLException {
        String sql = "DELETE FROM ressource WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        }catch (SQLException e) {
            throw new SQLException("Error supprimer ressource: " + e.getMessage(), e);
        }
    }
}