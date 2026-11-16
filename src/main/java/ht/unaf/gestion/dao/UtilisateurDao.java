package ht.unaf.gestion.dao;

import ht.unaf.gestion.model.Role;
import ht.unaf.gestion.model.Utilisateur;
import ht.unaf.gestion.util.JPAUtil;

import java.util.List;

public class UtilisateurDao extends GenericDao<Utilisateur> {
    public UtilisateurDao() { super(Utilisateur.class); }

    public Utilisateur parEmail(String email) {
        return JPAUtil.lire(em -> em.createQuery("SELECT u FROM Utilisateur u WHERE u.email = :e", Utilisateur.class)
                .setParameter("e", email)
                .getResultStream().findFirst().orElse(null));
    }

    public List<Utilisateur> parRole(Role role) {
        return JPAUtil.lire(em -> em.createQuery("SELECT u FROM Utilisateur u WHERE u.role = :r ORDER BY u.nom", Utilisateur.class)
                .setParameter("r", role).getResultList());
    }
}
