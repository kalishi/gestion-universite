package ht.unaf.gestion.service;

import ht.unaf.gestion.dao.UtilisateurDao;
import ht.unaf.gestion.model.*;
import ht.unaf.gestion.util.JPAUtil;
import ht.unaf.gestion.util.MotDePasse;
import jakarta.persistence.EntityManager;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

/**
 * Données de démonstration pour toute l'université (insérées au premier démarrage, base vide).
 * Comptes : admin@unaf.ht / admin123, prof@unaf.ht / prof123, etudiant@unaf.ht / etu123.
 */
public class DonneesDemo {

    public static void chargerSiVide() {
        if (new UtilisateurDao().compter() > 0) return;
        JPAUtil.executer(DonneesDemo::charger);
    }

    private static void charger(EntityManager em) {
        em.persist(new Utilisateur("Système", "Administrateur", "admin@unaf.ht", MotDePasse.hacher("admin123"), Role.ADMIN));

        // ---------- Facultés ----------
        Faculte fsi = fac(em, "Faculté des Sciences Informatiques");
        Faculte fsg = fac(em, "Faculté des Sciences de Gestion");
        Faculte fdse = fac(em, "Faculté de Droit et des Sciences Économiques");
        Faculte fmed = fac(em, "Faculté de Médecine et des Sciences de la Santé");
        Faculte fagr = fac(em, "Faculté d'Agronomie");
        Faculte fsed = fac(em, "Faculté des Sciences de l'Éducation");
        Faculte fgc = fac(em, "Faculté de Génie Civil");

        // ---------- Programmes ----------
        Programme licInfo = prog(em, "Licence en Informatique", Niveau.LICENCE, fsi, 45000, 18);
        Programme masGL = prog(em, "Master en Génie Logiciel", Niveau.MASTER, fsi, 75000, 15);
        Programme licGes = prog(em, "Licence en Gestion des Affaires", Niveau.LICENCE, fsg, 40000, 18);
        Programme licCpt = prog(em, "Licence en Comptabilité", Niveau.LICENCE, fsg, 40000, 18);
        Programme licDroit = prog(em, "Licence en Droit", Niveau.LICENCE, fdse, 38000, 18);
        Programme masEco = prog(em, "Master en Économie du Développement", Niveau.MASTER, fdse, 70000, 15);
        Programme licInf = prog(em, "Licence en Sciences Infirmières", Niveau.LICENCE, fmed, 55000, 20);
        Programme docMed = prog(em, "Doctorat en Médecine", Niveau.DOCTORAT, fmed, 120000, 24);
        Programme licAgr = prog(em, "Licence en Agronomie", Niveau.LICENCE, fagr, 35000, 18);
        Programme licEdu = prog(em, "Licence en Sciences de l'Éducation", Niveau.LICENCE, fsed, 30000, 18);
        Programme licGC = prog(em, "Licence en Génie Civil", Niveau.LICENCE, fgc, 60000, 20);

        // ---------- Salles ----------
        Salle a101 = salle(em, "A-101", 40), a102 = salle(em, "A-102", 40), b204 = salle(em, "B-204", 30);
        Salle amphi = salle(em, "Amphithéâtre 1", 150), labo1 = salle(em, "Labo Informatique 1", 25);
        Salle laboSante = salle(em, "Labo Santé", 30), atelier = salle(em, "Atelier Génie Civil", 35);

        // ---------- Sessions ----------
        SessionAcademique ancienne = new SessionAcademique("Automne 2025", LocalDate.of(2025, 9, 1), LocalDate.of(2026, 1, 31), false);
        SessionAcademique printemps = new SessionAcademique("Printemps 2026", LocalDate.of(2026, 2, 15), LocalDate.of(2026, 6, 30), false);
        SessionAcademique active = new SessionAcademique("Automne 2026", LocalDate.of(2026, 9, 1), LocalDate.of(2027, 1, 31), true);
        em.persist(ancienne); em.persist(printemps); em.persist(active);

        // ---------- Professeurs ----------
        Utilisateur pPierre = prof(em, "Pierre", "Jean", "prof@unaf.ht");
        Utilisateur pMarie = prof(em, "Joseph", "Marie", "prof2@unaf.ht");
        Utilisateur pDorce = prof(em, "Dorcé", "Rose-Andrée", "r.dorce@unaf.ht");
        Utilisateur pLouis = prof(em, "Louis-Jeune", "Patrick", "p.louisjeune@unaf.ht");
        Utilisateur pCharles = prof(em, "Charles", "Mireille", "m.charles@unaf.ht");
        Utilisateur pEtienne = prof(em, "Étienne", "Wilfrid", "w.etienne@unaf.ht");
        Utilisateur pAugustin = prof(em, "Augustin", "Nathalie", "n.augustin@unaf.ht");

        // ---------- Cours ----------
        Map<String, Cours> c = new HashMap<>();
        c.put("INF101", cours(em, "INF101", "Algorithmique", 4, licInfo, pPierre, a101, "Lundi", "08:00", "10:00"));
        c.put("INF102", cours(em, "INF102", "Programmation Java", 4, licInfo, pPierre, labo1, "Mardi", "08:00", "10:00"));
        c.put("INF201", cours(em, "INF201", "Bases de données", 4, licInfo, pMarie, b204, "Mercredi", "10:00", "12:00"));
        c.put("INF202", cours(em, "INF202", "Réseaux informatiques", 3, licInfo, pMarie, a101, "Vendredi", "08:00", "10:00"));
        c.put("INF301", cours(em, "INF301", "Java EE", 5, licInfo, pPierre, labo1, "Jeudi", "13:00", "16:00"));
        c.put("MAT101", cours(em, "MAT101", "Mathématiques discrètes", 3, licInfo, pMarie, b204, "Lundi", "10:00", "12:00"));
        c.put("GL501", cours(em, "GL501", "Architecture logicielle", 5, masGL, pPierre, b204, "Lundi", "13:00", "16:00"));
        c.put("GL502", cours(em, "GL502", "Gestion de projets logiciels", 4, masGL, null, a102, "Mercredi", "13:00", "16:00"));
        c.put("GES101", cours(em, "GES101", "Introduction au management", 4, licGes, pDorce, a102, "Mardi", "13:00", "15:00"));
        c.put("GES102", cours(em, "GES102", "Marketing", 3, licGes, pDorce, a102, "Jeudi", "08:00", "10:00"));
        c.put("CPT101", cours(em, "CPT101", "Comptabilité générale", 4, licCpt, pDorce, a101, "Mercredi", "08:00", "10:00"));
        c.put("CPT201", cours(em, "CPT201", "Comptabilité analytique", 4, licCpt, null, a101, "Vendredi", "10:00", "12:00"));
        c.put("DRT101", cours(em, "DRT101", "Droit constitutionnel haïtien", 4, licDroit, pLouis, amphi, "Lundi", "08:00", "11:00"));
        c.put("DRT102", cours(em, "DRT102", "Droit civil", 4, licDroit, pLouis, amphi, "Mercredi", "08:00", "11:00"));
        c.put("ECO501", cours(em, "ECO501", "Économie du développement", 5, masEco, pLouis, b204, "Samedi", "09:00", "12:00"));
        c.put("SAN101", cours(em, "SAN101", "Anatomie", 5, licInf, pCharles, laboSante, "Lundi", "08:00", "11:00"));
        c.put("SAN102", cours(em, "SAN102", "Soins infirmiers de base", 4, licInf, pCharles, laboSante, "Jeudi", "08:00", "11:00"));
        c.put("MED101", cours(em, "MED101", "Biologie cellulaire", 6, docMed, pCharles, amphi, "Mardi", "08:00", "12:00"));
        c.put("AGR101", cours(em, "AGR101", "Sciences du sol", 4, licAgr, pEtienne, a102, "Lundi", "13:00", "15:00"));
        c.put("AGR102", cours(em, "AGR102", "Production végétale", 4, licAgr, pEtienne, a102, "Jeudi", "13:00", "15:00"));
        c.put("EDU101", cours(em, "EDU101", "Psychologie de l'éducation", 3, licEdu, pAugustin, a101, "Mardi", "10:00", "12:00"));
        c.put("EDU102", cours(em, "EDU102", "Didactique générale", 3, licEdu, pAugustin, a101, "Vendredi", "13:00", "15:00"));
        c.put("GC101", cours(em, "GC101", "Résistance des matériaux", 5, licGC, pEtienne, atelier, "Mercredi", "13:00", "16:00"));
        c.put("GC102", cours(em, "GC102", "Dessin technique", 4, licGC, null, atelier, "Samedi", "08:00", "11:00"));
        c.get("INF201").getPrerequis().add(c.get("INF101"));
        c.get("INF301").getPrerequis().add(c.get("INF102"));
        c.get("INF301").getPrerequis().add(c.get("INF201"));
        c.get("CPT201").getPrerequis().add(c.get("CPT101"));
        c.get("DRT102").getPrerequis().add(c.get("DRT101"));
        c.get("SAN102").getPrerequis().add(c.get("SAN101"));

        // ---------- Étudiants ----------
        // Étudiant principal de démonstration (Informatique, dossier validé, 2 cours réussis)
        Utilisateur nadege = etu(em, "Louis", "Nadège", "etudiant@unaf.ht", "etu123");
        DossierInscription dNadege = dossier(em, nadege, licInfo, StatutDossier.VALIDE, "+509 3700-0000", "Port-au-Prince", LocalDate.of(2004, 5, 12), 20000);
        note(em, nadege, c.get("INF101"), ancienne, 75, 80, 85);
        note(em, nadege, c.get("INF102"), ancienne, 70, 65, 90);

        Object[][] etudiants = {
                {"Jean-Baptiste", "Kervens", licInfo, StatutDossier.VALIDE, 45000.0, "Cap-Haïtien"},
                {"Pierre-Louis", "Daphnée", licInfo, StatutDossier.EN_ATTENTE, 0.0, "Pétion-Ville"},
                {"Desir", "Ricardo", masGL, StatutDossier.VALIDE, 50000.0, "Delmas"},
                {"Joseph", "Fabienne", licGes, StatutDossier.VALIDE, 25000.0, "Jacmel"},
                {"Saint-Fleur", "Woodly", licGes, StatutDossier.EN_ATTENTE, 0.0, "Les Cayes"},
                {"Noël", "Christelle", licCpt, StatutDossier.VALIDE, 40000.0, "Gonaïves"},
                {"Toussaint", "Junior", licDroit, StatutDossier.VALIDE, 15000.0, "Port-au-Prince"},
                {"Florestal", "Esther", licDroit, StatutDossier.REJETE, 0.0, "Saint-Marc"},
                {"Bien-Aimé", "Jameson", masEco, StatutDossier.EN_ATTENTE, 0.0, "Carrefour"},
                {"Paul", "Ketsia", licInf, StatutDossier.VALIDE, 55000.0, "Hinche"},
                {"Augustin", "Mackenson", docMed, StatutDossier.VALIDE, 60000.0, "Port-de-Paix"},
                {"Lafortune", "Guerline", licAgr, StatutDossier.VALIDE, 20000.0, "Mirebalais"},
                {"Célestin", "Ronald", licAgr, StatutDossier.EN_ATTENTE, 0.0, "Jérémie"},
                {"Dieudonné", "Myrlande", licEdu, StatutDossier.VALIDE, 30000.0, "Léogâne"},
                {"Similien", "Stanley", licGC, StatutDossier.VALIDE, 35000.0, "Croix-des-Bouquets"},
                {"Valcourt", "Sabrina", licGC, StatutDossier.REJETE, 0.0, "Fort-Liberté"},
        };
        int i = 1;
        for (Object[] e : etudiants) {
            String email = sansAccent((String) e[1]) + "." + sansAccent((String) e[0]) + "@etu.unaf.ht";
            Utilisateur u = etu(em, (String) e[0], (String) e[1], email, "etu123");
            dossier(em, u, (Programme) e[2], (StatutDossier) e[3], "+509 3" + (600 + i) + "-" + (1000 + i * 37), (String) e[5],
                    LocalDate.of(2002 + i % 4, 1 + i % 12, 1 + i % 27), (Double) e[4]);
            i++;
        }

        // Inscriptions aux cours de la session active (pour les tableaux de bord)
        inscrire(em, "kervens.jeanbaptiste@etu.unaf.ht", active, c.get("INF101"), c.get("INF102"), c.get("MAT101"));
        inscrire(em, "ricardo.desir@etu.unaf.ht", active, c.get("GL501"), c.get("GL502"));
        inscrire(em, "fabienne.joseph@etu.unaf.ht", active, c.get("GES101"), c.get("GES102"));
        inscrire(em, "christelle.noel@etu.unaf.ht", active, c.get("CPT101"));
        inscrire(em, "junior.toussaint@etu.unaf.ht", active, c.get("DRT101"));
        inscrire(em, "ketsia.paul@etu.unaf.ht", active, c.get("SAN101"));
        inscrire(em, "mackenson.augustin@etu.unaf.ht", active, c.get("MED101"));
        inscrire(em, "guerline.lafortune@etu.unaf.ht", active, c.get("AGR101"), c.get("AGR102"));
        inscrire(em, "myrlande.dieudonne@etu.unaf.ht", active, c.get("EDU101"), c.get("EDU102"));
        inscrire(em, "stanley.similien@etu.unaf.ht", active, c.get("GC101"));
    }

