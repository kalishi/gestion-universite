package ht.unaf.gestion.web.professeur;

import ht.unaf.gestion.dao.*;
import ht.unaf.gestion.model.*;
import ht.unaf.gestion.web.BaseServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import ht.unaf.gestion.service.NoteService;

/** Liste des étudiants d'un cours et saisie des notes (calcul automatique de la note finale). */
@WebServlet("/professeur/notes")
public class SaisieNotesServlet extends BaseServlet {
    private final NoteService noteService = new NoteService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Cours c = new CoursDao().trouver(id(req, "cours"));
        if (c == null || c.getProfesseur() == null || !c.getProfesseur().getId().equals(utilisateur(req).getId())) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        SessionAcademique session = new SessionDao().active();
        req.setAttribute("cours", c);
        req.setAttribute("session", session);
        if (session != null) {
            req.setAttribute("inscriptions", new InscriptionCoursDao().parCoursEtSession(c.getId(), session.getId()));
        }
        vue(req, resp, "professeur/notes");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            for (Long id : ids(req, "inscriptionId")) {
                noteService.saisirNotes(utilisateur(req), id,
                        decimal(req, "partiel_" + id), decimal(req, "final_" + id), decimal(req, "travaux_" + id));
            }
            flash(req, "success", "Notes enregistrées.");
        } catch (Exception e) {
            flash(req, "danger", messageErreur(e));
        }
        rediriger(req, resp, "/professeur/notes?cours=" + req.getParameter("cours"));
    }
}
