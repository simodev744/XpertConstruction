package org.example.xpertaconstruction.dao;

import org.example.xpertaconstruction.db.DBConnection;
import org.example.xpertaconstruction.models.Administrateur;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AdminDao {

    public Administrateur getAdminByUsername(String username) throws SQLException {
        String sql = "SELECT * FROM administrateur WHERE nom_utilisateur = ?";
        Administrateur admin = null;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, username);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    admin = new Administrateur();
                    admin.setId(rs.getInt("id"));
                    admin.setNomUtilisateur(rs.getString("nom_utilisateur"));
                    admin.setMotDePasse(rs.getString("mot_de_passe"));
                    admin.setEmail(rs.getString("email"));
                    admin.setDateCreation(rs.getTimestamp("date_creation"));
                }
            }
        } catch (SQLException e) {
            throw new SQLException("Error trouve admin par son nom: " + e.getMessage(), e);
        }
        return admin;
    }

}