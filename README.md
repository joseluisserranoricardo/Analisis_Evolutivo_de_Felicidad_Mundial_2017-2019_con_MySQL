# 📈 Análisis Evolutivo de Felicidad Mundial (2017-2019) con MySQL

## 📖 Descripción del Proyecto
Este proyecto consiste en la integración y análisis de datos del *World Happiness Report* para el trienio 2017-2019.

## 🛠️ Desafíos Técnicos Superados
* **Normalización Estructural:** Los archivos originales era CSV independientes que presentaban nombres de columnas distintos. Se estandarizaron bajo una tabla maestra única.
* **Optimización de Consultas:** Uso de *Joins* para calcular variaciones entre años sin necesidad de herramientas externas.

---

## 📊 Métricas y Resultados Clave

### 1. Promedio Histórico (Top 10)
Se calculó la estabilidad de la felicidad utilizando la función de agregación `AVG()`. Los países nórdicos mantienen una consistencia notable.

![promedio](https://github.com/user-attachments/assets/b1078e56-c5b7-4b76-82d7-2a7fed3e8808)


```sql
SELECT pais, AVG(puntaje) as promedio_felicidad
FROM felicidad_mundial
GROUP BY pais
ORDER BY promedio_felicidad DESC
LIMIT 10;
```

### 2. Índice de Mejora (2017 vs 2019)
Utilizando una técnica de Self-Join, comparamos el estado inicial (2017) con el final (2019) para identificar qué naciones lograron incrementar su bienestar percibido.
```sql
SELECT 
    f19.pais, 
    f17.puntaje as score_2017, 
    f19.puntaje as score_2019,
    (f19.puntaje - f17.puntaje) as mejora
FROM felicidad_mundial f17
JOIN felicidad_mundial f19 ON f17.pais = f19.pais
WHERE f17.anio = 2017 AND f19.anio = 2019
ORDER BY mejora DESC
LIMIT 10;
```
![evolucion](https://github.com/user-attachments/assets/67c8d8ae-d9d2-45c0-aa33-19cdebb3affc)

### Conclusión Analítica
Los países ricos se mantienen más estables en felicidad mientras los países más pobres son los que más rápido crecen en este aspecto.
