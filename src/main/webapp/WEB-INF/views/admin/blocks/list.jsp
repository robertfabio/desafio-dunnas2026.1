<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Blocos" scope="request"/>
<jsp:include page="/WEB-INF/views/layouts/header.jsp"/>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h4 class="mb-0">Blocos</h4>
    <a href="${pageContext.request.contextPath}/admin/blocks/new" class="btn btn-primary btn-sm">
        <i class="bi bi-plus-lg me-1"></i>Novo Bloco
    </a>
</div>

<div class="card border-0 shadow-sm">
    <div class="card-body p-0">
        <c:choose>
            <c:when test="${empty blocks}">
                <p class="text-muted p-4 mb-0">Nenhum bloco cadastrado.</p>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>Nome</th>
                                <th>Andares</th>
                                <th>Unidades por andar</th>
                                <th>Total de unidades</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="block" items="${blocks}">
                                <tr>
                                    <td class="fw-semibold">${block.name}</td>
                                    <td>${block.floors}</td>
                                    <td>${block.unitsPerFloor}</td>
                                    <td>
                                        <span class="badge bg-secondary">
                                            ${block.floors * block.unitsPerFloor}
                                        </span>
                                    </td>
                                    <td class="text-end">
                                        <a href="${pageContext.request.contextPath}/admin/blocks/${block.id}/edit"
                                           class="btn btn-sm btn-outline-secondary me-1">
                                            <i class="bi bi-pencil"></i>
                                        </a>
                                        <form method="post"
                                              action="${pageContext.request.contextPath}/admin/blocks/${block.id}/delete"
                                              class="d-inline"
                                              onsubmit="return confirm('Remover o bloco ${block.name} e todas as suas unidades?')">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                            <button type="submit" class="btn btn-sm btn-outline-danger">
                                                <i class="bi bi-trash"></i>
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
