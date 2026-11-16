<%@ include file="/WEB-INF/views/commun/header.jspf" %>
<div class="row justify-content-center mt-5">
    <div class="col-md-5 col-lg-4">
        <div class="text-center mb-4">
            <i class="bi bi-mortarboard-fill text-primary display-4"></i>
            <h1 class="h4 mt-2">Université Anténor Firmin</h1>
            <p class="text-muted">Plateforme des inscriptions</p>
        </div>
        <div class="card shadow-sm">
            <div class="card-body p-4">
                <c:if test="${not empty erreur}"><div class="alert alert-danger"><c:out value="${erreur}"/></div></c:if>
                <form method="post" action="${ctx}/login">
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" class="form-control" value="<c:out value='${param.email}'/>" required autofocus>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Mot de passe</label>
                        <input type="password" name="motDePasse" class="form-control" required>
                    </div>
                    <button class="btn btn-primary w-100">Se connecter</button>
                </form>
                <hr>
                <p class="text-center mb-0">Nouvel étudiant ? <a href="${ctx}/inscription">Créer un compte</a></p>
            </div>
        </div>
        <div class="card mt-3 small text-muted">
            <div class="card-body py-2">
                <strong>Comptes de démo :</strong><br>
                admin@unaf.ht / admin123<br>
                prof@unaf.ht / prof123<br>
                etudiant@unaf.ht / etu123
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/views/commun/footer.jspf" %>
