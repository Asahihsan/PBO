--
-- PostgreSQL database dump
--

\restrict bTcGLDRYd16ecH8KQb2LNQeer9yctXXlkgBC9hzwAFYICLXQCC3umBjhwuI5Th9

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

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
-- Name: detail_pesanan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detail_pesanan (
    id_detail integer NOT NULL,
    id_pesanan integer,
    id_menu integer,
    jumlah integer,
    subtotal numeric(10,2),
    id_kategori integer
);


ALTER TABLE public.detail_pesanan OWNER TO postgres;

--
-- Name: detail_pesanan_id_detail_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.detail_pesanan ALTER COLUMN id_detail ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.detail_pesanan_id_detail_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: kategori; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kategori (
    id_kategori integer NOT NULL,
    nama_kategori character varying(50) NOT NULL
);


ALTER TABLE public.kategori OWNER TO postgres;

--
-- Name: kategori_id_kategori_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kategori_id_kategori_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.kategori_id_kategori_seq OWNER TO postgres;

--
-- Name: kategori_id_kategori_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kategori_id_kategori_seq OWNED BY public.kategori.id_kategori;


--
-- Name: menu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.menu (
    id_menu integer NOT NULL,
    nama_menu character varying(100),
    harga integer,
    gambar character varying(255),
    id_kategori integer NOT NULL
);


ALTER TABLE public.menu OWNER TO postgres;

--
-- Name: menu_id_menu_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.menu_id_menu_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.menu_id_menu_seq OWNER TO postgres;

--
-- Name: menu_id_menu_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.menu_id_menu_seq OWNED BY public.menu.id_menu;


--
-- Name: pesanan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pesanan (
    id_pesanan integer NOT NULL,
    nama_pelanggan character varying(100),
    total integer,
    tanggal timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    metode_pembayaran character varying(50),
    no_telp character varying(20),
    status character varying(20) DEFAULT 'pending'::character varying,
    id_user integer,
    email_pelanggan character varying(100)
);


ALTER TABLE public.pesanan OWNER TO postgres;

--
-- Name: pesanan_id_pesanan_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pesanan_id_pesanan_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pesanan_id_pesanan_seq OWNER TO postgres;

--
-- Name: pesanan_id_pesanan_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pesanan_id_pesanan_seq OWNED BY public.pesanan.id_pesanan;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id_user integer NOT NULL,
    nama character varying(100) NOT NULL,
    email character varying(100),
    password character varying(255),
    role character varying(20) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT users_role_check CHECK (((role)::text = ANY ((ARRAY['guest'::character varying, 'pelanggan'::character varying, 'kasir'::character varying])::text[])))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_user_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_user_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_user_seq OWNER TO postgres;

--
-- Name: users_id_user_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_user_seq OWNED BY public.users.id_user;


--
-- Name: kategori id_kategori; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategori ALTER COLUMN id_kategori SET DEFAULT nextval('public.kategori_id_kategori_seq'::regclass);


--
-- Name: menu id_menu; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu ALTER COLUMN id_menu SET DEFAULT nextval('public.menu_id_menu_seq'::regclass);


--
-- Name: pesanan id_pesanan; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pesanan ALTER COLUMN id_pesanan SET DEFAULT nextval('public.pesanan_id_pesanan_seq'::regclass);


--
-- Name: users id_user; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id_user SET DEFAULT nextval('public.users_id_user_seq'::regclass);


--
-- Data for Name: detail_pesanan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.detail_pesanan (id_detail, id_pesanan, id_menu, jumlah, subtotal, id_kategori) FROM stdin;
1	1	2	1	32000.00	\N
2	1	1	1	28000.00	\N
3	2	2	1	32000.00	\N
4	2	1	1	28000.00	\N
5	3	3	3	105000.00	\N
6	4	1	1	28000.00	\N
7	4	2	1	32000.00	\N
8	5	3	1	35000.00	\N
9	6	2	1	32000.00	2
10	7	1	1	28000.00	2
11	8	1	1	28000.00	2
12	9	5	1	30000.00	1
13	9	3	1	35000.00	1
14	10	3	1	35000.00	1
15	10	2	1	32000.00	2
\.


--
-- Data for Name: kategori; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kategori (id_kategori, nama_kategori) FROM stdin;
1	Dingin
2	Panas
\.


