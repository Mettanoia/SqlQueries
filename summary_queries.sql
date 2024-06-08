SELECT COUNT(*) AS total_alumnes FROM persona p WHERE p.tipo = 'alumno';


SELECT COUNT(*) AS total_alumnes FROM persona p WHERE p.tipo = 'alumno' AND YEAR(p.fecha_nacimiento) = 1999;


SELECT d.nombre, COUNT(prof.id_profesor) AS total_profesores FROM
departamento d JOIN profesor prof ON d.id = prof.id_departamento 
GROUP BY d.id
ORDER BY total_profesores DESC;


SELECT d.nombre, COUNT(prof.id_profesor) AS total_profesores FROM
departamento d LEFT JOIN profesor prof ON d.id = prof.id_departamento 
GROUP BY d.id
ORDER BY total_profesores DESC;


SELECT g.nombre, COUNT(a.id) AS total_asignaturas FROM
grado g LEFT JOIN asignatura a ON a.id_grado = g.id 
GROUP BY g.id 
ORDER BY total_asignaturas DESC;


SELECT g.nombre, COUNT(a.id) AS total_asignaturas FROM
grado g JOIN asignatura a ON a.id_grado = g.id 
GROUP BY g.id 
HAVING COUNT(a.id) > 40
ORDER BY total_asignaturas DESC;


SELECT g.nombre, a.tipo, COUNT(a.id) AS total_creditos FROM
grado g LEFT JOIN asignatura a ON g.id  = a.id_grado 
GROUP BY g.id, a.tipo
ORDer BY total_creditos DESC;


SELECT ce.anyo_inicio, COUNT(asma.id_alumno) AS total_alumnos FROM
curso_escolar ce LEFT JOIN alumno_se_matricula_asignatura asma ON ce.id = asma.id_curso_escolar 
GROUP BY ce.id 
ORDER BY total_alumnos DESC;


SELECT p.id, p.nombre, p.apellido1, p.apellido2, COUNT(a.id) AS total_asignaturas FROM persona p 
JOIN profesor prof ON p.id = prof.id_profesor 
LEFT JOIN asignatura a ON prof.id_profesor = a.id_profesor 
GROUP BY p.id 
ORDER BY total_asignaturas DESC;


SELECT p.* FROM persona p 
WHERE p.tipo = 'alumno'
ORDER BY p.fecha_nacimiento DESC 
LIMIT 1; 


SELECT p.* FROM persona p 
JOIN profesor prof ON p.id = prof.id_profesor 
LEFT JOIN asignatura a ON p.id = a.id_profesor
WHERE a.id IS NULL;
