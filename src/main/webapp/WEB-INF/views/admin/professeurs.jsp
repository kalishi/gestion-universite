<%@ include file="/WEB-INF/views/commun/header.jspf" %>
<h1 class="h3 mb-4">Professeurs</h1>
<div class="row g-4">
    <div class="col-md-4">
        <div class="card shadow-sm"><div class="card-body">
            <h2 class="h6">Nouveau compte professeur</h2>
            <form method="post">
                <input name="prenom" class="form-control mb-2" placeholder="Prénom" required>
                <input name="nom" class="form-control mb-2" placeholder="Nom" required>
                <input type="email" name="email" class="form-control mb-2" placeholder="Email" required>
                <input name="motDePasse" class="form-control mb-3" placeholder="Mot de passe" required>
                <button class="btn btn-primary">Créer</button>
            </form>
        </div></div>
    </div>
    <div class="col-md-8">
        <div class="card shadow-sm"><div class="card-body p-0">
            <table class="table table-hover mb-0">
                <thead class="table-light"><tr><th>Nom</th><th>Email</th><th>Cours affectés</th><th class="text-end"></th></tr></thead>
                <tbody>
                <c:forEach var="p" items="${professeurs}">
                    <tr><td><c:out value="${p.nomComplet}"/></td><td><c:out value="${p.email}"/></td>
                        <td class="small"><c:forEach var="c" items="${coursListe}"><c:if test="${c.professeur.id == p.id}"><span class="badge bg-primary-subtle text-primary-emphasis">${c.code}</span> </c:if></c:forEach></td>
                        <td class="text-end"><form method="post" class="d-inline" onsubmit="return confirm('Supprimer ?')"><input type="hidden" name="action" value="supprimer"><input type="hidden" name="id" value="${p.id}"><button class="btn btn-sm btn-outline-danger"><i class="bi bi-trash"></i></button></form></td></tr>
                </c:forEach>
                </tbody>
            </table>
        </div></div>
        <p class="text-muted small mt-2">L'affectation d'un professeur à un cours se fait dans <a href="${ctx}/admin/cours">Cours</a> (bouton modifier).</p>
    </div>
</div>
<%@ include file="/WEB-INF/views/commun/footer.jspf" %>
