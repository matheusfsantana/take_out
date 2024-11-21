# take_out

Aplicação desenvolvida no Crash Course do TreinaDev13, a ideia é ser uma aplicação para o modelo de restaurante Take away/take-out, é um modelo oferecido pelos restaurantes no qual o consumidor opta por retirar seu pedido diretamente no estabelecimento. 

O sistema contempla a gestão de pratos, cardápios e pedidos para esse tipo de estabelecimento e será usado exclusivamente pelos funcionários do estabelecimento, sem a opção de acesso por parte dos clientes finais.

Será possível cadastrar o estabelecimento, cadastrar pratos e bebidas, organizar cardápios, gerar pedidos e gerenciar o andamento de cada pedido.

## Pré-requisitos
- Ruby 3.3.1
- Rails >= 7.2.1.1
- Gem 3.5.22
- Bundle 2.5.22

## Como rodar a aplicação

No terminal, clone o repositorio:

```bash
   $ git clone https://github.com/matheusfsantana/take_out.git
```

Acesse o diretório

```bash
   $ cd take_out
```

Instale as dependencias

```bash
   $ bundle install
```

Utilize o comando a seguir para criar o banco, fazer as migrations e rodar os seeds:

```bash
   $ rails db:create db:migrate db:seed
```

Execute o comando para rodar a aplicação

```bash
   $ rails server
```

## Usuários
|Email|Password|Role|Acesso|
| -------- | -------- | -------- |-------- |
|admin@gmail.com|password1234|owner (Dono do restaurante)| Acesso total |
|employee@gmail.com|password1234|employee (Funcionário do restaurante)| Acesso aos pedidos, clientes e cardápios |

## Link acompanhamento de pedidos

http://127.0.0.1:3000/orders/search