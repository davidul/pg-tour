--  Create enum
create type status as enum('active', 'inactive', 'deleted');

-- create table
create table users (
    id serial primary key,
    username varchar(255) not null,
    password varchar(255) not null,
    email varchar(255) not null,
    status status not null default 'active', -- <-- enum
    created_at timestamp not null default current_timestamp,
    updated_at timestamp not null default current_timestamp
);

insert into users (username, password, email, status)
values ('admin', 'admin', 'admin@admin', 'active');

select * from users;

--
select enum_first(null::status);
select enum_last(null::status);
select enum_range(null::status);

-- alter enum
-- Add value
alter type status add value 'some' after 'active';
insert into users (username, password, email, status)
values ('admin', 'admin', 'admin@admin', 'some');
-- Remove value
-- alter type status drop attribute if exists 'some' cascade;
-- updated enum
alter table users alter column status type varchar;
insert into users (username, password, email, status)
values ('admin', 'admin', 'admin@admin', 'new value');

alter type status add value 'new value';
alter table users alter column status type status using status::text::status;

alter type status rename value 'some' to 'new';

insert into users (username, password, email, status)
values ('admin', 'admin', 'admin@admin', 'xxx');


-- cleanup
drop table users;
drop type status;

select pg_size_pretty(pg_relation_size('users'));
select txid_current();
select * from pg_attribute;

