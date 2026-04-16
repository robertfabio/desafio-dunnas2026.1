<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Dashboard" scope="request"/>
<jsp:include page="/WEB-INF/views/layouts/header.jsp"/>

<div class="row g-3 mb-4">
    <div class="col-sm-6">
        <div class="card border-0 shadow-sm stat-card h-100">
            <div class="card-body d-flex align-items-center gap-3">
                <div class="stat-icon"><i class="bi bi-ticket-perforated-fill"></i></div>
                <div>
                    <div class="text-muted small">Chamados abertos</div>
                    <div class="fs-4 fw-bold lh-1">${openTickets}</div>
                </div>
                <a href="${pageContext.request.contextPath}/staff/tickets" class="stretched-link"></a>
            </div>
        </div>
    </div>
    <div class="col-sm-6">
        <div class="card border-0 shadow-sm stat-card h-100">
            <div class="card-body d-flex align-items-center gap-3">
                <div class="stat-icon"><i class="bi bi-archive-fill"></i></div>
                <div>
                    <div class="text-muted small">Total de chamados</div>
                    <div class="fs-4 fw-bold lh-1">${totalTickets}</div>
                </div>
                <a href="${pageContext.request.contextPath}/staff/tickets" class="stretched-link"></a>
            </div>
        </div>
    </div>
</div>

<div class="row g-3">
    <div class="col-12">
        <div class="card border-0 shadow-sm">
            <div class="card-header bg-transparent fw-semibold">Acesso rápido</div>
            <div class="card-body d-flex flex-wrap gap-2">
                <a href="${pageContext.request.contextPath}/staff/tickets" class="btn btn-primary btn-sm"><i class="bi bi-ticket-perforated me-1"></i>Todos os chamados</a>
                <a href="${pageContext.request.contextPath}/staff/tickets?statusFinal=false" class="btn btn-outline-secondary btn-sm"><i class="bi bi-clock me-1"></i>Em aberto</a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/layouts/footer.jsp"/>
