package ht.unaf.inscriptions.web.admin;

import ht.unaf.inscriptions.dao.*;
import ht.unaf.inscriptions.model.*;
import ht.unaf.inscriptions.web.BaseServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/facultes")
public class FaculteServlet extends BaseServlet {
    private final GenericDao<Faculte> dao = new GenericDao<>(Faculte.class);

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("facultes", dao.tous());
        req.setAttribute("edition", dao.trouver(id(req, "modifier")));
        vue(req, resp, "admin/facultes");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            if ("supprimer".equals(req.getParameter("action"))) {
                dao.supprimer(id(req, "id"));
                flash(req, "success", "Faculté supprimée.");
            } else {
                Faculte f = id(req, "id") == null ? new Faculte() : dao.trouver(id(req, "id"));
                f.setNom(texte(req, "nom"));
                dao.enregistrer(f);
                flash(req, "success", "Faculté enregistrée.");
            }
        } catch (Exception e) {
            flash(req, "danger", messageErreur(e));
        }
        rediriger(req, resp, "/admin/facultes");
    }
}
