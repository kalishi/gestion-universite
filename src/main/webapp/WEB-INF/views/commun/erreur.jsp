<%@ page isErrorPage="true" %>
<%@ include file="/WEB-INF/views/commun/header.jspf" %>
<div class="text-center mt-5">
    <h1 class="display-5">Oups !</h1>
    <p class="lead">
        <c:choose>
            <c:when test="${pageContext.errorData.statusCode == 403}">Vous n'avez pas accès à cette page.</c:when>
            <c:when test="${pageContext.errorData.statusCode == 404}">Page introuvable.</c:when>
            <c:otherwise>Une erreur est survenue.</c:otherwise>
        </c:choose>
    </p>
    <a class="btn btn-primary" href="${ctx}/">Retour à l'accueil</a>
</div>
<%@ include file="/WEB-INF/views/commun/footer.jspf" %>
