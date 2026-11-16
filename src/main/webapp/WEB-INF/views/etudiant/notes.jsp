<%@ include file="/WEB-INF/views/commun/header.jspf" %>
<div class="row g-3 mb-3">
    <div class="col-md-4"><div class="card h-100"><div class="card-body kpi">
        <span class="kpi-icon tone-success"><i class="bi bi-award"></i></span>
        <div><div class="kpi-label">Moyenne pondérée</div><div class="kpi-value">${empty moyenne ? '—' : moyenne}<span class="fs-6 text-muted"> / 100</span></div></div>
    </div></div></div>
    <div class="col-md-8"><div class="card h-100"><div class="card-body d-flex flex-wrap align-items-center gap-3">
        <div class="me-auto small text-muted">Note finale = 30 % partiel + 40 % examen final + 30 % travaux. Note de passage : 60 / 100.</div>
        <a class="btn btn-primary" href="${ctx}/etudiant/releve.pdf"><i class="bi bi-file-earmark-pdf"></i> Télécharger le relevé (PDF)</a>
    </div></div></div>
</div>
<div class="card">
    <div class="table-responsive">
        <table class="table table-unaf table-hover">
            <thead><tr><th>Session</th><th>Cours</th><th class="num">Crédits</th><th class="num">Partiel</th><th class="num">Final</th><th class="num">Travaux</th><th class="num">Note finale</th><th>Résultat</th></tr></thead>
            <tbody>
            <c:forEach var="n" items="${notes}">
                <tr><td class="text-nowrap small"><c:out value="${n.session.libelle}"/></td>
                    <td><span class="code-tag me-1">${n.cours.code}</span><c:out value="${n.cours.intitule}"/></td><td class="num">${n.cours.credits}</td>
                    <td class="num">${empty n.notePartiel ? '—' : n.notePartiel}</td><td class="num">${empty n.noteExamenFinal ? '—' : n.noteExamenFinal}</td>
                    <td class="num">${empty n.noteTravaux ? '—' : n.noteTravaux}</td>
                    <td class="num fw-bold">${empty n.noteFinale ? '—' : n.noteFinale}</td>
                    <td><span class="badge-soft ${n.mention == 'Réussi' ? 'badge-success' : n.mention == 'Échoué' ? 'badge-danger' : 'badge-muted'}">${n.mention}</span></td></tr>
            </c:forEach>
            <c:if test="${empty notes}"><tr><td colspan="8"><div class="empty-state"><i class="bi bi-award"></i>Aucune note pour le moment.</div></td></tr></c:if>
            </tbody>
        </table>
    </div>
</div>
<%@ include file="/WEB-INF/views/commun/footer.jspf" %>
