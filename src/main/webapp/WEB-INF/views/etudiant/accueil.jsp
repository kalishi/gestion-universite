<%@ include file="/WEB-INF/views/commun/header.jspf" %>
<h1 class="h3 mb-4">Bienvenue, <c:out value="${moi.prenom}"/></h1>
<div class="row g-3">
    <div class="col-md-4">
        <div class="card shadow-sm h-100"><div class="card-body">
            <h2 class="h6 text-muted">Dossier d'inscription</h2>
            <c:choose>
                <c:when test="${empty dossier}">
                    <p class="fs-5 text-warning">Non déposé</p>
                    <a class="btn btn-primary btn-sm" href="${ctx}/etudiant/dossier">Déposer mon dossier</a>
                </c:when>
                <c:otherwise>
                    <p class="fs-5 mb-1"><span class="badge ${dossier.statut == 'VALIDE' ? 'bg-success' : dossier.statut == 'REJETE' ? 'bg-danger' : 'bg-warning text-dark'}">${dossier.statut}</span></p>
                    <p class="small mb-0"><c:out value="${dossier.programme.nom}"/></p>
                    <c:if test="${dossier.statut == 'REJETE'}"><a class="btn btn-sm btn-outline-primary mt-2" href="${ctx}/etudiant/dossier">Corriger mon dossier</a></c:if>
                </c:otherwise>
            </c:choose>
        </div></div>
    </div>
    <div class="col-md-4">
        <div class="card shadow-sm h-100"><div class="card-body">
            <h2 class="h6 text-muted">Session en cours</h2>
            <p class="fs-5 mb-1"><c:out value="${empty session ? 'Aucune' : session.libelle}"/></p>
            <p class="small">${empty nbCours ? 0 : nbCours} cours choisi(s)</p>
            <a class="btn btn-sm btn-outline-primary" href="${ctx}/etudiant/cours">Choisir mes cours</a>
        </div></div>
    </div>
    <div class="col-md-4">
        <div class="card shadow-sm h-100"><div class="card-body">
            <h2 class="h6 text-muted">Frais de scolarité</h2>
            <c:choose>
                <c:when test="${empty dossier}"><p class="text-muted">—</p></c:when>
                <c:otherwise>
                    <p class="mb-1">Montant : <fmt:formatNumber value="${dossier.programme.fraisScolarite}" maxFractionDigits="2"/> HTG</p>
                    <p class="mb-1">Payé : <fmt:formatNumber value="${totalPaye}" maxFractionDigits="2"/> HTG</p>
                    <p class="fs-5 ${solde > 0 ? 'text-danger' : 'text-success'}">Solde : <fmt:formatNumber value="${solde}" maxFractionDigits="2"/> HTG</p>
                </c:otherwise>
            </c:choose>
        </div></div>
    </div>
</div>
<c:if test="${not empty paiements}">
<div class="card shadow-sm mt-4"><div class="card-body">
    <h2 class="h6">Historique des paiements</h2>
    <table class="table table-sm mb-0">
        <c:forEach var="p" items="${paiements}"><tr><td>${p.datePaiement}</td><td class="text-end"><fmt:formatNumber value="${p.montant}" maxFractionDigits="2"/> HTG</td></tr></c:forEach>
    </table>
</div></div>
</c:if>
<%@ include file="/WEB-INF/views/commun/footer.jspf" %>
