package ht.unaf.inscriptions.web;

import ht.unaf.inscriptions.model.Role;
import ht.unaf.inscriptions.model.Utilisateur;
import ht.unaf.inscriptions.service.AuthService;
import ht.unaf.inscriptions.service.ServiceException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/** Création de compte étudiant. */
@WebServlet("/inscription")
public class InscriptionCompteServlet extends BaseServlet {
    private final AuthService authService = new AuthService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        vue(req, resp, "commun/inscription");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Utilisateur u = authService.creerCompte(req.getParameter("nom"), req.getParameter("prenom"),
                    req.getParameter("email"), req.getParameter("motDePasse"), Role.ETUDIANT);
            req.getSession().setAttribute("utilisateur", u);
            flash(req, "success", "Compte créé ! Déposez maintenant votre dossier d'inscription.");
            rediriger(req, resp, "/etudiant/dossier");
        } catch (ServiceException e) {
            req.setAttribute("erreur", e.getMessage());
            vue(req, resp, "commun/inscription");
        }
    }
}
