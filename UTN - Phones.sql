create database utnphones;
use utnphones;
-- drop database utnphones;

SET GLOBAL time_zone =  '-3:00';
SET GLOBAL event_scheduler = ON;

create table provinces(
	id_province int auto_increment primary key,
	province_name varchar(50)
);

create table cities(
	id_city int not null auto_increment primary key,
	city_name varchar(50),
	prefix smallint(3) unsigned zerofill,
	id_province_fk int,
	constraint fk_province foreign key(id_province_fk) references provinces(id_province)
);

create table rates(
	id_rate int not null auto_increment primary key,
	price_per_min decimal(12,2),
	cost_per_min decimal(12,2),
	id_city_from_fk int,
	id_city_to_fk int,
	constraint fk_city_from foreign key (id_city_from_fk) references cities(id_city),
	constraint fk_city_to foreign key (id_city_to_fk) references cities(id_city)
);
    
create table users(
	id_user int not null auto_increment primary key,
	first_name varchar(50),
	surname varchar(50),
	dni int unique key,
	birthdate datetime,
	username varchar(50) unique key,
	pwd varchar(50),
	email varchar(50),
    user_type enum ('CLIENT','EMPLOYEE'),
    user_status enum('ACTIVE','DELETE') default 'ACTIVE',
	id_city_fk int,
	constraint fk_id_city foreign key (id_city_fk) references cities(id_city)
);
    
create table user_lines(
	id_user_line int not null auto_increment primary key,
	line_number bigint(10) unsigned zerofill unique key ,
	type_line enum('MOBILE','RESIDENCE'),
	line_status enum('ACTIVE','SUSPENDED','DELETE') default 'ACTIVE',
	id_client_fk int,
	constraint fk_id_client foreign key (id_client_fk) references users(id_user)
);

create table invoices(
	id_invoice int not null auto_increment primary key,
	call_count int,
	total_cost decimal (12,2) ,
	total_price decimal(12,2) ,
	date_emission datetime ,
	date_expiration datetime ,
	invoice_status enum('PAID','NOT_PAID') default 'NOT_PAID',
	id_line_fk int,
	constraint fk_id_line foreign key (id_line_fk) references user_lines(id_user_line)
);

create table phonecalls(
	id_phonecall int not null auto_increment primary key,
	line_number_from varchar(10),
    line_number_to varchar(10),
    id_line_number_from_fk int,
	id_line_number_to_fk int,
	id_city_from_fk int,
	id_city_to_fk int,
	duration int,
	call_date datetime,
 	cost_per_min decimal (12,2),
 	price_per_min decimal (12,2),
 	total_price decimal (12,2),
 	total_cost decimal(12,2),
	id_invoice_fk int default null,
	constraint fk_id_invoice foreign key (id_invoice_fk) references invoices(id_invoice),
    constraint fk_id_city_from foreign key (id_city_from_fk) references cities(id_city),
    constraint fk_id_city_to foreign key (id_city_to_fk) references cities(id_city),
    constraint fk_id_line_number_from foreign key (id_line_number_from_fk) references user_lines(id_user_line),
    constraint fk_id_line_number_to foreign key (id_line_number_to_fk) references user_lines(id_user_line)
);

INSERT INTO provinces (province_name) values('Buenos Aires'),('Buenos Aires-GBA'),('Capital Federal'),('Catamarca'),('Chaco'),('Chubut'),('Córdoba'),('Corrientes'),('Entre Ríos'),('Formosa'),('Jujuy'),('La Pampa'),('La Rioja'),('Mendoza'),('Misiones'),('Neuquén'),('Río Negro'),('Salta'),('San Juan'),('San Luis'),('Santa Cruz'),('Santa Fe'),('Santiago del Estero'),('Tierra del Fuego'),('Tucumán');
insert into cities(city_name,prefix,id_province_fk)values("Mar del Plata","223",1),("La Plata","011",3),("Bahia Blanca","291",1),("Catamarca ","383",4),("Córdoba ","351",7),("Corrientes","378",8),("Resistencia","372",5),("Rawson","296",10),("Parana","343",9);

