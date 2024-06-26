create database kronosbooking;
#drop database kronosbooking;
use  kronosbooking;
CREATE TABLE endereco (
    id_endereco INT PRIMARY KEY AUTO_INCREMENT,
    logradouro VARCHAR(50),
    cep VARCHAR(8),
    numero INT,
    bairro VARCHAR(50),
    cidade VARCHAR(60),
    estado VARCHAR(2)
);

CREATE TABLE complemento (
    id_complemento INT PRIMARY KEY AUTO_INCREMENT,
    complemento VARCHAR(70),
    fk_endereco INT,
    FOREIGN KEY (fk_endereco) REFERENCES endereco(id_endereco)
);

CREATE TABLE horario_funcionamento (
    id_horario_funcionamento INT PRIMARY KEY AUTO_INCREMENT,
    dia_semana VARCHAR(45),
    horario_abertura varchar(5),
    horario_fechamento varchar(5)
);

CREATE TABLE empresa (
    id_empresa INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(70),
    contato CHAR(11),
    cnpj VARCHAR(14),
    endereco_id_endereco INT,
    fk_horario_funcionamento INT,
    FOREIGN KEY (endereco_id_endereco) REFERENCES endereco(id_endereco),
    FOREIGN KEY (fk_horario_funcionamento) REFERENCES horario_funcionamento(id_horario_funcionamento)
);

CREATE TABLE nivel_acesso (
    id_nivel_acesso INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(30),
    nivel INT,
    descricao VARCHAR(100)
);

CREATE TABLE ficha_anamnese (
    id_ficha INT PRIMARY KEY AUTO_INCREMENT,
    data_preenchimento DATETIME
);

CREATE TABLE usuario (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    email VARCHAR(100),
    senha VARCHAR(10),
    instagram VARCHAR(50),
    cpf VARCHAR(11),
    telefone BIGINT,
    telefone_emergencial BIGINT,
    data_nasc DATE,
    genero VARCHAR(100),
    indicacao VARCHAR(100),
    foto BLOB,
    status boolean,
    fk_nivel_acesso INT,
    fk_endereco INT,
    fk_empresa INT,
    fk_ficha_anamnese INT,
    FOREIGN KEY (fk_nivel_acesso) REFERENCES nivel_acesso(id_nivel_acesso),
    FOREIGN KEY (fk_endereco) REFERENCES endereco(id_endereco),
    FOREIGN KEY (fk_empresa) REFERENCES empresa(id_empresa),
    FOREIGN KEY (fk_ficha_anamnese) REFERENCES ficha_anamnese(id_ficha)
);

CREATE TABLE pergunta (
    id_pergunta INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(45),
    tipo VARCHAR(45), 
    status boolean
);

CREATE TABLE resposta (
	id_resposta INT PRIMARY KEY AUTO_INCREMENT,
    fk_pergunta INT,
	fk_ficha INT,
    fk_usuario INT,
    resposta_cliente VARCHAR(45),
    FOREIGN KEY (fk_pergunta) REFERENCES pergunta(id_pergunta),
    FOREIGN KEY (fk_ficha) REFERENCES ficha_anamnese(id_ficha),
     FOREIGN KEY (fk_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE status_agendamento (
    id_status_agendamento INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(30),
    cor VARCHAR(10),
    motivo VARCHAR(45)
);

CREATE TABLE procedimento (
    id_procedimento INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(50),
    descricao VARCHAR(45)
);

CREATE TABLE tempo_procedimento (
    id_tempo_procedimento INT PRIMARY KEY AUTO_INCREMENT,
    tempo_colocacao varchar(5),
    tempo_manutencao varchar(5),
    tempo_retirada varchar(5)
);

CREATE TABLE especificacao_procedimento (
    id_especificacao_procedimento INT PRIMARY KEY AUTO_INCREMENT,
    especificacao VARCHAR(70),
    preco_colocacao DOUBLE,
    preco_manutencao DOUBLE,
    preco_retirada DOUBLE,
    foto BLOB,
    fk_tempo_procedimento INT,
    fk_procedimento INT,
    FOREIGN KEY (fk_tempo_procedimento) REFERENCES tempo_procedimento(id_tempo_procedimento),
    FOREIGN KEY (fk_procedimento) REFERENCES procedimento(id_procedimento)
);

CREATE TABLE agendamento (
    id_agendamento INT PRIMARY KEY AUTO_INCREMENT,
    data DATETIME,
    horario TIMESTAMP,
    tipo_agendamento INT,
    fk_usuario INT,
    fk_procedimento INT,
    fk_status INT,
    FOREIGN KEY (fk_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (fk_procedimento) REFERENCES procedimento(id_procedimento),
    FOREIGN KEY (fk_status) REFERENCES status_agendamento(id_status_agendamento)
);

CREATE TABLE feedback (
    id_feedback INT PRIMARY KEY AUTO_INCREMENT,
    anotacoes VARCHAR(200),
    nota INT,
    fk_agendamento INT,
    fk_usuario INT,
    FOREIGN KEY (fk_agendamento) REFERENCES agendamento(id_agendamento),
    FOREIGN KEY (fk_usuario) REFERENCES usuario(id_usuario)
);

-- Criar tabela de Publicacao
CREATE TABLE publicacao (
    id_publicacao INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(255) NOT NULL,
    legenda VARCHAR(255),
    foto VARCHAR(255),
    curtidas INT NOT NULL DEFAULT 0,
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- Criar tabela de Comentario
CREATE TABLE comentario (
    id_comentario INT PRIMARY KEY AUTO_INCREMENT,
    texto VARCHAR(255) NOT NULL,
    curtidas INT NOT NULL DEFAULT 0,
    id_publicacao INT,
    id_usuario INT,
    FOREIGN KEY (id_publicacao) REFERENCES publicacao(id_publicacao),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

select * from comentario;