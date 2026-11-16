<%@ include file="/WEB-INF/views/commun/header.jspf" %>
<div class="row g-3">
    <div class="col-lg-4">
        <div class="card">
            <div class="card-header"><h2>Nouveau compte professeur</h2></div>
            <div class="card-body">
                <form method="post" data-loading>
                    <div class="row g-2 mb-3">
                        <div class="col-6"><label class="form-label" for="prenom">Prénom<span class="req">*</span></label><input id="prenom" name="prenom" class="form-control" required></div>
                        <div class="col-6"><label class="form-label" for="nom">Nom<span class="req">*</span></label><input id="nom" name="nom" class="form-control" required></div>
                    </div>
                    <div class="mb-3"><label class="form-label" for="email">Email<span class="req">*</span></label><input type="email" id="email" name="email" class="form-control" required></div>
                    <div class="mb-3"><label class="form-label" for="motDePasse">Mot de passe initial<span class="req">*</span></label><input id="motDePasse" name="motDePasse" class="form-control" required></div>
                    <button type="submit" class="btn btn-primary"><i class="bi bi-person-plus"></i> Créer le compte</button>
                </form>
            </div>
        </div>
        <div class="alert alert-info mt-3"><i class="bi bi-info-circle"></i><div>L'affectation aux cours se fait depuis <a href="${ctx}/admin/cours">Cours</a>, en modifiant un cours.</div></div>
    </div>
    <div class="col-lg-8">
        <div class="card">
            <div class="table-toolbar">
                <div class="search-input"><i class="bi bi-search"></i><input type="search" class="form-control" placeholder="Rechercher un professeur" aria-label="Rechercher" data-filter-table="#tbl"></div>
                <span class="small text-muted">${professeurs.size()} professeur(s)</span>
            </div>
            <div class="table-responsive">
                <table class="table table-unaf table-hover" id="tbl">
                    <thead><tr><th>Professeur</th><th>Cours affectés</th><th class="actions"></th></tr></thead>
                    <tbody>
                    <c:forEach var="p" items="${professeurs}">
                        <tr data-row><td><div class="d-flex align-items-center gap-2"><span class="avatar"><c:out value="${p.prenom.substring(0,1)}${p.nom.substring(0,1)}"/></span>
                                <div><div class="cell-title"><c:out value="${p.nomComplet}"/></div><div class="cell-sub"><c:out value="${p.email}"/></div></div></div></td>
                            <td><c:set var="n" value="0"/><c:forEach var="c" items="${coursListe}"><c:if test="${c.professeur.id == p.id}"><span class="code-tag me-1" title="<c:out value='${c.intitule}'/>">${c.code}</span><c:set var="n" value="${n + 1}"/></c:if></c:forEach>
                                <c:if test="${n == 0}"><span class="text-muted">Aucun cours</span></c:if></td>
                            <td class="actions"><form method="post" class="d-inline" data-confirm="Supprimer cet élément ? Cette action est définitive."><input type="hidden" name="action" value="supprimer"><input type="hidden" name="id" value="${p.id}"><button class="btn btn-sm btn-ghost text-danger" aria-label="Supprimer"><i class="bi bi-trash"></i></button></form></td></tr>
                    </c:forEach>
                    <c:if test="${empty professeurs}"><tr><td colspan="3"><div class="empty-state"><i class="bi bi-person-badge"></i>Aucun professeur.</div></td></tr></c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/views/commun/footer.jspf" %>
