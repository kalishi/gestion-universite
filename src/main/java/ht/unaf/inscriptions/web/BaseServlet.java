package ht.unaf.inscriptions.web;

import ht.unaf.inscriptions.model.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

/** Méthodes utilitaires partagées par tous les contrôleurs (servlets). */
public abstract class BaseServlet extends HttpServlet {

    /** Affiche une JSP située dans /WEB-INF/views. */
    protected void vue(HttpServletRequest req, HttpServletResponse resp, String nom) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/" + nom + ".jsp").forward(req, resp);
    }

    protected void rediriger(HttpServletRequest req, HttpServletResponse resp, String chemin) throws IOException {
        resp.sendRedirect(req.getContextPath() + chemin);
    }

    protected Utilisateur utilisateur(HttpServletRequest req) {
        return (Utilisateur) req.getSession().getAttribute("utilisateur");
    }

    /** Message affiché une fois après une redirection (type Bootstrap : success, danger...). */
    protected void flash(HttpServletRequest req, String type, String message) {
        req.getSession().setAttribute("flashType", type);
        req.getSession().setAttribute("flashMessage", message);
    }

    protected String texte(HttpServletRequest req, String nom) {
        String v = req.getParameter(nom);
        return v == null || v.isBlank() ? null : v.trim();
    }

    protected Long id(HttpServletRequest req, String nom) {
        try { return Long.valueOf(req.getParameter(nom)); } catch (Exception e) { return null; }
    }

    protected Integer entier(HttpServletRequest req, String nom) {
        try { return Integer.valueOf(req.getParameter(nom)); } catch (Exception e) { return null; }
    }

    protected Double decimal(HttpServletRequest req, String nom) {
        try { return Double.valueOf(req.getParameter(nom).replace(',', '.')); } catch (Exception e) { return null; }
    }

    protected List<Long> ids(HttpServletRequest req, String nom) {
        String[] v = req.getParameterValues(nom);
        if (v == null) return Collections.emptyList();
        return Arrays.stream(v).map(Long::valueOf).toList();
    }

    /** Message lisible pour une erreur (contrainte de clé étrangère, doublon...). */
    protected String messageErreur(Exception e) {
        if (e instanceof ht.unaf.inscriptions.service.ServiceException) return e.getMessage();
        Throwable t = e;
        while (t != null) {
            String m = String.valueOf(t.getMessage());
            if (m.contains("foreign key")) return "Opération impossible : cet élément est utilisé ailleurs.";
            if (m.contains("Duplicate") || m.contains("unique")) return "Cet élément existe déjà.";
            t = t.getCause();
        }
        return "Erreur : " + e.getMessage();
    }
}
