<%@ include file="/WEB-INF/views/commun/header.jspf" %>
<div class="row justify-content-center mt-5">
    <div class="col-md-6 col-lg-5">
        <div class="card shadow-sm">
            <div class="card-body p-4">
                <h1 class="h4 mb-3">Créer un compte étudiant</h1>
                <c:if test="${not empty erreur}"><div class="alert alert-danger"><c:out value="${erreur}"/></div></c:if>
                <form method="post" action="${ctx}/inscription">
                    <div class="row g-3">
                        <div class="col-6"><label class="form-label">Prénom</label>
                            <input name="prenom" class="form-control" value="<c:out value='${param.prenom}'/>" required></div>
                        <div class="col-6"><label class="form-label">Nom</label>
                            <input name="nom" class="form-control" value="<c:out value='${param.nom}'/>" required></div>
                        <div class="col-12"><label class="form-label">Email</label>
                            <input type="email" name="email" class="form-control" value="<c:out value='${param.email}'/>" required></div>
                        <div class="col-12"><label class="form-label">Mot de passe</label>
                            <input type="password" name="motDePasse" class="form-control" minlength="4" required></div>
                    </div>
                    <button class="btn btn-primary w-100 mt-4">Créer mon compte</button>
                </form>
                <p class="text-center mt-3 mb-0"><a href="${ctx}/login">J'ai déjà un compte</a></p>
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/views/commun/footer.jspf" %>
