package ht.unaf.gestion.web;

import ht.unaf.gestion.model.Utilisateur;
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

    /** Titre, sous-titre et entrée de menu active par défaut pour chaque vue. */
    private static final java.util.Map<String, String[]> PAGES = java.util.Map.ofEntries(
            java.util.Map.entry("admin/facultes", new String[]{"Facultés", "facultes", "Les facultés et écoles de l'université"}),
            java.util.Map.entry("admin/programmes", new String[]{"Programmes", "programmes", "Licences, masters et doctorats offerts"}),
            java.util.Map.entry("admin/cours", new String[]{"Cours", "cours", "Catalogue des cours, horaires, prérequis et enseignants"}),
            java.util.Map.entry("admin/sessions", new String[]{"Sessions académiques", "sessions", "Semestres et session ouverte aux inscriptions"}),
            java.util.Map.entry("admin/salles", new String[]{"Salles", "salles", "Salles de cours et laboratoires"}),
            java.util.Map.entry("admin/professeurs", new String[]{"Corps professoral", "professeurs", "Comptes et affectations des professeurs"}),
            java.util.Map.entry("etudiant/dossier", new String[]{"Dossier d'admission", "etu-dossier", "Pièces et informations de votre inscription"}),
            java.util.Map.entry("etudiant/cours", new String[]{"Choix des cours", "etu-cours", "Inscription aux cours de la session"}),
            java.util.Map.entry("etudiant/emploi-du-temps", new String[]{"Emploi du temps", "etu-edt", "Vos cours de la semaine"}),
            java.util.Map.entry("etudiant/notes", new String[]{"Notes & relevé", "etu-notes", "Résultats de toutes vos sessions"}),
            java.util.Map.entry("professeur/cours", new String[]{"Mes cours", "prof-cours", "Cours qui vous sont affectés"}),
            java.util.Map.entry("professeur/notes", new String[]{"Saisie des notes", "prof-cours", null}));

    /** Affiche une JSP située dans /WEB-INF/views. */
    protected void vue(HttpServletRequest req, HttpServletResponse resp, String nom) throws ServletException, IOException {
        String[] page = PAGES.get(nom);
        if (page != null) {
            if (req.getAttribute("titre") == null) req.setAttribute("titre", page[0]);
            if (req.getAttribute("menu") == null) req.setAttribute("menu", page[1]);
            if (req.getAttribute("sousTitre") == null && page[2] != null) req.setAttribute("sousTitre", page[2]);
        }
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
        if (e instanceof ht.unaf.gestion.service.ServiceException) return e.getMessage();
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
