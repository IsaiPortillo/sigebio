-- Rangos
INSERT INTO rangos (nombre_rango) VALUES 
('Junior'), ('Junior'), ('Senior'), ('Senior'), ('Director de Proyecto');

-- Investigadores
INSERT INTO investigadores (nombres, apellidos, id_rango) VALUES 
('Fernando', 'Amaya', 1),
('Mario', 'Amaya', 2),
('Maria', 'Teresa', 3),
('Luis', 'Martinez', 4),
('Josefa', 'Ramires', 5);

-- Laboratorios
INSERT INTO laboratorios (nombre, nivel_bioseguridad, capacidad) VALUES 
('Lab Microbiologia', 1, 20),
('Lab Virología B2', 2, 15),
('Lab Contencion B3', 3, 10),
('Lab Alta Seguridad 1', 4, 5),
('Lab Alta Seguridad 2', 4, 5);

-- Equipos
INSERT INTO equipos (nombre_equipo, estado_operativo, id_laboratorio, ultima_revision) VALUES 
('Microscopio Optico', 'Operativo', 1, '2026-01-10'),
('Centrifuga', 'Operativo', 2, '2026-02-15'),
('Campana Extractora', 'Mantenimiento', 3, '2026-03-20'),
('Secuenciador ADN', 'Operativo', 4, '2026-04-05'),
('Incubadora Especial', 'Operativo', 5, '2026-04-10');

-- Reservas (Sofía es Directora y puede reservar Nivel 4)
INSERT INTO reservas (id_investigador, id_laboratorio, fecha_reserva, hora_inicio, hora_fin) VALUES 
(1, 1, '2026-04-25', '08:00:00', '10:00:00'),
(2, 2, '2026-04-25', '10:00:00', '12:00:00'),
(3, 3, '2026-04-26', '09:00:00', '11:00:00'),
(5, 4, '2026-04-26', '13:00:00', '16:00:00'),
(5, 5, '2026-04-27', '08:00:00', '12:00:00');

-- Reserva_Equipos
INSERT INTO reserva_equipos (id_reserva, id_equipo) VALUES 
(1, 1),
(2, 2),
(4, 4),
(5, 5),
(1, 2);