CREATE TABLE rangos (
    id_rango SERIAL PRIMARY KEY,
    nombre_rango VARCHAR(50) NOT NULL
);

CREATE TABLE investigadores (
    id_investigador SERIAL PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    id_rango INT NOT NULL
);

CREATE TABLE laboratorios (
    id_laboratorio SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    nivel_bioseguridad INT NOT NULL,
    capacidad INT NOT NULL
);

CREATE TABLE equipos (
    id_equipo SERIAL PRIMARY KEY,
    nombre_equipo VARCHAR(100) NOT NULL,
    estado_operativo VARCHAR(50) NOT NULL,
    id_laboratorio INT NOT NULL
);

CREATE TABLE reservas (
    id_reserva SERIAL PRIMARY KEY,
    id_investigador INT NOT NULL,
    id_laboratorio INT NOT NULL,
    fecha_reserva DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL
);

CREATE TABLE reserva_equipos (
    id_reserva INT NOT NULL,
    id_equipo INT NOT NULL,
    PRIMARY KEY (id_reserva, id_equipo)
);

CREATE TABLE log_auditoria (
    id_log SERIAL PRIMARY KEY,
    usuario_db VARCHAR(50) NOT NULL,
    fecha_hora TIMESTAMP NOT NULL,
    accion TEXT NOT NULL
);