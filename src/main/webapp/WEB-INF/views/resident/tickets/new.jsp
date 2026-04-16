<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="pageTitle" value="Abrir Chamado" scope="request"/>
<jsp:include page="/WEB-INF/views/layouts/header.jsp"/>

<div class="row justify-content-center">
    <div class="col-md-7">
        <div class="card border-0 shadow-sm">
            <div class="card-body p-4">
                <h5 class="card-title mb-4">Novo Chamado</h5>

                <form:form method="post"
                           action="${pageContext.request.contextPath}/resident/tickets"
                           modelAttribute="ticketForm"
                           enctype="multipart/form-data">

                    <div class="mb-3">
                        <label class="form-label fw-semibold small">Título</label>
                        <form:input path="title" cssClass="form-control" placeholder="Descreva brevemente o problema"/>
                        <form:errors path="title" cssClass="text-danger small"/>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold small">Descrição</label>
                        <form:textarea path="description" cssClass="form-control" rows="4"
                                       placeholder="Detalhes do problema..."/>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold small">Unidade</label>
                        <form:select path="unitId" cssClass="form-select">
                            <form:option value="" label="Selecione sua unidade..."/>
                            <c:forEach var="unit" items="${units}">
                                <form:option value="${unit.id}">${unit.identifier} — ${unit.block.name}</form:option>
                            </c:forEach>
                        </form:select>
                        <form:errors path="unitId" cssClass="text-danger small"/>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold small">Tipo de Chamado</label>
                        <form:select path="typeId" cssClass="form-select">
                            <form:option value="" label="Selecione o tipo..."/>
                            <c:forEach var="type" items="${types}">
                                <form:option value="${type.id}">${type.title} (SLA: ${type.slaHours}h)</form:option>
                            </c:forEach>
                        </form:select>
                        <form:errors path="typeId" cssClass="text-danger small"/>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-semibold small">Anexos <span class="text-muted">(opcional)</span></label>
                        <input type="file" name="attachments" class="form-control" multiple accept="image/*,.pdf,.doc,.docx">
                        <div class="form-text">Máximo 10MB por arquivo.</div>
                    </div>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary">Abrir Chamado</button>
                        <a href="${pageContext.request.contextPath}/resident/tickets"
                           class="btn btn-outline-secondary">Cancelar</a>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/layouts/footer.jsp"/>
