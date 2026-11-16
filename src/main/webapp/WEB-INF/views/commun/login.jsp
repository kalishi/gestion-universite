<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="titre" value="Connexion"/>
<%@ include file="/WEB-INF/views/commun/header.jspf" %>
<div class="auth-wrap">
    <section class="auth-aside">
        <div class="d-flex align-items-center gap-3">
            <span class="app-brand-logo"><i class="bi bi-mortarboard-fill" aria-hidden="true"></i></span>
            <span><span class="app-brand-name d-block text-white">UNAF</span><span class="app-brand-sub">Université Anténor Firmin</span></span>
        </div>
        <div>
            <h1 class="mb-3">Le système de gestion de toute l'université</h1>
            <p class="mb-4 opacity-75">Admissions, facultés, programmes, cours, notes et frais de scolarité réunis dans une seule plateforme.</p>
            <div class="feature"><i class="bi bi-bank" aria-hidden="true"></i><div><strong class="text-white">Toutes les facultés</strong><br><span class="opacity-75">Une gestion centralisée de l'offre de formation.</span></div></div>
            <div class="feature"><i class="bi bi-folder-check" aria-hidden="true"></i><div><strong class="text-white">Admissions en ligne</strong><br><span class="opacity-75">Dépôt des dossiers et validation par l'administration.</span></div></div>
            <div class="feature"><i class="bi bi-award" aria-hidden="true"></i><div><strong class="text-white">Notes et relevés</strong><br><span class="opacity-75">Saisie par les professeurs, relevé PDF pour les étudiants.</span></div></div>
        </div>
        <div class="small opacity-75">© Université Anténor Firmin, Haïti</div>
    </section>
    <section class="auth-main">
        <div class="auth-card">
            <div class="d-lg-none text-center mb-4">
                <span class="app-brand-logo mx-auto mb-2"><i class="bi bi-mortarboard-fill"></i></span>
                <div class="h4 mb-0">UNAF</div>
            </div>
            <h2 class="h3 mb-1">Connexion</h2>
            <p class="text-muted mb-4">Accédez à votre espace administration, professeur ou étudiant.</p>
            <c:if test="${not empty erreur}"><div class="alert alert-danger" role="alert"><i class="bi bi-exclamation-octagon-fill"></i><div><c:out value="${erreur}"/></div></div></c:if>
            <form method="post" action="${ctx}/login" data-loading novalidate>
                <div class="mb-3">
                    <label class="form-label" for="email">Adresse email</label>
                    <input type="email" id="email" name="email" class="form-control" autocomplete="username" value="<c:out value='${param.email}'/>" required autofocus>
                </div>
                <div class="mb-4">
                    <label class="form-label" for="motDePasse">Mot de passe</label>
                    <input type="password" id="motDePasse" name="motDePasse" class="form-control" autocomplete="current-password" required>
                </div>
                <button type="submit" class="btn btn-primary w-100 btn-lg">Se connecter</button>
            </form>
            <p class="text-center mt-4 mb-0">Futur étudiant ? <a href="${ctx}/inscription" class="fw-semibold">Créer un compte</a></p>
            <div class="card mt-4 bg-light border-0">
                <div class="card-body small">
                    <div class="fw-semibold mb-1"><i class="bi bi-info-circle me-1"></i>Comptes de démonstration</div>
                    <div class="d-flex justify-content-between"><span>Administration</span><code>admin@unaf.ht / admin123</code></div>
                    <div class="d-flex justify-content-between"><span>Professeur</span><code>prof@unaf.ht / prof123</code></div>
                    <div class="d-flex justify-content-between"><span>Étudiant</span><code>etudiant@unaf.ht / etu123</code></div>
                </div>
            </div>
        </div>
    </section>
</div>
<%@ include file="/WEB-INF/views/commun/footer.jspf" %>
