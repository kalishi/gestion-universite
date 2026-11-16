package ht.unaf.inscriptions.web;

import ht.unaf.inscriptions.model.Utilisateur;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/** Page racine : redirige chaque utilisateur vers son espace. */
@WebServlet("")
public class AccueilServlet extends BaseServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Utilisateur u = utilisateur(req);
        switch (u.getRole()) {
            case ADMIN -> rediriger(req, resp, "/admin/tableau-de-bord");
            case PROFESSEUR -> rediriger(req, resp, "/professeur/cours");
            default -> rediriger(req, resp, "/etudiant/accueil");
        }
    }
}
