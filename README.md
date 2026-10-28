# Agenda Fotográfica — versão 2

Aplicação web para agenda de ensaios, contactos, controlo de pagamentos em reais e atalhos de WhatsApp.

## O que funciona nesta versão
- Dashboard com totais contratados, recebidos e saldos em aberto.
- Calendário mensal e lista de ensaios.
- Criar e editar clientes/ensaios.
- Cálculo automático do saldo (pacote menos sinal e pagamentos adicionais).
- Atalho manual de WhatsApp com texto personalizado.
- Exportação CSV.
- Modo local para testar sem conta.
- Integração preparada com Supabase Auth + tabela protegida por Row Level Security.

## Limitação importante
A sincronização na nuvem só funciona depois de configurar um projeto Supabase. Enquanto não configurar, os dados ficam apenas no armazenamento local do navegador e não são sincronizados entre dispositivos. A aplicação não envia mensagens automáticas de WhatsApp; o botão abre o WhatsApp para o usuário confirmar/enviar. Lembretes automáticos exigem um serviço agendador e a WhatsApp Business Platform/Cloud API, normalmente com configuração e possíveis custos.

## Publicar gratuitamente no GitHub Pages
1. Crie um repositório GitHub chamado `agenda-fotografica`.
2. Envie `index.html` para a raiz do repositório.
3. Abra **Settings → Pages**.
4. Em Build and deployment, escolha **Deploy from a branch**, branch `main`, pasta `/(root)`.
5. Guarde o endereço público apresentado pelo GitHub Pages.

## Ativar login e sincronização gratuita com Supabase
1. Crie um projeto em https://supabase.com/ e guarde a URL do projeto e a chave publicável (anon/public key).
2. No painel Supabase, abra **SQL Editor**, crie uma query e cole todo o conteúdo de `supabase-schema.sql`; execute.
3. Abra `index.html` num editor de texto. Procure por:
   - `const SUPABASE_URL = 'COLE_AQUI_A_URL_DO_SUPABASE';`
   - `const SUPABASE_ANON_KEY = 'COLE_AQUI_A_CHAVE_PUBLICA_ANON';`
4. Substitua os valores pela URL do projeto e pela chave pública/anon do Supabase.
   - Não use nem publique a chave `service_role` ou qualquer segredo privado.
5. Salve e envie novamente `index.html` ao GitHub.
6. No Supabase, configure **Authentication → URL Configuration**:
   - Site URL: o URL do seu GitHub Pages.
   - Redirect URLs: inclua o mesmo URL.
7. Abra a aplicação, clique em **Entrar / sincronizar**, crie uma conta com e-mail e senha e entre.
8. Faça um ensaio de teste. Abra a aplicação noutro dispositivo e entre com a mesma conta.

### Segurança e dados
- A tabela usa Row Level Security para que cada conta só leia e altere os seus próprios ensaios.
- Use uma senha única e forte e não compartilhe o login.
- Não armazene informações excessivas ou sensíveis dos clientes.
- Faça exportações CSV de backup periodicamente.
- A primeira configuração cloud não importa automaticamente os dados locais de demonstração ou ensaios locais. Após login, os dados da nuvem passam a ser carregados; crie novamente ou migre os ensaios reais conforme necessário.

## Lembretes
O botão WhatsApp prepara uma mensagem individual para o cliente. Não envia sozinho. Para automatizar lembretes de contrato dois dias antes e do ensaio um dia antes, a próxima etapa seria integrar um agendador/servidor e a WhatsApp Business Platform, além de registrar consentimento e tratar falhas de envio. Não coloque tokens da API do WhatsApp no código do navegador.

## Arquivos
- `index.html`: aplicação.
- `supabase-schema.sql`: tabela e políticas de segurança.
- `README.md`: instruções.
