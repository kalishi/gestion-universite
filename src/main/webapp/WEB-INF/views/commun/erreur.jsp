<%@ page isErrorPage="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="titre" value="Erreur"/>
<%@ include file="/WEB-INF/views/commun/header.jspf" %>
<div class="d-flex align-items-center justify-content-center" style="min-height:60vh">
    <div class="text-center">
        <div class="kpi-icon tone-danger mx-auto mb-3"><i class="bi bi-exclamation-triangle"></i></div>
        <h2 class="h3">
            <c:choose>
                <c:when test="${pageContext.errorData.statusCode == 403}">Accès refusé</c:when>
                <c:when test="${pageContext.errorData.statusCode == 404}">Page introuvable</c:when>
                <c:otherwise>Une erreur est survenue</c:otherwise>
            </c:choose>
        </h2>
        <p class="text-muted">
            <c:choose>
                <c:when test="${pageContext.errorData.statusCode == 403}">Cette page n'est pas disponible pour votre profil.</c:when>
                <c:when test="${pageContext.errorData.statusCode == 404}">L'adresse demandée n'existe pas.</c:when>
                <c:otherwise>Réessayez dans un instant. Si le problème continue, contactez l'administration.</c:otherwise>
            </c:choose>
        </p>
        <a class="btn btn-primary" href="${ctx}/"><i class="bi bi-house"></i> Retour à l'accueil</a>
    </div>
</div>
<%@ include file="/WEB-INF/views/commun/footer.jspf" %>
