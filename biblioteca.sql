-- Crear base de datos biblioteca
CREATE DATABASE biblioteca;

-- Ingresar a la base de datos biblioteca
\c biblioteca;

CREATE TABLE autores (
  codigo_autor SERIAL PRIMARY KEY,
  nombre_autor VARCHAR(50) NOT NULL,
  apellido_autor VARCHAR(50) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  fecha_muerte DATE
);

CREATE TABLE socios (
  rut VARCHAR(10) NOT NULL PRIMARY KEY,
  nombre_socio VARCHAR(50) NOT NULL,
  apellido_socio VARCHAR(50) NOT NULL,
  direccion VARCHAR(50) NOT NULL,
  telefono INT NOT NULL
);

CREATE TABLE libros (
  isbn VARCHAR(50) PRIMARY KEY,
  titulo VARCHAR(255) NOT NULL,
  numero_paginas INT NOT NULL,
  stock INT CHECK ((stock > 0 and stock <=1)) NOT NULL
);

CREATE TABLE prestamos ( 
  id SERIAL PRIMARY KEY,
  fecha_inicio DATE NOT NULL,
  fecha_devolucion DATE,
  rut_socio VARCHAR(50) REFERENCES socios(rut) NOT NULL,
  isbn_libro VARCHAR(50) REFERENCES libros(isbn)
);

CREATE TABLE autor_libro ( 
  id SERIAL PRIMARY KEY,
  tipo_autor VARCHAR(50) NOT NULL,
  codigo_autor SERIAL REFERENCES autores(codigo_autor),
  isbn_libro VARCHAR(50) REFERENCES libros(isbn)
);

-- Ingresar datos a la tabla socios
INSERT INTO socios (rut, nombre_socio, apellido_socio, direccion, telefono) VALUES ('1111111-1', 'Juan', 'Soto', 'Avenida 1, Santiago', 911111111);
INSERT INTO socios (rut, nombre_socio, apellido_socio, direccion, telefono) VALUES ('2222222-2', 'Ana', 'Pérez', 'Pasaje 2, Santiago', 922222222);
INSERT INTO socios (rut, nombre_socio, apellido_socio, direccion, telefono) VALUES ('3333333-3', 'Sandra', 'Aguilar', 'Avenida 2, Santiago', 933333333);
INSERT INTO socios (rut, nombre_socio, apellido_socio, direccion, telefono) VALUES ('4444444-4', 'Esteban', 'Jerez', 'Avenida 3, Santiago', 944444444);
INSERT INTO socios (rut, nombre_socio, apellido_socio, direccion, telefono) VALUES ('5555555-5', 'Silvana', 'Muñoz', 'Pasaje 3, Santiago', 955555555);

-- Ingresar datos a la tabla autores
INSERT INTO autores (codigo_autor, nombre_autor, apellido_autor, fecha_nacimiento, fecha_muerte) VALUES (3, 'José', 'Salgado', '1-1-1968', '1-1-2020');
INSERT INTO autores (codigo_autor, nombre_autor, apellido_autor, fecha_nacimiento, fecha_muerte) VALUES (4, 'Ana', 'Salgado', '1-1-1972', '');
INSERT INTO autores (codigo_autor, nombre_autor, apellido_autor, fecha_nacimiento, fecha_muerte) VALUES (1, 'Andrés', 'Ulloa', '1-1-1982', '');
INSERT INTO autores (codigo_autor, nombre_autor, apellido_autor, fecha_nacimiento, fecha_muerte) VALUES (2, 'Sergio', 'Mardones', '1-1-1950', '1-1-2012');
INSERT INTO autores (codigo_autor, nombre_autor, apellido_autor, fecha_nacimiento, fecha_muerte) VALUES (5, 'Martín', 'Porta', '1976', '');

-- Ingresar datos a la tabla libros
INSERT INTO libros (isbn, titulo, numero_paginas, stock) VALUES ('111-111 1111-11 1', 'Cuentos de terror', 344, 1);
INSERT INTO libros (isbn, titulo, numero_paginas, stock) VALUES ('222-222 2222-22 2', 'Poesias contemporáneas', 167, 1);
INSERT INTO libros (isbn, titulo, numero_paginas, stock) VALUES ('333-333 3333-33 3', 'Historia de Asia', 511, 1);
INSERT INTO libros (isbn, titulo, numero_paginas, stock) VALUES ('444-444 4444-44 4', 'Manual de mecánica', 298, 1);

-- Ingresar datos a la tabla autor_libro
INSERT INTO autor_libro (id, tipo_autor, codigo_autor, isbn_libro) VALUES (1, 'pricipal', 3, '111-111 1111-11 1');
INSERT INTO autor_libro (id, tipo_autor, codigo_autor, isbn_libro) VALUES (2, 'coautor', 4, '111-111 1111-11 1');
INSERT INTO autor_libro (id, tipo_autor, codigo_autor, isbn_libro) VALUES (3, 'principal', 1, '222-222 2222-22 2');
INSERT INTO autor_libro (id, tipo_autor, codigo_autor, isbn_libro) VALUES (4, 'principal', 2, '333-333 3333-33 3');
INSERT INTO autor_libro (id, tipo_autor, codigo_autor, isbn_libro) VALUES (5, 'principal', 5, '444-444 4444-44 4');

-- Ingresar datos a la tabla prestamos
INSERT INTO prestamos (id, fecha_inicio, fecha_devolucion, rut_socio, isbn_libro) VALUES (1, '20-1-2020', '27-1-2020', '1111111-1', '111-111 1111-11 1');
INSERT INTO prestamos (id, fecha_inicio, fecha_devolucion, rut_socio, isbn_libro) VALUES (2, '20-1-2020', '30-1-2020', '5555555-5', '222-222 2222-22 2');
INSERT INTO prestamos (id, fecha_inicio, fecha_devolucion, rut_socio, isbn_libro) VALUES (3, '22-1-2020', '30-1-2020', '3333333-3', '333-333 3333-33 3');
INSERT INTO prestamos (id, fecha_inicio, fecha_devolucion, rut_socio, isbn_libro) VALUES (4, '23-1-2020', '30-1-2020', '4444444-4', '444-444 4444-44 4');
INSERT INTO prestamos (id, fecha_inicio, fecha_devolucion, rut_socio, isbn_libro) VALUES (5, '27-1-2020', '04-2-2020', '2222222-2', '111-111 1111-11 1');
INSERT INTO prestamos (id, fecha_inicio, fecha_devolucion, rut_socio, isbn_libro) VALUES (6, '31-1-2020', '12-2-2020', '1111111-1', '444-444 4444-44 4');
INSERT INTO prestamos (id, fecha_inicio, fecha_devolucion, rut_socio, isbn_libro) VALUES (7, '31-1-2020', '12-2-2020', '3333333-3', '222-222 2222-22 2');

-- (a) Mostrar todos los libros que posean menos de 300 páginas
SELECT * FROM libros WHERE numero_paginas < 300;

-- (b) Mostrar todos los autores que hayan nacido después del 01-01-1970
SELECT * FROM autores WHERE fecha_nacimiento > '1-1-1970';

-- (c) ¿Cuál es el libro más solicitado?
select titulo as solicitado, count(ISBN_libro) from prestamos inner join libros on prestamos.ISBN_libro = libros.ISBN group by titulo order by count desc limit 1;

-- (d) Si se cobrara una multa de $100 por cada día de atraso, mostrar cuánto debería pagar cada usuario que entregue el préstamo después de 7 días.
