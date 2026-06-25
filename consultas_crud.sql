USE erp_proyectos;
GO

-- ===================================================
-- EVIDENCIAS DE OPERACIONES CRUD
-- Módulo de Gestión y Seguimiento de Proyectos
-- ===================================================

-- ---------------------------------------------------
-- 1. OPERACIÓN 'CREATE' (Inserción de Datos)
-- ---------------------------------------------------
INSERT INTO CLIENTES (ID_Cliente, RUC_NIT, Razon_Social) VALUES
(1001, 'J0310000000001', 'Inversiones C&A S.A.'),
(1002, 'J0310000000002', 'Corporación de Desarrollo Web'),
(1003, 'J0310000000003', 'Tecnologías Globales S.A.');

INSERT INTO CONTRATOS (ID_Contrato, ID_Cliente, Monto, Estado_Contrato, Fecha_Firma) VALUES
(500, 1001, 15000.00, 'Firmado', '2026-01-15'),
(501, 1002, 8500.00, 'Firmado', '2026-02-10'),
(502, 1003, 22000.00, 'Firmado', '2026-05-15');

INSERT INTO PROYECTOS (ID_Proyecto, ID_Contrato, Nombre_Proyecto, Estado_Proyecto, Fecha_Inicio, Fecha_Fin) VALUES
(9001, 500, 'Implementación Módulo Facturación', 'En Progreso', '2026-02-01', '2026-06-30'),
(9002, 501, 'Diseño Interfaz UI/UX', 'En Progreso', '2026-03-01', '2026-05-15'),
(9003, 502, 'Desarrollo de Aplicación Móvil', 'En Progreso', '2026-06-01', '2026-11-30');
GO

-- ---------------------------------------------------
-- 2. OPERACIÓN 'READ' (Lectura y Consulta Relacional)
-- ---------------------------------------------------
SELECT 
    P.ID_Proyecto AS [Código Proyecto],
    P.Nombre_Proyecto AS [Nombre del Proyecto],
    C.Razon_Social AS [Empresa Cliente],
    CO.Monto AS [Monto del Contrato],
    P.Estado_Proyecto AS [Estado Actual]
FROM PROYECTOS P
INNER JOIN CONTRATOS CO ON P.ID_Contrato = CO.ID_Contrato
INNER JOIN CLIENTES C ON CO.ID_Cliente = C.ID_Cliente;
GO

-- ---------------------------------------------------
-- 3. OPERACIÓN 'UPDATE' (Actualización de Datos)
-- ---------------------------------------------------
UPDATE PROYECTOS 
SET Estado_Proyecto = 'Completado' 
WHERE ID_Proyecto = 9002;
GO

SELECT ID_Proyecto, Nombre_Proyecto, Estado_Proyecto 
FROM PROYECTOS 
WHERE ID_Proyecto = 9002;
GO

-- ---------------------------------------------------
-- 4. OPERACIÓN 'DELETE' (Eliminación de Datos)
-- ---------------------------------------------------
-- Se inserta registro temporal para prueba de borrado
INSERT INTO PROYECTOS (ID_Proyecto, ID_Contrato, Nombre_Proyecto, Estado_Proyecto, Fecha_Inicio, Fecha_Fin) 
VALUES (9999, 501, 'Proyecto Temporal de Prueba', 'Cancelado', '2026-06-01', '2026-06-30');
GO

-- Se ejecuta la eliminación
DELETE FROM PROYECTOS 
WHERE ID_Proyecto = 9999;
GO

SELECT ID_Proyecto, Nombre_Proyecto, Estado_Proyecto 
FROM PROYECTOS;
GO
