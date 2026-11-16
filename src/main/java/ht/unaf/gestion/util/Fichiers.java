package ht.unaf.gestion.util;

import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

/** Enregistrement des pièces jointes dans le dossier ~/unaf-uploads. */
public final class Fichiers {
    private Fichiers() {}

    public static Path dossier() throws IOException {
        Path p = Path.of(System.getProperty("user.home"), "unaf-uploads");
        Files.createDirectories(p);
        return p;
    }

    /** Enregistre la pièce jointe et renvoie le nom du fichier créé (null si aucun fichier envoyé). */
    public static String enregistrer(Part part, String prefixe) throws IOException {
        if (part == null || part.getSize() == 0) return null;
        String original = Path.of(part.getSubmittedFileName()).getFileName().toString();
        int point = original.lastIndexOf('.');
        String ext = point >= 0 ? original.substring(point).toLowerCase() : "";
        String nom = prefixe + "-" + UUID.randomUUID().toString().substring(0, 8) + ext;
        try (InputStream in = part.getInputStream()) {
            Files.copy(in, dossier().resolve(nom), StandardCopyOption.REPLACE_EXISTING);
        }
        return nom;
    }
}
