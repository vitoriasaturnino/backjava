drop schema if exists spring;

drop user if exists 'user'@'localhost';

create schema spring;

create user 'user'@'localhost' identified by 'password';

grant select, insert, delete, update on spring.* to user@'localhost';

use spring;

create table usr_user (
  usr_id bigint unsigned not null auto_increment,
  usr_name varchar(20) not null,
  usr_password varchar(150) not null,
  primary key (usr_id),
  unique key uni_user_name (usr_name)
);

create table aut_authorization (
  aut_id bigint unsigned not null auto_increment,
  aut_name varchar(20) not null,
  primary key (aut_id),
  unique key uni_aut_name (aut_name)
);

create table uau_user_authorization (
  usr_id bigint unsigned not null,
  aut_id bigint unsigned not null,
  primary key (usr_id, aut_id),
  foreign key aut_user_fk (usr_id) references usr_user (usr_id) on delete restrict on update cascade,
  foreign key aut_authorization_fk (aut_id) references aut_authorization (aut_id) on delete restrict on update cascade
);

create table ant_annotation (
  ant_id bigint unsigned not null auto_increment,
  ant_text varchar(256) not null,
  ant_date_time datetime not null,
  ant_usr_id bigint unsigned not null,
  primary key (ant_id),
  foreign key ant_usr_fk (ant_usr_id) references usr_user(usr_id)
);

insert into usr_user (usr_name, usr_password)
  values ('admin', '$2a$10$i3.Z8Yv1Fwl0I5SNjdCGkOTRGQjGvHjh/gMZhdc3e7LIovAklqM6C');
insert into aut_authorization (aut_name)
  values ('ROLE_ADMIN');
insert into uau_user_authorization (usr_id, aut_id) 
  values (1, 1);
insert into ant_annotation (ant_text, ant_date_time, ant_usr_id)
  values('My new project', '2023-08-028 13:13', 1);
