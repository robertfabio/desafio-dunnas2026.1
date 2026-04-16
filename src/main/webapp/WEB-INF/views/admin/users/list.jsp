<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="Usuários" scope="request"/>
<jsp:include page="/WEB-INF/views/layouts/header.jsp"/>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h5 class="mb-0">Usuários cadastrados</h5>
    <a href="${pageContext.request.contextPath}/admin/users/new" class="btn btn-primary btn-sm">
        <i class="bi bi-plus-lg me-1"></i>Novo usuário
    </a>
</div>

<div class="card border-0 shadow-sm">
    <div class="table-responsive">
        <table class="table table-hover align-middle mb-0">
            <thead class="table-light">
                <tr>
                    <th>Nome</th>
                    <th>E-mail</th>
                    <th>Perfil</th>
                    <th>Status</th>
                    <th class="text-end">Ações</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="u" items="${users}">
                    <tr>
                        <td><c:out value="${u.name}"/></td>
                        <td class="text-muted small"><c:out value="${u.email}"/></td>
                        <td>
                            <c:choose>
                                <c:when test="${u.role == 'ADMIN'}">
                                    <span class="badge bg-danger">Admin</span>
                                </c:when>
                                <c:when test="${u.role == 'COLLABORATOR'}">
                                    <span class="badge bg-warning text-dark">Colaborador</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-info text-dark">Morador</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${u.active}">
                                    <span class="badge bg-success-subtle text-success">Ativo</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-secondary-subtle text-secondary">Inativo</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="text-end">
                            <a href="${pageContext.request.contextPath}/admin/users/${u.id}/edit"
                               class="btn btn-sm btn-outline-primary me-1">
                                <i class="bi bi-pencil"></i>
                            </a>
                            <c:if test="${u.role == 'RESIDENT'}">
                                <a href="${pageContext.request.contextPath}/admin/users/${u.id}/assign-units"
                                   class="btn btn-sm btn-outline-secondary me-1" title="Vincular Unidades">
                                    <i class="bi bi-house-add"></i>
                                </a>
                            </c:if>
                            <form method="post"
                                  action="${pageContext.request.contextPath}/admin/users/${u.id}/toggle-active"
                                  style="display:inline">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                                <button class="btn btn-sm ${u.active ? 'btn-outline-danger' : 'btn-outline-success'}"
                                        title="${u.active ? 'Desativar' : 'Ativar'}">
                                    <i class="bi ${u.active ? 'bi-toggle-on' : 'bi-toggle-off'}"></i>
                                </button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty users}">
                    <tr>
                        <td colspan="5" class="text-center text-muted py-4">Nenhum usuário cadastrado.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="/WEB-INF/views/layouts/footer.jsp"/>
