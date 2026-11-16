package ht.unaf.inscriptions.web.professeur;

import ht.unaf.inscriptions.dao.*;
import ht.unaf.inscriptions.model.*;
import ht.unaf.inscriptions.web.BaseServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import java.util.LinkedHashMap;
import java.util.Map;

@WebServlet("/professeur/cours")
public class MesCoursServlet extends BaseServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        SessionAcademique session = new SessionDao().active();
        InscriptionCoursDao inscDao = new InscriptionCoursDao();
        Map<Cours, Long> cours = new LinkedHashMap<>();
        for (Cours c : new CoursDao().parProfesseur(utilisateur(req).getId())) {
            cours.put(c, session == null ? 0 : inscDao.nombreInscrits(c.getId(), session.getId()));
        }
        req.setAttribute("session", session);
        req.setAttribute("cours", cours);
        vue(req, resp, "professeur/cours");
    }
}
