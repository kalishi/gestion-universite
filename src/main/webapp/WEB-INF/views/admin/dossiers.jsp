<%@ include file="/WEB-INF/views/commun/header.jspf" %>
<h1 class="h3 mb-4">Dossiers d'inscription</h1>
<div class="card shadow-sm"><div class="card-body p-0 table-responsive">
    <table class="table table-hover mb-0">
        <thead class="table-light"><tr><th>Étudiant</th><th>Programme</th><th>Déposé le</th><th>Statut</th><th></th></tr></thead>
        <tbody>
        <c:forEach var="d" items="${dossiers}">
            <tr><td><c:out value="${d.etudiant.nomComplet}"/><br><small class="text-muted"><c:out value="${d.etudiant.email}"/></small></td>
                <td><c:out value="${d.programme.nom}"/></td><td>${d.dateDepot}</td>
                <td><span class="badge ${d.statut == 'VALIDE' ? 'bg-success' : d.statut == 'REJETE' ? 'bg-danger' : 'bg-warning text-dark'}">${d.statut}</span></td>
                <td class="text-end"><a class="btn btn-sm btn-primary" href="?id=${d.id}">Ouvrir</a></td></tr>
        </c:forEach>
        <c:if test="${empty dossiers}"><tr><td colspan="5" class="text-center text-muted py-4">Aucun dossier.</td></tr></c:if>
        </tbody>
    </table>
</div></div>
<%@ include file="/WEB-INF/views/commun/footer.jspf" %>
