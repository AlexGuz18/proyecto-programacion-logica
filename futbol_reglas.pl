% ============================================================
% ARCHIVO 2: futbol_reglas.pl
% REGLAS del sistema de scouting y analisis de futbol
% Programacion Logica - Unidad 3
%
% Para usarlo en SWI-Prolog:
%   ?- consult('futbol_reglas.pl').
% ============================================================
%
% GUIA DE ESTUDIO (leer antes):
%  - Una REGLA tiene esta forma:      cabeza :- cuerpo.
%    El simbolo :- se lee "si". Ejemplo:
%        economico(F) :- valor_mercado(F, V), V =< 15.
%    se lee: "F es economico SI el valor de mercado de F es V
%    y V es menor o igual a 15".
%  - La coma (,) significa Y: todas las condiciones deben cumplirse.
%  - El punto y coma (;) significa O: basta con que se cumpla una.
%  - Las letras MAYUSCULAS (F, V, X) son VARIABLES: Prolog les va
%    probando valores hasta que la regla se cumpla (unificacion).
%  - Cuando una condicion falla, Prolog RETROCEDE y prueba otro valor
%    (esto se llama BACKTRACKING). Por eso con ; salen mas respuestas.
%  - Comparaciones usadas:  =<  menor o igual     >  mayor
%                           >=  mayor o igual     \=  distinto
%  - La variable anonima _ significa "no me importa este valor".
% ============================================================

% Importamos el archivo de hechos (asi las reglas pueden usarlos).
% Los dos archivos deben estar en la misma carpeta.
:- consult('futbol_datos.pl').

% ------------------------------------------------------------
% 1. REGLAS SENCILLAS (una condicion)
% ------------------------------------------------------------
% Cada una busca el dato en un hecho y lo compara con un numero.

% un futbolista es agente libre / economico si su valor es 15M o menos
% Paso a paso con economico(X):
%   1) busca un hecho valor_mercado(F, V) y guarda sus valores
%   2) comprueba que V =< 15
%   3) si se cumple, X toma el nombre del jugador; si no, prueba otro hecho
economico(F) :- valor_mercado(F, V), V =< 15.

% un futbolista es accesible si cuesta 50M o menos
accesible_precio(F) :- valor_mercado(F, V), V =< 50.

% un futbolista es una superestrella si cuesta mas de 100M
superestrella(F) :- valor_mercado(F, V), V > 100.

% un futbolista es clase mundial si su calificacion es 9 o mas
clase_mundial(F) :- calificacion(F, C), C >= 9.

% un futbolista es goleador si anota 20 goles o mas en la temporada
goleador(F) :- goles_temporada(F, G), G >= 20.

% ------------------------------------------------------------
% 2. REGLAS AND: varias condiciones unidas con coma (coma = Y)
% ------------------------------------------------------------
% Aqui el cuerpo tiene varias condiciones. TODAS deben ser verdad.
% Algunas reglas usan otras reglas (ej. ganga usa clase_mundial).

% ganga: es de clase mundial y ademas tiene precio accesible
% (une dos reglas de arriba: clase_mundial Y accesible_precio)
ganga(F) :- clase_mundial(F), accesible_precio(F).

% dos futbolistas juegan en la misma posicion (y no son el mismo)
% Se usa la MISMA variable P en las dos condiciones: eso obliga a que
% la posicion sea igual. F1 \= F2 evita que un jugador salga
% comparado consigo mismo.
misma_posicion(F1, F2) :-
    posicion(F1, P),
    posicion(F2, P),
    F1 \= F2.

% dos futbolistas son dirigidos por el mismo DT
% (misma idea: la variable DT repetida obliga a que sea el mismo tecnico)
mismo_tecnico(F1, F2) :-
    director_tecnico(F1, DT),
    director_tecnico(F2, DT),
    F1 \= F2.

% dos directores deportivos comparten a un jugador en plantilla
% (con los datos actuales ningun jugador esta en dos plantillas,
%  por eso esta regla da false: es correcto, no hay datos que la cumplan)
mismo_jugador(D1, D2, Futbolista) :-
    tiene_en_plantilla(D1, Futbolista),
    tiene_en_plantilla(D2, Futbolista),
    D1 \= D2.

% un director deportivo puede registrar a un jugador si tiene licencia
% de la liga donde juega ese jugador
% (la variable Liga conecta un hecho de licencia con un hecho de liga)
puede_registrar(D, F) :-
    tiene_licencia(D, Liga),
    liga(F, Liga).

