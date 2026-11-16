<%@ include file="/WEB-INF/views/commun/header.jspf" %>
<div class="row g-3 mb-3">
    <div class="col-sm-6 col-xl-3"><div class="card h-100"><div class="card-body kpi">
        <span class="kpi-icon tone-primary"><i class="bi bi-people"></i></span>
        <div><div class="kpi-label">Étudiants</div><div class="kpi-value">${nbEtudiants}</div><div class="kpi-sub">${valides} admis</div></div>
    </div></div></div>
    <div class="col-sm-6 col-xl-3"><div class="card h-100"><div class="card-body kpi">
        <span class="kpi-icon tone-info"><i class="bi bi-person-badge"></i></span>
        <div><div class="kpi-label">Professeurs</div><div class="kpi-value">${nbProfesseurs}</div><div class="kpi-sub">${nbCours} cours au catalogue</div></div>
    </div></div></div>
    <div class="col-sm-6 col-xl-3"><div class="card h-100"><div class="card-body kpi">
        <span class="kpi-icon tone-success"><i class="bi bi-bank"></i></span>
        <div><div class="kpi-label">Facultés</div><div class="kpi-value">${nbFacultes}</div><div class="kpi-sub">${nbProgrammes} programmes</div></div>
    </div></div></div>
    <div class="col-sm-6 col-xl-3"><div class="card h-100"><div class="card-body kpi">
        <span class="kpi-icon tone-accent"><i class="bi bi-hourglass-split"></i></span>
        <div><div class="kpi-label">Admissions en attente</div><div class="kpi-value">${enAttente}</div>
            <a class="kpi-sub" href="${ctx}/admin/dossiers?statut=EN_ATTENTE">Examiner les dossiers <i class="bi bi-arrow-right"></i></a></div>
    </div></div></div>
</div>

<div class="row g-3 mb-3">
    <div class="col-lg-8">
        <div class="card h-100">
            <div class="card-header"><h2>Étudiants admis par faculté</h2><span class="small text-muted">Dossiers validés</span></div>
            <div class="card-body"><div class="chart-box" style="height:340px"><canvas id="chartFacultes" role="img" aria-label="Nombre d'étudiants admis par faculté"></canvas></div></div>
        </div>
    </div>
    <div class="col-lg-4">
        <div class="card h-100">
            <div class="card-header"><h2>Frais de scolarité</h2><span class="badge-soft badge-primary">${tauxRecouvrement} % encaissé</span></div>
            <div class="card-body">
                <ul class="list-clean mb-3">
                    <li><span class="text-muted">Attendus (admis)</span><strong><fmt:formatNumber value="${fraisAttendus}" maxFractionDigits="0"/> HTG</strong></li>
                    <li><span class="text-muted">Encaissés</span><strong class="text-success"><fmt:formatNumber value="${totalEncaisse}" maxFractionDigits="0"/> HTG</strong></li>
                    <li><span class="text-muted">Reste à recouvrer</span><strong class="text-danger"><fmt:formatNumber value="${resteARecouvrer}" maxFractionDigits="0"/> HTG</strong></li>
                </ul>
                <div class="progress" role="progressbar" aria-label="Taux de recouvrement" aria-valuenow="${tauxRecouvrement}" aria-valuemin="0" aria-valuemax="100">
                    <div class="progress-bar" style="width:${tauxRecouvrement}%"></div>
                </div>
                <hr>
                <div class="chart-box" style="height:170px"><canvas id="chartStatuts" role="img" aria-label="Répartition des dossiers par statut"></canvas></div>
            </div>
        </div>
    </div>
</div>

