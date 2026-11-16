package ht.unaf.inscriptions.web.admin;

import ht.unaf.inscriptions.dao.*;
import ht.unaf.inscriptions.model.*;
import ht.unaf.inscriptions.web.BaseServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/admin/sessions")
public class SessionServlet extends BaseServlet {
    private final SessionDao dao = new SessionDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("sessions", dao.tous());
        vue(req, resp, "admin/sessions");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String action = String.valueOf(req.getParameter("action"));
            switch (action) {
                case "activer" -> { dao.activer(id(req, "id")); flash(req, "success", "Session activée."); }
                case "supprimer" -> { dao.supprimer(id(req, "id")); flash(req, "success", "Session supprimée."); }
                default -> {
                    SessionAcademique s = new SessionAcademique(texte(req, "libelle"),
                            date(req, "dateDebut"), date(req, "dateFin"), false);
                    dao.enregistrer(s);
                    flash(req, "success", "Session créée. Pensez à l'activer.");
                }
            }
        } catch (Exception e) {
            flash(req, "danger", messageErreur(e));
        }
        rediriger(req, resp, "/admin/sessions");
    }

    private LocalDate date(HttpServletRequest req, String nom) {
        String v = texte(req, nom);
        return v == null ? null : LocalDate.parse(v);
    }
}
