package ht.unaf.inscriptions.web.admin;

import ht.unaf.inscriptions.dao.*;
import ht.unaf.inscriptions.model.*;
import ht.unaf.inscriptions.web.BaseServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import ht.unaf.inscriptions.service.InscriptionService;

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
            vue(req, resp, "admin/dossier-detail");
        } else {
            req.setAttribute("dossiers", dao.tousRecents());
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
                    if (montant == null || montant <= 0) throw new ht.unaf.inscriptions.service.ServiceException("Montant invalide.");
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
