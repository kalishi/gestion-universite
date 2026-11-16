<%@ include file="/WEB-INF/views/commun/header.jspf" %>
<h1 class="h3 mb-1">Emploi du temps</h1>
<p class="text-muted">Session : <c:out value="${empty session ? 'aucune' : session.libelle}"/></p>
<div class="row g-3">
    <c:forEach var="j" items="${jours}">
        <div class="col-md-4 col-lg-2">
            <div class="card shadow-sm h-100">
                <div class="card-header bg-primary text-white text-center fw-semibold">${j}</div>
                <div class="card-body p-2 edt-case">
                    <c:forEach var="i" items="${mesCours}">
                        <c:if test="${i.cours.jour == j}">
                            <div class="border-start border-4 border-primary bg-white rounded p-2 mb-2 small shadow-sm">
                                <div class="fw-semibold">${i.cours.heureDebut} – ${i.cours.heureFin}</div>
                                <div>${i.cours.code} · <c:out value="${i.cours.intitule}"/></div>
                                <div class="text-muted"><i class="bi bi-geo-alt"></i> <c:out value="${i.cours.salle.nom}"/></div>
                                <div class="text-muted"><i class="bi bi-person"></i> <c:out value="${i.cours.professeur.nomComplet}"/></div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </div>
    </c:forEach>
</div>
<c:if test="${empty mesCours}"><p class="text-muted mt-3">Aucun cours choisi pour cette session.</p></c:if>
<%@ include file="/WEB-INF/views/commun/footer.jspf" %>
