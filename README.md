# WeatherHere - Previsão do Tempo

Bem-vindo ao **WeatherHere**, um aplicativo intuitivo e funcional que fornece informações detalhadas sobre o clima atual e previsões para os próximos dias! Desenvolvido com Flutter, o WeatherHere foi criado para tornar mais acessível a consulta de condições climáticas de qualquer lugar, em qualquer momento.

---

## Sobre o Projeto

O WeatherHere é um aplicativo que exibe informações meteorológicas de forma clara e organizada. Ele apresenta:

- **Previsão para Hoje e os Próximos Dias:** Mostra o clima atual e previsões para os dois dias seguintes, incluindo temperatura máxima e mínima.
- **Icones de Condição Climática:** Representações visuais do estado do clima (como sol, chuva ou nublado).
- **Suporte a Localização Atual:** Detecta automaticamente sua localização para exibir informações precisas do clima.
- **Busca por Cidade:** Permite pesquisar o clima de qualquer local no mundo digitando o nome da cidade.

A interface responsiva e moderna foi projetada para oferecer uma experiência simples e agradável, mesmo para novos usuários.

---

## Tempo de Desenvolvimento

O desenvolvimento do aplicativo levou **cerca de 10 dias**. Durante esse período, passei por diversas etapas:

1. **Planejamento e Design:** Decidi como a interface funcionaria e quais recursos eram essenciais.
2. **Integração da API OpenWeather:** Configurei o acesso a dados meteorológicos usando a API, o que foi um grande aprendizado.
3. **Tratamento de Erros e Dados Simulados:** Enquanto não tinha acesso completo ao serviço de previsão extendida, criei mockups para testar as funcionalidades.
4. **Aprimoramento da Interface:** Ajustei pequenos detalhes visuais para melhorar a experiência do usuário.

---

## Dificuldades

O desenvolvimento não foi sem desafios. Alguns dos principais foram:

- **Integração com a API:** Tive dificuldades iniciais com o endpoint da API do OpenWeather, principalmente ao trabalhar com previsões futuras. Foi necessário estudar a documentação oficial e fazer vários testes com `Postman`.

- **Erro 401 (Unauthorized):** Passei um tempo depurando um problema relacionado à chave de acesso da API. Descobri que minha chave não tinha permissões para o recurso “one call”, então precisei simular alguns dados.

- **Organização do Estado:** Trabalhar com estado em Flutter exigiu revisitar conceitos para garantir que os dados fossem atualizados de forma eficiente na interface.

---

## Facilidade

O que funcionou bem durante o desenvolvimento:

- **Componentização no Flutter:** Criar widgets reutilizáveis para as partes do aplicativo (como os cards de previsão) foi incrivelmente eficiente e reduziu o código duplicado.

- **Suporte da Comunidade:** Sempre que surgia uma dúvida, recorri à comunidade de desenvolvedores no [StackOverflow](https://stackoverflow.com/) e na documentação oficial do Flutter. As respostas foram muito útis.

---

## Tecnologias Utilizadas

- **Flutter**: Framework principal para o desenvolvimento do aplicativo.
- **OpenWeatherMap API**: Fornecimento de dados climáticos.
- **Dart**: Linguagem de programação utilizada com Flutter.
- **Git**: Controle de versão do projeto.

---

## Aprendizados

Ao final do projeto, ganhei uma compreensão mais profunda sobre:

1. **Consumo de APIs RESTful:** Entendi como consumir e tratar dados externos de forma eficiente.
2. **Gerenciamento de Estado no Flutter:** Melhorei minhas habilidades em atualizar e organizar dados na interface.
3. **Resiliência:** Percebi que problemas como erros de integração ou restrições em APIs podem ser contornados com simulação de dados e criatividade.

---

## Como Executar o Projeto

1. Clone este repositório:
   ```bash
   git clone https://github.com/seu-usuario/weatherhere.git
   ```

2. Instale as dependências:
   ```bash
   flutter pub get
   ```

3. Configure sua chave de API no arquivo de serviço:
   ```dart
   final String KeyApi = 'SUA_CHAVE_AQUI';
   ```

4. Execute o projeto:
   ```bash
   flutter run
   ```

---

## Considerações Finais

Este projeto foi uma experiência incrível de aprendizado e desenvolvimento. Embora tenha enfrentado desafios, eles me ensinaram a encontrar soluções criativas e a valorizar o suporte da comunidade de tecnologia. Estou ansioso para continuar aprimorando o WeatherHere e explorando novas funcionalidades!

Sinta-se à vontade para explorar, usar e contribuir para o projeto. Feedbacks são sempre bem-vindos!

---