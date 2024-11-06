create table o_emp(
    e_id int,
    fname varchar(45),
    lname varchar(45),
    salary int
);
-- 2. create new table
create table n_emp(
    ne_id int primary key,
    nfname varchar(45),
    nlname varchar(45),
    nsalary int
);
--3. Insert data in old table
insert into o_emp (e_id, fname, lname, salary)
values (1,'Ayush', 'B', 20000),
    (2,'Piyush', 'Joih', 30000),
    (3,'Kumar', 'Yadav', 34000),
    (4,'Ash', 'M', 40000),
    (5,'Ajey', 'N', 30000),
    (6,'Yash', 'S', 40000);
--4. Create a cursor
CURSOR with loop
 create procedure copyEmp()
 begin
     declare done int default false;
     declare n_e_id int;
     declare n_fname varchar(45);
     declare n_lname varchar(45);
     declare n_salary int;

     declare cur cursor for
        select e_id, fname, lname, salary from o_emp;

     declare continue handler for not found set done = true;

     open cur;
     read_loop :LOOP
         fetch cur into n_e_id, n_fname, n_lname, n_salary; 
     if done then
        leave read_loop;
     end if;
        if not exists(select 1 from n_emp where n_emp.ne_id=n_e_id)
        then
            insert into n_emp(ne_id, nfname,nlname,nsalary) values(n_e_id,n_fname,n_lname,n_salary);
        end if;
     end loop;
     close cur;
 end;

-- cal the procedure
call copyEmp();
--check
select *
from n_emp;