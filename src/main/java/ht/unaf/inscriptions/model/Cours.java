package ht.unaf.inscriptions.model;

import jakarta.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "cours")
public class Cours {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true, length = 20)
    private String code;

    @Column(nullable = false, length = 150)
    private String intitule;

    private int credits;

    @ManyToOne(optional = false)
    private Programme programme;

    /** Professeur affecté au cours (peut être vide). */
    @ManyToOne
    private Utilisateur professeur;

    @ManyToOne
    private Salle salle;

    /** Horaire simple : jour + heures (ex. "Lundi", "08:00", "10:00"). */
    @Column(length = 15)
    private String jour;
    @Column(name = "heure_debut", length = 5)
    private String heureDebut;
    @Column(name = "heure_fin", length = 5)
    private String heureFin;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name = "cours_prerequis",
            joinColumns = @JoinColumn(name = "cours_id"),
            inverseJoinColumns = @JoinColumn(name = "prerequis_id"))
    private Set<Cours> prerequis = new HashSet<>();

    public Cours() {}
    public Cours(String code, String intitule, int credits, Programme programme) {
        this.code = code; this.intitule = intitule; this.credits = credits; this.programme = programme;
    }

    public String getHoraire() {
        return jour == null ? "-" : jour + " " + heureDebut + " - " + heureFin;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }
    public String getIntitule() { return intitule; }
    public void setIntitule(String intitule) { this.intitule = intitule; }
    public int getCredits() { return credits; }
    public void setCredits(int credits) { this.credits = credits; }
    public Programme getProgramme() { return programme; }
    public void setProgramme(Programme programme) { this.programme = programme; }
    public Utilisateur getProfesseur() { return professeur; }
    public void setProfesseur(Utilisateur professeur) { this.professeur = professeur; }
    public Salle getSalle() { return salle; }
    public void setSalle(Salle salle) { this.salle = salle; }
    public String getJour() { return jour; }
    public void setJour(String jour) { this.jour = jour; }
    public String getHeureDebut() { return heureDebut; }
    public void setHeureDebut(String heureDebut) { this.heureDebut = heureDebut; }
    public String getHeureFin() { return heureFin; }
    public void setHeureFin(String heureFin) { this.heureFin = heureFin; }
    public Set<Cours> getPrerequis() { return prerequis; }
    public void setPrerequis(Set<Cours> prerequis) { this.prerequis = prerequis; }

    @Override public boolean equals(Object o) {
        return o instanceof Cours c && id != null && id.equals(c.id);
    }
    @Override public int hashCode() { return id == null ? 0 : id.hashCode(); }
}
