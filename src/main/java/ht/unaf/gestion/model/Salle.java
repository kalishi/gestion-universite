package ht.unaf.gestion.model;

import jakarta.persistence.*;

@Entity
@Table(name = "salle")
public class Salle {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true, length = 50)
    private String nom;

    private int capacite;

    public Salle() {}
    public Salle(String nom, int capacite) { this.nom = nom; this.capacite = capacite; }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }
    public int getCapacite() { return capacite; }
    public void setCapacite(int capacite) { this.capacite = capacite; }
}
