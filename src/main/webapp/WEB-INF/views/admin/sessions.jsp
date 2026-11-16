<%@ include file="/WEB-INF/views/commun/header.jspf" %>
<h1 class="h3 mb-4">Sessions académiques</h1>
<div class="row g-4">
    <div class="col-md-4">
        <div class="card shadow-sm"><div class="card-body">
            <h2 class="h6">Nouvelle session</h2>
            <form method="post">
                <input name="libelle" class="form-control mb-2" placeholder="Ex. Printemps 2027" required>
                <label class="form-label small">Début</label><input type="date" name="dateDebut" class="form-control mb-2">
                <label class="form-label small">Fin</label><input type="date" name="dateFin" class="form-control mb-3">
                <button class="btn btn-primary">Créer</button>
            </form>
        </div></div>
    </div>
    <div class="col-md-8">
        <div class="card shadow-sm"><div class="card-body p-0">
            <table class="table table-hover mb-0">
                <thead class="table-light"><tr><th>Session</th><th>Début</th><th>Fin</th><th>État</th><th class="text-end">Actions</th></tr></thead>
                <tbody>
                <c:forEach var="s" items="${sessions}">
                    <tr><td><c:out value="${s.libelle}"/></td><td>${s.dateDebut}</td><td>${s.dateFin}</td>
                        <td><c:choose><c:when test="${s.active}"><span class="badge bg-success">Active</span></c:when>
                            <c:otherwise><span class="badge bg-secondary">Fermée</span></c:otherwise></c:choose></td>
                        <td class="text-end text-nowrap">
                            <c:if test="${not s.active}">
                                <form method="post" class="d-inline"><input type="hidden" name="action" value="activer"><input type="hidden" name="id" value="${s.id}">
                                    <button class="btn btn-sm btn-outline-success">Activer</button></form>
                            </c:if>
                            <form method="post" class="d-inline" onsubmit="return confirm('Supprimer ?')"><input type="hidden" name="action" value="supprimer"><input type="hidden" name="id" value="${s.id}"><button class="btn btn-sm btn-outline-danger"><i class="bi bi-trash"></i></button></form></td></tr>
                </c:forEach>
                </tbody>
            </table>
        </div></div>
        <p class="text-muted small mt-2">Les étudiants choisissent leurs cours dans la session active ; une seule session est active à la fois.</p>
    </div>
</div>
<%@ include file="/WEB-INF/views/commun/footer.jspf" %>
