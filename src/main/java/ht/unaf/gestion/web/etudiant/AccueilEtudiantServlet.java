package ht.unaf.gestion.web.etudiant;

import ht.unaf.gestion.dao.*;
import ht.unaf.gestion.model.*;
import ht.unaf.gestion.web.BaseServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import ht.unaf.gestion.service.InscriptionService;

@WebServlet("/etudiant/accueil")
public class AccueilEtudiantServlet extends BaseServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Utilisateur u = utilisateur(req);
        DossierDao dossierDao = new DossierDao();
        DossierInscription d = dossierDao.parEtudiant(u.getId());
        SessionAcademique session = new SessionDao().active();
        req.setAttribute("dossier", d);
        req.setAttribute("session", session);
        if (d != null) {
            req.setAttribute("paiements", dossierDao.paiements(d.getId()));
            req.setAttribute("totalPaye", dossierDao.totalPaye(d.getId()));
            req.setAttribute("solde", new InscriptionService().solde(d));
        }
        InscriptionCoursDao inscDao = new InscriptionCoursDao();
        if (session != null) {
            java.util.List<InscriptionCours> enCours = inscDao.parEtudiantEtSession(u.getId(), session.getId());
            req.setAttribute("coursSession", enCours);
            req.setAttribute("nbCours", enCours.size());
            req.setAttribute("creditsSession", enCours.stream().mapToInt(i -> i.getCours().getCredits()).sum());
        }
        double points = 0; int creditsNotes = 0, creditsValides = 0;
        java.util.List<InscriptionCours> notes = inscDao.parEtudiant(u.getId());
        for (InscriptionCours i : notes) {
            if (i.getNoteFinale() != null) {
                points += i.getNoteFinale() * i.getCours().getCredits();
                creditsNotes += i.getCours().getCredits();
                if (i.getNoteFinale() >= InscriptionCours.NOTE_PASSAGE) creditsValides += i.getCours().getCredits();
            }
        }
        req.setAttribute("moyenne", creditsNotes == 0 ? null : Math.round(points / creditsNotes * 100.0) / 100.0);
        req.setAttribute("creditsValides", creditsValides);
        java.util.List<InscriptionCours> notees = new java.util.ArrayList<>(notes.stream().filter(i -> i.getNoteFinale() != null).toList());
        java.util.Collections.reverse(notees);
        req.setAttribute("dernieresNotes", notees);
        req.setAttribute("titre", "Bonjour, " + u.getPrenom());
        req.setAttribute("sousTitre", "Votre espace étudiant");
        req.setAttribute("menu", "etu-accueil");
        vue(req, resp, "etudiant/accueil");
    }
}
