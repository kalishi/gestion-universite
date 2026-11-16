package ht.unaf.gestion.model;

import jakarta.persistence.*;

/** Inscription d'un étudiant à un cours pour une session, avec ses notes (sur 100). */
@Entity
@Table(name = "inscription_cours",
       uniqueConstraints = @UniqueConstraint(columnNames = {"etudiant_id", "cours_id", "session_id"}))
public class InscriptionCours {
    /** Pondération de la note finale. */
    public static final double POIDS_PARTIEL = 0.30, POIDS_FINAL = 0.40, POIDS_TRAVAUX = 0.30;
    public static final double NOTE_PASSAGE = 60;

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(optional = false)
    private Utilisateur etudiant;

    @ManyToOne(optional = false)
    private Cours cours;

    @ManyToOne(optional = false)
    private SessionAcademique session;

    @Column(name = "note_partiel")
    private Double notePartiel;
    @Column(name = "note_examen_final")
    private Double noteExamenFinal;
    @Column(name = "note_travaux")
    private Double noteTravaux;
    @Column(name = "note_finale")
    private Double noteFinale;

    public InscriptionCours() {}
    public InscriptionCours(Utilisateur etudiant, Cours cours, SessionAcademique session) {
        this.etudiant = etudiant; this.cours = cours; this.session = session;
    }

    /** Calcul automatique de la note finale dès que les trois notes sont saisies. */
    public void calculerNoteFinale() {
        if (notePartiel != null && noteExamenFinal != null && noteTravaux != null) {
            double n = notePartiel * POIDS_PARTIEL + noteExamenFinal * POIDS_FINAL + noteTravaux * POIDS_TRAVAUX;
            noteFinale = Math.round(n * 100.0) / 100.0;
        } else {
            noteFinale = null;
        }
    }

    public String getMention() {
        if (noteFinale == null) return "En cours";
        return noteFinale >= NOTE_PASSAGE ? "Réussi" : "Échoué";
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Utilisateur getEtudiant() { return etudiant; }
    public void setEtudiant(Utilisateur etudiant) { this.etudiant = etudiant; }
    public Cours getCours() { return cours; }
    public void setCours(Cours cours) { this.cours = cours; }
    public SessionAcademique getSession() { return session; }
    public void setSession(SessionAcademique session) { this.session = session; }
    public Double getNotePartiel() { return notePartiel; }
    public void setNotePartiel(Double notePartiel) { this.notePartiel = notePartiel; }
    public Double getNoteExamenFinal() { return noteExamenFinal; }
    public void setNoteExamenFinal(Double noteExamenFinal) { this.noteExamenFinal = noteExamenFinal; }
    public Double getNoteTravaux() { return noteTravaux; }
    public void setNoteTravaux(Double noteTravaux) { this.noteTravaux = noteTravaux; }
    public Double getNoteFinale() { return noteFinale; }
    public void setNoteFinale(Double noteFinale) { this.noteFinale = noteFinale; }
}