insert into users(first_name,surname,dni,birthdate,username,pwd,email,user_type,id_city_fk) values("Ivan","Graciarena","38704049",'1995-01-11',"ivanmdq22","123","ivanigraciarena@hotmail.com",1,1),("Juan","Garcia","36993049",'1990-03-30',"juancho","j2020","juang@hotmail.com",1,5),("Jorge","Villordo","39748321",'1983-10-17',"villordin","villoria","villord@hotmail.com",1,4),("Pedro","Mujica","203935789",'1940-11-22',"mijuquin","mijuaquin","pepe@hotmail.com",1,3),("Miguel","Granados","25090384",'1943-01-22',"miguelon","elguachon","miguegrana@hotmail.com",1,2);

insert into user_lines (id_client_fk,line_number,type_line) values (1,"2235765132",1),(1,"2234770469",2),(2,"3511557539",1),(3,"3834918309",2),(4,"2918309532",1),(5,"0114998997",2);

insert into rates (price_per_min,cost_per_min,id_city_from_fk,id_city_to_fk)values(8,5,1,1),(8,5,2,2),(8,5,3,3),(8,5,4,4),(8,5,5,5),(8,5,6,6),(8,5,7,7),(8,5,8,8),(8,5,9,9),(9,5,1,2),(9,5,2,1),(10,5,1,3),(10,5,3,1),(9,5,1,4),(9,5,4,1),(9,7,1,5),(9,7,5,1),(15,10,1,6),(15,10,6,1),(14,11,1,7),(14,11,7,1),(10,8,1,8),(10,8,8,1),(8,6,1,9),(8,6,9,1),(10,5,2,3),(10,5,3,2),(9,5,2,4),(9,5,4,2),(9,7,2,5),(9,7,5,2),(15,10,2,6),(15,10,6,2),(14,11,2,7),(14,11,7,2),(10,8,2,8),(10,8,8,2),(8,6,2,9),(8,6,9,2),(9,5,3,4),(9,5,4,3),(9,7,3,5),(9,7,5,3),(15,10,3,6),(15,10,6,3),(14,11,3,7),(14,11,7,3),(10,8,3,8),(10,8,8,3),(8,6,3,9),(8,6,9,3),(9,7,4,5),(9,7,5,4),(15,10,4,6),(15,10,6,4),(14,11,4,7),(14,11,7,4),(10,8,4,8),(10,8,8,4),(8,6,4,9),(8,6,9,4),(15,10,5,6),(15,10,6,5),(14,11,5,7),(14,11,7,5),(10,8,5,8),(10,8,8,5),(8,6,5,9),(8,6,9,5),(14,11,6,7),(14,11,7,6),(10,8,6,8),(10,8,8,6),(8,6,6,9),(8,6,9,6),(10,8,7,8),(10,8,8,7),(8,6,7,9),(8,6,9,7),(8,6,8,9),(8,6,9,8);

#insert into invoices (call_count,date_emission,date_expiration,id_line_fk,price_cost,price_total)values(1,'2020-05-06','2020-05-21',1,200,350);
#insert into phonecalls(line_number_from,line_number_to,id_line_number_from_fk,id_line_number_to_fk,id_city_from_fk,id_city_to_fk,duration,call_date,id_invoice_fk)values("2235765132","11499899",1,6,1,2,20,'2020-04-03',1),("2235765132","11499899",1,6,1,3,20,'2020-01-05',1),("2235765132","11499899",1,6,1,5,20,'2020-04-03',1),(6,5,2,3,20,'2020-01-05',1),(6,3,2,5,20,'2020-04-05',1),(5,4,3,4,20,'2020-02-05',1),(6,3,2,5,20,'2020-04-05',1),(1,5,1,2,20,'2020-07-05',1),(4,6,4,2,20,'2020-02-05',1),(5,6,3,2,20,'2020-07-05',1);

