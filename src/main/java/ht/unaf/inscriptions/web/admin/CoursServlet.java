package ht.unaf.inscriptions.web.admin;

import ht.unaf.inscriptions.dao.*;
import ht.unaf.inscriptions.model.*;
import ht.unaf.inscriptions.web.BaseServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashSet;

/** Gestion des cours : horaire, salle, prérequis et affectation du professeur. */
@WebServlet("/admin/cours")
public class CoursServlet extends BaseServlet {
    private final CoursDao dao = new CoursDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("coursListe", dao.tous());
        req.setAttribute("programmes", new GenericDao<>(Programme.class).tous());
        req.setAttribute("salles", new GenericDao<>(Salle.class).tous());
        req.setAttribute("professeurs", new UtilisateurDao().parRole(Role.PROFESSEUR));
        req.setAttribute("jours", new String[]{"Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi"});
        req.setAttribute("edition", dao.trouver(id(req, "modifier")));
        vue(req, resp, "admin/cours");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            if ("supprimer".equals(req.getParameter("action"))) {
                dao.supprimer(id(req, "id"));
                flash(req, "success", "Cours supprimé.");
            } else {
                Cours c = id(req, "id") == null ? new Cours() : dao.trouver(id(req, "id"));
                c.setCode(texte(req, "code"));
                c.setIntitule(texte(req, "intitule"));
                c.setCredits(entier(req, "credits") == null ? 3 : entier(req, "credits"));
                c.setProgramme(new GenericDao<>(Programme.class).trouver(id(req, "programmeId")));
                c.setSalle(new GenericDao<>(Salle.class).trouver(id(req, "salleId")));
                c.setProfesseur(new UtilisateurDao().trouver(id(req, "professeurId")));
                c.setJour(texte(req, "jour"));
                c.setHeureDebut(texte(req, "heureDebut"));
                c.setHeureFin(texte(req, "heureFin"));
                c.setPrerequis(new HashSet<>());
                for (Long pid : ids(req, "prerequis")) {
                    if (!pid.equals(c.getId())) c.getPrerequis().add(dao.trouver(pid));
                }
                dao.enregistrer(c);
                flash(req, "success", "Cours enregistré.");
            }
        } catch (Exception e) {
            flash(req, "danger", messageErreur(e));
        }
        rediriger(req, resp, "/admin/cours");
    }
}
