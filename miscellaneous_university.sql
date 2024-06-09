SELECT p.nombre, p.apellido1, p.apellido2 FROM persona p 
WHERE p.tipo = 'alumno'
ORDER BY p.nombre, p.apellido1, p.apellido2 ASC;


SELECT p.nombre, p.apellido1, p.apellido2 FROM persona p 
WHERE p.tipo = 'alumno' AND p.telefono IS NULL; 


SELECT p.nombre, p.apellido1, p.apellido2 FROM persona p 
WHERE p.tipo = 'alumno' AND YEAR(p.fecha_nacimiento) = 1999;


SELECT p.nombre, p.apellido1, p.apellido2
FROM persona p 
WHERE p.tipo = 'profesor' 
AND p.telefono IS NULL 
AND RIGHT(p.nif, 1) = 'K';


SELECT p.nombre, p.apellido1, p.apellido2, d.nombre AS departamento FROM persona p 
JOIN profesor p2 ON p2.id_profesor = p.id 
JOIN departamento d ON p2.id_departamento = d.id 
ORDER BY p.nombre ,p.apellido1 , p.apellido2 ASC;


SELECT ce.anyo_inicio, ce.anyo_fin, GROUP_CONCAT(a.nombre SEPARATOR ', ') AS asignaturas FROM persona p 
JOIN alumno_se_matricula_asignatura asma ON p.id = asma.id_alumno
JOIN asignatura a ON asma.id_asignatura = a.id 
JOIN curso_escolar ce ON ce.id = asma.id_curso_escolar
WHERE p.nif = '26902806M'
GROUP BY ce.anyo_inicio, ce.anyo_fin


SELECT DISTINCT d.nombre FROM asignatura a 
JOIN grado g ON a.id_grado = g.id 
JOIN profesor p ON a.id_profesor = p.id_profesor 
JOIN departamento d ON p.id_departamento = d.id
WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';


SELECT DISTINCT p.* from alumno_se_matricula_asignatura asma 
JOIN curso_escolar ce ON ce.id = asma.id_curso_escolar 
JOIN persona p ON p.id = asma.id_alumno 
WHERE ce.anyo_inicio = '2018'




