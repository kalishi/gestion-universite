<%@ include file="/WEB-INF/views/commun/header.jspf" %>
<div class="d-flex justify-content-between align-items-center mb-4">
    <h1 class="h3 mb-0">Mes notes</h1>
    <a class="btn btn-outline-primary" href="${ctx}/etudiant/releve.pdf"><i class="bi bi-file-earmark-pdf"></i> Télécharger le relevé (PDF)</a>
</div>
<div class="card shadow-sm"><div class="card-body p-0 table-responsive">
    <table class="table table-hover mb-0">
        <thead class="table-light"><tr><th>Session</th><th>Code</th><th>Cours</th><th>Créd.</th><th>Partiel</th><th>Final</th><th>Travaux</th><th>Note finale</th><th>Résultat</th></tr></thead>
        <tbody>
        <c:forEach var="n" items="${notes}">
            <tr><td class="small"><c:out value="${n.session.libelle}"/></td><td>${n.cours.code}</td><td><c:out value="${n.cours.intitule}"/></td><td>${n.cours.credits}</td>
                <td>${empty n.notePartiel ? '-' : n.notePartiel}</td><td>${empty n.noteExamenFinal ? '-' : n.noteExamenFinal}</td>
                <td>${empty n.noteTravaux ? '-' : n.noteTravaux}</td>
                <td class="fw-semibold">${empty n.noteFinale ? '-' : n.noteFinale}</td>
                <td><span class="badge ${n.mention == 'Réussi' ? 'bg-success' : n.mention == 'Échoué' ? 'bg-danger' : 'bg-secondary'}">${n.mention}</span></td></tr>
        </c:forEach>
        <c:if test="${empty notes}"><tr><td colspan="9" class="text-center text-muted py-4">Aucune note pour le moment.</td></tr></c:if>
        </tbody>
    </table>
</div></div>
<p class="mt-3"><strong>Moyenne générale pondérée :</strong> ${empty moyenne ? '-' : moyenne} / 100
    <span class="text-muted small ms-2">(Note finale = 30 % partiel + 40 % examen final + 30 % travaux ; passage à 60)</span></p>
<%@ include file="/WEB-INF/views/commun/footer.jspf" %>
