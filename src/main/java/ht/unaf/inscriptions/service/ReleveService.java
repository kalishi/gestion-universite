package ht.unaf.inscriptions.service;

import com.lowagie.text.*;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import ht.unaf.inscriptions.model.DossierInscription;
import ht.unaf.inscriptions.model.InscriptionCours;
import ht.unaf.inscriptions.model.Utilisateur;

import java.awt.Color;
import java.io.OutputStream;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

/** Génère le relevé de notes en PDF (OpenPDF). */
public class ReleveService {

    public void genererPdf(Utilisateur etudiant, DossierInscription dossier, List<InscriptionCours> notes, OutputStream out) {
        Document doc = new Document(PageSize.A4, 40, 40, 40, 40);
        PdfWriter.getInstance(doc, out);
        doc.open();

        Font titre = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 16);
        Font gras = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10);
        Font normal = FontFactory.getFont(FontFactory.HELVETICA, 10);

        Paragraph entete = new Paragraph("UNIVERSITÉ ANTÉNOR FIRMIN", titre);
        entete.setAlignment(Element.ALIGN_CENTER);
        doc.add(entete);
        Paragraph sous = new Paragraph("Relevé de notes", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 13));
        sous.setAlignment(Element.ALIGN_CENTER);
        sous.setSpacingAfter(15);
        doc.add(sous);

        doc.add(new Paragraph("Étudiant : " + etudiant.getNomComplet(), normal));
        doc.add(new Paragraph("Email : " + etudiant.getEmail(), normal));
        if (dossier != null) {
            doc.add(new Paragraph("Programme : " + dossier.getProgramme().getNom()
                    + " (" + dossier.getProgramme().getNiveau() + ") — " + dossier.getProgramme().getFaculte().getNom(), normal));
        }
        doc.add(new Paragraph("Date : " + LocalDate.now().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")), normal));
        doc.add(Chunk.NEWLINE);

        PdfPTable table = new PdfPTable(new float[]{1.3f, 1.2f, 3.5f, 0.8f, 1f, 1f, 1f, 1.1f, 1.2f});
        table.setWidthPercentage(100);
        for (String h : new String[]{"Session", "Code", "Cours", "Créd.", "Partiel", "Final", "Travaux", "Note", "Résultat"}) {
            PdfPCell c = new PdfPCell(new Phrase(h, gras));
            c.setBackgroundColor(new Color(220, 230, 241));
            table.addCell(c);
        }
        double totalPoints = 0; int totalCredits = 0;
        for (InscriptionCours i : notes) {
            table.addCell(new Phrase(i.getSession().getLibelle(), normal));
            table.addCell(new Phrase(i.getCours().getCode(), normal));
            table.addCell(new Phrase(i.getCours().getIntitule(), normal));
            table.addCell(new Phrase(String.valueOf(i.getCours().getCredits()), normal));
            table.addCell(new Phrase(fmt(i.getNotePartiel()), normal));
            table.addCell(new Phrase(fmt(i.getNoteExamenFinal()), normal));
            table.addCell(new Phrase(fmt(i.getNoteTravaux()), normal));
            table.addCell(new Phrase(fmt(i.getNoteFinale()), gras));
            table.addCell(new Phrase(i.getMention(), normal));
            if (i.getNoteFinale() != null) {
                totalPoints += i.getNoteFinale() * i.getCours().getCredits();
                totalCredits += i.getCours().getCredits();
            }
        }
        doc.add(table);
        doc.add(Chunk.NEWLINE);
        String moyenne = totalCredits == 0 ? "-" : String.format("%.2f / 100", totalPoints / totalCredits);
        doc.add(new Paragraph("Moyenne générale pondérée : " + moyenne, gras));
        doc.add(new Paragraph("Note finale = 30% partiel + 40% examen final + 30% travaux. Note de passage : 60.", normal));
        doc.close();
    }

    private static String fmt(Double d) { return d == null ? "-" : String.format("%.2f", d); }
}
