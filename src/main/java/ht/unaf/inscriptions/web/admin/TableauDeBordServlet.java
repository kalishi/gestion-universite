package ht.unaf.inscriptions.web.admin;

import ht.unaf.inscriptions.dao.*;
import ht.unaf.inscriptions.model.*;
import ht.unaf.inscriptions.web.BaseServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/tableau-de-bord")
public class TableauDeBordServlet extends BaseServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UtilisateurDao u = new UtilisateurDao();
        req.setAttribute("nbEtudiants", u.parRole(Role.ETUDIANT).size());
        req.setAttribute("nbProfesseurs", u.parRole(Role.PROFESSEUR).size());
        req.setAttribute("nbCours", new CoursDao().compter());
        req.setAttribute("nbProgrammes", new GenericDao<>(Programme.class).compter());
        req.setAttribute("enAttente", new DossierDao().tousRecents().stream()
                .filter(d -> d.getStatut() == StatutDossier.EN_ATTENTE).count());
        req.setAttribute("sessionActive", new SessionDao().active());
        vue(req, resp, "admin/tableau-de-bord");
    }
}
