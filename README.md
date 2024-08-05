# ProyectoSQL  Se resolvio 4 problematicas que se enfrenta el banco ITBA, el lenguaje que se utilizo para resolver estos inconvenientes fue SQL.
## Introducción
ITBANK tiene un modelo de datos definido para la operación de su negocio. El 
modelo de datos permite conocer:
 Los tipos de los datos que hay en la base y la forma en que se relacionan.
 Las restricciones de integridad
 Entender cómo llevar adelante operaciones de manipulación de los datos
Se adjunta el siguiente extracto con las principales entidades:
### Primera problemática
Dada la base de datos ITBANK, se solicita ampliar el modelo de datos 
conocido con las nuevas entidades generadas por el home banking.
- Crear en la base de datos los tipos de cliente, de cuenta y marcas de 
tarjeta. Insertar los valores según la información provista en el Sprint 
5
- Agregar la entidad tarjeta teniendo en cuenta los atributos 
necesarios para la operación del home banking (se sugieren los 
siguientes campos Numero (único e irrepetible, con una restricción 
ante cada inserción que no debe superar 20 números/espacios), CVV, 
Fecha de otorgamiento, Fecha Expiración). Almacenar si es una 
tarjeta de crédito o débito. 
- Relacionar las tarjetas con la tabla donde se guardan las marcas de 
tarjeta
- Relacionar las tarjetas con el cliente al que pertenecen
- Insertar 500 tarjetas de crédito con sus respectivos datos 
(www.generatedata.com) asociándolas a los clientes de forma 
aleatoria
- Agregar la entidad direcciones, que puede ser usada por los clientes, 
empleados y sucursales con los campos utilizados en el SPRINT 5
- Insertar 500 direcciones, asignando del lote inicial a empleados, 
clientes o sucursal de forma aleatoria. Teniendo en cuenta que un 
cliente o empleado puede tener múltiples direcciones, pero la 
sucursal, solo una.
- Ampliar el alcance de la entidad cuenta para que identifique el tipo de 
la misma
- Asignar un tipo de cuenta a cada registro de cuenta de forma 
aleatoria
- Corregir el campo employee_hire_date de la tabla empleado con la 
fecha en formato YYYY-MM-DD
Para tal fin se recomienda usar las sentencias CREATE, ALTER, INSERT y 
## UPDATE
### Segunda problemática 
Una vez realizado los cambios en la base de datos, se pide entregar un archivo SQL 
con los siguientes requerimientos de consulta frecuente.
 Crear una vista con las columnas id, numero sucursal, nombre, apellido, DNI 
y edad de la tabla cliente calculada a partir de la fecha de nacimiento
o Mostrar las columnas de los clientes, ordenadas por el DNI de menor 
a mayor y cuya edad sea superior a 40 años
o Mostrar todos los clientes que se llaman “Anne” o “Tyler” ordenados 
por edad de menor a mayor
 Dado el siguiente JSON. Insertar 5 nuevos clientes en la base de datos y 
verificar que se haya realizado con éxito la inserción
[
{
"customer_name": "Lois",
"customer_surname": "Stout",
"customer_DNI": 47730534,
"branch_id": 80,
"customer_dob": "1984-07-07"
},
{
"customer_name": "Hall",
"customer_surname": "Mcconnell",
"customer_DNI": 52055464,
"branch_id": 45,
"customer_dob": "1968-04-30"
},
{
"customer_name": "Hilel",
"customer_surname": "Mclean",
"customer_DNI": 43625213,
"branch_id": 77,
"customer_dob": "1993-03-28"
},
{
"customer_name": "Jin",
"customer_surname": "Cooley",
"customer_DNI": 21207908,
"branch_id": 96,
"customer_dob": "1959-08-24"
},
{
"customer_name": "Gabriel",
"customer_surname": "Harmon",
"customer_DNI": 57063950,
"branch_id": 27,
"customer_dob": "1976-04-01"
}
]
 Actualizar 5 clientes recientemente agregados en la base de datos dado que 
hubo un error en el JSON que traía la información, la sucursal de todos es 
la 10
 Eliminar el registro correspondiente a “Noel David” realizando la selección 
por el nombre y apellido
 Consultar sobre cuál es el tipo de préstamo de mayor importe
### Tercera problemática 
 Seleccionar las cuentas con saldo negativo
 Seleccionar el nombre, apellido y edad de los clientes que tengan en el 
apellido la letra Z
 Seleccionar el nombre, apellido, edad y nombre de sucursal de las personas 
cuyo nombre sea “Brendan” y el resultado ordenarlo por nombre de 
sucursal
 Seleccionar de la tabla de préstamos, los préstamos con un importe mayor
a $80.000 y los préstamos prendarios utilizando la unión de 
tablas/consultas (recordar que en las bases de datos la moneda se guarda 
como integer, en este caso con 2 centavos)
 Seleccionar los prestamos cuyo importe sea mayor que el importe medio de 
todos los prestamos
 Contar la cantidad de clientes menores a 50 años
 Seleccionar las primeras 5 cuentas con saldo mayor a 8.000$
 Seleccionar los préstamos que tengan fecha en abril, junio y agosto, 
ordenándolos por importe
 Obtener el importe total de los prestamos agrupados por tipo de préstamos. 
Por cada tipo de préstamo de la tabla préstamo, calcular la suma de sus 
importes. Renombrar la columna como loan_total_accu
### Cuarta problemática 
 Listar la cantidad de clientes por nombre de sucursal ordenando de mayor 
a menor
 Obtener la cantidad de empleados por cliente por sucursal en un número
real
 Obtener la cantidad de tarjetas de crédito por tipo por sucursal
 Obtener el promedio de créditos otorgado por sucursal
 La información de las cuentas resulta critica para la compañía, por eso es 
necesario crear una tabla denominada “auditoria_cuenta” para guardar los 
datos movimientos, con los siguientes campos: old_id, new_id, old_balance, 
new_balance, old_iban, new_iban, old_type, new_type, user_action, 
created_at
o Crear un trigger que después de actualizar en la tabla cuentas los 
campos balance, IBAN o tipo de cuenta registre en la tabla auditoria
o Restar $100 a las cuentas 10,11,12,13,14
 Mediante índices mejorar la performance la búsqueda de clientes por DNI
 Crear la tabla “movimientos” con los campos de identificación del 
movimiento, número de cuenta, monto, tipo de operación y hora
o Mediante el uso de transacciones, hacer una transferencia de 1000$ 
desde la cuenta 200 a la cuenta 400
o Registrar el movimiento en la tabla movimientos
o En caso de no poder realizar la operación de forma completa, realizar 
un ROLLBAC
