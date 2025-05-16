# FlutterAndExpressTicketProject
Projeto acadêmico. Sistema de adquirição e listagem de ingressos, diferenciando-os em áreas do show 

O usuário preenche um formulário com nome, CPF, e-mail e escolhe a área (Pista ou Camarim). Quando envia, os dados são enviados via HTTP para uma API feita em Node.js com Express, que salva os ingressos em um arquivo tickets.json. Também é possível buscar os ingressos cadastrados por área

preenche → envia → API recebe → salva no JSON → pode consultar depois

para executar a API é necessario ter o Node instalado. Digite <b>node index.js</b> para rodar o back </br>
para executar o APP é necessario ter o dart e o flutter instalado. Digite <b>flutter run</b> para rodar o app
