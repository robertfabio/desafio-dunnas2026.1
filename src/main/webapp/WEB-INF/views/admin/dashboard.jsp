<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Dashboard" scope="request"/>
<jsp:include page="/WEB-INF/views/layouts/header.jsp"/>

<style>
    .hero-strip {
        background: linear-gradient(135deg, #1a1d23 0%, #2d3139 100%);
        border-radius: 14px;
        padding: 1.75rem 2rem;
        color: #fff;
        position: relative;
        overflow: hidden;
        margin-bottom: 1.5rem;
    }
    .hero-strip::before {
        content: '';
        position: absolute;
        width: 340px; height: 340px;
        border-radius: 50%;
        background: radial-gradient(circle, rgba(191,35,41,.22) 0%, transparent 65%);
        right: -80px; top: -100px;
    }
    .hero-strip .hero-icon {
        position: absolute;
        right: 1.8rem; bottom: -1rem;
        font-size: 6.5rem;
        opacity: .06;
        line-height: 1;
    }
    .kpi-card {
        border: none;
        border-radius: 14px;
        overflow: hidden;
        transition: transform .22s ease, box-shadow .22s ease;
        box-shadow: 0 2px 12px rgba(0,0,0,.06);
        cursor: pointer;
    }
    .kpi-card:hover { transform: translateY(-3px); box-shadow: 0 10px 32px rgba(0,0,0,.12); }
    .kpi-icon-box {
        width: 54px; height: 54px;
        border-radius: 13px;
        display: flex; align-items: center; justify-content: center;
        font-size: 1.45rem;
        flex-shrink: 0;
    }
    .kpi-val { font-size: 2.1rem; font-weight: 800; line-height: 1; color: #111827; }
    .kpi-label { font-size: .75rem; font-weight: 600; text-transform: uppercase; letter-spacing: .06em; margin-bottom: .3rem; color: #6b7280; }
    .kpi-sub { font-size: .75rem; color: #9ca3af; margin-top: .25rem; }
    .kpi-card { background: #fff; }
    .kpi-icon-box { background: #fff0f0; color: var(--dnn-red); }
    .prog-bar {
        height: 5px; border-radius: 99px;
        background: rgba(0,0,0,.07); margin-top: .85rem; overflow: hidden;
    }
    .prog-fill {
        height: 100%; border-radius: 99px;
        background: linear-gradient(90deg, #bf2329, #8e1016);
        width: 0; transition: width .9s cubic-bezier(.4,0,.2,1);
    }
    .nav-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(120px, 1fr)); gap: .6rem; }
    .nav-tile {
        display: flex; flex-direction: column;
        align-items: center; gap: .45rem;
        padding: 1rem .75rem;
        border-radius: 12px;
        border: 1.5px solid #f3f4f6;
        background: #fff;
        text-decoration: none;
        color: #374151;
        font-size: .78rem; font-weight: 500;
        transition: border-color .17s, background .17s, color .17s, transform .14s;
        text-align: center;
    }
    .nav-tile i { font-size: 1.35rem; color: var(--dnn-red); transition: transform .18s; }
    .nav-tile:hover { border-color: var(--dnn-red); background: #fff5f5; color: var(--dnn-red); transform: translateY(-1px); }
    .nav-tile:hover i { transform: scale(1.18); }
</style>

<div class="hero-strip">
    <div style="position:relative;z-index:1">
        <div class="d-flex align-items-center gap-2 mb-1">
            <span style="width:7px;height:7px;border-radius:50%;background:#bf2329;display:inline-block"></span>
            <span style="font-size:.72rem;color:rgba(255,255,255,.45);letter-spacing:.07em;text-transform:uppercase">Visão geral</span>
        </div>
        <h4 class="fw-bold mb-1" style="color:#fff;margin:0">Painel Administrativo</h4>
        <p style="color:rgba(255,255,255,.4);font-size:.85rem;margin:.35rem 0 0">Indicadores do condomínio em tempo real.</p>
    </div>
    <span class="hero-icon"><i class="bi bi-buildings"></i></span>
</div>

<div class="row g-3 mb-4">
    <div class="col-sm-6 col-xl-3">
        <div class="card kpi-card">
            <div class="card-body">
                <div class="kpi-label">Usuários</div>
                <div class="d-flex align-items-center gap-3 mt-1">
                    <div class="kpi-icon-box"><i class="bi bi-people-fill"></i></div>
                    <div class="kpi-val">${totalUsers}</div>
                </div>
                <div class="kpi-sub">Contas ativas no sistema</div>
            </div>
            <a href="${pageContext.request.contextPath}/admin/users" class="stretched-link"></a>
        </div>
    </div>
    <div class="col-sm-6 col-xl-3">
        <div class="card kpi-card">
            <div class="card-body">
                <div class="kpi-label">Blocos</div>
                <div class="d-flex align-items-center gap-3 mt-1">
                    <div class="kpi-icon-box"><i class="bi bi-building-fill"></i></div>
                    <div class="kpi-val">${totalBlocks}</div>
                </div>
                <div class="kpi-sub">${totalUnits} unidades cadastradas</div>
            </div>
            <a href="${pageContext.request.contextPath}/admin/blocks" class="stretched-link"></a>
        </div>
    </div>
    <div class="col-sm-6 col-xl-3">
        <div class="card kpi-card">
            <div class="card-body">
                <div class="kpi-label">Unidades</div>
                <div class="d-flex align-items-center gap-3 mt-1">
                    <div class="kpi-icon-box"><i class="bi bi-door-open-fill"></i></div>
                    <div class="kpi-val">${totalUnits}</div>
                </div>
                <div class="kpi-sub">Em ${totalBlocks} blocos</div>
            </div>
            <a href="${pageContext.request.contextPath}/admin/blocks" class="stretched-link"></a>
        </div>
    </div>
    <div class="col-sm-6 col-xl-3">
        <div class="card kpi-card">
            <div class="card-body">
                <div class="kpi-label">Em aberto</div>
                <div class="d-flex align-items-center gap-3 mt-1">
                    <div class="kpi-icon-box"><i class="bi bi-ticket-perforated-fill"></i></div>
                    <div class="kpi-val">${openTickets}
                        <span style="font-size:1rem;font-weight:400;color:#9ca3af">/ ${totalTickets}</span>
                    </div>
                </div>
                <div class="prog-bar"><div class="prog-fill" id="pBar"></div></div>
            </div>
            <a href="${pageContext.request.contextPath}/staff/tickets" class="stretched-link"></a>
        </div>
    </div>
</div>

<div class="card border-0 shadow-sm" style="border-radius:14px">
    <div class="card-body">
        <div style="font-size:.8rem;font-weight:600;color:#6b7280;margin-bottom:.85rem;text-transform:uppercase;letter-spacing:.06em">Navegação rápida</div>
        <div class="nav-grid">
            <a href="${pageContext.request.contextPath}/admin/users" class="nav-tile"><i class="bi bi-people"></i>Usuários</a>
            <a href="${pageContext.request.contextPath}/admin/blocks" class="nav-tile"><i class="bi bi-buildings"></i>Blocos</a>
            <a href="${pageContext.request.contextPath}/admin/ticket-types" class="nav-tile"><i class="bi bi-tags"></i>Tipos</a>
            <a href="${pageContext.request.contextPath}/admin/ticket-statuses" class="nav-tile"><i class="bi bi-diagram-3"></i>Status</a>
            <a href="${pageContext.request.contextPath}/staff/tickets" class="nav-tile"><i class="bi bi-inbox"></i>Chamados</a>
        </div>
    </div>
</div>

<script>
(function(){
    const total = Number('${totalTickets}') || 0;
    const open  = Number('${openTickets}')  || 0;
    const bar   = document.getElementById('pBar');
    if (bar && total > 0) setTimeout(() => bar.style.width = (open/total*100)+'%', 250);
})();
</script>

<jsp:include page="/WEB-INF/views/layouts/footer.jsp"/>
