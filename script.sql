-- ==========================================
-- CREACIÓN DE TABLAS (DDL) - VERSIÓN MEJORADA
-- ==========================================

-- 1. Tabla CLIENTES
CREATE TABLE CLIENTES (
    ID_Cliente INT PRIMARY KEY,
    -- Cumple con Regla R3.01: Unicidad Fiscal
    RUC_NIT VARCHAR(20) UNIQUE NOT NULL, 
    Razon_Social VARCHAR(150) NOT NULL
);

-- 2. Tabla CONTRATOS
CREATE TABLE CONTRATOS (
    ID_Contrato INT PRIMARY KEY,
    ID_Cliente INT NOT NULL,
    Monto DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    -- Cumple con Regla R3.02: Estado del contrato (ej. 'Firmado', 'En Negociación')
    Estado_Contrato VARCHAR(50) NOT NULL DEFAULT 'En Negociación',
    Fecha_Firma DATE,
    FOREIGN KEY (ID_Cliente) REFERENCES CLIENTES(ID_Cliente)
);

-- 3. Tabla PROYECTOS
CREATE TABLE PROYECTOS (
    ID_Proyecto INT PRIMARY KEY,
    ID_Contrato INT NOT NULL,
    Nombre_Proyecto VARCHAR(150) NOT NULL,
    -- Cumple con Regla de Cambio de Estado: (ej. 'En Progreso', 'Completado')
    Estado_Proyecto VARCHAR(50) NOT NULL DEFAULT 'En Progreso',
    -- Fechas para validar límites de tareas
    Fecha_Inicio DATE NOT NULL,
    Fecha_Fin DATE NOT NULL,
    FOREIGN KEY (ID_Contrato) REFERENCES CONTRATOS(ID_Contrato)
);

-- 4. Tabla EMPLEADOS
CREATE TABLE EMPLEADOS (
    ID_Empleado INT PRIMARY KEY,
    -- Cumple con Regla Costo Obligatorio:
    Costo_Hora DECIMAL(8,2) NOT NULL CHECK (Costo_Hora >= 0),
    -- Cumple con Regla Asignación Activa: (ej. 'Activo', 'Inactivo')
    Estado_Empleado VARCHAR(50) NOT NULL DEFAULT 'Activo'
);

-- 5. Tabla TAREAS
CREATE TABLE TAREAS (
    ID_Tarea INT PRIMARY KEY,
    ID_Proyecto INT NOT NULL,
    Nombre_Tarea VARCHAR(150) NOT NULL,
    -- Cumple con Regla Cambio de Estado Proyecto: (ej. 'Pendiente', 'Terminada')
    Estado_Tarea VARCHAR(50) NOT NULL DEFAULT 'Pendiente',
    -- Cumple con Regla Límite de Fechas:
    Fecha_Inicio DATE NOT NULL,
    Fecha_Limite DATE NOT NULL,
    FOREIGN KEY (ID_Proyecto) REFERENCES PROYECTOS(ID_Proyecto)
);

-- 6. Tabla ASIGNACIONES (Resolución de relación N:M)
CREATE TABLE ASIGNACIONES (
    ID_Tarea INT,
    ID_Empleado INT,
    Horas_Registradas DECIMAL(5,2) NOT NULL,
    -- Cumple con Regla R4.02 Validación de Cobro: (ej. 'Aprobadas', 'Rechazadas', 'En Revisión')
    Estado_Aprobacion VARCHAR(50) NOT NULL DEFAULT 'En Revisión',
    Fecha_Registro DATE NOT NULL,
    PRIMARY KEY (ID_Tarea, ID_Empleado),
    FOREIGN KEY (ID_Tarea) REFERENCES TAREAS(ID_Tarea),
    FOREIGN KEY (ID_Empleado) REFERENCES EMPLEADOS(ID_Empleado)
);

-- 7. NUEVA TABLA: GASTOS OPERATIVOS
-- Cumple con Regla R4.03 Aprobación de Gastos
CREATE TABLE GASTOS_OPERATIVOS (
    ID_Gasto INT PRIMARY KEY,
    ID_Proyecto INT NOT NULL,
    Descripcion VARCHAR(200) NOT NULL,
    Monto DECIMAL(10,2) NOT NULL,
    Aprobacion_Gerencial BOOLEAN NOT NULL DEFAULT FALSE,
    Fecha_Gasto DATE NOT NULL,
    FOREIGN KEY (ID_Proyecto) REFERENCES PROYECTOS(ID_Proyecto)
);

-- 8. Tabla FACTURAS
CREATE TABLE FACTURAS (
    ID_Factura INT PRIMARY KEY,
    ID_Proyecto INT NOT NULL,
    -- Cumple con Regla R4.01 Límite de Facturación:
    Monto_Facturado DECIMAL(12,2) NOT NULL,
    Fecha_Emision DATE NOT NULL,
    FOREIGN KEY (ID_Proyecto) REFERENCES PROYECTOS(ID_Proyecto)
);

-- ==========================================
-- INSERCIÓN DE DATOS DE PRUEBA (DML)
-- ==========================================

INSERT INTO CLIENTES (ID_Cliente, RUC_NIT, Razon_Social) VALUES
(1001, 'J0310000000001', 'Inversiones C&A S.A.'),
(1002, 'J0310000000002', 'Corporación de Desarrollo Web');

INSERT INTO CONTRATOS (ID_Contrato, ID_Cliente, Monto, Estado_Contrato, Fecha_Firma) VALUES
(500, 1001, 15000.00, 'Firmado', '2026-01-15'),
(501, 1002, 8500.00, 'Firmado', '2026-02-10');

INSERT INTO PROYECTOS (ID_Proyecto, ID_Contrato, Nombre_Proyecto, Estado_Proyecto, Fecha_Inicio, Fecha_Fin) VALUES
(9001, 500, 'Implementación Módulo Facturación', 'En Progreso', '2026-02-01', '2026-06-30'),
(9002, 501, 'Diseño Interfaz UI/UX', 'En Progreso', '2026-03-01', '2026-05-15');

INSERT INTO EMPLEADOS (ID_Empleado, Costo_Hora, Estado_Empleado) VALUES
(1, 25.00, 'Activo'),
(2, 30.50, 'Activo'),
(3, 40.00, 'Inactivo');

INSERT INTO TAREAS (ID_Tarea, ID_Proyecto, Nombre_Tarea, Estado_Tarea, Fecha_Inicio, Fecha_Limite) VALUES
(101, 9001, 'Levantamiento de Requerimientos', 'Terminada', '2026-02-05', '2026-02-20'),
(102, 9001, 'Desarrollo de Backend', 'Pendiente', '2026-02-21', '2026-04-15');

INSERT INTO ASIGNACIONES (ID_Tarea, ID_Empleado, Horas_Registradas, Estado_Aprobacion, Fecha_Registro) VALUES
(101, 1, 40.50, 'Aprobadas', '2026-02-20'),
(102, 2, 15.00, 'En Revisión', '2026-03-10');

INSERT INTO GASTOS_OPERATIVOS (ID_Gasto, ID_Proyecto, Descripcion, Monto, Aprobacion_Gerencial, Fecha_Gasto) VALUES
(1, 9001, 'Licencia de Servidor Anual', 600.00, TRUE, '2026-02-10'),
(2, 9002, 'Suscripción Software Diseño', 150.00, FALSE, '2026-03-05');

INSERT INTO FACTURAS (ID_Factura, ID_Proyecto, Monto_Facturado, Fecha_Emision) VALUES
(1, 9001, 5000.00, '2026-03-01');