#//////////////////////////////ADD-PHONECALL//////////////////////////////////
#drop trigger TBI_ADD_PHONECALL;
#select * from phonecalls;
Delimiter //
CREATE TRIGGER TBI_ADD_PHONECALL before insert on phonecalls for each row 
begin
	declare vIdCityFrom int;
    declare vIdCityTo int;
    declare vIdLineFrom int;
    declare vIdLineTo int;
    declare vPricePerMin int;
    declare vCostPerMin int;
    declare vTotalCost int;
    declare vTotalPrice int;
    set vIdCityFrom=CALCULATE_ID_CITY(new.line_number_from);
    set vIdCityTo=CALCULATE_ID_CITY(new.line_number_to);
    set vIdLineFrom=CALCULATE_ID_LINE(new.line_number_from);
    set vIdLineTo=CALCULATE_ID_LINE(new.line_number_to);
    set vPricePerMin=CALCULATE_PRICE_PER_MIN(vIdCityFrom,vIdCityTo);
    set vCostPerMin=CALCULATE_COST_PER_MIN(vIdCityFrom,vIdCityTo);
    set vTotalCost=CALCULATE_TOTAL(new.duration,vCostPerMin);
    set vTotalPrice=CALCULATE_TOTAL(new.duration,vPricePerMin);
    set new.id_line_number_from_fk=vIdLineFrom;
    set new.id_line_number_to_fk=vIdLineTo;
    set new.id_city_from_fk=vIdCityFrom;
    set new.id_city_to_fk=vIdCityTo;
    set new.cost_per_min=vCostPerMin;
    set new.price_per_min=vPricePerMin;
    set new.total_cost=vTotalCost;
    set new.total_price=vTotalPrice;
    set new.call_date=now();
end //
#/////////////////////////////////////////////////////////////////
Delimiter //
CREATE DEFINER=`root`@`localhost` FUNCTION `CALCULATE_COST_PER_MIN`(pIdCityFrom int,pCityTo int) RETURNS int(11)
    READS SQL data
begin
	declare vReturn int;
    set vReturn=(select cost_per_min from rates where pIdCityFrom=id_city_from_fk && pCityTo=id_city_to_fk);
	return vReturn;
end //

#/////////////////////////////////////////////////////////////////
Delimiter //
CREATE DEFINER=`root`@`localhost` FUNCTION `CALCULATE_ID_CITY`(lineNumber varchar(40)) RETURNS int(11)
    READS SQL DATA
begin
	declare vPrefixCity int;
    declare vReturn int;
    set vPrefixCity=CALCULATE_PREFIX(lineNumber);
	set vReturn=(select id_city from cities where prefix=vPrefixCity);
	return vReturn;
end //
#/////////////////////////////////////////////////////////////////
Delimiter //
CREATE DEFINER=`root`@`localhost` FUNCTION `CALCULATE_ID_LINE`(plineNumber varchar(40)) RETURNS int(11)
    READS SQL DATA
begin
	declare vReturn int;
    set vReturn=(select id_user_line from user_lines where line_number=pLineNumber);
    return vReturn;
end //
#/////////////////////////////////////////////////////////////////
Delimiter //
CREATE DEFINER=`root`@`localhost` FUNCTION `CALCULATE_PREFIX`(pLineNumber varchar(40)) RETURNS int(11)
    READS SQL DATA
begin
	declare vReturn int;
    set vReturn=substring(pLineNumber,1,3);
    return vReturn;
end //
#/////////////////////////////////////////////////////////////////
Delimiter //
CREATE DEFINER=`root`@`localhost` FUNCTION `CALCULATE_PRICE_PER_MIN`(pIdCityFrom int,pCityTo int) RETURNS int(11)
    READS SQL DATA
begin
	declare vReturn int;
    set vReturn=(select price_per_min from rates where pIdCityFrom=id_city_from_fk && pCityTo=id_city_to_fk);
	return vReturn;
end //
#/////////////////////////////////////////////////////////////////
Delimiter //
CREATE DEFINER=`root`@`localhost` FUNCTION `CALCULATE_TOTAL`(pDuration int,pValuePorMin int) RETURNS int(11)
    READS SQL DATA
begin
	declare vReturn int;
    set vReturn=(pDuration*pValuePorMin);
    return vReturn;
end //
#/////////////////////////////////////////////////////////////////

#select * from user_lines;
#update user_lines set line_status='DELETE' where id_user_line=1
#select * from phonecalls;
#select * from cities;
#delete from phonecalls


#/////////////////////////////////////////////////////////////////
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;    
rollback;
show engines;
#sp_add_phone_line(line type, username ,line number, line status)
#agregar transaccion
set autocommit = 0;
Delimiter //
create procedure sp_add_user_line(pUserDni int,pLineNumber bigint,pLineStatus int,pLineType int)
begin
	declare vUser_id int default 0;
    declare vIdLine int;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;
    start transaction;
    select id into vUser_id from users us where us.dni=pUserDni;
    if(vUser_id <> 0) then
		insert into user_lines (line_number,type_line,line_status,id_client) values (pLineNumber,pLineType,pLineStatus,vUser_id);
         set vIdLine = last_insert_id();
		insert into invoices (call_count,price_cost,price_total,date_emission,date_expiration,invoice_statu,id_line) values (0,0,0,Date(now()),LAST_DAY(now()),1,vIdLine);
	else 
		signal sqlstate '45000'
		SET MESSAGE_TEXT = 'El Dni ingresado no coincide con un Cliente existente.',
		MYSQL_ERRNO = 1001;
	end if;
    commit;
