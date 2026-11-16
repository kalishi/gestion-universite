package ht.unaf.gestion.model;

import jakarta.persistence.*;

@Entity
@Table(name = "programme")
public class Programme {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 150)
    private String nom;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private Niveau niveau;

    @ManyToOne(optional = false)
    private Faculte faculte;

    /** Frais de scolarité annuels (HTG). */
    @Column(name = "frais_scolarite", nullable = false)
    private double fraisScolarite;

    /** Nombre maximum de crédits par session. */
    @Column(name = "max_credits", nullable = false)
    private int maxCredits;

    public Programme() {}
    public Programme(String nom, Niveau niveau, Faculte faculte, double frais, int maxCredits) {
        this.nom = nom; this.niveau = niveau; this.faculte = faculte; this.fraisScolarite = frais; this.maxCredits = maxCredits;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }
    public Niveau getNiveau() { return niveau; }
    public void setNiveau(Niveau niveau) { this.niveau = niveau; }
    public Faculte getFaculte() { return faculte; }
    public void setFaculte(Faculte faculte) { this.faculte = faculte; }
    public double getFraisScolarite() { return fraisScolarite; }
    public void setFraisScolarite(double fraisScolarite) { this.fraisScolarite = fraisScolarite; }
    public int getMaxCredits() { return maxCredits; }
    public void setMaxCredits(int maxCredits) { this.maxCredits = maxCredits; }
}
