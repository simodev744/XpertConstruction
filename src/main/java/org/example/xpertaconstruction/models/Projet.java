package org.example.xpertaconstruction.models;

import java.sql.Date;
import java.sql.Timestamp;
public class Projet {
    private int id;
    private String nom;
    private String description;
    private Date dateDebut;
    private Date dateFin;
    private double budget;
    private String statut;
    private Timestamp dateCreation;
    private int administrateurId;
    public Projet() {}
    public Projet(int id, String nom, String description, Date dateDebut, Date dateFin, double budget, String statut, Timestamp dateCreation, int administrateurId) {
        this.id = id;
        this.nom = nom;
        this.description = description;
        this.dateDebut = dateDebut;
        this.dateFin = dateFin;
        this.budget = budget;
        this.statut = statut;
        this.dateCreation = dateCreation;
        this.administrateurId = administrateurId;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getDateDebut() {
        return dateDebut;
    }

    public void setDateDebut(Date dateDebut) {
        this.dateDebut = dateDebut;
    }

    public Date getDateFin() {
        return dateFin;
    }

    public void setDateFin(Date dateFin) {
        this.dateFin = dateFin;
    }

    public double getBudget() {
        return budget;
    }

    public void setBudget(double budget) {
        this.budget = budget;
    }

    public String getStatut() {
        return statut;
    }

    public void setStatut(String statut) {
        this.statut = statut;
    }

    public Timestamp getDateCreation() {
        return dateCreation;
    }

    public void setDateCreation(Timestamp dateCreation) {
        this.dateCreation = dateCreation;
    }

    public int getAdministrateurId() {
        return administrateurId;
    }

    public void setAdministrateurId(int administrateurId) {
        this.administrateurId = administrateurId;
    }

}