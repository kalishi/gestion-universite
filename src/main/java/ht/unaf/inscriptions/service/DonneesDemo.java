package ht.unaf.inscriptions.service;

import ht.unaf.inscriptions.dao.*;
import ht.unaf.inscriptions.model.*;
import ht.unaf.inscriptions.util.JPAUtil;

import java.time.LocalDate;

/** Insère des données de démonstration au premier démarrage (base vide). */
public class DonneesDemo {

    public static void chargerSiVide() {
        if (new UtilisateurDao().compter() > 0) return;

        JPAUtil.executer(em -> {
            Utilisateur admin = new Utilisateur("Admin", "Système", "admin@unaf.ht", "admin123", Role.ADMIN);
            Utilisateur prof1 = new Utilisateur("Jean", "Pierre", "prof@unaf.ht", "prof123", Role.PROFESSEUR);
            Utilisateur prof2 = new Utilisateur("Joseph", "Marie", "prof2@unaf.ht", "prof123", Role.PROFESSEUR);
            Utilisateur etu = new Utilisateur("Louis", "Nadège", "etudiant@unaf.ht", "etu123", Role.ETUDIANT);
            em.persist(admin); em.persist(prof1); em.persist(prof2); em.persist(etu);

            Faculte fsi = new Faculte("Faculté des Sciences Informatiques");
            Faculte fsg = new Faculte("Faculté des Sciences de Gestion");
            em.persist(fsi); em.persist(fsg);

            Programme licInfo = new Programme("Licence en Informatique", Niveau.LICENCE, fsi, 45000, 18);
            Programme masInfo = new Programme("Master en Génie Logiciel", Niveau.MASTER, fsi, 75000, 15);
            Programme licGes = new Programme("Licence en Gestion", Niveau.LICENCE, fsg, 40000, 18);
            em.persist(licInfo); em.persist(masInfo); em.persist(licGes);

            Salle s1 = new Salle("A-101", 40), s2 = new Salle("B-204", 30), labo = new Salle("Labo 1", 25);
            em.persist(s1); em.persist(s2); em.persist(labo);

            SessionAcademique ancienne = new SessionAcademique("Automne 2025", LocalDate.of(2025, 9, 1), LocalDate.of(2026, 1, 31), false);
            SessionAcademique active = new SessionAcademique("Automne 2026", LocalDate.of(2026, 9, 1), LocalDate.of(2027, 1, 31), true);
            em.persist(ancienne); em.persist(active);

            Cours algo = cours("INF101", "Algorithmique", 4, licInfo, prof1, s1, "Lundi", "08:00", "10:00");
            Cours prog = cours("INF102", "Programmation Java", 4, licInfo, prof1, labo, "Mardi", "08:00", "10:00");
            Cours bd = cours("INF201", "Bases de données", 4, licInfo, prof2, s2, "Mercredi", "10:00", "12:00");
            Cours jee = cours("INF301", "Java EE", 5, licInfo, prof1, labo, "Jeudi", "13:00", "16:00");
            Cours reseau = cours("INF202", "Réseaux informatiques", 3, licInfo, prof2, s1, "Vendredi", "08:00", "10:00");
            Cours maths = cours("MAT101", "Mathématiques discrètes", 3, licInfo, prof2, s2, "Lundi", "10:00", "12:00");
            Cours archi = cours("GL501", "Architecture logicielle", 5, masInfo, prof1, s2, "Lundi", "13:00", "16:00");
            Cours compta = cours("GES101", "Comptabilité générale", 4, licGes, prof2, s1, "Mardi", "13:00", "15:00");
            for (Cours c : new Cours[]{algo, prog, bd, jee, reseau, maths, archi, compta}) em.persist(c);
            bd.getPrerequis().add(algo);
            jee.getPrerequis().add(prog);
            jee.getPrerequis().add(bd);

            // Dossier déjà validé + historique pour l'étudiant de démo
            DossierInscription d = new DossierInscription();
            d.setEtudiant(etu); d.setProgramme(licInfo); d.setTelephone("+509 3700-0000");
            d.setAdresse("Port-au-Prince"); d.setDateNaissance(LocalDate.of(2004, 5, 12));
            d.setStatut(StatutDossier.VALIDE);
            em.persist(d);
            em.persist(new Paiement(d, 20000));

            InscriptionCours i1 = new InscriptionCours(etu, algo, ancienne);
            i1.setNotePartiel(75.0); i1.setNoteExamenFinal(80.0); i1.setNoteTravaux(85.0); i1.calculerNoteFinale();
            InscriptionCours i2 = new InscriptionCours(etu, prog, ancienne);
            i2.setNotePartiel(70.0); i2.setNoteExamenFinal(65.0); i2.setNoteTravaux(90.0); i2.calculerNoteFinale();
            em.persist(i1); em.persist(i2);
        });
    }

    private static Cours cours(String code, String intitule, int credits, Programme p, Utilisateur prof,
                               Salle salle, String jour, String debut, String fin) {
        Cours c = new Cours(code, intitule, credits, p);
        c.setProfesseur(prof); c.setSalle(salle); c.setJour(jour); c.setHeureDebut(debut); c.setHeureFin(fin);
        return c;
    }
}
