# README

## Queries Explanation

### 1. Retrieve Professors and Their Departments

```sql
SELECT dep.nombre AS departamento, p.nombre, apellido1, apellido2
FROM persona p
LEFT JOIN profesor prof ON p.id = prof.id_profesor
LEFT JOIN departamento dep ON dep.id = prof.id_departamento
WHERE p.tipo = 'profesor'
ORDER BY departamento, p.nombre, apellido1, apellido2;
```

- **Purpose**: List all professors along with their associated department names.
- **Logic**: 
  - Joins `persona` with `profesor` and `departamento`.
  - Filters for records where `persona.tipo` is 'profesor'.
  - Orders results by department and professor's name.

### 2. Find Professors Without Departments

```sql
SELECT p.* FROM persona p 
LEFT JOIN profesor prof ON p.id = prof.id_profesor 
WHERE p.tipo = 'profesor' 
AND prof.id_departamento IS NULL;
```

- **Purpose**: Identify professors who are not associated with any department.
- **Logic**: 
  - Joins `persona` with `profesor`.
  - Filters for professors with no department association.

### 3. Find Departments Without Professors

```sql
SELECT d.* FROM persona p 
RIGHT JOIN profesor prof ON p.id = prof.id_profesor 
RIGHT JOIN departamento d ON prof.id_departamento = d.id
WHERE prof.id_profesor IS NULL; 
```

- **Purpose**: Identify departments that have no professors assigned.
- **Logic**: 
  - Right joins `persona` and `profesor` with `departamento`.
  - Filters for departments with no associated professors.

### 4. Find Professors Without Subjects

```sql
SELECT p.* FROM persona p 
LEFT JOIN profesor prof ON p.id = prof.id_profesor 
LEFT JOIN asignatura a ON prof.id_profesor = a.id_profesor 
WHERE a.id IS NULL;
```

- **Purpose**: Identify professors who are not teaching any subjects.
- **Logic**: 
  - Joins `persona`, `profesor`, and `asignatura`.
  - Filters for professors without any associated subjects.

### 5. Find Subjects Without Professors

```sql
SELECT a.* FROM 
persona p RIGHT JOIN profesor prof 
ON p.id = prof.id_profesor 
RIGHT JOIN asignatura a 
ON prof.id_profesor = a.id_profesor 
WHERE p.id IS NULL;
```

- **Purpose**: Identify subjects that have no professors assigned.
- **Logic**: 
  - Right joins `persona` and `profesor` with `asignatura`.
  - Filters for subjects with no associated professors.

### 6. Find Departments with Subjects Not Enrolled by Any Students

```sql
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
```

- **Purpose**: Identify departments that have subjects with no student enrollments.
- **Logic**: 
  - Joins `asignatura` with `profesor`, `departamento`, `alumno_se_matricula_asignatura`, and `curso_escolar`.
  - Filters for subjects that are not enrolled by any students.
