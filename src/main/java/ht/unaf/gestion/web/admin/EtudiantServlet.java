package ht.unaf.gestion.web.admin;

import ht.unaf.gestion.dao.*;
import ht.unaf.gestion.model.*;
import ht.unaf.gestion.web.BaseServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.*;

/** Annuaire des étudiants de toute l'université, filtrable par faculté. */
@WebServlet("/admin/etudiants")
public class EtudiantServlet extends BaseServlet {

    /** Ligne affichée : étudiant + dossier éventuel + situation financière. */
    public static class Ligne {
        private final Utilisateur etudiant;
        private final DossierInscription dossier;
        private final double paye;
        Ligne(Utilisateur e, DossierInscription d, double paye) { this.etudiant = e; this.dossier = d; this.paye = paye; }
        public Utilisateur getEtudiant() { return etudiant; }
        public DossierInscription getDossier() { return dossier; }
        public double getPaye() { return paye; }
        public double getSolde() { return dossier == null ? 0 : dossier.getProgramme().getFraisScolarite() - paye; }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long faculteId = id(req, "faculte");
        Map<Long, DossierInscription> dossiers = new HashMap<>();
        for (DossierInscription d : new DossierDao().tous()) dossiers.put(d.getEtudiant().getId(), d);
        Map<Long, Double> payes = new StatsDao().payeParDossier();

        List<Ligne> lignes = new ArrayList<>();
        for (Utilisateur e : new UtilisateurDao().parRole(Role.ETUDIANT)) {
            DossierInscription d = dossiers.get(e.getId());
            if (faculteId != null && (d == null || !d.getProgramme().getFaculte().getId().equals(faculteId))) continue;
            lignes.add(new Ligne(e, d, d == null ? 0 : payes.getOrDefault(d.getId(), 0.0)));
        }
        req.setAttribute("lignes", lignes);
        req.setAttribute("facultes", new GenericDao<>(Faculte.class).tous());
        req.setAttribute("faculteId", faculteId);
        req.setAttribute("titre", "Étudiants");
        req.setAttribute("sousTitre", "Annuaire de tous les étudiants de l'université");
        req.setAttribute("menu", "etudiants");
        vue(req, resp, "admin/etudiants");
    }
}
