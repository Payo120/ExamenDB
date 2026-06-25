```mermaid
erDiagram
    CLIENTES ||--o{ CONTRATOS : "tiene"
    CONTRATOS ||--o{ PROYECTOS : "origina"
    PROYECTOS ||--o{ TAREAS : "desglosa"
    PROYECTOS ||--o{ FACTURAS : "genera"
    PROYECTOS ||--o{ GASTOS_OPERATIVOS : "incurre"
    TAREAS ||--o{ ASIGNACIONES : "registra"
    EMPLEADOS ||--o{ ASIGNACIONES : "trabaja"
