--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO postgres;

--
-- Name: events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.events (
    id integer NOT NULL,
    title character varying(128) NOT NULL,
    description text NOT NULL,
    date date NOT NULL,
    location character varying(128) NOT NULL,
    required_volunteers integer NOT NULL,
    image_filename character varying(128) NOT NULL,
    organizer_id integer NOT NULL
);


ALTER TABLE public.events OWNER TO postgres;

--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.events_id_seq OWNER TO postgres;

--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.events_id_seq OWNED BY public.events.id;


--
-- Name: registrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.registrations (
    id integer NOT NULL,
    event_id integer NOT NULL,
    volunteer_id integer NOT NULL,
    contact_info character varying(128) NOT NULL,
    registration_date timestamp without time zone NOT NULL,
    status character varying(16) NOT NULL
);


ALTER TABLE public.registrations OWNER TO postgres;

--
-- Name: registrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.registrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.registrations_id_seq OWNER TO postgres;

--
-- Name: registrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.registrations_id_seq OWNED BY public.registrations.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying(64) NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(64) NOT NULL,
    password text NOT NULL,
    last_name character varying(64) NOT NULL,
    first_name character varying(64) NOT NULL,
    middle_name character varying(64),
    role_id integer NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: events id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events ALTER COLUMN id SET DEFAULT nextval('public.events_id_seq'::regclass);


