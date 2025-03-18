package org.example.xpertaconstruction.models;
import java.sql.Timestamp;
public class Ressource {
    private int id;
    private String nom;
    private String type;
    private int quantite;
    private String unite;
    private String description;
    private int fournisseurId;
    private Timestamp dateCreation;

    public Ressource() {}

    public Ressource(int id, String nom, String type, int quantite, String unite, String description, int fournisseurId, Timestamp dateCreation) {
        this.id = id;
        this.nom = nom;
        this.type = type;
        this.quantite = quantite;
        this.unite = unite;
        this.description = description;
        this.fournisseurId = fournisseurId;
        this.dateCreation = dateCreation;
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getQuantite() {
        return quantite;
    }

    public void setQuantite(int quantite) {
        this.quantite = quantite;
    }

    public String getUnite() {
        return unite;
    }

    public void setUnite(String unite) {
        this.unite = unite;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getFournisseurId() {
        return fournisseurId;
    }

    public void setFournisseurId(int fournisseurId) {
        this.fournisseurId = fournisseurId;
    }

    public Timestamp getDateCreation() {
        return dateCreation;
    }

    public void setDateCreation(Timestamp dateCreation) {
        this.dateCreation = dateCreation;
    }

}