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
        width: 300px; height: 300px;
        border-radius: 50%;
        background: radial-gradient(circle, rgba(191,35,41,.22) 0%, transparent 65%);
        right: -60px; top: -80px;
    }
    .hero-strip .hero-icon {
        position: absolute;
        right: 1.8rem; bottom: -1rem;
        font-size: 6.5rem;
        opacity: .06; line-height: 1;
    }
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
</style>

<div class="hero-strip">
    <div style="position:relative;z-index:1">
        <div class="d-flex align-items-center gap-2 mb-1">
            <span style="width:7px;height:7px;border-radius:50%;background:#bf2329;display:inline-block"></span>
            <span style="font-size:.72rem;color:rgba(255,255,255,.45);letter-spacing:.07em;text-transform:uppercase">Atendimento</span>
        </div>
        <h4 class="fw-bold mb-1" style="color:#fff;margin:0">Painel do Colaborador</h4>
        <p style="color:rgba(255,255,255,.4);font-size:.85rem;margin:.35rem 0 0">Gerencie a fila de chamados do condomínio.</p>
    </div>
    <span class="hero-icon"><i class="bi bi-headset"></i></span>
</div>

<div class="row g-3 mb-4">
    <div class="col-sm-6">
        <div class="card kpi-card bg-rose">
            <div class="card-body">
                <div class="kpi-label text-rose">Em aberto</div>
                <div class="d-flex align-items-center gap-3 mt-1">
                    <div class="kpi-icon-box icon-rose"><i class="bi bi-ticket-perforated-fill"></i></div>
                    <div class="kpi-val">${openTickets}
                        <span style="font-size:1rem;font-weight:400;color:#9ca3af">/ ${totalTickets}</span>
                    </div>
                </div>
                <div class="prog-bar"><div class="prog-fill" id="pBar"></div></div>
            </div>
            <a href="${pageContext.request.contextPath}/staff/tickets" class="stretched-link"></a>
        </div>
    </div>
    <div class="col-sm-6">
        <div class="card kpi-card bg-slate">
            <div class="card-body">
                <div class="kpi-label text-slate">Total de chamados</div>
                <div class="d-flex align-items-center gap-3 mt-1">
                    <div class="kpi-icon-box icon-slate"><i class="bi bi-archive-fill"></i></div>
                    <div class="kpi-val">${totalTickets}</div>
                </div>
                <div class="kpi-sub">Histórico completo</div>
            </div>
            <a href="${pageContext.request.contextPath}/staff/tickets" class="stretched-link"></a>
        </div>
    </div>
</div>

<div class="card border-0 shadow-sm" style="border-radius:14px">
    <div class="card-body d-flex flex-wrap gap-2">
        <a href="${pageContext.request.contextPath}/staff/tickets" class="btn btn-primary btn-sm"><i class="bi bi-inbox me-1"></i>Todos os chamados</a>
        <a href="${pageContext.request.contextPath}/staff/tickets?statusFinal=false" class="btn btn-outline-secondary btn-sm"><i class="bi bi-clock me-1"></i>Em aberto</a>
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
