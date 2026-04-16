<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Dashboard" scope="request"/>
<jsp:include page="/WEB-INF/views/layouts/header.jsp"/>

<div class="row g-3">
    <div class="col-md-4">
        <div class="card border-0 shadow-sm h-100">
            <div class="card-body d-flex align-items-center gap-3">
                <div class="rounded-3 bg-primary bg-opacity-10 p-3">
                    <i class="bi bi-people fs-3 text-primary"></i>
                </div>
                <div>
                    <div class="text-muted small">Usuários</div>
                    <a href="${pageContext.request.contextPath}/admin/users" class="stretched-link fw-semibold text-decoration-none">Gerenciar usuários</a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card border-0 shadow-sm h-100">
            <div class="card-body d-flex align-items-center gap-3">
                <div class="rounded-3 bg-success bg-opacity-10 p-3">
                    <i class="bi bi-building fs-3 text-success"></i>
                </div>
                <div>
                    <div class="text-muted small">Blocos</div>
                    <a href="${pageContext.request.contextPath}/admin/blocks" class="stretched-link fw-semibold text-decoration-none">Gerenciar blocos</a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card border-0 shadow-sm h-100">
            <div class="card-body d-flex align-items-center gap-3">
                <div class="rounded-3 bg-warning bg-opacity-10 p-3">
                    <i class="bi bi-ticket-perforated fs-3 text-warning"></i>
                </div>
                <div>
                    <div class="text-muted small">Chamados</div>
                    <a href="${pageContext.request.contextPath}/staff/tickets" class="stretched-link fw-semibold text-decoration-none">Ver chamados</a>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/layouts/footer.jsp"/>
