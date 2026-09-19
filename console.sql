create database absherDB;
use absherDB;
create table citizen(
    national_id char(10) primary key check (national_id REGEXP '[0-9]{10}$'),
    name varchar(20) not null ,
    birthdate date not null,
    gender char(1) not null check ( gender='f' or gender= 'm' ),
    phone varchar(10) not null unique check ( phone REGEXP '^[05][0-9]{8}$'),
    email varchar(30) unique
);

CREATE table passport(
    passport_number varchar(20) primary key,
    citizen_id char(10) not null unique,
    issue_date date not null,
    expiry_date date not null,
    status varchar(10) default 'valid' check( status = 'valid' or status = 'expired' or status = 'Cancelled' ),
    check( expiry_date > issue_date ),
    foreign key (citizen_id) references citizen(national_id)
);

create table vehicle (
    vehicle_id int auto_increment primary key,
    plate_number varchar(10) not null unique,
    owner_id char(10) not null,
    make varchar(30) not null,
    model varchar(30) not null,
    manufacture_year smallint not null check( manufacture_year >= 1950 ),
    color varchar(20),
    registration_expiry date not null,
    foreign key (owner_id) references citizen(national_id)
);

create table vehicle (
    vehicle_id int auto_increment primary key,
    plate_number varchar(10) not null unique,
    owner_id char(10) not null,
    make varchar(30) not null,
    model varchar(30) not null,
    manufacture_year smallint not null check( manufacture_year >= 1950 ),
    color varchar(20),
    registration_expiry date not null,
    foreign key (owner_id) references citizen(national_id)
);

create table traffic_violation (
    violation_id int auto_increment primary key,
    vehicle_id int not null,
    driver_id char(10),
    violation_type varchar(100) not null,
    violation_date datetime default current_timestamp,
    city varchar(50) not null,
    fine_amount decimal(8,2) not null check( fine_amount > 0 ),
    status varchar(10) default 'Unpaid' check( status = 'Unpaid' or status = 'Paid' or status = 'Objected' ),
    foreign key (vehicle_id) references vehicle(vehicle_id),
    foreign key (driver_id) references citizen(national_id)
);


