--SEGUNDA PROBLEMATICA


CREATE VIEW Vista_Edad 
AS
SELECT *,
       strftime('%Y', 'now') - strftime('%Y', dob) - (strftime('%m-%d', 'now') < strftime('%m-%d', dob)) AS EDAD
FROM cliente;
--o Mostrar las columnas de los clientes, ordenadas por el DNI de menor a mayor y cuya edad sea superior a 40 años

SELECT customer_name,customer_DNI,EDAD
FROM Vista_Edad
WHERE EDAD>40
ORDER BY customer_DNI 
;
-- Mostrar todos los clientes que se llaman “Anne” o “Tyler” ordenados por edad de menor a mayor
SELECT customer_name, EDAD
FROM Vista_Edad
WHERE customer_name LIKE 'Anne' OR customer_name LIKE 'Tyler'
ORDER BY EDAD ;


INSERT INTO cliente
VALUES
(
501,
 "Lois",
 "Stout",
 47730534,
 "1984-07-07",
 80
 )
 
 
--delete from cliente
--where customer_id=501;
INSERT INTO cliente
VALUES
(502,
 "Hall",
 "Mcconnell",
 52055464,
 "1968-04-30",
 45)
INSERT INTO cliente
VALUES
(503, "Hilel", "Mclean", 43625213,"1993-03-28", 77),
(504, "Jin","Cooley", 21207908,"1959-08-24",96),
(505,"Gabriel","Harmon",57063950,"1976-04-01",27);
-- Actualizar 5 clientes recientemente agregados en la base de datos dado que hubo un error en el JSON que traía la información, la sucursal de todos es la 10
UPDATE cliente SET branch_id=10 WHERE customer_id=501
UPDATE cliente SET branch_id=10 WHERE customer_id=502;
UPDATE cliente SET branch_id=10 WHERE customer_id=503;
UPDATE cliente SET branch_id=10 WHERE customer_id=504;
UPDATE cliente SET branch_id=10 WHERE customer_id=505;
--Eliminar el registro correspondiente a “Noel David” realizando la selección por el nombre y apellido
select * from cliente
where customer_name = 'Noel David';

DELETE FROM cliente
WHERE customer_name = 'Noel David';

--Consultar sobre cuál es el tipo de préstamo de mayor importe

SELECT loan_date,loan_type,customer_id,loan_total FROM prestamo
ORDER BY loan_total DESC
LIMIT 1;

--TERCERA PROBLEMATICA
--Seleccionar las cuentas con saldo negativo
SELECT balance,iban 
FROM cuenta
WHERE balance < 0
;
--Seleccionar el nombre, apellido y edad de los clientes que tengan en el apellido la letra Z

SELECT customer_name,customer_surname,EDAD
FROM Vista_Edad
WHERE customer_surname LIKE '%Z%';

-- Seleccionar el nombre, apellido, edad y nombre de sucursal de las personas cuyo nombre sea “Brendan” y el resultado ordenarlo por nombre de 
--sucursal
SELECT T1.customer_name,T1.customer_surname,T1.EDAD,T2.branch_name
FROM Vista_Edad T1
INNER JOIN sucursal T2 ON T1.branch_id=T2.branch_id
WHERE T1.customer_name = 'Brendan'
ORDER BY t2.branch_name;
--Seleccionar de la tabla de préstamos, los préstamos con un importe mayor a $80.000 y los préstamos prendarios utilizando la unión de 
--tablas/consultas (recordar que en las bases de datos la moneda se guarda como integer, en este caso con 2 centavos)
SELECT *
FROM prestamo      
WHERE loan_total > 8000000 
UNION 
SELECT *
FROM prestamo
WHERE loan_type = 'PRENDARIO';
--Seleccionar los prestamos cuyo importe sea mayor que el importe medio de todos los prestamos
SELECT loan_date,loan_type,loan_total
FROM prestamo
WHERE loan_total >(SELECT AVG(loan_total) FROM prestamo)
;
--Seleccionar las primeras 5 cuentas con saldo mayor a 8.000$
SELECT iban,balance
FROM cuenta
WHERE balance> 8000
LIMIT 5;
--Seleccionar los préstamos que tengan fecha en abril, junio y agosto, ordenándolos por importe
SELECT loan_date,loan_total
FROM prestamo
WHERE loan_date LIKE '%-04-%' OR loan_date LIKE '%-06-%' OR loan_date LIKE '%-08-%'
ORDER BY loan_total;
--Obtener el importe total de los prestamos agrupados por tipo de préstamos. Por cada tipo de préstamo de la tabla préstamo, calcular la suma de sus 
--importes. Renombrar la columna como loan_total_accu
SELECT loan_type,SUM(loan_total) AS loan_total_accu
FROM prestamo
GROUP BY loan_type;
--CUARTA PROBLEMATICA
--Listar la cantidad de clientes por nombre de sucursal ordenando de mayor a menor
SELECT t2.branch_name,COUNT(t1.customer_id) AS Cantidad_Clientes
FROM cliente t1
INNER JOIN sucursal t2 ON t1.branch_id=t2.branch_id
GROUP BY t2.branch_name
ORDER BY COUNT(t1.customer_id) DESC;

-- Obtener la cantidad de empleados por cliente por sucursal en un número real

