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

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/** Choix des cours de la session active (vérification des prérequis et des crédits). */
@WebServlet("/etudiant/cours")
public class ChoixCoursServlet extends BaseServlet {
    private final InscriptionService service = new InscriptionService();

    /** Ligne affichée dans la liste des cours disponibles. */
    public static class LigneCours {
        private final Cours cours;
        private final boolean inscrit, reussi;
        private final String prerequisManquants;
        LigneCours(Cours c, boolean inscrit, boolean reussi, String manquants) {
            this.cours = c; this.inscrit = inscrit; this.reussi = reussi; this.prerequisManquants = manquants;
        }
        public Cours getCours() { return cours; }
        public boolean isInscrit() { return inscrit; }
        public boolean isReussi() { return reussi; }
        public String getPrerequisManquants() { return prerequisManquants; }
        public boolean isSelectionnable() { return !inscrit && !reussi && prerequisManquants.isEmpty(); }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Utilisateur u = utilisateur(req);
        DossierInscription d = new DossierDao().parEtudiant(u.getId());
        SessionAcademique session = new SessionDao().active();
        req.setAttribute("dossier", d);
        req.setAttribute("session", session);

        if (d != null && d.getStatut() == StatutDossier.VALIDE && session != null) {
            List<InscriptionCours> mesCours = new InscriptionCoursDao().parEtudiantEtSession(u.getId(), session.getId());
            Set<Long> idsInscrits = mesCours.stream().map(i -> i.getCours().getId()).collect(Collectors.toSet());
            Set<Long> reussis = service.coursReussis(u.getId());
            List<LigneCours> lignes = new ArrayList<>();
            for (Cours c : new CoursDao().parProgramme(d.getProgramme().getId())) {
                String manquants = service.prerequisManquants(c, reussis).stream()
                        .map(Cours::getCode).collect(Collectors.joining(", "));
                lignes.add(new LigneCours(c, idsInscrits.contains(c.getId()), reussis.contains(c.getId()), manquants));
            }
            req.setAttribute("lignes", lignes);
            req.setAttribute("mesCours", mesCours);
            req.setAttribute("creditsActuels", mesCours.stream().mapToInt(i -> i.getCours().getCredits()).sum());
        }
        vue(req, resp, "etudiant/cours");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            if ("retirer".equals(req.getParameter("action"))) {
                service.retirerCours(utilisateur(req), id(req, "inscriptionId"));
                flash(req, "success", "Cours retiré.");
            } else {
                service.choisirCours(utilisateur(req), ids(req, "coursIds"));
                flash(req, "success", "Inscription aux cours enregistrée.");
            }
        } catch (Exception e) {
            flash(req, "danger", messageErreur(e));
        }
        rediriger(req, resp, "/etudiant/cours");
    }
}
