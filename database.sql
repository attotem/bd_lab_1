-- Database: Shinkarenko

-- DROP DATABASE IF EXISTS "Shinkarenko";

CREATE DATABASE "Shinkarenko"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Ukrainian_Ukraine.1251'
    LC_CTYPE = 'Ukrainian_Ukraine.1251'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

-- Table: public.contacts

-- DROP TABLE IF EXISTS public.contacts;

CREATE TABLE IF NOT EXISTS public.contacts
(
    contact_id integer NOT NULL DEFAULT nextval('contacts_contact_id_seq'::regclass),
    email character varying(255) COLLATE pg_catalog."default" NOT NULL,
    phone character varying(20) COLLATE pg_catalog."default",
    user_id integer NOT NULL,
    CONSTRAINT contacts_pkey PRIMARY KEY (contact_id),
    CONSTRAINT contacts_email_key UNIQUE (email),
    CONSTRAINT contacts_phone_key UNIQUE (phone),
    CONSTRAINT contacts_user_id_fkey FOREIGN KEY (user_id)
        REFERENCES public.users (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.contacts
    OWNER to postgres;

-- Table: public.reservations

-- DROP TABLE IF EXISTS public.reservations;

CREATE TABLE IF NOT EXISTS public.reservations
(
    reservation_id integer NOT NULL DEFAULT nextval('reservations_reservation_id_seq'::regclass),
    user_id integer NOT NULL,
    table_id integer NOT NULL,
    reservation_date timestamp without time zone NOT NULL,
    duration integer NOT NULL,
    CONSTRAINT reservations_pkey PRIMARY KEY (reservation_id),
    CONSTRAINT reservations_table_id_fkey FOREIGN KEY (table_id)
        REFERENCES public.restaurant_tables (table_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT reservations_user_id_fkey FOREIGN KEY (user_id)
        REFERENCES public.users (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.reservations
    OWNER to postgres;
-- Table: public.restaurant_tables

-- DROP TABLE IF EXISTS public.restaurant_tables;

CREATE TABLE IF NOT EXISTS public.restaurant_tables
(
    table_id integer NOT NULL DEFAULT nextval('restaurant_tables_table_id_seq'::regclass),
    capacity integer NOT NULL,
    restaurant_id integer NOT NULL,
    CONSTRAINT restaurant_tables_pkey PRIMARY KEY (table_id),
    CONSTRAINT restaurant_tables_restaurant_id_fkey FOREIGN KEY (restaurant_id)
        REFERENCES public.restaurants (restaurant_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.restaurant_tables
    OWNER to postgres;

-- Table: public.restaurants

-- DROP TABLE IF EXISTS public.restaurants;

CREATE TABLE IF NOT EXISTS public.restaurants
(
    restaurant_id integer NOT NULL DEFAULT nextval('restaurants_restaurant_id_seq'::regclass),
    name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    table_quantity integer NOT NULL,
    CONSTRAINT restaurants_pkey PRIMARY KEY (restaurant_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.restaurants
    OWNER to postgres;

-- Table: public.users

-- DROP TABLE IF EXISTS public.users;

CREATE TABLE IF NOT EXISTS public.users
(
    user_id integer NOT NULL DEFAULT nextval('users_user_id_seq'::regclass),
    name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT users_pkey PRIMARY KEY (user_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.users
    OWNER to postgres;