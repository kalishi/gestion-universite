<%@ include file="/WEB-INF/views/commun/header.jspf" %>
<div class="card">
    <div class="table-toolbar">
        <ul class="nav nav-pills gap-1" role="tablist">
            <li class="nav-item"><a class="nav-link ${empty statut ? 'active' : ''}" href="${ctx}/admin/dossiers">Tous <span class="badge bg-light text-dark ms-1">${nbTous}</span></a></li>
            <li class="nav-item"><a class="nav-link ${statut == 'EN_ATTENTE' ? 'active' : ''}" href="?statut=EN_ATTENTE">En attente <span class="badge bg-warning text-dark ms-1">${nbAttente}</span></a></li>
            <li class="nav-item"><a class="nav-link ${statut == 'VALIDE' ? 'active' : ''}" href="?statut=VALIDE">Validés <span class="badge bg-success ms-1">${nbValides}</span></a></li>
            <li class="nav-item"><a class="nav-link ${statut == 'REJETE' ? 'active' : ''}" href="?statut=REJETE">Rejetés <span class="badge bg-danger ms-1">${nbRejetes}</span></a></li>
        </ul>
        <div class="search-input"><i class="bi bi-search"></i><input type="search" class="form-control" placeholder="Nom, programme, faculté…" aria-label="Rechercher un dossier" data-filter-table="#tbl"></div>
    </div>
    <div class="table-responsive">
        <table class="table table-unaf table-hover" id="tbl">
            <thead><tr><th>Étudiant</th><th>Programme demandé</th><th>Déposé le</th><th>Statut</th><th class="actions"></th></tr></thead>
            <tbody>
            <c:forEach var="d" items="${dossiers}">
                <tr data-row><td><div class="d-flex align-items-center gap-2"><span class="avatar"><c:out value="${d.etudiant.prenom.substring(0,1)}${d.etudiant.nom.substring(0,1)}"/></span>
                        <div><div class="cell-title"><c:out value="${d.etudiant.nomComplet}"/></div><div class="cell-sub"><c:out value="${d.etudiant.email}"/></div></div></div></td>
                    <td><div><c:out value="${d.programme.nom}"/></div><div class="cell-sub"><c:out value="${d.programme.faculte.nom}"/></div></td>
                    <td class="text-nowrap">${d.dateDepot}</td>
                    <td><%@ include file="/WEB-INF/views/commun/badge-statut.jspf" %></td>
                    <td class="actions"><a class="btn btn-sm btn-primary" href="?id=${d.id}">Examiner</a></td></tr>
            </c:forEach>
            <c:if test="${empty dossiers}"><tr><td colspan="5"><div class="empty-state"><i class="bi bi-inbox"></i>Aucun dossier dans cette catégorie.</div></td></tr></c:if>
            </tbody>
        </table>
    </div>
</div>
<%@ include file="/WEB-INF/views/commun/footer.jspf" %>
