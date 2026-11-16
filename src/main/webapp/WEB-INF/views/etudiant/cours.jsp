<%@ include file="/WEB-INF/views/commun/header.jspf" %>
<h1 class="h3 mb-1">Choix des cours</h1>
<p class="text-muted">Session : <strong><c:out value="${empty session ? 'aucune session ouverte' : session.libelle}"/></strong></p>
<c:choose>
<c:when test="${empty dossier or dossier.statut != 'VALIDE'}">
    <div class="alert alert-warning">Votre dossier d'inscription doit être <strong>validé</strong> par l'administration avant de choisir vos cours.
        <a href="${ctx}/etudiant/dossier">Voir mon dossier</a></div>
</c:when>
<c:when test="${empty session}">
    <div class="alert alert-warning">Aucune session n'est ouverte pour le moment.</div>
</c:when>
<c:otherwise>
    <div class="row g-4">
        <div class="col-lg-7">
            <div class="card shadow-sm"><div class="card-body">
                <h2 class="h6">Cours du programme <c:out value="${dossier.programme.nom}"/></h2>
                <form method="post">
                    <table class="table table-sm align-middle">
                        <thead><tr><th></th><th>Code</th><th>Cours</th><th>Créd.</th><th>Horaire</th><th>État</th></tr></thead>
                        <tbody>
                        <c:forEach var="l" items="${lignes}">
                            <tr class="${l.selectionnable ? '' : 'text-muted'}">
                                <td><input class="form-check-input" type="checkbox" name="coursIds" value="${l.cours.id}" ${l.selectionnable ? '' : 'disabled'}></td>
                                <td class="fw-semibold">${l.cours.code}</td><td><c:out value="${l.cours.intitule}"/></td>
                                <td>${l.cours.credits}</td><td class="small">${l.cours.horaire}</td>
                                <td class="small">
                                    <c:choose>
                                        <c:when test="${l.inscrit}"><span class="badge bg-primary">Inscrit</span></c:when>
                                        <c:when test="${l.reussi}"><span class="badge bg-success">Réussi</span></c:when>
                                        <c:when test="${not empty l.prerequisManquants}"><span class="badge bg-danger">Prérequis : ${l.prerequisManquants}</span></c:when>
                                        <c:otherwise><span class="badge bg-light text-dark">Disponible</span></c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <button class="btn btn-primary">S'inscrire aux cours cochés</button>
                </form>
            </div></div>
        </div>
        <div class="col-lg-5">
            <div class="card shadow-sm"><div class="card-body">
                <h2 class="h6">Mes cours cette session</h2>
                <p class="small">Crédits : <strong>${creditsActuels}</strong> / ${dossier.programme.maxCredits} maximum</p>
                <div class="progress mb-3" style="height:8px"><div class="progress-bar" style="width:${creditsActuels * 100 / dossier.programme.maxCredits}%"></div></div>
                <ul class="list-group">
                    <c:forEach var="i" items="${mesCours}">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <span><strong>${i.cours.code}</strong> <c:out value="${i.cours.intitule}"/> <small class="text-muted">(${i.cours.credits} cr.)</small></span>
                            <form method="post" class="m-0"><input type="hidden" name="action" value="retirer"><input type="hidden" name="inscriptionId" value="${i.id}">
                                <button class="btn btn-sm btn-outline-danger" title="Retirer"><i class="bi bi-x"></i></button></form>
                        </li>
                    </c:forEach>
                    <c:if test="${empty mesCours}"><li class="list-group-item text-muted">Aucun cours choisi.</li></c:if>
                </ul>
            </div></div>
        </div>
    </div>
</c:otherwise>
</c:choose>
<%@ include file="/WEB-INF/views/commun/footer.jspf" %>
