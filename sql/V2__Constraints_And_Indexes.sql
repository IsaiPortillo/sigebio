-- Restricciones de integridad referencial
ALTER TABLE investigadores
    ADD CONSTRAINT fk_inv_rango FOREIGN KEY (id_rango) REFERENCES rangos(id_rango) ON DELETE SET NULL;

ALTER TABLE equipos
    ADD CONSTRAINT fk_equipo_lab FOREIGN KEY (id_laboratorio) REFERENCES laboratorios(id_laboratorio) ON DELETE CASCADE;

ALTER TABLE reservas
    ADD CONSTRAINT fk_reserva_inv FOREIGN KEY (id_investigador) REFERENCES investigadores(id_investigador) ON DELETE CASCADE;

ALTER TABLE reservas
    ADD CONSTRAINT fk_reserva_lab FOREIGN KEY (id_laboratorio) REFERENCES laboratorios(id_laboratorio) ON DELETE CASCADE;

ALTER TABLE reserva_equipos
    ADD CONSTRAINT fk_req_reserva FOREIGN KEY (id_reserva) REFERENCES reservas(id_reserva) ON DELETE CASCADE;

ALTER TABLE reserva_equipos
    ADD CONSTRAINT fk_req_equipo FOREIGN KEY (id_equipo) REFERENCES equipos(id_equipo) ON DELETE CASCADE;

-- Restricciones de dominio
ALTER TABLE laboratorios
    ADD CONSTRAINT chk_nivel_bioseguridad CHECK (nivel_bioseguridad BETWEEN 1 AND 4);

-- Índices para optimizar búsquedas
CREATE INDEX idx_reservas_fecha ON reservas(fecha_reserva);