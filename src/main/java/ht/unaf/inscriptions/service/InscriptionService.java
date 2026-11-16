package ht.unaf.inscriptions.service;

import ht.unaf.inscriptions.dao.*;
import ht.unaf.inscriptions.model.*;

import java.util.*;
import java.util.stream.Collectors;

/** Règles métier du choix des cours : dossier validé, prérequis et maximum de crédits. */
public class InscriptionService {
    private final DossierDao dossierDao = new DossierDao();
    private final CoursDao coursDao = new CoursDao();
    private final SessionDao sessionDao = new SessionDao();
    private final InscriptionCoursDao inscriptionDao = new InscriptionCoursDao();

    /** Codes des cours déjà réussis par l'étudiant (note finale >= 60). */
    public Set<Long> coursReussis(Long etudiantId) {
        return inscriptionDao.parEtudiant(etudiantId).stream()
                .filter(i -> i.getNoteFinale() != null && i.getNoteFinale() >= InscriptionCours.NOTE_PASSAGE)
                .map(i -> i.getCours().getId())
                .collect(Collectors.toSet());
    }

    /** Liste des prérequis manquants pour un cours (vide si tout est en règle). */
    public List<Cours> prerequisManquants(Cours cours, Set<Long> reussis) {
        return cours.getPrerequis().stream().filter(p -> !reussis.contains(p.getId())).toList();
    }

    /** Inscrit l'étudiant aux cours choisis pour la session active. */
    public void choisirCours(Utilisateur etudiant, List<Long> coursIds) {
        DossierInscription dossier = dossierDao.parEtudiant(etudiant.getId());
        if (dossier == null || dossier.getStatut() != StatutDossier.VALIDE) {
            throw new ServiceException("Votre dossier d'inscription doit être validé par l'administration avant de choisir des cours.");
        }
        SessionAcademique session = sessionDao.active();
        if (session == null) throw new ServiceException("Aucune session n'est ouverte actuellement.");
        if (coursIds == null || coursIds.isEmpty()) throw new ServiceException("Sélectionnez au moins un cours.");

        List<InscriptionCours> dejaInscrits = inscriptionDao.parEtudiantEtSession(etudiant.getId(), session.getId());
        Set<Long> idsDeja = dejaInscrits.stream().map(i -> i.getCours().getId()).collect(Collectors.toSet());
        int credits = dejaInscrits.stream().mapToInt(i -> i.getCours().getCredits()).sum();
        Set<Long> reussis = coursReussis(etudiant.getId());

        List<Cours> aAjouter = new ArrayList<>();
        for (Long id : coursIds) {
            if (idsDeja.contains(id)) continue;
            Cours c = coursDao.trouver(id);
            if (c == null) continue;
            if (!c.getProgramme().getId().equals(dossier.getProgramme().getId())) {
                throw new ServiceException("Le cours " + c.getCode() + " n'appartient pas à votre programme.");
            }
            if (reussis.contains(c.getId())) {
                throw new ServiceException("Vous avez déjà réussi le cours " + c.getCode() + ".");
            }
            List<Cours> manquants = prerequisManquants(c, reussis);
            if (!manquants.isEmpty()) {
                throw new ServiceException("Prérequis non validés pour " + c.getCode() + " : "
                        + manquants.stream().map(Cours::getCode).collect(Collectors.joining(", ")));
            }
            credits += c.getCredits();
            aAjouter.add(c);
        }
        int max = dossier.getProgramme().getMaxCredits();
        if (credits > max) {
            throw new ServiceException("Maximum de crédits dépassé : " + credits + " / " + max + " crédits autorisés.");
        }
        for (Cours c : aAjouter) {
            inscriptionDao.enregistrer(new InscriptionCours(etudiant, c, session));
        }
    }

    /** Retire un cours (seulement tant qu'aucune note n'est saisie). */
    public void retirerCours(Utilisateur etudiant, Long inscriptionId) {
        InscriptionCours i = inscriptionDao.trouver(inscriptionId);
        if (i == null || !i.getEtudiant().getId().equals(etudiant.getId())) return;
        if (i.getNotePartiel() != null || i.getNoteExamenFinal() != null || i.getNoteTravaux() != null) {
            throw new ServiceException("Impossible de retirer un cours déjà noté.");
        }
        inscriptionDao.supprimer(inscriptionId);
    }

    public double solde(DossierInscription d) {
        return d.getProgramme().getFraisScolarite() - dossierDao.totalPaye(d.getId());
    }
}
