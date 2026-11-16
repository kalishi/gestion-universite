package ht.unaf.gestion.web;

import ht.unaf.gestion.dao.DossierDao;
import ht.unaf.gestion.model.DossierInscription;
import ht.unaf.gestion.model.Role;
import ht.unaf.gestion.model.Utilisateur;
import ht.unaf.gestion.util.Fichiers;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

/** Affiche une pièce jointe d'un dossier (admin ou étudiant propriétaire). ?dossier=ID&type=photo|diplome|acte */
@WebServlet("/fichier")
public class FichierServlet extends BaseServlet {
    private final DossierDao dossierDao = new DossierDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Utilisateur u = utilisateur(req);
        DossierInscription d = dossierDao.trouver(id(req, "dossier"));
        if (d == null || (u.getRole() != Role.ADMIN && !d.getEtudiant().getId().equals(u.getId()))) {
            resp.sendError(404);
            return;
        }
        String nom = switch (String.valueOf(req.getParameter("type"))) {
            case "photo" -> d.getPhoto();
            case "diplome" -> d.getDiplome();
            case "acte" -> d.getActeNaissance();
            default -> null;
        };
        Path p = nom == null ? null : Fichiers.dossier().resolve(nom);
        if (p == null || !Files.exists(p)) {
            resp.sendError(404);
            return;
        }
        String mime = getServletContext().getMimeType(nom);
        resp.setContentType(mime == null ? "application/octet-stream" : mime);
        resp.setHeader("Content-Disposition", "inline; filename=\"" + nom + "\"");
        Files.copy(p, resp.getOutputStream());
    }
}
