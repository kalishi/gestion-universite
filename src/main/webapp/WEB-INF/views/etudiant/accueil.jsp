<%@ include file="/WEB-INF/views/commun/header.jspf" %>
<c:if test="${empty dossier}">
    <div class="card mb-3 border-0" style="background:var(--color-primary);color:#fff">
        <div class="card-body d-flex flex-wrap align-items-center gap-3 p-4">
            <i class="bi bi-folder-plus fs-1" aria-hidden="true"></i>
            <div class="me-auto"><div class="h5 text-white mb-1">Commencez votre admission</div><div class="opacity-75">Déposez votre dossier : faculté, programme et pièces justificatives.</div></div>
            <a class="btn btn-accent" href="${ctx}/etudiant/dossier">Déposer mon dossier <i class="bi bi-arrow-right"></i></a>
        </div>
    </div>
</c:if>
<div class="row g-3 mb-3">
    <div class="col-sm-6 col-xl-3"><div class="card h-100"><div class="card-body kpi">
        <span class="kpi-icon tone-primary"><i class="bi bi-folder-check"></i></span>
        <div><div class="kpi-label">Admission</div>
            <div class="mt-1"><c:choose><c:when test="${empty dossier}"><span class="badge-soft badge-muted">Non déposée</span></c:when><c:otherwise><c:set var="d" value="${dossier}"/><%@ include file="/WEB-INF/views/commun/badge-statut.jspf" %></c:otherwise></c:choose></div>
            <div class="kpi-sub mt-1"><c:out value="${dossier.programme.nom}"/></div></div>
    </div></div></div>
    <div class="col-sm-6 col-xl-3"><div class="card h-100"><div class="card-body kpi">
        <span class="kpi-icon tone-info"><i class="bi bi-journal-check"></i></span>
        <div><div class="kpi-label">Cours de la session</div><div class="kpi-value">${empty nbCours ? 0 : nbCours}</div><div class="kpi-sub">${empty creditsSession ? 0 : creditsSession} crédits<c:if test="${not empty dossier}"> / ${dossier.programme.maxCredits} max</c:if></div></div>
    </div></div></div>
    <div class="col-sm-6 col-xl-3"><div class="card h-100"><div class="card-body kpi">
        <span class="kpi-icon tone-success"><i class="bi bi-award"></i></span>
        <div><div class="kpi-label">Moyenne générale</div><div class="kpi-value">${empty moyenne ? '—' : moyenne}</div><div class="kpi-sub">${creditsValides} crédits validés</div></div>
    </div></div></div>
    <div class="col-sm-6 col-xl-3"><div class="card h-100"><div class="card-body kpi">
        <span class="kpi-icon ${solde > 0 ? 'tone-danger' : 'tone-success'}"><i class="bi bi-wallet2"></i></span>
        <div><div class="kpi-label">Solde à payer</div><div class="kpi-value"><c:choose><c:when test="${empty dossier}">—</c:when><c:otherwise><fmt:formatNumber value="${solde}" maxFractionDigits="0"/></c:otherwise></c:choose></div><div class="kpi-sub">HTG</div></div>
    </div></div></div>
</div>
<div class="row g-3">
    <div class="col-lg-7">
        <div class="card h-100">
            <div class="card-header"><h2>Mes cours — <c:out value="${empty session ? 'aucune session ouverte' : session.libelle}"/></h2><a class="btn btn-sm btn-outline-primary" href="${ctx}/etudiant/cours">Gérer</a></div>
            <div class="table-responsive">
                <table class="table table-unaf">
                    <thead><tr><th>Cours</th><th>Horaire</th><th>Professeur</th></tr></thead>
                    <tbody>
                    <c:forEach var="i" items="${coursSession}">
                        <tr><td><span class="code-tag">${i.cours.code}</span> <span class="cell-title"><c:out value="${i.cours.intitule}"/></span></td>
                            <td class="text-nowrap small">${i.cours.horaire}</td><td class="small"><c:out value="${i.cours.professeur.nomComplet}"/></td></tr>
                    </c:forEach>
                    <c:if test="${empty coursSession}"><tr><td colspan="3"><div class="empty-state"><i class="bi bi-journal"></i>Aucun cours choisi pour cette session.</div></td></tr></c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="col-lg-5">
        <div class="card mb-3">
            <div class="card-header"><h2>Derniers résultats</h2><a class="small" href="${ctx}/etudiant/notes">Tout voir</a></div>
            <div class="card-body py-1">
                <ul class="list-clean">
                    <c:forEach var="n" items="${dernieresNotes}" end="4">
                        <li><span><span class="code-tag me-1">${n.cours.code}</span><c:out value="${n.cours.intitule}"/></span>
                            <strong class="${n.noteFinale >= 60 ? 'text-success' : 'text-danger'}">${n.noteFinale}</strong></li>
                    </c:forEach>
                    <c:if test="${empty dernieresNotes}"><li class="text-muted">Pas encore de note.</li></c:if>
                </ul>
            </div>
        </div>
        <div class="card">
            <div class="card-header"><h2>Paiements</h2></div>
            <div class="card-body py-1">
                <ul class="list-clean">
                    <c:forEach var="p" items="${paiements}"><li><span class="text-muted">${p.datePaiement}</span><strong><fmt:formatNumber value="${p.montant}" maxFractionDigits="0"/> HTG</strong></li></c:forEach>
                    <c:if test="${empty paiements}"><li class="text-muted">Aucun paiement enregistré.</li></c:if>
                </ul>
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/views/commun/footer.jspf" %>
