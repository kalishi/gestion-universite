package ht.unaf.gestion.web.admin;

import ht.unaf.gestion.dao.*;
import ht.unaf.gestion.model.*;
import ht.unaf.gestion.web.BaseServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import ht.unaf.gestion.service.InscriptionService;

/** Validation des dossiers d'inscription et gestion des paiements. */
@WebServlet("/admin/dossiers")
public class DossierServlet extends BaseServlet {
    private final DossierDao dao = new DossierDao();
    private final InscriptionService inscriptionService = new InscriptionService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        DossierInscription d = dao.trouver(id(req, "id"));
        if (d != null) {
            req.setAttribute("dossier", d);
            req.setAttribute("paiements", dao.paiements(d.getId()));
            req.setAttribute("totalPaye", dao.totalPaye(d.getId()));
            req.setAttribute("solde", inscriptionService.solde(d));
            req.setAttribute("titre", "Dossier de " + d.getEtudiant().getNomComplet());
            req.setAttribute("menu", "dossiers");
            vue(req, resp, "admin/dossier-detail");
        } else {
            String statut = req.getParameter("statut");
            java.util.List<DossierInscription> tous = dao.tousRecents();
            req.setAttribute("nbTous", tous.size());
            req.setAttribute("nbAttente", tous.stream().filter(x -> x.getStatut() == StatutDossier.EN_ATTENTE).count());
            req.setAttribute("nbValides", tous.stream().filter(x -> x.getStatut() == StatutDossier.VALIDE).count());
            req.setAttribute("nbRejetes", tous.stream().filter(x -> x.getStatut() == StatutDossier.REJETE).count());
            if (statut != null && !statut.isBlank()) {
                tous = tous.stream().filter(x -> x.getStatut().name().equals(statut)).toList();
            }
            req.setAttribute("dossiers", tous);
            req.setAttribute("statut", statut);
            req.setAttribute("titre", "Admissions");
            req.setAttribute("sousTitre", "Dossiers d'inscription de toutes les facultés");
            req.setAttribute("menu", "dossiers");
            vue(req, resp, "admin/dossiers");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Long id = id(req, "id");
        try {
            DossierInscription d = dao.trouver(id);
            switch (String.valueOf(req.getParameter("action"))) {
                case "valider" -> { d.setStatut(StatutDossier.VALIDE); dao.enregistrer(d); flash(req, "success", "Dossier validé."); }
                case "rejeter" -> { d.setStatut(StatutDossier.REJETE); dao.enregistrer(d); flash(req, "warning", "Dossier rejeté."); }
                case "paiement" -> {
                    Double montant = decimal(req, "montant");
                    if (montant == null || montant <= 0) throw new ht.unaf.gestion.service.ServiceException("Montant invalide.");
                    new GenericDao<>(Paiement.class).enregistrer(new Paiement(d, montant));
                    flash(req, "success", "Paiement enregistré.");
                }
                case "supprimerPaiement" -> {
                    new GenericDao<>(Paiement.class).supprimer(id(req, "paiementId"));
                    flash(req, "success", "Paiement supprimé.");
                }
                default -> {}
            }
        } catch (Exception e) {
            flash(req, "danger", messageErreur(e));
        }
        rediriger(req, resp, "/admin/dossiers?id=" + id);
    }
}
