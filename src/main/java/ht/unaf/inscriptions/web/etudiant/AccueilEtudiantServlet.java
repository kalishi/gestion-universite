package ht.unaf.inscriptions.web.etudiant;

import ht.unaf.inscriptions.dao.*;
import ht.unaf.inscriptions.model.*;
import ht.unaf.inscriptions.web.BaseServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import ht.unaf.inscriptions.service.InscriptionService;

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
        if (session != null) {
            req.setAttribute("nbCours", new InscriptionCoursDao().parEtudiantEtSession(u.getId(), session.getId()).size());
        }
        vue(req, resp, "etudiant/accueil");
    }
}
