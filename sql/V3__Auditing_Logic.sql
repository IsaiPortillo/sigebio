--1. funcion y trigger para verificar rango en laboratorios Nivel 4
CREATE OR REPLACE FUNCTION verificar_rango_bioseguridad()
RETURNS TRIGGER AS $$
DECLARE
    nivel_lab INT;
    rango_inv VARCHAR(50);
BEGIN
    SELECT nivel_bioseguridad INTO nivel_lab FROM laboratorios WHERE id_laboratorio = NEW.id_laboratorio;
    
    SELECT r.nombre_rango INTO rango_inv 
    FROM investigadores i 
    JOIN rangos r ON i.id_rango = r.id_rango 
    WHERE i.id_investigador = NEW.id_investigador;

    IF nivel_lab = 4 AND rango_inv != 'Director de Proyecto' THEN
        RAISE EXCEPTION 'Acceso denegado: Solo los Directores de Proyecto pueden reservar laboratorios de Nivel 4.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_verificar_rango
BEFORE INSERT ON reservas
FOR EACH ROW
EXECUTE FUNCTION verificar_rango_bioseguridad();

--2. funcion y trigger de auditoría
CREATE OR REPLACE FUNCTION auditar_reserva()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO log_auditoria (usuario_db, fecha_hora, accion)
    VALUES (CURRENT_USER, CURRENT_TIMESTAMP, 'Nueva reserva creada: ID ' || NEW.id_reserva || ' por Investigador ID ' || NEW.id_investigador);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_auditoria_reserva
AFTER INSERT ON reservas
FOR EACH ROW
EXECUTE FUNCTION auditar_reserva();