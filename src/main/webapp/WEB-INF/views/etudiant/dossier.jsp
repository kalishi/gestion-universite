<%@ include file="/WEB-INF/views/commun/header.jspf" %>
<c:choose>
<c:when test="${dossier.statut == 'VALIDE'}">
    <div class="alert alert-success"><i class="bi bi-check-circle-fill"></i><div>Votre admission est <strong>validée</strong>. Vous pouvez <a href="${ctx}/etudiant/cours">choisir vos cours</a>.</div></div>
    <div class="card">
        <div class="card-header"><h2>Mon dossier</h2></div>
        <div class="card-body">
            <dl class="row mb-0">
                <dt class="col-sm-3 text-muted fw-semibold">Faculté</dt><dd class="col-sm-9"><c:out value="${dossier.programme.faculte.nom}"/></dd>
                <dt class="col-sm-3 text-muted fw-semibold">Programme</dt><dd class="col-sm-9"><c:out value="${dossier.programme.nom}"/></dd>
                <dt class="col-sm-3 text-muted fw-semibold">Date de naissance</dt><dd class="col-sm-9">${dossier.dateNaissance}</dd>
                <dt class="col-sm-3 text-muted fw-semibold">Téléphone</dt><dd class="col-sm-9"><c:out value="${dossier.telephone}"/></dd>
                <dt class="col-sm-3 text-muted fw-semibold">Adresse</dt><dd class="col-sm-9 mb-0"><c:out value="${dossier.adresse}"/></dd>
            </dl>
        </div>
    </div>
</c:when>
<c:otherwise>
    <c:if test="${dossier.statut == 'EN_ATTENTE'}"><div class="alert alert-info"><i class="bi bi-hourglass-split"></i><div>Dossier déposé le ${dossier.dateDepot}, <strong>en cours d'examen</strong>. Vous pouvez encore le modifier.</div></div></c:if>
    <c:if test="${dossier.statut == 'REJETE'}"><div class="alert alert-danger"><i class="bi bi-x-octagon-fill"></i><div>Votre dossier a été <strong>rejeté</strong>. Corrigez-le puis déposez-le à nouveau.</div></div></c:if>
    <form method="post" enctype="multipart/form-data" data-loading>
        <div class="card mb-3">
            <div class="card-header"><h2>1. Formation demandée</h2></div>
            <div class="card-body">
                <label class="form-label" for="programmeId">Faculté et programme<span class="req">*</span></label>
                <select id="programmeId" name="programmeId" class="form-select" required>
                    <option value="">— Choisir un programme —</option>
                    <c:set var="facCourante" value=""/>
                    <c:forEach var="p" items="${programmes}">
                        <option value="${p.id}" ${dossier.programme.id == p.id ? 'selected' : ''}><c:out value="${p.faculte.nom}"/> — <c:out value="${p.nom}"/></option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="card mb-3">
            <div class="card-header"><h2>2. Informations personnelles</h2></div>
            <div class="card-body row g-3">
                <div class="col-md-4"><label class="form-label" for="dateNaissance">Date de naissance<span class="req">*</span></label>
                    <input type="date" id="dateNaissance" name="dateNaissance" class="form-control" value="${dossier.dateNaissance}" required></div>
                <div class="col-md-4"><label class="form-label" for="telephone">Téléphone<span class="req">*</span></label>
                    <input type="tel" id="telephone" name="telephone" class="form-control" placeholder="+509 …" autocomplete="tel" value="<c:out value='${dossier.telephone}'/>" required></div>
                <div class="col-md-12"><label class="form-label" for="adresse">Adresse<span class="req">*</span></label>
                    <input id="adresse" name="adresse" class="form-control" autocomplete="street-address" value="<c:out value='${dossier.adresse}'/>" required></div>
            </div>
        </div>
        <div class="card mb-3">
            <div class="card-header"><h2>3. Pièces justificatives</h2><span class="small text-muted">Image ou PDF, 5 Mo max.</span></div>
            <div class="card-body row g-3">
                <div class="col-md-4"><label class="form-label" for="photo">Photo d'identité<span class="req">*</span></label>
                    <input type="file" id="photo" name="photo" class="form-control" accept="image/*" ${empty dossier.photo ? 'required' : ''}>
                    <c:if test="${not empty dossier.photo}"><a class="form-text d-inline-block" target="_blank" href="${ctx}/fichier?dossier=${dossier.id}&type=photo"><i class="bi bi-paperclip"></i> Fichier déjà envoyé</a></c:if></div>
                <div class="col-md-4"><label class="form-label" for="diplome">Diplôme<span class="req">*</span></label>
                    <input type="file" id="diplome" name="diplome" class="form-control" accept=".pdf,image/*" ${empty dossier.diplome ? 'required' : ''}>
                    <c:if test="${not empty dossier.diplome}"><a class="form-text d-inline-block" target="_blank" href="${ctx}/fichier?dossier=${dossier.id}&type=diplome"><i class="bi bi-paperclip"></i> Fichier déjà envoyé</a></c:if></div>
                <div class="col-md-4"><label class="form-label" for="acte">Acte de naissance<span class="req">*</span></label>
                    <input type="file" id="acte" name="acte" class="form-control" accept=".pdf,image/*" ${empty dossier.acteNaissance ? 'required' : ''}>
                    <c:if test="${not empty dossier.acteNaissance}"><a class="form-text d-inline-block" target="_blank" href="${ctx}/fichier?dossier=${dossier.id}&type=acte"><i class="bi bi-paperclip"></i> Fichier déjà envoyé</a></c:if></div>
            </div>
        </div>
        <div class="d-flex justify-content-end"><button type="submit" class="btn btn-primary btn-lg"><i class="bi bi-send"></i> Déposer mon dossier</button></div>
    </form>
</c:otherwise>
</c:choose>
<%@ include file="/WEB-INF/views/commun/footer.jspf" %>
