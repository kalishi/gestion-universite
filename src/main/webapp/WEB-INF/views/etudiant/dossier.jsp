<%@ include file="/WEB-INF/views/commun/header.jspf" %>
<h1 class="h3 mb-4">Mon dossier d'inscription</h1>
<c:choose>
<c:when test="${dossier.statut == 'VALIDE'}">
    <div class="card shadow-sm"><div class="card-body">
        <div class="alert alert-success">Votre dossier a été validé. Vous pouvez choisir vos cours.</div>
        <dl class="row mb-0">
            <dt class="col-sm-3">Programme</dt><dd class="col-sm-9"><c:out value="${dossier.programme.nom}"/> — <c:out value="${dossier.programme.faculte.nom}"/></dd>
            <dt class="col-sm-3">Date de naissance</dt><dd class="col-sm-9">${dossier.dateNaissance}</dd>
            <dt class="col-sm-3">Téléphone</dt><dd class="col-sm-9"><c:out value="${dossier.telephone}"/></dd>
            <dt class="col-sm-3">Adresse</dt><dd class="col-sm-9"><c:out value="${dossier.adresse}"/></dd>
        </dl>
    </div></div>
</c:when>
<c:otherwise>
    <c:if test="${dossier.statut == 'EN_ATTENTE'}"><div class="alert alert-info">Dossier déposé le ${dossier.dateDepot}, en attente de validation. Vous pouvez encore le modifier.</div></c:if>
    <c:if test="${dossier.statut == 'REJETE'}"><div class="alert alert-danger">Votre dossier a été rejeté. Corrigez-le et déposez-le à nouveau.</div></c:if>
    <div class="card shadow-sm"><div class="card-body">
        <form method="post" enctype="multipart/form-data" class="row g-3">
            <div class="col-md-6"><label class="form-label">Programme souhaité</label>
                <select name="programmeId" class="form-select" required>
                    <option value="">— Choisir —</option>
                    <c:forEach var="p" items="${programmes}"><option value="${p.id}" ${dossier.programme.id == p.id ? 'selected' : ''}><c:out value="${p.nom}"/> (${p.niveau})</option></c:forEach>
                </select></div>
            <div class="col-md-3"><label class="form-label">Date de naissance</label>
                <input type="date" name="dateNaissance" class="form-control" value="${dossier.dateNaissance}" required></div>
            <div class="col-md-3"><label class="form-label">Téléphone</label>
                <input name="telephone" class="form-control" value="<c:out value='${dossier.telephone}'/>" required></div>
            <div class="col-12"><label class="form-label">Adresse</label>
                <input name="adresse" class="form-control" value="<c:out value='${dossier.adresse}'/>" required></div>
            <div class="col-md-4"><label class="form-label">Photo d'identité</label>
                <input type="file" name="photo" class="form-control" accept="image/*" ${empty dossier.photo ? 'required' : ''}>
                <c:if test="${not empty dossier.photo}"><a class="small" target="_blank" href="${ctx}/fichier?dossier=${dossier.id}&type=photo">Fichier actuel</a></c:if></div>
            <div class="col-md-4"><label class="form-label">Diplôme</label>
                <input type="file" name="diplome" class="form-control" accept=".pdf,image/*" ${empty dossier.diplome ? 'required' : ''}>
                <c:if test="${not empty dossier.diplome}"><a class="small" target="_blank" href="${ctx}/fichier?dossier=${dossier.id}&type=diplome">Fichier actuel</a></c:if></div>
            <div class="col-md-4"><label class="form-label">Acte de naissance</label>
                <input type="file" name="acte" class="form-control" accept=".pdf,image/*" ${empty dossier.acteNaissance ? 'required' : ''}>
                <c:if test="${not empty dossier.acteNaissance}"><a class="small" target="_blank" href="${ctx}/fichier?dossier=${dossier.id}&type=acte">Fichier actuel</a></c:if></div>
            <div class="col-12"><small class="text-muted">Formats : image ou PDF, 5 Mo maximum par fichier.</small></div>
            <div class="col-12"><button class="btn btn-primary">Déposer le dossier</button></div>
        </form>
    </div></div>
</c:otherwise>
</c:choose>
<%@ include file="/WEB-INF/views/commun/footer.jspf" %>
