<%@ include file="/WEB-INF/views/commun/header.jspf" %>
<div class="row g-3">
    <div class="col-lg-4">
        <div class="card">
            <div class="card-header"><h2>${empty edition ? 'Nouvelle salle' : 'Modifier la salle'}</h2></div>
            <div class="card-body">
                <form method="post" data-loading>
                    <input type="hidden" name="id" value="${edition.id}">
                    <div class="mb-3"><label class="form-label" for="nom">Nom<span class="req">*</span></label>
                        <input id="nom" name="nom" class="form-control" placeholder="Ex. A-101, Amphi 1, Labo 2" value="<c:out value='${edition.nom}'/>" required></div>
                    <div class="mb-3"><label class="form-label" for="capacite">Capacité (places)</label>
                        <input type="number" id="capacite" name="capacite" class="form-control" value="${edition.capacite}" min="1"></div>
                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary"><i class="bi bi-check2"></i> Enregistrer</button>
                        <c:if test="${not empty edition}"><a href="${ctx}/admin/salles" class="btn btn-ghost">Annuler</a></c:if>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="col-lg-8">
        <div class="card">
            <div class="table-toolbar">
                <div class="search-input"><i class="bi bi-search"></i><input type="search" class="form-control" placeholder="Rechercher une salle" aria-label="Rechercher" data-filter-table="#tbl"></div>
                <span class="small text-muted">${salles.size()} salle(s)</span>
            </div>
            <div class="table-responsive">
                <table class="table table-unaf table-hover" id="tbl">
                    <thead><tr><th>Salle</th><th class="num">Capacité</th><th class="actions">Actions</th></tr></thead>
                    <tbody>
                    <c:forEach var="s" items="${salles}">
                        <tr data-row><td><span class="cell-title"><i class="bi bi-door-open me-2 text-muted"></i><c:out value="${s.nom}"/></span></td><td class="num">${s.capacite} places</td>
                            <td class="actions"><a class="btn btn-sm btn-ghost" href="?modifier=${s.id}" aria-label="Modifier"><i class="bi bi-pencil"></i></a><form method="post" class="d-inline" data-confirm="Supprimer cet élément ? Cette action est définitive."><input type="hidden" name="action" value="supprimer"><input type="hidden" name="id" value="${s.id}"><button class="btn btn-sm btn-ghost text-danger" aria-label="Supprimer"><i class="bi bi-trash"></i></button></form></td></tr>
                    </c:forEach>
                    <c:if test="${empty salles}"><tr><td colspan="3"><div class="empty-state"><i class="bi bi-door-open"></i>Aucune salle enregistrée.</div></td></tr></c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/views/commun/footer.jspf" %>
