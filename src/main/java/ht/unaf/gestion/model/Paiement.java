package ht.unaf.gestion.model;

import jakarta.persistence.*;
import java.time.LocalDate;

/** Paiement (éventuellement partiel) des frais de scolarité. */
@Entity
@Table(name = "paiement")
public class Paiement {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(optional = false)
    private DossierInscription dossier;

    private double montant;

    @Column(name = "date_paiement")
    private LocalDate datePaiement = LocalDate.now();

    public Paiement() {}
    public Paiement(DossierInscription dossier, double montant) { this.dossier = dossier; this.montant = montant; }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public DossierInscription getDossier() { return dossier; }
    public void setDossier(DossierInscription dossier) { this.dossier = dossier; }
    public double getMontant() { return montant; }
    public void setMontant(double montant) { this.montant = montant; }
    public LocalDate getDatePaiement() { return datePaiement; }
    public void setDatePaiement(LocalDate datePaiement) { this.datePaiement = datePaiement; }
}
