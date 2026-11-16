<%@ include file="/WEB-INF/views/commun/header.jspf" %>
<h1 class="h3 mb-4">Facultés</h1>
<div class="row g-4">
    <div class="col-md-4">
        <div class="card shadow-sm"><div class="card-body">
            <h2 class="h6">${empty edition ? 'Nouvelle faculté' : 'Modifier la faculté'}</h2>
            <form method="post">
                <input type="hidden" name="id" value="${edition.id}">
                <input name="nom" class="form-control mb-3" placeholder="Nom de la faculté" value="<c:out value='${edition.nom}'/>" required>
                <button class="btn btn-primary">Enregistrer</button>
                <c:if test="${not empty edition}"><a href="${ctx}/admin/facultes" class="btn btn-link">Annuler</a></c:if>
            </form>
        </div></div>
    </div>
    <div class="col-md-8">
        <div class="card shadow-sm"><div class="card-body p-0">
            <table class="table table-hover mb-0">
                <thead class="table-light"><tr><th>#</th><th>Nom</th><th class="text-end">Actions</th></tr></thead>
                <tbody>
                <c:forEach var="f" items="${facultes}">
                    <tr><td>${f.id}</td><td><c:out value="${f.nom}"/></td>
                        <td class="text-end"><a class="btn btn-sm btn-outline-secondary" href="?modifier=${f.id}"><i class="bi bi-pencil"></i></a>
                        <form method="post" class="d-inline" onsubmit="return confirm('Supprimer ?')"><input type="hidden" name="action" value="supprimer"><input type="hidden" name="id" value="${f.id}"><button class="btn btn-sm btn-outline-danger"><i class="bi bi-trash"></i></button></form></td></tr>
                </c:forEach>
                </tbody>
            </table>
        </div></div>
    </div>
</div>
<%@ include file="/WEB-INF/views/commun/footer.jspf" %>
