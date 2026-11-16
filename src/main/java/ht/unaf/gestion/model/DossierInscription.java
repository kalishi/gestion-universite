package ht.unaf.gestion.model;

import jakarta.persistence.*;
import java.time.LocalDate;

/** Dossier d'inscription déposé par un étudiant (un seul par étudiant). */
@Entity
@Table(name = "dossier_inscription")
public class DossierInscription {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(optional = false)
    @JoinColumn(unique = true)
    private Utilisateur etudiant;

    @ManyToOne(optional = false)
    private Programme programme;

    @Column(name = "date_naissance")
    private LocalDate dateNaissance;
    @Column(length = 30)
    private String telephone;
    @Column(length = 200)
    private String adresse;

    /** Noms des fichiers enregistrés sur le disque. */
    private String photo;
    private String diplome;
    @Column(name = "acte_naissance")
    private String acteNaissance;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private StatutDossier statut = StatutDossier.EN_ATTENTE;

    @Column(name = "date_depot")
    private LocalDate dateDepot = LocalDate.now();

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Utilisateur getEtudiant() { return etudiant; }
    public void setEtudiant(Utilisateur etudiant) { this.etudiant = etudiant; }
    public Programme getProgramme() { return programme; }
    public void setProgramme(Programme programme) { this.programme = programme; }
    public LocalDate getDateNaissance() { return dateNaissance; }
    public void setDateNaissance(LocalDate dateNaissance) { this.dateNaissance = dateNaissance; }
    public String getTelephone() { return telephone; }
    public void setTelephone(String telephone) { this.telephone = telephone; }
    public String getAdresse() { return adresse; }
    public void setAdresse(String adresse) { this.adresse = adresse; }
    public String getPhoto() { return photo; }
    public void setPhoto(String photo) { this.photo = photo; }
    public String getDiplome() { return diplome; }
    public void setDiplome(String diplome) { this.diplome = diplome; }
    public String getActeNaissance() { return acteNaissance; }
    public void setActeNaissance(String acteNaissance) { this.acteNaissance = acteNaissance; }
    public StatutDossier getStatut() { return statut; }
    public void setStatut(StatutDossier statut) { this.statut = statut; }
    public LocalDate getDateDepot() { return dateDepot; }
    public void setDateDepot(LocalDate dateDepot) { this.dateDepot = dateDepot; }
}
