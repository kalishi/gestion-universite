package ht.unaf.gestion.web.etudiant;

import ht.unaf.gestion.dao.*;
import ht.unaf.gestion.model.*;
import ht.unaf.gestion.web.BaseServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/etudiant/emploi-du-temps")
public class EmploiDuTempsServlet extends BaseServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        SessionAcademique session = new SessionDao().active();
        req.setAttribute("session", session);
        if (session != null) {
            req.setAttribute("mesCours", new InscriptionCoursDao().parEtudiantEtSession(utilisateur(req).getId(), session.getId()));
        }
        req.setAttribute("jours", new String[]{"Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi"});
        vue(req, resp, "etudiant/emploi-du-temps");
    }
}
