# Plateforme de gestion des inscriptions universitaires (Jakarta EE)

Projet Java EE – Université Anténor Firmin, Faculté des Sciences Informatiques.

Version simple et fonctionnelle : **Servlets + JSP/JSTL (MVC)**, **JPA/Hibernate**, **MySQL**, **Bootstrap 5**, construite avec **Maven** et déployée sur **Tomcat 10.1**.

## Fonctionnalités

| Rôle | Fonctions |
|---|---|
| **Administration** | Facultés, programmes (licence/master, frais, crédits max), cours (horaire, salle, prérequis), sessions, salles ; validation/rejet des dossiers ; paiements partiels et solde ; affectation des professeurs aux cours ; création des comptes professeurs |
| **Étudiant** | Création de compte ; dépôt du dossier avec pièces jointes (photo, diplôme, acte de naissance) ; choix des cours de la session active avec vérification des **prérequis** et du **maximum de crédits** ; emploi du temps ; notes ; **relevé de notes en PDF** |
| **Professeur** | Liste de ses cours et des étudiants inscrits ; saisie des notes (partiel, examen final, travaux) avec **calcul automatique** de la note finale (30 % / 40 % / 30 %, passage à 60) |

Filtre de servlet (`AuthFilter`) : authentification par session + contrôle du rôle selon l'URL (`/admin/*`, `/etudiant/*`, `/professeur/*`).

## Architecture

```
src/main/java/ht/unaf/inscriptions/
├── model/      Entités JPA (Utilisateur, Faculte, Programme, Cours, SessionAcademique, Salle,
│               DossierInscription, Paiement, InscriptionCours) + énumérations
├── dao/        Accès aux données (GenericDao + DAO spécifiques, requêtes JPQL paramétrées)
├── service/    Règles métier (AuthService, InscriptionService, NoteService, ReleveService PDF,
│               DonneesDemo)
├── web/        Contrôleurs (servlets), AuthFilter, AppListener
│   ├── admin/  etudiant/  professeur/
└── util/       JPAUtil (EntityManagerFactory), Fichiers (pièces jointes)
src/main/webapp/WEB-INF/views/   Vues JSP (Bootstrap) par rôle
src/main/resources/META-INF/persistence.xml   Configuration JPA / MySQL
```

## Prérequis

- JDK 17, Maven (intégré à Eclipse), Tomcat 10.1, MySQL (ou MariaDB de XAMPP/WAMP) démarré sur le port 3306.

## Configuration de la base

Dans `src/main/resources/META-INF/persistence.xml` : URL `jdbc:mysql://localhost:3306/inscriptions_univ`, utilisateur `root`, mot de passe vide (XAMPP/WAMP par défaut). Modifiez `jakarta.persistence.jdbc.user` / `password` si votre MySQL a un mot de passe.

La base **et** les tables sont créées automatiquement au premier démarrage (`hbm2ddl.auto=update`), ainsi que des données de démonstration.

## Lancer dans Eclipse (Enterprise Java)

1. Démarrer MySQL (panneau XAMPP/WAMP ou service MySQL).
2. **File → Import… → Maven → Existing Maven Projects** → choisir ce dossier → *Finish*. Eclipse télécharge les dépendances (connexion Internet requise la première fois).
3. Si besoin : clic droit sur le projet → **Maven → Update Project…**
4. Fenêtre **Servers** (Window → Show View → Servers) → *Create a new server* → **Apache → Tomcat v10.1 Server** → répertoire `C:\apache-tomcat-10.1.53` → JRE : JDK 17 → ajouter le projet `inscriptions-universitaires`.
5. Clic droit sur le projet → **Run As → Run on Server**.
6. Ouvrir http://localhost:8080/inscriptions/

## Déployer le .war (sans Eclipse)

```
mvn clean package
copy target\inscriptions.war C:\apache-tomcat-10.1.53\webapps\
C:\apache-tomcat-10.1.53\bin\startup.bat
```
Puis http://localhost:8080/inscriptions/

## Comptes de démonstration

| Rôle | Email | Mot de passe |
|---|---|---|
| Administrateur | admin@unaf.ht | admin123 |
| Professeur | prof@unaf.ht | prof123 |
| Étudiant (dossier validé) | etudiant@unaf.ht | etu123 |

L'étudiant de démo a déjà réussi INF101 et INF102 (session Automne 2025) : il peut prendre INF201 (prérequis INF101) mais pas INF301 (prérequis INF102 + INF201).

Les pièces jointes sont enregistrées dans `C:\Users\<vous>\inscriptions-uploads`.

## Hors périmètre (volontairement non inclus)

Hachage BCrypt des mots de passe, API REST JAX-RS, migration Spring Boot, envoi de courriels, Docker.
