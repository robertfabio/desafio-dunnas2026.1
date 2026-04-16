<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Tipos de Chamado" scope="request"/>
<jsp:include page="/WEB-INF/views/layouts/header.jsp"/>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h4 class="mb-0">Tipos de Chamado</h4>
    <a href="${pageContext.request.contextPath}/admin/ticket-types/new" class="btn btn-primary btn-sm">
        <i class="bi bi-plus-lg me-1"></i>Novo Tipo
    </a>
</div>

<div class="card border-0 shadow-sm">
    <div class="card-body p-0">
        <c:choose>
            <c:when test="${empty types}">
                <p class="text-muted p-4 mb-0">Nenhum tipo de chamado cadastrado.</p>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>Título</th>
                                <th>SLA (horas)</th>
                                <th>Status</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="type" items="${types}">
                                <tr>
                                    <td class="fw-semibold">${type.title}</td>
                                    <td>${type.slaHours}h</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${type.active}">
                                                <span class="badge bg-success">Ativo</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">Inativo</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-end">
                                        <a href="${pageContext.request.contextPath}/admin/ticket-types/${type.id}/edit"
                                           class="btn btn-sm btn-outline-secondary me-1">
                                            <i class="bi bi-pencil"></i>
                                        </a>
                                        <form method="post"
                                              action="${pageContext.request.contextPath}/admin/ticket-types/${type.id}/toggle-active"
                                              class="d-inline">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                            <button type="submit"
                                                    class="btn btn-sm ${type.active ? 'btn-outline-warning' : 'btn-outline-success'}">
                                                <i class="bi ${type.active ? 'bi-pause-circle' : 'bi-play-circle'}"></i>
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<jsp:include page="/WEB-INF/views/layouts/footer.jsp"/>
