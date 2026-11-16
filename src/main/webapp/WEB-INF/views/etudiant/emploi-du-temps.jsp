<%@ include file="/WEB-INF/views/commun/header.jspf" %>
<p class="text-muted mb-3">Session : <strong><c:out value="${empty session ? 'aucune' : session.libelle}"/></strong></p>
<div class="row g-3">
    <c:forEach var="j" items="${jours}">
        <div class="col-md-6 col-xl-2">
            <div class="card h-100">
                <div class="card-header justify-content-center"><h2>${j}</h2></div>
                <div class="card-body p-2 timetable-day">
                    <c:set var="vide" value="true"/>
                    <c:forEach var="i" items="${mesCours}">
                        <c:if test="${i.cours.jour == j}">
                            <c:set var="vide" value="false"/>
                            <div class="slot">
                                <div class="slot-time">${i.cours.heureDebut} – ${i.cours.heureFin}</div>
                                <div class="fw-semibold">${i.cours.code}</div>
                                <div><c:out value="${i.cours.intitule}"/></div>
                                <div class="cell-sub"><i class="bi bi-geo-alt"></i> <c:out value="${empty i.cours.salle ? '—' : i.cours.salle.nom}"/></div>
                                <div class="cell-sub"><i class="bi bi-person"></i> <c:out value="${empty i.cours.professeur ? '—' : i.cours.professeur.nomComplet}"/></div>
                            </div>
                        </c:if>
                    </c:forEach>
                    <c:if test="${vide}"><div class="text-center text-muted small pt-4">Libre</div></c:if>
                </div>
            </div>
        </div>
    </c:forEach>
</div>
<c:if test="${empty mesCours}"><div class="alert alert-info mt-3"><i class="bi bi-info-circle"></i><div>Aucun cours choisi pour cette session. <a href="${ctx}/etudiant/cours">Choisir mes cours</a></div></div></c:if>
<%@ include file="/WEB-INF/views/commun/footer.jspf" %>
