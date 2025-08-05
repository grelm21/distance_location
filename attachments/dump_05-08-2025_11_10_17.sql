--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--

DROP DATABASE example;
DROP DATABASE example_development;
DROP DATABASE example_test;




--
-- Drop roles
--

DROP ROLE example;


--
-- Roles
--

CREATE ROLE example;
ALTER ROLE example WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:ya8DvxSamrFp7FymvftM5Q==$OALeG3w8faB24nFoya/4gLogxuTr28BuILwXEEgNPP4=:KiLu+cis69IB0gOMdYfytU7JBR2zONsOl07ZpDCL30I=';

--
-- User Configurations
--








--
-- Databases
--

--
-- Database "template1" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5 (Debian 17.5-1.pgdg120+1)
-- Dumped by pg_dump version 17.5 (Debian 17.5-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
DROP DATABASE template1;
--
-- Name: template1; Type: DATABASE; Schema: -; Owner: example
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE template1 OWNER TO example;

\connect template1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: example
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: example
--

ALTER DATABASE template1 IS_TEMPLATE = true;


\connect template1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: example
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- Database "example" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5 (Debian 17.5-1.pgdg120+1)
-- Dumped by pg_dump version 17.5 (Debian 17.5-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: example; Type: DATABASE; Schema: -; Owner: example
--

CREATE DATABASE example WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE example OWNER TO example;

\connect example

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: example
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- PostgreSQL database dump complete
--

--
-- Database "example_development" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5 (Debian 17.5-1.pgdg120+1)
-- Dumped by pg_dump version 17.5 (Debian 17.5-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: example_development; Type: DATABASE; Schema: -; Owner: example
--

CREATE DATABASE example_development WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE example_development OWNER TO example;

\connect example_development

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: example
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO example;

--
-- Name: locations; Type: TABLE; Schema: public; Owner: example
--

CREATE TABLE public.locations (
    id bigint NOT NULL,
    name character varying,
    kind integer DEFAULT 0,
    lonlat public.geography(Point,4326),
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.locations OWNER TO example;

--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: example
--

CREATE SEQUENCE public.locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.locations_id_seq OWNER TO example;

--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: example
--

ALTER SEQUENCE public.locations_id_seq OWNED BY public.locations.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: example
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO example;

--
-- Name: spatial_table; Type: TABLE; Schema: public; Owner: example
--

CREATE TABLE public.spatial_table (
    id bigint NOT NULL,
    lonlat public.geography(Point,4326)
);


ALTER TABLE public.spatial_table OWNER TO example;

--
-- Name: spatial_table_id_seq; Type: SEQUENCE; Schema: public; Owner: example
--

CREATE SEQUENCE public.spatial_table_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.spatial_table_id_seq OWNER TO example;

--
-- Name: spatial_table_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: example
--

ALTER SEQUENCE public.spatial_table_id_seq OWNED BY public.spatial_table.id;


--
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: example
--

ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_seq'::regclass);


--
-- Name: spatial_table id; Type: DEFAULT; Schema: public; Owner: example
--

ALTER TABLE ONLY public.spatial_table ALTER COLUMN id SET DEFAULT nextval('public.spatial_table_id_seq'::regclass);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: example
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2025-08-05 03:13:22.954394	2025-08-05 03:13:22.954397
\.


--
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: example
--

COPY public.locations (id, name, kind, lonlat, created_at, updated_at) FROM stdin;
19	Россия, Москва	0	0101000020E6100000FD6662BA10CF4240A41CCC26C0E04B40	2025-08-05 07:36:31.533201	2025-08-05 07:36:31.533201
20	Россия, Санкт-Петербург	0	0101000020E61000008F56B5A4A3503E400801F9122AF84D40	2025-08-05 07:36:40.868601	2025-08-05 07:36:40.868601
21	Россия, Самарская область, Тольятти	0	0101000020E610000078F01307D0B54840A69A594B01C14A40	2025-08-05 07:36:47.608572	2025-08-05 07:36:47.608572
22	Россия, Краснодар	0	0101000020E61000008C2E6F0ED77C43409BFEEC478A844640	2025-08-05 07:54:39.573891	2025-08-05 07:54:39.573891
23	Россия, Краснодарский край, Сочи	0	0101000020E6100000C9E6AA798EDC4340A35C1ABFF0CA4540	2025-08-05 07:54:45.022506	2025-08-05 07:54:45.022506
24	Россия, Волгоград	0	0101000020E6100000C0EC9E3C2C424640598AE42B815A4840	2025-08-05 07:54:54.229511	2025-08-05 07:54:54.229511
25	Россия, Ленинградская область, Выборг	0	0101000020E61000008429CAA5F1BF3C402BF86D88F15A4E40	2025-08-05 07:55:00.822387	2025-08-05 07:55:00.822387
26	Россия, Нижний Новгород	0	0101000020E61000004B732B84D500464028B7ED7BD4294C40	2025-08-05 07:55:07.711288	2025-08-05 07:55:07.711288
27	Россия, Вологда	0	0101000020E6100000DF50F86C1DF243401EDE7360399C4D40	2025-08-05 07:55:16.788391	2025-08-05 07:55:16.788391
28	Россия, Архангельская область, Приморский муниципальный округ, посёлок Васьково	0	0101000020E6100000814067D2A63A4440A59F70766B1A5040	2025-08-05 07:55:28.404454	2025-08-05 07:55:28.404454
29	Россия, Хабаровск	0	0101000020E6100000D960E1244DE260409FCBD424783D4840	2025-08-05 07:55:42.920106	2025-08-05 07:55:42.920106
30	Беларусь, Минск	0	0101000020E610000005E10A28D48F3B401FDAC70A7EF34A40	2025-08-05 07:55:54.585806	2025-08-05 07:55:54.585806
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: example
--

COPY public.schema_migrations (version) FROM stdin;
20250802122110
20250802124802
\.


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: example
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- Data for Name: spatial_table; Type: TABLE DATA; Schema: public; Owner: example
--

COPY public.spatial_table (id, lonlat) FROM stdin;
\.


--
-- Name: locations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: example
--

SELECT pg_catalog.setval('public.locations_id_seq', 30, true);


--
-- Name: spatial_table_id_seq; Type: SEQUENCE SET; Schema: public; Owner: example
--

SELECT pg_catalog.setval('public.spatial_table_id_seq', 1, false);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: example
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: example
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: example
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: spatial_table spatial_table_pkey; Type: CONSTRAINT; Schema: public; Owner: example
--

ALTER TABLE ONLY public.spatial_table
    ADD CONSTRAINT spatial_table_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

--
-- Database "example_test" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5 (Debian 17.5-1.pgdg120+1)
-- Dumped by pg_dump version 17.5 (Debian 17.5-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: example_test; Type: DATABASE; Schema: -; Owner: example
--

CREATE DATABASE example_test WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE example_test OWNER TO example;

\connect example_test

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5 (Debian 17.5-1.pgdg120+1)
-- Dumped by pg_dump version 17.5 (Debian 17.5-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: example
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO example;

\connect postgres

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: example
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

