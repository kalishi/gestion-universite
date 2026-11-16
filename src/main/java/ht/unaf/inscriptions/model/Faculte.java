package ht.unaf.inscriptions.model;

import jakarta.persistence.*;

@Entity
@Table(name = "faculte")
public class Faculte {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true, length = 120)
    private String nom;

    public Faculte() {}
    public Faculte(String nom) { this.nom = nom; }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }
}
