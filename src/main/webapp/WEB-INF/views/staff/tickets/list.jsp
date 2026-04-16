<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="Fila de Chamados" scope="request"/>
<jsp:include page="/WEB-INF/views/layouts/header.jsp"/>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h5 class="mb-0">Fila de Chamados</h5>
</div>

<div class="card border-0 shadow-sm">
    <div class="card-body p-0">
        <table class="table table-hover align-middle mb-0">
            <thead class="table-light">
                <tr>
                    <th class="ps-3">#</th>
                    <th>Título</th>
                    <th>Tipo</th>
                    <th>Unidade</th>
                    <th>Solicitante</th>
                    <th>Status</th>
                    <th>Aberto em</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="ticket" items="${tickets}">
                    <tr>
                        <td class="ps-3 text-muted small">${ticket.id}</td>
                        <td>${ticket.title}</td>
                        <td><span class="badge bg-light text-dark border">${ticket.type.title}</span></td>
                        <td class="small">${ticket.unit.identifier}</td>
                        <td class="small">${ticket.creator.name}</td>
                        <td>
                            <span class="badge"
                                  style="background-color:${ticket.status.color};color:#fff">
                                ${ticket.status.name}
                            </span>
                        </td>
                        <td class="small text-muted">
                            <fmt:formatDate value="${ticket.createdAt}" pattern="dd/MM/yyyy"/>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/staff/tickets/${ticket.id}"
                               class="btn btn-sm btn-outline-primary">Ver</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty tickets}">
                    <tr>
                        <td colspan="8" class="text-center text-muted py-4">Nenhum chamado na fila.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="/WEB-INF/views/layouts/footer.jsp"/>
