<%@ include file="/WEB-INF/views/commun/header.jspf" %>
<div class="row g-3">
    <div class="col-xl-4">
        <div class="card">
            <div class="card-header"><h2>${empty edition ? 'Nouveau programme' : 'Modifier le programme'}</h2></div>
            <div class="card-body">
                <form method="post" data-loading>
                    <input type="hidden" name="id" value="${edition.id}">
                    <div class="mb-3"><label class="form-label" for="nom">Intitulé<span class="req">*</span></label>
                        <input id="nom" name="nom" class="form-control" placeholder="Ex. Licence en Droit" value="<c:out value='${edition.nom}'/>" required></div>
                    <div class="mb-3"><label class="form-label" for="faculteId">Faculté<span class="req">*</span></label>
                        <select id="faculteId" name="faculteId" class="form-select" required>
                            <c:forEach var="f" items="${facultes}"><option value="${f.id}" ${edition.faculte.id == f.id ? 'selected' : ''}><c:out value="${f.nom}"/></option></c:forEach>
                        </select></div>
                    <div class="mb-3"><label class="form-label" for="niveau">Niveau</label>
                        <select id="niveau" name="niveau" class="form-select">
                            <c:forEach var="n" items="${niveaux}"><option value="${n}" ${edition.niveau == n ? 'selected' : ''}>${n == 'LICENCE' ? 'Licence' : n == 'MASTER' ? 'Master' : 'Doctorat'}</option></c:forEach>
                        </select></div>
                    <div class="row g-2 mb-3">
                        <div class="col-7"><label class="form-label" for="frais">Frais annuels (HTG)<span class="req">*</span></label>
                            <input type="number" step="0.01" min="0" id="frais" name="frais" class="form-control" value="${edition.fraisScolarite}" required></div>
                        <div class="col-5"><label class="form-label" for="maxCredits">Crédits max</label>
                            <input type="number" min="1" id="maxCredits" name="maxCredits" class="form-control" value="${empty edition ? 18 : edition.maxCredits}" required aria-describedby="credAide"></div>
                    </div>
                    <div id="credAide" class="form-text mb-3">Nombre maximum de crédits qu'un étudiant peut prendre par session.</div>
                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary"><i class="bi bi-check2"></i> Enregistrer</button>
                        <c:if test="${not empty edition}"><a href="${ctx}/admin/programmes" class="btn btn-ghost">Annuler</a></c:if>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="col-xl-8">
        <div class="card">
            <div class="table-toolbar">
                <div class="search-input"><i class="bi bi-search"></i><input type="search" class="form-control" placeholder="Programme, faculté, niveau…" aria-label="Rechercher" data-filter-table="#tbl"></div>
                <span class="small text-muted">${programmes.size()} programme(s)</span>
            </div>
            <div class="table-responsive">
                <table class="table table-unaf table-hover" id="tbl">
                    <thead><tr><th>Programme</th><th>Niveau</th><th class="num">Frais annuels</th><th class="num">Crédits max</th><th class="actions">Actions</th></tr></thead>
                    <tbody>
                    <c:forEach var="p" items="${programmes}">
                        <tr data-row><td><div class="cell-title"><c:out value="${p.nom}"/></div><div class="cell-sub"><c:out value="${p.faculte.nom}"/></div></td>
                            <td><span class="badge-soft ${p.niveau == 'LICENCE' ? 'badge-primary' : p.niveau == 'MASTER' ? 'badge-warning' : 'badge-success'}">${p.niveau == 'LICENCE' ? 'Licence' : p.niveau == 'MASTER' ? 'Master' : 'Doctorat'}</span></td>
                            <td class="num"><fmt:formatNumber value="${p.fraisScolarite}" maxFractionDigits="0"/> HTG</td><td class="num">${p.maxCredits}</td>
                            <td class="actions"><a class="btn btn-sm btn-ghost" href="?modifier=${p.id}" aria-label="Modifier"><i class="bi bi-pencil"></i></a><form method="post" class="d-inline" data-confirm="Supprimer cet élément ? Cette action est définitive."><input type="hidden" name="action" value="supprimer"><input type="hidden" name="id" value="${p.id}"><button class="btn btn-sm btn-ghost text-danger" aria-label="Supprimer"><i class="bi bi-trash"></i></button></form></td></tr>
                    </c:forEach>
                    <c:if test="${empty programmes}"><tr><td colspan="5"><div class="empty-state"><i class="bi bi-diagram-3"></i>Aucun programme.</div></td></tr></c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/views/commun/footer.jspf" %>
