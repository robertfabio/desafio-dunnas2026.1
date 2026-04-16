<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="pageTitle" value="${statusId != null ? 'Editar Status' : 'Novo Status'}" scope="request"/>
<jsp:include page="/WEB-INF/views/layouts/header.jsp"/>

<div class="row justify-content-center">
    <div class="col-md-5">
        <div class="card border-0 shadow-sm">
            <div class="card-body p-4">
                <h5 class="card-title mb-4">
                    <c:choose>
                        <c:when test="${statusId != null}">Editar Status</c:when>
                        <c:otherwise>Novo Status</c:otherwise>
                    </c:choose>
                </h5>

                <c:set var="formAction"
                       value="${statusId != null ?
                            pageContext.request.contextPath.concat('/admin/ticket-statuses/').concat(statusId).concat('/edit') :
                            pageContext.request.contextPath.concat('/admin/ticket-statuses')}"/>

                <form:form method="post" action="${formAction}" modelAttribute="statusForm">
                    <div class="mb-3">
                        <label class="form-label fw-semibold small">Nome</label>
                        <form:input path="name" cssClass="form-control" placeholder="Ex: Em Andamento"/>
                        <form:errors path="name" cssClass="text-danger small"/>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold small">Cor (hex)</label>
                        <div class="input-group">
                            <form:input path="color" type="color" cssClass="form-control form-control-color" style="max-width:60px"/>
                            <form:input path="color" cssClass="form-control" placeholder="#6c757d"/>
                        </div>
                        <form:errors path="color" cssClass="text-danger small"/>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold small">Ordem de exibição</label>
                        <form:input path="sortOrder" type="number" cssClass="form-control" placeholder="0"/>
                        <form:errors path="sortOrder" cssClass="text-danger small"/>
                    </div>

                    <div class="mb-3">
                        <div class="form-check">
                            <form:checkbox path="default" cssClass="form-check-input" id="isDefault"/>
                            <label class="form-check-label small" for="isDefault">
                                Status padrão <span class="text-muted">(atribuído ao criar chamado)</span>
                            </label>
                        </div>
                    </div>

                    <div class="mb-4">
                        <div class="form-check">
                            <form:checkbox path="final" cssClass="form-check-input" id="isFinal"/>
                            <label class="form-check-label small" for="isFinal">
                                Status final <span class="text-muted">(registra data de conclusão)</span>
                            </label>
                        </div>
                    </div>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary">Salvar</button>
                        <a href="${pageContext.request.contextPath}/admin/ticket-statuses"
                           class="btn btn-outline-secondary">Cancelar</a>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/layouts/footer.jsp"/>