SELECT cliente.customer_id, cliente.customer_name as nombre_cliente, sucursal.branch_id, sucursal.branch_name as nombre_sucursal, COUNT(empleado.employee_id) as cantidad_empleados
FROM cliente
JOIN sucursal ON cliente.branch_id = sucursal.branch_id
LEFT JOIN empleado ON sucursal.branch_id= empleado.branch_id
GROUP BY cliente.customer_id, cliente.customer_name, sucursal.branch_id, sucursal.branch_name
ORDER BY COUNT(empleado.employee_id) DESC;


--Obtener la cantidad de tarjetas de crédito por tipo por sucursal
SELECT COUNT(T2.ID_Tarjeta) AS cant_tarjeta,T1.Nombre,T4.branch_name,T4.branch_id
FROM MarcasTarjeta T1
INNER JOIN Tarjeta T2 ON T1.ID_MarTarjeta=T2.ID_MarTarjeta
INNER JOIN cliente T3  ON T2.ID_Customer=T3.customer_id
INNER JOIN sucursal T4 ON T3.branch_id=T4.branch_id
GROUP BY T1.Nombre,T4.branch_name,T4.branch_id


  --Crear un trigger que después de actualizar en la tabla cuentas los campos balance, IBAN o tipo de cuenta registre en la tabla auditoria

CREATE TABLE auditoria_cuenta (
    old_id INT,
    new_id INT,
    old_balance DECIMAL(10,2),
    new_balance DECIMAL(10,2),
    old_iban VARCHAR(30),
    new_iban VARCHAR(30),
    old_type VARCHAR(20),
    new_type VARCHAR(20),
    user_action VARCHAR(50),
    created_at TIMESTAMP
);
-- La información de las cuentas resulta critica para la compañía, por eso es necesario crear una tabla denominada “auditoria_cuenta” para guardar los 
--datos movimientos, con los siguientes campos: old_id, new_id, old_balance, new_balance, old_iban, new_iban, old_type, new_type, user_action, created_at
--o Crear un trigger que después de actualizar en la tabla cuentas los campos balance, IBAN o tipo de cuenta registre en la tabla auditoria
--o Restar $100 a las cuentas 10,11,12,13,14

CREATE TRIGGER after_cuenta_update3
AFTER UPDATE ON cuenta
FOR EACH ROW
BEGIN
    -- Restar $100 a las cuentas 10, 11, 12, 13, 14
    UPDATE cuenta
    SET balance = CASE WHEN NEW.id IN (10, 11, 12, 13, 14) THEN NEW.balance - 100 ELSE NEW.balance END
    WHERE id = NEW.id;

    -- Registrar la auditoría
    INSERT INTO auditoria_cuenta (old_id, new_id, old_balance, new_balance, old_iban, new_iban, old_type, new_type, user_action, created_at)
    VALUES (OLD.id, NEW.id, OLD.balance, NEW.balance, OLD.iban, NEW.iban, OLD.type, NEW.type, 'UPDATE', strftime('%Y-%m-%d %H:%M:%S', 'now'));
END;


--Mediante índices mejorar la performance la búsqueda de clientes por DNI

CREATE VIEW indices_dni 
AS 
SELECT customer_DNI
FROM cliente

DROP VIEW indices_dni

SELECT * FROM indices_dni
SELECT * FROM cuenta;

-- Crear la tabla “movimientos” con los campos de identificación del movimiento, número de cuenta, monto, tipo de operación y hora 
--o Mediante el uso de transacciones, hacer una transferencia de 1000$ desde la cuenta 200 a la cuenta 400 o Registrar el movimiento en la tabla movimientos
--o En caso de no poder realizar la operación de forma completa, realizar un ROLLBAC
drop table movimientos


-- Crear la tabla "movimientos"
CREATE TABLE movimientos (
    id INTEGER PRIMARY KEY,
    numero_cuenta INTEGER,
    monto DECIMAL(10,2),
    tipo_operacion VARCHAR(20),
    hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Realizar la transferencia
-- Inicia la transacción automáticamente en SQLite
BEGIN;

-- Intenta realizar la transferencia
-- Resta $1000 de la cuenta 200
UPDATE cuentas SET balance = balance - 1000 WHERE numero_cuenta = 200;

-- Añade el registro de movimiento para la cuenta 200
INSERT INTO movimientos (numero_cuenta, monto, tipo_operacion) VALUES (200, -1000, 'TRANSFERENCIA');

-- Verifica si se puede realizar la transferencia completa
-- Si la cuenta 200 tiene suficiente saldo
IF (SELECT balance FROM cuentas WHERE numero_cuenta = 200) >= 0 THEN
    -- Suma $1000 a la cuenta 400
    UPDATE cuentas SET balance = balance + 1000 WHERE numero_cuenta = 400;

    -- Añade el registro de movimiento para la cuenta 400
    INSERT INTO movimientos (numero_cuenta, monto, tipo_operacion) VALUES (400, 1000, 'TRANSFERENCIA');

    -- Confirma automáticamente en SQLite si todo está bien
    COMMIT;

-- Si no se puede realizar la transferencia completa
ELSE
    -- Revierte automáticamente en SQLite
    ROLLBACK;
END IF;

  
  
  


























