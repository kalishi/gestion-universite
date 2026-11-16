<%@ include file="/WEB-INF/views/commun/header.jspf" %>
<nav aria-label="Fil d'Ariane" class="mb-3"><ol class="breadcrumb small"><li class="breadcrumb-item"><a href="${ctx}/professeur/cours">Mes cours</a></li><li class="breadcrumb-item active" aria-current="page">${cours.code}</li></ol></nav>
<div class="card mb-3"><div class="card-body d-flex flex-wrap align-items-center gap-3">
    <span class="code-tag fs-6">${cours.code}</span>
    <div class="me-auto"><div class="h5 mb-0"><c:out value="${cours.intitule}"/></div><div class="cell-sub"><c:out value="${empty session ? 'Aucune session ouverte' : session.libelle}"/> · ${empty inscriptions ? 0 : inscriptions.size()} étudiant(s)</div></div>
    <div class="small text-muted">Note finale = 30 % partiel + 40 % final + 30 % travaux</div>
</div></div>
<form method="post" class="card" data-loading>
    <input type="hidden" name="cours" value="${cours.id}">
    <div class="table-responsive">
        <table class="table table-unaf table-hover">
            <thead><tr><th>Étudiant</th><th class="num">Partiel</th><th class="num">Examen final</th><th class="num">Travaux</th><th class="num">Note finale</th><th>Résultat</th></tr></thead>
            <tbody>
            <c:forEach var="i" items="${inscriptions}">
                <tr data-note-row>
                    <td><input type="hidden" name="inscriptionId" value="${i.id}">
                        <div class="cell-title"><c:out value="${i.etudiant.nomComplet}"/></div><div class="cell-sub"><c:out value="${i.etudiant.email}"/></div></td>
                    <td class="num"><input type="number" step="0.01" min="0" max="100" class="form-control form-control-sm note ms-auto" name="partiel_${i.id}" value="${i.notePartiel}" aria-label="Partiel de ${i.etudiant.nomComplet}"></td>
                    <td class="num"><input type="number" step="0.01" min="0" max="100" class="form-control form-control-sm note ms-auto" name="final_${i.id}" value="${i.noteExamenFinal}" aria-label="Examen final de ${i.etudiant.nomComplet}"></td>
                    <td class="num"><input type="number" step="0.01" min="0" max="100" class="form-control form-control-sm note ms-auto" name="travaux_${i.id}" value="${i.noteTravaux}" aria-label="Travaux de ${i.etudiant.nomComplet}"></td>
                    <td class="num fw-bold" data-note-final>${empty i.noteFinale ? '—' : i.noteFinale}</td>
                    <td><span class="badge-soft ${i.mention == 'Réussi' ? 'badge-success' : i.mention == 'Échoué' ? 'badge-danger' : 'badge-muted'}">${i.mention}</span></td></tr>
            </c:forEach>
            <c:if test="${empty inscriptions}"><tr><td colspan="6"><div class="empty-state"><i class="bi bi-people"></i>Aucun étudiant inscrit à ce cours pour cette session.</div></td></tr></c:if>
            </tbody>
        </table>
    </div>
    <c:if test="${not empty inscriptions}"><div class="sticky-actions"><button type="submit" class="btn btn-primary"><i class="bi bi-save"></i> Enregistrer les notes</button></div></c:if>
</form>
<%@ include file="/WEB-INF/views/commun/footer.jspf" %>
