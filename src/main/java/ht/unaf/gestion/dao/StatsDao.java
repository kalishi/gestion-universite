package ht.unaf.gestion.dao;

import ht.unaf.gestion.model.StatutDossier;
import ht.unaf.gestion.util.JPAUtil;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/** Requêtes d'agrégation pour les tableaux de bord. */
public class StatsDao {

    /** Nombre d'étudiants admis (dossier validé) par faculté, y compris les facultés sans étudiant. */
    public Map<String, Long> etudiantsParFaculte() {
        Map<String, Long> res = new LinkedHashMap<>();
        JPAUtil.lire(em -> em.createQuery("SELECT f.nom FROM Faculte f ORDER BY f.nom", String.class).getResultList())
                .forEach(n -> res.put(n, 0L));
        List<Object[]> rows = JPAUtil.lire(em -> em.createQuery(
                "SELECT d.programme.faculte.nom, COUNT(d) FROM DossierInscription d WHERE d.statut = :s GROUP BY d.programme.faculte.nom",
                Object[].class).setParameter("s", StatutDossier.VALIDE).getResultList());
        for (Object[] r : rows) res.put((String) r[0], (Long) r[1]);
        return res;
    }

    public Map<StatutDossier, Long> dossiersParStatut() {
        Map<StatutDossier, Long> res = new LinkedHashMap<>();
        for (StatutDossier s : StatutDossier.values()) res.put(s, 0L);
        List<Object[]> rows = JPAUtil.lire(em -> em.createQuery(
                "SELECT d.statut, COUNT(d) FROM DossierInscription d GROUP BY d.statut", Object[].class).getResultList());
        for (Object[] r : rows) res.put((StatutDossier) r[0], (Long) r[1]);
        return res;
    }

    /** Total des frais attendus pour les dossiers validés. */
    public double fraisAttendus() {
        Double v = JPAUtil.lire(em -> em.createQuery(
                "SELECT SUM(d.programme.fraisScolarite) FROM DossierInscription d WHERE d.statut = :s", Double.class)
                .setParameter("s", StatutDossier.VALIDE).getSingleResult());
        return v == null ? 0 : v;
    }

    public double totalEncaisse() {
        Double v = JPAUtil.lire(em -> em.createQuery("SELECT SUM(p.montant) FROM Paiement p", Double.class).getSingleResult());
        return v == null ? 0 : v;
    }

    /** Montant payé par dossier (id dossier -> total). */
    public Map<Long, Double> payeParDossier() {
        Map<Long, Double> res = new LinkedHashMap<>();
        List<Object[]> rows = JPAUtil.lire(em -> em.createQuery(
                "SELECT p.dossier.id, SUM(p.montant) FROM Paiement p GROUP BY p.dossier.id", Object[].class).getResultList());
        for (Object[] r : rows) res.put((Long) r[0], (Double) r[1]);
        return res;
    }

    /** Inscriptions aux cours de la session par faculté. */
    public Map<String, Long> inscriptionsCoursParFaculte(Long sessionId) {
        Map<String, Long> res = new LinkedHashMap<>();
        if (sessionId == null) return res;
        List<Object[]> rows = JPAUtil.lire(em -> em.createQuery(
                "SELECT i.cours.programme.faculte.nom, COUNT(i) FROM InscriptionCours i WHERE i.session.id = :s "
                        + "GROUP BY i.cours.programme.faculte.nom ORDER BY COUNT(i) DESC", Object[].class)
                .setParameter("s", sessionId).getResultList());
        for (Object[] r : rows) res.put((String) r[0], (Long) r[1]);
        return res;
    }

    public long coursSansProfesseur() {
        return JPAUtil.lire(em -> em.createQuery("SELECT COUNT(c) FROM Cours c WHERE c.professeur IS NULL", Long.class).getSingleResult());
    }

    public long compter(String entite) {
        return JPAUtil.lire(em -> em.createQuery("SELECT COUNT(e) FROM " + entite + " e", Long.class).getSingleResult());
    }
}