    // ---------- Aides ----------
    /** « Dieudonné » -> « dieudonne », « Jean-Baptiste » -> « jeanbaptiste ». */
    private static String sansAccent(String s) {
        return java.text.Normalizer.normalize(s, java.text.Normalizer.Form.NFD)
                .replaceAll("\\p{M}", "").toLowerCase().replaceAll("[^a-z]", "");
    }

    private static Faculte fac(EntityManager em, String nom) { Faculte f = new Faculte(nom); em.persist(f); return f; }

    private static Programme prog(EntityManager em, String nom, Niveau n, Faculte f, double frais, int credits) {
        Programme p = new Programme(nom, n, f, frais, credits); em.persist(p); return p;
    }

    private static Salle salle(EntityManager em, String nom, int cap) { Salle s = new Salle(nom, cap); em.persist(s); return s; }

    private static Utilisateur prof(EntityManager em, String nom, String prenom, String email) {
        Utilisateur u = new Utilisateur(nom, prenom, email, MotDePasse.hacher("prof123"), Role.PROFESSEUR); em.persist(u); return u;
    }

    private static Utilisateur etu(EntityManager em, String nom, String prenom, String email, String mdp) {
        Utilisateur u = new Utilisateur(nom, prenom, email, MotDePasse.hacher(mdp), Role.ETUDIANT); em.persist(u); return u;
    }

