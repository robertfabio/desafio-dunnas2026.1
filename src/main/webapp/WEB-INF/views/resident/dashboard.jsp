<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Meu Painel" scope="request"/>
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
        width: 280px; height: 280px;
        border-radius: 50%;
        background: radial-gradient(circle, rgba(191,35,41,.22) 0%, transparent 65%);
        right: -60px; top: -70px;
    }
    .hero-strip .hero-icon {
        position: absolute;
        right: 1.8rem; bottom: -1rem;
        font-size: 6.5rem;
        opacity: .06; line-height: 1;
    }
    .hero-greeting { font-size: .72rem; color: rgba(255,255,255,.45); letter-spacing: .07em; text-transform: uppercase; }
    .hero-name { font-size: 1.5rem; font-weight: 700; color: #fff; margin: .25rem 0; }
    .hero-sub { font-size: .85rem; color: rgba(255,255,255,.4); }
    .kpi-card {
        border: none; border-radius: 14px; overflow: hidden;
        transition: transform .22s ease, box-shadow .22s ease;
        box-shadow: 0 2px 12px rgba(0,0,0,.06); cursor: pointer;
    }
    .kpi-card:hover { transform: translateY(-3px); box-shadow: 0 10px 32px rgba(0,0,0,.12); }
    .kpi-icon-box {
        width: 54px; height: 54px; border-radius: 13px;
        display: flex; align-items: center; justify-content: center;
        font-size: 1.45rem; flex-shrink: 0;
    }
    .kpi-val { font-size: 2.1rem; font-weight: 800; line-height: 1; color: #111827; }
    .kpi-label { font-size: .75rem; font-weight: 600; text-transform: uppercase; letter-spacing: .06em; margin-bottom: .3rem; }
    .kpi-sub { font-size: .75rem; color: #9ca3af; margin-top: .25rem; }
    .bg-rose  { background: #fff1f2; } .icon-rose  { background: #ffe4e6; color: #bf2329; } .text-rose  { color: #9f1239; }
    .bg-slate { background: #f8fafc; } .icon-slate { background: #f1f5f9; color: #475569; } .text-slate { color: #334155; }
    .prog-bar { height: 5px; border-radius: 99px; background: rgba(0,0,0,.07); margin-top: .85rem; overflow: hidden; }
    .prog-fill { height: 100%; border-radius: 99px; background: linear-gradient(90deg,#bf2329,#8e1016); width:0; transition: width .9s cubic-bezier(.4,0,.2,1); }
    .action-card {
        display: flex; align-items: center; gap: 1rem;
        padding: 1rem 1.25rem;
        border-radius: 12px;
        border: 1.5px solid #f3f4f6;
        background: #fff;
        text-decoration: none;
        color: #374151;
        transition: border-color .17s, background .17s, transform .14s;
    }
    .action-card:hover { border-color: var(--dnn-red); background: #fff5f5; color: var(--dnn-red); transform: translateY(-1px); }
    .action-card .ac-icon { width: 42px; height: 42px; border-radius: 10px; display: flex; align-items: center; justify-content: center; font-size: 1.2rem; flex-shrink: 0; }
    .action-card.primary .ac-icon { background: #ffe4e6; color: #bf2329; }
    .action-card.secondary .ac-icon { background: #f1f5f9; color: #475569; }
    .action-card .ac-label { font-size: .78rem; color: #9ca3af; margin-bottom: .1rem; }
    .action-card .ac-title { font-size: .9rem; font-weight: 600; }
</style>

<div class="hero-strip">
    <div style="position:relative;z-index:1">
        <div class="hero-greeting">Meu painel</div>
        <div class="hero-name">Olá, <c:out value="${userName}"/>!</div>
        <div class="hero-sub">Bem-vindo ao seu espaço de chamados.</div>
    </div>
    <span class="hero-icon"><i class="bi bi-house-door"></i></span>
</div>

<div class="row g-3 mb-4">
    <div class="col-sm-6">
        <div class="card kpi-card bg-rose">
            <div class="card-body">
                <div class="kpi-label text-rose">Em aberto</div>
                <div class="d-flex align-items-center gap-3 mt-1">
                    <div class="kpi-icon-box icon-rose"><i class="bi bi-ticket-perforated-fill"></i></div>
                    <div class="kpi-val">${myOpenTickets}
                        <span style="font-size:1rem;font-weight:400;color:#9ca3af">/ ${myTickets}</span>
                    </div>
                </div>
                <div class="prog-bar"><div class="prog-fill" id="pBar"></div></div>
            </div>
            <a href="${pageContext.request.contextPath}/resident/tickets" class="stretched-link"></a>
        </div>
    </div>
    <div class="col-sm-6">
        <div class="card kpi-card bg-slate">
            <div class="card-body">
                <div class="kpi-label text-slate">Total de chamados</div>
                <div class="d-flex align-items-center gap-3 mt-1">
                    <div class="kpi-icon-box icon-slate"><i class="bi bi-archive-fill"></i></div>
                    <div class="kpi-val">${myTickets}</div>
                </div>
                <div class="kpi-sub">Todos os seus chamados</div>
            </div>
            <a href="${pageContext.request.contextPath}/resident/tickets" class="stretched-link"></a>
        </div>
    </div>
</div>

<div class="row g-2">
    <div class="col-sm-6">
        <a href="${pageContext.request.contextPath}/resident/tickets/new" class="action-card primary">
            <div class="ac-icon"><i class="bi bi-plus-circle-fill"></i></div>
            <div>
                <div class="ac-label">Precisa de ajuda?</div>
                <div class="ac-title">Abrir novo chamado</div>
            </div>
        </a>
    </div>
    <div class="col-sm-6">
        <a href="${pageContext.request.contextPath}/resident/tickets" class="action-card secondary">
            <div class="ac-icon"><i class="bi bi-list-ul"></i></div>
            <div>
                <div class="ac-label">Acompanhe o andamento</div>
                <div class="ac-title">Ver meus chamados</div>
            </div>
        </a>
    </div>
</div>

<script>
(function(){
    const total = Number('${myTickets}')     || 0;
    const open  = Number('${myOpenTickets}') || 0;
    const bar   = document.getElementById('pBar');
    if (bar && total > 0) setTimeout(() => bar.style.width = (open/total*100)+'%', 250);
})();
</script>

<jsp:include page="/WEB-INF/views/layouts/footer.jsp"/>
