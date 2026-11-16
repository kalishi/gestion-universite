<%@ include file="/WEB-INF/views/commun/header.jspf" %>
<h1 class="h3 mb-4">Programmes</h1>
<div class="row g-4">
    <div class="col-lg-4">
        <div class="card shadow-sm"><div class="card-body">
            <h2 class="h6">${empty edition ? 'Nouveau programme' : 'Modifier le programme'}</h2>
            <form method="post">
                <input type="hidden" name="id" value="${edition.id}">
                <label class="form-label">Nom</label>
                <input name="nom" class="form-control mb-2" value="<c:out value='${edition.nom}'/>" required>
                <label class="form-label">Niveau</label>
                <select name="niveau" class="form-select mb-2">
                    <c:forEach var="n" items="${niveaux}"><option value="${n}" ${edition.niveau == n ? 'selected' : ''}>${n}</option></c:forEach>
                </select>
                <label class="form-label">Faculté</label>
                <select name="faculteId" class="form-select mb-2" required>
                    <c:forEach var="f" items="${facultes}"><option value="${f.id}" ${edition.faculte.id == f.id ? 'selected' : ''}><c:out value="${f.nom}"/></option></c:forEach>
                </select>
                <div class="row g-2 mb-3">
                    <div class="col"><label class="form-label">Frais (HTG)</label>
                        <input type="number" step="0.01" name="frais" class="form-control" value="${edition.fraisScolarite}" required></div>
                    <div class="col"><label class="form-label">Crédits max / session</label>
                        <input type="number" name="maxCredits" class="form-control" value="${empty edition ? 18 : edition.maxCredits}" required></div>
                </div>
                <button class="btn btn-primary">Enregistrer</button>
                <c:if test="${not empty edition}"><a href="${ctx}/admin/programmes" class="btn btn-link">Annuler</a></c:if>
            </form>
        </div></div>
    </div>
    <div class="col-lg-8">
        <div class="card shadow-sm"><div class="card-body p-0 table-responsive">
            <table class="table table-hover mb-0">
                <thead class="table-light"><tr><th>Programme</th><th>Niveau</th><th>Faculté</th><th>Frais</th><th>Crédits max</th><th class="text-end">Actions</th></tr></thead>
                <tbody>
                <c:forEach var="p" items="${programmes}">
                    <tr><td><c:out value="${p.nom}"/></td><td><span class="badge bg-info text-dark">${p.niveau}</span></td>
                        <td><c:out value="${p.faculte.nom}"/></td>
                        <td><fmt:formatNumber value="${p.fraisScolarite}" type="number" maxFractionDigits="2"/> HTG</td><td>${p.maxCredits}</td>
                        <td class="text-end text-nowrap"><a class="btn btn-sm btn-outline-secondary" href="?modifier=${p.id}"><i class="bi bi-pencil"></i></a>
                        <form method="post" class="d-inline" onsubmit="return confirm('Supprimer ?')"><input type="hidden" name="action" value="supprimer"><input type="hidden" name="id" value="${p.id}"><button class="btn btn-sm btn-outline-danger"><i class="bi bi-trash"></i></button></form></td></tr>
                </c:forEach>
                </tbody>
            </table>
        </div></div>
    </div>
</div>
<%@ include file="/WEB-INF/views/commun/footer.jspf" %>
