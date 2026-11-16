package ht.unaf.inscriptions.web.etudiant;

import ht.unaf.inscriptions.dao.*;
import ht.unaf.inscriptions.model.*;
import ht.unaf.inscriptions.web.BaseServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import ht.unaf.inscriptions.util.Fichiers;
import jakarta.servlet.annotation.MultipartConfig;

import java.time.LocalDate;

/** Dépôt du dossier d'inscription avec pièces jointes (photo, diplôme, acte de naissance). */
@WebServlet("/etudiant/dossier")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024, maxRequestSize = 20 * 1024 * 1024)
public class DossierEtudiantServlet extends BaseServlet {
    private final DossierDao dao = new DossierDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("dossier", dao.parEtudiant(utilisateur(req).getId()));
        req.setAttribute("programmes", new GenericDao<>(Programme.class).tous());
        vue(req, resp, "etudiant/dossier");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Utilisateur u = utilisateur(req);
        try {
            DossierInscription d = dao.parEtudiant(u.getId());
            if (d == null) {
                d = new DossierInscription();
                d.setEtudiant(u);
            } else if (d.getStatut() == StatutDossier.VALIDE) {
                throw new ht.unaf.inscriptions.service.ServiceException("Votre dossier est déjà validé.");
            }
            Programme p = new GenericDao<>(Programme.class).trouver(id(req, "programmeId"));
            if (p == null) throw new ht.unaf.inscriptions.service.ServiceException("Choisissez un programme.");
            d.setProgramme(p);
            d.setTelephone(texte(req, "telephone"));
            d.setAdresse(texte(req, "adresse"));
            String naissance = texte(req, "dateNaissance");
            d.setDateNaissance(naissance == null ? null : LocalDate.parse(naissance));

            String prefixe = "etu" + u.getId();
            String photo = Fichiers.enregistrer(req.getPart("photo"), prefixe + "-photo");
            String diplome = Fichiers.enregistrer(req.getPart("diplome"), prefixe + "-diplome");
            String acte = Fichiers.enregistrer(req.getPart("acte"), prefixe + "-acte");
            if (photo != null) d.setPhoto(photo);
            if (diplome != null) d.setDiplome(diplome);
            if (acte != null) d.setActeNaissance(acte);
            if (d.getPhoto() == null || d.getDiplome() == null || d.getActeNaissance() == null) {
                throw new ht.unaf.inscriptions.service.ServiceException("Les trois pièces jointes sont obligatoires.");
            }
            d.setStatut(StatutDossier.EN_ATTENTE);
            dao.enregistrer(d);
            flash(req, "success", "Dossier déposé. Il sera examiné par l'administration.");
            rediriger(req, resp, "/etudiant/accueil");
        } catch (Exception e) {
            flash(req, "danger", messageErreur(e));
            rediriger(req, resp, "/etudiant/dossier");
        }
    }
}
