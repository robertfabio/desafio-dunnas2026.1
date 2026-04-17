<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Página não encontrada — Dunnas Residences</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --dnn-red:       #bf2329;
            --dnn-red-dark:  #8e1016;
            --dnn-red-light: #f8e6e7;
        }

        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            min-height: 100vh;
            background: #f3f4f6;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', system-ui, sans-serif;
            overflow: hidden;
        }

        .bg-blob {
            position: fixed;
            border-radius: 50%;
            filter: blur(80px);
            opacity: .12;
            pointer-events: none;
            z-index: 0;
        }
        .bg-blob-1 {
            width: 500px; height: 500px;
            background: var(--dnn-red);
            top: -120px; left: -120px;
            animation: drift 14s ease-in-out infinite;
        }
        .bg-blob-2 {
            width: 380px; height: 380px;
            background: #1a1d23;
            bottom: -80px; right: -80px;
            animation: drift 18s ease-in-out infinite reverse;
        }
        @keyframes drift {
            0%, 100% { transform: translate(0, 0); }
            50%       { transform: translate(30px, 20px); }
        }

        .card-error {
            position: relative;
            z-index: 1;
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,.10);
            padding: 3.5rem 3rem;
            text-align: center;
            max-width: 480px;
            width: 90%;
        }

        .brand-logo {
            margin-bottom: 2rem;
        }
        .brand-logo img {
            height: 72px;
        }

        .code-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 88px; height: 88px;
            border-radius: 50%;
            background: var(--dnn-red-light);
            margin-bottom: 1.25rem;
        }
        .code-badge i {
            font-size: 2.4rem;
            color: var(--dnn-red);
        }

        .error-number {
            font-size: 5rem;
            font-weight: 900;
            line-height: 1;
            color: #111827;
            letter-spacing: -.04em;
            margin-bottom: .5rem;
        }
        .error-number span {
            color: var(--dnn-red);
        }

        .error-title {
            font-size: 1.25rem;
            font-weight: 700;
            color: #111827;
            margin-bottom: .5rem;
        }

        .error-desc {
            font-size: .9rem;
            color: #6b7280;
            line-height: 1.6;
            margin-bottom: 2rem;
        }

        .btn-home {
            display: inline-flex;
            align-items: center;
            gap: .5rem;
            background: var(--dnn-red);
            color: #fff;
            border: none;
            border-radius: 10px;
            padding: .65rem 1.5rem;
            font-weight: 600;
            font-size: .9rem;
            text-decoration: none;
            transition: background .2s, transform .15s;
        }
        .btn-home:hover {
            background: var(--dnn-red-dark);
            color: #fff;
            transform: translateY(-1px);
        }

        .footer-note {
            margin-top: 2rem;
            font-size: .75rem;
            color: #9ca3af;
        }
    </style>
</head>
<body>
    <div class="bg-blob bg-blob-1"></div>
    <div class="bg-blob bg-blob-2"></div>

    <div class="card-error">
        <div class="brand-logo">
            <img src="${pageContext.request.contextPath}/images/logo.svg" alt="Dunnas Residences">
        </div>

        <div class="code-badge">
            <i class="bi bi-map"></i>
        </div>

        <div class="error-number"><span>4</span>0<span>4</span></div>
        <div class="error-title">Página não encontrada</div>
        <p class="error-desc">
            O endereço que você acessou não existe ou foi removido.<br>
            Verifique o link ou volte para a página inicial.
        </p>

        <a href="${pageContext.request.contextPath}/" class="btn-home">
            <i class="bi bi-house-door-fill"></i>
            Voltar ao início
        </a>

        <div class="footer-note">Dunnas Residences &mdash; Sistema de Gestão Condominial</div>
    </div>
</body>
</html>
