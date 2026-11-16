<%@ include file="/WEB-INF/views/commun/header.jspf" %>
<c:set var="d" value="${dossier}"/>
<nav aria-label="Fil d'Ariane" class="mb-3"><ol class="breadcrumb small"><li class="breadcrumb-item"><a href="${ctx}/admin/dossiers">Admissions</a></li><li class="breadcrumb-item active" aria-current="page"><c:out value="${d.etudiant.nomComplet}"/></li></ol></nav>
<div class="row g-3">
    <div class="col-lg-7">
        <div class="card mb-3">
            <div class="card-body d-flex flex-wrap align-items-center gap-3">
                <span class="avatar" style="width:56px;height:56px;font-size:1.2rem"><c:out value="${d.etudiant.prenom.substring(0,1)}${d.etudiant.nom.substring(0,1)}"/></span>
                <div class="me-auto">
                    <div class="h5 mb-0"><c:out value="${d.etudiant.nomComplet}"/></div>
                    <div class="text-muted small"><c:out value="${d.etudiant.email}"/></div>
                </div>
                <%@ include file="/WEB-INF/views/commun/badge-statut.jspf" %>
            </div>
        </div>
        <div class="card mb-3">
            <div class="card-header"><h2>Informations du dossier</h2></div>
            <div class="card-body">
                <dl class="row mb-0">
                    <dt class="col-sm-4 text-muted fw-semibold">Faculté</dt><dd class="col-sm-8"><c:out value="${d.programme.faculte.nom}"/></dd>
                    <dt class="col-sm-4 text-muted fw-semibold">Programme</dt><dd class="col-sm-8"><c:out value="${d.programme.nom}"/></dd>
                    <dt class="col-sm-4 text-muted fw-semibold">Date de naissance</dt><dd class="col-sm-8">${empty d.dateNaissance ? '—' : d.dateNaissance}</dd>
                    <dt class="col-sm-4 text-muted fw-semibold">Téléphone</dt><dd class="col-sm-8"><c:out value="${empty d.telephone ? '—' : d.telephone}"/></dd>
                    <dt class="col-sm-4 text-muted fw-semibold">Adresse</dt><dd class="col-sm-8"><c:out value="${empty d.adresse ? '—' : d.adresse}"/></dd>
                    <dt class="col-sm-4 text-muted fw-semibold">Déposé le</dt><dd class="col-sm-8 mb-0">${d.dateDepot}</dd>
                </dl>
            </div>
        </div>
        <div class="card mb-3">
            <div class="card-header"><h2>Pièces justificatives</h2></div>
            <div class="card-body d-flex flex-wrap gap-2">
                <c:if test="${not empty d.photo}"><a target="_blank" rel="noopener" class="doc-chip" href="${ctx}/fichier?dossier=${d.id}&type=photo"><i class="bi bi-person-square"></i> Photo d'identité</a></c:if>
                <c:if test="${not empty d.diplome}"><a target="_blank" rel="noopener" class="doc-chip" href="${ctx}/fichier?dossier=${d.id}&type=diplome"><i class="bi bi-file-earmark-text"></i> Diplôme</a></c:if>
                <c:if test="${not empty d.acteNaissance}"><a target="_blank" rel="noopener" class="doc-chip" href="${ctx}/fichier?dossier=${d.id}&type=acte"><i class="bi bi-file-earmark-text"></i> Acte de naissance</a></c:if>
                <c:if test="${empty d.photo and empty d.diplome and empty d.acteNaissance}"><span class="text-muted">Aucune pièce jointe (dossier de démonstration).</span></c:if>
            </div>
        </div>
        <div class="card">
            <div class="card-header"><h2>Décision</h2></div>
            <div class="card-body d-flex flex-wrap gap-2">
                <form method="post"><input type="hidden" name="id" value="${d.id}"><input type="hidden" name="action" value="valider">
                    <button class="btn btn-primary" ${d.statut == 'VALIDE' ? 'disabled' : ''}><i class="bi bi-check-lg"></i> Valider l'admission</button></form>
                <form method="post" data-confirm="Rejeter ce dossier ? L'étudiant devra le corriger."><input type="hidden" name="id" value="${d.id}"><input type="hidden" name="action" value="rejeter">
                    <button class="btn btn-outline-danger" ${d.statut == 'REJETE' ? 'disabled' : ''}><i class="bi bi-x-lg"></i> Rejeter</button></form>
            </div>
        </div>
    </div>
    <div class="col-lg-5">
        <div class="card">
            <div class="card-header"><h2>Frais de scolarité</h2><span class="badge-soft ${solde > 0 ? 'badge-danger' : 'badge-success'}">${solde > 0 ? 'Solde dû' : 'Soldé'}</span></div>
            <div class="card-body">
                <div class="row text-center g-2 mb-3">
                    <div class="col-4"><div class="kpi-label">Montant</div><div class="fw-bold"><fmt:formatNumber value="${d.programme.fraisScolarite}" maxFractionDigits="0"/></div></div>
                    <div class="col-4"><div class="kpi-label">Payé</div><div class="fw-bold text-success"><fmt:formatNumber value="${totalPaye}" maxFractionDigits="0"/></div></div>
                    <div class="col-4"><div class="kpi-label">Solde</div><div class="fw-bold ${solde > 0 ? 'text-danger' : 'text-success'}"><fmt:formatNumber value="${solde}" maxFractionDigits="0"/></div></div>
                </div>
                <div class="progress mb-4" role="progressbar" aria-label="Part payée"><div class="progress-bar" style="width:${d.programme.fraisScolarite == 0 ? 100 : totalPaye * 100 / d.programme.fraisScolarite}%"></div></div>
                <form method="post" data-loading>
                    <input type="hidden" name="id" value="${d.id}"><input type="hidden" name="action" value="paiement">
                    <label class="form-label" for="montant">Enregistrer un paiement (HTG)</label>
                    <div class="input-group">
                        <input type="number" step="0.01" min="1" id="montant" name="montant" class="form-control" placeholder="Montant" required>
                        <button type="submit" class="btn btn-primary"><i class="bi bi-plus-lg"></i> Ajouter</button>
                    </div>
                    <div class="form-text">Les paiements partiels sont acceptés.</div>
                </form>
            </div>
            <div class="table-responsive">
                <table class="table table-unaf">
                    <thead><tr><th>Date</th><th class="num">Montant</th><th class="actions"></th></tr></thead>
                    <tbody>
                    <c:forEach var="p" items="${paiements}">
                        <tr><td>${p.datePaiement}</td><td class="num"><fmt:formatNumber value="${p.montant}" maxFractionDigits="2"/> HTG</td>
                            <td class="actions"><form method="post" class="d-inline" data-confirm="Supprimer ce paiement ?">
                                <input type="hidden" name="id" value="${d.id}"><input type="hidden" name="action" value="supprimerPaiement">
                                <input type="hidden" name="paiementId" value="${p.id}"><button class="btn btn-sm btn-ghost text-danger" aria-label="Supprimer le paiement"><i class="bi bi-trash"></i></button></form></td></tr>
                    </c:forEach>
                    <c:if test="${empty paiements}"><tr><td colspan="3"><div class="empty-state py-3">Aucun paiement enregistré.</div></td></tr></c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/views/commun/footer.jspf" %>