--
-- Name: registrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registrations ALTER COLUMN id SET DEFAULT nextval('public.registrations_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alembic_version (version_num) FROM stdin;
add_demo_users
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.events (id, title, description, date, location, required_volunteers, image_filename, organizer_id) FROM stdin;
2	╨Т╨╛╨╗╨╛╨╜╤В╤С╤А╤Б╨║╨╕╨╣ ╤Б╤Г╨▒╨▒╨╛╤В╨╜╨╕╨║	╨Я╨╛╨╝╨╛╤Й╤М ╨▓ ╤Г╨▒╨╛╤А╨║╨╡ ╨┐╨░╤А╨║╨░.	2024-06-10	╨Я╨░╤А╨║ ╨Я╨╛╨▒╨╡╨┤╤Л	15	subbotnik.jpg	1
3	╨С╨╗╨░╨│╨╛╤В╨▓╨╛╤А╨╕╤В╨╡╨╗╤М╨╜╤Л╨╣ ╨╖╨░╨▒╨╡╨│	╨Ю╤А╨│╨░╨╜╨╕╨╖╨░╤Ж╨╕╤П ╨╕ ╨┐╨╛╨┤╨┤╨╡╤А╨╢╨║╨░ ╤Г╤З╨░╤Б╤В╨╜╨╕╨║╨╛╨▓.	2024-06-15	╨ж╨╡╨╜╤В╤А╨░╨╗╤М╨╜╤Л╨╣ ╤Б╤В╨░╨┤╨╕╨╛╨╜	20	run.jpg	1
4	╨Ы╨╡╤В╨╜╨╕╨╣ ╤Д╨╡╤Б╤В╨╕╨▓╨░╨╗╤М	╨а╨░╨▒╨╛╤В╨░ ╨╜╨░ ╤Д╤Г╨┤╨║╨╛╤А╤В╨╡ ╨╕ ╤Б╤Ж╨╡╨╜╨╡.	2024-06-20	╨Я╨╗╨╛╤Й╨░╨┤╤М ╨Ы╨╡╨╜╨╕╨╜╨░	12	festival.jpg	1
5	╨Ф╨╡╨╜╤М ╨┤╨╛╨╜╨╛╤А╨░	╨Я╨╛╨╝╨╛╤Й╤М ╨▓ ╨╛╤А╨│╨░╨╜╨╕╨╖╨░╤Ж╨╕╨╕ ╤Б╨┤╨░╤З╨╕ ╨║╤А╨╛╨▓╨╕.	2024-06-25	╨У╨╛╤А╨╛╨┤╤Б╨║╨░╤П ╨▒╨╛╨╗╤М╨╜╨╕╤Ж╨░ тДЦ1	10	donor.jpg	1
6	╨н╨║╨╛╨╗╨╛╨│╨╕╤З╨╡╤Б╨║╨╕╨╣ ╨║╨▓╨╡╤Б╤В	╨Я╤А╨╛╨▓╨╡╨┤╨╡╨╜╨╕╨╡ ╨║╨▓╨╡╤Б╤В╨░ ╨┤╨╗╤П ╤И╨║╨╛╨╗╤М╨╜╨╕╨║╨╛╨▓.	2024-07-01	╨н╨║╨╛╤Ж╨╡╨╜╤В╤А	8	ecoquest.jpg	1
7	╨Я╨╛╨╝╨╛╤Й╤М ╨┐╤А╨╕╤О╤В╤Г	╨б╨▒╨╛╤А ╨╕ ╨┤╨╛╤Б╤В╨░╨▓╨║╨░ ╨║╨╛╤А╨╝╨░ ╨┤╨╗╤П ╨╢╨╕╨▓╨╛╤В╨╜╤Л╤Е.	2024-07-05	╨Я╤А╨╕╤О╤В "╨Ф╤А╤Г╨╢╨╛╨║"	7	shelter.jpg	1
8	╨Ь╨░╤Б╤В╨╡╤А-╨║╨╗╨░╤Б╤Б ╨┐╨╛ ╤А╨╛╨▒╨╛╤В╨╛╤В╨╡╤Е╨╜╨╕╨║╨╡	╨Я╨╛╨╝╨╛╤Й╤М ╨▓ ╨┐╤А╨╛╨▓╨╡╨┤╨╡╨╜╨╕╨╕ ╨╝╨░╤Б╤В╨╡╤А-╨║╨╗╨░╤Б╤Б╨░ ╨┤╨╗╤П ╨┤╨╡╤В╨╡╨╣.	2024-07-10	╨в╨╡╤Е╨╜╨╛╨┐╨░╤А╨║	5	robot.jpg	1
9	╨Ф╨╡╨╜╤М ╨╛╤В╨║╤А╤Л╤В╤Л╤Е ╨┤╨▓╨╡╤А╨╡╨╣	╨Т╤Б╤В╤А╨╡╤З╨░ ╨│╨╛╤Б╤В╨╡╨╣ ╨╕ ╨╛╤А╨│╨░╨╜╨╕╨╖╨░╤Ж╨╕╤П ╤Н╨║╤Б╨║╤Г╤А╤Б╨╕╨╣.	2024-07-15	╨Ь╤Г╨╖╨╡╨╣ ╨╕╤Б╤В╨╛╤А╨╕╨╕	6	museum.jpg	1
10	╨д╨╡╤Б╤В╨╕╨▓╨░╨╗╤М ╤Г╨╗╨╕╤З╨╜╨╛╨╣ ╨╡╨┤╤Л	╨а╨░╨▒╨╛╤В╨░ ╨╜╨░ ╤В╨╛╤З╨║╨░╤Е ╨┐╨╕╤В╨░╨╜╨╕╤П ╨╕ ╤Г╨▒╨╛╤А╨║╨░ ╤В╨╡╤А╤А╨╕╤В╨╛╤А╨╕╨╕.	2024-07-20	╨У╨╛╤А╨╛╨┤╤Б╨║╨╛╨╣ ╤Б╨║╨▓╨╡╤А	10	foodfest.jpg	1
11	╨в╤Г╤А╨╜╨╕╤А ╨┐╨╛ ╤И╨░╤Е╨╝╨░╤В╨░╨╝	╨б╤Г╨┤╨╡╨╣╤Б╤В╨▓╨╛ ╨╕ ╨┐╨╛╨╝╨╛╤Й╤М ╤Г╤З╨░╤Б╤В╨╜╨╕╨║╨░╨╝.	2024-07-25	╨Ф╨╛╨╝ ╨║╤Г╨╗╤М╤В╤Г╤А╤Л	4	chess.jpg	1
12	╨Ъ╨╕╨╜╨╛╨╜╨╛╤З╤М	╨Ю╤А╨│╨░╨╜╨╕╨╖╨░╤Ж╨╕╤П ╨║╨╕╨╜╨╛╨┐╨╛╨║╨░╨╖╨░ ╨╜╨░ ╨╛╤В╨║╤А╤Л╤В╨╛╨╝ ╨▓╨╛╨╖╨┤╤Г╤Е╨╡.	2024-07-30	╨Я╨░╤А╨║ ╨╕╤Б╨║╤Г╤Б╤Б╤В╨▓	6	cinema.jpg	1
13	╨Ф╨╡╤В╤Б╨║╨╕╨╣ ╨┐╤А╨░╨╖╨┤╨╜╨╕╨║	╨Р╨╜╨╕╨╝╨░╤Ж╨╕╤П ╨╕ ╨┐╤А╨╛╨▓╨╡╨┤╨╡╨╜╨╕╨╡ ╨║╨╛╨╜╨║╤Г╤А╤Б╨╛╨▓.	2024-08-05	╨Ф╨╡╤В╤Б╨║╨╕╨╣ ╤Ж╨╡╨╜╤В╤А	9	kids.jpg	1
14	╨Т╨╡╨╗╨╛╨┐╤А╨╛╨▒╨╡╨│	╨б╨╛╨┐╤А╨╛╨▓╨╛╨╢╨┤╨╡╨╜╨╕╨╡ ╨╕ ╨╛╨▒╨╡╤Б╨┐╨╡╤З╨╡╨╜╨╕╨╡ ╨▒╨╡╨╖╨╛╨┐╨░╤Б╨╜╨╛╤Б╤В╨╕.	2024-08-10	╨б╤В╨░╤А╤В ╤Г ╤Д╨╛╨╜╤В╨░╨╜╨░	12	velo.jpg	1
15	╨п╤А╨╝╨░╤А╨║╨░ ╤А╨╡╨╝╤С╤Б╨╡╨╗	╨Я╨╛╨╝╨╛╤Й╤М ╨╝╨░╤Б╤В╨╡╤А╨░╨╝ ╨╕ ╨╛╤А╨│╨░╨╜╨╕╨╖╨░╤Ж╨╕╤П ╨┐╨╗╨╛╤Й╨░╨┤╨║╨╕.	2024-08-15	╨в╨╛╤А╨│╨╛╨▓╨░╤П ╨┐╨╗╨╛╤Й╨░╨┤╤М	8	craft.jpg	1
16	╨Ю╤Б╨╡╨╜╨╜╨╕╨╣ ╨▒╨░╨╗	╨Ф╨╡╨║╨╛╤А╨╕╤А╨╛╨▓╨░╨╜╨╕╨╡ ╨╖╨░╨╗╨░ ╨╕ ╨▓╤Б╤В╤А╨╡╤З╨░ ╨│╨╛╤Б╤В╨╡╨╣.	2024-09-01	╨У╨╛╤А╨╛╨┤╤Б╨║╨╛╨╣ ╨┤╨▓╨╛╤А╨╡╤Ж ╨║╤Г╨╗╤М╤В╤Г╤А╤Л	10	autumn.jpg	1
17	╨д╨╛╤А╤Г╨╝ ╨╝╨╛╨╗╨╛╨┤╤Л╤Е ╨╗╨╕╨┤╨╡╤А╨╛╨▓	╨Ю╤А╨│╨░╨╜╨╕╨╖╨░╤Ж╨╕╤П ╤Б╨╡╨║╤Ж╨╕╨╣ ╨╕ ╤А╨╡╨│╨╕╤Б╤В╤А╨░╤Ж╨╕╤П ╤Г╤З╨░╤Б╤В╨╜╨╕╨║╨╛╨▓.	2024-09-10	╨Ъ╨╛╨╜╨│╤А╨╡╤Б╤Б-╤Е╨╛╨╗╨╗	15	forum.jpg	1
18	╨Ф╨╡╨╜╤М ╨│╨╛╤А╨╛╨┤╨░	╨а╨░╨▒╨╛╤В╨░ ╨╜╨░ ╨┐╤А╨░╨╖╨┤╨╜╨╕╤З╨╜╤Л╤Е ╨┐╨╗╨╛╤Й╨░╨┤╨║╨░╤Е.	2024-09-15	╨ж╨╡╨╜╤В╤А╨░╨╗╤М╨╜╤Л╨╣ ╨┐╨░╤А╨║	25	cityday.jpg	1
19	╨Ю╤Б╨╡╨╜╨╜╨╕╨╣ ╨▓╨╡╨╗╨╛╤Д╨╡╤Б╤В╨╕╨▓╨░╨╗╤М	╨Я╨╛╨╝╨╛╤Й╤М ╨▓ ╨┐╤А╨╛╨▓╨╡╨┤╨╡╨╜╨╕╨╕ ╨▓╨╡╨╗╨╛╨╖╨░╨╡╨╖╨┤╨░.	2024-09-20	╨Э╨░╨▒╨╡╤А╨╡╨╢╨╜╨░╤П	10	velofest.jpg	1
20	╨в╨╡╨░╤В╤А╨░╨╗╤М╨╜╨░╤П ╨╜╨╛╤З╤М	╨Т╤Б╤В╤А╨╡╤З╨░ ╨│╨╛╤Б╤В╨╡╨╣ ╨╕ ╨┐╨╛╨╝╨╛╤Й╤М ╨░╨║╤В╤С╤А╨░╨╝.	2024-09-25	╨Ф╤А╨░╨╝╤В╨╡╨░╤В╤А	7	theatre.jpg	1
21	╨Ч╨╕╨╝╨╜╨╕╨╣ ╨╝╨░╤А╨░╤Д╨╛╨╜	╨Ю╤А╨│╨░╨╜╨╕╨╖╨░╤Ж╨╕╤П ╨┐╤Г╨╜╨║╤В╨░ ╨┐╨╕╤В╨░╨╜╨╕╤П ╨╕ ╤Б╨╛╨┐╤А╨╛╨▓╨╛╨╢╨┤╨╡╨╜╨╕╨╡.	2024-12-10	╨б╤В╨░╨┤╨╕╨╛╨╜ "╨б╨╜╨╡╨╢╨╕╨╜╨║╨░"	18	marathon.jpg	1
22	╨Э╨╛╨▓╨╛╨│╨╛╨┤╨╜╨╕╨╣ ╨▒╨░╨╗	╨г╨║╤А╨░╤И╨╡╨╜╨╕╨╡ ╨╖╨░╨╗╨░ ╨╕ ╨▓╤Б╤В╤А╨╡╤З╨░ ╨│╨╛╤Б╤В╨╡╨╣.	2024-12-25	╨Ф╨▓╨╛╤А╨╡╤Ж ╨╝╨╛╨╗╨╛╨┤╤С╨╢╨╕	14	newyear.jpg	1
23	╨а╨╛╨╢╨┤╨╡╤Б╤В╨▓╨╡╨╜╤Б╨║╨░╤П ╤П╤А╨╝╨░╤А╨║╨░	╨Я╨╛╨╝╨╛╤Й╤М ╨▓ ╨╛╤А╨│╨░╨╜╨╕╨╖╨░╤Ж╨╕╨╕ ╤В╨╛╤А╨│╨╛╨▓╤Л╤Е ╤В╨╛╤З╨╡╨║.	2025-01-05	╨Я╨╗╨╛╤Й╨░╨┤╤М ╨а╨╡╨▓╨╛╨╗╤О╤Ж╨╕╨╕	11	christmas.jpg	1
24	Platonich party	╨Ы╤Г╤З╤И╨╡╨╡ ╨╝╨╡╤Б╤В╨╛ ╨┤╨╗╤П ╤А╨░╨╖╨▓╨╗╨╡╤З╨╡╨╜╨╕╤П.	2005-02-06	╨Т╨Ф╨Э╨е	25	1.jpg	2
\.


--
-- Data for Name: registrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.registrations (id, event_id, volunteer_id, contact_info, registration_date, status) FROM stdin;
1	23	1	8348488484	2025-06-21 13:35:16.588291	accepted
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, name, description) FROM stdin;
1	admin	╨Р╨┤╨╝╨╕╨╜╨╕╤Б╤В╤А╨░╤В╨╛╤А
2	moderator	╨Ь╨╛╨┤╨╡╤А╨░╤В╨╛╤А
3	user	╨Я╨╛╨╗╤М╨╖╨╛╨▓╨░╤В╨╡╨╗╤М
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, password, last_name, first_name, middle_name, role_id) FROM stdin;
1	testuser	scrypt:32768:8:1$f8eaOxEFe2YxuYHO$3bb1d2c5eba11a20b5790cf32aee173961514fba8a833245a3df785fdc1ce5e4565e62fe1d109cb416564fbfddc850fc15659d30ed7f58184fd201f78a793dbf	╨Ш╨▓╨░╨╜╨╛╨▓	╨Ш╨▓╨░╨╜	╨Ш╨▓╨░╨╜╨╛╨▓╨╕╤З	3
2	adminuser	scrypt:32768:8:1$b3ay6OkAwDQzY3Uo$5b1eae696b3a713804a3095225e075517c328462c6c7982e62440d400dbb1fea66d27b0c0629a7bb97edd2bc01e750cf0a9be20d2f8a9e0863de4ca86a2a5295	╨Р╨┤╨╝╨╕╨╜╨╛╨▓	╨Р╨┤╨╝╨╕╨╜	╨Р╨┤╨╝╨╕╨╜╨╛╨▓╨╕╤З	1
3	moduser	scrypt:32768:8:1$1u0RMUdCDlp1KyI8$a0cd6806beed49ca6bd420c6e38594aa7fad39dbc81c6a7c2d52b87a20db82c74a8aa5f1c5f07e3cabfd64fc55efad034a2eb0d0045690dc5934f6da9cee74a5	╨Ь╨╛╨┤╨╡╤А╨░╤В╨╛╨▓	╨Ь╨╛╨┤╨╡╤А╨░╤В╨╛╤А	╨Ь╨╛╨┤╨╡╤А╨░╤В╨╛╤А╨╛╨▓╨╕╤З	2
\.


--
-- Name: events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.events_id_seq', 24, true);


--
-- Name: registrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.registrations_id_seq', 1, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 3, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: registrations registrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registrations
    ADD CONSTRAINT registrations_pkey PRIMARY KEY (id);


--
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: events events_organizer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_organizer_id_fkey FOREIGN KEY (organizer_id) REFERENCES public.users(id);


--
-- Name: registrations registrations_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registrations
    ADD CONSTRAINT registrations_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.events(id) ON DELETE CASCADE;


--
-- Name: registrations registrations_volunteer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registrations
    ADD CONSTRAINT registrations_volunteer_id_fkey FOREIGN KEY (volunteer_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: users users_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- PostgreSQL database dump complete
--

