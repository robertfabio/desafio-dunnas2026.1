<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="pageTitle" value="Chamado #${ticket.id}" scope="request"/>
<jsp:include page="/WEB-INF/views/layouts/header.jsp"/>

<div class="mb-3">
    <a href="${pageContext.request.contextPath}/staff/tickets"
       class="text-decoration-none small text-muted">← Voltar à fila</a>
</div>

<div class="row g-4">
    <div class="col-md-8">
        <div class="card border-0 shadow-sm mb-4">
            <div class="card-body">
                <h5 class="card-title">${ticket.title}</h5>
                <p class="text-muted">${ticket.description}</p>
                <hr>
                <div class="row g-2">
                    <div class="col-sm-6">
                        <div class="text-muted small">Tipo</div>
                        <div>${ticket.type.title} <span class="text-muted small">(SLA: ${ticket.type.slaHours}h)</span></div>
                    </div>
                    <div class="col-sm-6">
                        <div class="text-muted small">Unidade</div>
                        <div>${ticket.unit.identifier} — ${ticket.unit.block.name}</div>
                    </div>
                    <div class="col-sm-6">
                        <div class="text-muted small">Solicitante</div>
                        <div>${ticket.creator.name}</div>
                    </div>
                    <div class="col-sm-6">
                        <div class="text-muted small">Aberto em</div>
                        <div><fmt:formatDate value="${ticket.createdAt}" pattern="dd/MM/yyyy HH:mm"/></div>
                    </div>
                    <c:if test="${ticket.concludedAt != null}">
                        <div class="col-sm-6">
                            <div class="text-muted small">Concluído em</div>
                            <div><fmt:formatDate value="${ticket.concludedAt}" pattern="dd/MM/yyyy HH:mm"/></div>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <c:if test="${not empty ticket.attachments}">
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-body">
                    <h6 class="mb-3">Anexos</h6>
                    <ul class="list-unstyled mb-0">
                        <c:forEach var="att" items="${ticket.attachments}">
                            <li class="mb-1">
                                <a href="${pageContext.request.contextPath}/uploads/${att.storedFilename}"
                                   target="_blank" class="small">
                                    ${att.originalFilename}
                                    <span class="text-muted">(${att.contentType})</span>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </c:if>

        <div class="card border-0 shadow-sm">
            <div class="card-body">
                <h6 class="mb-3">Comentários</h6>

                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success alert-dismissible fade show py-2" role="alert">
                        ${successMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show py-2" role="alert">
                        ${errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:choose>
                    <c:when test="${empty comments}">
                        <p class="text-muted small">Nenhum comentário ainda.</p>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="comment" items="${comments}">
                            <div class="border rounded p-3 mb-2 bg-light">
                                <div class="d-flex justify-content-between mb-1">
                                    <strong class="small">${comment.author.name}
                                        <span class="text-muted fw-normal">(${comment.author.role})</span>
                                    </strong>
                                    <span class="text-muted small">
                                        <fmt:formatDate value="${comment.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                    </span>
                                </div>
                                <p class="mb-0 small">${comment.content}</p>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>

                <hr>
                <h6 class="mb-2">Adicionar Comentário</h6>
                <form:form method="post"
                           action="${pageContext.request.contextPath}/staff/tickets/${ticket.id}/comments"
                           modelAttribute="commentForm">
                    <div class="mb-2">
                        <form:textarea path="content" cssClass="form-control form-control-sm"
                                       rows="3" placeholder="Digite seu comentário..."/>
                    </div>
                    <button type="submit" class="btn btn-primary btn-sm">Comentar</button>
                </form:form>
            </div>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card border-0 shadow-sm">
            <div class="card-body">
                <h6 class="mb-3">Status Atual</h6>
                <span class="badge fs-6 mb-3"
                      style="background-color:${ticket.status.color};color:#fff">
                    ${ticket.status.name}
                </span>

                <c:if test="${not ticket.status.final}">
                    <hr>
                    <h6 class="mb-3">Atualizar Status</h6>
                    <form:form method="post"
                               action="${pageContext.request.contextPath}/staff/tickets/${ticket.id}/status"
                               modelAttribute="updateStatusForm">
                        <div class="mb-3">
                            <form:select path="statusId" cssClass="form-select form-select-sm">
                                <c:forEach var="s" items="${statuses}">
                                    <form:option value="${s.id}">${s.name}</form:option>
                                </c:forEach>
                            </form:select>
                        </div>
                        <button type="submit" class="btn btn-primary btn-sm w-100">Atualizar</button>
                    </form:form>
                </c:if>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/layouts/footer.jsp"/>
