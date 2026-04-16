<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="pageTitle" value="Unidades do Morador" scope="request"/>
<jsp:include page="/WEB-INF/views/layouts/header.jsp"/>

<div class="row justify-content-center">
    <div class="col-md-8">
        <div class="card border-0 shadow-sm">
            <div class="card-body p-4">
                <h5 class="card-title mb-1">Unidades de <span class="text-primary">${user.name}</span></h5>
                <p class="text-muted small mb-4">${user.email}</p>

                <form:form method="post"
                           action="${pageContext.request.contextPath}/admin/users/${user.id}/assign-units"
                           modelAttribute="assignForm">

                    <c:set var="currentBlock" value=""/>
                    <c:forEach var="unit" items="${allUnits}">
                        <c:if test="${unit.block.name != currentBlock}">
                            <c:if test="${currentBlock != ''}">
                                </div>
                            </c:if>
                            <c:set var="currentBlock" value="${unit.block.name}"/>
                            <h6 class="fw-semibold mt-3 mb-2 text-secondary">
                                <i class="bi bi-building me-1"></i>${unit.block.name}
                            </h6>
                            <div class="row g-2">
                        </c:if>
                        <div class="col-6 col-sm-4 col-md-3">
                            <div class="form-check border rounded p-2">
                                <input class="form-check-input" type="checkbox"
                                       name="unitIds" value="${unit.id}" id="unit_${unit.id}"
                                       <c:forEach var="sel" items="${assignForm.unitIds}">
                                           <c:if test="${sel == unit.id}">checked</c:if>
                                       </c:forEach>>
                                <label class="form-check-label small" for="unit_${unit.id}">
                                    ${unit.identifier}
                                </label>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${not empty allUnits}">
                            </div>
                    </c:if>

                    <c:if test="${empty allUnits}">
                        <p class="text-muted">Nenhuma unidade cadastrada. Cadastre blocos e unidades primeiro.</p>
                    </c:if>

                    <div class="d-flex gap-2 mt-4">
                        <button type="submit" class="btn btn-primary">Salvar</button>
                        <a href="${pageContext.request.contextPath}/admin/users"
                           class="btn btn-outline-secondary">Cancelar</a>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/layouts/footer.jsp"/>
