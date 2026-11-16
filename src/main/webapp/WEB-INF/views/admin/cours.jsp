<%@ include file="/WEB-INF/views/commun/header.jspf" %>
<h1 class="h3 mb-4">Cours</h1>
<div class="card shadow-sm mb-4"><div class="card-body">
    <h2 class="h6">${empty edition ? 'Nouveau cours' : 'Modifier le cours'}</h2>
    <form method="post" class="row g-2">
        <input type="hidden" name="id" value="${edition.id}">
        <div class="col-md-2"><label class="form-label small">Code</label><input name="code" class="form-control" value="<c:out value='${edition.code}'/>" required></div>
        <div class="col-md-4"><label class="form-label small">Intitulé</label><input name="intitule" class="form-control" value="<c:out value='${edition.intitule}'/>" required></div>
        <div class="col-md-1"><label class="form-label small">Crédits</label><input type="number" name="credits" class="form-control" min="1" value="${empty edition ? 3 : edition.credits}"></div>
        <div class="col-md-5"><label class="form-label small">Programme</label>
            <select name="programmeId" class="form-select" required>
                <c:forEach var="p" items="${programmes}"><option value="${p.id}" ${edition.programme.id == p.id ? 'selected' : ''}><c:out value="${p.nom}"/></option></c:forEach>
            </select></div>
        <div class="col-md-3"><label class="form-label small">Professeur affecté</label>
            <select name="professeurId" class="form-select">
                <option value="">— Aucun —</option>
                <c:forEach var="pr" items="${professeurs}"><option value="${pr.id}" ${edition.professeur.id == pr.id ? 'selected' : ''}><c:out value="${pr.nomComplet}"/></option></c:forEach>
            </select></div>
        <div class="col-md-2"><label class="form-label small">Salle</label>
            <select name="salleId" class="form-select">
                <option value="">—</option>
                <c:forEach var="s" items="${salles}"><option value="${s.id}" ${edition.salle.id == s.id ? 'selected' : ''}><c:out value="${s.nom}"/></option></c:forEach>
            </select></div>
        <div class="col-md-2"><label class="form-label small">Jour</label>
            <select name="jour" class="form-select">
                <option value="">—</option>
                <c:forEach var="j" items="${jours}"><option ${edition.jour == j ? 'selected' : ''}>${j}</option></c:forEach>
            </select></div>
        <div class="col-md-1"><label class="form-label small">Début</label><input type="time" name="heureDebut" class="form-control" value="${edition.heureDebut}"></div>
        <div class="col-md-1"><label class="form-label small">Fin</label><input type="time" name="heureFin" class="form-control" value="${edition.heureFin}"></div>
        <div class="col-md-3"><label class="form-label small">Prérequis (Ctrl+clic)</label>
            <select name="prerequis" class="form-select" multiple size="3">
                <c:forEach var="pc" items="${coursListe}">
                    <c:if test="${pc.id != edition.id}">
                        <option value="${pc.id}" ${edition.prerequis.contains(pc) ? 'selected' : ''}>${pc.code}</option>
                    </c:if>
                </c:forEach>
            </select></div>
        <div class="col-12">
            <button class="btn btn-primary">Enregistrer</button>
            <c:if test="${not empty edition}"><a href="${ctx}/admin/cours" class="btn btn-link">Annuler</a></c:if>
        </div>
    </form>
</div></div>

<div class="card shadow-sm"><div class="card-body p-0 table-responsive">
    <table class="table table-hover mb-0">
        <thead class="table-light"><tr><th>Code</th><th>Intitulé</th><th>Crédits</th><th>Programme</th><th>Professeur</th><th>Horaire</th><th>Salle</th><th>Prérequis</th><th class="text-end">Actions</th></tr></thead>
        <tbody>
        <c:forEach var="c" items="${coursListe}">
            <tr><td class="fw-semibold">${c.code}</td><td><c:out value="${c.intitule}"/></td><td>${c.credits}</td>
                <td class="small"><c:out value="${c.programme.nom}"/></td>
                <td><c:choose><c:when test="${not empty c.professeur}"><c:out value="${c.professeur.nomComplet}"/></c:when>
                    <c:otherwise><span class="badge bg-warning text-dark">Non affecté</span></c:otherwise></c:choose></td>
                <td class="small">${c.horaire}</td><td><c:out value="${c.salle.nom}"/></td>
                <td class="small"><c:forEach var="pr" items="${c.prerequis}" varStatus="st">${pr.code}${st.last ? '' : ', '}</c:forEach></td>
                <td class="text-end text-nowrap"><a class="btn btn-sm btn-outline-secondary" href="?modifier=${c.id}"><i class="bi bi-pencil"></i></a>
                <form method="post" class="d-inline" onsubmit="return confirm('Supprimer ?')"><input type="hidden" name="action" value="supprimer"><input type="hidden" name="id" value="${c.id}"><button class="btn btn-sm btn-outline-danger"><i class="bi bi-trash"></i></button></form></td></tr>
        </c:forEach>
        </tbody>
    </table>
</div></div>
<%@ include file="/WEB-INF/views/commun/footer.jspf" %>
