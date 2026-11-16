package ht.unaf.gestion.service;

import ht.unaf.gestion.dao.InscriptionCoursDao;
import ht.unaf.gestion.model.InscriptionCours;
import ht.unaf.gestion.model.Utilisateur;

public class NoteService {
    private final InscriptionCoursDao inscriptionDao = new InscriptionCoursDao();

    /** Saisie des notes par le professeur du cours ; la note finale est calculée automatiquement. */
    public void saisirNotes(Utilisateur prof, Long inscriptionId, Double partiel, Double examenFinal, Double travaux) {
        InscriptionCours i = inscriptionDao.trouver(inscriptionId);
        if (i == null) return;
        if (i.getCours().getProfesseur() == null || !i.getCours().getProfesseur().getId().equals(prof.getId())) {
            throw new ServiceException("Vous n'êtes pas le professeur de ce cours.");
        }
        verifier(partiel); verifier(examenFinal); verifier(travaux);
        i.setNotePartiel(partiel);
        i.setNoteExamenFinal(examenFinal);
        i.setNoteTravaux(travaux);
        i.calculerNoteFinale();
        inscriptionDao.enregistrer(i);
    }

    private void verifier(Double n) {
        if (n != null && (n < 0 || n > 100)) throw new ServiceException("Les notes doivent être comprises entre 0 et 100.");
    }
}
