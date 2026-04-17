<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dunnas Residences — Entrar</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root { --dnn-red: #bf2329; --dnn-red-dark: #8e1016; }
        *, *::before, *::after { box-sizing: border-box; }
        html, body { height: 100%; margin: 0; }
        body {
            display: flex;
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
        }

        .panel-brand {
            display: none;
            position: relative;
            overflow: hidden;
            background: #0f1117;
            flex: 1;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }
        @media (min-width: 992px) { .panel-brand { display: flex; } }

        .p-layer {
            position: absolute;
            inset: -60px;
            will-change: transform;
            pointer-events: none;
            transition: transform .05s linear;
        }
        .orb {
            position: absolute;
            border-radius: 50%;
        }
        .orb-1 {
            width: 520px; height: 520px;
            background: radial-gradient(circle at 40% 40%, rgba(191,35,41,.22) 0%, transparent 65%);
            top: -100px; left: -120px;
        }
        .orb-2 {
            width: 380px; height: 380px;
            background: radial-gradient(circle at 60% 60%, rgba(142,16,22,.16) 0%, transparent 65%);
            bottom: 20px; right: -80px;
        }
        .orb-3 {
            width: 220px; height: 220px;
            background: radial-gradient(circle, rgba(191,35,41,.10) 0%, transparent 70%);
            top: 45%; left: 55%;
        }
        .grid-layer {
            position: absolute;
            inset: 0;
            background-image:
                linear-gradient(rgba(255,255,255,.025) 1px, transparent 1px),
                linear-gradient(90deg, rgba(255,255,255,.025) 1px, transparent 1px);
            background-size: 52px 52px;
        }
        .stripe {
            position: absolute;
            width: 200%; height: 2px;
            background: linear-gradient(90deg, transparent, rgba(191,35,41,.35), transparent);
            left: -50%;
        }
        .stripe-1 { top: 38%; transform: rotate(-5deg); }
        .stripe-2 { top: 62%; transform: rotate(-5deg); opacity: .4; }

        .brand-content {
            position: relative;
            z-index: 1;
            text-align: center;
            color: #a71111;
            padding: 3rem 2.5rem;
        }
        .brand-content img {
            display: block;
            margin: 0 auto 2rem;
            margin-left: 8rem;
        }
        .brand-tagline {
            font-size: 1.05rem;
            color: rgba(255,255,255,.45);
            line-height: 1.6;
            max-width: 280px;
            margin: 0 auto 2.5rem;
        }
        .brand-badges {
            display: flex;
            flex-direction: column;
            gap: .6rem;
            align-items: center;
        }
        .brand-badge {
            display: inline-flex;
            align-items: center;
            gap: .5rem;
            font-size: .75rem;
            color: rgba(255,255,255,.4);
            border: 1px solid rgba(255,255,255,.08);
            border-radius: 20px;
            padding: .35rem 1rem;
            background: rgba(255,255,255,.03);
            backdrop-filter: blur(8px);
        }
        .brand-badge i { color: var(--dnn-red); }

        .panel-form {
            width: 100%;
            max-width: 460px;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2.5rem 2rem;
            background: #fff;
            flex-shrink: 0;
        }
        @media (max-width: 991px) {
            body { background: #fff; justify-content: center; align-items: center; min-height: 100vh; }
            .panel-form { max-width: 100%; min-height: 100vh; }
        }

        .form-box { width: 100%; max-width: 340px; }

        .logo-mobile { display: none; text-align: center; margin-bottom: 2rem; }
        @media (max-width: 991px) { .logo-mobile { display: block; } }

        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(18px); }
            to   { opacity: 1; transform: translateY(0); }
        }
        .form-box { animation: fadeUp .4s .05s ease both; }

        .form-title { font-size: 1.6rem; font-weight: 700; color: #111827; margin-bottom: .3rem; }
        .form-subtitle { color: #6b7280; font-size: .875rem; margin-bottom: 2rem; }

        .form-label { font-size: .8rem; font-weight: 600; color: #374151; margin-bottom: .4rem; display: block; }
        .input-wrap { position: relative; }
        .input-wrap .bi {
            position: absolute;
            left: .85rem;
            top: 50%;
            transform: translateY(-50%);
            color: #9ca3af;
            font-size: .9rem;
            pointer-events: none;
        }
        .input-wrap input {
            width: 100%;
            padding: .65rem .85rem .65rem 2.4rem;
            border: 1.5px solid #e5e7eb;
            border-radius: 9px;
            font-size: .9rem;
            outline: none;
            color: #111827;
            transition: border-color .15s, box-shadow .15s;
            font-family: inherit;
        }
        .input-wrap input:focus {
            border-color: var(--dnn-red);
            box-shadow: 0 0 0 3px rgba(191,35,41,.11);
        }
        .input-wrap input::placeholder { color: #c4c9d4; }

        .btn-login {
            display: block;
            width: 100%;
            padding: .72rem;
            background: var(--dnn-red);
            color: #fff;
            border: none;
            border-radius: 9px;
            font-size: .95rem;
            font-weight: 600;
            font-family: inherit;
            cursor: pointer;
            transition: background .18s, box-shadow .18s, transform .1s;
        }
        .btn-login:hover {
            background: var(--dnn-red-dark);
            box-shadow: 0 6px 20px rgba(191,35,41,.32);
        }
        .btn-login:active { transform: scale(.98); }

        .footer-note {
            text-align: center;
            font-size: .73rem;
            color: #c4c9d4;
            margin-top: 2.5rem;
        }
    </style>
</head>
<body>

    <div class="panel-brand" id="brandPanel">
        <div class="p-layer" id="layer1">
            <div class="orb orb-1"></div>
            <div class="orb orb-2"></div>
            <div class="orb orb-3"></div>
        </div>
        <div class="p-layer" id="layer2">
            <div class="grid-layer"></div>
            <div class="stripe stripe-1"></div>
            <div class="stripe stripe-2"></div>
        </div>
        <div class="brand-content">
            <img src="${pageContext.request.contextPath}/images/logo-white.svg" alt="Dunnas Residences" height="128">
            <p class="brand-tagline">Gestão inteligente de chamados para o seu condomínio.</p>
            <div class="brand-badges">
                <div class="brand-badge"><i class="bi bi-shield-check"></i> Acesso seguro e auditado</div>
                <div class="brand-badge"><i class="bi bi-bell"></i> Chamados em tempo real</div>
                <div class="brand-badge"><i class="bi bi-people"></i> Controle por perfil de acesso</div>
            </div>
        </div>
    </div>

    <div class="panel-form">
        <div class="form-box">
            <div class="logo-mobile">
                <img src="${pageContext.request.contextPath}/images/logo.svg" alt="Dunnas Residences" height="60">
            </div>

            <p class="form-title">Bem-vindo de volta</p>
            <p class="form-subtitle">Insira suas credenciais para acessar o sistema.</p>

            <c:if test="${param.error != null}">
                <div style="background:#fef2f2;border:1px solid #fecaca;border-radius:8px;padding:.6rem .9rem;font-size:.82rem;color:#b91c1c;margin-bottom:1rem;display:flex;align-items:center;gap:.5rem">
                    <i class="bi bi-exclamation-circle"></i> E-mail ou senha incorretos.
                </div>
            </c:if>
            <c:if test="${param.logout != null}">
                <div style="background:#f0fdf4;border:1px solid #bbf7d0;border-radius:8px;padding:.6rem .9rem;font-size:.82rem;color:#166534;margin-bottom:1rem;display:flex;align-items:center;gap:.5rem">
                    <i class="bi bi-check-circle"></i> Você saiu com sucesso.
                </div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/login">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

                <div class="mb-3">
                    <label for="email" class="form-label">E-mail</label>
                    <div class="input-wrap">
                        <i class="bi bi-envelope"></i>
                        <input id="email" type="email" name="username"
                               placeholder="seu@email.com" required autofocus>
                    </div>
                </div>

                <div class="mb-4">
                    <label for="password" class="form-label">Senha</label>
                    <div class="input-wrap">
                        <i class="bi bi-lock"></i>
                        <input id="password" type="password" name="password"
                               placeholder="••••••••" required>
                    </div>
                </div>

                <button type="submit" class="btn-login">Entrar</button>
            </form>

            <p class="footer-note">&copy; 2026 Dunnas Residences &mdash; Todos os direitos reservados.</p>
        </div>
    </div>

    <script>
        const panel = document.getElementById('brandPanel');
        const l1 = document.getElementById('layer1');
        const l2 = document.getElementById('layer2');
        if (panel) {
            panel.addEventListener('mousemove', (e) => {
                const r = panel.getBoundingClientRect();
                const dx = (e.clientX - r.left - r.width / 2) / r.width;
                const dy = (e.clientY - r.top - r.height / 2) / r.height;
                l1.style.transition = 'transform .06s linear';
                l2.style.transition = 'transform .10s linear';
                l1.style.transform = `translate(${dx * 28}px, ${dy * 28}px)`;
                l2.style.transform = `translate(${dx * 12}px, ${dy * 12}px)`;
            });
            panel.addEventListener('mouseleave', () => {
                l1.style.transition = 'transform .7s ease';
                l2.style.transition = 'transform .7s ease';
                l1.style.transform = 'translate(0,0)';
                l2.style.transform = 'translate(0,0)';
            });
        }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
