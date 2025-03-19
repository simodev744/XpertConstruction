package org.example.xpertaconstruction.dao;


import org.example.xpertaconstruction.db.DBConnection;
import org.example.xpertaconstruction.models.Fournisseur;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FournisseurDao {

    public void addFournisseur(Fournisseur fournisseur) throws SQLException {
        String sql = "INSERT INTO fournisseur (nom, contact, email, telephone, adresse) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, fournisseur.getNom());
            pstmt.setString(2, fournisseur.getContact());
            pstmt.setString(3, fournisseur.getEmail());
            pstmt.setString(4, fournisseur.getTelephone());
            pstmt.setString(5, fournisseur.getAdresse());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException("Error ajouter fournisseur: " + e.getMessage(), e);
        }
    }
    public List<Fournisseur> getAllFournisseurs() throws SQLException {
        List<Fournisseur> fournisseurs = new ArrayList<>();
        String sql = "SELECT * FROM fournisseur";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Fournisseur fournisseur = new Fournisseur();
                fournisseur.setId(rs.getInt("id"));
                fournisseur.setNom(rs.getString("nom"));
                fournisseur.setContact(rs.getString("contact"));
                fournisseur.setEmail(rs.getString("email"));
                fournisseur.setTelephone(rs.getString("telephone"));
                fournisseur.setAdresse(rs.getString("adresse"));
                fournisseur.setDateCreation(rs.getTimestamp("date_creation"));
                fournisseurs.add(fournisseur);
            }
        } catch (SQLException e) {
            throw new SQLException("Error trouver tous les fournisseurs: " + e.getMessage(), e);
        }
        return fournisseurs;
    }

    public Fournisseur getFournisseurById(int id) throws SQLException {
        String sql = "SELECT * FROM fournisseur WHERE id = ?";
        Fournisseur fournisseur = null;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    fournisseur = new Fournisseur();
                    fournisseur.setId(rs.getInt("id"));
                    fournisseur.setNom(rs.getString("nom"));
                    fournisseur.setContact(rs.getString("contact"));
                    fournisseur.setEmail(rs.getString("email"));
                    fournisseur.setTelephone(rs.getString("telephone"));
                    fournisseur.setAdresse(rs.getString("adresse"));
                    fournisseur.setDateCreation(rs.getTimestamp("date_creation"));
                }
            }
        } catch (SQLException e) {
            throw new SQLException("Error trouver fourmisseur par ID: " + e.getMessage(), e);
        }
        return fournisseur;
    }

    public void updateFournisseur(Fournisseur fournisseur) throws SQLException {
        String sql = "UPDATE fournisseur SET nom = ?, contact = ?, email = ?, telephone = ?, adresse = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, fournisseur.getNom());
            pstmt.setString(2, fournisseur.getContact());
            pstmt.setString(3, fournisseur.getEmail());
            pstmt.setString(4, fournisseur.getTelephone());
            pstmt.setString(5, fournisseur.getAdresse());
            pstmt.setInt(6, fournisseur.getId());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException("Error mise a jour fournisseur " + e.getMessage(), e);
        }
    }

    public void deleteFournisseur(int id) throws SQLException {
        String sql = "DELETE FROM fournisseur WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException("Error supprimer fournisseur: " + e.getMessage(), e);
        }
    }

}