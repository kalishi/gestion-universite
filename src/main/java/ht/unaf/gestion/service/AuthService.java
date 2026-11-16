package ht.unaf.gestion.service;

import ht.unaf.gestion.dao.UtilisateurDao;
import ht.unaf.gestion.model.Role;
import ht.unaf.gestion.model.Utilisateur;

public class AuthService {
    private final UtilisateurDao utilisateurDao = new UtilisateurDao();

    public Utilisateur connecter(String email, String motDePasse) {
        Utilisateur u = utilisateurDao.parEmail(email == null ? "" : email.trim().toLowerCase());
        if (u == null || !u.getMotDePasse().equals(motDePasse)) {
            throw new ServiceException("Email ou mot de passe incorrect.");
        }
        return u;
    }

    public Utilisateur creerCompte(String nom, String prenom, String email, String motDePasse, Role role) {
        if (vide(nom) || vide(prenom) || vide(email) || vide(motDePasse)) {
            throw new ServiceException("Tous les champs sont obligatoires.");
        }
        email = email.trim().toLowerCase();
        if (utilisateurDao.parEmail(email) != null) {
            throw new ServiceException("Un compte existe déjà avec cet email.");
        }
        return utilisateurDao.enregistrer(new Utilisateur(nom.trim(), prenom.trim(), email, motDePasse, role));
    }

    private static boolean vide(String s) { return s == null || s.isBlank(); }
}
