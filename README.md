Dataset Template :ramen:
==

Este repositório visa documentar padronizações que poderão ser utilizadas como template para novos conjuntos de dados a serem publicados no [Portal de Dados Abertos do Estado de Minas Gerais - PDA/MG](https://dados.mg.gov.br/).

O principal objetivo é a disseminação de melhores práticas em relação as ferramentas utilizadas no âmbito da Diretoria de Transparência Ativa - DTA, e, ao mesmo tempo, a redução do trabalho repetitivo na inicialização de um novo conjunto de dados e sua publicação no [PDA/MG](https://dados.mg.gov.br/).

#### Diretrizes

  + Utilização padrão [frictionless](https://specs.frictionlessdata.io/#overview) de documentação de conjunto de dados;
  + Utilização pacote python [dpckan](https://pypi.org/project/dpckan/) para publicação e atualização dos conjuntos de dados;
  + Schema e Dialetic documentados fora do arquivo datapackage.json; e
  + Validação dados x metadados realizada local e remotamente (github action).

#### Utilização:

  + Criação de repositório a partir do repositório template;
  + Clone local do novo repositório criado;
  + Criação do ambiente python:

```Terminal
# Sistema operacional windows
$ make venv-create-windows

# Sistema operacional linux
$ make venv-create-linux
```

  + Ativação dp ambiente python:

```Terminal
# Sistema operacional windows
$ source venv/Scripts/activate

# Sistema operacional linux
$ source venv/bin/activate
```

  + Instalação pacotes python:

```Terminal
$ make install-packages
```

  + Validação conjunto de dados:

```
$ make dataset-validate
```

  + Publicando conjunto de dados:

```
$ make dataset-create
```
