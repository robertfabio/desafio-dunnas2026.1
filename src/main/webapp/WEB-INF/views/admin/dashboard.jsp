<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Dashboard" scope="request"/>
<jsp:include page="/WEB-INF/views/layouts/header.jsp"/>

<div class="row g-3 mb-4">
    <div class="col-sm-6 col-xl-3">
        <div class="card border-0 shadow-sm stat-card h-100">
            <div class="card-body d-flex align-items-center gap-3">
                <div class="stat-icon"><i class="bi bi-people-fill"></i></div>
                <div>
                    <div class="text-muted small">Usuários</div>
                    <div class="fs-4 fw-bold lh-1">${totalUsers}</div>
                </div>
                <a href="${pageContext.request.contextPath}/admin/users" class="stretched-link"></a>
            </div>
        </div>
    </div>
    <div class="col-sm-6 col-xl-3">
        <div class="card border-0 shadow-sm stat-card h-100">
            <div class="card-body d-flex align-items-center gap-3">
                <div class="stat-icon"><i class="bi bi-building-fill"></i></div>
                <div>
                    <div class="text-muted small">Blocos</div>
                    <div class="fs-4 fw-bold lh-1">${totalBlocks}</div>
                </div>
                <a href="${pageContext.request.contextPath}/admin/blocks" class="stretched-link"></a>
            </div>
        </div>
    </div>
    <div class="col-sm-6 col-xl-3">
        <div class="card border-0 shadow-sm stat-card h-100">
            <div class="card-body d-flex align-items-center gap-3">
                <div class="stat-icon"><i class="bi bi-door-open-fill"></i></div>
                <div>
                    <div class="text-muted small">Unidades</div>
                    <div class="fs-4 fw-bold lh-1">${totalUnits}</div>
                </div>
                <a href="${pageContext.request.contextPath}/admin/blocks" class="stretched-link"></a>
            </div>
        </div>
    </div>
    <div class="col-sm-6 col-xl-3">
        <div class="card border-0 shadow-sm stat-card h-100">
            <div class="card-body d-flex align-items-center gap-3">
                <div class="stat-icon"><i class="bi bi-ticket-perforated-fill"></i></div>
                <div>
                    <div class="text-muted small">Chamados abertos</div>
                    <div class="fs-4 fw-bold lh-1">${openTickets}
                        <span class="fs-6 text-muted fw-normal">/ ${totalTickets}</span>
                    </div>
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
                <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-outline-secondary btn-sm"><i class="bi bi-people me-1"></i>Usuários</a>
                <a href="${pageContext.request.contextPath}/admin/blocks" class="btn btn-outline-secondary btn-sm"><i class="bi bi-building me-1"></i>Blocos</a>
                <a href="${pageContext.request.contextPath}/admin/ticket-types" class="btn btn-outline-secondary btn-sm"><i class="bi bi-tags me-1"></i>Tipos de chamado</a>
                <a href="${pageContext.request.contextPath}/admin/ticket-statuses" class="btn btn-outline-secondary btn-sm"><i class="bi bi-circle-half me-1"></i>Status</a>
                <a href="${pageContext.request.contextPath}/staff/tickets" class="btn btn-primary btn-sm"><i class="bi bi-ticket-perforated me-1"></i>Chamados</a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/layouts/footer.jsp"/>
