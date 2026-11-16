package ht.unaf.inscriptions.web;

import ht.unaf.inscriptions.model.Utilisateur;
import ht.unaf.inscriptions.service.AuthService;
import ht.unaf.inscriptions.service.ServiceException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends BaseServlet {
    private final AuthService authService = new AuthService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        vue(req, resp, "commun/login");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Utilisateur u = authService.connecter(req.getParameter("email"), req.getParameter("motDePasse"));
            req.getSession().setAttribute("utilisateur", u);
            rediriger(req, resp, "/");
        } catch (ServiceException e) {
            req.setAttribute("erreur", e.getMessage());
            vue(req, resp, "commun/login");
        }
    }
}
