package ht.unaf.gestion.web;

import ht.unaf.gestion.service.DonneesDemo;
import ht.unaf.gestion.util.JPAUtil;
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
        sce.getServletContext().log("UNAF démarré.");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        JPAUtil.fermer();
    }
}