--
-- Data for Name: menu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.menu (id_menu, nama_menu, harga, gambar, id_kategori) FROM stdin;
1	Autumn Brew	28000	assets/img/Autumn Brew.jpg	1
2	Deep Hazelnut	32000	assets/img/Deep Hazelnut.jpg	1
3	Dual-Tone Macchiato	35000	assets/img/Dual-Tone Macchiato.jpg	1
4	Pure Beige	25000	assets/img/Pure Beige.jpg	1
5	Taupe Coffee	30000	assets/img/Taupe Coffee.jpg	1
6	Vanilla Latte	33000	assets/img/Vanilla Latte.jpg	1
\.


--
-- Data for Name: pesanan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pesanan (id_pesanan, nama_pelanggan, total, tanggal, metode_pembayaran, no_telp, status, id_user, email_pelanggan) FROM stdin;
1	ihsan	60000	2026-01-07 11:12:09.234254	cash	123123	selesai	\N	\N
2	asahi	60000	2026-01-07 11:26:11.369589	gopay	1924719827	selesai	\N	\N
3	asahi	105000	2026-01-08 03:26:40.282043	cash	87654	pending	\N	\N
4	muhammad ihsan	60000	2026-01-08 03:28:00.905552	cash	123123	selesai	2	muhammadihsann687@gmail.com
5	ihsann	35000	2026-01-08 03:34:44.898797	ovo	87654	pending	\N	\N
6	adad	32000	2026-01-08 03:42:50.477774	transfer	123123	pending	\N	\N
7	ihg	28000	2026-01-08 03:44:50.751694	cash	1924719827	pending	\N	\N
8	asahi	28000	2026-01-08 03:45:07.253482	dana	87654	pending	\N	\N
9	ihsan	65000	2026-01-08 03:59:42.972889	transfer	87654	pending	\N	\N
10	ihsan	67000	2026-01-08 03:59:55.458112	dana	123123	pending	\N	\N
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id_user, nama, email, password, role, created_at) FROM stdin;
1	Admin Kasir	kasir@beansbrew.com	kasir123	kasir	2026-01-07 08:46:32.047822
2	muhammad ihsan	muhammadihsann687@gmail.com	asahi103	pelanggan	2026-01-07 09:12:29.261067
\.


--
-- Name: detail_pesanan_id_detail_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.detail_pesanan_id_detail_seq', 15, true);


--
-- Name: kategori_id_kategori_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kategori_id_kategori_seq', 2, true);


--
-- Name: menu_id_menu_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.menu_id_menu_seq', 6, true);


--
-- Name: pesanan_id_pesanan_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pesanan_id_pesanan_seq', 10, true);


--
-- Name: users_id_user_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_user_seq', 2, true);


--
-- Name: detail_pesanan detail_pesanan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detail_pesanan
    ADD CONSTRAINT detail_pesanan_pkey PRIMARY KEY (id_detail);


--
-- Name: kategori kategori_nama_kategori_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategori
    ADD CONSTRAINT kategori_nama_kategori_key UNIQUE (nama_kategori);


--
-- Name: kategori kategori_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategori
    ADD CONSTRAINT kategori_pkey PRIMARY KEY (id_kategori);


--
-- Name: menu menu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu
    ADD CONSTRAINT menu_pkey PRIMARY KEY (id_menu);


--
-- Name: pesanan pesanan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pesanan
    ADD CONSTRAINT pesanan_pkey PRIMARY KEY (id_pesanan);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id_user);


--
-- Name: detail_pesanan detail_pesanan_id_kategori_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detail_pesanan
    ADD CONSTRAINT detail_pesanan_id_kategori_fkey FOREIGN KEY (id_kategori) REFERENCES public.kategori(id_kategori);


--
-- Name: detail_pesanan detail_pesanan_id_menu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detail_pesanan
    ADD CONSTRAINT detail_pesanan_id_menu_fkey FOREIGN KEY (id_menu) REFERENCES public.menu(id_menu);


--
-- Name: detail_pesanan detail_pesanan_id_pesanan_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detail_pesanan
    ADD CONSTRAINT detail_pesanan_id_pesanan_fkey FOREIGN KEY (id_pesanan) REFERENCES public.pesanan(id_pesanan);


--
-- Name: menu fk_menu_kategori; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu
    ADD CONSTRAINT fk_menu_kategori FOREIGN KEY (id_kategori) REFERENCES public.kategori(id_kategori);


--
-- Name: pesanan pesanan_id_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pesanan
    ADD CONSTRAINT pesanan_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.users(id_user);


--
-- PostgreSQL database dump complete
--

\unrestrict bTcGLDRYd16ecH8KQb2LNQeer9yctXXlkgBC9hzwAFYICLXQCC3umBjhwuI5Th9

