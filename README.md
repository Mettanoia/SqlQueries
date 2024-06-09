# README

## LEFT and RIGHT JOINs - University

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


## Summary Queries - University

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

## Miscellaneous - University

### 1. List All Students Ordered by Name and Surnames

```sql
SELECT p.nombre, p.apellido1, p.apellido2 FROM persona p 
WHERE p.tipo = 'alumno'
ORDER BY p.nombre, p.apellido1, p.apellido2 ASC;
```

- **Purpose**: Retrieve all students, ordered by their first name and surnames.
- **Logic**: 
  - Filters records in the `persona` table where `tipo` is 'alumno'.
  - Orders the results by `nombre`, `apellido1`, and `apellido2`.

### 2. List Students Without a Phone Number

```sql
SELECT p.nombre, p.apellido1, p.apellido2 FROM persona p 
WHERE p.tipo = 'alumno' AND p.telefono IS NULL;
```

- **Purpose**: Retrieve all students who do not have a phone number.
- **Logic**: 
  - Filters records in the `persona` table where `tipo` is 'alumno' and `telefono` is NULL.

### 3. List Students Born in 1999

```sql
SELECT p.nombre, p.apellido1, p.apellido2 FROM persona p 
WHERE p.tipo = 'alumno' AND YEAR(p.fecha_nacimiento) = 1999;
```

- **Purpose**: Retrieve all students born in 1999.
- **Logic**: 
  - Filters records in the `persona` table where `tipo` is 'alumno' and the birth year is 1999.

### 4. List Professors Without a Phone Number and Whose NIF Ends in 'K'

```sql
SELECT p.nombre, p.apellido1, p.apellido2
FROM persona p 
WHERE p.tipo = 'profesor' 
AND p.telefono IS NULL 
AND RIGHT(p.nif, 1) = 'K';
```

- **Purpose**: Retrieve all professors who do not have a phone number and whose NIF ends with 'K'.
- **Logic**: 
  - Filters records in the `persona` table where `tipo` is 'profesor', `telefono` is NULL, and the last character of `nif` is 'K'.

### 5. List Professors with Their Departments Ordered by Name and Surnames

```sql
SELECT p.nombre, p.apellido1, p.apellido2, d.nombre AS departamento FROM persona p 
JOIN profesor p2 ON p2.id_profesor = p.id 
JOIN departamento d ON p2.id_departamento = d.id 
ORDER BY p.nombre, p.apellido1, p.apellido2 ASC;
```

- **Purpose**: Retrieve all professors along with their department names, ordered by their first name and surnames.
- **Logic**: 
  - Joins the `persona`, `profesor`, and `departamento` tables.
  - Orders the results by `nombre`, `apellido1`, and `apellido2`.

### 6. List Courses Taken by a Specific Student Grouped by School Year

```sql
SELECT ce.anyo_inicio, ce.anyo_fin, GROUP_CONCAT(a.nombre SEPARATOR ', ') AS asignaturas FROM persona p 
JOIN alumno_se_matricula_asignatura asma ON p.id = asma.id_alumno
JOIN asignatura a ON asma.id_asignatura = a.id 
JOIN curso_escolar ce ON ce.id = asma.id_curso_escolar
WHERE p.nif = '26902806M'
GROUP BY ce.anyo_inicio, ce.anyo_fin;
```

- **Purpose**: Retrieve all courses taken by a specific student, grouped by the school year.
- **Logic**: 
  - Joins the `persona`, `alumno_se_matricula_asignatura`, `asignatura`, and `curso_escolar` tables.
  - Filters records for the student with NIF '26902806M'.
  - Groups the results by school year and concatenates course names.

### 7. List Departments Offering a Specific Degree Program

```sql
SELECT DISTINCT d.nombre FROM asignatura a 
JOIN grado g ON a.id_grado = g.id 
JOIN profesor p ON a.id_profesor = p.id_profesor 
JOIN departamento d ON p.id_departamento = d.id
WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';
```

- **Purpose**: Retrieve all departments that offer the 'Grado en Ingeniería Informática (Plan 2015)' degree program.
- **Logic**: 
  - Joins the `asignatura`, `grado`, `profesor`, and `departamento` tables.
  - Filters records for the specified degree program and selects distinct department names.

### 8. List Students Enrolled in a Specific School Year

```sql
SELECT DISTINCT p.* FROM alumno_se_matricula_asignatura asma 
JOIN curso_escolar ce ON ce.id = asma.id_curso_escolar 
JOIN persona p ON p.id = asma.id_alumno 
WHERE ce.anyo_inicio = '2018';
```

- **Purpose**: Retrieve all students who were enrolled in the school year starting in 2018.
- **Logic**: 
  - Joins the `alumno_se_matricula_asignatura`, `curso_escolar`, and `persona` tables.
  - Filters records for the school year starting in 2018 and selects distinct student records.
 
## Miscellaneous - Shop

### 1. List Products from Manufacturers Whose Name Ends with 'e'

```sql
SELECT p.nombre, p.precio FROM producto p 
JOIN fabricante f ON p.codigo_fabricante = f.codigo 
WHERE LOWER(RIGHT(f.nombre, 1)) = 'e';
```

