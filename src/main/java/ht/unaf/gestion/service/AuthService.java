package ht.unaf.gestion.service;

import ht.unaf.gestion.dao.UtilisateurDao;
import ht.unaf.gestion.model.Role;
import ht.unaf.gestion.model.Utilisateur;
import ht.unaf.gestion.util.MotDePasse;

public class AuthService {
    private static final int LONGUEUR_MIN = 6;
    private final UtilisateurDao utilisateurDao = new UtilisateurDao();

    public Utilisateur connecter(String email, String motDePasse) {
        Utilisateur u = utilisateurDao.parEmail(email == null ? "" : email.trim().toLowerCase());
        if (u == null || !MotDePasse.verifier(motDePasse, u.getMotDePasse())) {
            throw new ServiceException("Email ou mot de passe incorrect.");
        }
        // Migration transparente : un ancien mot de passe en clair est haché dès la connexion réussie
        if (!MotDePasse.estHache(u.getMotDePasse())) {
            u.setMotDePasse(MotDePasse.hacher(motDePasse));
            u = utilisateurDao.enregistrer(u);
        }
        return u;
    }

    public Utilisateur creerCompte(String nom, String prenom, String email, String motDePasse, Role role) {
        if (vide(nom) || vide(prenom) || vide(email) || vide(motDePasse)) {
            throw new ServiceException("Tous les champs sont obligatoires.");
        }
        if (motDePasse.length() < LONGUEUR_MIN) {
            throw new ServiceException("Le mot de passe doit contenir au moins " + LONGUEUR_MIN + " caractères.");
        }
        email = email.trim().toLowerCase();
        if (utilisateurDao.parEmail(email) != null) {
            throw new ServiceException("Un compte existe déjà avec cet email.");
        }
        return utilisateurDao.enregistrer(new Utilisateur(nom.trim(), prenom.trim(), email, MotDePasse.hacher(motDePasse), role));
    }

    private static boolean vide(String s) { return s == null || s.isBlank(); }
}
