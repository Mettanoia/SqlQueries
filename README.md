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


## Summary Queries

### 1. Count Total Students

```sql
SELECT COUNT(*) AS total_alumnes FROM persona p WHERE p.tipo = 'alumno';
```

- **Purpose**: Count the total number of students in the database.
- **Logic**: 
  - Counts the number of records in the `persona` table where `tipo` is 'alumno'.

### 2. Count Students Born in 1999

```sql
SELECT COUNT(*) AS total_alumnes FROM persona p WHERE p.tipo = 'alumno' AND YEAR(p.fecha_nacimiento) = 1999;
```

- **Purpose**: Count the total number of students born in 1999.
- **Logic**: 
  - Filters records in the `persona` table where `tipo` is 'alumno' and the birth year is 1999.

### 3. Count Professors per Department

```sql
SELECT d.nombre, COUNT(prof.id_profesor) AS total_profesores FROM
departamento d JOIN profesor prof ON d.id = prof.id_departamento 
GROUP BY d.id
ORDER BY total_profesores DESC;
```

- **Purpose**: Count the number of professors in each department.
- **Logic**: 
  - Joins the `departamento` and `profesor` tables.
  - Groups the results by department and counts the number of professors.

### 4. Count Professors per Department (Including Departments with No Professors)

```sql
SELECT d.nombre, COUNT(prof.id_profesor) AS total_profesores FROM
departamento d LEFT JOIN profesor prof ON d.id = prof.id_departamento 
GROUP BY d.id
ORDER BY total_profesores DESC;
```

- **Purpose**: Count the number of professors in each department, including those with no professors.
- **Logic**: 
  - Left joins the `departamento` and `profesor` tables to include all departments.
  - Groups the results by department and counts the number of professors.

### 5. Count Subjects per Degree Program

```sql
SELECT g.nombre, COUNT(a.id) AS total_asignaturas FROM
grado g LEFT JOIN asignatura a ON a.id_grado = g.id 
GROUP BY g.id 
ORDER BY total_asignaturas DESC;
```

- **Purpose**: Count the number of subjects per degree program.
- **Logic**: 
  - Left joins the `grado` and `asignatura` tables.
  - Groups the results by degree program and counts the number of subjects.

### 6. Count Degree Programs with More Than 40 Subjects

```sql
SELECT g.nombre, COUNT(a.id) AS total_asignaturas FROM
grado g JOIN asignatura a ON a.id_grado = g.id 
GROUP BY g.id 
HAVING COUNT(a.id) > 40
ORDER BY total_asignaturas DESC;
```

- **Purpose**: Count the degree programs with more than 40 subjects.
- **Logic**: 
  - Joins the `grado` and `asignatura` tables.
  - Groups the results by degree program and filters those with more than 40 subjects.

### 7. Count Total Credits per Degree Program and Subject Type

```sql
SELECT g.nombre, a.tipo, COUNT(a.id) AS total_creditos FROM
grado g LEFT JOIN asignatura a ON g.id  = a.id_grado 
GROUP BY g.id, a.tipo
ORDER BY total_creditos DESC;
```

- **Purpose**: Count the total credits per degree program and subject type.
- **Logic**: 
  - Left joins the `grado` and `asignatura` tables.
  - Groups the results by degree program and subject type and counts the total credits.

### 8. Count Students Enrolled in Each School Year

```sql
SELECT ce.anyo_inicio, COUNT(asma.id_alumno) AS total_alumnos FROM
curso_escolar ce LEFT JOIN alumno_se_matricula_asignatura asma ON ce.id = asma.id_curso_escolar 
GROUP BY ce.id 
ORDER BY total_alumnos DESC;
```

- **Purpose**: Count the number of students enrolled in each school year.
- **Logic**: 
  - Left joins the `curso_escolar` and `alumno_se_matricula_asignatura` tables.
  - Groups the results by school year and counts the number of students.

### 9. Count Subjects Taught by Each Professor

```sql
SELECT p.id, p.nombre, p.apellido1, p.apellido2, COUNT(a.id) AS total_asignaturas FROM persona p 
JOIN profesor prof ON p.id = prof.id_profesor 
LEFT JOIN asignatura a ON prof.id_profesor = a.id_profesor 
GROUP BY p.id 
ORDER BY total_asignaturas DESC;
```

- **Purpose**: Count the number of subjects taught by each professor.
- **Logic**: 
  - Joins the `persona` and `profesor` tables.
  - Left joins the `profesor` and `asignatura` tables.
  - Groups the results by professor and counts the number of subjects.

### 10. Retrieve Information of the Youngest Student

```sql
SELECT p.* FROM persona p 
WHERE p.tipo = 'alumno'
ORDER BY p.fecha_nacimiento DESC 
LIMIT 1; 
```

- **Purpose**: Retrieve information about the youngest student based on their date of birth.
- **Logic**: 
  - Filters records in the `persona` table where `tipo` is 'alumno'.
  - Orders the results by birth date in descending order and retrieves the top record.

### 11. Find Students Who Are Not Assigned Any Subjects

```sql
SELECT p.* FROM persona p 
JOIN profesor prof ON p.id = prof.id_profesor 
LEFT JOIN asignatura a ON p.id = a.id_profesor
WHERE a.id IS NULL;
```

- **Purpose**: Identify students who are not assigned any subjects.

- **Logic**: 
  - Joins the `persona` and `profesor` tables.
  - Left joins the `persona` and `asignatura` tables.
  - Filters for students without any associated subjects.