- **Purpose**: Retrieve products from manufacturers whose name ends with the letter 'e'.
- **Logic**: 
  - Joins `producto` with `fabricante`.
  - Filters manufacturers whose name ends with 'e' (case-insensitive).

### 2. List Products from Manufacturers Whose Name Contains 'w'

```sql
SELECT p.nombre, p.precio FROM producto p 
JOIN fabricante f ON p.codigo_fabricante = f.codigo 
WHERE LOWER(f.nombre) LIKE '%w%';
```

- **Purpose**: Retrieve products from manufacturers whose name contains the letter 'w'.
- **Logic**: 
  - Joins `producto` with `fabricante`.
  - Filters manufacturers whose name contains 'w' (case-insensitive).

### 3. List Products with Price >= 180 with Manufacturer Name

```sql
SELECT p.nombre, p.precio, f.nombre AS fabricante FROM producto p 
JOIN fabricante f ON p.codigo_fabricante = f.codigo 
WHERE p.precio >= 180 
ORDER BY p.precio DESC, p.nombre ASC;
```

- **Purpose**: Retrieve products with a price of 180 or higher, including manufacturer names.
- **Logic**: 
  - Joins `producto` with `fabricante`.
  - Filters products with a price greater than or equal to 180.
  - Orders results by price (descending) and product name (ascending).

### 4. List Manufacturers with Their Products

```sql
SELECT DISTINCT f.nombre, GROUP_CONCAT(p.nombre SEPARATOR ', ') FROM fabricante f 
JOIN producto p ON p.codigo_fabricante = f.codigo
GROUP BY f.nombre;
```

- **Purpose**: Retrieve all manufacturers and a comma-separated list of their products.
- **Logic**: 
  - Joins `fabricante` with `producto`.
  - Groups by manufacturer name and concatenates product names.

### 5. List All Manufacturers with Their Products (Including Manufacturers with No Products)

```sql
SELECT DISTINCT f.nombre, GROUP_CONCAT(p.nombre SEPARATOR ', ') FROM fabricante f 
LEFT JOIN producto p ON p.codigo_fabricante = f.codigo
GROUP BY f.nombre;
```

- **Purpose**: Retrieve all manufacturers and a comma-separated list of their products, including those with no products.
- **Logic**: 
  - Left joins `fabricante` with `producto`.
  - Groups by manufacturer name and concatenates product names.

### 6. List Manufacturers with No Products

```sql
SELECT DISTINCT f.nombre FROM fabricante f 
LEFT JOIN producto p ON p.codigo_fabricante = f.codigo
WHERE p.codigo IS NULL;
```

- **Purpose**: Identify manufacturers that have no products.
- **Logic**: 
  - Left joins `fabricante` with `producto`.
  - Filters for manufacturers with no associated products.

### 7. List All Products from 'Lenovo'

```sql
SELECT DISTINCT p.* FROM fabricante f 
JOIN producto p ON p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Lenovo';
```

- **Purpose**: Retrieve all products manufactured by 'Lenovo'.
- **Logic**: 
  - Joins `fabricante` with `producto`.
  - Filters for products with the manufacturer name 'Lenovo'.

### 8. List the Most Expensive Product from Manufacturer with Code 2

```sql
SELECT p.nombre, p.precio FROM producto p 
WHERE p.precio = (SELECT MAX(p2.precio) FROM producto p2 WHERE p2.codigo_fabricante = 2);
```

- **Purpose**: Retrieve the most expensive product from the manufacturer with code 2.
- **Logic**: 
  - Filters products to find the one with the maximum price for the manufacturer with code 2.

### 9. List the Most Expensive Product from Manufacturer with Code 2 (Alternative)

```sql
SELECT p.nombre FROM producto p 
WHERE p.codigo_fabricante = 2
ORDER BY p.precio DESC 
LIMIT 1;
```

- **Purpose**: Retrieve the most expensive product from the manufacturer with code 2.
- **Logic**: 
  - Filters products by manufacturer code 2.
  - Orders results by price (descending) and limits to the top result.

### 10. List the Cheapest Product from Manufacturer with Code 3

```sql
SELECT p.nombre FROM producto p 
WHERE p.codigo_fabricante = 3
ORDER BY p.precio ASC 
LIMIT 1;
```

- **Purpose**: Retrieve the cheapest product from the manufacturer with code 3.
- **Logic**: 
  - Filters products by manufacturer code 3.
  - Orders results by price (ascending) and limits to the top result.

### 11. List Products from Manufacturer with Code 1 Priced Above Average

```sql
SELECT p.nombre, p.precio FROM producto p 
WHERE p.precio > (SELECT AVG(p2.precio) FROM producto p2 WHERE p2.codigo_fabricante = 1) 
AND p.codigo_fabricante = 1;
```

- **Purpose**: Retrieve products from the manufacturer with code 1 that are priced above the average price of products from the same manufacturer.
- **Logic**: 
  - Filters products by manufacturer code 1.
  - Compares product price with the average price of products from the same manufacturer.
