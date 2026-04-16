<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Status de Chamado" scope="request"/>
<jsp:include page="/WEB-INF/views/layouts/header.jsp"/>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h4 class="mb-0">Status de Chamado</h4>
    <a href="${pageContext.request.contextPath}/admin/ticket-statuses/new" class="btn btn-primary btn-sm">
        <i class="bi bi-plus-lg me-1"></i>Novo Status
    </a>
</div>

<div class="card border-0 shadow-sm">
    <div class="card-body p-0">
        <c:choose>
            <c:when test="${empty statuses}">
                <p class="text-muted p-4 mb-0">Nenhum status cadastrado.</p>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>Ordem</th>
                                <th>Nome</th>
                                <th>Cor</th>
                                <th>Padrão</th>
                                <th>Final</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="status" items="${statuses}">
                                <tr>
                                    <td class="text-muted small">${status.sortOrder}</td>
                                    <td>
                                        <span class="badge rounded-pill" style="background-color: ${status.color}">
                                            ${status.name}
                                        </span>
                                    </td>
                                    <td>
                                        <span class="d-inline-flex align-items-center gap-2">
                                            <span style="width:16px;height:16px;border-radius:4px;background:${status.color};display:inline-block;border:1px solid #dee2e6"></span>
                                            <code class="small">${status.color}</code>
                                        </span>
                                    </td>
                                    <td>
                                        <c:if test="${status['default']}">
                                            <i class="bi bi-check-circle-fill text-success"></i>
                                        </c:if>
                                    </td>
                                    <td>
                                        <c:if test="${status['final']}">
                                            <i class="bi bi-flag-fill text-danger"></i>
                                        </c:if>
                                    </td>
                                    <td class="text-end">
                                        <a href="${pageContext.request.contextPath}/admin/ticket-statuses/${status.id}/edit"
                                           class="btn btn-sm btn-outline-secondary">
                                            <i class="bi bi-pencil"></i>
                                        </a>
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
