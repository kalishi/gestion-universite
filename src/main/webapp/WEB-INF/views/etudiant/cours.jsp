<%@ include file="/WEB-INF/views/commun/header.jspf" %>
<c:choose>
<c:when test="${empty dossier or dossier.statut != 'VALIDE'}">
    <div class="alert alert-warning"><i class="bi bi-lock-fill"></i><div>Votre admission doit être <strong>validée</strong> par l'administration avant de choisir vos cours. <a href="${ctx}/etudiant/dossier">Voir mon dossier</a></div></div>
</c:when>
<c:when test="${empty session}">
    <div class="alert alert-warning"><i class="bi bi-calendar-x"></i><div>Aucune session n'est ouverte aux inscriptions pour le moment.</div></div>
</c:when>
<c:otherwise>
<div class="row g-3">
    <div class="col-lg-8">
        <form method="post" class="card" data-loading>
            <div class="card-header"><h2>Cours disponibles — <c:out value="${dossier.programme.nom}"/></h2><span class="small text-muted"><c:out value="${session.libelle}"/></span></div>
            <div class="card-body d-grid gap-2">
                <c:forEach var="l" items="${lignes}">
                    <label class="course-option ${l.selectionnable ? '' : 'disabled'}" for="c${l.cours.id}">
                        <input class="form-check-input mt-1" type="checkbox" id="c${l.cours.id}" name="coursIds" value="${l.cours.id}" ${l.selectionnable ? '' : 'disabled'}>
                        <span class="course-body flex-grow-1">
                            <span class="d-flex flex-wrap justify-content-between gap-2">
                                <span><span class="code-tag me-1">${l.cours.code}</span><span class="cell-title"><c:out value="${l.cours.intitule}"/></span></span>
                                <span>
                                    <c:choose>
                                        <c:when test="${l.inscrit}"><span class="badge-soft badge-primary">Inscrit</span></c:when>
                                        <c:when test="${l.reussi}"><span class="badge-soft badge-success">Déjà réussi</span></c:when>
                                        <c:when test="${not empty l.prerequisManquants}"><span class="badge-soft badge-danger">Prérequis : ${l.prerequisManquants}</span></c:when>
                                        <c:otherwise><span class="badge-soft badge-muted">Disponible</span></c:otherwise>
                                    </c:choose>
                                </span>
                            </span>
                            <span class="cell-sub d-block mt-1"><i class="bi bi-clock"></i> ${l.cours.horaire} · <i class="bi bi-geo-alt"></i> <c:out value="${empty l.cours.salle ? '—' : l.cours.salle.nom}"/> · ${l.cours.credits} crédits<c:if test="${not empty l.cours.professeur}"> · <c:out value="${l.cours.professeur.nomComplet}"/></c:if></span>
                        </span>
                    </label>
                </c:forEach>
                <c:if test="${empty lignes}"><div class="empty-state"><i class="bi bi-journal"></i>Aucun cours dans votre programme.</div></c:if>
            </div>
            <div class="sticky-actions"><button type="submit" class="btn btn-primary"><i class="bi bi-check2-square"></i> M'inscrire aux cours cochés</button></div>
        </form>
    </div>
    <div class="col-lg-4">
        <div class="card">
            <div class="card-header"><h2>Ma sélection</h2></div>
            <div class="card-body">
                <div class="d-flex justify-content-between small mb-1"><span>Crédits</span><strong>${creditsActuels} / ${dossier.programme.maxCredits}</strong></div>
                <div class="progress mb-3" role="progressbar" aria-label="Crédits utilisés" aria-valuenow="${creditsActuels}" aria-valuemin="0" aria-valuemax="${dossier.programme.maxCredits}">
                    <div class="progress-bar ${creditsActuels > dossier.programme.maxCredits ? 'bg-danger' : ''}" style="width:${creditsActuels * 100 / dossier.programme.maxCredits}%"></div></div>
                <ul class="list-clean">
                    <c:forEach var="i" items="${mesCours}">
                        <li class="align-items-center">
                            <span><span class="code-tag me-1">${i.cours.code}</span><c:out value="${i.cours.intitule}"/> <span class="cell-sub">(${i.cours.credits} cr.)</span></span>
                            <form method="post" class="m-0" data-confirm="Retirer ce cours de votre sélection ?"><input type="hidden" name="action" value="retirer"><input type="hidden" name="inscriptionId" value="${i.id}">
                                <button class="btn btn-sm btn-ghost text-danger" aria-label="Retirer ${i.cours.code}"><i class="bi bi-x-lg"></i></button></form>
                        </li>
                    </c:forEach>
                    <c:if test="${empty mesCours}"><li class="text-muted">Aucun cours choisi.</li></c:if>
                </ul>
            </div>
        </div>
    </div>
</div>
</c:otherwise>
</c:choose>
<%@ include file="/WEB-INF/views/commun/footer.jspf" %>
