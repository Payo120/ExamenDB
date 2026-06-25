```text
```mermaid
erDiagram
    CLIENTES ||--o{ CONTRATOS : "tiene (1:N)"
    CONTRATOS ||--o{ PROYECTOS : "origina (1:N)"
    PROYECTOS ||--o{ TAREAS : "desglosa en (1:N)"
    PROYECTOS ||--o{ FACTURAS : "genera (1:N)"
    PROYECTOS ||--o{ GASTOS_OPERATIVOS : "incurre en (1:N)"
    TAREAS ||--o{ ASIGNACIONES : "registra en (1:N)"
    EMPLEADOS ||--o{ ASIGNACIONES : "trabaja en (1:N)"

    CLIENTES {
        int ID_Cliente PK
        varchar RUC_NIT UK
        varchar Razon_Social
    }
    CONTRATOS {
        int ID_Contrato PK
        int ID_Cliente FK
        decimal Monto
        varchar Estado_Contrato
    }
    PROYECTOS {
        int ID_Proyecto PK
        int ID_Contrato FK
        varchar Nombre_Proyecto
        varchar Estado_Proyecto
    }
    EMPLEADOS {
        int ID_Empleado PK
        decimal Costo_Hora
        varchar Estado_Empleado
    }
    TAREAS {
        int ID_Tarea PK
        int ID_Proyecto FK
        varchar Nombre_Tarea
        varchar Estado_Tarea
    }
    ASIGNACIONES {
        int ID_Tarea PK, FK
        int ID_Empleado PK, FK
        decimal Horas_Registradas
        varchar Estado_Aprobacion
    }
