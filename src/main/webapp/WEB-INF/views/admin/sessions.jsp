<%@ include file="/WEB-INF/views/commun/header.jspf" %>
<div class="row g-3">
    <div class="col-lg-4">
        <div class="card">
            <div class="card-header"><h2>Nouvelle session</h2></div>
            <div class="card-body">
                <form method="post" data-loading>
                    <div class="mb-3"><label class="form-label" for="libelle">Libellé<span class="req">*</span></label>
                        <input id="libelle" name="libelle" class="form-control" placeholder="Ex. Printemps 2027" required></div>
                    <div class="row g-2 mb-3">
                        <div class="col-6"><label class="form-label" for="dateDebut">Début</label><input type="date" id="dateDebut" name="dateDebut" class="form-control"></div>
                        <div class="col-6"><label class="form-label" for="dateFin">Fin</label><input type="date" id="dateFin" name="dateFin" class="form-control"></div>
                    </div>
                    <button type="submit" class="btn btn-primary"><i class="bi bi-plus-lg"></i> Créer la session</button>
                </form>
            </div>
        </div>
        <div class="alert alert-info mt-3"><i class="bi bi-info-circle"></i><div>Une seule session est ouverte à la fois : c'est dans celle-ci que les étudiants choisissent leurs cours et que les professeurs saisissent les notes.</div></div>
    </div>
    <div class="col-lg-8">
        <div class="card">
            <div class="table-responsive">
                <table class="table table-unaf table-hover">
                    <thead><tr><th>Session</th><th>Période</th><th>État</th><th class="actions">Actions</th></tr></thead>
                    <tbody>
                    <c:forEach var="s" items="${sessions}">
                        <tr><td class="cell-title"><c:out value="${s.libelle}"/></td><td class="text-nowrap">${s.dateDebut} → ${s.dateFin}</td>
                            <td><c:choose><c:when test="${s.active}"><span class="badge-soft badge-success">Ouverte</span></c:when><c:otherwise><span class="badge-soft badge-muted">Fermée</span></c:otherwise></c:choose></td>
                            <td class="actions">
                                <c:if test="${not s.active}">
                                    <form method="post" class="d-inline"><input type="hidden" name="action" value="activer"><input type="hidden" name="id" value="${s.id}">
                                        <button class="btn btn-sm btn-outline-primary"><i class="bi bi-play-fill"></i> Ouvrir</button></form>
                                </c:if>
                                <form method="post" class="d-inline" data-confirm="Supprimer cet élément ? Cette action est définitive."><input type="hidden" name="action" value="supprimer"><input type="hidden" name="id" value="${s.id}"><button class="btn btn-sm btn-ghost text-danger" aria-label="Supprimer"><i class="bi bi-trash"></i></button></form></td></tr>
                    </c:forEach>
                    <c:if test="${empty sessions}"><tr><td colspan="4"><div class="empty-state"><i class="bi bi-calendar3"></i>Aucune session.</div></td></tr></c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/views/commun/footer.jspf" %>
