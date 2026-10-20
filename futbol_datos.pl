% ============================================================
% ARCHIVO 1: futbol_datos.pl
% Base de datos (solo HECHOS) sobre futbol profesional
% Programacion Logica - Unidad 3
% ============================================================
%
% GUIA DE ESTUDIO (leer antes):
%  - Un HECHO es algo que Prolog toma como verdadero. Ejemplo:
%        valor_mercado(messi, 30).
%    se lee: "el valor de mercado de messi es 30 (millones)".
%  - El nombre antes del parentesis es el PREDICADO (valor_mercado)
%    y lo que va dentro son los ARGUMENTOS (messi, 30).
%  - Todo termina con punto (.). Si falta un punto, Prolog da error.
%  - Los nombres en minuscula (messi, laliga) son CONSTANTES (datos fijos).
%    Las que empiezan con MAYUSCULA (X, Y) son VARIABLES y solo se usan
%    en las consultas y en las reglas, nunca en estos hechos.
%  - El numero que va despues de la / (ej. futbolista/1) es la cantidad
%    de argumentos que lleva ese predicado (se llama "aridad").
%  - Este archivo no hace nada solo: solo guarda datos. Las conclusiones
%    las sacan las reglas del archivo futbol_reglas.pl
% ============================================================

% ---------- OBJETOS: los 15 futbolistas ----------
% futbolista(Nombre).   -> predicado con 1 argumento (futbolista/1)
% Estos son los "objetos" principales del programa (minimo 15).
futbolista(messi).
futbolista(ronaldo).
futbolista(mbappe).
futbolista(haaland).
futbolista(vinicius).
futbolista(bellingham).
futbolista(pedri).
futbolista(musiala).
futbolista(yamal).
futbolista(de_bruyne).
futbolista(rodri).
futbolista(kane).
futbolista(modric).
futbolista(kante).
futbolista(neymar).

% ---------- posicion(Futbolista, Posicion) ----------
% predicado de 2 argumentos (posicion/2): quien juega en que puesto
posicion(messi, extremo).
posicion(ronaldo, delantero).
posicion(mbappe, delantero).
posicion(haaland, delantero).
posicion(vinicius, extremo).
posicion(bellingham, mediocampista).
posicion(pedri, mediocampista).
posicion(musiala, mediocampista).
posicion(yamal, extremo).
posicion(de_bruyne, mediocampista).
posicion(rodri, pivote).
posicion(kane, delantero).
posicion(modric, mediocampista).
posicion(kante, pivote).
posicion(neymar, extremo).

% ---------- valor_mercado(Futbolista, ValorEnMillones) ----------
% el numero es un dato numerico, lo usan las reglas para comparar (=<, >)
valor_mercado(messi, 30).
valor_mercado(ronaldo, 15).
valor_mercado(mbappe, 180).
valor_mercado(haaland, 180).
valor_mercado(vinicius, 180).
valor_mercado(bellingham, 180).
valor_mercado(pedri, 80).
valor_mercado(musiala, 110).
valor_mercado(yamal, 120).
valor_mercado(de_bruyne, 50).
valor_mercado(rodri, 130).
valor_mercado(kane, 100).
valor_mercado(modric, 6).
valor_mercado(kante, 10).
valor_mercado(neymar, 30).

% ---------- calificacion(Futbolista, Nota de 0 a 10) ----------
calificacion(messi, 10).
calificacion(ronaldo, 9).
calificacion(mbappe, 9).
calificacion(haaland, 9).
calificacion(vinicius, 9).
calificacion(bellingham, 9).
calificacion(pedri, 8).
calificacion(musiala, 9).
calificacion(yamal, 8).
calificacion(de_bruyne, 9).
calificacion(rodri, 10).
calificacion(kane, 9).
calificacion(modric, 8).
calificacion(kante, 7).
calificacion(neymar, 8).

% ---------- goles_temporada(Futbolista, Goles) ----------
goles_temporada(messi, 25).
goles_temporada(ronaldo, 35).
goles_temporada(mbappe, 44).
goles_temporada(haaland, 38).
goles_temporada(vinicius, 24).
goles_temporada(bellingham, 23).
goles_temporada(pedri, 6).
goles_temporada(musiala, 12).
goles_temporada(yamal, 10).
goles_temporada(de_bruyne, 6).
goles_temporada(rodri, 9).
goles_temporada(kane, 44).
goles_temporada(modric, 2).
goles_temporada(kante, 4).
goles_temporada(neymar, 15).

