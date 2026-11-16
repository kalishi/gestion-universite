package ht.unaf.inscriptions.web;

import ht.unaf.inscriptions.model.Role;
import ht.unaf.inscriptions.model.Utilisateur;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/** Filtre d'authentification et de contrôle des rôles par préfixe d'URL. */
@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        req.setCharacterEncoding("UTF-8");

        String chemin = req.getRequestURI().substring(req.getContextPath().length());
        if (chemin.equals("/login") || chemin.equals("/inscription") || chemin.startsWith("/assets/")) {
            chain.doFilter(req, resp);
            return;
        }

        HttpSession session = req.getSession(false);
        Utilisateur u = session == null ? null : (Utilisateur) session.getAttribute("utilisateur");
        if (u == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Role requis = chemin.startsWith("/admin") ? Role.ADMIN
                : chemin.startsWith("/etudiant") ? Role.ETUDIANT
                : chemin.startsWith("/professeur") ? Role.PROFESSEUR
                : null;
        if (requis != null && u.getRole() != requis) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Accès refusé");
            return;
        }
        chain.doFilter(req, resp);
    }
}
