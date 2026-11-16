<%@ include file="/WEB-INF/views/commun/header.jspf" %>
<div class="row g-3">
    <div class="col-lg-4">
        <div class="card">
            <div class="card-header"><h2>${empty edition ? 'Nouvelle faculté' : 'Modifier la faculté'}</h2></div>
            <div class="card-body">
                <form method="post" data-loading>
                    <input type="hidden" name="id" value="${edition.id}">
                    <label class="form-label" for="nom">Nom de la faculté<span class="req">*</span></label>
                    <input id="nom" name="nom" class="form-control" placeholder="Ex. Faculté de Droit" value="<c:out value='${edition.nom}'/>" required>
                    <div class="d-flex gap-2 mt-3">
                        <button type="submit" class="btn btn-primary"><i class="bi bi-check2"></i> Enregistrer</button>
                        <c:if test="${not empty edition}"><a href="${ctx}/admin/facultes" class="btn btn-ghost">Annuler</a></c:if>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="col-lg-8">
        <div class="card">
            <div class="table-toolbar">
                <div class="search-input"><i class="bi bi-search"></i><input type="search" class="form-control" placeholder="Rechercher une faculté" aria-label="Rechercher" data-filter-table="#tbl"></div>
                <span class="small text-muted">${facultes.size()} faculté(s)</span>
            </div>
            <div class="table-responsive">
                <table class="table table-unaf table-hover" id="tbl">
                    <thead><tr><th>Faculté</th><th class="num">Programmes</th><th class="num">Étudiants admis</th><th class="actions">Actions</th></tr></thead>
                    <tbody>
                    <c:forEach var="f" items="${facultes}">
                        <tr data-row><td><div class="d-flex align-items-center gap-2"><span class="kpi-icon tone-primary" style="width:34px;height:34px;font-size:1rem"><i class="bi bi-bank"></i></span><span class="cell-title"><c:out value="${f.nom}"/></span></div></td>
                            <td class="num">${empty progParFac[f.id] ? 0 : progParFac[f.id]}</td>
                            <td class="num">${empty etuParFac[f.nom] ? 0 : etuParFac[f.nom]}</td>
                            <td class="actions"><a class="btn btn-sm btn-ghost" href="${ctx}/admin/etudiants?faculte=${f.id}" aria-label="Voir les étudiants"><i class="bi bi-people"></i></a><a class="btn btn-sm btn-ghost" href="?modifier=${f.id}" aria-label="Modifier"><i class="bi bi-pencil"></i></a><form method="post" class="d-inline" data-confirm="Supprimer cet élément ? Cette action est définitive."><input type="hidden" name="action" value="supprimer"><input type="hidden" name="id" value="${f.id}"><button class="btn btn-sm btn-ghost text-danger" aria-label="Supprimer"><i class="bi bi-trash"></i></button></form></td></tr>
                    </c:forEach>
                    <c:if test="${empty facultes}"><tr><td colspan="4"><div class="empty-state"><i class="bi bi-bank"></i>Aucune faculté. Créez la première avec le formulaire.</div></td></tr></c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/views/commun/footer.jspf" %>
