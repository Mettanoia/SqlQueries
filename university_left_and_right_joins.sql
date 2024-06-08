SELECT dep.nombre AS departamento, p.nombre, apellido1, apellido2
FROM persona p
LEFT JOIN profesor prof ON p.id = prof.id_profesor
LEFT JOIN departamento dep ON dep.id = prof.id_departamento
WHERE p.tipo = 'profesor'
ORDER BY departamento, p.nombre, apellido1, apellido2;


SELECT p.* FROM persona p 
LEFT JOIN profesor prof ON p.id = prof.id_profesor 
WHERE p.tipo = 'profesor' 
AND prof.id_departamento IS NULL;


SELECT d.* FROM persona p 
RIGHT JOIN profesor prof ON p.id = prof.id_profesor 
RIGHT JOIN departamento d ON prof.id_departamento = d.id
WHERE prof.id_profesor IS NULL; 


SELECT p.* FROM persona p 
LEFT JOIN profesor prof ON p.id = prof.id_profesor 
LEFT JOIN asignatura a ON prof.id_profesor = a.id_profesor 
WHERE a.id IS NULL;


SELECT a.* FROM 
persona p RIGHT JOIN profesor prof 
ON p.id = prof.id_profesor 
	RIGHT JOIN asignatura a 
	ON prof.id_profesor = a.id_profesor 
WHERE p.id IS NULL;


SELECT DISTINCT d.nombre FROM 
asignatura a JOIN profesor p 
	ON a.id_profesor = p.id_profesor 
JOIN departamento d 
	ON p.id_departamento = d.id 
LEFT JOIN alumno_se_matricula_asignatura asma 
	ON a.id = asma.id_asignatura 
LEFT JOIN curso_escolar ce 
	ON asma.id_curso_escolar = ce.id
WHERE ce.id IS NULL;
