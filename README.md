# Projeto DevOps: dupla-03

Site: https://gustavohenriques99.github.io/DevOpsNaNuvem_dupla-03/ (status em /status.html)
Imagem: ghcr.io/gustavohenriques99/devopsnanuvem_dupla-03

## O fluxo completo
Quando enviamos uma tag que começa com v (por exemplo, v1), o GitHub Actions dispara o fluxo Publicar imagem. Ele baixa o código, instala o Python e roda os testes. Se os testes passam, o fluxo entra no ghcr.io com o token do próprio GitHub e constrói a imagem com o --build-arg, que leva o nome da tag para o ARG e o ENV do Dockerfile. Depois publica a imagem com essa tag. Para colocar no ar, basta fazer o docker pull dessa imagem e o docker run com a porta mapeada (-p 50072:50072). Já o push na main dispara o CI e o fluxo Publicar site com status, que roda os testes antes de gerar o status.html e publicar o site.

## Linha do tempo
- v1 (f357cfd): Dockerfile com ARG e ENV, o fluxo publicar-imagem.yml e a primeira imagem publicada. O /saude respondeu versao v1.
- v2 (39c3789): a porta do app.py foi trocada para 50073. O pipeline ficou todo verde, mas o contêiner não respondeu na porta 50072 que estava mapeada.
- v3 (e94b16e): por engano revertemos o commit errado (Publicação de imagem versionada), que removeu o fluxo de publicação. A imagem v3 nunca foi publicada.
- v4 (f14329d): desfizemos o revert errado (Reapply) e depois revertemos o commit certo (Refatoração da porta). O fluxo publicou a imagem e o /saude voltou a responder.

## O que os testes não pegaram
Os testes usam o test_client() do Flask, que chama a aplicação direto, sem abrir nenhuma porta de rede. Por isso a v2 passou em todos os testes, mesmo escutando na porta errada. O que faltou foi um teste de fumaça: subir o contêiner e dar curl em /saude antes de publicar a imagem, o que pegaria a falha antes da v2 chegar ao registro.

## Quem fez o quê
Aluno A (Gustavo): fez o passo 2, a página de status e os testes antes da publicação do site (commits 65efbe1, 1daf311 e 19b50b2).
Aluno B (Jackson): fez os passos 3 e 4 (Dockerfile, fluxo de publicação e a tag v1) e seguiu sozinho a partir do passo 5: conferiu a imagem, simulou a falha da v2, fez os dois rollbacks, o revert e este README.
