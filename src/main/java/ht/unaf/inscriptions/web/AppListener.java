package ht.unaf.inscriptions.web;

import ht.unaf.inscriptions.service.DonneesDemo;
import ht.unaf.inscriptions.util.JPAUtil;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

/** Démarrage : création de l'EntityManagerFactory (tables) et des données de démo. */
@WebListener
public class AppListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        JPAUtil.getEmf();
        DonneesDemo.chargerSiVide();
        sce.getServletContext().log("Plateforme d'inscriptions démarrée.");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        JPAUtil.fermer();
    }
}
