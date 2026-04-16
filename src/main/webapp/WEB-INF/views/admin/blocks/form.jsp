<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="pageTitle" value="${blockId != null ? 'Editar Bloco' : 'Novo Bloco'}" scope="request"/>
<jsp:include page="/WEB-INF/views/layouts/header.jsp"/>

<div class="row justify-content-center">
    <div class="col-md-5">
        <div class="card border-0 shadow-sm">
            <div class="card-body p-4">
                <h5 class="card-title mb-4">
                    <c:choose>
                        <c:when test="${blockId != null}">Editar Bloco</c:when>
                        <c:otherwise>Novo Bloco</c:otherwise>
                    </c:choose>
                </h5>

                <c:set var="formAction"
                       value="${blockId != null ?
                            pageContext.request.contextPath.concat('/admin/blocks/').concat(blockId).concat('/edit') :
                            pageContext.request.contextPath.concat('/admin/blocks')}"/>

                <form:form method="post" action="${formAction}" modelAttribute="blockForm">
                    <div class="mb-3">
                        <label class="form-label fw-semibold small">Nome do bloco</label>
                        <form:input path="name" cssClass="form-control" placeholder="Ex: A, B, Torre 1"/>
                        <form:errors path="name" cssClass="text-danger small"/>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold small">Número de andares</label>
                        <form:input path="floors" type="number" cssClass="form-control" placeholder="Ex: 10"
                                   readonly="${blockId != null}"/>
                        <form:errors path="floors" cssClass="text-danger small"/>
                        <c:if test="${blockId != null}">
                            <div class="form-text text-warning">
                                <i class="bi bi-exclamation-triangle me-1"></i>
                                Alterar andares não recria as unidades existentes.
                            </div>
                        </c:if>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-semibold small">Unidades por andar</label>
                        <form:input path="unitsPerFloor" type="number" cssClass="form-control" placeholder="Ex: 4"
                                   readonly="${blockId != null}"/>
                        <form:errors path="unitsPerFloor" cssClass="text-danger small"/>
                    </div>

                    <c:if test="${blockId == null}">
                        <div class="alert alert-info small py-2 mb-4">
                            <i class="bi bi-info-circle me-1"></i>
                            As unidades serão geradas automaticamente (ex: <strong>A-101</strong>, <strong>A-102</strong>…).
                        </div>
                    </c:if>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary">Salvar</button>
                        <a href="${pageContext.request.contextPath}/admin/blocks"
                           class="btn btn-outline-secondary">Cancelar</a>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/layouts/footer.jsp"/>