% un director deportivo puede fichar a un jugador si le alcanza el presupuesto
puede_fichar(D, F) :-
    presupuesto_fichaje(D, Dinero),
    valor_mercado(F, Precio),
    Precio =< Dinero.

% recomendamos fichar a un jugador si:
% busca esa posicion, puede registrarlo en su liga, le alcanza el presupuesto
% y es clase mundial
% Paso a paso con recomendar_fichaje(ana, X):
%   1) le_gusta_posicion(ana, Pos)  -> Pos = mediocampista (primer hecho)
%   2) posicion(F, Pos)             -> busca un jugador de esa posicion
%   3) puede_registrar(ana, F)      -> revisa la licencia de ana
%   4) puede_fichar(ana, F)         -> revisa el presupuesto
%   5) clase_mundial(F)             -> revisa la calificacion
%   Si algo falla, Prolog retrocede y prueba otro jugador u otra posicion.
recomendar_fichaje(D, F) :-
    le_gusta_posicion(D, Pos),
    posicion(F, Pos),
    puede_registrar(D, F),
    puede_fichar(D, F),
    clase_mundial(F).

% ------------------------------------------------------------
% 3. REGLAS OR: dos reglas con el mismo nombre, o con punto y coma
% ------------------------------------------------------------
% Hay dos formas de escribir un O en Prolog.

% FORMA 1: dos reglas con el mismo nombre.
% un futbolista es perfil mediatico si es campeon internacional
% o si juega de delantero
% (basta con que se cumpla UNA de las dos reglas. Si se cumplen las dos,
%  el jugador sale repetido en las respuestas; es normal)
perfil_mediatico(F) :- campeon_internacional(F).
perfil_mediatico(F) :- posicion(F, delantero).

% FORMA 2: una sola regla con punto y coma (;)
% regla OR con punto y coma (;): se cumple si es economico O accesible
opcion_viable(F) :- economico(F) ; accesible_precio(F).

% variable anonima (_): no nos importa el valor exacto
% un director deportivo esta activo si tiene al menos un jugador registrado
% (no importa cual jugador, por eso se usa _ en vez de una variable)
director_activo(D) :- tiene_en_plantilla(D, _).

% ------------------------------------------------------------
% 4. REGLAS RECURSIVAS
% ------------------------------------------------------------
% Una regla recursiva es la que se llama a si misma. Siempre lleva:
%   - CASO BASE: la condicion que detiene la busqueda
%   - CASO RECURSIVO: se da un paso y se vuelve a llamar a la misma regla
%
% Con los hechos: red_contactos(ana, luis), (luis, carlos), (carlos, maria)

% caso base: X esta en contacto directo con Y
en_contacto(X, Y) :- red_contactos(X, Y).

% caso recursivo: X se conecta con Z, y Z esta en contacto con Y
% Ejemplo en_contacto(ana, maria):
%   - caso base falla (ana no conoce directo a maria)
%   - caso recursivo: ana conoce a luis (Z = luis), pregunta en_contacto(luis, maria)
%   - luis conoce a carlos, pregunta en_contacto(carlos, maria)
%   - carlos conoce a maria -> caso base se cumple -> true
en_contacto(X, Y) :- red_contactos(X, Z), en_contacto(Z, Y).

% ------------------------------------------------------------
% CONSULTAS DE PRUEBA (para ejecutar en SWI-Prolog con punto final)
% Escribirlas SIN el ?- (ya lo pone Prolog). Con ; se ven mas respuestas.
% ------------------------------------------------------------
% ?- economico(X).                       % Que jugadores son economicos
% ?- ganga(X).                           % Jugadores top con bajo precio
% ?- misma_posicion(messi, X).           % Extremos parecidos a Messi
% ?- mismo_tecnico(mbappe, X).           % Jugadores dirigidos por Ancelotti
% ?- puede_fichar(ana, X).               % A quien le alcanza el presupuesto de Ana
% ?- recomendar_fichaje(ana, X).         % Fichajes ideales recomendados para Ana
% ?- perfil_mediatico(X).                % Jugadores mediaticos
% ?- opcion_viable(X).                   % Regla OR con ;
% ?- en_contacto(ana, maria).            % Conexiones en red de scouting (true)
% ?- en_contacto(ana, X).                % Con quien llega ana por recursividad
% ?- director_activo(maria).             % Valida si el director opera
% ?- valor_mercado(messi, _).            % Solo pregunta si existe (usa _)
