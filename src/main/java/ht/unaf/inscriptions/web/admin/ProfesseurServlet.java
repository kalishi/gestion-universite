package ht.unaf.inscriptions.web.admin;

import ht.unaf.inscriptions.dao.*;
import ht.unaf.inscriptions.model.*;
import ht.unaf.inscriptions.web.BaseServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import ht.unaf.inscriptions.service.AuthService;

/** Création des comptes professeurs. */
@WebServlet("/admin/professeurs")
public class ProfesseurServlet extends BaseServlet {
    private final UtilisateurDao dao = new UtilisateurDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("professeurs", dao.parRole(Role.PROFESSEUR));
        req.setAttribute("coursListe", new CoursDao().tous());
        vue(req, resp, "admin/professeurs");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            if ("supprimer".equals(req.getParameter("action"))) {
                dao.supprimer(id(req, "id"));
                flash(req, "success", "Professeur supprimé.");
            } else {
                new AuthService().creerCompte(req.getParameter("nom"), req.getParameter("prenom"),
                        req.getParameter("email"), req.getParameter("motDePasse"), Role.PROFESSEUR);
                flash(req, "success", "Compte professeur créé.");
            }
        } catch (Exception e) {
            flash(req, "danger", messageErreur(e));
        }
        rediriger(req, resp, "/admin/professeurs");
    }
}
