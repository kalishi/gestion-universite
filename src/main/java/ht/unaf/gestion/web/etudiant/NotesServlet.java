package ht.unaf.gestion.web.etudiant;

import ht.unaf.gestion.dao.*;
import ht.unaf.gestion.model.*;
import ht.unaf.gestion.web.BaseServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import ht.unaf.gestion.service.ReleveService;

import java.util.List;

/** Consultation des notes et téléchargement du relevé en PDF. */
@WebServlet({"/etudiant/notes", "/etudiant/releve.pdf"})
public class NotesServlet extends BaseServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Utilisateur u = utilisateur(req);
        List<InscriptionCours> notes = new InscriptionCoursDao().parEtudiant(u.getId());

        if (req.getServletPath().endsWith(".pdf")) {
            resp.setContentType("application/pdf");
            resp.setHeader("Content-Disposition", "attachment; filename=\"releve-notes.pdf\"");
            new ReleveService().genererPdf(u, new DossierDao().parEtudiant(u.getId()), notes, resp.getOutputStream());
            return;
        }

        double points = 0; int credits = 0;
        for (InscriptionCours i : notes) {
            if (i.getNoteFinale() != null) {
                points += i.getNoteFinale() * i.getCours().getCredits();
                credits += i.getCours().getCredits();
            }
        }
        req.setAttribute("notes", notes);
        req.setAttribute("moyenne", credits == 0 ? null : Math.round(points / credits * 100.0) / 100.0);
        vue(req, resp, "etudiant/notes");
    }
}
