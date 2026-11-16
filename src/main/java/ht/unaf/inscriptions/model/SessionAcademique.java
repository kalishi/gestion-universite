package ht.unaf.inscriptions.model;

import jakarta.persistence.*;
import java.time.LocalDate;

/** Session (semestre) académique. Une seule session est active à la fois. */
@Entity
@Table(name = "session_academique")
public class SessionAcademique {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 80)
    private String libelle;

    @Column(name = "date_debut")
    private LocalDate dateDebut;

    @Column(name = "date_fin")
    private LocalDate dateFin;

    private boolean active;

    public SessionAcademique() {}
    public SessionAcademique(String libelle, LocalDate debut, LocalDate fin, boolean active) {
        this.libelle = libelle; this.dateDebut = debut; this.dateFin = fin; this.active = active;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getLibelle() { return libelle; }
    public void setLibelle(String libelle) { this.libelle = libelle; }
    public LocalDate getDateDebut() { return dateDebut; }
    public void setDateDebut(LocalDate dateDebut) { this.dateDebut = dateDebut; }
    public LocalDate getDateFin() { return dateFin; }
    public void setDateFin(LocalDate dateFin) { this.dateFin = dateFin; }
    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }
}
