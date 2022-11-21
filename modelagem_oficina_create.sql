-- Criação do Banco de Dados para uma Oficina de Carros 

drop database Oficina;
create database Oficina;
use Oficina;

-- criando tabela Cliente
create table Cliente(
	idCliente int auto_increment primary key,
    Nome varchar(45),
    CPF char(11) not null,
    Endereço varchar(255),
    Telefone int not null,
    constraint unique_cpf_client unique (CPF)
);

alter table Cliente auto_increment=1;

-- criando a tabela Veículo
create table Veiculo(
	IdVeiculo int auto_increment primary key,
    IdVeiculo_cliente int,
    Marca varchar(15) not null,
    Modelo varchar(15) not null,
    Ano varchar(10) not null,
    Placa char(7) not null unique,
	constraint fk_veiculo_cliente foreign key(IdVeiculo_cliente) references Cliente(idCliente)
);

-- criando tabela Ordem de Serviço
create table OS (
	IdOS int auto_increment primary key,
    IdOSVeiculo int,
    Descrição varchar (255) not null,
    DataEmissão datetime not null,
    StatusOS enum('Andamento', 'Finalizado', 'Entregue') default 'Andamento',
    DataEntrega date,
    constraint fk_os_veiculo foreign key(IdOSVeiculo) references Veiculo(IdVeiculo) on update cascade
);

-- criando tabela Pagamento
create table Pagamento(
	IdPagamento int auto_increment primary key,
    IdOSPagamento int,
    FormaPagamento enum('Cartão de Crédito', 'Cartão de Débito', 'PIX', 'Dinheiro') default 'Cartão de Crédito',
    limitAvailable boolean,
    constraint fk_os_pagamento foreign key(IdOSPagamento) references OS(IdOS)
);

-- criando tabela Preços
create table Preço(
	IdPreco int auto_increment primary key,
    IdOSPreco int,
    MãodeObra int not null,
    Pecas varchar(255),
    constraint fk_os_preco foreign key(IdOSPreco) references OS(IdOS)
);

-- criando tabela de Serviços
create table Serviços(
	IdServico int auto_increment primary key,
    IdOsServico int,
    Conserto varchar(255),
    Revisão varchar(255),
    constraint fk_os_servico foreign key(IdOsServico) references OS(IdOS)
);
-- criando tabela Mecânicos
create table Mecanicos(
	IdMecanico int auto_increment primary key,
    IdOSMecanico int,
    NomeMecanico varchar(45) not null,
    CPF char(9) not null,
    Endereço varchar(255) not null,
    Especialidade varchar(255) not null,
    constraint unique_cpf_mecanico unique(CPF)
);

-- criando tabela Equipe Mecânicos
create table EquipeMecanicos(
	IdEquipeOS int,
    IdEquipeMecanicos int,
    Integrantes varchar(255),
    primary key(IdEquipeOS, IdEquipeMecanicos),
    constraint fk_equipe_os foreign key(IdEquipeOS) references OS(IdOS),
    constraint fk_equipe_mecanicos foreign key(IdEquipeMecanicos) references Mecanicos(IdMecanico)
);

