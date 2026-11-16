<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="titre" value="Créer un compte"/>
<%@ include file="/WEB-INF/views/commun/header.jspf" %>
<div class="auth-wrap">
    <section class="auth-aside">
        <div class="d-flex align-items-center gap-3">
            <span class="app-brand-logo"><i class="bi bi-mortarboard-fill" aria-hidden="true"></i></span>
            <span><span class="app-brand-name d-block text-white">UNAF</span><span class="app-brand-sub">Université Anténor Firmin</span></span>
        </div>
        <div>
            <h1 class="mb-4">Votre admission en 3 étapes</h1>
            <div class="feature"><i class="bi bi-1-circle-fill"></i><div><strong class="text-white">Créez votre compte</strong><br><span class="opacity-75">Quelques informations suffisent.</span></div></div>
            <div class="feature"><i class="bi bi-2-circle-fill"></i><div><strong class="text-white">Déposez votre dossier</strong><br><span class="opacity-75">Choisissez votre faculté et votre programme, joignez vos pièces.</span></div></div>
            <div class="feature"><i class="bi bi-3-circle-fill"></i><div><strong class="text-white">Choisissez vos cours</strong><br><span class="opacity-75">Dès la validation de votre dossier.</span></div></div>
        </div>
        <div class="small opacity-75">© Université Anténor Firmin, Haïti</div>
    </section>
    <section class="auth-main">
        <div class="auth-card">
            <h2 class="h3 mb-1">Créer un compte étudiant</h2>
            <p class="text-muted mb-4">Ce compte vous servira pendant toute votre scolarité.</p>
            <c:if test="${not empty erreur}"><div class="alert alert-danger" role="alert"><i class="bi bi-exclamation-octagon-fill"></i><div><c:out value="${erreur}"/></div></div></c:if>
            <form method="post" action="${ctx}/inscription" data-loading>
                <div class="row g-3">
                    <div class="col-sm-6"><label class="form-label" for="prenom">Prénom<span class="req">*</span></label>
                        <input id="prenom" name="prenom" class="form-control" autocomplete="given-name" value="<c:out value='${param.prenom}'/>" required></div>
                    <div class="col-sm-6"><label class="form-label" for="nom">Nom<span class="req">*</span></label>
                        <input id="nom" name="nom" class="form-control" autocomplete="family-name" value="<c:out value='${param.nom}'/>" required></div>
                    <div class="col-12"><label class="form-label" for="email">Adresse email<span class="req">*</span></label>
                        <input type="email" id="email" name="email" class="form-control" autocomplete="email" value="<c:out value='${param.email}'/>" required></div>
                    <div class="col-12"><label class="form-label" for="motDePasse">Mot de passe<span class="req">*</span></label>
                        <input type="password" id="motDePasse" name="motDePasse" class="form-control" minlength="6" autocomplete="new-password" required aria-describedby="mdpAide">
                        <div id="mdpAide" class="form-text">6 caractères minimum. Il est enregistré chiffré (BCrypt).</div></div>
                </div>
                <button type="submit" class="btn btn-primary w-100 btn-lg mt-4">Créer mon compte</button>
            </form>
            <p class="text-center mt-4 mb-0">Déjà inscrit ? <a href="${ctx}/login" class="fw-semibold">Se connecter</a></p>
        </div>
    </section>
</div>
<%@ include file="/WEB-INF/views/commun/footer.jspf" %>
