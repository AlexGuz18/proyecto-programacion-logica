# Proyecto Programación Lógica (Unidad 3) - Scouting de fútbol en Prolog

Base de conocimiento en **SWI-Prolog** sobre fútbol profesional: 15 futbolistas y 4 directores deportivos, con hechos y reglas para analizar jugadores y recomendar fichajes.

**Materia:** Programación Lógica y Funcional  
**Alumno:** Alberto Alexandro Guman Parra  
**Instituto Tecnológico de Tlajomulco** - Ingeniería en Sistemas Computacionales

## Archivos

| Archivo | Contenido |
|---|---|
| `futbol_datos.pl` | Solo hechos: futbolistas, posición, valor de mercado, calificación, goles, liga, técnico, directores, licencias, presupuesto y red de contactos |
| `futbol_reglas.pl` | Reglas: sencillas, AND (coma), OR (`;` y reglas repetidas), recursiva y variable anónima `_` |

## Cómo usarlo

1. Instalar [SWI-Prolog](https://www.swi-prolog.org/download/stable).
2. Poner los dos archivos en la misma carpeta.
3. Abrir SWI-Prolog y cargar el programa (ajustar la ruta):

```prolog
?- working_directory(_, 'C:/ruta/de/la/carpeta').
?- consult('futbol_reglas.pl').
```

Ese archivo importa automáticamente `futbol_datos.pl`.

## Consultas de ejemplo

```prolog
?- economico(X).
?- ganga(X).
?- mismo_tecnico(mbappe, X).
?- recomendar_fichaje(ana, X).
?- opcion_viable(X).
?- en_contacto(ana, maria).
?- en_contacto(ana, X).
```

Con `;` se piden más respuestas (backtracking).

## Conceptos usados

- Hechos y reglas (cláusulas de Horn)
- Variables y unificación
- Backtracking
- Reglas con AND (`,`) y OR (`;`)
- Recursividad (`en_contacto`)
- Variable anónima (`_`)
