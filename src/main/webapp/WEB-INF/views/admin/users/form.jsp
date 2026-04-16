<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="pageTitle" value="${userId != null ? 'Editar Usuário' : 'Novo Usuário'}" scope="request"/>
<jsp:include page="/WEB-INF/views/layouts/header.jsp"/>

<div class="row justify-content-center">
    <div class="col-md-6">
        <div class="card border-0 shadow-sm">
            <div class="card-body p-4">
                <h5 class="card-title mb-4">
                    <c:choose>
                        <c:when test="${userId != null}">Editar Usuário</c:when>
                        <c:otherwise>Novo Usuário</c:otherwise>
                    </c:choose>
                </h5>

                <c:set var="formAction"
                       value="${userId != null ?
                            pageContext.request.contextPath.concat('/admin/users/').concat(userId).concat('/edit') :
                            pageContext.request.contextPath.concat('/admin/users')}"/>

                <form:form method="post" action="${formAction}" modelAttribute="userForm">
                    <div class="mb-3">
                        <label class="form-label fw-semibold small">Nome</label>
                        <form:input path="name" cssClass="form-control" placeholder="Nome completo"/>
                        <form:errors path="name" cssClass="text-danger small"/>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold small">E-mail</label>
                        <form:input path="email" type="email" cssClass="form-control"
                                   placeholder="email@exemplo.com"
                                   readonly="${userId != null}"/>
                        <form:errors path="email" cssClass="text-danger small"/>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold small">
                            Senha <c:if test="${userId != null}"><span class="text-muted">(deixe em branco para manter)</span></c:if>
                        </label>
                        <form:password path="password" cssClass="form-control" placeholder="••••••••"/>
                        <form:errors path="password" cssClass="text-danger small"/>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-semibold small">Perfil</label>
                        <form:select path="role" cssClass="form-select">
                            <form:option value="" label="Selecione..."/>
                            <c:forEach var="r" items="${roles}">
                                <form:option value="${r}">
                                    <c:choose>
                                        <c:when test="${r == 'ADMIN'}">Administrador</c:when>
                                        <c:when test="${r == 'COLLABORATOR'}">Colaborador</c:when>
                                        <c:otherwise>Morador</c:otherwise>
                                    </c:choose>
                                </form:option>
                            </c:forEach>
                        </form:select>
                        <form:errors path="role" cssClass="text-danger small"/>
                    </div>

                    <div class="d-flex gap-2">
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
