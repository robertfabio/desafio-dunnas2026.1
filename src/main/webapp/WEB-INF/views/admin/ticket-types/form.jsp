<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="pageTitle" value="${typeId != null ? 'Editar Tipo' : 'Novo Tipo de Chamado'}" scope="request"/>
<jsp:include page="/WEB-INF/views/layouts/header.jsp"/>

<div class="row justify-content-center">
    <div class="col-md-5">
        <div class="card border-0 shadow-sm">
            <div class="card-body p-4">
                <h5 class="card-title mb-4">
                    <c:choose>
                        <c:when test="${typeId != null}">Editar Tipo de Chamado</c:when>
                        <c:otherwise>Novo Tipo de Chamado</c:otherwise>
                    </c:choose>
                </h5>

                <c:set var="formAction"
                       value="${typeId != null ?
                            pageContext.request.contextPath.concat('/admin/ticket-types/').concat(typeId).concat('/edit') :
                            pageContext.request.contextPath.concat('/admin/ticket-types')}"/>

                <form:form method="post" action="${formAction}" modelAttribute="typeForm">
                    <div class="mb-3">
                        <label class="form-label fw-semibold small">Título</label>
                        <form:input path="title" cssClass="form-control" placeholder="Ex: Manutenção Geral"/>
                        <form:errors path="title" cssClass="text-danger small"/>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-semibold small">SLA (horas)</label>
                        <form:input path="slaHours" type="number" cssClass="form-control" placeholder="Ex: 48"/>
                        <div class="form-text">Prazo máximo para resolução do chamado.</div>
                        <form:errors path="slaHours" cssClass="text-danger small"/>
                    </div>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary">Salvar</button>
                        <a href="${pageContext.request.contextPath}/admin/ticket-types"
                           class="btn btn-outline-secondary">Cancelar</a>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/layouts/footer.jsp"/>
