package ht.unaf.gestion.util;

import org.mindrot.BCrypt;

/**
 * Hachage des mots de passe avec BCrypt (jBCrypt, Damien Miller — licence ISC).
 * <p>
 * Le mot de passe n'est jamais stocké : on stocke son empreinte BCrypt
 * (ex. {@code $2a$10$...}, 60 caractères) qui contient un sel aléatoire.
 * Deux utilisateurs ayant le même mot de passe ont donc des empreintes différentes.
 */
public final class MotDePasse {
    /** Coût BCrypt : 2^10 itérations (~80 ms par vérification). */
    private static final int COUT = 10;

    private MotDePasse() {}

    /** Calcule l'empreinte BCrypt d'un mot de passe en clair. */
    public static String hacher(String clair) {
        return BCrypt.hashpw(clair, BCrypt.gensalt(COUT));
    }

    /** Vérifie un mot de passe saisi contre l'empreinte stockée. */
    public static boolean verifier(String clair, String stocke) {
        if (clair == null || stocke == null) return false;
        if (estHache(stocke)) {
            try {
                return BCrypt.checkpw(clair, stocke);
            } catch (IllegalArgumentException e) {
                return false; // empreinte corrompue
            }
        }
        // Ancien compte enregistré en clair (avant la mise en place de BCrypt)
        return stocke.equals(clair);
    }

    /** Indique si la valeur stockée est déjà une empreinte BCrypt. */
    public static boolean estHache(String stocke) {
        return stocke != null && stocke.length() == 60
                && (stocke.startsWith("$2a$") || stocke.startsWith("$2b$") || stocke.startsWith("$2y$"));
    }
}