% ---------- liga(Futbolista, Liga) ----------
% Un jugador puede haber militado o militan en distintas ligas
% Ojo: un mismo jugador puede tener VARIOS hechos de liga (ej. messi tiene 2).
% Por eso al consultar liga(messi, L) Prolog da una respuesta y con ;
% da la siguiente (eso es backtracking).
liga(messi, mls).
liga(messi, laliga).
liga(ronaldo, saudi_pro_league).
liga(ronaldo, premier_league).
liga(mbappe, laliga).
liga(mbappe, ligue_1).
liga(haaland, premier_league).
liga(vinicius, laliga).
liga(bellingham, laliga).
liga(pedri, laliga).
liga(musiala, bundesliga).
liga(yamal, laliga).
liga(de_bruyne, premier_league).
liga(rodri, premier_league).
liga(kane, bundesliga).
liga(kane, premier_league).
liga(modric, laliga).
liga(kante, saudi_pro_league).
liga(neymar, saudi_pro_league).

% ---------- director_tecnico(Futbolista, Entrenador) ----------
% no todos los jugadores tienen este hecho, solo los que se muestran aqui
% (lo que no esta escrito Prolog lo toma como falso)
director_tecnico(messi, martino).
director_tecnico(mbappe, ancelotti).
director_tecnico(vinicius, ancelotti).
director_tecnico(bellingham, ancelotti).
director_tecnico(modric, ancelotti).
director_tecnico(haaland, guardiola).
director_tecnico(de_bruyne, guardiola).
director_tecnico(rodri, guardiola).

% ---------- campeon_internacional(Futbolista) ----------
% Hecho simple de 1 argumento: si el jugador esta aqui, ha ganado Champions o
% Mundial. Si no esta, Prolog responde false (suposicion del mundo cerrado).
campeon_internacional(messi).
campeon_internacional(ronaldo).
campeon_internacional(mbappe).
campeon_internacional(vinicius).
campeon_internacional(bellingham).
campeon_internacional(rodri).
campeon_internacional(modric).

% ---------- OBJETOS: directores deportivos / clubes ----------
% director_deportivo(Nombre).   -> segundo tipo de objeto del programa
director_deportivo(ana).
director_deportivo(luis).
director_deportivo(carlos).
director_deportivo(maria).

% tiene_licencia(Director, Liga)
% (un director puede tener licencia en varias ligas: ana tiene 2)
tiene_licencia(ana, laliga).
tiene_licencia(ana, premier_league).
tiene_licencia(luis, premier_league).
tiene_licencia(carlos, saudi_pro_league).
tiene_licencia(maria, laliga).

% presupuesto_fichaje(Director, Millones)
% cuanto dinero tiene cada director para comprar jugadores
presupuesto_fichaje(ana, 100).
presupuesto_fichaje(luis, 30).
presupuesto_fichaje(carlos, 95).
presupuesto_fichaje(maria, 150).

% le_gusta_posicion(Director, Posicion)
% que puestos busca cada director
le_gusta_posicion(ana, mediocampista).
le_gusta_posicion(ana, extremo).
le_gusta_posicion(luis, delantero).
le_gusta_posicion(luis, pivote).
le_gusta_posicion(carlos, delantero).
le_gusta_posicion(maria, extremo).
le_gusta_posicion(maria, mediocampista).

% tiene_en_plantilla(Director, Futbolista): jugadores en sus clubes
tiene_en_plantilla(ana, pedri).
tiene_en_plantilla(ana, modric).
tiene_en_plantilla(luis, rodri).
tiene_en_plantilla(luis, kante).
tiene_en_plantilla(carlos, ronaldo).
tiene_en_plantilla(carlos, neymar).
tiene_en_plantilla(maria, vinicius).
tiene_en_plantilla(maria, bellingham).

% red_contactos(Director1, Director2): red de scouting entre directores
% IMPORTANTE: va en una sola direccion. red_contactos(ana, luis) significa
% que ana conoce a luis, NO que luis conoce a ana. La regla recursiva
% en_contacto (en el otro archivo) usa estos hechos para encadenar:
% ana -> luis -> carlos -> maria
red_contactos(ana, luis).
red_contactos(luis, carlos).
red_contactos(carlos, maria).
