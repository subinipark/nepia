-- DML section...



-- # Inserted dummy data for table 'tasks'
insert into tasks (name, order_no, updated_at)
values ('기획 및 요구사항 분석', 1, now());

insert into tasks (name, order_no, updated_at)
values ('설계', 2, now());

insert into tasks (name, order_no, updated_at)
values ('구현', 3, now());

insert into tasks (name, order_no, updated_at)
values ('테스트 및 유지보수', 4, now());
