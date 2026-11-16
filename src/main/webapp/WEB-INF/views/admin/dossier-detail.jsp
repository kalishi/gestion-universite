<%@ include file="/WEB-INF/views/commun/header.jspf" %>
<a href="${ctx}/admin/dossiers" class="btn btn-link px-0 mb-2"><i class="bi bi-arrow-left"></i> Retour aux dossiers</a>
<div class="row g-4">
    <div class="col-lg-6">
        <div class="card shadow-sm"><div class="card-body">
            <div class="d-flex justify-content-between align-items-start">
                <h1 class="h4"><c:out value="${dossier.etudiant.nomComplet}"/></h1>
                <span class="badge fs-6 ${dossier.statut == 'VALIDE' ? 'bg-success' : dossier.statut == 'REJETE' ? 'bg-danger' : 'bg-warning text-dark'}">${dossier.statut}</span>
            </div>
            <dl class="row mb-0">
                <dt class="col-5">Email</dt><dd class="col-7"><c:out value="${dossier.etudiant.email}"/></dd>
                <dt class="col-5">Programme</dt><dd class="col-7"><c:out value="${dossier.programme.nom}"/> (${dossier.programme.niveau})</dd>
                <dt class="col-5">Date de naissance</dt><dd class="col-7">${dossier.dateNaissance}</dd>
                <dt class="col-5">Téléphone</dt><dd class="col-7"><c:out value="${dossier.telephone}"/></dd>
                <dt class="col-5">Adresse</dt><dd class="col-7"><c:out value="${dossier.adresse}"/></dd>
                <dt class="col-5">Déposé le</dt><dd class="col-7">${dossier.dateDepot}</dd>
            </dl>
            <h2 class="h6 mt-3">Pièces jointes</h2>
            <div class="d-flex gap-2 flex-wrap">
                <c:if test="${not empty dossier.photo}"><a target="_blank" class="btn btn-sm btn-outline-secondary" href="${ctx}/fichier?dossier=${dossier.id}&type=photo"><i class="bi bi-image"></i> Photo</a></c:if>
                <c:if test="${not empty dossier.diplome}"><a target="_blank" class="btn btn-sm btn-outline-secondary" href="${ctx}/fichier?dossier=${dossier.id}&type=diplome"><i class="bi bi-file-earmark"></i> Diplôme</a></c:if>
                <c:if test="${not empty dossier.acteNaissance}"><a target="_blank" class="btn btn-sm btn-outline-secondary" href="${ctx}/fichier?dossier=${dossier.id}&type=acte"><i class="bi bi-file-earmark"></i> Acte de naissance</a></c:if>
                <c:if test="${empty dossier.photo and empty dossier.diplome}"><span class="text-muted small">Aucune pièce (dossier de démonstration).</span></c:if>
            </div>
            <hr>
            <form method="post" class="d-inline"><input type="hidden" name="id" value="${dossier.id}"><input type="hidden" name="action" value="valider">
                <button class="btn btn-success" ${dossier.statut == 'VALIDE' ? 'disabled' : ''}><i class="bi bi-check-lg"></i> Valider</button></form>
            <form method="post" class="d-inline"><input type="hidden" name="id" value="${dossier.id}"><input type="hidden" name="action" value="rejeter">
                <button class="btn btn-outline-danger" ${dossier.statut == 'REJETE' ? 'disabled' : ''}><i class="bi bi-x-lg"></i> Rejeter</button></form>
        </div></div>
    </div>
    <div class="col-lg-6">
        <div class="card shadow-sm"><div class="card-body">
            <h2 class="h5">Frais de scolarité</h2>
            <div class="row text-center my-3">
                <div class="col"><div class="text-muted small">Montant</div><div class="fs-5"><fmt:formatNumber value="${dossier.programme.fraisScolarite}" maxFractionDigits="2"/></div></div>
                <div class="col"><div class="text-muted small">Payé</div><div class="fs-5 text-success"><fmt:formatNumber value="${totalPaye}" maxFractionDigits="2"/></div></div>
                <div class="col"><div class="text-muted small">Solde</div><div class="fs-5 ${solde > 0 ? 'text-danger' : 'text-success'}"><fmt:formatNumber value="${solde}" maxFractionDigits="2"/></div></div>
            </div>
            <form method="post" class="input-group mb-3">
                <input type="hidden" name="id" value="${dossier.id}"><input type="hidden" name="action" value="paiement">
                <input type="number" step="0.01" min="1" name="montant" class="form-control" placeholder="Montant du paiement (HTG)" required>
                <button class="btn btn-primary">Ajouter un paiement</button>
            </form>
            <table class="table table-sm">
                <thead><tr><th>Date</th><th class="text-end">Montant</th><th></th></tr></thead>
                <tbody>
                <c:forEach var="p" items="${paiements}">
                    <tr><td>${p.datePaiement}</td><td class="text-end"><fmt:formatNumber value="${p.montant}" maxFractionDigits="2"/> HTG</td>
                        <td class="text-end"><form method="post" class="d-inline" onsubmit="return confirm('Supprimer ce paiement ?')">
                            <input type="hidden" name="id" value="${dossier.id}"><input type="hidden" name="action" value="supprimerPaiement">
                            <input type="hidden" name="paiementId" value="${p.id}"><button class="btn btn-sm btn-link text-danger p-0"><i class="bi bi-trash"></i></button></form></td></tr>
                </c:forEach>
                <c:if test="${empty paiements}"><tr><td colspan="3" class="text-muted">Aucun paiement.</td></tr></c:if>
                </tbody>
            </table>
        </div></div>
    </div>
</div>
<%@ include file="/WEB-INF/views/commun/footer.jspf" %>
