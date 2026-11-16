<%@ include file="/WEB-INF/views/commun/header.jspf" %>
<div class="card">
    <div class="table-toolbar">
        <form method="get" class="d-flex gap-2 align-items-center">
            <label class="form-label mb-0 small text-nowrap" for="faculte">Faculté</label>
            <select id="faculte" name="faculte" class="form-select" onchange="this.form.submit()">
                <option value="">Toutes les facultés</option>
                <c:forEach var="f" items="${facultes}"><option value="${f.id}" ${faculteId == f.id ? 'selected' : ''}><c:out value="${f.nom}"/></option></c:forEach>
            </select>
            <noscript><button class="btn btn-sm btn-primary">Filtrer</button></noscript>
        </form>
        <div class="d-flex align-items-center gap-3">
            <div class="search-input"><i class="bi bi-search"></i><input type="search" class="form-control" placeholder="Nom, email, programme…" aria-label="Rechercher un étudiant" data-filter-table="#tbl" data-filter-count="#nbEtu"></div>
            <span class="small text-muted text-nowrap"><span id="nbEtu">${lignes.size()}</span> étudiant(s)</span>
        </div>
    </div>
    <div class="table-responsive">
        <table class="table table-unaf table-hover" id="tbl">
            <thead><tr><th>Étudiant</th><th>Faculté / programme</th><th>Admission</th><th class="num">Payé</th><th class="num">Solde</th><th class="actions"></th></tr></thead>
            <tbody>
            <c:forEach var="l" items="${lignes}">
                <c:set var="d" value="${l.dossier}"/>
                <tr data-row>
                    <td><div class="d-flex align-items-center gap-2"><span class="avatar"><c:out value="${l.etudiant.prenom.substring(0,1)}${l.etudiant.nom.substring(0,1)}"/></span>
                        <div><div class="cell-title"><c:out value="${l.etudiant.nomComplet}"/></div><div class="cell-sub"><c:out value="${l.etudiant.email}"/></div></div></div></td>
                    <td><c:choose><c:when test="${not empty d}"><div><c:out value="${d.programme.nom}"/></div><div class="cell-sub"><c:out value="${d.programme.faculte.nom}"/></div></c:when><c:otherwise><span class="text-muted">—</span></c:otherwise></c:choose></td>
                    <td><c:choose><c:when test="${not empty d}"><%@ include file="/WEB-INF/views/commun/badge-statut.jspf" %></c:when><c:otherwise><span class="badge-soft badge-muted">Sans dossier</span></c:otherwise></c:choose></td>
                    <td class="num"><fmt:formatNumber value="${l.paye}" maxFractionDigits="0"/></td>
                    <td class="num ${l.solde > 0 ? 'text-danger fw-semibold' : ''}"><fmt:formatNumber value="${l.solde}" maxFractionDigits="0"/></td>
                    <td class="actions"><c:if test="${not empty d}"><a class="btn btn-sm btn-ghost" href="${ctx}/admin/dossiers?id=${d.id}" aria-label="Ouvrir le dossier"><i class="bi bi-chevron-right"></i></a></c:if></td>
                </tr>
            </c:forEach>
            <c:if test="${empty lignes}"><tr><td colspan="6"><div class="empty-state"><i class="bi bi-people"></i>Aucun étudiant pour ce filtre.</div></td></tr></c:if>
            </tbody>
        </table>
    </div>
</div>
<%@ include file="/WEB-INF/views/commun/footer.jspf" %>
