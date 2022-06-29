# CONSULTAS NO RECURSIVAS (no fueron solicitadas en la consigna)

# Top 3 equipos mas goleadores de visitante

WITH equipos_visitantes AS (
	SELECT eq.idEquipo, eq.nombre, en.golesVis 
    FROM equipos eq INNER JOIN enfrentamientos en 
					ON en.idEquipoVis = eq.idEquipo)
SELECT nombre, sum(golesVis) AS goles_visitante 
FROM equipos_visitantes 
GROUP BY idEquipo 
ORDER BY sum(golesVis) desc 
LIMIT 3;

# El equipo más fuerte jugando de local

WITH equipos_local AS (
	SELECT eq.idEquipo, eq.nombre, en.golesLoc 
    FROM equipos eq INNER JOIN enfrentamientos en 
					ON en.idEquipoLoc = eq.idEquipo 
    WHERE en.golesLoc > en.golesVis)
SELECT nombre, count(idEquipo) AS victorias_local, sum(golesLoc) AS goles_local  
FROM equipos_local 
GROUP BY idEquipo 
ORDER BY count(idEquipo) desc, sum(golesLoc) desc 
LIMIT 1;

# El equipo mas goleado

WITH de_local AS (
	SELECT eq.idEquipo, eq.nombre, sum(en.golesVis) AS recibidos_de_local 
    FROM equipos eq INNER JOIN enfrentamientos en 
					ON en.idEquipoLoc = eq.idEquipo 
	GROUP BY eq.idEquipo 
    ORDER BY sum(en.golesVis) desc 
    LIMIT 1)
SELECT dl.nombre, dl.recibidos_de_local + sum(en.golesLoc) AS goles_recibidos 
FROM de_local dl INNER JOIN enfrentamientos en 
						ON en.idEquipoVis = dl.idEquipo 
GROUP BY dl.idEquipo;

# CONSULTAS RECURSIVAS

# Resultados de los partidos luego de jugar de local
WITH RECURSIVE
cte_local_visitante (idLocal, idVisitante, jornada, fecha, golesLocal, golesVisitante) AS(
	SELECT idEquipoLoc, idEquipoVis, jornada, fecha, golesLoc, golesVis 
    FROM enfrentamientos 
    WHERE idEquipoLoc = 1 AND jornada = 1
	UNION ALL
    SELECT en.idEquipoLoc, en.idEquipoVis, en.jornada, en.fecha, en.golesLoc, en.golesVis 
    FROM cte_local_visitante lv INNER JOIN enfrentamientos en 
								ON en.jornada = lv.jornada + 1 
    WHERE en.idEquipoVis = lv.idLocal)

SELECT lv.idLocal, eq.nombre, lv.idVisitante, e.nombre, lv.jornada, lv.fecha, lv.golesLocal, lv.golesVisitante
FROM cte_local_visitante lv INNER JOIN equipos eq 
									ON lv.idLocal = eq.idEquipo 
							INNER JOIN equipos e 
									ON lv.idVisitante = e.idEquipo;
                                    
                                    
# Resultados de los partidos luego de jugar de visitante
WITH RECURSIVE
cte_visitante_local (idLocal, idVisitante, jornada, fecha, golesLocal, golesVisitante) AS(
	SELECT idEquipoLoc, idEquipoVis, jornada, fecha, golesLoc, golesVis 
    FROM enfrentamientos 
    WHERE idEquipoVis = 2 AND jornada = 1
	UNION ALL
    SELECT en.idEquipoLoc, en.idEquipoVis, en.jornada, en.fecha, en.golesLoc, en.golesVis 
    FROM cte_visitante_local vl INNER JOIN enfrentamientos en 
								ON en.jornada = vl.jornada + 1 
    WHERE en.idEquipoLoc = vl.idVisitante)
SELECT vl.idLocal, eq.nombre, vl.idVisitante, e.nombre, vl.jornada, vl.fecha, vl.golesLocal, vl.golesVisitante
FROM cte_visitante_local vl INNER JOIN equipos eq 
									ON vl.idLocal = eq.idEquipo 
							INNER JOIN equipos e 
									ON vl.idVisitante = e.idEquipo;										
