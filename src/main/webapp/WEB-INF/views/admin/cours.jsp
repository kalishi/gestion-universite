<%@ include file="/WEB-INF/views/commun/header.jspf" %>
<div class="card mb-3">
    <div class="card-header">
        <h2>${empty edition ? 'Nouveau cours' : 'Modifier le cours '}<c:if test="${not empty edition}"><span class="code-tag ms-1">${edition.code}</span></c:if></h2>
        <c:if test="${empty edition}"><button class="btn btn-sm btn-outline-primary" type="button" data-bs-toggle="collapse" data-bs-target="#formCours" aria-expanded="false" aria-controls="formCours"><i class="bi bi-plus-lg"></i> Ajouter</button></c:if>
    </div>
    <div class="collapse ${empty edition ? '' : 'show'}" id="formCours">
    <div class="card-body">
        <form method="post" data-loading>
            <input type="hidden" name="id" value="${edition.id}">
            <div class="form-section-title mt-0">Identification</div>
            <div class="row g-3">
                <div class="col-md-2"><label class="form-label" for="code">Code<span class="req">*</span></label><input id="code" name="code" class="form-control" placeholder="INF101" value="<c:out value='${edition.code}'/>" required></div>
                <div class="col-md-6"><label class="form-label" for="intitule">Intitulé<span class="req">*</span></label><input id="intitule" name="intitule" class="form-control" value="<c:out value='${edition.intitule}'/>" required></div>
                <div class="col-md-1"><label class="form-label" for="credits">Crédits</label><input type="number" id="credits" name="credits" class="form-control" min="1" value="${empty edition ? 3 : edition.credits}"></div>
                <div class="col-md-3"><label class="form-label" for="programmeId">Programme<span class="req">*</span></label>
                    <select id="programmeId" name="programmeId" class="form-select" required>
                        <c:forEach var="p" items="${programmes}"><option value="${p.id}" ${edition.programme.id == p.id ? 'selected' : ''}><c:out value="${p.nom}"/></option></c:forEach>
                    </select></div>
            </div>
            <div class="form-section-title">Enseignant, salle et horaire</div>
            <div class="row g-3">
                <div class="col-md-4"><label class="form-label" for="professeurId">Professeur</label>
                    <select id="professeurId" name="professeurId" class="form-select">
                        <option value="">— Non affecté —</option>
                        <c:forEach var="pr" items="${professeurs}"><option value="${pr.id}" ${edition.professeur.id == pr.id ? 'selected' : ''}><c:out value="${pr.nomComplet}"/></option></c:forEach>
                    </select></div>
                <div class="col-md-2"><label class="form-label" for="salleId">Salle</label>
                    <select id="salleId" name="salleId" class="form-select">
                        <option value="">—</option>
                        <c:forEach var="s" items="${salles}"><option value="${s.id}" ${edition.salle.id == s.id ? 'selected' : ''}><c:out value="${s.nom}"/></option></c:forEach>
                    </select></div>
                <div class="col-md-2"><label class="form-label" for="jour">Jour</label>
                    <select id="jour" name="jour" class="form-select">
                        <option value="">—</option>
                        <c:forEach var="j" items="${jours}"><option ${edition.jour == j ? 'selected' : ''}>${j}</option></c:forEach>
                    </select></div>
                <div class="col-6 col-md-2"><label class="form-label" for="heureDebut">Début</label><input type="time" id="heureDebut" name="heureDebut" class="form-control" value="${edition.heureDebut}"></div>
                <div class="col-6 col-md-2"><label class="form-label" for="heureFin">Fin</label><input type="time" id="heureFin" name="heureFin" class="form-control" value="${edition.heureFin}"></div>
                <div class="col-md-6"><label class="form-label" for="prerequis">Prérequis</label>
                    <select id="prerequis" name="prerequis" class="form-select" multiple size="4" aria-describedby="preAide">
                        <c:forEach var="pc" items="${coursListe}">
                            <c:if test="${pc.id != edition.id}"><option value="${pc.id}" ${edition.prerequis.contains(pc) ? 'selected' : ''}>${pc.code} — <c:out value="${pc.intitule}"/></option></c:if>
                        </c:forEach>
                    </select>
                    <div id="preAide" class="form-text">Maintenez Ctrl pour en sélectionner plusieurs. L'étudiant devra les avoir réussis.</div></div>
            </div>
            <div class="d-flex gap-2 mt-4">
                <button type="submit" class="btn btn-primary"><i class="bi bi-check2"></i> Enregistrer le cours</button>
                <a href="${ctx}/admin/cours" class="btn btn-ghost">Annuler</a>
            </div>
        </form>
    </div>
    </div>
</div>

<div class="card">
    <div class="table-toolbar">
        <div class="search-input"><i class="bi bi-search"></i><input type="search" class="form-control" placeholder="Code, intitulé, programme, professeur…" aria-label="Rechercher un cours" data-filter-table="#tbl" data-filter-count="#nbCours"></div>
        <span class="small text-muted"><span id="nbCours">${coursListe.size()}</span> cours</span>
    </div>
    <div class="table-responsive">
        <table class="table table-unaf table-hover" id="tbl">
            <thead><tr><th>Cours</th><th>Programme</th><th class="num">Crédits</th><th>Professeur</th><th>Horaire</th><th>Prérequis</th><th class="actions">Actions</th></tr></thead>
            <tbody>
            <c:forEach var="c" items="${coursListe}">
                <tr data-row>
                    <td><span class="code-tag">${c.code}</span><div class="cell-title mt-1"><c:out value="${c.intitule}"/></div></td>
                    <td><div><c:out value="${c.programme.nom}"/></div><div class="cell-sub"><c:out value="${c.programme.faculte.nom}"/></div></td>
                    <td class="num">${c.credits}</td>
                    <td><c:choose><c:when test="${not empty c.professeur}"><c:out value="${c.professeur.nomComplet}"/></c:when>
                        <c:otherwise><span class="badge-soft badge-warning">Non affecté</span></c:otherwise></c:choose></td>
                    <td class="text-nowrap"><div>${c.horaire}</div><div class="cell-sub"><c:out value="${c.salle.nom}"/></div></td>
                    <td><c:forEach var="pr" items="${c.prerequis}"><span class="code-tag me-1">${pr.code}</span></c:forEach><c:if test="${empty c.prerequis}"><span class="text-muted">—</span></c:if></td>
                    <td class="actions"><a class="btn btn-sm btn-ghost" href="?modifier=${c.id}" aria-label="Modifier"><i class="bi bi-pencil"></i></a><form method="post" class="d-inline" data-confirm="Supprimer cet élément ? Cette action est définitive."><input type="hidden" name="action" value="supprimer"><input type="hidden" name="id" value="${c.id}"><button class="btn btn-sm btn-ghost text-danger" aria-label="Supprimer"><i class="bi bi-trash"></i></button></form></td></tr>
            </c:forEach>
            <c:if test="${empty coursListe}"><tr><td colspan="7"><div class="empty-state"><i class="bi bi-journal"></i>Aucun cours au catalogue.</div></td></tr></c:if>
            </tbody>
        </table>
    </div>
</div>
<%@ include file="/WEB-INF/views/commun/footer.jspf" %>