    private static Cours cours(EntityManager em, String code, String intitule, int credits, Programme p, Utilisateur prof,
                               Salle salle, String jour, String debut, String fin) {
        Cours c = new Cours(code, intitule, credits, p);
        c.setProfesseur(prof); c.setSalle(salle); c.setJour(jour); c.setHeureDebut(debut); c.setHeureFin(fin);
        em.persist(c);
        return c;
    }

    private static DossierInscription dossier(EntityManager em, Utilisateur u, Programme p, StatutDossier statut,
                                              String tel, String adresse, LocalDate naissance, double paye) {
        DossierInscription d = new DossierInscription();
        d.setEtudiant(u); d.setProgramme(p); d.setStatut(statut);
        d.setTelephone(tel); d.setAdresse(adresse); d.setDateNaissance(naissance);
        d.setDateDepot(LocalDate.now().minusDays(Math.abs(u.getEmail().hashCode() % 40)));
        em.persist(d);
        if (paye > 0) {
            // Un ou deux versements selon le montant
            if (paye > 20000) {
                em.persist(new Paiement(d, Math.round(paye / 2)));
                em.persist(new Paiement(d, paye - Math.round(paye / 2)));
            } else {
                em.persist(new Paiement(d, paye));
            }
        }
        return d;
    }

    private static void note(EntityManager em, Utilisateur e, Cours c, SessionAcademique s, double p, double f, double t) {
        InscriptionCours i = new InscriptionCours(e, c, s);
        i.setNotePartiel(p); i.setNoteExamenFinal(f); i.setNoteTravaux(t); i.calculerNoteFinale();
        em.persist(i);
    }

    private static void inscrire(EntityManager em, String email, SessionAcademique s, Cours... cours) {
        Utilisateur u = em.createQuery("SELECT u FROM Utilisateur u WHERE u.email = :e", Utilisateur.class)
                .setParameter("e", email).getSingleResult();
        for (Cours c : cours) em.persist(new InscriptionCours(u, c, s));
    }
}