end; //
#select * from users
#select * from user_lines;
#select * from invoices;
#drop procedure sp_add_user_line;
#call sp_add_user_line(38704049,2235679563,1,2);
#////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#facturas de un usuario emitidas por un rango de fechas
Delimiter //
create procedure sp_invoices_betweendates(in pIdUser int,in date_from datetime, in date_to datetime)
begin 
	set date_to=DATE_ADD(date_to, INTERVAL '23 59' hour_minute);
	select inv.call_count,
		   #inv.total_cost,
           inv.total_price,
           inv.date_emission,
           inv.date_expiration,
           #inv.invoice_status,
           inv.id_line_fk
	from invoices as inv
	inner join user_lines ul 
    on inv.id_line_fk=ul.id_user_line
    inner join users u
    on ul.id_client_fk=u.id_user
	where inv.date_emission >= date_from 
	and   inv.date_emission <= date_to
	and   u.id_user=PidUser;
end //
#drop procedure sp_invoices_betweendates
#select * from invoices
#select * from user_lines
#update invoices set date_emission='2020-05-27 00:00:00' where id_invoice=23;
#call sp_invoices_betweendates(3,'2020-05-23','2020-05-27');
#/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
# consulta llamadas de una usuario logueado por rango de fechas
Delimiter //
create procedure sp_phonecalls_betweendates(in pId int,in date_from datetime, in date_to datetime)
begin 
	set date_to=DATE_ADD(date_to, INTERVAL '23 59' hour_minute);
	select p.line_number_from,
		   p.line_number_to,
		   p.duration,
           p.id_city_from_fk,
           p.id_city_to_fk,
		   p.call_date,
		   p.total_price 
	from phonecalls as p 
	inner join user_lines ul 
    on p.id_line_number_from_fk=ul.id_user_line
    inner join users u
    on ul.id_client_fk=u.id_user
	where p.call_date >= date_from 
	and   p.call_date <= date_to
	and   u.id_user=Pid;
end //
#drop procedure sp_phonecalls_betweendates;
#select * from phonecalls
#update users set user_type='CLIENT' where id_user=1
#update phonecalls set call_date="2020-05-27 15:41:35" where id_phonecall=46;
#call sp_phonecalls_betweendates(3,'2020-05-20','2020-05-31');

#///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#consulta de los top 5 destinos mas llamados por el usuario
#drop procedure sp_user_top10;
Delimiter //
create procedure sp_user_top10(in pidUser int)
begin
	select line_number_to
	  from phonecalls as p
      inner join user_lines ul 
	  on p.id_line_number_from_fk=ul.id_user_line
	  inner join users u
	  on ul.id_client_fk=u.id_user
	  where p.line_number_from=ul.line_number && u.id_user=pIdUser
	  group by line_number_to
	  order by count(line_number_to) desc
	  limit 5;
end //
#call sp_user_top10(3);
#select * from user_lines
#insert into user_lines (line_number,type_line,line_status,id_client_fk)values('2236547876',1,1,6)
#////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#destino mas llamadi por el usuario(echo rancio)
/*select f.line_number_to as "destino mas llamado" ,concat(u.first_name," ",u.surname) as "Nombre Apellido"
from users as u 
join (select line_number_to, id_line_number_from_fk
	  from phonecalls
	  where line_number_from="2235765132"
	  group by line_number_to
	  order by count(line_number_to) desc
	  limit 1) as f
on f.id_line_number_from_fk = u.id_user;
*/
#/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#todas las llamadas de un usuario 
/*select p.line_number_from,p.line_number_to,p.id_city_from_fk,p.id_city_to_fk,p.duration,p.call_date,p.total_price
from phonecalls as p
join user_lines as ul
on p.id_line_number_from_fk=ul.id_user_line
join users as u
on ul.id_client_fk=u.id_user
where u.id_user=1;*/
#/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*y debe generar una
factura por línea y debe tomar en cuenta todas las llamadas no facturadas
para cada una de las líneas, sin tener en cuenta su fecha. La fecha de
vencimiento de esta factura será estipulada a 15 días.*/
Delimiter //
create function GET_USER_LINE_STATUS(pIdLine int)
returns int
reads sql data
begin
	declare vReturn int;
	if((select line_status from user_lines where id_user_line=pIdLine)='ACTIVE')then
		set vReturn=1;
	else
		set vReturn=0;
	end if;
    return vReturn;
