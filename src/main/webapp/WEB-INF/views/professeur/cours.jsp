<%@ include file="/WEB-INF/views/commun/header.jspf" %>
<h1 class="h3 mb-1">Mes cours</h1>
<p class="text-muted">Session : <c:out value="${empty session ? 'aucune session active' : session.libelle}"/></p>
<div class="row g-3">
    <c:forEach var="e" items="${cours}">
        <div class="col-md-6 col-lg-4">
            <div class="card shadow-sm h-100"><div class="card-body">
                <div class="d-flex justify-content-between"><span class="badge bg-primary">${e.key.code}</span><span class="small text-muted">${e.key.credits} crédits</span></div>
                <h2 class="h5 mt-2"><c:out value="${e.key.intitule}"/></h2>
                <p class="small text-muted mb-2"><c:out value="${e.key.programme.nom}"/><br>${e.key.horaire} · <c:out value="${e.key.salle.nom}"/></p>
                <p class="mb-3"><i class="bi bi-people"></i> ${e.value} étudiant(s) inscrit(s)</p>
                <a class="btn btn-sm btn-primary" href="${ctx}/professeur/notes?cours=${e.key.id}">Étudiants &amp; notes</a>
            </div></div>
        </div>
    </c:forEach>
    <c:if test="${empty cours}"><p class="text-muted">Aucun cours ne vous est affecté.</p></c:if>
</div>
<%@ include file="/WEB-INF/views/commun/footer.jspf" %>