<div class="row g-3">
    <div class="col-lg-8">
        <div class="card h-100">
            <div class="card-header"><h2>Derniers dossiers d'admission</h2><a href="${ctx}/admin/dossiers" class="btn btn-sm btn-outline-primary">Tout voir</a></div>
            <div class="table-responsive">
                <table class="table table-unaf table-hover">
                    <thead><tr><th>Étudiant</th><th>Programme</th><th>Déposé le</th><th>Statut</th><th></th></tr></thead>
                    <tbody>
                    <c:forEach var="d" items="${dossiersRecents}">
                        <tr><td><div class="cell-title"><c:out value="${d.etudiant.nomComplet}"/></div><div class="cell-sub"><c:out value="${d.etudiant.email}"/></div></td>
                            <td><div><c:out value="${d.programme.nom}"/></div><div class="cell-sub"><c:out value="${d.programme.faculte.nom}"/></div></td>
                            <td class="text-nowrap">${d.dateDepot}</td>
                            <td><%@ include file="/WEB-INF/views/commun/badge-statut.jspf" %></td>
                            <td class="actions"><a class="btn btn-sm btn-ghost" href="${ctx}/admin/dossiers?id=${d.id}" aria-label="Ouvrir le dossier"><i class="bi bi-chevron-right"></i></a></td></tr>
                    </c:forEach>
                    <c:if test="${empty dossiersRecents}"><tr><td colspan="5"><div class="empty-state"><i class="bi bi-inbox"></i>Aucun dossier pour le moment.</div></td></tr></c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="col-lg-4">
        <div class="card mb-3">
            <div class="card-header"><h2>Session académique</h2><a href="${ctx}/admin/sessions" class="small">Gérer</a></div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${not empty sessionActive}">
                        <div class="d-flex align-items-center gap-2 mb-1"><span class="badge-soft badge-success">Ouverte</span></div>
                        <div class="h5 mb-1"><c:out value="${sessionActive.libelle}"/></div>
                        <div class="small text-muted">Du ${sessionActive.dateDebut} au ${sessionActive.dateFin}</div>
                    </c:when>
                    <c:otherwise><div class="alert alert-warning mb-0"><i class="bi bi-exclamation-triangle"></i><div>Aucune session ouverte : les étudiants ne peuvent pas choisir de cours.</div></div></c:otherwise>
                </c:choose>
                <div class="chart-box mt-3" style="height:150px"><canvas id="chartCours" role="img" aria-label="Inscriptions aux cours par faculté pour la session"></canvas></div>
            </div>
        </div>
        <div class="card">
            <div class="card-header"><h2>Actions rapides</h2></div>
            <div class="card-body d-grid gap-2">
                <a class="btn btn-outline-primary justify-content-start" href="${ctx}/admin/cours"><i class="bi bi-journal-plus"></i> Ajouter un cours</a>
                <a class="btn btn-outline-primary justify-content-start" href="${ctx}/admin/programmes"><i class="bi bi-diagram-3"></i> Ouvrir un programme</a>
                <a class="btn btn-outline-primary justify-content-start" href="${ctx}/admin/professeurs"><i class="bi bi-person-plus"></i> Créer un compte professeur</a>
                <c:if test="${coursSansProf > 0}">
                    <div class="alert alert-warning mb-0 mt-1 small"><i class="bi bi-person-exclamation"></i><div>${coursSansProf} cours sans professeur affecté.</div></div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<script src="${ctx}/assets/vendor/chartjs/chart.umd.min.js"></script>
<script>
(function () {
  Chart.defaults.font.family = "'Source Sans 3', system-ui, sans-serif";
  Chart.defaults.color = '#475569';
  var noData = { id: 'noData', afterDraw: function (c) {
      var d = c.data.datasets[0].data; if (d.length && d.some(function (v) { return v > 0; })) return;
      var a = c.chartArea, x = c.ctx; x.save(); x.textAlign = 'center'; x.fillStyle = '#94A3B8';
      x.fillText('Aucune donnée', (a.left + a.right) / 2, (a.top + a.bottom) / 2); x.restore(); } };
  new Chart(document.getElementById('chartFacultes'), {
    type: 'bar',
    data: { labels: ${chartFacLabels}, datasets: [{ label: 'Étudiants admis', data: ${chartFacValues}, backgroundColor: '#1E40AF', borderRadius: 6, maxBarThickness: 42 }] },
    options: { maintainAspectRatio: false, plugins: { legend: { display: false } },
      scales: { y: { beginAtZero: true, ticks: { precision: 0 }, grid: { color: '#EEF2F7' } },
                x: { grid: { display: false }, ticks: { callback: function (v) { var l = this.getLabelForValue(v).replace('Faculté des ', '').replace('Faculté de ', '').replace("Faculté d'", ''); return l.length > 18 ? l.slice(0, 17) + '…' : l; } } } } },
    plugins: [noData]
  });
  new Chart(document.getElementById('chartStatuts'), {
    type: 'doughnut',
    data: { labels: ['En attente', 'Validés', 'Rejetés'], datasets: [{ data: ${chartStatutValues}, backgroundColor: ['#D97706', '#15803D', '#DC2626'], borderWidth: 2, borderColor: '#fff' }] },
    options: { maintainAspectRatio: false, cutout: '62%', plugins: { legend: { position: 'right', labels: { boxWidth: 12 } } } },
    plugins: [noData]
  });
  new Chart(document.getElementById('chartCours'), {
    type: 'bar',
    data: { labels: ${chartCoursLabels}, datasets: [{ label: 'Inscriptions aux cours', data: ${chartCoursValues}, backgroundColor: '#3B82F6', borderRadius: 4 }] },
    options: { indexAxis: 'y', maintainAspectRatio: false, plugins: { legend: { display: false } },
      scales: { x: { beginAtZero: true, ticks: { precision: 0 } }, y: { ticks: { callback: function (v) { var l = this.getLabelForValue(v).replace(/^Faculté (des |de |d')/, ''); return l.length > 16 ? l.slice(0, 15) + '…' : l; } } } } },
    plugins: [noData]
  });
})();
</script>
<%@ include file="/WEB-INF/views/commun/footer.jspf" %>
