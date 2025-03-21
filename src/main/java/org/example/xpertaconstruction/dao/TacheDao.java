package org.example.xpertaconstruction.dao;



import org.example.xpertaconstruction.db.DBConnection;
import org.example.xpertaconstruction.models.RessourceTache;
import org.example.xpertaconstruction.models.Tache;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TacheDao {
    public void addTache(Tache tache) throws SQLException {
        String sql = "INSERT INTO tache (description, date_debut, date_fin, statut, projet_id) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, tache.getDescription());
            pstmt.setDate(2, tache.getDateDebut());
            pstmt.setDate(3, tache.getDateFin());
            pstmt.setString(4, tache.getStatut());
            pstmt.setInt(5, tache.getProjetId());
            pstmt.executeUpdate();
        }catch (SQLException e) {
            throw new SQLException("Error ajouter tache: " + e.getMessage(), e);
        }
    }

    public List<Tache> getAllTachesByProjetId(int projetId) throws SQLException {
        List<Tache> taches = new ArrayList<>();
        String sql = "SELECT * FROM tache WHERE projet_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, projetId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Tache tache = new Tache();
                    tache.setId(rs.getInt("id"));
                    tache.setDescription(rs.getString("description"));
                    tache.setDateDebut(rs.getDate("date_debut"));
                    tache.setDateFin(rs.getDate("date_fin"));
                    tache.setStatut(rs.getString("statut"));
                    tache.setProjetId(rs.getInt("projet_id"));
                    tache.setDateCreation(rs.getTimestamp("date_creation"));
                    taches.add(tache);
                }
            }
        }catch (SQLException e) {
            throw new SQLException("Error trouver les taches par projetid: " + e.getMessage(), e);
        }
        return taches;
    }

    public Tache getTacheById(int id) throws SQLException {
        String sql = "SELECT * FROM tache WHERE id = ?";
        Tache tache = null;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    tache = new Tache();
                    tache.setId(rs.getInt("id"));
                    tache.setDescription(rs.getString("description"));
                    tache.setDateDebut(rs.getDate("date_debut"));
                    tache.setDateFin(rs.getDate("date_fin"));
                    tache.setStatut(rs.getString("statut"));
                    tache.setProjetId(rs.getInt("projet_id"));
                    tache.setDateCreation(rs.getTimestamp("date_creation"));
                }
            }
        }catch (SQLException e) {
            throw new SQLException("Error trouver tacheb par id: " + e.getMessage(), e);
        }
        return tache;
    }

    public void updateTache(Tache tache) throws SQLException {
        String sql = "UPDATE tache SET description = ?, date_debut = ?, date_fin = ?, statut = ?, projet_id = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, tache.getDescription());
            pstmt.setDate(2, tache.getDateDebut());
            pstmt.setDate(3, tache.getDateFin());
            pstmt.setString(4, tache.getStatut());
            pstmt.setInt(5, tache.getProjetId());
            pstmt.setInt(6, tache.getId());
            pstmt.executeUpdate();
        }catch (SQLException e) {
            throw new SQLException("Error mise a jour tache: " + e.getMessage(), e);
        }
    }

    public void deleteTache(int id) throws SQLException {
        String sql = "DELETE FROM tache WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        }catch (SQLException e) {
            throw new SQLException("Error supprimer tache: " + e.getMessage(), e);
        }
    }


    public void assignResourceToTask(int tacheId, int ressourceId, int quantiteUtilisee) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmtAssign = null;
        PreparedStatement pstmtUpdateResource = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            String assignSql = "INSERT INTO ressource_tache (tache_id, ressource_id, quantite_utilisee) VALUES (?, ?, ?)";
            pstmtAssign = conn.prepareStatement(assignSql);
            pstmtAssign.setInt(1, tacheId);
            pstmtAssign.setInt(2, ressourceId);
            pstmtAssign.setInt(3, quantiteUtilisee);
            pstmtAssign.executeUpdate();


            String updateSql = "UPDATE ressource SET quantite = quantite - ? WHERE id = ?";
            pstmtUpdateResource = conn.prepareStatement(updateSql);
            pstmtUpdateResource.setInt(1, quantiteUtilisee);
            pstmtUpdateResource.setInt(2, ressourceId);
            int rowsAffected = pstmtUpdateResource.executeUpdate();

            if (rowsAffected == 0) {
                throw new SQLException("resource introuvable ou qantité est insuffisant.");
            }


            conn.commit();

        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    System.err.println("Error : " + ex.getMessage());
                    throw new SQLException("Error : " + ex.getMessage(), ex);
                }
            }
            System.err.println("Error affecter  resource à task: " + e.getMessage());
            throw new SQLException("Error affecter  resource à task: " + e.getMessage(), e);

        } finally {

            if (pstmtAssign != null) {
                try {
                    pstmtAssign.close();
                } catch (SQLException e) {
                    System.err.println("Error fermermeture pstmtAssign: " + e.getMessage());
                    throw new SQLException("Error fermeture pstmtAssign: " + e.getMessage(), e);
                }
            }
            if (pstmtUpdateResource != null) {
                try {
                    pstmtUpdateResource.close();
                } catch (SQLException e) {
                    System.err.println("Error fermer pstmtUpdateResource: " + e.getMessage());
                    throw new SQLException("Error fermer pstmtUpdateResource: " + e.getMessage(), e);
                }
            }
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    System.err.println("Error closing connection: " + e.getMessage());
                    throw new SQLException("Error closing connection: " + e.getMessage(), e);
                }
            }
        }
    }


    public List<RessourceTache> getAssignedResourcesForTask(int taskId) throws SQLException{
        List<RessourceTache> assignedResources = new ArrayList<>();
        String sql = "SELECT * FROM ressource_tache WHERE tache_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, taskId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                 RessourceTache ressourceTache = new RessourceTache();
                    ressourceTache.setId(rs.getInt("id"));
                    ressourceTache.setTacheId(rs.getInt("tache_id"));
                    ressourceTache.setRessourceId(rs.getInt("ressource_id"));
                    ressourceTache.setQuantiteUtilisee(rs.getInt("quantite_utilisee"));
                    ressourceTache.setDateAssignation(rs.getTimestamp("date_assignation"));
                    assignedResources.add(ressourceTache);
                }
            }
        } catch (SQLException e) {
            throw new SQLException("Error trouver les ressources assigné for task: " + e.getMessage(), e);
        }
        return assignedResources;
    }
}