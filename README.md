Conjuntos De Dados Padronizados
==

Este repositório visa documentar padronizações que poderão ser utilizadas como templates para novos conjuntos de dados a serem publicados no [Portal de Dados Abertos do Estado de Minas Gerais - PDA/MG](https://dados.mg.gov.br/).

O principal objetivo para adoção destes diretórios padronizados é a disseminação de melhores práticas em relação as ferramentas utilizadas no âmbito da Diretoria Centra de Transparência Ativa - DTA, e, ao mesmo tempo, a redução do trabalho repetitivo na inicialização de um novo conjunto de dados e sua publicação no [PDA/MG](https://dados.mg.gov.br/).

#### As estruturas padronizadas dos novos conjuntos seguirá a seguinte divisão:

- [Conjuntos Essenciais](https://github.com/dados-mg/datasets-template/tree/conjunto-essencial):

    - Schema e Dialetic documentados dentro do arquivo datapackage.json; e

    - Validação dados x metadados realizada local e remotamente (github action).

- [Conjuntos Intermediários]():

    - Schema e Dialetic documentados em arquivos externos e referenciados no arquivo datapackage.json; e

    - Validação dados x metadados realizada local e remotamente (github action).

- [Conjuntos Avançados]():

    - Schema e Dialetic documentados em arquivos externos e referenciados no arquivo datapackage.json;

    - Validação dados x metadados realizada local e remotamente (github action); e

    - Utilização da ferramenta [Git Large Files - glf](https://git-lfs.github.com/)

#### Ferramentas:

- Todos os conjuntos:

  - [Controle de Versão Git](https://git-scm.com/);

  - [Repositório online com controle de versão github](https://github.com/);

  - [Padrão Frictionless de documentação de conjunto de dados sem fricção](https://frictionlessdata.io/); e

  - [Biblioteca Python dpckan](https://pypi.org/project/dpckan/)

- Casos Específicos:

  - [Git Large Files - glf](https://git-lfs.github.com/)
