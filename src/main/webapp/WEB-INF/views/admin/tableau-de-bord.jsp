<%@ include file="/WEB-INF/views/commun/header.jspf" %>
<h1 class="h3 mb-4">Tableau de bord</h1>
<div class="row g-3 mb-4">
    <div class="col-6 col-md-3"><div class="card shadow-sm"><div class="card-body"><div class="text-muted">Étudiants</div><div class="stat">${nbEtudiants}</div></div></div></div>
    <div class="col-6 col-md-3"><div class="card shadow-sm"><div class="card-body"><div class="text-muted">Professeurs</div><div class="stat">${nbProfesseurs}</div></div></div></div>
    <div class="col-6 col-md-3"><div class="card shadow-sm"><div class="card-body"><div class="text-muted">Programmes</div><div class="stat">${nbProgrammes}</div></div></div></div>
    <div class="col-6 col-md-3"><div class="card shadow-sm"><div class="card-body"><div class="text-muted">Cours</div><div class="stat">${nbCours}</div></div></div></div>
</div>
<div class="row g-3">
    <div class="col-md-6">
        <div class="card shadow-sm"><div class="card-body">
            <h2 class="h5">Dossiers en attente</h2>
            <p class="stat text-warning mb-2">${enAttente}</p>
            <a href="${ctx}/admin/dossiers" class="btn btn-sm btn-primary">Examiner les dossiers</a>
        </div></div>
    </div>
    <div class="col-md-6">
        <div class="card shadow-sm"><div class="card-body">
            <h2 class="h5">Session active</h2>
            <c:choose>
                <c:when test="${not empty sessionActive}"><p class="fs-4 mb-2"><c:out value="${sessionActive.libelle}"/></p></c:when>
                <c:otherwise><p class="text-danger mb-2">Aucune session active</p></c:otherwise>
            </c:choose>
            <a href="${ctx}/admin/sessions" class="btn btn-sm btn-outline-primary">Gérer les sessions</a>
        </div></div>
    </div>
</div>
<%@ include file="/WEB-INF/views/commun/footer.jspf" %>
