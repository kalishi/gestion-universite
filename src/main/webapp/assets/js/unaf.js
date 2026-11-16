/* UNAF – petites interactions (sans dépendance réseau) */
(function () {
  // Menu latéral sur mobile
  var btn = document.querySelector('[data-toggle-sidebar]');
  var side = document.querySelector('.app-sidebar');
  if (btn && side) {
    btn.addEventListener('click', function () { side.classList.toggle('open'); });
    document.addEventListener('click', function (e) {
      if (side.classList.contains('open') && !side.contains(e.target) && !btn.contains(e.target)) side.classList.remove('open');
    });
  }

  // Filtre instantané des tableaux : <input data-filter-table="#idTable">
  document.querySelectorAll('[data-filter-table]').forEach(function (input) {
    var table = document.querySelector(input.getAttribute('data-filter-table'));
    if (!table) return;
    var counter = document.querySelector(input.getAttribute('data-filter-count'));
    input.addEventListener('input', function () {
      var q = input.value.trim().toLowerCase(), visible = 0;
      table.querySelectorAll('tbody tr[data-row]').forEach(function (tr) {
        var show = tr.textContent.toLowerCase().indexOf(q) !== -1;
        tr.style.display = show ? '' : 'none';
        if (show) visible++;
      });
      if (counter) counter.textContent = visible;
    });
  });

  // Confirmation des suppressions : <form data-confirm="Message">
  document.querySelectorAll('form[data-confirm]').forEach(function (f) {
    f.addEventListener('submit', function (e) { if (!confirm(f.getAttribute('data-confirm'))) e.preventDefault(); });
  });

  // Retour visuel à l'envoi des formulaires
  document.querySelectorAll('form[data-loading]').forEach(function (f) {
    f.addEventListener('submit', function () {
      var b = f.querySelector('button[type="submit"], button:not([type])');
      if (b) { b.disabled = true; b.insertAdjacentHTML('afterbegin', '<span class="spinner-border spinner-border-sm" aria-hidden="true"></span>'); }
    });
  });

  // Calcul en direct de la note finale (page professeur)
  document.querySelectorAll('tr[data-note-row]').forEach(function (tr) {
    var inputs = tr.querySelectorAll('input.note'), out = tr.querySelector('[data-note-final]');
    function calc() {
      var v = Array.prototype.map.call(inputs, function (i) { return i.value === '' ? null : parseFloat(i.value.replace(',', '.')); });
      if (v.some(function (x) { return x === null || isNaN(x); })) { out.textContent = '—'; return; }
      out.textContent = (v[0] * 0.3 + v[1] * 0.4 + v[2] * 0.3).toFixed(2);
    }
    inputs.forEach(function (i) { i.addEventListener('input', calc); });
  });

  // Fermeture automatique des messages de succès
  document.querySelectorAll('.alert-success[data-autoclose]').forEach(function (a) {
    setTimeout(function () { a.style.transition = 'opacity .3s'; a.style.opacity = '0'; setTimeout(function () { a.remove(); }, 300); }, 5000);
  });
})();
