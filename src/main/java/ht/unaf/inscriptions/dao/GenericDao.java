package ht.unaf.inscriptions.dao;

import ht.unaf.inscriptions.util.JPAUtil;

import java.util.List;

/** DAO générique : opérations CRUD communes à toutes les entités. */
public class GenericDao<T> {
    protected final Class<T> type;

    public GenericDao(Class<T> type) { this.type = type; }

    public T trouver(Long id) {
        if (id == null) return null;
        return JPAUtil.lire(em -> em.find(type, id));
    }

    public List<T> tous() {
        return JPAUtil.lire(em -> em.createQuery("SELECT e FROM " + type.getSimpleName() + " e ORDER BY e.id", type)
                .getResultList());
    }

    /** Insère (id null) ou met à jour l'entité. */
    public T enregistrer(T entite) {
        return JPAUtil.ecrire(em -> em.merge(entite));
    }

    public void supprimer(Long id) {
        JPAUtil.executer(em -> {
            T e = em.find(type, id);
            if (e != null) em.remove(e);
        });
    }

    public long compter() {
        return JPAUtil.lire(em -> em.createQuery("SELECT COUNT(e) FROM " + type.getSimpleName() + " e", Long.class)
                .getSingleResult());
    }
}
