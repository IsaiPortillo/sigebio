# SIGEBIO+ (Sistema Integral Avanzado de Gestion de Investigaciones Biogeneticas)

**Universidad de El Salvador**  
**Facultad Multidisciplinaria Oriental**  
**Departamento de Ingenieria y Arquitectura | Ingenieria de Sistemas Informaticos**  
**Diplomado de Preespecializacion - Actividad Evaluada No. 1**  
**Elaborado por: Adilman Isai Portillo Ceron (PC18035) A y Erving Fernando Amaya Villalta (AV16023) B**

---

## 1. Descripcion General
SIGEBIO+ es un sistema para la gestion de laboratorios de bioseguridad, investigadores, equipos, reservas y auditoria de eventos.

La base de datos se gestiona con migraciones versionadas para asegurar:
- Integridad referencial
- Trazabilidad de cambios
- Evolucion controlada del esquema

## 2. Objetivo del Proyecto
Disenar e implementar una base de datos relacional en PostgreSQL para un entorno de investigacion biogenetica, aplicando buenas practicas de modelado, versionado y despliegue.

## 3. Tecnologias Utilizadas
- PostgreSQL 15
- Flyway CLI
- Docker y Docker Compose
- pgAdmin 4
- Git y GitHub

## 4. Estructura del Repositorio
- [docker-compose.yml](docker-compose.yml): Infraestructura de contenedores (PostgreSQL y pgAdmin)
- [flyway.conf](flyway.conf): Configuracion de Flyway
- [sql](sql): Scripts de migracion SQL
- [docs/ER.jpeg](docs/ER.jpeg): Diagrama entidad relacion

### 4.1 Migraciones Incluidas
- V1__Initial_Schema.sql
- V2__Constraints_And_Indexes.sql
- V3__Auditing_Logic.sql
- V4__Equipment_Maintenance.sql
- V5__Seed_Data.sql

## 5. Requisitos Previos
- Docker Desktop (incluye Docker Compose)
- Flyway CLI instalado y disponible en terminal

## 6. Configuracion y Ejecucion
### 6.1 Levantar infraestructura
Desde la raiz del proyecto:

```bash
docker compose up -d
```

Servicios esperados:
- PostgreSQL en localhost:5433
- pgAdmin en http://localhost:5050

### 6.2 Verificar estado de contenedores
```bash
docker compose ps
```

### 6.3 Verificar conexion Flyway
```bash
flyway info
```

### 6.4 Ejecutar migraciones
```bash
flyway migrate
```

### 6.5 Validar consistencia de migraciones
```bash
flyway validate
```

## 7. Configuracion de Flyway
Archivo principal: [flyway.conf](flyway.conf)

Valores relevantes:
- URL: jdbc:postgresql://localhost:5433/sigebio
- Usuario: admin
- Esquema por defecto: public
- Ubicacion de scripts: filesystem:./sql

## 8. Modelo de Datos
### 8.1 Diagrama ER
![Diagrama ER](docs/ER.jpeg)

### 8.2 Esquema Logico
| Entidad | Atributos | Clave primaria | Claves foraneas | Restricciones y reglas |
|---|---|---|---|---|
| rangos | id_rango, nombre_rango | id_rango | - | nombre_rango obligatorio |
| investigadores | id_investigador, nombres, apellidos, id_rango | id_investigador | id_rango -> rangos.id_rango | nombres y apellidos obligatorios |
| laboratorios | id_laboratorio, nombre, nivel_bioseguridad, capacidad | id_laboratorio | - | CHECK nivel_bioseguridad BETWEEN 1 AND 4 |
| equipos | id_equipo, nombre_equipo, estado_operativo, id_laboratorio, ultima_revision | id_equipo | id_laboratorio -> laboratorios.id_laboratorio | eliminacion en cascada por laboratorio |
| reservas | id_reserva, id_investigador, id_laboratorio, fecha_reserva, hora_inicio, hora_fin | id_reserva | id_investigador -> investigadores.id_investigador; id_laboratorio -> laboratorios.id_laboratorio | trigger de control de acceso y trigger de auditoria |
| reserva_equipos | id_reserva, id_equipo | (id_reserva, id_equipo) | id_reserva -> reservas.id_reserva; id_equipo -> equipos.id_equipo | tabla puente para relacion N:M |
| log_auditoria | id_log, usuario_db, fecha_hora, accion | id_log | - | registro automatico de inserciones en reservas |

### 8.3 Cardinalidades Principales
- Un rango puede estar asociado a muchos investigadores (1:N)
- Un investigador puede realizar muchas reservas (1:N)
- Un laboratorio puede tener muchos equipos (1:N)
- Un laboratorio puede recibir muchas reservas (1:N)
- Una reserva puede incluir muchos equipos y un equipo puede estar en muchas reservas (N:M)

## 9. Reglas de Negocio Implementadas
- Solo investigadores con rango Director de Proyecto pueden reservar laboratorios de nivel 4
- Toda insercion en reservas genera un registro en log_auditoria
- Integridad referencial mediante claves foraneas y restricciones ON DELETE

## 10. Solucion de Problemas
### Error de autenticacion en Flyway
Si aparece error de password en Flyway:
- Verifica que Flyway use puerto 5433
- Confirma que PostgreSQL del contenedor este arriba con docker compose ps
- Asegura que no se este usando el PostgreSQL local de Windows en el puerto 5432

## 11. Evidencia de Funcionamiento Recomendada
Para tu entrega academica, incluye capturas de:
- docker compose ps
- flyway info
- flyway migrate
- Tabla flyway_schema_history en pgAdmin

## 12. Creditos
Proyecto academico desarrollado para el Diplomado de Preespecializacion.
