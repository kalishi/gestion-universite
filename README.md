# UNAF — Système de gestion universitaire (Jakarta EE)

Application web de gestion de **toute l'Université Anténor Firmin** : facultés, programmes (licence, master, doctorat), admissions, cours, emplois du temps, notes et frais de scolarité.

**Technologies :** Java 17 · Servlets + JSP/JSTL (MVC) · JPA/Hibernate · MySQL · Bootstrap 5 · Chart.js · Maven · Tomcat 10.1.
**Fonctionne sans Internet :** Bootstrap, les icônes, les polices (Lexend, Source Sans 3) et Chart.js sont dans `src/main/webapp/assets/vendor`.

## Fonctionnalités

| Espace | Fonctions |
|---|---|
| **Administration** | Tableau de bord (effectifs, admissions, frais encaissés, graphiques par faculté) ; facultés, programmes, cours (horaire, salle, prérequis, professeur), sessions, salles ; admissions (validation/rejet, filtres par statut) ; annuaire des étudiants par faculté ; paiements partiels et solde ; comptes professeurs |
| **Étudiant** | Création de compte ; dossier d'admission avec pièces jointes ; choix des cours (prérequis + crédits max) ; emploi du temps ; notes et relevé PDF ; suivi des paiements |
| **Professeur** | Ses cours et ses étudiants ; saisie des notes avec calcul automatique (30 % partiel, 40 % final, 30 % travaux) |

## Interface

Design system généré avec le skill **ui-ux-pro-max** (style « Data-Dense Dashboard ») : bleu académique `#1E40AF`, accent ambre `#D97706`, titres en Lexend et texte en Source Sans 3. Barre latérale par rôle, tableaux avec recherche instantanée, formulaires avec libellés visibles, responsive (mobile → grand écran).

Fichiers : `assets/css/unaf.css` (thème), `assets/js/unaf.js` (interactions), `WEB-INF/views/commun/header.jspf` (mise en page).

## Architecture

```
src/main/java/ht/unaf/gestion/
├── model/     Entités JPA
├── dao/       Accès aux données (GenericDao, StatsDao pour les tableaux de bord…)
├── service/   Règles métier (inscription aux cours, notes, relevé PDF, données de démo)
├── web/       Servlets (admin/, etudiant/, professeur/), filtre des rôles, listener
└── util/      JPAUtil, Fichiers, Json
src/main/webapp/WEB-INF/views/   Vues JSP
```

## Lancer l'application (n'importe quel Eclipse, même portable)

1. Démarrer MySQL (XAMPP/WAMP). La base `unaf_db` et ses tables sont créées automatiquement au premier lancement, avec les données de démonstration.
2. Eclipse : **File → Import… → Maven → Existing Maven Projects** (ou **General → Existing Projects into Workspace**) → dossier du projet.
3. Clic droit sur le projet → **Run As → Maven build…** → *Goals* : `clean package` → **Run**. Le fichier `target\unaf.war` est créé.
4. Double-cliquer sur **`demarrer.bat`** : il déploie sur Tomcat et ouvre http://localhost:8080/unaf/
5. Pour arrêter : **`arreter.bat`**. Après une modification : refaire les étapes 3 et 4.

Avec Eclipse Enterprise Java, on peut aussi ajouter un serveur Tomcat v10.1 (vue *Servers*) puis **Run As → Run on Server**.

MySQL : utilisateur `root`, mot de passe vide par défaut (XAMPP/WAMP). À changer dans `src/main/resources/META-INF/persistence.xml` si besoin.

## Comptes de démonstration

| Rôle | Email | Mot de passe |
|---|---|---|
| Administration | admin@unaf.ht | admin123 |
| Professeur | prof@unaf.ht | prof123 |
| Étudiant | etudiant@unaf.ht | etu123 |

Les données de démo couvrent 7 facultés, 11 programmes, 24 cours, 7 professeurs et 17 étudiants (admissions validées, en attente et rejetées, paiements partiels). Les autres comptes étudiants (`prenom.nom@etu.unaf.ht`) utilisent aussi `etu123`.

Pièces jointes enregistrées dans `C:\Users\<vous>\unaf-uploads`.

## Sécurité des mots de passe

Les mots de passe sont **hachés avec BCrypt** (coût 10, sel aléatoire) avant d'être enregistrés : la base ne contient que des empreintes du type `$2a$10$…` (60 caractères), jamais le mot de passe en clair. Implémentation : `util/MotDePasse.java`, qui s'appuie sur jBCrypt (`org/mindrot/BCrypt.java`, licence ISC, inclus dans le projet — aucune dépendance à télécharger).

- Inscription, création de compte professeur et données de démo : le mot de passe est haché.
- Connexion : `BCrypt.checkpw` compare le mot de passe saisi à l'empreinte.
- Migration : un ancien compte encore en clair est accepté une fois, puis son mot de passe est haché automatiquement à cette connexion.
- Longueur minimale : 6 caractères.

## Hors périmètre (volontairement non inclus)

API REST JAX-RS, migration Spring Boot, envoi de courriels, Docker.
