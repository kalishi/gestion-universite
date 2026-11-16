package ht.unaf.gestion.web.admin;

import ht.unaf.gestion.dao.*;
import ht.unaf.gestion.model.*;
import ht.unaf.gestion.util.Json;
import ht.unaf.gestion.web.BaseServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/tableau-de-bord")
public class TableauDeBordServlet extends BaseServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        StatsDao stats = new StatsDao();
        UtilisateurDao u = new UtilisateurDao();
        SessionAcademique session = new SessionDao().active();

        req.setAttribute("nbEtudiants", u.parRole(Role.ETUDIANT).size());
        req.setAttribute("nbProfesseurs", u.parRole(Role.PROFESSEUR).size());
        req.setAttribute("nbFacultes", stats.compter("Faculte"));
        req.setAttribute("nbProgrammes", stats.compter("Programme"));
        req.setAttribute("nbCours", stats.compter("Cours"));
        req.setAttribute("coursSansProf", stats.coursSansProfesseur());
        req.setAttribute("sessionActive", session);

        Map<StatutDossier, Long> statuts = stats.dossiersParStatut();
        req.setAttribute("enAttente", statuts.get(StatutDossier.EN_ATTENTE));
        req.setAttribute("valides", statuts.get(StatutDossier.VALIDE));
        req.setAttribute("rejetes", statuts.get(StatutDossier.REJETE));

        double attendu = stats.fraisAttendus(), encaisse = stats.totalEncaisse();
        req.setAttribute("fraisAttendus", attendu);
        req.setAttribute("totalEncaisse", encaisse);
        req.setAttribute("resteARecouvrer", Math.max(0, attendu - encaisse));
        req.setAttribute("tauxRecouvrement", attendu == 0 ? 0 : Math.round(encaisse * 100 / attendu));

        Map<String, Long> parFaculte = stats.etudiantsParFaculte();
        req.setAttribute("chartFacLabels", Json.chaines(parFaculte.keySet()));
        req.setAttribute("chartFacValues", Json.nombres(parFaculte.values()));
        req.setAttribute("chartStatutValues", Json.nombres(statuts.values()));
        Map<String, Long> coursFac = stats.inscriptionsCoursParFaculte(session == null ? null : session.getId());
        req.setAttribute("chartCoursLabels", Json.chaines(coursFac.keySet()));
        req.setAttribute("chartCoursValues", Json.nombres(coursFac.values()));

        List<DossierInscription> recents = new DossierDao().tousRecents();
        req.setAttribute("dossiersRecents", recents.subList(0, Math.min(6, recents.size())));

        req.setAttribute("titre", "Tableau de bord");
        req.setAttribute("menu", "dashboard");
        vue(req, resp, "admin/tableau-de-bord");
    }
}
