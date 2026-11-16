<%@ include file="/WEB-INF/views/commun/header.jspf" %>
<p class="text-muted mb-3">Session : <strong><c:out value="${empty session ? 'aucune session ouverte' : session.libelle}"/></strong></p>
<div class="row g-3">
    <c:forEach var="e" items="${cours}">
        <div class="col-md-6 col-xl-4">
            <div class="card h-100">
                <div class="card-body d-flex flex-column">
                    <div class="d-flex justify-content-between align-items-start mb-2"><span class="code-tag">${e.key.code}</span><span class="small text-muted">${e.key.credits} crédits</span></div>
                    <h2 class="h5 mb-1"><c:out value="${e.key.intitule}"/></h2>
                    <div class="cell-sub mb-3"><c:out value="${e.key.programme.nom}"/> · <c:out value="${e.key.programme.faculte.nom}"/></div>
                    <ul class="list-clean small mb-3">
                        <li><span class="text-muted"><i class="bi bi-clock me-1"></i>Horaire</span><span>${e.key.horaire}</span></li>
                        <li><span class="text-muted"><i class="bi bi-geo-alt me-1"></i>Salle</span><span><c:out value="${empty e.key.salle ? '—' : e.key.salle.nom}"/></span></li>
                        <li><span class="text-muted"><i class="bi bi-people me-1"></i>Inscrits</span><strong>${e.value}</strong></li>
                    </ul>
                    <a class="btn btn-primary mt-auto" href="${ctx}/professeur/notes?cours=${e.key.id}"><i class="bi bi-pencil-square"></i> Étudiants &amp; notes</a>
                </div>
            </div>
        </div>
    </c:forEach>
    <c:if test="${empty cours}"><div class="col-12"><div class="card"><div class="empty-state"><i class="bi bi-journal"></i>Aucun cours ne vous est encore affecté.</div></div></div></c:if>
</div>
<%@ include file="/WEB-INF/views/commun/footer.jspf" %>
