package ht.unaf.gestion.web.admin;

import ht.unaf.gestion.dao.*;
import ht.unaf.gestion.model.*;
import ht.unaf.gestion.web.BaseServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/programmes")
public class ProgrammeServlet extends BaseServlet {
    private final GenericDao<Programme> dao = new GenericDao<>(Programme.class);
    private final GenericDao<Faculte> faculteDao = new GenericDao<>(Faculte.class);

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("programmes", dao.tous());
        req.setAttribute("facultes", faculteDao.tous());
        req.setAttribute("niveaux", Niveau.values());
        req.setAttribute("edition", dao.trouver(id(req, "modifier")));
        vue(req, resp, "admin/programmes");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            if ("supprimer".equals(req.getParameter("action"))) {
                dao.supprimer(id(req, "id"));
                flash(req, "success", "Programme supprimé.");
            } else {
                Programme p = id(req, "id") == null ? new Programme() : dao.trouver(id(req, "id"));
                p.setNom(texte(req, "nom"));
                p.setNiveau(Niveau.valueOf(req.getParameter("niveau")));
                p.setFaculte(faculteDao.trouver(id(req, "faculteId")));
                p.setFraisScolarite(decimal(req, "frais") == null ? 0 : decimal(req, "frais"));
                p.setMaxCredits(entier(req, "maxCredits") == null ? 18 : entier(req, "maxCredits"));
                dao.enregistrer(p);
                flash(req, "success", "Programme enregistré.");
            }
        } catch (Exception e) {
            flash(req, "danger", messageErreur(e));
        }
        rediriger(req, resp, "/admin/programmes");
    }
}
