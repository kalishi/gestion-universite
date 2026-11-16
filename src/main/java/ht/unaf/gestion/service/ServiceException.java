package ht.unaf.gestion.service;

/** Erreur métier affichée à l'utilisateur. */
public class ServiceException extends RuntimeException {
    public ServiceException(String message) { super(message); }
}
