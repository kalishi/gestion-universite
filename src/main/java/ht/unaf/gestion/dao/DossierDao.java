package ht.unaf.gestion.dao;

import ht.unaf.gestion.model.DossierInscription;
import ht.unaf.gestion.model.Paiement;
import ht.unaf.gestion.util.JPAUtil;

import java.util.List;

public class DossierDao extends GenericDao<DossierInscription> {
    public DossierDao() { super(DossierInscription.class); }

    public DossierInscription parEtudiant(Long etudiantId) {
        return JPAUtil.lire(em -> em.createQuery("SELECT d FROM DossierInscription d WHERE d.etudiant.id = :e", DossierInscription.class)
                .setParameter("e", etudiantId).getResultStream().findFirst().orElse(null));
    }

    public List<DossierInscription> tousRecents() {
        return JPAUtil.lire(em -> em.createQuery("SELECT d FROM DossierInscription d ORDER BY d.statut, d.dateDepot DESC", DossierInscription.class)
                .getResultList());
    }

    public long compterEnAttente() {
        return JPAUtil.lire(em -> em.createQuery("SELECT COUNT(d) FROM DossierInscription d WHERE d.statut = :s", Long.class)
                .setParameter("s", ht.unaf.gestion.model.StatutDossier.EN_ATTENTE).getSingleResult());
    }

    public List<Paiement> paiements(Long dossierId) {
        return JPAUtil.lire(em -> em.createQuery("SELECT p FROM Paiement p WHERE p.dossier.id = :d ORDER BY p.datePaiement, p.id", Paiement.class)
                .setParameter("d", dossierId).getResultList());
    }

    public double totalPaye(Long dossierId) {
        Double t = JPAUtil.lire(em -> em.createQuery("SELECT SUM(p.montant) FROM Paiement p WHERE p.dossier.id = :d", Double.class)
                .setParameter("d", dossierId).getSingleResult());
        return t == null ? 0 : t;
    }
}
