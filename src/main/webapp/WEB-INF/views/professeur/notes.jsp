<%@ include file="/WEB-INF/views/commun/header.jspf" %>
<a href="${ctx}/professeur/cours" class="btn btn-link px-0"><i class="bi bi-arrow-left"></i> Mes cours</a>
<h1 class="h3 mb-1">${cours.code} — <c:out value="${cours.intitule}"/></h1>
<p class="text-muted">Session : <c:out value="${empty session ? 'aucune' : session.libelle}"/> · Note finale = 30 % partiel + 40 % examen final + 30 % travaux (sur 100)</p>
<form method="post">
    <input type="hidden" name="cours" value="${cours.id}">
    <div class="card shadow-sm"><div class="card-body p-0 table-responsive">
        <table class="table table-hover mb-0">
            <thead class="table-light"><tr><th>Étudiant</th><th>Email</th><th>Partiel</th><th>Examen final</th><th>Travaux</th><th>Note finale</th><th>Résultat</th></tr></thead>
            <tbody>
            <c:forEach var="i" items="${inscriptions}">
                <tr><td><input type="hidden" name="inscriptionId" value="${i.id}"><c:out value="${i.etudiant.nomComplet}"/></td>
                    <td class="small"><c:out value="${i.etudiant.email}"/></td>
                    <td><input type="number" step="0.01" min="0" max="100" class="form-control form-control-sm note" name="partiel_${i.id}" value="${i.notePartiel}"></td>
                    <td><input type="number" step="0.01" min="0" max="100" class="form-control form-control-sm note" name="final_${i.id}" value="${i.noteExamenFinal}"></td>
                    <td><input type="number" step="0.01" min="0" max="100" class="form-control form-control-sm note" name="travaux_${i.id}" value="${i.noteTravaux}"></td>
                    <td class="fw-semibold">${empty i.noteFinale ? '-' : i.noteFinale}</td>
                    <td><span class="badge ${i.mention == 'Réussi' ? 'bg-success' : i.mention == 'Échoué' ? 'bg-danger' : 'bg-secondary'}">${i.mention}</span></td></tr>
            </c:forEach>
            <c:if test="${empty inscriptions}"><tr><td colspan="7" class="text-center text-muted py-4">Aucun étudiant inscrit à ce cours pour cette session.</td></tr></c:if>
            </tbody>
        </table>
    </div></div>
    <c:if test="${not empty inscriptions}"><button class="btn btn-primary mt-3">Enregistrer les notes</button></c:if>
</form>
<%@ include file="/WEB-INF/views/commun/footer.jspf" %>
