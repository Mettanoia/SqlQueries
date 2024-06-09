SELECT p.nombre , p.precio FROM producto p 
JOIN fabricante f ON p.codigo_fabricante = f.codigo 
WHERE LOWER(RIGHT(f.nombre, 1)) = 'e' ;


SELECT p.nombre , p.precio FROM producto p 
JOIN fabricante f ON p.codigo_fabricante = f.codigo 
WHERE LOWER(f.nombre) LIKE '%w%' ;


SELECT p.nombre , p.precio, f.nombre AS fabricante FROM producto p 
JOIN fabricante f ON p.codigo_fabricante = f.codigo 
WHERE p.precio >= 180 
ORDER BY p.precio DESC, p.nombre ASC;


SELECT DISTINCT f.nombre, GROUP_CONCAT(p.nombre SEPARATOR ',  ') FROM fabricante f 
JOIN producto p ON p.codigo_fabricante = f.codigo
GROUP BY f.nombre;


SELECT DISTINCT f.nombre, GROUP_CONCAT(p.nombre SEPARATOR ',  ') FROM fabricante f 
LEFT JOIN producto p ON p.codigo_fabricante = f.codigo
GROUP BY f.nombre;


SELECT DISTINCT f.nombre FROM fabricante f 
LEFT JOIN producto p ON p.codigo_fabricante = f.codigo
WHERE p.codigo IS NULL;


SELECT DISTINCT p.* FROM fabricante f 
JOIN producto p ON p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Lenovo';


SELECT p.nombre, p.precio FROM producto p 
WHERE p.precio = (SELECT MAX(p2.precio) FROM producto p2 WHERE p2.codigo_fabricante = 2);


SELECT p.nombre FROM producto p 
WHERE p.codigo_fabricante = 2
ORDER BY p.precio DESC 
LIMIT 1;


SELECT p.nombre FROM producto p 
WHERE p.codigo_fabricante = 3
ORDER BY p.precio ASC 
LIMIT 1;


SELECT p.nombre, p.precio FROM producto p 
WHERE p.precio > (SELECT AVG(p2.precio) FROM producto p2 WHERE p2.codigo_fabricante = 1) AND p.codigo_fabricante = 1