end //
#/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////7
Delimiter //
create function IF_HAVE_PHONECALLS(pIdLine int)
returns int
reads sql data
begin
        declare vReturn int;
        
		if exists(select id_phonecall from phonecalls where id_line_number_from_fk=pIdLine && id_invoice_fk is null)then
			set vReturn=1;
        else
			set vReturn=0;
        end if;
        return vReturn;
end //
#drop function IF_HAVE_PHONECALLS;
#select IF_HAVE_PHONECALLS(6);
#select * from users
#select * from phonecalls
#update users set user_type='EMPLOYEE' where id_user=1
#/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////7
Delimiter //
create procedure sp_create_invoices()
begin
	DECLARE finished INTEGER DEFAULT 0;
	DECLARE id_userline int DEFAULT 0;

	DECLARE curUserLines 
		CURSOR FOR 
			SELECT id_user_line FROM user_lines;

	DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET finished = 1;

	OPEN curUserLines;

	getUserLine: LOOP
		FETCH curUserLines INTO id_userline;
		IF finished = 1 THEN 
			LEAVE getUserLine;
		END IF;
        if((IF_HAVE_PHONECALLS(id_userline)=1) && (GET_USER_LINE_STATUS(id_userline)=1))then 
				insert into invoices(id_line_fk)VALUES(id_userline);
		end if;
	END LOOP getUserLine;
	CLOSE curUserLines;
end //

#call sp_create_invoices();
#drop procedure sp_create_invoices;
#delete from phonecalls;
#delete from invoices;
#select * from INVOICES
#select * from user_lines
#select * from phonecalls
#update user_lines set line_status='DELETE' where id_user_line=1;
#insert into phonecalls(line_number_from,line_number_to,duration)values("3834918309","0114998997",35);
#///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#evento que se ejecuta primer dia de cada mes

CREATE EVENT invoice_facturation
ON SCHEDULE EVERY '1' MONTH
STARTS '2020-05-01 00:00:00'
DO
CALL sp_create_invoices();
#//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Delimiter //
create function CALCULATE_CALLCOUNT(pIdLine int)
returns int
reads sql data
begin
	declare vReturn int;
    set vReturn=(select count(*) from phonecalls where id_line_number_from_fk=pIdLine && id_invoice_fk is null);
	return vReturn;
end //
#////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Delimiter //
create function CALCULATE_TOTAL_COST(pIdLine int)
returns int
reads sql data
begin
	declare vReturn int;
    set vReturn=(select sum(total_cost) from phonecalls where id_line_number_from_fk=pIdLine && id_invoice_fk is null);
    return vReturn;
end //
#drop function CALCULATE_TOTAL_COST
#////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Delimiter //
create function CALCULATE_TOTAL_PRICE(pIdLine int)
returns int
reads sql data
begin
	declare vReturn int;
    set vReturn=(select sum(total_price) from phonecalls where id_line_number_from_fk=pIdLine && id_invoice_fk is null);
    return vReturn;
end //
#drop function CALCULATE_TOTAL_PRICE
#//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Delimiter //
create trigger tbi_calculate_invoice_data before insert on invoices for each row
begin
	declare vCallcount int;
    declare vTotalCost int;
    declare vTotalPrice int;
    declare vDateExp datetime;
    set vCallCount=CALCULATE_CALLCOUNT(new.id_line_fk);
    set vTotalCost=CALCULATE_TOTAL_COST(new.id_line_fk);
    set vTotalPrice=CALCULATE_TOTAL_PRICE(new.id_line_fk);
    set new.date_emission=now();
    set new.date_expiration=DATE_ADD(NOW(),INTERVAL 15 DAY);
    set new.total_price=vTotalPrice;
    set new.total_cost=vTotalCost;
    set new.call_count=vCallCount;
end //
#////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////77
Delimiter //
create trigger tai_addphonecall_to_invoice after insert on invoices for each row
begin
	update phonecalls set id_invoice_fk=new.id_invoice where id_line_number_from_fk=new.id_line_fk;
end //