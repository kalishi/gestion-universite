package ht.unaf.gestion.web.admin;

import ht.unaf.gestion.dao.*;
import ht.unaf.gestion.model.*;
import ht.unaf.gestion.web.BaseServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/salles")
public class SalleServlet extends BaseServlet {
    private final GenericDao<Salle> dao = new GenericDao<>(Salle.class);

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("salles", dao.tous());
        req.setAttribute("edition", dao.trouver(id(req, "modifier")));
        vue(req, resp, "admin/salles");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            if ("supprimer".equals(req.getParameter("action"))) {
                dao.supprimer(id(req, "id"));
                flash(req, "success", "Salle supprimée.");
            } else {
                Salle s = id(req, "id") == null ? new Salle() : dao.trouver(id(req, "id"));
                s.setNom(texte(req, "nom"));
                s.setCapacite(entier(req, "capacite") == null ? 0 : entier(req, "capacite"));
                dao.enregistrer(s);
                flash(req, "success", "Salle enregistrée.");
            }
        } catch (Exception e) {
            flash(req, "danger", messageErreur(e));
        }
        rediriger(req, resp, "/admin/salles");
    }
}
