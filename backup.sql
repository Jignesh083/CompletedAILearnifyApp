--
-- PostgreSQL database dump
--


-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

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
-- Name: admins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admins (
    id integer NOT NULL,
    email text NOT NULL,
    password text NOT NULL
);


ALTER TABLE public.admins OWNER TO postgres;

--
-- Name: admins_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admins_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admins_id_seq OWNER TO postgres;

--
-- Name: admins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admins_id_seq OWNED BY public.admins.id;


--
-- Name: attempt_responses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attempt_responses (
    id integer NOT NULL,
    attempt_id integer,
    question_id integer,
    selected_option_id integer,
    is_correct boolean,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.attempt_responses OWNER TO postgres;

--
-- Name: attempt_responses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.attempt_responses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.attempt_responses_id_seq OWNER TO postgres;

--
-- Name: attempt_responses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.attempt_responses_id_seq OWNED BY public.attempt_responses.id;


--
-- Name: attempts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attempts (
    id integer NOT NULL,
    user_id integer,
    subject text,
    score integer,
    total integer,
    created_at timestamp without time zone DEFAULT now(),
    topic_id integer,
    quiz_type text,
    started_at timestamp without time zone DEFAULT now(),
    submitted_at timestamp without time zone,
    duration_seconds integer,
    status text DEFAULT 'started'::text,
    CONSTRAINT status_check CHECK ((status = ANY (ARRAY['started'::text, 'submitted'::text, 'timeout'::text])))
);


ALTER TABLE public.attempts OWNER TO postgres;

--
-- Name: attempts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.attempts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.attempts_id_seq OWNER TO postgres;

--
-- Name: attempts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.attempts_id_seq OWNED BY public.attempts.id;


--
-- Name: daily_quiz; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.daily_quiz (
    id integer NOT NULL,
    quiz_date date,
    question_ids integer[]
);


ALTER TABLE public.daily_quiz OWNER TO postgres;

--
-- Name: daily_quiz_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.daily_quiz_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.daily_quiz_id_seq OWNER TO postgres;

--
-- Name: daily_quiz_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.daily_quiz_id_seq OWNED BY public.daily_quiz.id;


--
-- Name: daily_quiz_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.daily_quiz_log (
    id integer NOT NULL,
    topic_id integer,
    quiz_date date NOT NULL,
    subject character varying(50)
);


ALTER TABLE public.daily_quiz_log OWNER TO postgres;

--
-- Name: daily_quiz_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.daily_quiz_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.daily_quiz_log_id_seq OWNER TO postgres;

--
-- Name: daily_quiz_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.daily_quiz_log_id_seq OWNED BY public.daily_quiz_log.id;


--
-- Name: daily_quiz_results; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.daily_quiz_results (
    id integer NOT NULL,
    user_id integer,
    score integer,
    total integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.daily_quiz_results OWNER TO postgres;

--
-- Name: daily_quiz_results_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.daily_quiz_results_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.daily_quiz_results_id_seq OWNER TO postgres;

--
-- Name: daily_quiz_results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.daily_quiz_results_id_seq OWNED BY public.daily_quiz_results.id;


--
-- Name: options; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.options (
    id integer NOT NULL,
    question_id integer,
    option_text text,
    is_correct boolean DEFAULT false
);


ALTER TABLE public.options OWNER TO postgres;

--
-- Name: options_backup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.options_backup (
    id integer,
    question_id integer,
    option_text text
);


ALTER TABLE public.options_backup OWNER TO postgres;

--
-- Name: options_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.options_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.options_id_seq OWNER TO postgres;

--
-- Name: options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.options_id_seq OWNED BY public.options.id;


--
-- Name: purchases; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purchases (
    id integer NOT NULL,
    user_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    payment_id text,
    expiry_date timestamp without time zone NOT NULL,
    topic_id integer,
    email text
);


ALTER TABLE public.purchases OWNER TO postgres;

--
-- Name: purchases_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.purchases_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.purchases_id_seq OWNER TO postgres;

--
-- Name: purchases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.purchases_id_seq OWNED BY public.purchases.id;


--
-- Name: questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.questions (
    id integer NOT NULL,
    topic_id integer,
    question text
);


ALTER TABLE public.questions OWNER TO postgres;

--
-- Name: questions_backup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.questions_backup (
    id integer,
    topic_id integer,
    question text,
    answer integer
);


ALTER TABLE public.questions_backup OWNER TO postgres;

--
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.questions_id_seq OWNER TO postgres;

--
-- Name: questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.questions_id_seq OWNED BY public.questions.id;


--
-- Name: quiz_results; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quiz_results (
    id integer NOT NULL,
    user_id integer,
    topic_key text,
    score integer,
    total integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.quiz_results OWNER TO postgres;

--
-- Name: quiz_results_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quiz_results_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.quiz_results_id_seq OWNER TO postgres;

--
-- Name: quiz_results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quiz_results_id_seq OWNED BY public.quiz_results.id;


--
-- Name: topics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.topics (
    id integer NOT NULL,
    topic_key text,
    bundle_key text,
    title text,
    description text,
    price integer DEFAULT 0,
    thumbnail text,
    sort_order integer DEFAULT 0
);


ALTER TABLE public.topics OWNER TO postgres;

--
-- Name: topics_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.topics_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.topics_id_seq OWNER TO postgres;

--
-- Name: topics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.topics_id_seq OWNED BY public.topics.id;


--
-- Name: user_streaks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_streaks (
    id integer NOT NULL,
    user_id integer,
    last_quiz_date date,
    streak_count integer DEFAULT 1
);


ALTER TABLE public.user_streaks OWNER TO postgres;

--
-- Name: user_streaks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_streaks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_streaks_id_seq OWNER TO postgres;

--
-- Name: user_streaks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_streaks_id_seq OWNED BY public.user_streaks.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name text,
    email text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    password text NOT NULL
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
-- Name: admins id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins ALTER COLUMN id SET DEFAULT nextval('public.admins_id_seq'::regclass);


--
-- Name: attempt_responses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attempt_responses ALTER COLUMN id SET DEFAULT nextval('public.attempt_responses_id_seq'::regclass);


--
-- Name: attempts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attempts ALTER COLUMN id SET DEFAULT nextval('public.attempts_id_seq'::regclass);


--
-- Name: daily_quiz id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.daily_quiz ALTER COLUMN id SET DEFAULT nextval('public.daily_quiz_id_seq'::regclass);


--
-- Name: daily_quiz_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.daily_quiz_log ALTER COLUMN id SET DEFAULT nextval('public.daily_quiz_log_id_seq'::regclass);


--
-- Name: daily_quiz_results id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.daily_quiz_results ALTER COLUMN id SET DEFAULT nextval('public.daily_quiz_results_id_seq'::regclass);


--
-- Name: options id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.options ALTER COLUMN id SET DEFAULT nextval('public.options_id_seq'::regclass);


--
-- Name: purchases id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchases ALTER COLUMN id SET DEFAULT nextval('public.purchases_id_seq'::regclass);


--
-- Name: questions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions ALTER COLUMN id SET DEFAULT nextval('public.questions_id_seq'::regclass);


--
-- Name: quiz_results id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_results ALTER COLUMN id SET DEFAULT nextval('public.quiz_results_id_seq'::regclass);


--
-- Name: topics id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topics ALTER COLUMN id SET DEFAULT nextval('public.topics_id_seq'::regclass);


--
-- Name: user_streaks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_streaks ALTER COLUMN id SET DEFAULT nextval('public.user_streaks_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: admins; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.admins VALUES (1, 'admin@ailearnify.com', '123456');


--
-- Data for Name: attempt_responses; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.attempt_responses VALUES (1, 1, 5111, 20437, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (2, 1, 5117, 20461, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (3, 1, 5104, 20409, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (4, 1, 5112, 20441, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (5, 1, 5121, 20477, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (6, 1, 5116, 20457, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (7, 1, 5110, 20433, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (8, 1, 5119, 20469, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (9, 1, 5102, 20401, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (10, 1, 5120, 20473, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (11, 1, 5118, 20465, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (12, 1, 5108, 20425, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (13, 1, 5103, 20405, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (14, 1, 5109, 20429, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (15, 1, 5113, 20445, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (16, 1, 5115, 20453, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (17, 1, 5107, 20421, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (18, 1, 5106, 20417, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (19, 1, 5114, 20449, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (20, 2, 5115, 20453, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (21, 2, 5119, 20470, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (22, 2, 5112, 20441, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (23, 2, 5110, 20433, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (24, 2, 5102, 20401, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (25, 2, 5111, 20437, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (26, 2, 5116, 20457, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (27, 2, 5113, 20445, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (28, 2, 5105, 20413, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (29, 2, 5109, 20429, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (30, 2, 5121, 20477, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (31, 2, 5106, 20417, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (32, 2, 5103, 20405, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (33, 2, 5117, 20461, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (34, 2, 5118, 20465, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (35, 2, 5114, 20449, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (36, 2, 5108, 20425, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (37, 2, 5107, 20421, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (38, 2, 5120, 20473, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (39, 3, 5839, 23349, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (40, 3, 5582, 22321, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (41, 3, 5883, 23525, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (42, 3, 5801, 23197, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (43, 3, 5890, 23553, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (44, 3, 5734, 22929, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (45, 3, 5810, 23233, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (46, 3, 5769, 23069, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (47, 3, 5583, 22325, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (48, 3, 5541, 22157, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (49, 3, 5931, 23717, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (50, 3, 5916, 23657, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (51, 3, 5817, 23261, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (52, 3, 5570, 22273, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (53, 3, 5683, 22725, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (54, 3, 5829, 23309, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (55, 3, 5322, 21281, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (56, 3, 5711, 22838, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (57, 3, 5431, 21718, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (58, 4, 5104, 20409, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (59, 4, 5116, 20457, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (60, 4, 5121, 20477, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (61, 4, 5120, 20473, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (62, 4, 5102, 20401, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (63, 4, 5103, 20405, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (64, 4, 5115, 20453, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (65, 4, 5113, 20445, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (66, 4, 5107, 20421, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (67, 4, 5112, 20441, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (68, 4, 5106, 20417, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (69, 4, 5111, 20437, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (70, 4, 5108, 20425, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (71, 4, 5110, 20433, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (72, 4, 5109, 20429, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (73, 4, 5118, 20465, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (74, 4, 5105, 20413, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (75, 4, 5119, 20469, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (76, 4, 5114, 20449, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (77, 5, 5107, 20421, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (78, 5, 5114, 20449, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (79, 5, 5110, 20433, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (80, 5, 5104, 20409, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (81, 5, 5108, 20425, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (82, 5, 5105, 20413, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (83, 5, 5119, 20469, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (84, 5, 5116, 20457, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (85, 5, 5113, 20445, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (86, 5, 5106, 20417, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (87, 5, 5118, 20465, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (88, 5, 5117, 20461, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (89, 5, 5102, 20401, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (90, 5, 5103, 20405, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (91, 5, 5121, 20477, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (92, 5, 5109, 20429, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (93, 5, 5111, 20437, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (94, 5, 5120, 20473, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (95, 5, 5115, 20453, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (96, 5, 5112, 20441, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (97, 6, 5110, 20433, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (98, 6, 5118, 20465, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (99, 6, 5104, 20409, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (100, 6, 5117, 20461, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (101, 6, 5102, 20401, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (102, 6, 5115, 20453, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (103, 6, 5103, 20405, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (104, 6, 5114, 20449, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (105, 6, 5108, 20425, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (106, 6, 5107, 20421, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (107, 6, 5116, 20457, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (108, 6, 5121, 20477, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (109, 6, 5119, 20469, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (110, 6, 5105, 20413, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (111, 6, 5111, 20437, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (112, 6, 5112, 20441, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (113, 6, 5113, 20445, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (114, 6, 5109, 20429, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (115, 6, 5120, 20473, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (116, 6, 5106, 20417, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (117, 7, 5110, 20433, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (118, 7, 5118, 20465, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (119, 7, 5104, 20409, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (120, 7, 5117, 20461, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (121, 7, 5102, 20401, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (122, 7, 5115, 20453, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (123, 7, 5103, 20405, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (124, 7, 5114, 20449, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (125, 7, 5108, 20425, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (126, 7, 5107, 20421, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (127, 7, 5116, 20457, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (128, 7, 5121, 20477, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (129, 7, 5119, 20469, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (130, 7, 5105, 20413, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (131, 7, 5111, 20437, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (132, 7, 5112, 20441, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (133, 7, 5113, 20445, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (134, 7, 5109, 20429, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (135, 7, 5120, 20473, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (136, 7, 5106, 20417, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (137, 8, 5117, 20461, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (138, 8, 5109, 20429, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (139, 8, 5114, 20449, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (140, 8, 5106, 20417, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (141, 8, 5105, 20413, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (142, 8, 5110, 20433, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (143, 8, 5108, 20425, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (144, 8, 5121, 20477, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (145, 8, 5119, 20469, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (146, 8, 5104, 20409, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (147, 8, 5111, 20437, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (148, 8, 5116, 20457, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (149, 8, 5103, 20405, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (150, 8, 5102, 20401, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (151, 8, 5120, 20473, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (152, 8, 5107, 20421, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (153, 8, 5113, 20445, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (154, 8, 5115, 20453, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (155, 8, 5112, 20441, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (156, 8, 5118, 20465, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (157, 9, 5117, 20461, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (158, 9, 5109, 20429, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (159, 9, 5114, 20449, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (160, 9, 5106, 20417, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (161, 9, 5105, 20413, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (162, 9, 5110, 20433, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (163, 9, 5108, 20425, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (164, 9, 5121, 20477, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (165, 9, 5119, 20469, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (166, 9, 5104, 20409, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (167, 9, 5111, 20437, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (168, 9, 5116, 20457, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (169, 9, 5103, 20405, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (170, 9, 5102, 20401, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (171, 9, 5120, 20473, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (172, 9, 5107, 20421, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (173, 9, 5113, 20445, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (174, 9, 5115, 20453, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (175, 9, 5112, 20441, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (176, 9, 5118, 20465, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (177, 14, 5102, 20401, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (178, 14, 5108, 20425, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (179, 14, 5104, 20409, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (180, 14, 5117, 20461, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (181, 14, 5119, 20469, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (182, 14, 5114, 20449, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (183, 14, 5110, 20434, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (184, 14, 5111, 20437, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (185, 14, 5118, 20465, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (186, 14, 5103, 20406, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (187, 14, 5105, 20413, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (188, 14, 5116, 20457, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (189, 14, 5115, 20453, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (190, 14, 5112, 20441, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (191, 14, 5107, 20421, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (192, 14, 5109, 20429, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (193, 14, 5106, 20417, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (194, 14, 5120, 20473, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (195, 14, 5113, 20445, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (196, 14, 5121, 20478, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (197, 15, 5102, 20401, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (198, 15, 5108, 20425, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (199, 15, 5104, 20409, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (200, 15, 5117, 20461, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (201, 15, 5119, 20469, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (202, 15, 5114, 20449, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (203, 15, 5110, 20434, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (204, 15, 5111, 20437, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (205, 15, 5118, 20465, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (206, 15, 5103, 20406, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (207, 15, 5105, 20413, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (208, 15, 5116, 20457, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (209, 15, 5115, 20453, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (210, 15, 5112, 20441, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (211, 15, 5107, 20421, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (212, 15, 5109, 20429, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (213, 15, 5106, 20417, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (214, 15, 5120, 20473, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (215, 15, 5113, 20445, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (216, 15, 5121, 20478, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (217, 16, 5102, 20401, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (218, 16, 5108, 20425, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (219, 16, 5104, 20409, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (220, 16, 5117, 20461, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (221, 16, 5119, 20469, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (222, 16, 5114, 20449, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (223, 16, 5110, 20434, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (224, 16, 5111, 20437, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (225, 16, 5118, 20465, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (226, 16, 5103, 20406, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (227, 16, 5105, 20413, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (228, 16, 5116, 20457, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (229, 16, 5115, 20453, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (230, 16, 5112, 20441, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (231, 16, 5107, 20421, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (232, 16, 5109, 20429, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (233, 16, 5106, 20417, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (234, 16, 5120, 20473, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (235, 16, 5113, 20445, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (236, 16, 5121, 20478, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (241, 27, 5112, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (242, 27, 5115, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (243, 27, 5118, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (244, 27, 5109, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (245, 27, 5102, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (246, 27, 5113, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (247, 27, 5120, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (248, 27, 5108, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (249, 27, 5103, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (250, 27, 5110, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (251, 27, 5117, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (252, 27, 5111, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (253, 27, 5116, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (254, 27, 5104, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (255, 27, 5121, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (256, 27, 5106, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (257, 27, 5105, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (258, 27, 5114, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (259, 27, 5119, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (260, 27, 5107, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (261, 28, 5117, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (262, 28, 5115, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (263, 28, 5103, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (264, 28, 5102, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (265, 28, 5111, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (266, 28, 5110, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (267, 28, 5112, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (268, 28, 5109, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (269, 28, 5105, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (270, 28, 5114, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (271, 28, 5116, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (272, 28, 5118, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (273, 28, 5113, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (274, 28, 5107, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (275, 28, 5119, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (276, 28, 5120, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (277, 28, 5121, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (278, 28, 5106, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (279, 28, 5108, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (280, 28, 5104, NULL, NULL, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (281, 36, 5120, 20473, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (282, 36, 5118, 20465, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (283, 36, 5116, 20457, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (284, 36, 5105, 20413, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (285, 36, 5112, 20441, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (286, 36, 5106, 20417, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (287, 36, 5121, 20477, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (288, 36, 5108, 20425, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (289, 36, 5104, 20409, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (290, 36, 5107, 20421, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (291, 36, 5113, 20445, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (292, 36, 5119, 20469, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (293, 36, 5102, 20401, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (294, 36, 5110, 20433, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (295, 36, 5115, 20453, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (296, 36, 5111, 20437, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (297, 36, 5103, 20405, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (298, 36, 5114, 20449, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (299, 36, 5109, 20429, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (300, 36, 5117, 20461, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (301, 37, 5118, 20465, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (302, 37, 5109, 20429, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (303, 37, 5102, 20402, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (304, 37, 5108, 20426, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (305, 37, 5115, 20454, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (306, 37, 5121, 20478, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (307, 37, 5103, 20406, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (308, 37, 5107, 20422, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (309, 37, 5111, 20438, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (310, 37, 5120, 20474, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (311, 37, 5114, 20451, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (312, 37, 5105, 20414, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (313, 37, 5110, 20434, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (314, 37, 5119, 20470, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (315, 37, 5117, 20462, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (316, 37, 5113, 20446, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (317, 37, 5104, 20410, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (318, 37, 5106, 20418, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (319, 37, 5116, 20458, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (320, 37, 5112, 20442, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (322, 43, 5299, 21189, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (323, 43, 5298, 21186, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (324, 43, 5289, 21150, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (325, 43, 5283, 21127, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (326, 43, 5288, 21146, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (327, 43, 5284, 21129, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (328, 43, 5297, 21181, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (329, 43, 5294, 21169, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (330, 43, 5293, 21165, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (331, 43, 5292, 21161, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (332, 43, 5290, 21153, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (333, 43, 5291, 21157, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (334, 43, 5282, 21121, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (335, 43, 5296, 21177, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (336, 43, 5286, 21137, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (337, 43, 5295, 21173, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (338, 43, 5287, 21141, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (339, 43, 5285, 21133, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (340, 43, 5300, 21193, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (341, 43, 5301, 21197, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (342, 47, 5289, 21149, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (343, 47, 5288, 21145, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (344, 47, 5297, 21182, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (345, 47, 5293, 21166, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (346, 47, 5301, 21198, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (347, 47, 5296, 21178, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (348, 47, 5299, 21190, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (349, 47, 5284, 21130, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (350, 47, 5292, 21162, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (351, 47, 5282, 21122, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (352, 47, 5290, 21154, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (353, 47, 5291, 21158, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (354, 47, 5285, 21134, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (355, 47, 5286, 21138, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (356, 47, 5298, 21186, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (357, 47, 5287, 21142, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (358, 47, 5283, 21126, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (359, 47, 5300, 21194, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (360, 47, 5295, 21174, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (361, 47, 5294, 21170, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (362, 70, 5116, 20457, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (363, 70, 5108, 20426, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (364, 70, 5111, 20440, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (365, 70, 5121, 20480, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (366, 70, 5114, 20449, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (367, 70, 5112, 20441, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (368, 70, 5104, 20410, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (369, 70, 5113, 20446, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (370, 70, 5119, 20470, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (371, 70, 5102, 20403, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (372, 70, 5120, 20476, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (373, 70, 5118, 20467, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (374, 70, 5115, 20455, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (375, 70, 5110, 20433, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (376, 70, 5106, 20419, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (377, 70, 5107, 20424, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (378, 70, 5109, 20431, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (379, 70, 5103, 20407, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (380, 70, 5105, 20415, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (381, 70, 5117, 20462, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (382, 87, 5291, 21160, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (383, 87, 5288, 21148, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (384, 87, 5289, 21151, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (385, 87, 5287, 21141, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (386, 87, 5284, 21131, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (387, 87, 5293, 21165, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (388, 87, 5285, 21134, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (389, 87, 5295, 21176, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (390, 87, 5296, 21179, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (391, 87, 5290, 21155, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (392, 87, 5292, 21162, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (393, 87, 5299, 21189, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (394, 87, 5298, 21187, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (395, 87, 5301, 21198, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (396, 87, 5282, 21121, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (397, 87, 5286, 21137, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (398, 87, 5297, 21182, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (399, 87, 5294, 21172, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (400, 87, 5300, 21196, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (401, 87, 5283, 21125, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (402, 91, 5285, 21134, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (403, 91, 5293, 21168, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (404, 91, 5290, 21156, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (405, 91, 5299, 21191, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (406, 91, 5287, 21142, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (407, 91, 5300, 21196, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (408, 91, 5292, 21162, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (409, 91, 5283, 21128, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (410, 91, 5294, 21172, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (411, 91, 5301, 21199, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (412, 91, 5291, 21159, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (413, 91, 5289, 21151, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (414, 91, 5296, 21177, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (415, 91, 5298, 21186, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (416, 91, 5282, 21123, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (417, 91, 5288, 21147, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (418, 91, 5297, 21182, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (419, 91, 5286, 21138, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (420, 91, 5284, 21130, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (421, 91, 5295, 21175, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (422, 95, 5138, 20547, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (423, 95, 5124, 20492, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (424, 95, 5122, 20484, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (425, 95, 5128, 20508, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (426, 95, 5126, 20500, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (427, 95, 5139, 20550, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (428, 95, 5132, 20524, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (429, 95, 5127, 20503, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (430, 95, 5136, 20540, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (431, 95, 5141, 20559, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (432, 95, 5140, 20556, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (433, 95, 5125, 20493, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (434, 95, 5131, 20519, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (435, 95, 5135, 20534, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (436, 95, 5137, 20541, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (437, 95, 5134, 20529, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (438, 95, 5133, 20527, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (439, 95, 5129, 20509, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (440, 95, 5123, 20488, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (441, 95, 5130, 20514, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (442, 96, 5301, 21197, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (443, 96, 5292, 21163, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (444, 96, 5299, 21189, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (445, 96, 5291, 21160, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (446, 96, 5289, 21151, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (447, 96, 5288, 21145, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (448, 96, 5287, 21142, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (449, 96, 5297, 21182, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (450, 96, 5296, 21178, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (451, 96, 5300, 21196, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (452, 96, 5290, 21155, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (453, 96, 5286, 21137, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (454, 96, 5285, 21135, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (455, 96, 5294, 21169, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (456, 96, 5284, 21131, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (457, 96, 5295, 21173, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (458, 96, 5298, 21186, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (459, 96, 5283, 21127, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (460, 96, 5282, 21121, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (461, 96, 5293, 21168, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (462, 98, 5108, 20426, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (463, 98, 5109, 20429, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (464, 98, 5115, 20453, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (465, 98, 5113, 20447, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (466, 98, 5103, 20407, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (467, 98, 5111, 20440, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (468, 98, 5110, 20436, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (469, 98, 5119, 20472, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (470, 98, 5116, 20459, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (471, 98, 5114, 20449, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (472, 98, 5102, 20404, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (473, 98, 5120, 20474, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (474, 98, 5112, 20444, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (475, 98, 5105, 20413, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (476, 98, 5117, 20463, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (477, 98, 5118, 20466, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (478, 98, 5107, 20421, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (479, 98, 5106, 20417, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (480, 98, 5121, 20480, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (481, 98, 5104, 20412, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (482, 99, 5111, 20439, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (483, 99, 5107, 20423, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (484, 99, 5116, 20459, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (485, 99, 5119, 20472, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (486, 99, 5118, 20468, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (487, 99, 5106, 20420, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (488, 99, 5112, 20441, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (489, 99, 5104, 20409, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (490, 99, 5115, 20456, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (491, 99, 5103, 20407, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (492, 99, 5102, 20402, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (493, 99, 5109, 20430, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (494, 99, 5114, 20449, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (495, 99, 5108, 20425, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (496, 99, 5117, 20462, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (497, 99, 5113, 20445, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (498, 99, 5105, 20414, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (499, 99, 5110, 20433, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (500, 99, 5120, 20476, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (501, 99, 5121, 20480, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (502, 100, 5108, 20426, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (503, 100, 5115, 20455, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (504, 100, 5119, 20470, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (505, 100, 5116, 20460, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (506, 100, 5104, 20410, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (507, 100, 5113, 20446, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (508, 100, 5105, 20413, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (509, 100, 5117, 20463, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (510, 100, 5102, 20402, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (511, 100, 5120, 20476, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (512, 100, 5121, 20478, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (513, 100, 5106, 20419, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (514, 100, 5118, 20466, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (515, 100, 5109, 20432, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (516, 100, 5114, 20449, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (517, 100, 5112, 20444, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (518, 100, 5103, 20408, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (519, 100, 5110, 20433, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (520, 100, 5111, 20440, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (521, 100, 5107, 20424, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (522, 104, 5102, 20404, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (523, 104, 5106, 20418, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (524, 104, 5109, 20430, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (525, 104, 5103, 20407, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (526, 104, 5113, 20445, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (527, 104, 5119, 20469, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (528, 104, 5118, 20468, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (529, 104, 5114, 20451, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (530, 104, 5110, 20434, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (531, 104, 5112, 20444, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (532, 104, 5104, 20410, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (533, 104, 5115, 20454, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (534, 104, 5111, 20437, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (535, 104, 5108, 20425, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (536, 104, 5120, 20475, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (537, 104, 5107, 20421, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (538, 104, 5116, 20460, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (539, 104, 5117, 20461, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (540, 104, 5121, 20479, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (541, 104, 5105, 20415, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (542, 106, 5119, 20469, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (543, 106, 5108, 20428, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (544, 106, 5106, 20420, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (545, 106, 5120, 20473, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (546, 106, 5116, 20460, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (547, 106, 5102, 20404, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (548, 106, 5105, 20413, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (549, 106, 5114, 20451, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (550, 106, 5111, 20438, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (551, 106, 5112, 20444, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (552, 106, 5109, 20432, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (553, 106, 5110, 20433, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (554, 106, 5103, 20406, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (555, 106, 5104, 20411, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (556, 106, 5117, 20461, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (557, 106, 5118, 20467, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (558, 106, 5115, 20454, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (559, 106, 5107, 20422, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (560, 106, 5121, 20478, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (561, 106, 5113, 20446, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (562, 107, 5106, 20419, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (563, 107, 5113, 20446, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (564, 107, 5119, 20469, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (565, 107, 5102, 20402, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (566, 107, 5115, 20454, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (567, 107, 5109, 20429, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (568, 107, 5111, 20437, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (569, 107, 5112, 20441, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (570, 107, 5104, 20411, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (571, 107, 5118, 20466, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (572, 107, 5114, 20451, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (573, 107, 5116, 20458, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (574, 107, 5121, 20478, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (575, 107, 5107, 20422, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (576, 107, 5110, 20436, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (577, 107, 5105, 20415, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (578, 107, 5103, 20405, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (579, 107, 5120, 20476, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (580, 107, 5108, 20425, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (581, 107, 5117, 20461, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (582, 109, 5110, 20433, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (583, 109, 5115, 20453, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (584, 109, 5107, 20421, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (585, 109, 5117, 20464, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (586, 109, 5104, 20410, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (587, 109, 5102, 20401, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (588, 109, 5106, 20420, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (589, 109, 5108, 20428, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (590, 109, 5119, 20469, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (591, 109, 5118, 20468, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (592, 109, 5112, 20442, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (593, 109, 5113, 20445, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (594, 109, 5116, 20458, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (595, 109, 5120, 20474, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (596, 109, 5121, 20479, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (597, 109, 5105, 20415, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (598, 109, 5114, 20452, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (599, 109, 5103, 20408, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (600, 109, 5109, 20431, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (601, 109, 5111, 20438, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (602, NULL, 5110, 20434, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (603, NULL, 5113, 20445, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (604, NULL, 5106, 20417, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (605, NULL, 5117, 20461, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (606, NULL, 5107, 20421, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (607, NULL, 5121, 20477, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (608, NULL, 5104, 20410, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (609, NULL, 5105, 20414, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (610, NULL, 5103, 20405, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (611, NULL, 5116, 20458, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (612, NULL, 5120, 20473, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (613, NULL, 5115, 20454, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (614, NULL, 5109, 20430, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (615, NULL, 5114, 20450, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (616, NULL, 5118, 20465, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (617, NULL, 5102, 20402, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (618, NULL, 5108, 20425, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (619, NULL, 5119, 20470, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (620, NULL, 5111, 20437, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (621, NULL, 5112, 20443, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (622, NULL, 5110, 20434, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (623, NULL, 5113, 20445, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (624, NULL, 5106, 20417, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (625, NULL, 5117, 20461, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (626, NULL, 5107, 20421, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (627, NULL, 5121, 20477, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (628, NULL, 5104, 20410, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (629, NULL, 5105, 20414, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (630, NULL, 5103, 20405, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (631, NULL, 5116, 20458, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (632, NULL, 5120, 20473, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (633, NULL, 5115, 20454, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (634, NULL, 5109, 20430, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (635, NULL, 5114, 20450, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (636, NULL, 5118, 20465, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (637, NULL, 5102, 20402, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (638, NULL, 5108, 20425, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (639, NULL, 5119, 20470, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (640, NULL, 5111, 20437, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (641, NULL, 5112, 20443, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (642, 111, 5102, 20404, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (643, 111, 5103, 20406, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (644, 111, 5104, 20412, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (645, 111, 5105, 20416, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (646, 111, 5106, 20417, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (647, 111, 5107, 20423, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (648, 111, 5108, 20425, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (649, 111, 5109, 20430, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (650, 111, 5110, 20435, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (651, 111, 5111, 20437, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (652, 111, 5112, 20443, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (653, 111, 5113, 20445, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (654, 111, 5114, 20450, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (655, 111, 5115, 20453, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (656, 111, 5116, 20458, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (657, 111, 5117, 20462, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (658, 111, 5118, 20467, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (659, 111, 5119, 20470, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (660, 111, 5120, 20476, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (661, 111, 5121, 20480, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (662, 112, 5282, 21122, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (663, 112, 5283, 21125, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (664, 112, 5284, 21130, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (665, 112, 5285, 21134, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (666, 112, 5286, 21138, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (667, 112, 5287, 21143, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (668, 112, 5288, 21148, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (669, 112, 5289, 21150, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (670, 112, 5290, 21155, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (671, 112, 5291, 21157, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (672, 112, 5292, 21163, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (673, 112, 5293, 21166, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (674, 112, 5294, 21170, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (675, 112, 5295, 21175, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (676, 112, 5296, 21178, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (677, 112, 5297, 21183, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (678, 112, 5298, 21187, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (679, 112, 5299, 21191, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (680, 112, 5300, 21194, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (681, 112, 5301, 21199, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (682, 113, 5102, 20402, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (683, 113, 5103, 20407, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (684, 113, 5104, 20412, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (685, 113, 5105, 20415, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (686, 113, 5106, 20418, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (687, 113, 5107, 20423, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (688, 113, 5108, 20428, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (689, 113, 5109, 20432, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (690, 113, 5110, 20436, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (691, 113, 5111, 20437, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (692, 113, 5112, 20442, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (693, 113, 5113, 20446, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (694, 113, 5114, 20450, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (695, 113, 5115, 20455, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (696, 113, 5116, 20459, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (697, 113, 5117, 20463, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (698, 113, 5118, 20465, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (699, 113, 5119, 20470, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (700, 113, 5120, 20475, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (701, 113, 5121, 20477, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (702, 114, 5282, 21123, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (703, 114, 5283, 21125, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (704, 114, 5284, 21129, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (705, 114, 5285, 21134, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (706, 114, 5286, 21137, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (707, 114, 5287, 21143, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (708, 114, 5288, 21146, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (709, 114, 5289, 21150, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (710, 114, 5290, 21153, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (711, 114, 5291, 21160, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (712, 114, 5292, 21161, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (713, 114, 5293, 21165, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (714, 114, 5294, 21169, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (715, 114, 5295, 21173, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (716, 114, 5296, 21179, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (717, 114, 5297, 21181, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (718, 114, 5298, 21188, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (719, 114, 5299, 21189, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (720, 114, 5300, 21196, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (721, 114, 5301, 21200, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (722, 115, 5102, 20404, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (723, 115, 5103, 20405, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (724, 115, 5104, 20412, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (725, 115, 5105, 20413, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (726, 115, 5106, 20417, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (727, 115, 5107, 20422, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (728, 115, 5108, 20425, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (729, 115, 5109, 20429, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (730, 115, 5110, 20436, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (731, 115, 5111, 20439, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (732, 115, 5112, 20441, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (733, 115, 5113, 20445, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (734, 115, 5114, 20452, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (735, 115, 5115, 20455, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (736, 115, 5116, 20458, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (737, 115, 5117, 20464, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (738, 115, 5118, 20465, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (739, 115, 5119, 20472, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (740, 115, 5120, 20475, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (741, 115, 5121, 20478, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (742, 116, 5102, 20403, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (743, 116, 5103, 20407, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (744, 116, 5104, 20410, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (745, 116, 5105, 20416, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (746, 116, 5106, 20417, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (747, 116, 5107, 20424, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (748, 116, 5108, 20427, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (749, 116, 5109, 20429, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (750, 116, 5110, 20436, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (751, 116, 5111, 20440, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (752, 116, 5112, 20444, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (753, 116, 5113, 20447, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (754, 116, 5114, 20450, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (755, 116, 5115, 20453, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (756, 116, 5116, 20458, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (757, 116, 5117, 20464, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (758, 116, 5118, 20468, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (759, 116, 5119, 20470, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (760, 116, 5120, 20473, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (761, 116, 5121, 20478, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (762, 117, 5102, 20404, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (763, 117, 5103, 20405, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (764, 117, 5104, 20412, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (765, 117, 5105, 20416, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (766, 117, 5106, 20420, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (767, 117, 5107, 20421, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (768, 117, 5108, 20425, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (769, 117, 5109, 20429, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (770, 117, 5110, 20434, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (771, 117, 5111, 20439, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (772, 117, 5112, 20444, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (773, 117, 5113, 20446, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (774, 117, 5114, 20452, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (775, 117, 5115, 20453, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (776, 117, 5116, 20460, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (777, 117, 5117, 20461, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (778, 117, 5118, 20467, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (779, 117, 5119, 20471, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (780, 117, 5120, 20474, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (781, 117, 5121, 20477, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (782, NULL, 5109, 20430, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (783, NULL, 5116, 20458, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (784, NULL, 5102, 20402, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (785, NULL, 5103, 20405, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (786, NULL, 5111, 20437, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (787, NULL, 5104, 20410, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (788, NULL, 5108, 20425, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (789, NULL, 5112, 20443, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (790, NULL, 5113, 20445, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (791, NULL, 5106, 20417, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (792, NULL, 5114, 20450, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (793, NULL, 5110, 20434, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (794, NULL, 5117, 20461, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (795, NULL, 5107, 20421, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (796, NULL, 5115, 20454, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (797, NULL, 5119, 20470, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (798, NULL, 5105, 20414, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (799, NULL, 5120, 20473, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (800, NULL, 5121, 20477, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (801, NULL, 5118, 20465, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (802, 119, 5582, 22324, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (803, 119, 5583, 22328, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (804, 119, 5584, 22332, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (805, 119, 5585, 22333, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (806, 119, 5586, 22337, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (807, 119, 5587, 22344, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (808, 119, 5588, 22346, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (809, 119, 5589, 22351, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (810, 119, 5590, 22356, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (811, 119, 5591, 22360, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (812, 119, 5592, 22363, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (813, 119, 5593, 22368, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (814, 119, 5594, 22370, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (815, 119, 5595, 22374, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (816, 119, 5596, 22377, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (817, 119, 5597, 22382, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (818, 119, 5598, 22387, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (819, 119, 5599, 22389, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (820, 119, 5600, 22394, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (821, 119, 5601, 22397, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (822, 120, 5622, 22481, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (823, 120, 5623, 22487, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (824, 120, 5624, 22492, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (825, 120, 5625, 22493, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (826, 120, 5626, 22497, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (827, 120, 5627, 22504, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (828, 120, 5628, 22507, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (829, 120, 5629, 22511, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (830, 120, 5630, 22516, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (831, 120, 5631, 22520, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (832, 120, 5632, 22521, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (833, 120, 5633, 22528, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (834, 120, 5634, 22530, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (835, 120, 5635, 22536, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (836, 120, 5636, 22540, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (837, 120, 5637, 22543, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (838, 120, 5638, 22546, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (839, 120, 5639, 22550, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (840, 120, 5640, 22554, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (841, 120, 5641, 22558, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (842, 121, 5302, 21202, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (843, 121, 5303, 21205, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (844, 121, 5304, 21209, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (845, 121, 5305, 21214, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (846, 121, 5306, 21217, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (847, 121, 5307, 21222, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (848, 121, 5308, 21228, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (849, 121, 5309, 21232, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (850, 121, 5310, 21234, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (851, 121, 5311, 21239, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (852, 121, 5312, 21244, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (853, 121, 5313, 21248, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (854, 121, 5314, 21249, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (855, 121, 5315, 21253, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (856, 121, 5316, 21258, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (857, 121, 5317, 21262, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (858, 121, 5318, 21265, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (859, 121, 5319, 21272, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (860, 121, 5320, 21276, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (861, 121, 5321, 21279, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (862, 122, 5302, 21203, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (863, 122, 5303, 21207, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (864, 122, 5304, 21212, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (865, 122, 5305, 21214, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (866, 122, 5306, 21220, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (867, 122, 5307, 21221, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (868, 122, 5308, 21226, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (869, 122, 5309, 21232, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (870, 122, 5310, 21233, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (871, 122, 5311, 21239, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (872, 122, 5312, 21242, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (873, 122, 5313, 21247, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (874, 122, 5314, 21252, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (875, 122, 5315, 21253, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (876, 122, 5316, 21257, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (877, 122, 5317, 21263, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (878, 122, 5318, 21268, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (879, 122, 5319, 21269, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (880, 122, 5320, 21276, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (881, 122, 5321, 21279, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (882, 123, 5342, 21364, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (883, 123, 5343, 21368, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (884, 123, 5344, 21369, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (885, 123, 5345, 21373, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (886, 123, 5346, 21379, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (887, 123, 5347, 21384, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (888, 123, 5348, 21386, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (889, 123, 5349, 21391, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (890, 123, 5350, 21396, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (891, 123, 5351, 21399, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (892, 123, 5352, 21402, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (893, 123, 5353, 21407, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (894, 123, 5354, 21410, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (895, 123, 5355, 21416, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (896, 123, 5356, 21418, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (897, 123, 5357, 21424, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (898, 123, 5358, 21426, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (899, 123, 5359, 21429, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (900, 123, 5360, 21436, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (901, 123, 5361, 21440, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (902, 124, 5302, 21202, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (903, 124, 5303, 21207, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (904, 124, 5304, 21209, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (905, 124, 5305, 21213, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (906, 124, 5306, 21220, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (907, 124, 5307, 21224, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (908, 124, 5308, 21228, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (909, 124, 5309, 21231, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (910, 124, 5310, 21233, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (911, 124, 5311, 21239, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (912, 124, 5312, 21241, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (913, 124, 5313, 21246, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (914, 124, 5314, 21249, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (915, 124, 5315, 21256, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (916, 124, 5316, 21259, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (917, 124, 5317, 21263, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (918, 124, 5318, 21267, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (919, 124, 5319, 21271, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (920, 124, 5320, 21274, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (921, 124, 5321, 21278, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (922, 125, 5302, 21203, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (923, 125, 5303, 21207, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (924, 125, 5304, 21211, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (925, 125, 5305, 21213, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (926, 125, 5306, 21217, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (927, 125, 5307, 21221, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (928, 125, 5308, 21226, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (929, 125, 5309, 21232, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (930, 125, 5310, 21235, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (931, 125, 5311, 21240, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (932, 125, 5312, 21243, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (933, 125, 5313, 21245, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (934, 125, 5314, 21250, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (935, 125, 5315, 21254, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (936, 125, 5316, 21258, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (937, 125, 5317, 21263, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (938, 125, 5318, 21265, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (939, 125, 5319, 21272, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (940, 125, 5320, 21275, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (941, 125, 5321, 21279, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (942, 126, 5102, 20404, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (943, 126, 5103, 20408, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (944, 126, 5104, 20412, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (945, 126, 5105, 20416, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (946, 126, 5106, 20417, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (947, 126, 5107, 20421, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (948, 126, 5108, 20426, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (949, 126, 5109, 20431, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (950, 126, 5110, 20435, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (951, 126, 5111, 20438, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (952, 126, 5112, 20442, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (953, 126, 5113, 20448, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (954, 126, 5114, 20451, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (955, 126, 5115, 20456, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (956, 126, 5116, 20458, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (957, 126, 5117, 20463, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (958, 126, 5118, 20466, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (959, 126, 5119, 20472, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (960, 126, 5120, 20475, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (961, 126, 5121, 20479, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (962, 128, 5302, 21202, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (963, 128, 5303, 21205, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (964, 128, 5304, 21209, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (965, 128, 5305, 21215, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (966, 128, 5306, 21219, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (967, 128, 5307, 21223, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (968, 128, 5308, 21227, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (969, 128, 5309, 21229, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (970, 128, 5310, 21235, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (971, 128, 5311, 21240, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (972, 128, 5312, 21242, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (973, 128, 5313, 21245, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (974, 128, 5314, 21252, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (975, 128, 5315, 21256, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (976, 128, 5316, 21257, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (977, 128, 5317, 21264, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (978, 128, 5318, 21268, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (979, 128, 5319, 21272, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (980, 128, 5320, 21274, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (981, 128, 5321, 21278, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (982, 129, 5382, 21524, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (983, 129, 5383, 21526, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (984, 129, 5384, 21531, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (985, 129, 5385, 21535, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (986, 129, 5386, 21539, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (987, 129, 5387, 21542, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (988, 129, 5388, 21548, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (989, 129, 5389, 21552, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (990, 129, 5390, 21553, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (991, 129, 5391, 21557, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (992, 129, 5392, 21562, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (993, 129, 5393, 21568, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (994, 129, 5394, 21572, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (995, 129, 5395, 21573, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (996, 129, 5396, 21578, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (997, 129, 5397, 21581, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (998, 129, 5398, 21586, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (999, 129, 5399, 21591, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1000, 129, 5400, 21594, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1001, 129, 5401, 21597, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1002, 130, 5302, 21203, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1003, 130, 5303, 21205, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1004, 130, 5304, 21211, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1005, 130, 5305, 21213, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1006, 130, 5306, 21220, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1007, 130, 5307, 21223, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1008, 130, 5308, 21226, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1009, 130, 5309, 21232, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1010, 130, 5310, 21235, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1011, 130, 5311, 21237, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1012, 130, 5312, 21241, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1013, 130, 5313, 21248, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1014, 130, 5314, 21249, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1015, 130, 5315, 21254, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1016, 130, 5316, 21257, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1017, 130, 5317, 21263, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1018, 130, 5318, 21267, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1019, 130, 5319, 21270, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1020, 130, 5320, 21275, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1021, 130, 5321, 21279, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1022, 131, 5582, 22322, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1023, 131, 5583, 22326, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1024, 131, 5584, 22330, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1025, 131, 5585, 22334, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1026, 131, 5586, 22338, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1027, 131, 5587, 22341, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1028, 131, 5588, 22348, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1029, 131, 5589, 22349, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1030, 131, 5590, 22356, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1031, 131, 5591, 22357, true, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1032, 131, 5592, 22362, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1033, 131, 5593, 22367, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1034, 131, 5594, 22372, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1035, 131, 5595, 22376, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1036, 131, 5596, 22380, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1037, 131, 5597, 22383, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1038, 131, 5598, 22387, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1039, 131, 5599, 22392, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1040, 131, 5600, 22394, false, '2026-03-27 15:17:04.505627');
INSERT INTO public.attempt_responses VALUES (1041, 131, 5601, 22400, false, '2026-03-27 15:17:04.505627');


--
-- Data for Name: attempts; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.attempts VALUES (1, 1, 'dsa', 2, 19, '2026-03-16 12:39:13.017696', NULL, NULL, '2026-03-16 15:02:41.686684', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (2, 1, 'dsa', 2, 19, '2026-03-16 12:39:37.21271', NULL, NULL, '2026-03-16 15:02:41.686684', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (3, 1, 'rl', 16, 19, '2026-03-16 12:39:52.046106', NULL, NULL, '2026-03-16 15:02:41.686684', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (4, 1, 'dsa', 2, 19, '2026-03-16 12:41:49.810411', NULL, NULL, '2026-03-16 15:02:41.686684', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (5, 1, 'dsa', 2, 20, '2026-03-16 12:46:30.296435', NULL, NULL, '2026-03-16 15:02:41.686684', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (6, 1, 'dsa', 2, 20, '2026-03-16 12:47:00.597948', NULL, NULL, '2026-03-16 15:02:41.686684', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (7, 1, 'dsa', 2, 20, '2026-03-16 12:47:00.776693', NULL, NULL, '2026-03-16 15:02:41.686684', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (8, 1, 'dsa', 2, 20, '2026-03-16 12:51:28.103968', NULL, NULL, '2026-03-16 15:02:41.686684', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (9, 1, 'dsa', 2, 20, '2026-03-16 12:51:28.300892', NULL, NULL, '2026-03-16 15:02:41.686684', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (10, 1, 'dsa_intro', 0, 20, '2026-03-16 13:30:20.672', NULL, NULL, '2026-03-16 15:02:41.686684', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (11, 1, 'dsa_intro', 0, 20, '2026-03-16 13:30:20.704464', NULL, NULL, '2026-03-16 15:02:41.686684', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (12, 1, 'dsa_intro', 0, 20, '2026-03-16 13:38:52.473669', NULL, NULL, '2026-03-16 15:02:41.686684', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (13, 1, 'dsa_intro', 0, 20, '2026-03-16 13:43:35.203519', NULL, NULL, '2026-03-16 15:02:41.686684', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (14, 1, 'dsa', 3, 20, '2026-03-16 13:46:18.931131', NULL, NULL, '2026-03-16 15:02:41.686684', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (15, 1, 'dsa', 3, 20, '2026-03-16 13:46:19.028922', NULL, NULL, '2026-03-16 15:02:41.686684', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (16, 1, 'dsa', 3, 20, '2026-03-16 13:46:20.072946', NULL, NULL, '2026-03-16 15:02:41.686684', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (17, 1, NULL, NULL, NULL, '2026-03-16 16:25:34.987456', 2, NULL, '2026-03-16 16:25:34.987456', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (18, 1, NULL, NULL, NULL, '2026-03-16 16:26:11.890903', 2, NULL, '2026-03-16 16:26:11.890903', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (19, 1, NULL, NULL, NULL, '2026-03-16 16:30:19.645808', 2, 'topic', '2026-03-16 16:30:19.645808', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (20, 1, NULL, NULL, NULL, '2026-03-16 16:33:17.433991', 1, 'topic', '2026-03-16 16:33:17.433991', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (21, 1, NULL, NULL, NULL, '2026-03-16 16:40:01.738336', 1, 'topic', '2026-03-16 16:40:01.738336', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (22, 1, NULL, NULL, NULL, '2026-03-16 16:42:46.104658', 1, 'topic', '2026-03-16 16:42:46.104658', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (23, 1, NULL, NULL, NULL, '2026-03-16 16:43:43.433685', 1, 'topic', '2026-03-16 16:43:43.433685', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (24, 1, NULL, NULL, NULL, '2026-03-16 16:48:10.742766', 1, 'topic', '2026-03-16 16:48:10.742766', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (25, 1, NULL, NULL, NULL, '2026-03-16 16:50:58.977476', 1, 'topic', '2026-03-16 16:50:58.977476', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (26, 1, NULL, NULL, NULL, '2026-03-16 16:52:16.492724', 1, 'topic', '2026-03-16 16:52:16.492724', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (27, 1, NULL, 0, NULL, '2026-03-16 16:52:57.426922', 1, 'topic', '2026-03-16 16:52:57.426922', '2026-03-16 16:53:15.670131', 18, 'submitted');
INSERT INTO public.attempts VALUES (28, 1, NULL, 0, NULL, '2026-03-16 16:55:19.418182', 1, 'topic', '2026-03-16 16:55:19.418182', '2026-03-16 17:00:12.253668', 293, 'submitted');
INSERT INTO public.attempts VALUES (29, 1, NULL, NULL, NULL, '2026-03-16 17:18:35.786821', 1, 'topic', '2026-03-16 17:18:35.786821', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (30, 1, NULL, NULL, NULL, '2026-03-16 17:20:29.043865', 1, 'topic', '2026-03-16 17:20:29.043865', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (31, 1, NULL, NULL, NULL, '2026-03-16 17:20:55.101331', 1, 'topic', '2026-03-16 17:20:55.101331', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (32, 1, NULL, NULL, NULL, '2026-03-16 17:30:19.922612', 1, 'topic', '2026-03-16 17:30:19.922612', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (33, 1, NULL, NULL, NULL, '2026-03-16 17:30:37.722691', 1, 'topic', '2026-03-16 17:30:37.722691', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (34, 1, NULL, NULL, NULL, '2026-03-16 17:32:14.6457', 1, 'topic', '2026-03-16 17:32:14.6457', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (35, 1, NULL, NULL, NULL, '2026-03-16 17:32:24.517949', 1, 'topic', '2026-03-16 17:32:24.517949', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (36, 1, NULL, 2, NULL, '2026-03-16 17:35:40.105438', 1, 'topic', '2026-03-16 17:35:40.105438', '2026-03-16 17:36:06.114396', 26, 'submitted');
INSERT INTO public.attempts VALUES (37, 1, NULL, 6, NULL, '2026-03-16 17:37:22.37726', 1, 'topic', '2026-03-16 17:37:22.37726', '2026-03-16 17:37:42.735344', 20, 'submitted');
INSERT INTO public.attempts VALUES (38, 1, NULL, NULL, NULL, '2026-03-16 17:44:55.742158', 1, 'topic', '2026-03-16 17:44:55.742158', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (39, 1, NULL, NULL, NULL, '2026-03-16 17:46:11.997599', 1, 'topic', '2026-03-16 17:46:11.997599', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (40, 1, NULL, NULL, NULL, '2026-03-16 17:49:50.537568', 1, 'topic', '2026-03-16 17:49:50.537568', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (41, 1, NULL, NULL, NULL, '2026-03-16 17:56:53.574947', 1, 'topic', '2026-03-16 17:56:53.574947', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (42, 1, NULL, NULL, NULL, '2026-03-16 17:59:17.361318', 1, 'topic', '2026-03-16 17:59:17.361318', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (43, 1, NULL, 5, NULL, '2026-03-16 17:59:41.82593', 2, 'topic', '2026-03-16 17:59:41.82593', '2026-03-16 18:00:23.075391', 41, 'submitted');
INSERT INTO public.attempts VALUES (44, 1, NULL, NULL, NULL, '2026-03-16 18:00:56.138532', 1, 'topic', '2026-03-16 18:00:56.138532', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (45, 1, NULL, NULL, NULL, '2026-03-16 18:02:11.859891', 1, 'topic', '2026-03-16 18:02:11.859891', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (46, 1, NULL, NULL, NULL, '2026-03-16 18:02:28.41328', 2, 'topic', '2026-03-16 18:02:28.41328', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (47, 1, NULL, 7, NULL, '2026-03-16 18:02:40.265383', 2, 'topic', '2026-03-16 18:02:40.265383', '2026-03-16 18:03:01.821866', 22, 'submitted');
INSERT INTO public.attempts VALUES (48, 1, NULL, NULL, NULL, '2026-03-16 18:04:44.897911', 2, 'topic', '2026-03-16 18:04:44.897911', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (49, 1, NULL, NULL, NULL, '2026-03-16 18:04:49.922696', 1, 'topic', '2026-03-16 18:04:49.922696', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (50, 1, NULL, NULL, NULL, '2026-03-16 18:04:56.668944', 1, 'topic', '2026-03-16 18:04:56.668944', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (51, 1, NULL, NULL, NULL, '2026-03-16 18:05:43.383', 1, 'topic', '2026-03-16 18:05:43.383', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (52, 1, NULL, NULL, NULL, '2026-03-16 18:05:49.637097', 1, 'topic', '2026-03-16 18:05:49.637097', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (53, 1, NULL, NULL, NULL, '2026-03-16 18:05:53.552558', 1, 'topic', '2026-03-16 18:05:53.552558', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (54, 1, NULL, NULL, NULL, '2026-03-16 18:09:33.37279', 1, 'topic', '2026-03-16 18:09:33.37279', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (55, 1, NULL, NULL, NULL, '2026-03-16 18:20:29.097257', 1, 'topic', '2026-03-16 18:20:29.097257', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (56, 1, NULL, NULL, NULL, '2026-03-16 18:21:07.097577', 2, 'topic', '2026-03-16 18:21:07.097577', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (57, 1, NULL, NULL, NULL, '2026-03-16 18:23:42.006865', 2, 'topic', '2026-03-16 18:23:42.006865', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (58, 1, NULL, NULL, NULL, '2026-03-17 11:19:55.376169', 2, 'topic', '2026-03-17 11:19:55.376169', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (59, 1, NULL, NULL, NULL, '2026-03-17 11:26:01.219721', 2, 'topic', '2026-03-17 11:26:01.219721', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (60, 1, NULL, NULL, NULL, '2026-03-17 11:26:34.758078', 1, 'topic', '2026-03-17 11:26:34.758078', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (61, 1, NULL, NULL, NULL, '2026-03-17 11:32:21.409008', 1, 'topic', '2026-03-17 11:32:21.409008', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (62, 1, NULL, NULL, NULL, '2026-03-17 11:32:35.192677', 1, 'topic', '2026-03-17 11:32:35.192677', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (63, 1, NULL, NULL, NULL, '2026-03-17 13:32:04.05558', 1, 'topic', '2026-03-17 13:32:04.05558', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (64, 1, NULL, NULL, NULL, '2026-03-17 13:55:39.200874', 1, 'topic', '2026-03-17 13:55:39.200874', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (65, 1, NULL, NULL, NULL, '2026-03-17 13:55:39.20332', 1, 'topic', '2026-03-17 13:55:39.20332', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (66, 1, NULL, NULL, NULL, '2026-03-17 13:55:52.290152', 1, 'topic', '2026-03-17 13:55:52.290152', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (67, 1, NULL, NULL, NULL, '2026-03-17 13:56:00.362249', 1, 'topic', '2026-03-17 13:56:00.362249', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (68, 1, NULL, NULL, NULL, '2026-03-17 13:56:46.805403', 1, 'topic', '2026-03-17 13:56:46.805403', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (69, 1, NULL, NULL, NULL, '2026-03-17 13:57:07.553568', 1, 'topic', '2026-03-17 13:57:07.553568', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (70, 1, NULL, 5, NULL, '2026-03-17 14:00:43.390893', 1, 'topic', '2026-03-17 14:00:43.390893', '2026-03-17 14:16:01.41802', 918, 'submitted');
INSERT INTO public.attempts VALUES (71, 1, NULL, NULL, NULL, '2026-03-17 14:17:07.788318', 1, 'topic', '2026-03-17 14:17:07.788318', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (72, 1, NULL, NULL, NULL, '2026-03-17 14:17:37.728435', 1, 'topic', '2026-03-17 14:17:37.728435', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (73, 1, NULL, NULL, NULL, '2026-03-17 14:25:21.186216', 1, 'topic', '2026-03-17 14:25:21.186216', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (74, 1, NULL, NULL, NULL, '2026-03-17 14:25:56.104548', 1, 'topic', '2026-03-17 14:25:56.104548', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (75, 1, NULL, NULL, NULL, '2026-03-17 14:27:53.986435', 1, 'topic', '2026-03-17 14:27:53.986435', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (76, 1, NULL, NULL, NULL, '2026-03-17 14:29:08.628715', 1, 'topic', '2026-03-17 14:29:08.628715', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (77, 1, NULL, NULL, NULL, '2026-03-17 14:29:44.07396', 3, 'topic', '2026-03-17 14:29:44.07396', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (78, 1, NULL, NULL, NULL, '2026-03-17 14:30:46.008516', 3, 'topic', '2026-03-17 14:30:46.008516', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (79, 1, NULL, NULL, NULL, '2026-03-17 14:46:18.078532', 3, 'topic', '2026-03-17 14:46:18.078532', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (80, 1, NULL, NULL, NULL, '2026-03-17 14:46:35.161678', 3, 'topic', '2026-03-17 14:46:35.161678', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (81, 1, NULL, NULL, NULL, '2026-03-17 14:48:39.482473', 3, 'topic', '2026-03-17 14:48:39.482473', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (82, 1, NULL, NULL, NULL, '2026-03-17 14:48:57.747416', 81, 'topic', '2026-03-17 14:48:57.747416', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (83, 1, NULL, NULL, NULL, '2026-03-17 14:55:19.930168', 1, 'topic', '2026-03-17 14:55:19.930168', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (84, 1, NULL, NULL, NULL, '2026-03-17 14:57:07.726175', 1, 'topic', '2026-03-17 14:57:07.726175', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (85, 1, NULL, NULL, NULL, '2026-03-17 14:58:31.663057', 1, 'topic', '2026-03-17 14:58:31.663057', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (86, 1, NULL, NULL, NULL, '2026-03-17 15:17:08.153605', 2, 'topic', '2026-03-17 15:17:08.153605', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (87, 1, NULL, 5, NULL, '2026-03-17 15:17:46.981894', 2, 'topic', '2026-03-17 15:17:46.981894', '2026-03-17 15:18:07.883725', 21, 'submitted');
INSERT INTO public.attempts VALUES (88, 1, NULL, NULL, NULL, '2026-03-17 15:19:36.704812', 2, 'topic', '2026-03-17 15:19:36.704812', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (89, 1, NULL, NULL, NULL, '2026-03-17 15:20:37.502198', 2, 'topic', '2026-03-17 15:20:37.502198', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (90, 1, NULL, NULL, NULL, '2026-03-17 15:21:51.839753', 2, 'topic', '2026-03-17 15:21:51.839753', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (91, 1, NULL, 10, NULL, '2026-03-17 15:22:13.717011', 2, 'topic', '2026-03-17 15:22:13.717011', '2026-03-17 15:22:35.648993', 22, 'submitted');
INSERT INTO public.attempts VALUES (92, 1, NULL, NULL, NULL, '2026-03-17 15:23:30.591306', 2, 'topic', '2026-03-17 15:23:30.591306', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (93, 1, NULL, NULL, NULL, '2026-03-17 15:23:38.902098', 2, 'topic', '2026-03-17 15:23:38.902098', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (94, 1, NULL, NULL, NULL, '2026-03-17 15:31:09.326585', 2, 'topic', '2026-03-17 15:31:09.326585', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (95, 1, NULL, 4, NULL, '2026-03-17 15:31:26.483854', 3, 'topic', '2026-03-17 15:31:26.483854', '2026-03-17 15:31:44.633048', 18, 'submitted');
INSERT INTO public.attempts VALUES (96, 1, NULL, 5, NULL, '2026-03-17 15:36:03.694674', 2, 'topic', '2026-03-17 15:36:03.694674', '2026-03-17 15:36:27.693347', 24, 'submitted');
INSERT INTO public.attempts VALUES (97, 1, NULL, NULL, NULL, '2026-03-17 15:47:38.038743', 2, 'topic', '2026-03-17 15:47:38.038743', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (98, 1, NULL, 3, NULL, '2026-03-17 15:48:34.049429', 1, 'topic', '2026-03-17 15:48:34.049429', '2026-03-17 15:48:52.494142', 18, 'submitted');
INSERT INTO public.attempts VALUES (99, 1, NULL, 2, NULL, '2026-03-17 15:53:12.174404', 1, 'topic', '2026-03-17 15:53:12.174404', '2026-03-17 15:53:31.793553', 20, 'submitted');
INSERT INTO public.attempts VALUES (100, 1, NULL, 3, NULL, '2026-03-17 15:58:18.913094', 1, 'topic', '2026-03-17 15:58:18.913094', '2026-03-17 15:58:40.367485', 21, 'submitted');
INSERT INTO public.attempts VALUES (101, 1, NULL, NULL, NULL, '2026-03-17 16:01:27.516995', 1, 'topic', '2026-03-17 16:01:27.516995', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (102, 1, NULL, NULL, NULL, '2026-03-17 16:02:17.193272', 1, 'topic', '2026-03-17 16:02:17.193272', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (103, 1, NULL, NULL, NULL, '2026-03-17 16:03:07.572735', 1, 'topic', '2026-03-17 16:03:07.572735', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (104, 1, NULL, 5, NULL, '2026-03-17 16:03:56.192969', 1, 'topic', '2026-03-17 16:03:56.192969', '2026-03-17 16:04:15.204829', 19, 'submitted');
INSERT INTO public.attempts VALUES (105, 1, NULL, NULL, NULL, '2026-03-17 16:58:00.646056', 1, 'topic', '2026-03-17 16:58:00.646056', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (106, 1, NULL, 5, NULL, '2026-03-17 16:58:25.448272', 1, 'topic', '2026-03-17 16:58:25.448272', '2026-03-17 16:58:50.084071', 25, 'submitted');
INSERT INTO public.attempts VALUES (107, 1, NULL, 7, NULL, '2026-03-17 17:09:58.634973', 1, 'topic', '2026-03-17 17:09:58.634973', '2026-03-17 17:10:17.262668', 19, 'submitted');
INSERT INTO public.attempts VALUES (108, 1, NULL, NULL, NULL, '2026-03-17 17:15:07.826282', 1, 'topic', '2026-03-17 17:15:07.826282', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (109, 1, NULL, 6, NULL, '2026-03-17 17:15:45.170613', 1, 'topic', '2026-03-17 17:15:45.170613', '2026-03-17 17:16:11.928807', 27, 'submitted');
INSERT INTO public.attempts VALUES (110, 5, NULL, NULL, NULL, '2026-03-18 10:48:42.289708', 1, 'topic', '2026-03-18 10:48:42.289708', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (111, 5, NULL, 5, NULL, '2026-03-18 10:49:23.076054', 1, 'topic', '2026-03-18 10:49:23.076054', '2026-03-18 10:49:30.649784', NULL, 'submitted');
INSERT INTO public.attempts VALUES (112, 5, NULL, 2, NULL, '2026-03-18 10:49:36.090823', 2, 'topic', '2026-03-18 10:49:36.090823', '2026-03-18 10:49:46.095124', NULL, 'submitted');
INSERT INTO public.attempts VALUES (113, 5, NULL, 3, NULL, '2026-03-18 10:50:18.119658', 1, 'topic', '2026-03-18 10:50:18.119658', '2026-03-18 10:50:27.432442', NULL, 'submitted');
INSERT INTO public.attempts VALUES (114, 5, NULL, 10, NULL, '2026-03-18 11:02:21.456008', 2, 'topic', '2026-03-18 11:02:21.456008', '2026-03-18 11:02:40.364128', NULL, 'submitted');
INSERT INTO public.attempts VALUES (115, 5, NULL, 8, NULL, '2026-03-18 11:06:21.145446', 1, 'topic', '2026-03-18 11:06:21.145446', '2026-03-18 11:06:27.529294', NULL, 'submitted');
INSERT INTO public.attempts VALUES (116, 5, NULL, 4, NULL, '2026-03-18 11:12:48.084115', 1, 'topic', '2026-03-18 11:12:48.084115', '2026-03-18 11:12:56.070245', NULL, 'submitted');
INSERT INTO public.attempts VALUES (117, 5, NULL, 7, NULL, '2026-03-18 11:34:48.743593', 1, 'topic', '2026-03-18 11:34:48.743593', '2026-03-18 11:35:07.252148', NULL, 'submitted');
INSERT INTO public.attempts VALUES (118, 5, NULL, NULL, NULL, '2026-03-18 11:35:44.781604', 99, 'topic', '2026-03-18 11:35:44.781604', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (119, 5, NULL, 5, NULL, '2026-03-18 11:35:51.518444', 95, 'topic', '2026-03-18 11:35:51.518444', '2026-03-18 11:36:03.614002', NULL, 'submitted');
INSERT INTO public.attempts VALUES (120, 5, NULL, 4, NULL, '2026-03-20 16:07:20.278704', 97, 'topic', '2026-03-20 16:07:20.278704', '2026-03-20 16:08:47.55503', NULL, 'submitted');
INSERT INTO public.attempts VALUES (121, 5, NULL, 6, NULL, '2026-03-21 10:35:04.312186', 81, 'topic', '2026-03-21 10:35:04.312186', '2026-03-21 10:35:17.59546', NULL, 'submitted');
INSERT INTO public.attempts VALUES (122, 5, NULL, 5, NULL, '2026-03-21 11:17:16.580949', 81, 'topic', '2026-03-21 11:17:16.580949', '2026-03-21 11:17:34.297672', NULL, 'submitted');
INSERT INTO public.attempts VALUES (123, 5, NULL, 3, NULL, '2026-03-21 12:21:39.679263', 83, 'topic', '2026-03-21 12:21:39.679263', '2026-03-21 12:21:54.112318', NULL, 'submitted');
INSERT INTO public.attempts VALUES (124, 5, NULL, 5, NULL, '2026-03-21 12:23:57.461214', 81, 'topic', '2026-03-21 12:23:57.461214', '2026-03-21 12:24:15.483945', NULL, 'submitted');
INSERT INTO public.attempts VALUES (125, 7, NULL, 5, NULL, '2026-03-21 14:41:06.929541', 81, 'topic', '2026-03-21 14:41:06.929541', '2026-03-21 14:41:18.199598', NULL, 'submitted');
INSERT INTO public.attempts VALUES (126, 7, NULL, 2, NULL, '2026-03-21 14:41:21.740105', 1, 'topic', '2026-03-21 14:41:21.740105', '2026-03-21 14:41:31.360155', NULL, 'submitted');
INSERT INTO public.attempts VALUES (127, 7, NULL, NULL, NULL, '2026-03-21 14:50:10.934082', 85, 'topic', '2026-03-21 14:50:10.934082', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (128, 7, NULL, 5, NULL, '2026-03-21 14:56:18.953061', 81, 'topic', '2026-03-21 14:56:18.953061', '2026-03-21 14:56:27.715074', NULL, 'submitted');
INSERT INTO public.attempts VALUES (129, 7, NULL, 5, NULL, '2026-03-21 15:10:34.111913', 85, 'topic', '2026-03-21 15:10:34.111913', '2026-03-21 15:10:50.842081', NULL, 'submitted');
INSERT INTO public.attempts VALUES (130, 7, NULL, 6, NULL, '2026-03-21 15:12:26.583059', 81, 'topic', '2026-03-21 15:12:26.583059', '2026-03-21 15:12:47.491205', NULL, 'submitted');
INSERT INTO public.attempts VALUES (131, 5, NULL, 3, NULL, '2026-03-23 10:34:09.50402', 95, 'topic', '2026-03-23 10:34:09.50402', '2026-03-23 10:34:36.849641', NULL, 'submitted');
INSERT INTO public.attempts VALUES (132, 5, NULL, NULL, NULL, '2026-03-23 10:37:03.065927', 95, 'topic', '2026-03-23 10:37:03.065927', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (133, 5, NULL, NULL, NULL, '2026-03-23 10:46:34.055263', 95, 'topic', '2026-03-23 10:46:34.055263', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (134, 8, NULL, NULL, NULL, '2026-03-23 11:43:36.476885', 95, 'topic', '2026-03-23 11:43:36.476885', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (135, 5, NULL, NULL, NULL, '2026-03-23 11:50:51.64435', 95, 'topic', '2026-03-23 11:50:51.64435', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (136, 5, NULL, NULL, NULL, '2026-03-23 11:55:57.985571', 95, 'topic', '2026-03-23 11:55:57.985571', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (137, 5, NULL, NULL, NULL, '2026-03-23 12:04:38.152127', 81, 'topic', '2026-03-23 12:04:38.152127', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (138, 8, NULL, NULL, NULL, '2026-03-23 12:08:57.352387', 95, 'topic', '2026-03-23 12:08:57.352387', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (139, 8, NULL, NULL, NULL, '2026-03-23 12:10:08.362011', 96, 'topic', '2026-03-23 12:10:08.362011', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (140, 8, NULL, NULL, NULL, '2026-03-23 12:57:29.49624', 96, 'topic', '2026-03-23 12:57:29.49624', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (141, 9, NULL, NULL, NULL, '2026-03-23 14:20:04.283836', 96, 'topic', '2026-03-23 14:20:04.283836', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (142, 9, NULL, NULL, NULL, '2026-03-23 14:41:09.867804', 100, 'topic', '2026-03-23 14:41:09.867804', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (143, 9, NULL, NULL, NULL, '2026-03-23 14:44:09.795512', 98, 'topic', '2026-03-23 14:44:09.795512', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (144, 9, NULL, NULL, NULL, '2026-03-23 14:44:42.776799', 98, 'topic', '2026-03-23 14:44:42.776799', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (145, 9, NULL, NULL, NULL, '2026-03-23 15:34:54.541159', 100, 'topic', '2026-03-23 15:34:54.541159', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (146, 9, NULL, NULL, NULL, '2026-03-23 15:45:15.37239', 99, 'topic', '2026-03-23 15:45:15.37239', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (147, 9, NULL, NULL, NULL, '2026-03-23 15:56:59.238355', 97, 'topic', '2026-03-23 15:56:59.238355', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (148, 9, NULL, NULL, NULL, '2026-03-23 16:26:52.248131', 100, 'topic', '2026-03-23 16:26:52.248131', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (149, 9, NULL, NULL, NULL, '2026-03-23 16:47:48.628051', 99, 'topic', '2026-03-23 16:47:48.628051', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (150, 9, NULL, NULL, NULL, '2026-03-23 16:47:55.933149', 97, 'topic', '2026-03-23 16:47:55.933149', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (151, 9, NULL, NULL, NULL, '2026-03-23 16:50:02.833604', 100, 'topic', '2026-03-23 16:50:02.833604', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (152, 9, NULL, NULL, NULL, '2026-03-23 16:55:59.568987', 100, 'topic', '2026-03-23 16:55:59.568987', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (153, 9, NULL, NULL, NULL, '2026-03-23 17:03:04.784208', 99, 'topic', '2026-03-23 17:03:04.784208', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (154, 9, NULL, NULL, NULL, '2026-03-23 17:18:41.488791', 99, 'topic', '2026-03-23 17:18:41.488791', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (155, 9, NULL, NULL, NULL, '2026-03-24 10:26:58.473299', 98, 'topic', '2026-03-24 10:26:58.473299', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (156, 9, NULL, NULL, NULL, '2026-03-24 10:39:33.528438', 99, 'topic', '2026-03-24 10:39:33.528438', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (157, 9, NULL, NULL, NULL, '2026-03-24 10:41:09.467261', 99, 'topic', '2026-03-24 10:41:09.467261', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (158, 9, NULL, NULL, NULL, '2026-03-24 10:59:49.783206', 99, 'topic', '2026-03-24 10:59:49.783206', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (159, 9, NULL, NULL, NULL, '2026-03-24 11:21:48.758768', 99, 'topic', '2026-03-24 11:21:48.758768', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (160, 9, NULL, NULL, NULL, '2026-03-26 12:38:26.359382', 96, 'topic', '2026-03-26 12:38:26.359382', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (161, 9, NULL, NULL, NULL, '2026-03-26 13:32:33.948053', 95, 'topic', '2026-03-26 13:32:33.948053', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (162, 9, NULL, NULL, NULL, '2026-03-26 14:48:45.993801', 98, 'topic', '2026-03-26 14:48:45.993801', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (163, 9, NULL, NULL, NULL, '2026-03-26 14:56:50.259906', 97, 'topic', '2026-03-26 14:56:50.259906', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (164, 8, NULL, NULL, NULL, '2026-03-26 15:39:24.617536', 97, 'topic', '2026-03-26 15:39:24.617536', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (165, 8, NULL, NULL, NULL, '2026-03-27 15:45:08.507799', 1, 'topic', '2026-03-27 15:45:08.507799', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (166, 10, NULL, NULL, NULL, '2026-03-27 15:50:15.655965', 99, 'topic', '2026-03-27 15:50:15.655965', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (167, 10, NULL, NULL, NULL, '2026-03-27 15:51:53.515609', 1, 'topic', '2026-03-27 15:51:53.515609', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (168, 10, NULL, NULL, NULL, '2026-03-27 18:25:59.577585', 98, 'topic', '2026-03-27 18:25:59.577585', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (169, 10, NULL, NULL, NULL, '2026-03-28 10:44:05.970921', 99, 'topic', '2026-03-28 10:44:05.970921', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (170, 10, NULL, NULL, NULL, '2026-03-28 10:57:29.819484', 98, 'topic', '2026-03-28 10:57:29.819484', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (171, 11, NULL, NULL, NULL, '2026-03-28 11:57:52.370046', 99, 'topic', '2026-03-28 11:57:52.370046', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (172, 10, NULL, NULL, NULL, '2026-03-28 13:45:43.959526', 99, 'topic', '2026-03-28 13:45:43.959526', NULL, NULL, 'started');
INSERT INTO public.attempts VALUES (173, 9, NULL, NULL, NULL, '2026-03-28 13:51:42.202353', 99, 'topic', '2026-03-28 13:51:42.202353', NULL, NULL, 'started');


--
-- Data for Name: daily_quiz; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.daily_quiz VALUES (1, '2026-03-13', '{14,607,212,375,121,394,509,27,361,273}');


--
-- Data for Name: daily_quiz_log; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: daily_quiz_results; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.daily_quiz_results VALUES (1, 1, 5, 10, '2026-03-07 17:03:15.737283');
INSERT INTO public.daily_quiz_results VALUES (2, 1, 5, 10, '2026-03-07 17:03:38.974064');
INSERT INTO public.daily_quiz_results VALUES (3, 1, 5, 20, '2026-03-07 17:04:02.775655');
INSERT INTO public.daily_quiz_results VALUES (4, 1, 4, 20, '2026-03-10 10:48:28.714909');
INSERT INTO public.daily_quiz_results VALUES (5, 1, 1, 2, '2026-03-13 14:00:50.922246');
INSERT INTO public.daily_quiz_results VALUES (6, 1, 2, 19, '2026-03-16 11:50:58.120782');
INSERT INTO public.daily_quiz_results VALUES (7, 1, 18, 19, '2026-03-16 11:51:25.564919');
INSERT INTO public.daily_quiz_results VALUES (8, 1, 2, 19, '2026-03-16 11:54:00.736997');
INSERT INTO public.daily_quiz_results VALUES (9, 1, 19, 19, '2026-03-16 12:00:24.001144');
INSERT INTO public.daily_quiz_results VALUES (10, 1, 2, 19, '2026-03-16 12:00:33.480689');
INSERT INTO public.daily_quiz_results VALUES (11, 1, 2, 19, '2026-03-16 12:00:47.784964');
INSERT INTO public.daily_quiz_results VALUES (12, 1, 2, 19, '2026-03-16 12:24:02.278626');
INSERT INTO public.daily_quiz_results VALUES (13, 1, 2, 19, '2026-03-16 12:27:03.176345');
INSERT INTO public.daily_quiz_results VALUES (14, 1, 2, 19, '2026-03-16 12:30:00.325441');
INSERT INTO public.daily_quiz_results VALUES (15, 1, 2, 19, '2026-03-16 12:31:42.653198');
INSERT INTO public.daily_quiz_results VALUES (16, 1, 2, 20, '2026-03-16 15:07:45.375905');
INSERT INTO public.daily_quiz_results VALUES (17, 1, 2, 20, '2026-03-16 15:07:47.389568');
INSERT INTO public.daily_quiz_results VALUES (18, 1, 2, 20, '2026-03-16 15:08:03.381817');
INSERT INTO public.daily_quiz_results VALUES (19, 1, 2, 20, '2026-03-16 15:08:53.538441');
INSERT INTO public.daily_quiz_results VALUES (20, 1, 2, 20, '2026-03-16 15:08:53.887607');
INSERT INTO public.daily_quiz_results VALUES (21, 1, 2, 20, '2026-03-16 15:08:56.198807');
INSERT INTO public.daily_quiz_results VALUES (22, 1, 2, 20, '2026-03-16 15:09:48.104787');
INSERT INTO public.daily_quiz_results VALUES (23, 1, 2, 20, '2026-03-16 15:09:48.239923');
INSERT INTO public.daily_quiz_results VALUES (24, 1, 2, 20, '2026-03-16 15:10:32.514425');
INSERT INTO public.daily_quiz_results VALUES (25, 1, 2, 20, '2026-03-16 15:10:32.5642');
INSERT INTO public.daily_quiz_results VALUES (27, 1, 2, 20, '2026-03-16 15:10:33.120871');
INSERT INTO public.daily_quiz_results VALUES (26, 1, 2, 20, '2026-03-16 15:10:32.84104');
INSERT INTO public.daily_quiz_results VALUES (28, 1, 4, 20, '2026-03-16 15:12:36.450799');
INSERT INTO public.daily_quiz_results VALUES (29, 1, 4, 20, '2026-03-16 15:13:31.33662');
INSERT INTO public.daily_quiz_results VALUES (30, 1, 4, 20, '2026-03-16 15:13:31.480046');
INSERT INTO public.daily_quiz_results VALUES (31, 1, 4, 20, '2026-03-16 15:13:31.690894');
INSERT INTO public.daily_quiz_results VALUES (32, 1, 4, 20, '2026-03-16 15:13:31.973889');
INSERT INTO public.daily_quiz_results VALUES (33, 1, 3, 20, '2026-03-16 15:15:47.545233');
INSERT INTO public.daily_quiz_results VALUES (34, 1, 3, 20, '2026-03-16 15:15:47.598038');
INSERT INTO public.daily_quiz_results VALUES (35, 1, 3, 20, '2026-03-16 15:15:47.616408');
INSERT INTO public.daily_quiz_results VALUES (36, 1, 3, 20, '2026-03-16 15:15:47.625828');
INSERT INTO public.daily_quiz_results VALUES (37, 1, 3, 20, '2026-03-16 15:15:48.287603');


--
-- Data for Name: options; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.options VALUES (20458, 5116, 'Linked List', false);
INSERT INTO public.options VALUES (20459, 5116, 'Stack', false);
INSERT INTO public.options VALUES (20460, 5116, 'Queue', false);
INSERT INTO public.options VALUES (21949, 5489, 'Environment model', true);
INSERT INTO public.options VALUES (21993, 5500, 'Markov Decision Process', true);
INSERT INTO public.options VALUES (22069, 5519, 'Planning problems', true);
INSERT INTO public.options VALUES (22833, 5710, 'Reward + discounted max Q-value of next state', true);
INSERT INTO public.options VALUES (22573, 5645, 'Monte Carlo method', true);
INSERT INTO public.options VALUES (20929, 5234, 'Dynamic', true);
INSERT INTO public.options VALUES (21117, 5281, 'Perfect', true);
INSERT INTO public.options VALUES (21433, 5360, 'Value Function', true);
INSERT INTO public.options VALUES (21361, 5342, 'Future depends only on current state and action', true);
INSERT INTO public.options VALUES (23457, 5866, 'Continuous action spaces', true);
INSERT INTO public.options VALUES (22541, 5637, 'Value estimates stabilize', true);
INSERT INTO public.options VALUES (21245, 5313, 'Discount factor', true);
INSERT INTO public.options VALUES (21145, 5288, 'O(log n)', true);
INSERT INTO public.options VALUES (20613, 5155, 'Pattern matching', true);
INSERT INTO public.options VALUES (22509, 5629, 'Incrementally during episode', true);
INSERT INTO public.options VALUES (23261, 5817, 'Sequential decision tasks', true);
INSERT INTO public.options VALUES (22877, 5721, 'Off-policy TD control algorithm learning optimal Q-values using greedy updates', true);
INSERT INTO public.options VALUES (22369, 5594, 'Online learning', true);
INSERT INTO public.options VALUES (21049, 5264, 'Sorting', true);
INSERT INTO public.options VALUES (22817, 5706, 'Temporal Difference learning', true);
INSERT INTO public.options VALUES (23313, 5830, 'Convolutional Neural Network', true);
INSERT INTO public.options VALUES (23317, 5831, 'Large experience samples', true);
INSERT INTO public.options VALUES (23769, 5944, 'Optimize user engagement', true);
INSERT INTO public.options VALUES (22041, 5512, 'Markov Decision Process', true);
INSERT INTO public.options VALUES (21877, 5471, 'Markov Decision Process', true);
INSERT INTO public.options VALUES (23505, 5878, 'Actor-Critic methods', true);
INSERT INTO public.options VALUES (20697, 5176, 'n', true);
INSERT INTO public.options VALUES (23213, 5805, 'Lambda (λ)', true);
INSERT INTO public.options VALUES (23637, 5911, 'Atari video games', true);
INSERT INTO public.options VALUES (22989, 5749, 'Iteratively', true);
INSERT INTO public.options VALUES (20757, 5191, 'O(n)', true);
INSERT INTO public.options VALUES (22065, 5518, 'Q-Learning', true);
INSERT INTO public.options VALUES (21813, 5455, 'Q-Learning', true);
INSERT INTO public.options VALUES (21025, 5258, 'Front', true);
INSERT INTO public.options VALUES (20625, 5158, 'Length', true);
INSERT INTO public.options VALUES (23221, 5807, 'Speed of learning', true);
INSERT INTO public.options VALUES (23165, 5793, 'Reward + discounted next value', true);
INSERT INTO public.options VALUES (22549, 5639, 'Interaction with environment', true);
INSERT INTO public.options VALUES (20977, 5246, 'Scheduling', true);
INSERT INTO public.options VALUES (21981, 5497, 'Planning problems', true);
INSERT INTO public.options VALUES (22277, 5571, '{"text":"Total discounted reward","is_correct":true}', true);
INSERT INTO public.options VALUES (22269, 5569, '{"text":"Episodic tasks","is_correct":true}', true);
INSERT INTO public.options VALUES (22157, 5541, 'Using environment model to simulate experience and improve policy', true);
INSERT INTO public.options VALUES (23753, 5940, 'Policy quality', true);
INSERT INTO public.options VALUES (22013, 5505, 'Policy evaluation and improvement in one update', true);
INSERT INTO public.options VALUES (21385, 5348, 'Find policy maximizing long-term reward', true);
INSERT INTO public.options VALUES (23481, 5872, 'Expected return', true);
INSERT INTO public.options VALUES (21637, 5411, 'Q-Learning and Dynamic Programming', true);
INSERT INTO public.options VALUES (23809, 5954, 'Resource allocation', true);
INSERT INTO public.options VALUES (22901, 5727, 'V(s) using features', true);
INSERT INTO public.options VALUES (20529, 5134, 'At compile time', true);
INSERT INTO public.options VALUES (23725, 5933, 'Action with highest predicted Q-value', true);
INSERT INTO public.options VALUES (21369, 5344, 'Set of all possible environment states', true);
INSERT INTO public.options VALUES (21365, 5343, 'States', true);
INSERT INTO public.options VALUES (22561, 5642, 'k future rewards', true);
INSERT INTO public.options VALUES (22329, 5584, 'Reward + discounted next state value', true);
INSERT INTO public.options VALUES (21729, 5434, 'Policy Iteration', true);
INSERT INTO public.options VALUES (23713, 5930, 'Experience Replay', true);
INSERT INTO public.options VALUES (20777, 5196, 'Small data', true);
INSERT INTO public.options VALUES (23417, 5856, 'Action value estimate', true);
INSERT INTO public.options VALUES (22193, 5550, 'Remains optimal for remaining steps', true);
INSERT INTO public.options VALUES (21997, 5501, 'Iterative method alternating evaluation and improvement to find optimal policy', true);
INSERT INTO public.options VALUES (20817, 5206, 'Quotient', true);
INSERT INTO public.options VALUES (23037, 5761, 'Iterative optimization method to minimize error by updating parameters', true);
INSERT INTO public.options VALUES (23365, 5843, 'An action with unknown reward distribution', true);
INSERT INTO public.options VALUES (22909, 5729, 'Bias-variance trade-off', true);
INSERT INTO public.options VALUES (20669, 5169, 'O(n)', true);
INSERT INTO public.options VALUES (21865, 5468, 'Fully known and modeled', true);
INSERT INTO public.options VALUES (23077, 5771, 'State value estimate', true);
INSERT INTO public.options VALUES (22757, 5691, 'Optimal or near-optimal policy', true);
INSERT INTO public.options VALUES (23433, 5860, 'Cumulative reward', true);
INSERT INTO public.options VALUES (21029, 5259, 'Deque', true);
INSERT INTO public.options VALUES (22709, 5679, 'Maximum action-value estimate', true);
INSERT INTO public.options VALUES (22353, 5590, 'Environment model', true);
INSERT INTO public.options VALUES (21341, 5337, 'Exploration vs Exploitation', true);
INSERT INTO public.options VALUES (22165, 5543, 'Richard Bellman', true);
INSERT INTO public.options VALUES (22781, 5697, 'It uses next action chosen by policy', true);
INSERT INTO public.options VALUES (20913, 5230, 'Queue', true);
INSERT INTO public.options VALUES (23513, 5880, 'Policy weights', true);
INSERT INTO public.options VALUES (21749, 5439, 'Optimal action-value function', true);
INSERT INTO public.options VALUES (22153, 5540, 'Convergence', true);
INSERT INTO public.options VALUES (21733, 5435, 'Value functions evaluate and improve policies', true);
INSERT INTO public.options VALUES (21689, 5424, 'Maximum expected return from a state', true);
INSERT INTO public.options VALUES (21581, 5397, 'Action-value function', true);
INSERT INTO public.options VALUES (21501, 5377, 'Policy evaluation converges', true);
INSERT INTO public.options VALUES (23265, 5818, 'Reward information backward in time', true);
INSERT INTO public.options VALUES (22025, 5508, 'Environment model', true);
INSERT INTO public.options VALUES (21085, 5273, 'Queries', true);
INSERT INTO public.options VALUES (23521, 5882, 'Policy function and value function', true);
INSERT INTO public.options VALUES (23729, 5934, 'Complex decision environments', true);
INSERT INTO public.options VALUES (21405, 5353, 'Return', true);
INSERT INTO public.options VALUES (22957, 5741, 'Using parameterized models to estimate value or policy functions', true);
INSERT INTO public.options VALUES (21905, 5478, 'Expensive for large state spaces', true);
INSERT INTO public.options VALUES (21237, 5311, 'State transition mechanism', true);
INSERT INTO public.options VALUES (23617, 5906, 'Stabilize training', true);
INSERT INTO public.options VALUES (23013, 5755, 'Improving prediction accuracy', true);
INSERT INTO public.options VALUES (23001, 5752, 'Slow convergence', true);
INSERT INTO public.options VALUES (21541, 5387, 'Q-Learning', true);
INSERT INTO public.options VALUES (23633, 5910, 'Reward plus discounted max future Q-value', true);
INSERT INTO public.options VALUES (21929, 5484, 'Value function for the current policy', true);
INSERT INTO public.options VALUES (21037, 5261, 'Order', true);
INSERT INTO public.options VALUES (23097, 5776, 'Must wait till episode ends', true);
INSERT INTO public.options VALUES (23081, 5772, 'Unbiased but high variance', true);
INSERT INTO public.options VALUES (22881, 5722, 'Handle large or continuous state spaces', true);
INSERT INTO public.options VALUES (22925, 5733, 'Linear function approximation', true);
INSERT INTO public.options VALUES (22397, 5601, 'One-step TD method updating value using immediate reward and next estimate', true);
INSERT INTO public.options VALUES (21669, 5419, 'Recursive decomposition', true);
INSERT INTO public.options VALUES (23309, 5829, 'Robotics and autonomous driving', true);
INSERT INTO public.options VALUES (20665, 5168, 'Sequential search', true);
INSERT INTO public.options VALUES (22521, 5632, 'Monte Carlo methods', true);
INSERT INTO public.options VALUES (21857, 5466, 'Iterative updates', true);
INSERT INTO public.options VALUES (21113, 5280, 'Boundary input', true);
INSERT INTO public.options VALUES (21005, 5253, 'Last element', true);
INSERT INTO public.options VALUES (22997, 5751, 'Divergence', true);
INSERT INTO public.options VALUES (21713, 5430, 'Optimal policy selection', true);
INSERT INTO public.options VALUES (21393, 5350, 'P(s'' | s,a)', true);
INSERT INTO public.options VALUES (22633, 5660, 'They update during learning process', true);
INSERT INTO public.options VALUES (20430, 5109, 'Queue', false);
INSERT INTO public.options VALUES (20431, 5109, 'Tree', false);
INSERT INTO public.options VALUES (20432, 5109, 'Graph', false);
INSERT INTO public.options VALUES (20434, 5110, 'Stack', false);
INSERT INTO public.options VALUES (22181, 5547, 'Breaking complex problems into smaller parts', true);
INSERT INTO public.options VALUES (20821, 5207, '3', true);
INSERT INTO public.options VALUES (23501, 5877, 'Markov Decision Process', true);
INSERT INTO public.options VALUES (23113, 5780, 'Sampling experience', true);
INSERT INTO public.options VALUES (23721, 5932, 'Value function bias', true);
INSERT INTO public.options VALUES (23285, 5823, 'High-dimensional state spaces', true);
INSERT INTO public.options VALUES (21525, 5383, 'Q(s,a)', true);
INSERT INTO public.options VALUES (20597, 5151, 'O(1)', true);
INSERT INTO public.options VALUES (21745, 5438, 'Value Iteration', true);
INSERT INTO public.options VALUES (21445, 5363, 'V(s)', true);
INSERT INTO public.options VALUES (21801, 5452, 'Best possible action from that state', true);
INSERT INTO public.options VALUES (21685, 5423, 'π*', true);
INSERT INTO public.options VALUES (21609, 5404, 'Richard Bellman', true);
INSERT INTO public.options VALUES (23785, 5948, 'Learning control policies through interaction', true);
INSERT INTO public.options VALUES (21013, 5255, 'Allowed', true);
INSERT INTO public.options VALUES (22473, 5620, 'Bootstrapped estimate', true);
INSERT INTO public.options VALUES (20557, 5141, 'Frequent insertions', true);
INSERT INTO public.options VALUES (23053, 5765, 'Actual cumulative return', true);
INSERT INTO public.options VALUES (22441, 5612, 'Magnitude of update', true);
INSERT INTO public.options VALUES (21677, 5421, 'Recursive method to compute value functions', true);
INSERT INTO public.options VALUES (23017, 5756, 'Momentum', true);
INSERT INTO public.options VALUES (20525, 5133, 'Array', true);
INSERT INTO public.options VALUES (23701, 5927, 'Stability of learning', true);
INSERT INTO public.options VALUES (21489, 5374, 'Each state', true);
INSERT INTO public.options VALUES (22857, 5716, 'It uses greedy optimal action in update', true);
INSERT INTO public.options VALUES (23749, 5939, 'Bootstrapping', true);
INSERT INTO public.options VALUES (22409, 5604, 'No bootstrapping', true);
INSERT INTO public.options VALUES (22325, 5583, 'Immediate next state', true);
INSERT INTO public.options VALUES (21941, 5487, 'Policy becomes stable', true);
INSERT INTO public.options VALUES (20933, 5235, 'Fixed', true);
INSERT INTO public.options VALUES (22869, 5719, 'Update uses max future Q-value', true);
INSERT INTO public.options VALUES (23337, 5836, 'Optimal policy', true);
INSERT INTO public.options VALUES (23069, 5769, 'Gradient descent', true);
INSERT INTO public.options VALUES (22569, 5644, 'TD(0)', true);
INSERT INTO public.options VALUES (22401, 5602, 'Full return of an episode', true);
INSERT INTO public.options VALUES (21397, 5351, 'Discount factor', true);
INSERT INTO public.options VALUES (20917, 5231, 'Insert', true);
INSERT INTO public.options VALUES (21965, 5493, 'Convergence to optimal policy', true);
INSERT INTO public.options VALUES (21481, 5372, 'Dynamic Programming', true);
INSERT INTO public.options VALUES (21461, 5367, 'Evaluating long-term rewards', true);
INSERT INTO public.options VALUES (20445, 5113, 'Array', true);
INSERT INTO public.options VALUES (23129, 5784, 'Difference between predicted and target value', true);
INSERT INTO public.options VALUES (21649, 5414, 'Discount factor', true);
INSERT INTO public.options VALUES (23237, 5811, 'Credit assignment problem', true);
INSERT INTO public.options VALUES (22497, 5626, 'Eligibility traces', true);
INSERT INTO public.options VALUES (23621, 5907, 'Mean Squared Error', true);
INSERT INTO public.options VALUES (22429, 5609, 'Episodic tasks', true);
INSERT INTO public.options VALUES (23301, 5827, 'Tabular methods', true);
INSERT INTO public.options VALUES (21837, 5461, 'Recursive equations to compute optimal value functions and policies', true);
INSERT INTO public.options VALUES (21797, 5451, 'Principle of Optimality', true);
INSERT INTO public.options VALUES (22885, 5723, 'Parameterized function', true);
INSERT INTO public.options VALUES (21869, 5469, 'Policy evaluation and improvement', true);
INSERT INTO public.options VALUES (22417, 5606, 'State-value function', true);
INSERT INTO public.options VALUES (21061, 5267, 'Stack', true);
INSERT INTO public.options VALUES (20501, 5127, 'Access', true);
INSERT INTO public.options VALUES (23765, 5943, 'Game AI', true);
INSERT INTO public.options VALUES (21737, 5436, 'Bellman Optimality Principle', true);
INSERT INTO public.options VALUES (23493, 5875, 'High variance', true);
INSERT INTO public.options VALUES (23469, 5869, 'Stochastic policies', true);
INSERT INTO public.options VALUES (21937, 5486, 'Evaluation and improvement', true);
INSERT INTO public.options VALUES (21465, 5368, 'Value Function', true);
INSERT INTO public.options VALUES (22993, 5750, 'Learning rate', true);
INSERT INTO public.options VALUES (21985, 5498, 'State-value function', true);
INSERT INTO public.options VALUES (22501, 5627, 'Updating multiple past states', true);
INSERT INTO public.options VALUES (22393, 5600, 'Faster convergence than Monte Carlo in many cases', true);
INSERT INTO public.options VALUES (21725, 5433, 'Value Iteration', true);
INSERT INTO public.options VALUES (22761, 5692, 'Markov Decision Process', true);
INSERT INTO public.options VALUES (21241, 5312, 'Episode', true);
INSERT INTO public.options VALUES (20905, 5228, 'Pop empty', true);
INSERT INTO public.options VALUES (23329, 5834, 'Stabilize learning', true);
INSERT INTO public.options VALUES (22605, 5653, 'Importance of future rewards', true);
INSERT INTO public.options VALUES (21781, 5447, 'Q-Learning and Value Iteration', true);
INSERT INTO public.options VALUES (20941, 5237, 'Array', true);
INSERT INTO public.options VALUES (21881, 5472, 'Exact solutions for optimal policies', true);
INSERT INTO public.options VALUES (20925, 5233, 'Recursion', true);
INSERT INTO public.options VALUES (22469, 5619, 'Monte Carlo evaluation', true);
INSERT INTO public.options VALUES (21417, 5356, 'Sequential decision problems', true);
INSERT INTO public.options VALUES (22601, 5652, 'Experience from environment', true);
INSERT INTO public.options VALUES (21045, 5263, 'Queue', true);
INSERT INTO public.options VALUES (21573, 5395, 'Q-Learning', true);
INSERT INTO public.options VALUES (23577, 5896, 'Policy gradient', true);
INSERT INTO public.options VALUES (22985, 5748, 'Deep Reinforcement Learning', true);
INSERT INTO public.options VALUES (20785, 5198, 'Merge', true);
INSERT INTO public.options VALUES (23801, 5952, 'Decision making and navigation', true);
INSERT INTO public.options VALUES (23009, 5754, 'All training samples', true);
INSERT INTO public.options VALUES (23389, 5849, 'Chosen action', true);
INSERT INTO public.options VALUES (20461, 5117, 'Java', true);
INSERT INTO public.options VALUES (20921, 5232, 'Linear DS', true);
INSERT INTO public.options VALUES (21345, 5338, 'Learning Rule', true);
INSERT INTO public.options VALUES (21913, 5480, 'Bellman expectation update', true);
INSERT INTO public.options VALUES (22921, 5732, 'Tabular methods fail in large spaces', true);
INSERT INTO public.options VALUES (23045, 5763, 'Policy evaluation with function approximation', true);
INSERT INTO public.options VALUES (22149, 5539, 'State transitions and rewards', true);
INSERT INTO public.options VALUES (21389, 5349, 'Policy', true);
INSERT INTO public.options VALUES (22865, 5718, 'Optimal control problems', true);
INSERT INTO public.options VALUES (22653, 5665, 'Q-Learning', true);
INSERT INTO public.options VALUES (22629, 5659, 'Future rewards and estimated value', true);
INSERT INTO public.options VALUES (20829, 5209, '0', true);
INSERT INTO public.options VALUES (22073, 5520, 'Greedy selection over actions', true);
INSERT INTO public.options VALUES (22685, 5673, 'Importance sampling', true);
INSERT INTO public.options VALUES (21285, 5323, 'The external system interacting with the agent', true);
INSERT INTO public.options VALUES (23169, 5794, 'Learning rate', true);
INSERT INTO public.options VALUES (22721, 5682, 'State-Action-Reward-State-Action', true);
INSERT INTO public.options VALUES (22741, 5687, 'ε-greedy strategy', true);
INSERT INTO public.options VALUES (21505, 5378, 'Future benefit of a state', true);
INSERT INTO public.options VALUES (21185, 5298, 'Unsorted array', true);
INSERT INTO public.options VALUES (23193, 5800, 'Markov Decision Process', true);
INSERT INTO public.options VALUES (23117, 5781, 'Updating approximator parameters using full episode returns', true);
INSERT INTO public.options VALUES (23205, 5803, 'Temporary memory of visited states', true);
INSERT INTO public.options VALUES (21597, 5401, 'It estimates expected future reward for actions in states', true);
INSERT INTO public.options VALUES (21301, 5327, 'Strategy mapping states to actions', true);
INSERT INTO public.options VALUES (22021, 5507, 'Value estimates converge', true);
INSERT INTO public.options VALUES (23781, 5947, 'Treatment planning', true);
INSERT INTO public.options VALUES (22969, 5744, 'Step size of parameter update', true);
INSERT INTO public.options VALUES (21741, 5437, 'Highest cumulative reward', true);
INSERT INTO public.options VALUES (20753, 5190, 'O(n)', true);
INSERT INTO public.options VALUES (23669, 5919, 'Discrete action spaces', true);
INSERT INTO public.options VALUES (21613, 5405, 'Immediate reward + discounted future value', true);
INSERT INTO public.options VALUES (23089, 5774, 'Markov Decision Process', true);
INSERT INTO public.options VALUES (22253, 5565, '{"text":"Model-free learning","is_correct":true}', true);
INSERT INTO public.options VALUES (20989, 5249, 'Linear DS', true);
INSERT INTO public.options VALUES (23161, 5792, 'Incremental', true);
INSERT INTO public.options VALUES (22537, 5636, 'Propagating reward information faster', true);
INSERT INTO public.options VALUES (22301, 5577, '{"text":"Number of episodes increases","is_correct":true}', true);
INSERT INTO public.options VALUES (22101, 5527, 'Bellman updates', true);
INSERT INTO public.options VALUES (21845, 5463, 'Solving Markov Decision Processes', true);
INSERT INTO public.options VALUES (20837, 5211, '+', true);
INSERT INTO public.options VALUES (21757, 5441, 'Agent selects actions maximizing long-term reward', true);
INSERT INTO public.options VALUES (21177, 5296, 'O(1)', true);
INSERT INTO public.options VALUES (21161, 5292, 'O(1)', true);
INSERT INTO public.options VALUES (20457, 5116, 'Array', true);
INSERT INTO public.options VALUES (22593, 5650, 'Markov Decision Process', true);
INSERT INTO public.options VALUES (22457, 5616, 'Higher variance', true);
INSERT INTO public.options VALUES (22613, 5655, 'Balancing learning speed and accuracy', true);
INSERT INTO public.options VALUES (20725, 5183, 'Merge', true);
INSERT INTO public.options VALUES (21253, 5315, 'Exploration', true);
INSERT INTO public.options VALUES (22589, 5649, 'Sequential decision problems', true);
INSERT INTO public.options VALUES (23665, 5918, 'Periodically', true);
INSERT INTO public.options VALUES (23177, 5796, 'Using current estimate to update itself', true);
INSERT INTO public.options VALUES (21893, 5475, 'Known', true);
INSERT INTO public.options VALUES (21349, 5339, 'Policy', true);
INSERT INTO public.options VALUES (23125, 5783, 'TD error', true);
INSERT INTO public.options VALUES (21585, 5398, 'Evaluate consequences of actions', true);
INSERT INTO public.options VALUES (20617, 5156, 'American Standard Code', true);
INSERT INTO public.options VALUES (20729, 5184, 'O(n)', true);
INSERT INTO public.options VALUES (20553, 5140, 'Heap', true);
INSERT INTO public.options VALUES (22917, 5731, 'Generalize learning across states', true);
INSERT INTO public.options VALUES (22317, 5581, '{"text":"Learning value functions by averaging returns from complete episodes","is_correct":true}', true);
INSERT INTO public.options VALUES (22841, 5712, 'Interaction with environment', true);
INSERT INTO public.options VALUES (22257, 5566, '{"text":"State-value function","is_correct":true}', true);
INSERT INTO public.options VALUES (20825, 5208, '0', true);
INSERT INTO public.options VALUES (23281, 5822, 'Deep Neural Networks', true);
INSERT INTO public.options VALUES (23217, 5806, 'Monte Carlo and TD learning', true);
INSERT INTO public.options VALUES (20621, 5157, 'English', true);
INSERT INTO public.options VALUES (22381, 5597, 'Bellman expectation equation', true);
INSERT INTO public.options VALUES (21297, 5326, 'Reward Signal', true);
INSERT INTO public.options VALUES (21189, 5299, 'O(n)', true);
INSERT INTO public.options VALUES (22669, 5669, 'Target policy', true);
INSERT INTO public.options VALUES (20601, 5152, 'String', true);
INSERT INTO public.options VALUES (22489, 5624, 'TD(0)', true);
INSERT INTO public.options VALUES (23377, 5846, 'Trying less-selected actions', true);
INSERT INTO public.options VALUES (21921, 5482, 'Optimal policy in an MDP', true);
INSERT INTO public.options VALUES (21629, 5409, 'Policy distribution over actions', true);
INSERT INTO public.options VALUES (21001, 5252, 'First element', true);
INSERT INTO public.options VALUES (20573, 5145, 'Concatenation', true);
INSERT INTO public.options VALUES (23025, 5758, 'Gradient of loss', true);
INSERT INTO public.options VALUES (22645, 5663, 'Learning about one policy while following another', true);
INSERT INTO public.options VALUES (20485, 5123, 'Random memory', true);
INSERT INTO public.options VALUES (20801, 5202, 'Divisible by 1 & itself', true);
INSERT INTO public.options VALUES (20769, 5194, 'Stack', true);
INSERT INTO public.options VALUES (22017, 5506, 'Max operator', true);
INSERT INTO public.options VALUES (21493, 5375, 'Choose better policies', true);
INSERT INTO public.options VALUES (23269, 5819, 'Bootstrapping', true);
INSERT INTO public.options VALUES (22557, 5641, 'Method combining multi-step returns using eligibility traces', true);
INSERT INTO public.options VALUES (23797, 5951, 'Ad placement optimization', true);
INSERT INTO public.options VALUES (23661, 5917, 'Training instability', true);
INSERT INTO public.options VALUES (21209, 5304, 'The external system with which the agent interacts', true);
INSERT INTO public.options VALUES (22357, 5591, 'Difference between current and updated estimate', true);
INSERT INTO public.options VALUES (20985, 5248, 'Empty', true);
INSERT INTO public.options VALUES (22701, 5677, 'Separating behavior and target policies', true);
INSERT INTO public.options VALUES (23361, 5842, 'Balancing exploration and exploitation', true);
INSERT INTO public.options VALUES (22485, 5623, 'Trade-off between bias and variance', true);
INSERT INTO public.options VALUES (21477, 5371, 'Decision-making quality', true);
INSERT INTO public.options VALUES (21549, 5389, 'Policy improvement', true);
INSERT INTO public.options VALUES (22105, 5528, 'Real-world interaction cost', true);
INSERT INTO public.options VALUES (21973, 5495, 'Expensive for large state spaces', true);
INSERT INTO public.options VALUES (23249, 5814, 'Updating multiple states simultaneously', true);
INSERT INTO public.options VALUES (22625, 5658, 'TD and Monte Carlo', true);
INSERT INTO public.options VALUES (23601, 5902, 'Optimal action-value function', true);
INSERT INTO public.options VALUES (21125, 5283, 'Execution time', true);
INSERT INTO public.options VALUES (21533, 5385, 'Selecting the best action', true);
INSERT INTO public.options VALUES (21373, 5345, 'All possible actions agent can take', true);
INSERT INTO public.options VALUES (22309, 5579, '{"text":"Markov Decision Process","is_correct":true}', true);
INSERT INTO public.options VALUES (21141, 5287, 'O(n)', true);
INSERT INTO public.options VALUES (23509, 5879, 'On-policy', true);
INSERT INTO public.options VALUES (22197, 5551, 'Value Iteration and Policy Iteration', true);
INSERT INTO public.options VALUES (22641, 5662, 'Learning about the policy currently being followed', true);
INSERT INTO public.options VALUES (21765, 5443, 'V*(s)', true);
INSERT INTO public.options VALUES (23245, 5813, 'Discount factor and lambda', true);
INSERT INTO public.options VALUES (23057, 5766, 'Mean Squared Value Error', true);
INSERT INTO public.options VALUES (23473, 5870, 'Gradient ascent', true);
INSERT INTO public.options VALUES (23385, 5848, 'No state transitions', true);
INSERT INTO public.options VALUES (20661, 5167, 'Linear', true);
INSERT INTO public.options VALUES (23453, 5865, 'REINFORCE', true);
INSERT INTO public.options VALUES (21873, 5470, 'Convergence', true);
INSERT INTO public.options VALUES (21577, 5396, 'Agent gains more experience', true);
INSERT INTO public.options VALUES (22189, 5549, 'Future optimal actions', true);
INSERT INTO public.options VALUES (23677, 5921, 'Using deep neural networks to approximate Q-values for complex RL tasks', true);
INSERT INTO public.options VALUES (23381, 5847, 'Upper Confidence Bound (UCB)', true);
INSERT INTO public.options VALUES (23273, 5820, 'Tracking past state-action visits', true);
INSERT INTO public.options VALUES (22813, 5705, 'Optimal policy directly', true);
INSERT INTO public.options VALUES (21621, 5407, 'Expected rewards and next state values', true);
INSERT INTO public.options VALUES (21017, 5256, 'Yes', true);
INSERT INTO public.options VALUES (20841, 5212, 'Logic', true);
INSERT INTO public.options VALUES (21917, 5481, 'Model-based method using Bellman updates to compute optimal policies', true);
INSERT INTO public.options VALUES (22361, 5592, 'Importance of future rewards', true);
INSERT INTO public.options VALUES (21681, 5422, 'Strategy that achieves highest expected return', true);
INSERT INTO public.options VALUES (20957, 5241, 'Random', true);
INSERT INTO public.options VALUES (22821, 5707, 'ε-greedy strategy', true);
INSERT INTO public.options VALUES (22213, 5555, 'Bellman Optimality Equation', true);
INSERT INTO public.options VALUES (20733, 5185, 'Bubble', true);
INSERT INTO public.options VALUES (23137, 5786, 'Weight ← Weight + α × TD error × feature', true);
INSERT INTO public.options VALUES (22029, 5509, 'Dynamic Programming method', true);
INSERT INTO public.options VALUES (21449, 5364, 'How good it is to be in a particular state', true);
INSERT INTO public.options VALUES (21213, 5305, 'State', true);
INSERT INTO public.options VALUES (20713, 5180, 'O(1)', true);
INSERT INTO public.options VALUES (23545, 5888, 'Gradient ascent guided by critic', true);
INSERT INTO public.options VALUES (22341, 5587, 'State-value function', true);
INSERT INTO public.options VALUES (21805, 5453, 'Optimal value function', true);
INSERT INTO public.options VALUES (21853, 5465, 'Bellman equations', true);
INSERT INTO public.options VALUES (21565, 5393, 'Control algorithms', true);
INSERT INTO public.options VALUES (23421, 5857, 'Online', true);
INSERT INTO public.options VALUES (21257, 5316, 'Exploitation', true);
INSERT INTO public.options VALUES (21265, 5318, 'Reinforcement Learning', true);
INSERT INTO public.options VALUES (21273, 5320, 'Sequential decision problems', true);
INSERT INTO public.options VALUES (23477, 5871, 'Variance of updates', true);
INSERT INTO public.options VALUES (22729, 5684, 'Action-value function Q(s,a)', true);
INSERT INTO public.options VALUES (22081, 5522, 'Using a model to simulate experience and improve policy', true);
INSERT INTO public.options VALUES (23681, 5922, 'Overestimation of Q-values', true);
INSERT INTO public.options VALUES (23553, 5890, 'Continuous action problems', true);
INSERT INTO public.options VALUES (23573, 5895, 'At each time step', true);
INSERT INTO public.options VALUES (21149, 5289, 'O(n)', true);
INSERT INTO public.options VALUES (22689, 5674, 'Current policy strategy', true);
INSERT INTO public.options VALUES (21589, 5399, 'Bellman updates', true);
INSERT INTO public.options VALUES (21473, 5370, 'Discounted sum of future rewards', true);
INSERT INTO public.options VALUES (21101, 5277, 'Extra memory', true);
INSERT INTO public.options VALUES (22313, 5580, '{"text":"They learn from real experience","is_correct":true}', true);
INSERT INTO public.options VALUES (21769, 5444, 'Q*(s,a)', true);
INSERT INTO public.options VALUES (21377, 5346, 'State Transition Function', true);
INSERT INTO public.options VALUES (22705, 5678, 'Next action chosen by policy', true);
INSERT INTO public.options VALUES (21605, 5403, 'Value functions', true);
INSERT INTO public.options VALUES (21121, 5282, 'Actual execution time', true);
INSERT INTO public.options VALUES (23465, 5868, 'Reward feedback', true);
INSERT INTO public.options VALUES (22245, 5563, '{"text":"Sampled returns","is_correct":true}', true);
INSERT INTO public.options VALUES (22553, 5640, 'TD and Monte Carlo', true);
INSERT INTO public.options VALUES (21945, 5488, 'Further improvement does not change policy', true);
INSERT INTO public.options VALUES (22265, 5568, '{"text":"Averaging returns from multiple episodes","is_correct":true}', true);
INSERT INTO public.options VALUES (23485, 5873, 'After sampling trajectories', true);
INSERT INTO public.options VALUES (22505, 5628, 'Value function', true);
INSERT INTO public.options VALUES (23533, 5885, 'Temporal Difference error', true);
INSERT INTO public.options VALUES (23033, 5760, 'Weights', true);
INSERT INTO public.options VALUES (23409, 5854, 'Thompson Sampling', true);
INSERT INTO public.options VALUES (22793, 5700, 'Exploration affects updates', true);
INSERT INTO public.options VALUES (22529, 5634, 'Weighted sum of multi-step returns', true);
INSERT INTO public.options VALUES (22481, 5622, 'TD(0) and Monte Carlo', true);
INSERT INTO public.options VALUES (20497, 5126, 'Slow access', true);
INSERT INTO public.options VALUES (21009, 5254, 'FIFO', true);
INSERT INTO public.options VALUES (22665, 5668, 'Behavior policy', true);
INSERT INTO public.options VALUES (22893, 5725, 'Memory requirement', true);
INSERT INTO public.options VALUES (22169, 5544, 'Dynamic Programming', true);
INSERT INTO public.options VALUES (22033, 5510, 'Choosing action with highest value', true);
INSERT INTO public.options VALUES (20705, 5178, 'Binary', true);
INSERT INTO public.options VALUES (22261, 5567, '{"text":"After an episode ends","is_correct":true}', true);
INSERT INTO public.options VALUES (21709, 5429, 'Policy improvement principle', true);
INSERT INTO public.options VALUES (23121, 5782, 'Learning value functions with function approximation', true);
INSERT INTO public.options VALUES (22713, 5680, 'Off-policy learning', true);
INSERT INTO public.options VALUES (22077, 5521, 'Method using Bellman optimality updates to compute optimal values and policy', true);
INSERT INTO public.options VALUES (21721, 5432, 'Q-Learning', true);
INSERT INTO public.options VALUES (22173, 5545, 'Optimal solutions of subproblems', true);
INSERT INTO public.options VALUES (21961, 5492, 'Max operator over actions', true);
INSERT INTO public.options VALUES (20813, 5205, 'Greatest Common Divisor', true);
INSERT INTO public.options VALUES (22285, 5573, '{"text":"ε-greedy policy","is_correct":true}', true);
INSERT INTO public.options VALUES (21261, 5317, 'Exploration–Exploitation trade-off', true);
INSERT INTO public.options VALUES (21401, 5352, 'Gamma', true);
INSERT INTO public.options VALUES (20721, 5182, 'Finding data', true);
INSERT INTO public.options VALUES (21761, 5442, 'Maximum expected return from a state', true);
INSERT INTO public.options VALUES (22845, 5713, 'Importance of future rewards', true);
INSERT INTO public.options VALUES (23397, 5851, 'Loss due to not choosing optimal action', true);
INSERT INTO public.options VALUES (23189, 5799, 'Faster convergence than Monte Carlo', true);
INSERT INTO public.options VALUES (23777, 5946, 'Portfolio optimization', true);
INSERT INTO public.options VALUES (23685, 5923, 'Two networks', true);
INSERT INTO public.options VALUES (21269, 5319, 'Robotics', true);
INSERT INTO public.options VALUES (21849, 5464, 'Policy Iteration and Value Iteration', true);
INSERT INTO public.options VALUES (20489, 5124, '0', true);
INSERT INTO public.options VALUES (20477, 5121, 'Graphic design', true);
INSERT INTO public.options VALUES (21137, 5286, 'Big-O', true);
INSERT INTO public.options VALUES (21453, 5365, 'Policy followed by the agent', true);
INSERT INTO public.options VALUES (21129, 5284, 'Big-O', true);
INSERT INTO public.options VALUES (22465, 5618, 'Entire episode trajectory', true);
INSERT INTO public.options VALUES (22333, 5585, 'Bootstrapping method', true);
INSERT INTO public.options VALUES (22789, 5699, 'Online control problems', true);
INSERT INTO public.options VALUES (23093, 5775, 'Generalized value function', true);
INSERT INTO public.options VALUES (23641, 5912, 'Past experiences', true);
INSERT INTO public.options VALUES (20789, 5199, 'Quick', true);
INSERT INTO public.options VALUES (22617, 5656, 'Value estimates stabilize', true);
INSERT INTO public.options VALUES (22941, 5737, 'Approximation error', true);
INSERT INTO public.options VALUES (22037, 5511, 'All states', true);
INSERT INTO public.options VALUES (20965, 5243, 'Insert', true);
INSERT INTO public.options VALUES (22677, 5671, 'Safer and more stable', true);
INSERT INTO public.options VALUES (22745, 5688, 'At every step of interaction', true);
INSERT INTO public.options VALUES (22945, 5738, 'Number of features/weights', true);
INSERT INTO public.options VALUES (22385, 5598, 'Estimated value of next state', true);
INSERT INTO public.options VALUES (20993, 5250, 'Space', true);
INSERT INTO public.options VALUES (20645, 5163, 'Binary Search', true);
INSERT INTO public.options VALUES (22433, 5610, 'Markov Decision Process', true);
INSERT INTO public.options VALUES (22293, 5575, '{"text":"At every occurrence of state in episode","is_correct":true}', true);
INSERT INTO public.options VALUES (20649, 5164, 'O(1)', true);
INSERT INTO public.options VALUES (22977, 5746, 'Mean Squared Error', true);
INSERT INTO public.options VALUES (22405, 5603, 'Monte Carlo method', true);
INSERT INTO public.options VALUES (23333, 5835, 'Training instability', true);
INSERT INTO public.options VALUES (23349, 5839, 'Epsilon-greedy', true);
INSERT INTO public.options VALUES (21897, 5476, 'Value function for current policy', true);
INSERT INTO public.options VALUES (23305, 5828, 'Feature learning', true);
INSERT INTO public.options VALUES (21569, 5394, 'V(s) can be derived from Q(s,a)', true);
INSERT INTO public.options VALUES (23141, 5787, 'TD learning and function approximation', true);
INSERT INTO public.options VALUES (21833, 5460, 'Max operator', true);
INSERT INTO public.options VALUES (20637, 5161, 'Numeric operations', true);
INSERT INTO public.options VALUES (22109, 5529, 'Planning techniques', true);
INSERT INTO public.options VALUES (23709, 5929, 'Off-policy learning', true);
INSERT INTO public.options VALUES (21817, 5456, 'Smaller recursive subproblems', true);
INSERT INTO public.options VALUES (22425, 5608, 'Complete episode experience', true);
INSERT INTO public.options VALUES (22389, 5599, 'Incremental', true);
INSERT INTO public.options VALUES (21509, 5379, 'Reinforcement Learning algorithms', true);
INSERT INTO public.options VALUES (22141, 5537, 'Dyna architecture', true);
INSERT INTO public.options VALUES (23689, 5924, 'Action selection', true);
INSERT INTO public.options VALUES (22769, 5694, 'Importance of future rewards', true);
INSERT INTO public.options VALUES (22249, 5564, '{"text":"Episode termination","is_correct":true}', true);
INSERT INTO public.options VALUES (21353, 5340, 'Trial-and-error learning', true);
INSERT INTO public.options VALUES (22897, 5726, 'Continuous state problems', true);
INSERT INTO public.options VALUES (22809, 5704, 'Maximum estimated Q-value of next state', true);
INSERT INTO public.options VALUES (20849, 5214, 'Infinite', true);
INSERT INTO public.options VALUES (23149, 5789, 'Large or continuous state space', true);
INSERT INTO public.options VALUES (20581, 5147, 'C', true);
INSERT INTO public.options VALUES (23497, 5876, 'Direct policy optimization', true);
INSERT INTO public.options VALUES (23401, 5852, 'Non-stationary bandit', true);
INSERT INTO public.options VALUES (21789, 5449, 'Discount factor', true);
INSERT INTO public.options VALUES (20633, 5160, 'Pattern matching', true);
INSERT INTO public.options VALUES (23557, 5891, 'A2C / A3C', true);
INSERT INTO public.options VALUES (21933, 5485, 'Maximum expected future reward', true);
INSERT INTO public.options VALUES (23757, 5941, 'Using two networks to reduce overestimation and stabilize Q-learning', true);
INSERT INTO public.options VALUES (22661, 5667, 'Greedy or optimal action estimate', true);
INSERT INTO public.options VALUES (20517, 5131, '1D', true);
INSERT INTO public.options VALUES (23537, 5886, 'Variance in policy gradient updates', true);
INSERT INTO public.options VALUES (21413, 5355, 'Markov Decision Process', true);
INSERT INTO public.options VALUES (23073, 5770, 'Environment model', true);
INSERT INTO public.options VALUES (20793, 5200, 'Keeps order', true);
INSERT INTO public.options VALUES (22061, 5517, 'Updating value estimates iteratively', true);
INSERT INTO public.options VALUES (21957, 5491, 'Bellman expectation equation', true);
INSERT INTO public.options VALUES (22805, 5703, 'Action-value function Q(s,a)', true);
INSERT INTO public.options VALUES (22517, 5631, 'Markov Decision Process', true);
INSERT INTO public.options VALUES (20893, 5225, 'Queue', true);
INSERT INTO public.options VALUES (21329, 5334, 'Action-Value Function', true);
INSERT INTO public.options VALUES (22133, 5535, 'Iteratively', true);
INSERT INTO public.options VALUES (23233, 5810, 'At every time step', true);
INSERT INTO public.options VALUES (21657, 5416, 'Optimality principle', true);
INSERT INTO public.options VALUES (21653, 5415, 'Gamma', true);
INSERT INTO public.options VALUES (23653, 5915, 'Large number of interactions', true);
INSERT INTO public.options VALUES (22937, 5736, 'Markov Decision Process', true);
INSERT INTO public.options VALUES (22681, 5672, 'They can reuse past experience', true);
INSERT INTO public.options VALUES (20473, 5120, 'Graph', true);
INSERT INTO public.options VALUES (22049, 5514, 'Expensive for large state spaces', true);
INSERT INTO public.options VALUES (21593, 5400, 'Maximization over actions', true);
INSERT INTO public.options VALUES (20549, 5139, '2D', true);
INSERT INTO public.options VALUES (23549, 5889, 'State value or action value', true);
INSERT INTO public.options VALUES (21205, 5303, 'Agent', true);
INSERT INTO public.options VALUES (23541, 5887, 'Online learning', true);
INSERT INTO public.options VALUES (21829, 5459, 'Immediate reward plus optimal next state value', true);
INSERT INTO public.options VALUES (21701, 5427, 'Highest possible expected reward from state', true);
INSERT INTO public.options VALUES (21357, 5341, 'Agent interacts, observes states, takes actions, gets rewards, improves policy', true);
INSERT INTO public.options VALUES (22113, 5530, 'Future rewards', true);
INSERT INTO public.options VALUES (23805, 5953, 'Logistics', true);
INSERT INTO public.options VALUES (23645, 5913, 'Optimal policy indirectly via Q-values', true);
INSERT INTO public.options VALUES (20402, 5102, 'Data Science Analysis', false);
INSERT INTO public.options VALUES (20404, 5102, 'Data Storage Algorithm', false);
INSERT INTO public.options VALUES (20403, 5102, 'Data Structures and Algorithms', false);
INSERT INTO public.options VALUES (20418, 5106, 'Queue', false);
INSERT INTO public.options VALUES (20425, 5108, 'Queue', true);
INSERT INTO public.options VALUES (20437, 5111, 'Ticket counter', true);
INSERT INTO public.options VALUES (20429, 5109, 'Stack', true);
INSERT INTO public.options VALUES (20417, 5106, 'Array', true);
INSERT INTO public.options VALUES (20405, 5103, 'A programming language', true);
INSERT INTO public.options VALUES (20421, 5107, 'To increase code length', true);
INSERT INTO public.options VALUES (21157, 5291, 'O(n)', true);
INSERT INTO public.options VALUES (21041, 5262, 'Loop', true);
INSERT INTO public.options VALUES (23085, 5773, 'Actual trajectory rewards', true);
INSERT INTO public.options VALUES (21469, 5369, 'Policy evaluation', true);
INSERT INTO public.options VALUES (21089, 5274, 'DFS', true);
INSERT INTO public.options VALUES (21825, 5458, 'Optimal action-value function', true);
INSERT INTO public.options VALUES (20641, 5162, 'Sorting data', true);
INSERT INTO public.options VALUES (22413, 5605, 'After episode termination', true);
INSERT INTO public.options VALUES (20653, 5165, 'Unsorted array', true);
INSERT INTO public.options VALUES (20701, 5177, 'Data retrieval', true);
INSERT INTO public.options VALUES (23341, 5837, 'Update neural network weights', true);
INSERT INTO public.options VALUES (23489, 5874, 'Explicit value function in some cases', true);
INSERT INTO public.options VALUES (20673, 5170, 'Greedy', true);
INSERT INTO public.options VALUES (23673, 5920, 'Stabilize learning', true);
INSERT INTO public.options VALUES (21409, 5354, 'Markov Property', true);
INSERT INTO public.options VALUES (23437, 5861, 'Learning to choose best action without state transitions', true);
INSERT INTO public.options VALUES (23325, 5833, 'Break correlation between samples', true);
INSERT INTO public.options VALUES (22129, 5534, 'Transition model', true);
INSERT INTO public.options VALUES (21073, 5270, 'Start', true);
INSERT INTO public.options VALUES (22765, 5693, 'Interaction with environment', true);
INSERT INTO public.options VALUES (22449, 5614, 'Using full return information', true);
INSERT INTO public.options VALUES (21281, 5322, 'Agent', true);
INSERT INTO public.options VALUES (21277, 5321, 'Agent interacts, receives rewards and improves policy', true);
INSERT INTO public.options VALUES (22373, 5595, 'Value estimates stabilize', true);
INSERT INTO public.options VALUES (20981, 5247, 'Full', true);
INSERT INTO public.options VALUES (22825, 5708, 'At every interaction step', true);
INSERT INTO public.options VALUES (23773, 5945, 'Smart transportation systems', true);
INSERT INTO public.options VALUES (23257, 5816, 'TD(λ) algorithms', true);
INSERT INTO public.options VALUES (21561, 5392, 'Q-value', true);
INSERT INTO public.options VALUES (20465, 5118, 'UI design', true);
INSERT INTO public.options VALUES (22177, 5546, 'Markov Decision Process', true);
INSERT INTO public.options VALUES (22365, 5593, 'Magnitude of update', true);
INSERT INTO public.options VALUES (21517, 5381, 'It estimates expected future rewards for states', true);
INSERT INTO public.options VALUES (21109, 5279, 'Logic', true);
INSERT INTO public.options VALUES (20737, 5186, 'Greedy', true);
INSERT INTO public.options VALUES (23173, 5795, 'Bootstrapping value estimates', true);
INSERT INTO public.options VALUES (20973, 5245, 'Undo', true);
INSERT INTO public.options VALUES (23789, 5949, 'Smart grid optimization', true);
INSERT INTO public.options VALUES (21221, 5307, 'Policy', true);
INSERT INTO public.options VALUES (23449, 5864, 'Maximize expected cumulative reward', true);
INSERT INTO public.options VALUES (22693, 5675, 'Q-Learning', true);
INSERT INTO public.options VALUES (21625, 5408, 'Bellman Expectation Equation', true);
INSERT INTO public.options VALUES (23145, 5788, 'Online during episode', true);
INSERT INTO public.options VALUES (20541, 5137, 'O(1)', true);
INSERT INTO public.options VALUES (21977, 5496, 'Using updated value estimates', true);
INSERT INTO public.options VALUES (23597, 5901, 'Policy optimization guided by value estimation', true);
INSERT INTO public.options VALUES (22949, 5739, 'Deep Reinforcement Learning', true);
INSERT INTO public.options VALUES (22209, 5554, 'Computation complexity via decomposition', true);
INSERT INTO public.options VALUES (20605, 5153, 'O(1)', true);
INSERT INTO public.options VALUES (21457, 5366, 'Vπ(s)', true);
INSERT INTO public.options VALUES (20685, 5173, 'Linear', true);
INSERT INTO public.options VALUES (23153, 5790, 'Memory requirement of tabular methods', true);
INSERT INTO public.options VALUES (23133, 5785, 'It ignores the gradient of the target value', true);
INSERT INTO public.options VALUES (22577, 5646, 'Sum of k rewards + bootstrapped estimate', true);
INSERT INTO public.options VALUES (21437, 5361, 'Framework using states, actions, transitions and rewards', true);
INSERT INTO public.options VALUES (22453, 5615, 'Bellman expectation equation indirectly', true);
INSERT INTO public.options VALUES (21421, 5357, 'Actions in states lead to new states and rewards', true);
INSERT INTO public.options VALUES (21785, 5448, 'Markov Decision Process', true);
INSERT INTO public.options VALUES (22733, 5685, 'Next action actually taken', true);
INSERT INTO public.options VALUES (22089, 5524, 'Learn without real interaction', true);
INSERT INTO public.options VALUES (23745, 5938, 'Deep Reinforcement Learning', true);
INSERT INTO public.options VALUES (22953, 5740, 'Directly approximating policy function', true);
INSERT INTO public.options VALUES (20741, 5187, 'O(n)', true);
INSERT INTO public.options VALUES (23049, 5764, 'Episode termination', true);
INSERT INTO public.options VALUES (23649, 5914, 'Bootstrapping', true);
INSERT INTO public.options VALUES (20953, 5240, 'Allowed', true);
INSERT INTO public.options VALUES (21773, 5445, 'Maximization over actions', true);
INSERT INTO public.options VALUES (22777, 5696, 'Q-values stabilize', true);
INSERT INTO public.options VALUES (21201, 5302, 'To maximize cumulative reward over time', true);
INSERT INTO public.options VALUES (20745, 5188, 'Quick', true);
INSERT INTO public.options VALUES (22797, 5701, 'On-policy TD control method updating Q-values using next action from policy', true);
INSERT INTO public.options VALUES (21197, 5301, 'UI design', true);
INSERT INTO public.options VALUES (23657, 5916, 'Convolutional Neural Network', true);
INSERT INTO public.options VALUES (21861, 5467, 'Finite state and action spaces', true);
INSERT INTO public.options VALUES (22657, 5666, 'Actions actually taken by current policy', true);
INSERT INTO public.options VALUES (22609, 5654, 'Estimated value after k steps', true);
INSERT INTO public.options VALUES (22297, 5576, '{"text":"Using averaged returns","is_correct":true}', true);
INSERT INTO public.options VALUES (20419, 5106, 'Stack', false);
INSERT INTO public.options VALUES (20420, 5106, 'Tree', false);
INSERT INTO public.options VALUES (20406, 5103, 'A way to store and organize data', false);
INSERT INTO public.options VALUES (20407, 5103, 'A compiler', false);
INSERT INTO public.options VALUES (20408, 5103, 'An operating system', false);
INSERT INTO public.options VALUES (20410, 5104, 'A step-by-step procedure', false);
INSERT INTO public.options VALUES (20411, 5104, 'A database', false);
INSERT INTO public.options VALUES (20412, 5104, 'A programming language', false);
INSERT INTO public.options VALUES (20414, 5105, 'Graph', false);
INSERT INTO public.options VALUES (20415, 5105, 'Stack', false);
INSERT INTO public.options VALUES (20416, 5105, 'Heap', false);
INSERT INTO public.options VALUES (20422, 5107, 'To optimize performance', false);
INSERT INTO public.options VALUES (20423, 5107, 'To reduce UI bugs', false);
INSERT INTO public.options VALUES (20424, 5107, 'To write HTML', false);
INSERT INTO public.options VALUES (20426, 5108, 'Stack', false);
INSERT INTO public.options VALUES (20427, 5108, 'Array', false);
INSERT INTO public.options VALUES (20428, 5108, 'Tree', false);
INSERT INTO public.options VALUES (20435, 5110, 'Algorithm', false);
INSERT INTO public.options VALUES (20436, 5110, 'Queue', false);
INSERT INTO public.options VALUES (20438, 5111, 'Undo/Redo', false);
INSERT INTO public.options VALUES (20439, 5111, 'ATM queue', false);
INSERT INTO public.options VALUES (20440, 5111, 'Traffic signal', false);
INSERT INTO public.options VALUES (20442, 5112, 'Stack of plates', false);
INSERT INTO public.options VALUES (20443, 5112, 'Line at bank', false);
INSERT INTO public.options VALUES (20444, 5112, 'Recursion', false);
INSERT INTO public.options VALUES (20446, 5113, 'Stack', false);
INSERT INTO public.options VALUES (20447, 5113, 'Hash Table', false);
INSERT INTO public.options VALUES (20448, 5113, 'Queue', false);
INSERT INTO public.options VALUES (20450, 5114, 'Linked List', false);
INSERT INTO public.options VALUES (20451, 5114, 'Static array', false);
INSERT INTO public.options VALUES (20452, 5114, 'Tuple', false);
INSERT INTO public.options VALUES (20454, 5115, 'Stack', false);
INSERT INTO public.options VALUES (20455, 5115, 'Array', false);
INSERT INTO public.options VALUES (20456, 5115, 'Graph', false);
INSERT INTO public.options VALUES (20462, 5117, 'C++', false);
INSERT INTO public.options VALUES (20463, 5117, 'Python', false);
INSERT INTO public.options VALUES (20464, 5117, 'Algorithm', false);
INSERT INTO public.options VALUES (20466, 5118, 'Efficient problem solving', false);
INSERT INTO public.options VALUES (20467, 5118, 'Web styling', false);
INSERT INTO public.options VALUES (20468, 5118, 'Animations', false);
INSERT INTO public.options VALUES (20470, 5119, 'Queue', false);
INSERT INTO public.options VALUES (20471, 5119, 'Tree', false);
INSERT INTO public.options VALUES (20472, 5119, 'Stack', false);
INSERT INTO public.options VALUES (20474, 5120, 'Array', false);
INSERT INTO public.options VALUES (20475, 5120, 'Stack', false);
INSERT INTO public.options VALUES (20476, 5120, 'Queue', false);
INSERT INTO public.options VALUES (20478, 5121, 'Game logic', false);
INSERT INTO public.options VALUES (20479, 5121, 'Problem solving', false);
INSERT INTO public.options VALUES (20480, 5121, 'Video editing', false);
INSERT INTO public.options VALUES (20482, 5122, 'Collection of different data types', false);
INSERT INTO public.options VALUES (20483, 5122, 'Dynamic structure', false);
INSERT INTO public.options VALUES (20484, 5122, 'Tree structure', false);
INSERT INTO public.options VALUES (20486, 5123, 'Contiguous memory', false);
INSERT INTO public.options VALUES (20487, 5123, 'Heap only', false);
INSERT INTO public.options VALUES (20488, 5123, 'Stack only', false);
INSERT INTO public.options VALUES (20490, 5124, '1', false);
INSERT INTO public.options VALUES (20491, 5124, '-1', false);
INSERT INTO public.options VALUES (20481, 5122, 'Collection of elements of same type', true);
INSERT INTO public.options VALUES (20569, 5144, '0', true);
INSERT INTO public.options VALUES (20492, 5124, 'Depends', false);
INSERT INTO public.options VALUES (20494, 5125, 'O(log n)', false);
INSERT INTO public.options VALUES (20495, 5125, 'O(1)', false);
INSERT INTO public.options VALUES (20496, 5125, 'O(n²)', false);
INSERT INTO public.options VALUES (20498, 5126, 'Fixed size', false);
INSERT INTO public.options VALUES (20499, 5126, 'Complex syntax', false);
INSERT INTO public.options VALUES (20500, 5126, 'High memory', false);
INSERT INTO public.options VALUES (20502, 5127, 'Insertion', false);
INSERT INTO public.options VALUES (20503, 5127, 'Reading', false);
INSERT INTO public.options VALUES (20504, 5127, 'Indexing', false);
INSERT INTO public.options VALUES (20506, 5128, 'Fixed', false);
INSERT INTO public.options VALUES (20507, 5128, 'Random', false);
INSERT INTO public.options VALUES (20508, 5128, 'Unlimited', false);
INSERT INTO public.options VALUES (20510, 5129, 'Binary', false);
INSERT INTO public.options VALUES (20511, 5129, 'Both', false);
INSERT INTO public.options VALUES (20512, 5129, 'None', false);
INSERT INTO public.options VALUES (20514, 5130, 'Small array', false);
INSERT INTO public.options VALUES (20515, 5130, 'Linked list', false);
INSERT INTO public.options VALUES (20516, 5130, 'Tree', false);
INSERT INTO public.options VALUES (20518, 5131, '2D', false);
INSERT INTO public.options VALUES (20519, 5131, '3D', false);
INSERT INTO public.options VALUES (20520, 5131, 'Jagged', false);
INSERT INTO public.options VALUES (20522, 5132, 'O(log n)', false);
INSERT INTO public.options VALUES (20523, 5132, 'O(n)', false);
INSERT INTO public.options VALUES (20524, 5132, 'O(n²)', false);
INSERT INTO public.options VALUES (20526, 5133, 'Linked List', false);
INSERT INTO public.options VALUES (20527, 5133, 'Stack', false);
INSERT INTO public.options VALUES (20528, 5133, 'Queue', false);
INSERT INTO public.options VALUES (20530, 5134, 'At runtime', false);
INSERT INTO public.options VALUES (20531, 5134, 'Both', false);
INSERT INTO public.options VALUES (20532, 5134, 'Never', false);
INSERT INTO public.options VALUES (20534, 5135, '1', false);
INSERT INTO public.options VALUES (20535, 5135, 'Depends on OS', false);
INSERT INTO public.options VALUES (20536, 5135, '-1', false);
INSERT INTO public.options VALUES (20538, 5136, 'Linked List', false);
INSERT INTO public.options VALUES (20539, 5136, 'Same', false);
INSERT INTO public.options VALUES (20540, 5136, 'Depends', false);
INSERT INTO public.options VALUES (20542, 5137, 'O(n)', false);
INSERT INTO public.options VALUES (20543, 5137, 'O(log n)', false);
INSERT INTO public.options VALUES (20544, 5137, 'O(n²)', false);
INSERT INTO public.options VALUES (20546, 5138, 'O(log n)', false);
INSERT INTO public.options VALUES (20547, 5138, 'O(n)', false);
INSERT INTO public.options VALUES (20548, 5138, 'O(n²)', false);
INSERT INTO public.options VALUES (20550, 5139, 'Jagged', false);
INSERT INTO public.options VALUES (20551, 5139, '3D', false);
INSERT INTO public.options VALUES (20552, 5139, 'Static', false);
INSERT INTO public.options VALUES (20554, 5140, 'Stack', false);
INSERT INTO public.options VALUES (20555, 5140, 'Contiguous blocks', false);
INSERT INTO public.options VALUES (20556, 5140, 'Registers', false);
INSERT INTO public.options VALUES (20558, 5141, 'Random access', false);
INSERT INTO public.options VALUES (20559, 5141, 'Dynamic resizing', false);
INSERT INTO public.options VALUES (20560, 5141, 'Recursion', false);
INSERT INTO public.options VALUES (20562, 5142, 'Collection of numbers', false);
INSERT INTO public.options VALUES (20563, 5142, 'Boolean value', false);
INSERT INTO public.options VALUES (20564, 5142, 'Tree node', false);
INSERT INTO public.options VALUES (20566, 5143, 'Stack', false);
INSERT INTO public.options VALUES (20567, 5143, 'Queue', false);
INSERT INTO public.options VALUES (20568, 5143, 'Tree', false);
INSERT INTO public.options VALUES (20570, 5144, '1', false);
INSERT INTO public.options VALUES (20571, 5144, '-1', false);
INSERT INTO public.options VALUES (20572, 5144, 'Depends', false);
INSERT INTO public.options VALUES (20574, 5145, 'Deletion', false);
INSERT INTO public.options VALUES (20575, 5145, 'Traversal', false);
INSERT INTO public.options VALUES (20576, 5145, 'All', false);
INSERT INTO public.options VALUES (20578, 5146, 'O(n)', false);
INSERT INTO public.options VALUES (20579, 5146, 'O(log n)', false);
INSERT INTO public.options VALUES (20580, 5146, 'O(n²)', false);
INSERT INTO public.options VALUES (20582, 5147, 'C++', false);
INSERT INTO public.options VALUES (20583, 5147, 'Java', false);
INSERT INTO public.options VALUES (20584, 5147, 'Assembly', false);
INSERT INTO public.options VALUES (20586, 5148, 'int[]', false);
INSERT INTO public.options VALUES (20587, 5148, 'bool[]', false);
INSERT INTO public.options VALUES (20588, 5148, 'float[]', false);
INSERT INTO public.options VALUES (20590, 5149, 'Whole string', false);
INSERT INTO public.options VALUES (20591, 5149, 'New string only', false);
INSERT INTO public.options VALUES (20592, 5149, 'Invalid', false);
INSERT INTO public.options VALUES (20594, 5150, 'strcmp()', false);
INSERT INTO public.options VALUES (20595, 5150, 'check()', false);
INSERT INTO public.options VALUES (20596, 5150, 'equal()', false);
INSERT INTO public.options VALUES (20598, 5151, 'O(log n)', false);
INSERT INTO public.options VALUES (20599, 5151, 'O(n)', false);
INSERT INTO public.options VALUES (20600, 5151, 'O(n²)', false);
INSERT INTO public.options VALUES (20602, 5152, 'StringBuilder', false);
INSERT INTO public.options VALUES (20603, 5152, 'char', false);
INSERT INTO public.options VALUES (20604, 5152, 'int', false);
INSERT INTO public.options VALUES (20606, 5153, 'O(n)', false);
INSERT INTO public.options VALUES (20607, 5153, 'O(log n)', false);
INSERT INTO public.options VALUES (20608, 5153, 'O(n²)', false);
INSERT INTO public.options VALUES (20610, 5154, 'O(1)', false);
INSERT INTO public.options VALUES (20611, 5154, 'O(log n)', false);
INSERT INTO public.options VALUES (20612, 5154, 'O(n²)', false);
INSERT INTO public.options VALUES (20614, 5155, 'Sorting', false);
INSERT INTO public.options VALUES (20615, 5155, 'Searching', false);
INSERT INTO public.options VALUES (20616, 5155, 'Insertion', false);
INSERT INTO public.options VALUES (20618, 5156, 'American Standard Code for Information Interchange', false);
INSERT INTO public.options VALUES (20619, 5156, 'Advanced System Code', false);
INSERT INTO public.options VALUES (20620, 5156, 'None', false);
INSERT INTO public.options VALUES (20622, 5157, 'ASCII', false);
INSERT INTO public.options VALUES (20623, 5157, 'Multiple languages', false);
INSERT INTO public.options VALUES (20624, 5157, 'Binary', false);
INSERT INTO public.options VALUES (20626, 5158, 'Characters', false);
INSERT INTO public.options VALUES (20627, 5158, 'Hash', false);
INSERT INTO public.options VALUES (20628, 5158, 'All', false);
INSERT INTO public.options VALUES (20630, 5159, 'Join', false);
INSERT INTO public.options VALUES (20631, 5159, 'Multiply', false);
INSERT INTO public.options VALUES (20632, 5159, 'Replace', false);
INSERT INTO public.options VALUES (20634, 5160, 'DFS', false);
INSERT INTO public.options VALUES (20635, 5160, 'BFS', false);
INSERT INTO public.options VALUES (20636, 5160, 'Sorting', false);
INSERT INTO public.options VALUES (20638, 5161, 'Text processing', false);
INSERT INTO public.options VALUES (20639, 5161, 'Graph traversal', false);
INSERT INTO public.options VALUES (20640, 5161, 'Sorting', false);
INSERT INTO public.options VALUES (20642, 5162, 'Finding an element in data', false);
INSERT INTO public.options VALUES (20643, 5162, 'Deleting data', false);
INSERT INTO public.options VALUES (20644, 5162, 'Updating data', false);
INSERT INTO public.options VALUES (20646, 5163, 'Linear Search', false);
INSERT INTO public.options VALUES (20647, 5163, 'Jump Search', false);
INSERT INTO public.options VALUES (20648, 5163, 'Interpolation Search', false);
INSERT INTO public.options VALUES (20650, 5164, 'O(log n)', false);
INSERT INTO public.options VALUES (20651, 5164, 'O(n)', false);
INSERT INTO public.options VALUES (20652, 5164, 'O(n log n)', false);
INSERT INTO public.options VALUES (20654, 5165, 'Sorted array', false);
INSERT INTO public.options VALUES (20655, 5165, 'Linked list', false);
INSERT INTO public.options VALUES (20656, 5165, 'Graph', false);
INSERT INTO public.options VALUES (20658, 5166, 'O(log n)', false);
INSERT INTO public.options VALUES (20659, 5166, 'O(n²)', false);
INSERT INTO public.options VALUES (20660, 5166, 'O(1)', false);
INSERT INTO public.options VALUES (20662, 5167, 'Binary', false);
INSERT INTO public.options VALUES (20663, 5167, 'Jump', false);
INSERT INTO public.options VALUES (20664, 5167, 'DFS', false);
INSERT INTO public.options VALUES (20666, 5168, 'Divide search', false);
INSERT INTO public.options VALUES (20667, 5168, 'Fast search', false);
INSERT INTO public.options VALUES (20668, 5168, 'Hash search', false);
INSERT INTO public.options VALUES (20670, 5169, 'O(log n)', false);
INSERT INTO public.options VALUES (20671, 5169, 'O(1)', false);
INSERT INTO public.options VALUES (20672, 5169, 'O(n log n)', false);
INSERT INTO public.options VALUES (20674, 5170, 'Divide & Conquer', false);
INSERT INTO public.options VALUES (20675, 5170, 'Dynamic', false);
INSERT INTO public.options VALUES (20676, 5170, 'Backtracking', false);
INSERT INTO public.options VALUES (20678, 5171, 'O(log n)', false);
INSERT INTO public.options VALUES (20679, 5171, 'O(n)', false);
INSERT INTO public.options VALUES (20680, 5171, 'O(n²)', false);
INSERT INTO public.options VALUES (20682, 5172, 'Locating data', false);
INSERT INTO public.options VALUES (20683, 5172, 'Deleting data', false);
INSERT INTO public.options VALUES (20684, 5172, 'Encrypting data', false);
INSERT INTO public.options VALUES (20686, 5173, 'Binary', false);
INSERT INTO public.options VALUES (20687, 5173, 'Both same', false);
INSERT INTO public.options VALUES (20688, 5173, 'None', false);
INSERT INTO public.options VALUES (20690, 5174, 'Array is unsorted', false);
INSERT INTO public.options VALUES (20691, 5174, 'Array is small', false);
INSERT INTO public.options VALUES (20692, 5174, 'Array is empty', false);
INSERT INTO public.options VALUES (20694, 5175, 'Unsorted only', false);
INSERT INTO public.options VALUES (20695, 5175, 'Both', false);
INSERT INTO public.options VALUES (20696, 5175, 'None', false);
INSERT INTO public.options VALUES (20698, 5176, 'log n', false);
INSERT INTO public.options VALUES (20699, 5176, 'n²', false);
INSERT INTO public.options VALUES (20700, 5176, '1', false);
INSERT INTO public.options VALUES (20702, 5177, 'Data sorting', false);
INSERT INTO public.options VALUES (20703, 5177, 'Data deletion', false);
INSERT INTO public.options VALUES (20704, 5177, 'UI design', false);
INSERT INTO public.options VALUES (20706, 5178, 'Linear', false);
INSERT INTO public.options VALUES (20707, 5178, 'Merge', false);
INSERT INTO public.options VALUES (21225, 5308, 'Reward', true);
INSERT INTO public.options VALUES (20708, 5178, 'Jump', false);
INSERT INTO public.options VALUES (20710, 5179, 'O(log n)', false);
INSERT INTO public.options VALUES (20711, 5179, 'O(n)', false);
INSERT INTO public.options VALUES (20712, 5179, 'O(n²)', false);
INSERT INTO public.options VALUES (20714, 5180, 'O(n)', false);
INSERT INTO public.options VALUES (20715, 5180, 'O(log n)', false);
INSERT INTO public.options VALUES (20716, 5180, 'O(n²)', false);
INSERT INTO public.options VALUES (20718, 5181, 'Accuracy', false);
INSERT INTO public.options VALUES (20719, 5181, 'Performance', false);
INSERT INTO public.options VALUES (20720, 5181, 'Efficiency', false);
INSERT INTO public.options VALUES (20722, 5182, 'Arranging data', false);
INSERT INTO public.options VALUES (20723, 5182, 'Deleting data', false);
INSERT INTO public.options VALUES (20724, 5182, 'Encrypting data', false);
INSERT INTO public.options VALUES (20726, 5183, 'Quick', false);
INSERT INTO public.options VALUES (20727, 5183, 'Bubble', false);
INSERT INTO public.options VALUES (20728, 5183, 'Heap', false);
INSERT INTO public.options VALUES (20730, 5184, 'O(n²)', false);
INSERT INTO public.options VALUES (20731, 5184, 'O(log n)', false);
INSERT INTO public.options VALUES (20732, 5184, 'O(n log n)', false);
INSERT INTO public.options VALUES (20734, 5185, 'Insertion', false);
INSERT INTO public.options VALUES (20735, 5185, 'Quick', false);
INSERT INTO public.options VALUES (20736, 5185, 'Selection', false);
INSERT INTO public.options VALUES (20738, 5186, 'Divide & Conquer', false);
INSERT INTO public.options VALUES (20739, 5186, 'Backtracking', false);
INSERT INTO public.options VALUES (20740, 5186, 'DP', false);
INSERT INTO public.options VALUES (20742, 5187, 'O(n log n)', false);
INSERT INTO public.options VALUES (20743, 5187, 'O(n²)', false);
INSERT INTO public.options VALUES (20744, 5187, 'O(log n)', false);
INSERT INTO public.options VALUES (20746, 5188, 'Heap', false);
INSERT INTO public.options VALUES (20747, 5188, 'Bubble', false);
INSERT INTO public.options VALUES (20748, 5188, 'Selection', false);
INSERT INTO public.options VALUES (20750, 5189, 'O(n²)', false);
INSERT INTO public.options VALUES (20751, 5189, 'O(n log n)', false);
INSERT INTO public.options VALUES (20752, 5189, 'O(log n)', false);
INSERT INTO public.options VALUES (20754, 5190, 'O(n²)', false);
INSERT INTO public.options VALUES (20755, 5190, 'O(log n)', false);
INSERT INTO public.options VALUES (20756, 5190, 'O(1)', false);
INSERT INTO public.options VALUES (20758, 5191, 'O(n log n)', false);
INSERT INTO public.options VALUES (20759, 5191, 'O(n²)', false);
INSERT INTO public.options VALUES (20760, 5191, 'O(log n)', false);
INSERT INTO public.options VALUES (20762, 5192, 'UI', false);
INSERT INTO public.options VALUES (20763, 5192, 'Security', false);
INSERT INTO public.options VALUES (20764, 5192, 'Storage', false);
INSERT INTO public.options VALUES (20766, 5193, 'Quick', false);
INSERT INTO public.options VALUES (20767, 5193, 'Bubble', false);
INSERT INTO public.options VALUES (20768, 5193, 'Insertion', false);
INSERT INTO public.options VALUES (20770, 5194, 'Queue', false);
INSERT INTO public.options VALUES (20771, 5194, 'Heap', false);
INSERT INTO public.options VALUES (20772, 5194, 'Tree', false);
INSERT INTO public.options VALUES (20774, 5195, 'Random', false);
INSERT INTO public.options VALUES (20775, 5195, 'Middle', false);
INSERT INTO public.options VALUES (20776, 5195, 'Ends', false);
INSERT INTO public.options VALUES (20778, 5196, 'Huge data', false);
INSERT INTO public.options VALUES (20779, 5196, 'Random data', false);
INSERT INTO public.options VALUES (20780, 5196, 'Graphs', false);
INSERT INTO public.options VALUES (20782, 5197, 'Descending', false);
INSERT INTO public.options VALUES (20783, 5197, 'Both', false);
INSERT INTO public.options VALUES (20784, 5197, 'None', false);
INSERT INTO public.options VALUES (20786, 5198, 'Quick', false);
INSERT INTO public.options VALUES (20787, 5198, 'Both', false);
INSERT INTO public.options VALUES (20788, 5198, 'None', false);
INSERT INTO public.options VALUES (20790, 5199, 'Merge', false);
INSERT INTO public.options VALUES (20791, 5199, 'Both', false);
INSERT INTO public.options VALUES (20792, 5199, 'None', false);
INSERT INTO public.options VALUES (20794, 5200, 'Fast', false);
INSERT INTO public.options VALUES (20795, 5200, 'Memory efficient', false);
INSERT INTO public.options VALUES (20796, 5200, 'Random', false);
INSERT INTO public.options VALUES (20798, 5201, 'Linear search', false);
INSERT INTO public.options VALUES (20799, 5201, 'Hashing', false);
INSERT INTO public.options VALUES (20800, 5201, 'Stack', false);
INSERT INTO public.options VALUES (20802, 5202, 'Even number', false);
INSERT INTO public.options VALUES (20803, 5202, 'Odd number', false);
INSERT INTO public.options VALUES (20804, 5202, 'Composite', false);
INSERT INTO public.options VALUES (20806, 5203, 'Composite', false);
INSERT INTO public.options VALUES (20807, 5203, 'Odd', false);
INSERT INTO public.options VALUES (20808, 5203, 'None', false);
INSERT INTO public.options VALUES (20810, 5204, 'Large Common Multiple', false);
INSERT INTO public.options VALUES (20811, 5204, 'Lowest Common Mode', false);
INSERT INTO public.options VALUES (20812, 5204, 'None', false);
INSERT INTO public.options VALUES (20814, 5205, 'Global Common Divisor', false);
INSERT INTO public.options VALUES (20815, 5205, 'General Common Divisor', false);
INSERT INTO public.options VALUES (20816, 5205, 'None', false);
INSERT INTO public.options VALUES (20818, 5206, 'Remainder', false);
INSERT INTO public.options VALUES (20819, 5206, 'Product', false);
INSERT INTO public.options VALUES (20820, 5206, 'Sum', false);
INSERT INTO public.options VALUES (20822, 5207, '2', false);
INSERT INTO public.options VALUES (20823, 5207, '5', false);
INSERT INTO public.options VALUES (20824, 5207, '7', false);
INSERT INTO public.options VALUES (20826, 5208, '2', false);
INSERT INTO public.options VALUES (20827, 5208, '4', false);
INSERT INTO public.options VALUES (20828, 5208, '1', false);
INSERT INTO public.options VALUES (20830, 5209, '1', false);
INSERT INTO public.options VALUES (20831, 5209, 'Undefined', false);
INSERT INTO public.options VALUES (20832, 5209, 'Infinity', false);
INSERT INTO public.options VALUES (20834, 5210, '3', false);
INSERT INTO public.options VALUES (20835, 5210, '0', false);
INSERT INTO public.options VALUES (20836, 5210, '2', false);
INSERT INTO public.options VALUES (20838, 5211, '*', false);
INSERT INTO public.options VALUES (20839, 5211, '^', false);
INSERT INTO public.options VALUES (20840, 5211, '%', false);
INSERT INTO public.options VALUES (20842, 5212, 'Optimization', false);
INSERT INTO public.options VALUES (20843, 5212, 'Efficiency', false);
INSERT INTO public.options VALUES (20844, 5212, 'All', false);
INSERT INTO public.options VALUES (20846, 5213, '1,2', false);
INSERT INTO public.options VALUES (20847, 5213, '2,3', false);
INSERT INTO public.options VALUES (20848, 5213, '1,3', false);
INSERT INTO public.options VALUES (20850, 5214, 'Limited', false);
INSERT INTO public.options VALUES (20851, 5214, 'Odd only', false);
INSERT INTO public.options VALUES (20852, 5214, 'Even only', false);
INSERT INTO public.options VALUES (20854, 5215, '20', false);
INSERT INTO public.options VALUES (20855, 5215, '25', false);
INSERT INTO public.options VALUES (20856, 5215, '30', false);
INSERT INTO public.options VALUES (20858, 5216, '27', false);
INSERT INTO public.options VALUES (20859, 5216, '18', false);
INSERT INTO public.options VALUES (20860, 5216, '6', false);
INSERT INTO public.options VALUES (20862, 5217, '8', false);
INSERT INTO public.options VALUES (20863, 5217, '10', false);
INSERT INTO public.options VALUES (20864, 5217, '16', false);
INSERT INTO public.options VALUES (20866, 5218, '8', false);
INSERT INTO public.options VALUES (20867, 5218, '10', false);
INSERT INTO public.options VALUES (20868, 5218, '16', false);
INSERT INTO public.options VALUES (20870, 5219, 'No', false);
INSERT INTO public.options VALUES (20871, 5219, 'Sometimes', false);
INSERT INTO public.options VALUES (20872, 5219, 'Rarely', false);
INSERT INTO public.options VALUES (20874, 5220, '5', false);
INSERT INTO public.options VALUES (20875, 5220, '10', false);
INSERT INTO public.options VALUES (20876, 5220, '15', false);
INSERT INTO public.options VALUES (20878, 5221, '24', false);
INSERT INTO public.options VALUES (20879, 5221, '6', false);
INSERT INTO public.options VALUES (20880, 5221, '4', false);
INSERT INTO public.options VALUES (20882, 5222, 'LIFO', false);
INSERT INTO public.options VALUES (20883, 5222, 'Random', false);
INSERT INTO public.options VALUES (20884, 5222, 'Priority', false);
INSERT INTO public.options VALUES (20886, 5223, 'Insert', false);
INSERT INTO public.options VALUES (20887, 5223, 'Peek', false);
INSERT INTO public.options VALUES (20888, 5223, 'Delete', false);
INSERT INTO public.options VALUES (20890, 5224, 'Middle', false);
INSERT INTO public.options VALUES (20891, 5224, 'Top', false);
INSERT INTO public.options VALUES (20892, 5224, 'Any', false);
INSERT INTO public.options VALUES (20894, 5225, 'Undo', false);
INSERT INTO public.options VALUES (20895, 5225, 'Sorting', false);
INSERT INTO public.options VALUES (20896, 5225, 'Graph', false);
INSERT INTO public.options VALUES (20898, 5226, 'Last', false);
INSERT INTO public.options VALUES (20899, 5226, 'Top', false);
INSERT INTO public.options VALUES (20900, 5226, 'Bottom', false);
INSERT INTO public.options VALUES (20902, 5227, 'Full', false);
INSERT INTO public.options VALUES (20903, 5227, 'Sorted', false);
INSERT INTO public.options VALUES (20904, 5227, 'Deleted', false);
INSERT INTO public.options VALUES (20906, 5228, 'Push full', false);
INSERT INTO public.options VALUES (20907, 5228, 'Peek', false);
INSERT INTO public.options VALUES (20908, 5228, 'Traverse', false);
INSERT INTO public.options VALUES (20910, 5229, 'Queue', false);
INSERT INTO public.options VALUES (20911, 5229, 'Graph', false);
INSERT INTO public.options VALUES (20912, 5229, 'Array', false);
INSERT INTO public.options VALUES (20914, 5230, 'Stack', false);
INSERT INTO public.options VALUES (20915, 5230, 'Tree', false);
INSERT INTO public.options VALUES (20916, 5230, 'Graph', false);
INSERT INTO public.options VALUES (20918, 5231, 'Delete', false);
INSERT INTO public.options VALUES (20919, 5231, 'View top', false);
INSERT INTO public.options VALUES (20920, 5231, 'Sort', false);
INSERT INTO public.options VALUES (20922, 5232, 'Non-linear DS', false);
INSERT INTO public.options VALUES (20923, 5232, 'Tree', false);
INSERT INTO public.options VALUES (20924, 5232, 'Graph', false);
INSERT INTO public.options VALUES (20926, 5233, 'Sorting', false);
INSERT INTO public.options VALUES (20927, 5233, 'Searching', false);
INSERT INTO public.options VALUES (20928, 5233, 'UI', false);
INSERT INTO public.options VALUES (20930, 5234, 'Static', false);
INSERT INTO public.options VALUES (20931, 5234, 'Heap', false);
INSERT INTO public.options VALUES (20932, 5234, 'Disk', false);
INSERT INTO public.options VALUES (20934, 5235, 'Infinite', false);
INSERT INTO public.options VALUES (20935, 5235, 'Dynamic', false);
INSERT INTO public.options VALUES (20936, 5235, 'None', false);
INSERT INTO public.options VALUES (20938, 5236, 'Queue', false);
INSERT INTO public.options VALUES (20939, 5236, 'Array', false);
INSERT INTO public.options VALUES (20940, 5236, 'Graph', false);
INSERT INTO public.options VALUES (20942, 5237, 'Linked List', false);
INSERT INTO public.options VALUES (20943, 5237, 'Both', false);
INSERT INTO public.options VALUES (20944, 5237, 'None', false);
INSERT INTO public.options VALUES (20946, 5238, 'Stack', false);
INSERT INTO public.options VALUES (20947, 5238, 'Queue', false);
INSERT INTO public.options VALUES (20948, 5238, 'Array', false);
INSERT INTO public.options VALUES (20950, 5239, 'Stack', false);
INSERT INTO public.options VALUES (20951, 5239, 'Tree', false);
INSERT INTO public.options VALUES (20952, 5239, 'Graph', false);
INSERT INTO public.options VALUES (20954, 5240, 'Not allowed', false);
INSERT INTO public.options VALUES (20955, 5240, 'Partial', false);
INSERT INTO public.options VALUES (20956, 5240, 'None', false);
INSERT INTO public.options VALUES (20958, 5241, 'Sequential', false);
INSERT INTO public.options VALUES (20959, 5241, 'Top only', false);
INSERT INTO public.options VALUES (20960, 5241, 'Bottom', false);
INSERT INTO public.options VALUES (20962, 5242, 'FIFO', false);
INSERT INTO public.options VALUES (20963, 5242, 'Random', false);
INSERT INTO public.options VALUES (20964, 5242, 'Priority', false);
INSERT INTO public.options VALUES (20966, 5243, 'Delete', false);
INSERT INTO public.options VALUES (20967, 5243, 'View', false);
INSERT INTO public.options VALUES (20968, 5243, 'Sort', false);
INSERT INTO public.options VALUES (20970, 5244, 'Rear', false);
INSERT INTO public.options VALUES (20971, 5244, 'Middle', false);
INSERT INTO public.options VALUES (20972, 5244, 'Any', false);
INSERT INTO public.options VALUES (20974, 5245, 'Call stack', false);
INSERT INTO public.options VALUES (20975, 5245, 'Ticket line', false);
INSERT INTO public.options VALUES (20976, 5245, 'Sorting', false);
INSERT INTO public.options VALUES (20978, 5246, 'Undo', false);
INSERT INTO public.options VALUES (20979, 5246, 'Recursion', false);
INSERT INTO public.options VALUES (20980, 5246, 'Parsing', false);
INSERT INTO public.options VALUES (20982, 5247, 'Empty', false);
INSERT INTO public.options VALUES (20983, 5247, 'Sorted', false);
INSERT INTO public.options VALUES (20984, 5247, 'Deleted', false);
INSERT INTO public.options VALUES (20986, 5248, 'Full', false);
INSERT INTO public.options VALUES (20987, 5248, 'Sorted', false);
INSERT INTO public.options VALUES (20988, 5248, 'Deleted', false);
INSERT INTO public.options VALUES (20990, 5249, 'Non-linear DS', false);
INSERT INTO public.options VALUES (20991, 5249, 'Tree', false);
INSERT INTO public.options VALUES (20992, 5249, 'Graph', false);
INSERT INTO public.options VALUES (20994, 5250, 'Speed', false);
INSERT INTO public.options VALUES (20995, 5250, 'Security', false);
INSERT INTO public.options VALUES (20996, 5250, 'UI', false);
INSERT INTO public.options VALUES (20998, 5251, 'Linked list', false);
INSERT INTO public.options VALUES (20999, 5251, 'Both', false);
INSERT INTO public.options VALUES (21000, 5251, 'None', false);
INSERT INTO public.options VALUES (21002, 5252, 'Last', false);
INSERT INTO public.options VALUES (21003, 5252, 'Middle', false);
INSERT INTO public.options VALUES (21004, 5252, 'None', false);
INSERT INTO public.options VALUES (21006, 5253, 'First', false);
INSERT INTO public.options VALUES (21007, 5253, 'Middle', false);
INSERT INTO public.options VALUES (21008, 5253, 'None', false);
INSERT INTO public.options VALUES (21010, 5254, 'Highest priority', false);
INSERT INTO public.options VALUES (21011, 5254, 'Random', false);
INSERT INTO public.options VALUES (21012, 5254, 'Last', false);
INSERT INTO public.options VALUES (21014, 5255, 'Not allowed', false);
INSERT INTO public.options VALUES (21015, 5255, 'Partial', false);
INSERT INTO public.options VALUES (21016, 5255, 'None', false);
INSERT INTO public.options VALUES (21018, 5256, 'No', false);
INSERT INTO public.options VALUES (21019, 5256, 'Sometimes', false);
INSERT INTO public.options VALUES (21020, 5256, 'Never', false);
INSERT INTO public.options VALUES (21022, 5257, 'Front', false);
INSERT INTO public.options VALUES (21023, 5257, 'Middle', false);
INSERT INTO public.options VALUES (21024, 5257, 'Any', false);
INSERT INTO public.options VALUES (21026, 5258, 'Rear', false);
INSERT INTO public.options VALUES (21027, 5258, 'Any', false);
INSERT INTO public.options VALUES (21028, 5258, 'Middle', false);
INSERT INTO public.options VALUES (21030, 5259, 'Stack', false);
INSERT INTO public.options VALUES (21031, 5259, 'Heap', false);
INSERT INTO public.options VALUES (21032, 5259, 'Tree', false);
INSERT INTO public.options VALUES (21034, 5260, 'Yes', false);
INSERT INTO public.options VALUES (21035, 5260, 'Same', false);
INSERT INTO public.options VALUES (21036, 5260, 'Depends', false);
INSERT INTO public.options VALUES (21038, 5261, 'Priority', false);
INSERT INTO public.options VALUES (21039, 5261, 'Random', false);
INSERT INTO public.options VALUES (21040, 5261, 'None', false);
INSERT INTO public.options VALUES (21042, 5262, 'Stack', false);
INSERT INTO public.options VALUES (21043, 5262, 'Queue', false);
INSERT INTO public.options VALUES (21044, 5262, 'Graph', false);
INSERT INTO public.options VALUES (21046, 5263, 'Stack', false);
INSERT INTO public.options VALUES (21047, 5263, 'Graph', false);
INSERT INTO public.options VALUES (21048, 5263, 'Tree', false);
INSERT INTO public.options VALUES (21050, 5264, 'Traversal', false);
INSERT INTO public.options VALUES (21051, 5264, 'Hashing', false);
INSERT INTO public.options VALUES (21052, 5264, 'Graph', false);
INSERT INTO public.options VALUES (21054, 5265, 'Unsorted', false);
INSERT INTO public.options VALUES (21055, 5265, 'Linked list', false);
INSERT INTO public.options VALUES (21056, 5265, 'Graph', false);
INSERT INTO public.options VALUES (21058, 5266, 'Set', false);
INSERT INTO public.options VALUES (21059, 5266, 'Array', false);
INSERT INTO public.options VALUES (21060, 5266, 'Stack', false);
INSERT INTO public.options VALUES (21062, 5267, 'Queue', false);
INSERT INTO public.options VALUES (21063, 5267, 'Both', false);
INSERT INTO public.options VALUES (21064, 5267, 'None', false);
INSERT INTO public.options VALUES (21066, 5268, 'Hashing', false);
INSERT INTO public.options VALUES (21067, 5268, 'Both', false);
INSERT INTO public.options VALUES (21068, 5268, 'None', false);
INSERT INTO public.options VALUES (21070, 5269, 'Loop', false);
INSERT INTO public.options VALUES (21071, 5269, 'Both', false);
INSERT INTO public.options VALUES (21072, 5269, 'None', false);
INSERT INTO public.options VALUES (21074, 5270, 'End', false);
INSERT INTO public.options VALUES (21075, 5270, 'Stop condition', false);
INSERT INTO public.options VALUES (21076, 5270, 'None', false);
INSERT INTO public.options VALUES (21078, 5271, 'O(n²)', false);
INSERT INTO public.options VALUES (21079, 5271, 'O(2^n)', false);
INSERT INTO public.options VALUES (21080, 5271, 'O(log n)', false);
INSERT INTO public.options VALUES (21082, 5272, 'Sorting', false);
INSERT INTO public.options VALUES (21083, 5272, 'Graph', false);
INSERT INTO public.options VALUES (21084, 5272, 'Tree', false);
INSERT INTO public.options VALUES (21086, 5273, 'Sorting', false);
INSERT INTO public.options VALUES (21087, 5273, 'Searching', false);
INSERT INTO public.options VALUES (21088, 5273, 'Deletion', false);
INSERT INTO public.options VALUES (21090, 5274, 'BFS', false);
INSERT INTO public.options VALUES (21091, 5274, 'Sorting', false);
INSERT INTO public.options VALUES (21092, 5274, 'Queue', false);
INSERT INTO public.options VALUES (21094, 5275, 'DFS', false);
INSERT INTO public.options VALUES (21095, 5275, 'Recursion', false);
INSERT INTO public.options VALUES (21096, 5275, 'Sorting', false);
INSERT INTO public.options VALUES (21098, 5276, 'Operations', false);
INSERT INTO public.options VALUES (21099, 5276, 'Memory', false);
INSERT INTO public.options VALUES (21100, 5276, 'UI', false);
INSERT INTO public.options VALUES (21102, 5277, 'Input size', false);
INSERT INTO public.options VALUES (21103, 5277, 'Output size', false);
INSERT INTO public.options VALUES (21104, 5277, 'Time', false);
INSERT INTO public.options VALUES (21106, 5278, 'Reading', false);
INSERT INTO public.options VALUES (21107, 5278, 'Watching', false);
INSERT INTO public.options VALUES (21108, 5278, 'Skipping', false);
INSERT INTO public.options VALUES (21110, 5279, 'Coding', false);
INSERT INTO public.options VALUES (21111, 5279, 'Confidence', false);
INSERT INTO public.options VALUES (21112, 5279, 'All', false);
INSERT INTO public.options VALUES (21114, 5280, 'Normal case', false);
INSERT INTO public.options VALUES (21115, 5280, 'Wrong input', false);
INSERT INTO public.options VALUES (21116, 5280, 'None', false);
INSERT INTO public.options VALUES (21118, 5281, 'Confused', false);
INSERT INTO public.options VALUES (21119, 5281, 'Slow', false);
INSERT INTO public.options VALUES (21120, 5281, 'None', false);
INSERT INTO public.options VALUES (21122, 5282, 'Number of operations vs input size', false);
INSERT INTO public.options VALUES (21123, 5282, 'CPU speed', false);
INSERT INTO public.options VALUES (21124, 5282, 'RAM size', false);
INSERT INTO public.options VALUES (21126, 5283, 'Input size', false);
INSERT INTO public.options VALUES (21127, 5283, 'Extra memory used', false);
INSERT INTO public.options VALUES (21128, 5283, 'Output size', false);
INSERT INTO public.options VALUES (21130, 5284, 'Big-Ω', false);
INSERT INTO public.options VALUES (21131, 5284, 'Big-Θ', false);
INSERT INTO public.options VALUES (21132, 5284, 'Little-o', false);
INSERT INTO public.options VALUES (21134, 5285, 'Big-Ω', false);
INSERT INTO public.options VALUES (21135, 5285, 'Big-Θ', false);
INSERT INTO public.options VALUES (21136, 5285, 'Little-o', false);
INSERT INTO public.options VALUES (21138, 5286, 'Big-Ω', false);
INSERT INTO public.options VALUES (21139, 5286, 'Big-Θ', false);
INSERT INTO public.options VALUES (21140, 5286, 'Little-o', false);
INSERT INTO public.options VALUES (21142, 5287, 'O(log n)', false);
INSERT INTO public.options VALUES (21143, 5287, 'O(n²)', false);
INSERT INTO public.options VALUES (21144, 5287, 'O(1)', false);
INSERT INTO public.options VALUES (21146, 5288, 'O(1)', false);
INSERT INTO public.options VALUES (21147, 5288, 'O(n)', false);
INSERT INTO public.options VALUES (21148, 5288, 'O(n log n)', false);
INSERT INTO public.options VALUES (21150, 5289, 'O(log n)', false);
INSERT INTO public.options VALUES (21151, 5289, 'O(1)', false);
INSERT INTO public.options VALUES (21152, 5289, 'O(n²)', false);
INSERT INTO public.options VALUES (21154, 5290, 'O(log n)', false);
INSERT INTO public.options VALUES (21155, 5290, 'O(n)', false);
INSERT INTO public.options VALUES (21156, 5290, 'O(n²)', false);
INSERT INTO public.options VALUES (21158, 5291, 'O(n log n)', false);
INSERT INTO public.options VALUES (21159, 5291, 'O(n²)', false);
INSERT INTO public.options VALUES (21160, 5291, 'O(2n)', false);
INSERT INTO public.options VALUES (21162, 5292, 'O(n)', false);
INSERT INTO public.options VALUES (21163, 5292, 'O(log n)', false);
INSERT INTO public.options VALUES (21164, 5292, 'O(n²)', false);
INSERT INTO public.options VALUES (21166, 5293, 'Worst case', false);
INSERT INTO public.options VALUES (21167, 5293, 'Big-O', false);
INSERT INTO public.options VALUES (21168, 5293, 'Average case', false);
INSERT INTO public.options VALUES (21170, 5294, 'O(log n)', false);
INSERT INTO public.options VALUES (21171, 5294, 'O(1)', false);
INSERT INTO public.options VALUES (21172, 5294, 'O(n²)', false);
INSERT INTO public.options VALUES (21174, 5295, 'O(n log n)', false);
INSERT INTO public.options VALUES (21175, 5295, 'O(n²)', false);
INSERT INTO public.options VALUES (21176, 5295, 'O(log n)', false);
INSERT INTO public.options VALUES (21178, 5296, 'O(n)', false);
INSERT INTO public.options VALUES (21179, 5296, 'O(log n)', false);
INSERT INTO public.options VALUES (21180, 5296, 'O(n²)', false);
INSERT INTO public.options VALUES (21182, 5297, 'To optimize algorithms', false);
INSERT INTO public.options VALUES (21183, 5297, 'To reduce UI', false);
INSERT INTO public.options VALUES (21184, 5297, 'To increase RAM', false);
INSERT INTO public.options VALUES (21186, 5298, 'Sorted array', false);
INSERT INTO public.options VALUES (21187, 5298, 'Graph', false);
INSERT INTO public.options VALUES (21188, 5298, 'Tree', false);
INSERT INTO public.options VALUES (21190, 5299, 'O(log n)', false);
INSERT INTO public.options VALUES (21191, 5299, 'O(n!)', false);
INSERT INTO public.options VALUES (21192, 5299, 'O(n/2)', false);
INSERT INTO public.options VALUES (21194, 5300, 'Average', false);
INSERT INTO public.options VALUES (21195, 5300, 'Worst', false);
INSERT INTO public.options VALUES (21196, 5300, 'Random', false);
INSERT INTO public.options VALUES (21198, 5301, 'Performance comparison', false);
INSERT INTO public.options VALUES (21199, 5301, 'Styling', false);
INSERT INTO public.options VALUES (21200, 5301, 'Animations', false);
INSERT INTO public.options VALUES (21202, 5302, 'To minimize dataset size', false);
INSERT INTO public.options VALUES (21203, 5302, 'To classify labeled data', false);
INSERT INTO public.options VALUES (21204, 5302, 'To compress information', false);
INSERT INTO public.options VALUES (21206, 5303, 'Dataset', false);
INSERT INTO public.options VALUES (21207, 5303, 'Compiler', false);
INSERT INTO public.options VALUES (21208, 5303, 'Network', false);
INSERT INTO public.options VALUES (21210, 5304, 'Programming language', false);
INSERT INTO public.options VALUES (21211, 5304, 'Training dataset', false);
INSERT INTO public.options VALUES (21212, 5304, 'Neural network', false);
INSERT INTO public.options VALUES (21214, 5305, 'Reward', false);
INSERT INTO public.options VALUES (21215, 5305, 'Action', false);
INSERT INTO public.options VALUES (21216, 5305, 'Policy', false);
INSERT INTO public.options VALUES (21218, 5306, 'Dataset', false);
INSERT INTO public.options VALUES (21219, 5306, 'Algorithm', false);
INSERT INTO public.options VALUES (21220, 5306, 'Reward', false);
INSERT INTO public.options VALUES (21222, 5307, 'Dataset', false);
INSERT INTO public.options VALUES (21223, 5307, 'Reward Function', false);
INSERT INTO public.options VALUES (21224, 5307, 'Transition Matrix', false);
INSERT INTO public.options VALUES (21226, 5308, 'Dataset', false);
INSERT INTO public.options VALUES (21227, 5308, 'Gradient', false);
INSERT INTO public.options VALUES (21228, 5308, 'Parameter', false);
INSERT INTO public.options VALUES (21230, 5309, 'Static rules', false);
INSERT INTO public.options VALUES (21231, 5309, 'Labeled datasets', false);
INSERT INTO public.options VALUES (21232, 5309, 'Compression', false);
INSERT INTO public.options VALUES (21234, 5310, 'Uses only labeled data', false);
INSERT INTO public.options VALUES (21235, 5310, 'Has no environment', false);
INSERT INTO public.options VALUES (21236, 5310, 'Uses no algorithms', false);
INSERT INTO public.options VALUES (21238, 5311, 'Dataset distribution', false);
INSERT INTO public.options VALUES (21239, 5311, 'Network design', false);
INSERT INTO public.options VALUES (21240, 5311, 'Sorting', false);
INSERT INTO public.options VALUES (21242, 5312, 'Dataset', false);
INSERT INTO public.options VALUES (21243, 5312, 'Gradient', false);
INSERT INTO public.options VALUES (21244, 5312, 'Compiler', false);
INSERT INTO public.options VALUES (21246, 5313, 'Dataset size', false);
INSERT INTO public.options VALUES (21247, 5313, 'State index', false);
INSERT INTO public.options VALUES (21248, 5313, 'Policy weight', false);
INSERT INTO public.options VALUES (21250, 5314, 'Alpha', false);
INSERT INTO public.options VALUES (21251, 5314, 'Beta', false);
INSERT INTO public.options VALUES (21252, 5314, 'Lambda', false);
INSERT INTO public.options VALUES (21254, 5315, 'Sorting', false);
INSERT INTO public.options VALUES (21255, 5315, 'Removing rewards', false);
INSERT INTO public.options VALUES (21256, 5315, 'Compression', false);
INSERT INTO public.options VALUES (21258, 5316, 'Exploration', false);
INSERT INTO public.options VALUES (21259, 5316, 'Clustering', false);
INSERT INTO public.options VALUES (21260, 5316, 'Sampling', false);
INSERT INTO public.options VALUES (21262, 5317, 'Sorting–Searching', false);
INSERT INTO public.options VALUES (21263, 5317, 'Data–Memory', false);
INSERT INTO public.options VALUES (21264, 5317, 'Speed–Compression', false);
INSERT INTO public.options VALUES (21266, 5318, 'Supervised Learning', false);
INSERT INTO public.options VALUES (21267, 5318, 'Unsupervised', false);
INSERT INTO public.options VALUES (21268, 5318, 'Data Mining', false);
INSERT INTO public.options VALUES (21270, 5319, 'File compression', false);
INSERT INTO public.options VALUES (21271, 5319, 'Database query', false);
INSERT INTO public.options VALUES (21272, 5319, 'Text editing', false);
INSERT INTO public.options VALUES (21274, 5320, 'Sorting', false);
INSERT INTO public.options VALUES (21275, 5320, 'Compression', false);
INSERT INTO public.options VALUES (21276, 5320, 'Removing states', false);
INSERT INTO public.options VALUES (21278, 5321, 'Dataset sorting', false);
INSERT INTO public.options VALUES (21279, 5321, 'Static rules', false);
INSERT INTO public.options VALUES (21280, 5321, 'Single action always', false);
INSERT INTO public.options VALUES (21282, 5322, 'Dataset', false);
INSERT INTO public.options VALUES (21283, 5322, 'Compiler', false);
INSERT INTO public.options VALUES (21284, 5322, 'Network', false);
INSERT INTO public.options VALUES (21286, 5323, 'The training dataset', false);
INSERT INTO public.options VALUES (21287, 5323, 'Programming language', false);
INSERT INTO public.options VALUES (21288, 5323, 'Neural network model', false);
INSERT INTO public.options VALUES (21290, 5324, 'Policy', false);
INSERT INTO public.options VALUES (21291, 5324, 'Reward', false);
INSERT INTO public.options VALUES (21292, 5324, 'Gradient', false);
INSERT INTO public.options VALUES (21294, 5325, 'Only dataset size', false);
INSERT INTO public.options VALUES (21295, 5325, 'Only neural network structure', false);
INSERT INTO public.options VALUES (21296, 5325, 'Only algorithm complexity', false);
INSERT INTO public.options VALUES (21298, 5326, 'Dataset', false);
INSERT INTO public.options VALUES (21299, 5326, 'Compiler', false);
INSERT INTO public.options VALUES (21300, 5326, 'Network Layer', false);
INSERT INTO public.options VALUES (21302, 5327, 'Dataset containing rewards', false);
INSERT INTO public.options VALUES (21303, 5327, 'Sorting algorithm', false);
INSERT INTO public.options VALUES (21304, 5327, 'Compression method', false);
INSERT INTO public.options VALUES (21306, 5328, 'Sorting function', false);
INSERT INTO public.options VALUES (21307, 5328, 'Compression function', false);
INSERT INTO public.options VALUES (21308, 5328, 'Dataset function', false);
INSERT INTO public.options VALUES (21310, 5329, 'Minimize dataset size', false);
INSERT INTO public.options VALUES (21311, 5329, 'Remove states', false);
INSERT INTO public.options VALUES (21312, 5329, 'Compress data', false);
INSERT INTO public.options VALUES (21314, 5330, 'Dataset', false);
INSERT INTO public.options VALUES (21315, 5330, 'Parameter', false);
INSERT INTO public.options VALUES (21316, 5330, 'Compiler', false);
INSERT INTO public.options VALUES (21318, 5331, 'Dataset size', false);
INSERT INTO public.options VALUES (21319, 5331, 'Learning dataset', false);
INSERT INTO public.options VALUES (21320, 5331, 'Memory size', false);
INSERT INTO public.options VALUES (21322, 5332, 'Dataset', false);
INSERT INTO public.options VALUES (21323, 5332, 'Gradient', false);
INSERT INTO public.options VALUES (21324, 5332, 'Compiler', false);
INSERT INTO public.options VALUES (21326, 5333, 'Dataset Function', false);
INSERT INTO public.options VALUES (21327, 5333, 'Sorting Function', false);
INSERT INTO public.options VALUES (21328, 5333, 'Compression Function', false);
INSERT INTO public.options VALUES (21330, 5334, 'Dataset Function', false);
INSERT INTO public.options VALUES (21331, 5334, 'Transition Function', false);
INSERT INTO public.options VALUES (21332, 5334, 'Compression Function', false);
INSERT INTO public.options VALUES (21334, 5335, 'Dataset Probability', false);
INSERT INTO public.options VALUES (21335, 5335, 'Compression Probability', false);
INSERT INTO public.options VALUES (21336, 5335, 'Sorting Probability', false);
INSERT INTO public.options VALUES (21338, 5336, 'Dataset Loader', false);
INSERT INTO public.options VALUES (21339, 5336, 'Compression Module', false);
INSERT INTO public.options VALUES (21340, 5336, 'Sorting Engine', false);
INSERT INTO public.options VALUES (21342, 5337, 'Sorting vs Searching', false);
INSERT INTO public.options VALUES (21343, 5337, 'Memory vs Speed', false);
INSERT INTO public.options VALUES (21344, 5337, 'Compression vs Storage', false);
INSERT INTO public.options VALUES (21346, 5338, 'Dataset Manager', false);
INSERT INTO public.options VALUES (21347, 5338, 'Compiler Engine', false);
INSERT INTO public.options VALUES (21348, 5338, 'Network Protocol', false);
INSERT INTO public.options VALUES (21350, 5339, 'Dataset', false);
INSERT INTO public.options VALUES (21351, 5339, 'Reward Function', false);
INSERT INTO public.options VALUES (21352, 5339, 'Compiler', false);
INSERT INTO public.options VALUES (21354, 5340, 'Static rule-based learning', false);
INSERT INTO public.options VALUES (21355, 5340, 'Dataset memorization', false);
INSERT INTO public.options VALUES (21356, 5340, 'Sorting learning', false);
INSERT INTO public.options VALUES (21358, 5341, 'Dataset is sorted repeatedly', false);
INSERT INTO public.options VALUES (21359, 5341, 'Neural network processes images only', false);
INSERT INTO public.options VALUES (21360, 5341, 'Static rule applied to all problems', false);
INSERT INTO public.options VALUES (21362, 5342, 'Future depends on all past states', false);
INSERT INTO public.options VALUES (21363, 5342, 'Future depends only on reward', false);
INSERT INTO public.options VALUES (21364, 5342, 'Future depends on dataset size', false);
INSERT INTO public.options VALUES (21366, 5343, 'Actions', false);
INSERT INTO public.options VALUES (21367, 5343, 'Rewards', false);
INSERT INTO public.options VALUES (21368, 5343, 'Compiler', false);
INSERT INTO public.options VALUES (21370, 5344, 'Number of datasets', false);
INSERT INTO public.options VALUES (21371, 5344, 'List of algorithms', false);
INSERT INTO public.options VALUES (21372, 5344, 'Number of rewards', false);
INSERT INTO public.options VALUES (21374, 5345, 'Dataset count', false);
INSERT INTO public.options VALUES (21375, 5345, 'Memory size', false);
INSERT INTO public.options VALUES (21376, 5345, 'Compiler instructions', false);
INSERT INTO public.options VALUES (21378, 5346, 'Sorting Function', false);
INSERT INTO public.options VALUES (21379, 5346, 'Compression Function', false);
INSERT INTO public.options VALUES (21380, 5346, 'Dataset Function', false);
INSERT INTO public.options VALUES (21382, 5347, 'Sort dataset', false);
INSERT INTO public.options VALUES (21383, 5347, 'Compress information', false);
INSERT INTO public.options VALUES (21384, 5347, 'Remove states', false);
INSERT INTO public.options VALUES (21386, 5348, 'Minimize dataset', false);
INSERT INTO public.options VALUES (21387, 5348, 'Compress rewards', false);
INSERT INTO public.options VALUES (21388, 5348, 'Eliminate states', false);
INSERT INTO public.options VALUES (21390, 5349, 'Dataset', false);
INSERT INTO public.options VALUES (21391, 5349, 'Transition Matrix', false);
INSERT INTO public.options VALUES (21392, 5349, 'Gradient', false);
INSERT INTO public.options VALUES (21394, 5350, 'R(s,a)', false);
INSERT INTO public.options VALUES (21395, 5350, 'V(s)', false);
INSERT INTO public.options VALUES (21396, 5350, 'Q(s,a)', false);
INSERT INTO public.options VALUES (21398, 5351, 'Dataset size', false);
INSERT INTO public.options VALUES (21399, 5351, 'Transition count', false);
INSERT INTO public.options VALUES (21400, 5351, 'Policy weight', false);
INSERT INTO public.options VALUES (21402, 5352, 'Alpha', false);
INSERT INTO public.options VALUES (21403, 5352, 'Beta', false);
INSERT INTO public.options VALUES (21404, 5352, 'Lambda', false);
INSERT INTO public.options VALUES (21406, 5353, 'Dataset', false);
INSERT INTO public.options VALUES (21407, 5353, 'Parameter', false);
INSERT INTO public.options VALUES (21408, 5353, 'Compiler', false);
INSERT INTO public.options VALUES (21410, 5354, 'Reward Property', false);
INSERT INTO public.options VALUES (21411, 5354, 'Dataset Property', false);
INSERT INTO public.options VALUES (21412, 5354, 'Policy Property', false);
INSERT INTO public.options VALUES (21414, 5355, 'Linear Regression', false);
INSERT INTO public.options VALUES (21415, 5355, 'Decision Tree', false);
INSERT INTO public.options VALUES (21416, 5355, 'Clustering', false);
INSERT INTO public.options VALUES (21418, 5356, 'Static sorting', false);
INSERT INTO public.options VALUES (21419, 5356, 'Arithmetic calculation', false);
INSERT INTO public.options VALUES (21420, 5356, 'File compression', false);
INSERT INTO public.options VALUES (21422, 5357, 'States remove rewards', false);
INSERT INTO public.options VALUES (21423, 5357, 'Rewards remove actions', false);
INSERT INTO public.options VALUES (21424, 5357, 'Actions remove states', false);
INSERT INTO public.options VALUES (21426, 5358, 'Sorting numbers', false);
INSERT INTO public.options VALUES (21427, 5358, 'Compressing images', false);
INSERT INTO public.options VALUES (21428, 5358, 'Encrypting files', false);
INSERT INTO public.options VALUES (21430, 5359, 'Dataset Probability', false);
INSERT INTO public.options VALUES (21431, 5359, 'Sorting Probability', false);
INSERT INTO public.options VALUES (21432, 5359, 'Compression Probability', false);
INSERT INTO public.options VALUES (21434, 5360, 'Dataset Function', false);
INSERT INTO public.options VALUES (21435, 5360, 'Compression Function', false);
INSERT INTO public.options VALUES (21436, 5360, 'Sorting Function', false);
INSERT INTO public.options VALUES (21438, 5361, 'Method for sorting data', false);
INSERT INTO public.options VALUES (21439, 5361, 'Dataset compression technique', false);
INSERT INTO public.options VALUES (21440, 5361, 'Rule for removing states', false);
INSERT INTO public.options VALUES (21442, 5362, 'Immediate reward only', false);
INSERT INTO public.options VALUES (21443, 5362, 'Dataset size', false);
INSERT INTO public.options VALUES (21444, 5362, 'Number of actions', false);
INSERT INTO public.options VALUES (21446, 5363, 'Q(s,a)', false);
INSERT INTO public.options VALUES (21447, 5363, 'P(s,a)', false);
INSERT INTO public.options VALUES (21448, 5363, 'R(s)', false);
INSERT INTO public.options VALUES (21450, 5364, 'Only actions', false);
INSERT INTO public.options VALUES (21451, 5364, 'Dataset quality', false);
INSERT INTO public.options VALUES (21452, 5364, 'Network performance', false);
INSERT INTO public.options VALUES (21454, 5365, 'Dataset format', false);
INSERT INTO public.options VALUES (21455, 5365, 'Sorting method', false);
INSERT INTO public.options VALUES (21456, 5365, 'Compiler design', false);
INSERT INTO public.options VALUES (21458, 5366, 'Qπ(s,a)', false);
INSERT INTO public.options VALUES (21459, 5366, 'P(s,a)', false);
INSERT INTO public.options VALUES (21460, 5366, 'R(s)', false);
INSERT INTO public.options VALUES (21462, 5367, 'Compressing datasets', false);
INSERT INTO public.options VALUES (21463, 5367, 'Removing states', false);
INSERT INTO public.options VALUES (21464, 5367, 'Sorting actions', false);
INSERT INTO public.options VALUES (21466, 5368, 'Dataset Function', false);
INSERT INTO public.options VALUES (21467, 5368, 'Sorting Function', false);
INSERT INTO public.options VALUES (21468, 5368, 'Compression Function', false);
INSERT INTO public.options VALUES (21470, 5369, 'Dataset training', false);
INSERT INTO public.options VALUES (21471, 5369, 'Image compression', false);
INSERT INTO public.options VALUES (21472, 5369, 'Binary search', false);
INSERT INTO public.options VALUES (21474, 5370, 'Immediate reward only', false);
INSERT INTO public.options VALUES (21475, 5370, 'Dataset average', false);
INSERT INTO public.options VALUES (21476, 5370, 'Sorting complexity', false);
INSERT INTO public.options VALUES (21478, 5371, 'Dataset storage', false);
INSERT INTO public.options VALUES (21479, 5371, 'Sorting speed', false);
INSERT INTO public.options VALUES (21480, 5371, 'Network bandwidth', false);
INSERT INTO public.options VALUES (21482, 5372, 'Sorting algorithms', false);
INSERT INTO public.options VALUES (21483, 5372, 'Compression algorithms', false);
INSERT INTO public.options VALUES (21484, 5372, 'Encryption methods', false);
INSERT INTO public.options VALUES (21486, 5373, 'Larger dataset', false);
INSERT INTO public.options VALUES (21487, 5373, 'Higher memory usage', false);
INSERT INTO public.options VALUES (21488, 5373, 'More actions available', false);
INSERT INTO public.options VALUES (21490, 5374, 'Each dataset', false);
INSERT INTO public.options VALUES (21491, 5374, 'Each compiler', false);
INSERT INTO public.options VALUES (21492, 5374, 'Each algorithm', false);
INSERT INTO public.options VALUES (21494, 5375, 'Remove rewards', false);
INSERT INTO public.options VALUES (21495, 5375, 'Compress data', false);
INSERT INTO public.options VALUES (21496, 5375, 'Sort inputs', false);
INSERT INTO public.options VALUES (21498, 5376, 'Dataset distribution', false);
INSERT INTO public.options VALUES (21499, 5376, 'Sorting mechanism', false);
INSERT INTO public.options VALUES (21500, 5376, 'Compression rate', false);
INSERT INTO public.options VALUES (21502, 5377, 'Dataset size increases', false);
INSERT INTO public.options VALUES (22992, 5749, 'Never', false);
INSERT INTO public.options VALUES (21503, 5377, 'Sorting improves', false);
INSERT INTO public.options VALUES (21504, 5377, 'Memory decreases', false);
INSERT INTO public.options VALUES (21506, 5378, 'Dataset format', false);
INSERT INTO public.options VALUES (21507, 5378, 'Network topology', false);
INSERT INTO public.options VALUES (21508, 5378, 'Sorting order', false);
INSERT INTO public.options VALUES (21510, 5379, 'File compression', false);
INSERT INTO public.options VALUES (21511, 5379, 'Static programming', false);
INSERT INTO public.options VALUES (21512, 5379, 'Sorting theory', false);
INSERT INTO public.options VALUES (21514, 5380, 'Dataset function', false);
INSERT INTO public.options VALUES (21515, 5380, 'Sorting function', false);
INSERT INTO public.options VALUES (21516, 5380, 'Compression function', false);
INSERT INTO public.options VALUES (21518, 5381, 'It removes actions', false);
INSERT INTO public.options VALUES (21519, 5381, 'It compresses rewards', false);
INSERT INTO public.options VALUES (21520, 5381, 'It sorts datasets', false);
INSERT INTO public.options VALUES (21522, 5382, 'Immediate reward only', false);
INSERT INTO public.options VALUES (21523, 5382, 'Dataset size', false);
INSERT INTO public.options VALUES (21524, 5382, 'Number of policies', false);
INSERT INTO public.options VALUES (21526, 5383, 'V(s)', false);
INSERT INTO public.options VALUES (21527, 5383, 'P(s,a)', false);
INSERT INTO public.options VALUES (21528, 5383, 'R(s)', false);
INSERT INTO public.options VALUES (21530, 5384, 'States only', false);
INSERT INTO public.options VALUES (21531, 5384, 'Datasets', false);
INSERT INTO public.options VALUES (21532, 5384, 'Algorithms', false);
INSERT INTO public.options VALUES (21534, 5385, 'Sorting datasets', false);
INSERT INTO public.options VALUES (21535, 5385, 'Compressing rewards', false);
INSERT INTO public.options VALUES (21536, 5385, 'Removing states', false);
INSERT INTO public.options VALUES (21538, 5386, 'Vπ(s)', false);
INSERT INTO public.options VALUES (21539, 5386, 'R(s)', false);
INSERT INTO public.options VALUES (21540, 5386, 'P(s,a)', false);
INSERT INTO public.options VALUES (21542, 5387, 'Linear Regression', false);
INSERT INTO public.options VALUES (21543, 5387, 'Merge Sort', false);
INSERT INTO public.options VALUES (21544, 5387, 'K-Means', false);
INSERT INTO public.options VALUES (21546, 5388, 'Larger dataset', false);
INSERT INTO public.options VALUES (21547, 5388, 'More memory', false);
INSERT INTO public.options VALUES (21548, 5388, 'Less reward', false);
INSERT INTO public.options VALUES (21550, 5389, 'Dataset compression', false);
INSERT INTO public.options VALUES (21551, 5389, 'Sorting speed', false);
INSERT INTO public.options VALUES (21552, 5389, 'Network training', false);
INSERT INTO public.options VALUES (21554, 5390, 'Dataset function', false);
INSERT INTO public.options VALUES (21555, 5390, 'Sorting function', false);
INSERT INTO public.options VALUES (21556, 5390, 'Compression function', false);
INSERT INTO public.options VALUES (21558, 5391, 'Dataset type', false);
INSERT INTO public.options VALUES (21559, 5391, 'Compiler version', false);
INSERT INTO public.options VALUES (21560, 5391, 'Sorting algorithm', false);
INSERT INTO public.options VALUES (21562, 5392, 'Dataset value', false);
INSERT INTO public.options VALUES (21563, 5392, 'Sorting value', false);
INSERT INTO public.options VALUES (21564, 5392, 'Compression value', false);
INSERT INTO public.options VALUES (21566, 5393, 'Dataset loading', false);
INSERT INTO public.options VALUES (21567, 5393, 'File compression', false);
INSERT INTO public.options VALUES (21568, 5393, 'Static programming', false);
INSERT INTO public.options VALUES (21570, 5394, 'Q(s,a) ignores states', false);
INSERT INTO public.options VALUES (21571, 5394, 'They are unrelated', false);
INSERT INTO public.options VALUES (21572, 5394, 'V(s) ignores rewards', false);
INSERT INTO public.options VALUES (21574, 5395, 'Binary Search', false);
INSERT INTO public.options VALUES (21575, 5395, 'Merge Sort', false);
INSERT INTO public.options VALUES (21576, 5395, 'Linear Regression', false);
INSERT INTO public.options VALUES (21578, 5396, 'Dataset shrinks', false);
INSERT INTO public.options VALUES (21579, 5396, 'Sorting improves', false);
INSERT INTO public.options VALUES (21580, 5396, 'Memory decreases', false);
INSERT INTO public.options VALUES (21582, 5397, 'Dataset function', false);
INSERT INTO public.options VALUES (21583, 5397, 'Compression function', false);
INSERT INTO public.options VALUES (21584, 5397, 'Sorting function', false);
INSERT INTO public.options VALUES (21586, 5398, 'Remove states', false);
INSERT INTO public.options VALUES (21587, 5398, 'Compress rewards', false);
INSERT INTO public.options VALUES (21588, 5398, 'Sort inputs', false);
INSERT INTO public.options VALUES (21590, 5399, 'Sorting rules', false);
INSERT INTO public.options VALUES (21591, 5399, 'Dataset copying', false);
INSERT INTO public.options VALUES (21592, 5399, 'Static programming', false);
INSERT INTO public.options VALUES (21594, 5400, 'Dataset selection', false);
INSERT INTO public.options VALUES (21595, 5400, 'Sorting order', false);
INSERT INTO public.options VALUES (21596, 5400, 'Compression ratio', false);
INSERT INTO public.options VALUES (21598, 5401, 'It removes rewards', false);
INSERT INTO public.options VALUES (21599, 5401, 'It compresses datasets', false);
INSERT INTO public.options VALUES (23225, 5808, 'TD(0)', true);
INSERT INTO public.options VALUES (21600, 5401, 'It sorts environment states', false);
INSERT INTO public.options VALUES (21602, 5402, 'Sorting datasets', false);
INSERT INTO public.options VALUES (21603, 5402, 'Compressing rewards', false);
INSERT INTO public.options VALUES (21604, 5402, 'Removing states', false);
INSERT INTO public.options VALUES (21606, 5403, 'Dataset size', false);
INSERT INTO public.options VALUES (21607, 5403, 'Neural network parameters', false);
INSERT INTO public.options VALUES (21608, 5403, 'Compiler instructions', false);
INSERT INTO public.options VALUES (21610, 5404, 'Alan Turing', false);
INSERT INTO public.options VALUES (21611, 5404, 'John McCarthy', false);
INSERT INTO public.options VALUES (21612, 5404, 'Geoffrey Hinton', false);
INSERT INTO public.options VALUES (21614, 5405, 'Dataset size + memory', false);
INSERT INTO public.options VALUES (21615, 5405, 'Policy + algorithm', false);
INSERT INTO public.options VALUES (21616, 5405, 'Sorting + searching', false);
INSERT INTO public.options VALUES (21618, 5406, 'Data compression', false);
INSERT INTO public.options VALUES (21619, 5406, 'Static programming', false);
INSERT INTO public.options VALUES (21620, 5406, 'Sorting property', false);
INSERT INTO public.options VALUES (21622, 5407, 'Dataset distribution', false);
INSERT INTO public.options VALUES (21623, 5407, 'Network weights', false);
INSERT INTO public.options VALUES (21624, 5407, 'Compiler rules', false);
INSERT INTO public.options VALUES (21626, 5408, 'Linear Equation', false);
INSERT INTO public.options VALUES (21627, 5408, 'Sorting Equation', false);
INSERT INTO public.options VALUES (21628, 5408, 'Compression Equation', false);
INSERT INTO public.options VALUES (21630, 5409, 'Dataset distribution', false);
INSERT INTO public.options VALUES (21631, 5409, 'Sorting probability', false);
INSERT INTO public.options VALUES (21632, 5409, 'Compression probability', false);
INSERT INTO public.options VALUES (21634, 5410, 'Dataset compression', false);
INSERT INTO public.options VALUES (21635, 5410, 'Static memory', false);
INSERT INTO public.options VALUES (21636, 5410, 'Sorting algorithm', false);
INSERT INTO public.options VALUES (21638, 5411, 'Sorting algorithms', false);
INSERT INTO public.options VALUES (21639, 5411, 'Clustering algorithms', false);
INSERT INTO public.options VALUES (21640, 5411, 'Encryption algorithms', false);
INSERT INTO public.options VALUES (21642, 5412, 'Linear Regression', false);
INSERT INTO public.options VALUES (21643, 5412, 'Decision Tree', false);
INSERT INTO public.options VALUES (21644, 5412, 'Clustering', false);
INSERT INTO public.options VALUES (21646, 5413, 'Sorting complexity', false);
INSERT INTO public.options VALUES (21647, 5413, 'Dataset memory', false);
INSERT INTO public.options VALUES (21648, 5413, 'Compression rate', false);
INSERT INTO public.options VALUES (21650, 5414, 'Dataset size', false);
INSERT INTO public.options VALUES (21651, 5414, 'State index', false);
INSERT INTO public.options VALUES (21652, 5414, 'Policy parameter', false);
INSERT INTO public.options VALUES (21654, 5415, 'Alpha', false);
INSERT INTO public.options VALUES (21655, 5415, 'Beta', false);
INSERT INTO public.options VALUES (21656, 5415, 'Lambda', false);
INSERT INTO public.options VALUES (21658, 5416, 'Sorting principle', false);
INSERT INTO public.options VALUES (21659, 5416, 'Compression principle', false);
INSERT INTO public.options VALUES (21660, 5416, 'Dataset principle', false);
INSERT INTO public.options VALUES (21662, 5417, 'Optimal policy already known', false);
INSERT INTO public.options VALUES (21663, 5417, 'Dataset unavailable', false);
INSERT INTO public.options VALUES (21664, 5417, 'Rewards removed', false);
INSERT INTO public.options VALUES (21666, 5418, 'Dataset size', false);
INSERT INTO public.options VALUES (21667, 5418, 'Sorting order', false);
INSERT INTO public.options VALUES (21668, 5418, 'Compression ratio', false);
INSERT INTO public.options VALUES (21670, 5419, 'Dataset duplication', false);
INSERT INTO public.options VALUES (21671, 5419, 'Compression rules', false);
INSERT INTO public.options VALUES (21672, 5419, 'Sorting steps', false);
INSERT INTO public.options VALUES (21674, 5420, 'Sort datasets', false);
INSERT INTO public.options VALUES (21675, 5420, 'Compress memory', false);
INSERT INTO public.options VALUES (21676, 5420, 'Remove actions', false);
INSERT INTO public.options VALUES (21678, 5421, 'Dataset compression rule', false);
INSERT INTO public.options VALUES (21679, 5421, 'Sorting mechanism', false);
INSERT INTO public.options VALUES (21680, 5421, 'State removal technique', false);
INSERT INTO public.options VALUES (21682, 5422, 'Minimum dataset size', false);
INSERT INTO public.options VALUES (21683, 5422, 'Maximum memory usage', false);
INSERT INTO public.options VALUES (21684, 5422, 'Static decision rule', false);
INSERT INTO public.options VALUES (21686, 5423, 'V(s)', false);
INSERT INTO public.options VALUES (21687, 5423, 'Q(s,a)', false);
INSERT INTO public.options VALUES (21688, 5423, 'P(s,a)', false);
INSERT INTO public.options VALUES (21690, 5424, 'Minimum reward', false);
INSERT INTO public.options VALUES (21691, 5424, 'Dataset average', false);
INSERT INTO public.options VALUES (21692, 5424, 'Number of actions', false);
INSERT INTO public.options VALUES (21694, 5425, 'V(s)', false);
INSERT INTO public.options VALUES (21695, 5425, 'Q(s,a)', false);
INSERT INTO public.options VALUES (21696, 5425, 'R(s)', false);
INSERT INTO public.options VALUES (21698, 5426, 'V(s)', false);
INSERT INTO public.options VALUES (21699, 5426, 'R(s)', false);
INSERT INTO public.options VALUES (21700, 5426, 'P(s,a)', false);
INSERT INTO public.options VALUES (21702, 5427, 'Dataset size', false);
INSERT INTO public.options VALUES (21703, 5427, 'Immediate reward only', false);
INSERT INTO public.options VALUES (21704, 5427, 'Policy count', false);
INSERT INTO public.options VALUES (21706, 5428, 'V(s)=minₐ Q(s,a)', false);
INSERT INTO public.options VALUES (21707, 5428, 'V(s)=R(s)', false);
INSERT INTO public.options VALUES (21708, 5428, 'V(s)=P(s,a)', false);
INSERT INTO public.options VALUES (21710, 5429, 'Sorting principle', false);
INSERT INTO public.options VALUES (21711, 5429, 'Compression principle', false);
INSERT INTO public.options VALUES (21712, 5429, 'Dataset rule', false);
INSERT INTO public.options VALUES (21714, 5430, 'Dataset filtering', false);
INSERT INTO public.options VALUES (21715, 5430, 'Sorting rule', false);
INSERT INTO public.options VALUES (21716, 5430, 'Compression step', false);
INSERT INTO public.options VALUES (21718, 5431, 'Dataset removal', false);
INSERT INTO public.options VALUES (23400, 5851, 'Dataset error', false);
INSERT INTO public.options VALUES (21719, 5431, 'Sorting improvement', false);
INSERT INTO public.options VALUES (21720, 5431, 'Memory reduction', false);
INSERT INTO public.options VALUES (21722, 5432, 'Merge Sort', false);
INSERT INTO public.options VALUES (21723, 5432, 'Binary Search', false);
INSERT INTO public.options VALUES (21724, 5432, 'K-Means', false);
INSERT INTO public.options VALUES (21726, 5433, 'Hashing', false);
INSERT INTO public.options VALUES (21727, 5433, 'Compression', false);
INSERT INTO public.options VALUES (21728, 5433, 'Encryption', false);
INSERT INTO public.options VALUES (21730, 5434, 'Linear Search', false);
INSERT INTO public.options VALUES (21731, 5434, 'Merge Sort', false);
INSERT INTO public.options VALUES (21732, 5434, 'Linear Regression', false);
INSERT INTO public.options VALUES (21734, 5435, 'Policies remove value functions', false);
INSERT INTO public.options VALUES (21735, 5435, 'They are unrelated', false);
INSERT INTO public.options VALUES (21736, 5435, 'Policies compress rewards', false);
INSERT INTO public.options VALUES (21738, 5436, 'Sorting principle', false);
INSERT INTO public.options VALUES (21739, 5436, 'Dataset principle', false);
INSERT INTO public.options VALUES (21740, 5436, 'Compression principle', false);
INSERT INTO public.options VALUES (21742, 5437, 'Smallest dataset', false);
INSERT INTO public.options VALUES (21743, 5437, 'Lowest memory', false);
INSERT INTO public.options VALUES (21744, 5437, 'Least actions', false);
INSERT INTO public.options VALUES (21746, 5438, 'Binary Search', false);
INSERT INTO public.options VALUES (21747, 5438, 'Sorting', false);
INSERT INTO public.options VALUES (21748, 5438, 'Compression', false);
INSERT INTO public.options VALUES (21750, 5439, 'Dataset function', false);
INSERT INTO public.options VALUES (21751, 5439, 'Sorting function', false);
INSERT INTO public.options VALUES (21752, 5439, 'Compression function', false);
INSERT INTO public.options VALUES (21754, 5440, 'Dataset stops growing', false);
INSERT INTO public.options VALUES (21755, 5440, 'Sorting stops', false);
INSERT INTO public.options VALUES (21756, 5440, 'Rewards removed', false);
INSERT INTO public.options VALUES (21758, 5441, 'Agent sorts datasets', false);
INSERT INTO public.options VALUES (21759, 5441, 'Agent compresses memory', false);
INSERT INTO public.options VALUES (21760, 5441, 'Agent removes states', false);
INSERT INTO public.options VALUES (21762, 5442, 'Dataset size', false);
INSERT INTO public.options VALUES (21763, 5442, 'Number of actions', false);
INSERT INTO public.options VALUES (21764, 5442, 'Network structure', false);
INSERT INTO public.options VALUES (21766, 5443, 'V(s)', false);
INSERT INTO public.options VALUES (21767, 5443, 'Q(s,a)', false);
INSERT INTO public.options VALUES (21768, 5443, 'R(s)', false);
INSERT INTO public.options VALUES (21770, 5444, 'V(s)', false);
INSERT INTO public.options VALUES (21771, 5444, 'P(s,a)', false);
INSERT INTO public.options VALUES (21772, 5444, 'R(s,a)', false);
INSERT INTO public.options VALUES (21774, 5445, 'Minimization', false);
INSERT INTO public.options VALUES (21775, 5445, 'Averaging', false);
INSERT INTO public.options VALUES (21776, 5445, 'Random selection', false);
INSERT INTO public.options VALUES (21778, 5446, 'Dataset size', false);
INSERT INTO public.options VALUES (21779, 5446, 'Sorting complexity', false);
INSERT INTO public.options VALUES (21780, 5446, 'Memory usage', false);
INSERT INTO public.options VALUES (21782, 5447, 'Binary Search', false);
INSERT INTO public.options VALUES (21783, 5447, 'Merge Sort', false);
INSERT INTO public.options VALUES (21784, 5447, 'K-Means', false);
INSERT INTO public.options VALUES (21786, 5448, 'Linear Regression', false);
INSERT INTO public.options VALUES (21787, 5448, 'Decision Tree', false);
INSERT INTO public.options VALUES (21788, 5448, 'Clustering', false);
INSERT INTO public.options VALUES (21790, 5449, 'Dataset size', false);
INSERT INTO public.options VALUES (21791, 5449, 'Learning rate', false);
INSERT INTO public.options VALUES (21792, 5449, 'Memory capacity', false);
INSERT INTO public.options VALUES (21794, 5450, 'Alpha', false);
INSERT INTO public.options VALUES (21795, 5450, 'Beta', false);
INSERT INTO public.options VALUES (21796, 5450, 'Lambda', false);
INSERT INTO public.options VALUES (21798, 5451, 'Sorting Principle', false);
INSERT INTO public.options VALUES (21799, 5451, 'Dataset Principle', false);
INSERT INTO public.options VALUES (21800, 5451, 'Compression Principle', false);
INSERT INTO public.options VALUES (21802, 5452, 'Dataset format', false);
INSERT INTO public.options VALUES (21803, 5452, 'Sorting order', false);
INSERT INTO public.options VALUES (21804, 5452, 'Memory usage', false);
INSERT INTO public.options VALUES (21806, 5453, 'Dataset average', false);
INSERT INTO public.options VALUES (21807, 5453, 'Sorting speed', false);
INSERT INTO public.options VALUES (21808, 5453, 'Compression rate', false);
INSERT INTO public.options VALUES (21810, 5454, 'Binary Search', false);
INSERT INTO public.options VALUES (21811, 5454, 'Sorting Method', false);
INSERT INTO public.options VALUES (21812, 5454, 'Compression Method', false);
INSERT INTO public.options VALUES (21814, 5455, 'Decision Tree', false);
INSERT INTO public.options VALUES (21815, 5455, 'Linear Regression', false);
INSERT INTO public.options VALUES (21816, 5455, 'K-Means', false);
INSERT INTO public.options VALUES (21818, 5456, 'Datasets', false);
INSERT INTO public.options VALUES (21819, 5456, 'Sorting blocks', false);
INSERT INTO public.options VALUES (21820, 5456, 'Compression units', false);
INSERT INTO public.options VALUES (21822, 5457, 'Minimum reward', false);
INSERT INTO public.options VALUES (21823, 5457, 'Dataset size', false);
INSERT INTO public.options VALUES (21824, 5457, 'Random value', false);
INSERT INTO public.options VALUES (21826, 5458, 'Dataset function', false);
INSERT INTO public.options VALUES (21827, 5458, 'Sorting function', false);
INSERT INTO public.options VALUES (21828, 5458, 'Compression function', false);
INSERT INTO public.options VALUES (21830, 5459, 'Dataset compression', false);
INSERT INTO public.options VALUES (21831, 5459, 'Sorting order', false);
INSERT INTO public.options VALUES (21832, 5459, 'Memory reduction', false);
INSERT INTO public.options VALUES (21834, 5460, 'Dataset operator', false);
INSERT INTO public.options VALUES (21835, 5460, 'Sorting operator', false);
INSERT INTO public.options VALUES (21836, 5460, 'Compression operator', false);
INSERT INTO public.options VALUES (21838, 5461, 'Dataset compression rules', false);
INSERT INTO public.options VALUES (21839, 5461, 'Sorting algorithms', false);
INSERT INTO public.options VALUES (21840, 5461, 'State removal techniques', false);
INSERT INTO public.options VALUES (23813, 5955, 'Dynamic pricing', true);
INSERT INTO public.options VALUES (23825, 5958, 'Process optimization', true);
INSERT INTO public.options VALUES (23869, 5969, 'Other agents are learning simultaneously', true);
INSERT INTO public.options VALUES (23897, 5976, 'Many agents contribute to outcome', true);
INSERT INTO public.options VALUES (23905, 5978, 'Traffic management systems', true);
INSERT INTO public.options VALUES (23865, 5968, 'Non-stationarity', true);
INSERT INTO public.options VALUES (23889, 5974, 'Nash Equilibrium', true);
INSERT INTO public.options VALUES (23881, 5972, 'Robot swarm coordination', true);
INSERT INTO public.options VALUES (23873, 5970, 'Centralized training', true);
INSERT INTO public.options VALUES (23817, 5956, 'Adaptive learning paths', true);
INSERT INTO public.options VALUES (23853, 5965, 'Maximize joint reward', true);
INSERT INTO public.options VALUES (23877, 5971, 'Agents act independently during deployment', true);
INSERT INTO public.options VALUES (23837, 5961, 'Using reward-driven learning for optimal decision making in real-world systems', true);
INSERT INTO public.options VALUES (23901, 5977, 'Centralized critic', true);
INSERT INTO public.options VALUES (23917, 5981, 'Learning optimal behavior in environments with multiple interacting agents', true);
INSERT INTO public.options VALUES (23821, 5957, 'Autonomous flight control', true);
INSERT INTO public.options VALUES (20797, 5201, 'Binary search', true);
INSERT INTO public.options VALUES (22929, 5734, 'Neural networks', true);
INSERT INTO public.options VALUES (20833, 5210, '1', true);
INSERT INTO public.options VALUES (22201, 5552, 'Value functions', true);
INSERT INTO public.options VALUES (23625, 5908, 'Gradient descent', true);
INSERT INTO public.options VALUES (20409, 5104, 'A hardware device', true);
INSERT INTO public.options VALUES (23861, 5967, 'Game theory', true);
INSERT INTO public.options VALUES (21842, 5462, 'No reward signal', false);
INSERT INTO public.options VALUES (21843, 5462, 'No policy', false);
INSERT INTO public.options VALUES (21844, 5462, 'No states', false);
INSERT INTO public.options VALUES (21846, 5463, 'Sorting datasets', false);
INSERT INTO public.options VALUES (21847, 5463, 'Compressing data', false);
INSERT INTO public.options VALUES (21848, 5463, 'Training neural networks', false);
INSERT INTO public.options VALUES (21850, 5464, 'Binary Search and Merge Sort', false);
INSERT INTO public.options VALUES (21851, 5464, 'Regression and Classification', false);
INSERT INTO public.options VALUES (21852, 5464, 'Encryption and Compression', false);
INSERT INTO public.options VALUES (21854, 5465, 'Sorting rules', false);
INSERT INTO public.options VALUES (21855, 5465, 'Dataset size', false);
INSERT INTO public.options VALUES (21856, 5465, 'Compiler instructions', false);
INSERT INTO public.options VALUES (21858, 5466, 'Single calculation', false);
INSERT INTO public.options VALUES (21859, 5466, 'Random guessing', false);
INSERT INTO public.options VALUES (21860, 5466, 'Dataset compression', false);
INSERT INTO public.options VALUES (21862, 5467, 'Infinite memory', false);
INSERT INTO public.options VALUES (21863, 5467, 'No rewards', false);
INSERT INTO public.options VALUES (21864, 5467, 'No environment', false);
INSERT INTO public.options VALUES (21866, 5468, 'Unknown', false);
INSERT INTO public.options VALUES (21867, 5468, 'Randomly generated', false);
INSERT INTO public.options VALUES (22773, 5695, 'Magnitude of Q-value update', true);
INSERT INTO public.options VALUES (21173, 5295, 'O(n)', true);
INSERT INTO public.options VALUES (20561, 5142, 'Collection of characters', true);
INSERT INTO public.options VALUES (21053, 5265, 'Sorted array', true);
INSERT INTO public.options VALUES (20469, 5119, 'Array', true);
INSERT INTO public.options VALUES (21693, 5425, 'V*(s)', true);
INSERT INTO public.options VALUES (20869, 5219, 'Yes', true);
INSERT INTO public.options VALUES (22145, 5538, 'Policy optimization', true);
INSERT INTO public.options VALUES (22221, 5557, 'Ensures global optimality via local optimality', true);
INSERT INTO public.options VALUES (22981, 5747, 'Training function approximators', true);
INSERT INTO public.options VALUES (20449, 5114, 'Array', true);
INSERT INTO public.options VALUES (21697, 5426, 'Q*(s,a)', true);
INSERT INTO public.options VALUES (22737, 5686, 'Temporal Difference learning', true);
INSERT INTO public.options VALUES (21969, 5494, 'Convergence', true);
INSERT INTO public.options VALUES (22009, 5504, 'State-value estimates', true);
INSERT INTO public.options VALUES (23345, 5838, 'Continuous control problems', true);
INSERT INTO public.options VALUES (20537, 5136, 'Array', true);
INSERT INTO public.options VALUES (20629, 5159, 'Split', true);
INSERT INTO public.options VALUES (22581, 5647, 'Value functions', true);
INSERT INTO public.options VALUES (20413, 5105, 'Tree', true);
INSERT INTO public.options VALUES (20565, 5143, 'Array of chars', true);
INSERT INTO public.options VALUES (22585, 5648, 'Bias-variance trade-off', true);
INSERT INTO public.options VALUES (21717, 5431, 'Value under optimal policy ≥ value under any policy', true);
INSERT INTO public.options VALUES (22117, 5531, 'Policy Iteration and Value Iteration', true);
INSERT INTO public.options VALUES (20717, 5181, 'Speed', true);
INSERT INTO public.options VALUES (21313, 5330, 'Return', true);
INSERT INTO public.options VALUES (22853, 5715, 'Q-values stabilize', true);
INSERT INTO public.options VALUES (20609, 5154, 'O(n)', true);
INSERT INTO public.options VALUES (21429, 5359, 'Transition Probability', true);
INSERT INTO public.options VALUES (22889, 5724, 'Neural Network', true);
INSERT INTO public.options VALUES (20857, 5216, '9', true);
INSERT INTO public.options VALUES (23029, 5759, 'Reducing prediction error', true);
INSERT INTO public.options VALUES (21105, 5278, 'Practice', true);
INSERT INTO public.options VALUES (21309, 5329, 'Maximize cumulative reward', true);
INSERT INTO public.options VALUES (21497, 5376, 'Expected return', true);
INSERT INTO public.options VALUES (23569, 5894, 'Markov Decision Process', true);
INSERT INTO public.options VALUES (23857, 5966, 'Adversarial setting', true);
INSERT INTO public.options VALUES (21793, 5450, 'Gamma', true);
INSERT INTO public.options VALUES (22185, 5548, 'Bellman Equation', true);
INSERT INTO public.options VALUES (22289, 5574, '{"text":"State is visited first time in episode","is_correct":true}', true);
INSERT INTO public.options VALUES (23157, 5791, 'Approximate state value', true);
INSERT INTO public.options VALUES (20889, 5224, 'Bottom', true);
INSERT INTO public.options VALUES (23561, 5892, 'Providing low-variance feedback', true);
INSERT INTO public.options VALUES (22597, 5651, 'After k transitions', true);
INSERT INTO public.options VALUES (21317, 5331, 'Discount factor', true);
INSERT INTO public.options VALUES (22749, 5689, 'It considers exploratory actions during learning', true);
INSERT INTO public.options VALUES (22121, 5532, 'Generated or simulated', true);
INSERT INTO public.options VALUES (21321, 5332, 'Episode', true);
INSERT INTO public.options VALUES (23609, 5904, 'Large or high-dimensional state spaces', true);
INSERT INTO public.options VALUES (20969, 5244, 'Front', true);
INSERT INTO public.options VALUES (23585, 5898, 'Instability due to function approximation', true);
INSERT INTO public.options VALUES (22493, 5625, 'Monte Carlo method', true);
INSERT INTO public.options VALUES (20505, 5128, 'Dynamic', true);
INSERT INTO public.options VALUES (21633, 5410, 'Discounted future reward', true);
INSERT INTO public.options VALUES (21661, 5417, 'Policy is known', true);
INSERT INTO public.options VALUES (20577, 5146, 'O(1)', true);
INSERT INTO public.options VALUES (22305, 5578, '{"text":"Value function","is_correct":true}', true);
INSERT INTO public.options VALUES (20589, 5149, 'Part of string', true);
INSERT INTO public.options VALUES (21217, 5306, 'A decision taken by the agent', true);
INSERT INTO public.options VALUES (21153, 5290, 'O(1)', true);
INSERT INTO public.options VALUES (21169, 5294, 'O(n)', true);
INSERT INTO public.options VALUES (21557, 5391, 'Policy followed after taking action', true);
INSERT INTO public.options VALUES (21325, 5333, 'Value Function', true);
INSERT INTO public.options VALUES (20453, 5115, 'Queue', true);
INSERT INTO public.options VALUES (22477, 5621, 'Learning value using full episode return without bootstrapping', true);
INSERT INTO public.options VALUES (22005, 5503, 'Bellman Optimality Equation', true);
INSERT INTO public.options VALUES (22725, 5683, 'On-policy TD control method', true);
INSERT INTO public.options VALUES (23581, 5897, 'Balancing bias and variance', true);
INSERT INTO public.options VALUES (21133, 5285, 'Big-O', true);
INSERT INTO public.options VALUES (21021, 5257, 'Rear', true);
INSERT INTO public.options VALUES (22421, 5607, 'Total discounted reward until terminal state', true);
INSERT INTO public.options VALUES (21545, 5388, 'Better expected long-term reward', true);
INSERT INTO public.options VALUES (21233, 5310, 'It learns from reward signals', true);
INSERT INTO public.options VALUES (21333, 5335, 'Transition Probability', true);
INSERT INTO public.options VALUES (23021, 5757, 'Differentiable loss function', true);
INSERT INTO public.options VALUES (22513, 5630, 'Sequential decision problems', true);
INSERT INTO public.options VALUES (22829, 5709, 'It learns optimal policy independent of behavior policy', true);
INSERT INTO public.options VALUES (21529, 5384, 'State–action pairs', true);
INSERT INTO public.options VALUES (21673, 5420, 'Update value estimates', true);
INSERT INTO public.options VALUES (20897, 5226, 'First', true);
INSERT INTO public.options VALUES (20509, 5129, 'Linear', true);
INSERT INTO public.options VALUES (20881, 5222, 'FIFO', true);
INSERT INTO public.options VALUES (23829, 5959, 'Personalized content recommendation', true);
INSERT INTO public.options VALUES (23005, 5753, 'Single sample', true);
INSERT INTO public.options VALUES (20761, 5192, 'Searching speed', true);
INSERT INTO public.options VALUES (22637, 5661, 'Methods using k-step returns to update value estimates', true);
INSERT INTO public.options VALUES (22337, 5586, 'After every transition', true);
INSERT INTO public.options VALUES (21841, 5462, 'Complete knowledge of environment model', true);
INSERT INTO public.options VALUES (22565, 5643, 'TD learning and Monte Carlo', true);
INSERT INTO public.options VALUES (22533, 5635, 'Discount factor and λ', true);
INSERT INTO public.options VALUES (20805, 5203, 'Prime', true);
INSERT INTO public.options VALUES (23605, 5903, 'Deep Neural Networks', true);
INSERT INTO public.options VALUES (23297, 5826, 'Deep Q Network (DQN)', true);
INSERT INTO public.options VALUES (21289, 5324, 'State', true);
INSERT INTO public.options VALUES (20961, 5242, 'LIFO', true);
INSERT INTO public.options VALUES (21097, 5276, 'Speed', true);
INSERT INTO public.options VALUES (22649, 5664, 'SARSA', true);
INSERT INTO public.options VALUES (22161, 5542, 'An optimal policy has optimal sub-policies', true);
INSERT INTO public.options VALUES (23277, 5821, 'Mechanism to speed learning by assigning credit to recent states', true);
INSERT INTO public.options VALUES (23197, 5801, 'Updating approximate value using TD error and gradient descent', true);
INSERT INTO public.options VALUES (23705, 5928, 'Action from online network and value from target network', true);
INSERT INTO public.options VALUES (21513, 5380, 'State-value function', true);
INSERT INTO public.options VALUES (23593, 5900, 'Stochastic policy distribution', true);
INSERT INTO public.options VALUES (22545, 5638, 'Policy evaluation and control', true);
INSERT INTO public.options VALUES (22241, 5562, '{"text":"Learning from complete episodes","is_correct":true}', true);
INSERT INTO public.options VALUES (23733, 5935, 'Online network', true);
INSERT INTO public.options VALUES (23441, 5862, 'Policy parameters', true);
INSERT INTO public.options VALUES (20781, 5197, 'Ascending', true);
INSERT INTO public.options VALUES (22973, 5745, 'Loss or error function', true);
INSERT INTO public.options VALUES (20865, 5218, '2', true);
INSERT INTO public.options VALUES (22349, 5589, 'Interaction with environment', true);
INSERT INTO public.options VALUES (22753, 5690, 'Reward + discounted Q value of next action', true);
INSERT INTO public.options VALUES (23201, 5802, 'Assign credit to recently visited states', true);
INSERT INTO public.options VALUES (23429, 5859, 'Future state transitions', true);
INSERT INTO public.options VALUES (21077, 5271, 'O(n)', true);
INSERT INTO public.options VALUES (22961, 5742, 'Optimize parameters of value or policy function', true);
INSERT INTO public.options VALUES (20513, 5130, 'Sorted array', true);
INSERT INTO public.options VALUES (20765, 5193, 'Merge', true);
INSERT INTO public.options VALUES (21901, 5477, 'Better actions using value estimates', true);
INSERT INTO public.options VALUES (23693, 5925, 'Action evaluation', true);
INSERT INTO public.options VALUES (20521, 5132, 'O(1)', true);
INSERT INTO public.options VALUES (22445, 5613, 'Value estimates stabilize', true);
INSERT INTO public.options VALUES (20861, 5217, '2', true);
INSERT INTO public.options VALUES (23697, 5926, 'Decoupling action selection and evaluation', true);
INSERT INTO public.options VALUES (23425, 5858, 'Boltzmann exploration', true);
INSERT INTO public.options VALUES (20749, 5189, 'O(n)', true);
INSERT INTO public.options VALUES (23413, 5855, 'Reinforcement Learning', true);
INSERT INTO public.options VALUES (20877, 5221, '12', true);
INSERT INTO public.options VALUES (23373, 5845, 'Choosing action with highest estimated reward', true);
INSERT INTO public.options VALUES (21705, 5428, 'V*(s)=maxₐ Q*(s,a)', true);
INSERT INTO public.options VALUES (22913, 5730, 'Gradient descent', true);
INSERT INTO public.options VALUES (23517, 5881, 'Directly optimizing policy using gradient of expected reward', true);
INSERT INTO public.options VALUES (21069, 5269, 'Hash map', true);
INSERT INTO public.options VALUES (23565, 5893, 'Bootstrapping', true);
INSERT INTO public.options VALUES (20593, 5150, 'compare()', true);
INSERT INTO public.options VALUES (20401, 5102, 'Data Structure Algorithm', true);
INSERT INTO public.options VALUES (20809, 5204, 'Least Common Multiple', true);
INSERT INTO public.options VALUES (23393, 5850, 'Maximize total reward', true);
INSERT INTO public.options VALUES (23241, 5812, 'Types of eligibility traces', true);
INSERT INTO public.options VALUES (20937, 5236, 'Stack', true);
INSERT INTO public.options VALUES (21425, 5358, 'Robot navigating maze', true);
INSERT INTO public.options VALUES (22697, 5676, 'SARSA', true);
INSERT INTO public.options VALUES (23229, 5809, 'Monte Carlo method', true);
INSERT INTO public.options VALUES (22437, 5611, 'Importance of future rewards', true);
INSERT INTO public.options VALUES (20873, 5220, '1', true);
INSERT INTO public.options VALUES (20533, 5135, '0', true);
INSERT INTO public.options VALUES (21989, 5499, 'Policy mapping states to better actions', true);
INSERT INTO public.options VALUES (23061, 5767, 'Episodic tasks', true);
INSERT INTO public.options VALUES (22281, 5572, '{"text":"Environment model","is_correct":true}', true);
INSERT INTO public.options VALUES (22225, 5558, 'Sequential decision-making problems', true);
INSERT INTO public.options VALUES (23109, 5779, 'Better value estimation', true);
INSERT INTO public.options VALUES (22001, 5502, 'Optimal value function', true);
INSERT INTO public.options VALUES (21777, 5446, 'Immediate reward plus discounted next state value', true);
INSERT INTO public.options VALUES (22085, 5523, 'A model of the environment', true);
INSERT INTO public.options VALUES (23529, 5884, 'Quality of actions using value function', true);
INSERT INTO public.options VALUES (20441, 5112, 'Undo operation', true);
INSERT INTO public.options VALUES (23893, 5975, 'Shared reward', true);
INSERT INTO public.options VALUES (23849, 5964, 'Shared environment', true);
INSERT INTO public.options VALUES (21617, 5406, 'Principle of optimality', true);
INSERT INTO public.options VALUES (22461, 5617, 'It provides unbiased return estimates', true);
INSERT INTO public.options VALUES (21665, 5418, 'Maximum possible state value', true);
INSERT INTO public.options VALUES (22801, 5702, 'Off-policy TD control algorithm', true);
INSERT INTO public.options VALUES (23845, 5963, 'Cooperate or compete', true);
INSERT INTO public.options VALUES (21753, 5440, 'Further improvement does not change policy', true);
INSERT INTO public.options VALUES (21641, 5412, 'Markov Decision Process', true);
INSERT INTO public.options VALUES (23717, 5931, 'Gradient descent', true);
INSERT INTO public.options VALUES (21885, 5473, 'All states', true);
INSERT INTO public.options VALUES (20945, 5238, 'Heap', true);
INSERT INTO public.options VALUES (23909, 5979, 'Adapt to other agents’ behaviors', true);
INSERT INTO public.options VALUES (23321, 5832, 'Reward signal', true);
INSERT INTO public.options VALUES (22125, 5533, 'Evaluating consequences before acting', true);
INSERT INTO public.options VALUES (23353, 5840, 'Learning hierarchical features', true);
INSERT INTO public.options VALUES (22837, 5711, 'Markov Decision Process', true);
INSERT INTO public.options VALUES (21337, 5336, 'Learning Algorithm', true);
INSERT INTO public.options VALUES (22205, 5553, 'Maximum cumulative reward', true);
INSERT INTO public.options VALUES (20901, 5227, 'Empty', true);
INSERT INTO public.options VALUES (23445, 5863, 'Parameterized function', true);
INSERT INTO public.options VALUES (23065, 5768, 'Complete episode experience', true);
INSERT INTO public.options VALUES (23913, 5980, 'State-action space', true);
INSERT INTO public.options VALUES (22965, 5743, 'Opposite to gradient of error', true);
INSERT INTO public.options VALUES (23293, 5825, 'Interacting with environment and updating network weights', true);
INSERT INTO public.options VALUES (21165, 5293, 'Best case', true);
INSERT INTO public.options VALUES (22093, 5525, 'Markov Decision Process', true);
INSERT INTO public.options VALUES (23289, 5824, 'Neural Network', true);
INSERT INTO public.options VALUES (20853, 5215, '10', true);
INSERT INTO public.options VALUES (22217, 5556, 'Optimal value of successor states', true);
INSERT INTO public.options VALUES (21521, 5382, 'Expected return from taking an action in a state', true);
INSERT INTO public.options VALUES (22053, 5515, 'Recursive Bellman updates', true);
INSERT INTO public.options VALUES (22273, 5570, '{"text":"Optimal policy","is_correct":true}', true);
INSERT INTO public.options VALUES (20689, 5174, 'Array is sorted', true);
INSERT INTO public.options VALUES (22785, 5698, 'Updating Q-values incrementally', true);
INSERT INTO public.options VALUES (23041, 5762, 'Full episode return', true);
INSERT INTO public.options VALUES (20677, 5171, 'O(1)', true);
INSERT INTO public.options VALUES (23209, 5804, 'Temporal Difference learning', true);
INSERT INTO public.options VALUES (23793, 5950, 'Dialogue optimization', true);
INSERT INTO public.options VALUES (23461, 5867, 'Policy Gradient Theorem', true);
INSERT INTO public.options VALUES (22045, 5513, 'Convergence to optimal value function', true);
INSERT INTO public.options VALUES (21033, 5260, 'No', true);
INSERT INTO public.options VALUES (23357, 5841, 'Using deep neural networks with RL to solve complex decision problems', true);
INSERT INTO public.options VALUES (22873, 5720, 'Robotics and game AI', true);
INSERT INTO public.options VALUES (21229, 5309, 'Trial and error interaction', true);
INSERT INTO public.options VALUES (21081, 5272, 'Subarray', true);
INSERT INTO public.options VALUES (21441, 5362, 'Expected cumulative reward from a state under a policy', true);
INSERT INTO public.options VALUES (20545, 5138, 'O(1)', true);
INSERT INTO public.options VALUES (20885, 5223, 'Remove', true);
INSERT INTO public.options VALUES (23741, 5937, 'Epsilon-greedy', true);
INSERT INTO public.options VALUES (23841, 5962, 'Multiple agents interacting in the same environment', true);
INSERT INTO public.options VALUES (22137, 5536, 'Agent learns from simulated trials', true);
INSERT INTO public.options VALUES (21889, 5474, 'Recursive decomposition', true);
INSERT INTO public.options VALUES (23737, 5936, 'Periodically', true);
INSERT INTO public.options VALUES (21485, 5373, 'Better long-term reward expectation', true);
INSERT INTO public.options VALUES (22097, 5526, 'Simulated experience', true);
INSERT INTO public.options VALUES (23181, 5797, 'Deep Reinforcement Learning', true);
INSERT INTO public.options VALUES (20585, 5148, 'char[]', true);
INSERT INTO public.options VALUES (20709, 5179, 'O(1)', true);
INSERT INTO public.options VALUES (22321, 5582, 'One-step bootstrapping', true);
INSERT INTO public.options VALUES (21093, 5275, 'BFS', true);
INSERT INTO public.options VALUES (21057, 5266, 'Loop', true);
INSERT INTO public.options VALUES (20657, 5166, 'O(n)', true);
INSERT INTO public.options VALUES (23613, 5905, 'Break correlation between consecutive samples', true);
INSERT INTO public.options VALUES (23833, 5960, 'Strategy optimization', true);
INSERT INTO public.options VALUES (23105, 5778, 'Actual return G', true);
INSERT INTO public.options VALUES (23185, 5798, 'Deep Q-Learning', true);
INSERT INTO public.options VALUES (22933, 5735, 'Generalizing experience', true);
INSERT INTO public.options VALUES (22233, 5560, 'Optimal solution contains optimal parts', true);
INSERT INTO public.options VALUES (21193, 5300, 'Best', true);
INSERT INTO public.options VALUES (20693, 5175, 'Sorted only', true);
INSERT INTO public.options VALUES (20997, 5251, 'Array', true);
INSERT INTO public.options VALUES (21953, 5490, 'Dynamic Programming method', true);
INSERT INTO public.options VALUES (23253, 5815, 'Recency and frequency of state visit', true);
INSERT INTO public.options VALUES (22673, 5670, 'Learning optimal policy while exploring', true);
INSERT INTO public.options VALUES (23525, 5883, 'Selecting actions based on policy', true);
INSERT INTO public.options VALUES (21381, 5347, 'Provide feedback about action quality', true);
INSERT INTO public.options VALUES (23101, 5777, 'Continuous state problems', true);
INSERT INTO public.options VALUES (21065, 5268, 'Sorting', true);
INSERT INTO public.options VALUES (21537, 5386, 'Qπ(s,a)', true);
INSERT INTO public.options VALUES (21305, 5328, 'State transition function', true);
INSERT INTO public.options VALUES (22237, 5561, 'Optimal strategies can be constructed from optimal sub-strategies', true);
INSERT INTO public.options VALUES (22229, 5559, 'Future decisions depend only on current optimal decisions', true);
INSERT INTO public.options VALUES (23629, 5909, 'Epsilon-greedy', true);
INSERT INTO public.options VALUES (21821, 5457, 'Maximum expected value over actions', true);
INSERT INTO public.options VALUES (22525, 5633, 'Monte Carlo methods', true);
INSERT INTO public.options VALUES (23405, 5853, 'Exploration', true);
INSERT INTO public.options VALUES (20493, 5125, 'O(n)', true);
INSERT INTO public.options VALUES (22717, 5681, 'On-policy learns about current policy, off-policy learns optimal policy while following another', true);
INSERT INTO public.options VALUES (20909, 5229, 'Recursion', true);
INSERT INTO public.options VALUES (21181, 5297, 'To write more code', true);
INSERT INTO public.options VALUES (20681, 5172, 'Arranging data', true);
INSERT INTO public.options VALUES (20433, 5110, 'Array', true);
INSERT INTO public.options VALUES (21925, 5483, 'Policy Evaluation and Policy Improvement', true);
INSERT INTO public.options VALUES (22905, 5728, 'Q(s,a) using parameters', true);
INSERT INTO public.options VALUES (22621, 5657, 'Policy evaluation and control', true);
INSERT INTO public.options VALUES (21293, 5325, 'Next state and received reward', true);
INSERT INTO public.options VALUES (22345, 5588, 'Markov Decision Process', true);
INSERT INTO public.options VALUES (22057, 5516, 'Best possible action', true);
INSERT INTO public.options VALUES (21645, 5413, 'Expected rewards for state–action pairs', true);
INSERT INTO public.options VALUES (21909, 5479, 'Planning problems', true);
INSERT INTO public.options VALUES (21553, 5390, 'Action-value function', true);
INSERT INTO public.options VALUES (23885, 5973, 'Improve coordination', true);
INSERT INTO public.options VALUES (23589, 5899, 'Neural networks', true);
INSERT INTO public.options VALUES (20845, 5213, '0,1', true);
INSERT INTO public.options VALUES (22849, 5714, 'Magnitude of Q-value update', true);
INSERT INTO public.options VALUES (21601, 5402, 'Recursive relationship between current and future values', true);
INSERT INTO public.options VALUES (20773, 5195, 'Adjacent elements', true);
INSERT INTO public.options VALUES (23761, 5942, 'Robotics and autonomous systems', true);
INSERT INTO public.options VALUES (22861, 5717, 'Updating Q-values incrementally', true);
INSERT INTO public.options VALUES (22377, 5596, 'Updating value estimates step-by-step', true);
INSERT INTO public.options VALUES (21249, 5314, 'Gamma', true);
INSERT INTO public.options VALUES (23369, 5844, 'Epsilon-greedy', true);
INSERT INTO public.options VALUES (20949, 5239, 'Queue', true);
INSERT INTO public.options VALUES (21809, 5454, 'Value Iteration', true);
INSERT INTO public.options VALUES (21868, 5468, 'Static dataset', false);
INSERT INTO public.options VALUES (21870, 5469, 'Sorting and searching', false);
INSERT INTO public.options VALUES (21871, 5469, 'Compression and encryption', false);
INSERT INTO public.options VALUES (21872, 5469, 'Sampling only', false);
INSERT INTO public.options VALUES (21874, 5470, 'Dataset removal', false);
INSERT INTO public.options VALUES (21875, 5470, 'Memory overflow', false);
INSERT INTO public.options VALUES (21876, 5470, 'Sorting completion', false);
INSERT INTO public.options VALUES (21878, 5471, 'Linear Regression', false);
INSERT INTO public.options VALUES (21879, 5471, 'Clustering', false);
INSERT INTO public.options VALUES (21880, 5471, 'Hashing', false);
INSERT INTO public.options VALUES (21882, 5472, 'Approximate compression', false);
INSERT INTO public.options VALUES (21883, 5472, 'Sorting results', false);
INSERT INTO public.options VALUES (21884, 5472, 'Random actions', false);
INSERT INTO public.options VALUES (21886, 5473, 'Single state', false);
INSERT INTO public.options VALUES (21887, 5473, 'Dataset entries', false);
INSERT INTO public.options VALUES (21888, 5473, 'Only rewards', false);
INSERT INTO public.options VALUES (21890, 5474, 'Dataset duplication', false);
INSERT INTO public.options VALUES (21891, 5474, 'Sorting partition', false);
INSERT INTO public.options VALUES (21892, 5474, 'Compression blocks', false);
INSERT INTO public.options VALUES (21894, 5475, 'Unknown', false);
INSERT INTO public.options VALUES (21895, 5475, 'Ignored', false);
INSERT INTO public.options VALUES (21896, 5475, 'Removed', false);
INSERT INTO public.options VALUES (21898, 5476, 'Dataset size', false);
INSERT INTO public.options VALUES (21899, 5476, 'Sorting complexity', false);
INSERT INTO public.options VALUES (21900, 5476, 'Memory usage', false);
INSERT INTO public.options VALUES (21902, 5477, 'Random dataset', false);
INSERT INTO public.options VALUES (21903, 5477, 'Sorting rules', false);
INSERT INTO public.options VALUES (21904, 5477, 'Compression rate', false);
INSERT INTO public.options VALUES (21906, 5478, 'Very cheap always', false);
INSERT INTO public.options VALUES (21907, 5478, 'Independent of state count', false);
INSERT INTO public.options VALUES (21908, 5478, 'Memory-free', false);
INSERT INTO public.options VALUES (21910, 5479, 'Sorting problems', false);
INSERT INTO public.options VALUES (21911, 5479, 'Encryption tasks', false);
INSERT INTO public.options VALUES (21912, 5479, 'Compression tasks', false);
INSERT INTO public.options VALUES (21914, 5480, 'Sorting equation', false);
INSERT INTO public.options VALUES (21915, 5480, 'Compression equation', false);
INSERT INTO public.options VALUES (21916, 5480, 'Dataset equation', false);
INSERT INTO public.options VALUES (21918, 5481, 'Dataset compression technique', false);
INSERT INTO public.options VALUES (21919, 5481, 'Sorting framework', false);
INSERT INTO public.options VALUES (21920, 5481, 'Static decision rule', false);
INSERT INTO public.options VALUES (21922, 5482, 'Dataset size', false);
INSERT INTO public.options VALUES (21923, 5482, 'Sorting order', false);
INSERT INTO public.options VALUES (21924, 5482, 'Compression rate', false);
INSERT INTO public.options VALUES (21926, 5483, 'Sorting and Searching', false);
INSERT INTO public.options VALUES (21927, 5483, 'Encoding and Decoding', false);
INSERT INTO public.options VALUES (21928, 5483, 'Sampling and Clustering', false);
INSERT INTO public.options VALUES (21930, 5484, 'Dataset average', false);
INSERT INTO public.options VALUES (21931, 5484, 'Sorting complexity', false);
INSERT INTO public.options VALUES (21932, 5484, 'Memory usage', false);
INSERT INTO public.options VALUES (21934, 5485, 'Dataset format', false);
INSERT INTO public.options VALUES (21935, 5485, 'Sorting rules', false);
INSERT INTO public.options VALUES (21936, 5485, 'Compression method', false);
INSERT INTO public.options VALUES (21938, 5486, 'Sorting and merging', false);
INSERT INTO public.options VALUES (21939, 5486, 'Encoding and decoding', false);
INSERT INTO public.options VALUES (21940, 5486, 'Compression and expansion', false);
INSERT INTO public.options VALUES (21942, 5487, 'Dataset size decreases', false);
INSERT INTO public.options VALUES (21943, 5487, 'Sorting finishes', false);
INSERT INTO public.options VALUES (21944, 5487, 'Rewards are removed', false);
INSERT INTO public.options VALUES (21946, 5488, 'Dataset stops growing', false);
INSERT INTO public.options VALUES (21947, 5488, 'Sorting stops', false);
INSERT INTO public.options VALUES (21948, 5488, 'Memory becomes full', false);
INSERT INTO public.options VALUES (21950, 5489, 'Dataset compression', false);
INSERT INTO public.options VALUES (21951, 5489, 'Sorting complexity', false);
INSERT INTO public.options VALUES (21952, 5489, 'Neural network weights', false);
INSERT INTO public.options VALUES (21954, 5490, 'Sorting algorithm', false);
INSERT INTO public.options VALUES (21955, 5490, 'Compression algorithm', false);
INSERT INTO public.options VALUES (21956, 5490, 'Regression method', false);
INSERT INTO public.options VALUES (21958, 5491, 'Sorting equation', false);
INSERT INTO public.options VALUES (21959, 5491, 'Dataset equation', false);
INSERT INTO public.options VALUES (21960, 5491, 'Compression equation', false);
INSERT INTO public.options VALUES (21962, 5492, 'Min operator', false);
INSERT INTO public.options VALUES (21963, 5492, 'Average operator', false);
INSERT INTO public.options VALUES (21964, 5492, 'Random operator', false);
INSERT INTO public.options VALUES (21966, 5493, 'Dataset removal', false);
INSERT INTO public.options VALUES (21967, 5493, 'Sorting completion', false);
INSERT INTO public.options VALUES (21968, 5493, 'Memory reduction', false);
INSERT INTO public.options VALUES (21970, 5494, 'Dataset deletion', false);
INSERT INTO public.options VALUES (21971, 5494, 'Sorting finish', false);
INSERT INTO public.options VALUES (21972, 5494, 'Reward removal', false);
INSERT INTO public.options VALUES (21974, 5495, 'Always very fast', false);
INSERT INTO public.options VALUES (21975, 5495, 'Independent of state size', false);
INSERT INTO public.options VALUES (21976, 5495, 'Memory-free', false);
INSERT INTO public.options VALUES (21978, 5496, 'Sorting datasets', false);
INSERT INTO public.options VALUES (21979, 5496, 'Compressing rewards', false);
INSERT INTO public.options VALUES (21980, 5496, 'Removing actions', false);
INSERT INTO public.options VALUES (21982, 5497, 'Sorting tasks', false);
INSERT INTO public.options VALUES (21983, 5497, 'Compression tasks', false);
INSERT INTO public.options VALUES (21984, 5497, 'Encryption tasks', false);
INSERT INTO public.options VALUES (21986, 5498, 'Dataset function', false);
INSERT INTO public.options VALUES (21987, 5498, 'Sorting function', false);
INSERT INTO public.options VALUES (21988, 5498, 'Compression function', false);
INSERT INTO public.options VALUES (21990, 5499, 'Dataset mapping', false);
INSERT INTO public.options VALUES (21991, 5499, 'Sorting mapping', false);
INSERT INTO public.options VALUES (21992, 5499, 'Compression mapping', false);
INSERT INTO public.options VALUES (21994, 5500, 'Linear Regression', false);
INSERT INTO public.options VALUES (21995, 5500, 'Clustering', false);
INSERT INTO public.options VALUES (21996, 5500, 'Hashing', false);
INSERT INTO public.options VALUES (21998, 5501, 'Dataset compression technique', false);
INSERT INTO public.options VALUES (21999, 5501, 'Sorting framework', false);
INSERT INTO public.options VALUES (22000, 5501, 'Static rule method', false);
INSERT INTO public.options VALUES (22002, 5502, 'Dataset size', false);
INSERT INTO public.options VALUES (22003, 5502, 'Sorting order', false);
INSERT INTO public.options VALUES (22004, 5502, 'Compression rate', false);
INSERT INTO public.options VALUES (22006, 5503, 'Sorting equation', false);
INSERT INTO public.options VALUES (22007, 5503, 'Dataset equation', false);
INSERT INTO public.options VALUES (22008, 5503, 'Compression equation', false);
INSERT INTO public.options VALUES (22010, 5504, 'Dataset entries', false);
INSERT INTO public.options VALUES (22011, 5504, 'Sorting rules', false);
INSERT INTO public.options VALUES (22012, 5504, 'Compiler instructions', false);
INSERT INTO public.options VALUES (22014, 5505, 'Sorting and searching', false);
INSERT INTO public.options VALUES (22015, 5505, 'Encoding and decoding', false);
INSERT INTO public.options VALUES (22016, 5505, 'Compression and expansion', false);
INSERT INTO public.options VALUES (22018, 5506, 'Min operator', false);
INSERT INTO public.options VALUES (22019, 5506, 'Average operator', false);
INSERT INTO public.options VALUES (22020, 5506, 'Random operator', false);
INSERT INTO public.options VALUES (22022, 5507, 'Dataset is removed', false);
INSERT INTO public.options VALUES (22023, 5507, 'Sorting finishes', false);
INSERT INTO public.options VALUES (22024, 5507, 'Memory becomes full', false);
INSERT INTO public.options VALUES (22026, 5508, 'Dataset compression', false);
INSERT INTO public.options VALUES (22027, 5508, 'Sorting complexity', false);
INSERT INTO public.options VALUES (22028, 5508, 'Neural network weights', false);
INSERT INTO public.options VALUES (22030, 5509, 'Sorting algorithm', false);
INSERT INTO public.options VALUES (22031, 5509, 'Compression algorithm', false);
INSERT INTO public.options VALUES (22032, 5509, 'Regression method', false);
INSERT INTO public.options VALUES (22034, 5510, 'Random selection', false);
INSERT INTO public.options VALUES (22035, 5510, 'Dataset sorting', false);
INSERT INTO public.options VALUES (22036, 5510, 'Compression step', false);
INSERT INTO public.options VALUES (22038, 5511, 'Single state', false);
INSERT INTO public.options VALUES (22039, 5511, 'Dataset entries', false);
INSERT INTO public.options VALUES (22040, 5511, 'Only rewards', false);
INSERT INTO public.options VALUES (22042, 5512, 'Linear Regression', false);
INSERT INTO public.options VALUES (22043, 5512, 'Clustering', false);
INSERT INTO public.options VALUES (22044, 5512, 'Hashing', false);
INSERT INTO public.options VALUES (22046, 5513, 'Dataset deletion', false);
INSERT INTO public.options VALUES (22047, 5513, 'Sorting completion', false);
INSERT INTO public.options VALUES (22048, 5513, 'Memory reduction', false);
INSERT INTO public.options VALUES (22050, 5514, 'Always very fast', false);
INSERT INTO public.options VALUES (22051, 5514, 'Independent of state size', false);
INSERT INTO public.options VALUES (22052, 5514, 'Memory-free', false);
INSERT INTO public.options VALUES (22054, 5515, 'Sorting partitions', false);
INSERT INTO public.options VALUES (22055, 5515, 'Dataset duplication', false);
INSERT INTO public.options VALUES (22056, 5515, 'Compression blocks', false);
INSERT INTO public.options VALUES (22058, 5516, 'Dataset format', false);
INSERT INTO public.options VALUES (22059, 5516, 'Sorting order', false);
INSERT INTO public.options VALUES (22060, 5516, 'Memory size', false);
INSERT INTO public.options VALUES (22062, 5517, 'Sorting datasets', false);
INSERT INTO public.options VALUES (22063, 5517, 'Compressing rewards', false);
INSERT INTO public.options VALUES (22064, 5517, 'Removing states', false);
INSERT INTO public.options VALUES (22066, 5518, 'Merge Sort', false);
INSERT INTO public.options VALUES (22067, 5518, 'Binary Search', false);
INSERT INTO public.options VALUES (22068, 5518, 'K-Means', false);
INSERT INTO public.options VALUES (22070, 5519, 'Sorting tasks', false);
INSERT INTO public.options VALUES (22071, 5519, 'Compression tasks', false);
INSERT INTO public.options VALUES (22072, 5519, 'Encryption tasks', false);
INSERT INTO public.options VALUES (22074, 5520, 'Random selection', false);
INSERT INTO public.options VALUES (22075, 5520, 'Dataset filtering', false);
INSERT INTO public.options VALUES (22076, 5520, 'Sorting rules', false);
INSERT INTO public.options VALUES (22078, 5521, 'Dataset compression technique', false);
INSERT INTO public.options VALUES (22079, 5521, 'Sorting framework', false);
INSERT INTO public.options VALUES (22080, 5521, 'Static decision rule', false);
INSERT INTO public.options VALUES (22082, 5522, 'Sorting datasets', false);
INSERT INTO public.options VALUES (22083, 5522, 'Compressing rewards', false);
INSERT INTO public.options VALUES (22084, 5522, 'Removing states', false);
INSERT INTO public.options VALUES (22086, 5523, 'Only dataset', false);
INSERT INTO public.options VALUES (22087, 5523, 'Only reward signal', false);
INSERT INTO public.options VALUES (22088, 5523, 'Only neural network', false);
INSERT INTO public.options VALUES (22090, 5524, 'Remove rewards', false);
INSERT INTO public.options VALUES (22091, 5524, 'Sort inputs', false);
INSERT INTO public.options VALUES (22092, 5524, 'Compress memory', false);
INSERT INTO public.options VALUES (22094, 5525, 'Linear Regression', false);
INSERT INTO public.options VALUES (22095, 5525, 'Decision Tree', false);
INSERT INTO public.options VALUES (22096, 5525, 'Clustering', false);
INSERT INTO public.options VALUES (22098, 5526, 'Dataset compression', false);
INSERT INTO public.options VALUES (22099, 5526, 'Sorting steps', false);
INSERT INTO public.options VALUES (22100, 5526, 'Encryption rules', false);
INSERT INTO public.options VALUES (22102, 5527, 'Sorting equations', false);
INSERT INTO public.options VALUES (22103, 5527, 'Compression equations', false);
INSERT INTO public.options VALUES (22104, 5527, 'Dataset equations', false);
INSERT INTO public.options VALUES (22106, 5528, 'Dataset size', false);
INSERT INTO public.options VALUES (22107, 5528, 'Memory usage always', false);
INSERT INTO public.options VALUES (22108, 5528, 'Sorting complexity', false);
INSERT INTO public.options VALUES (22110, 5529, 'Sorting algorithms', false);
INSERT INTO public.options VALUES (22111, 5529, 'Compression methods', false);
INSERT INTO public.options VALUES (22112, 5529, 'Clustering rules', false);
INSERT INTO public.options VALUES (22114, 5530, 'Dataset averages', false);
INSERT INTO public.options VALUES (22115, 5530, 'Sorting speed', false);
INSERT INTO public.options VALUES (22116, 5530, 'Network bandwidth', false);
INSERT INTO public.options VALUES (22118, 5531, 'Binary Search and Merge Sort', false);
INSERT INTO public.options VALUES (22119, 5531, 'Regression and Classification', false);
INSERT INTO public.options VALUES (22120, 5531, 'Hashing and Encoding', false);
INSERT INTO public.options VALUES (22122, 5532, 'Only real-time', false);
INSERT INTO public.options VALUES (22123, 5532, 'Dataset-based', false);
INSERT INTO public.options VALUES (22124, 5532, 'Random guessing', false);
INSERT INTO public.options VALUES (22126, 5533, 'Sorting datasets', false);
INSERT INTO public.options VALUES (22127, 5533, 'Compressing rewards', false);
INSERT INTO public.options VALUES (22128, 5533, 'Removing actions', false);
INSERT INTO public.options VALUES (22130, 5534, 'Sorting model', false);
INSERT INTO public.options VALUES (22131, 5534, 'Compression model', false);
INSERT INTO public.options VALUES (22132, 5534, 'Dataset model', false);
INSERT INTO public.options VALUES (22134, 5535, 'Only once', false);
INSERT INTO public.options VALUES (22135, 5535, 'Randomly', false);
INSERT INTO public.options VALUES (22136, 5535, 'Never', false);
INSERT INTO public.options VALUES (22138, 5536, 'Dataset becomes smaller', false);
INSERT INTO public.options VALUES (22139, 5536, 'Sorting becomes faster', false);
INSERT INTO public.options VALUES (22140, 5536, 'Memory becomes larger', false);
INSERT INTO public.options VALUES (22142, 5537, 'Sorting architecture', false);
INSERT INTO public.options VALUES (22143, 5537, 'Compression architecture', false);
INSERT INTO public.options VALUES (22144, 5537, 'Regression architecture', false);
INSERT INTO public.options VALUES (22146, 5538, 'Dataset formatting', false);
INSERT INTO public.options VALUES (22147, 5538, 'Sorting inputs', false);
INSERT INTO public.options VALUES (22148, 5538, 'Compression outputs', false);
INSERT INTO public.options VALUES (22150, 5539, 'Dataset compression', false);
INSERT INTO public.options VALUES (22151, 5539, 'Sorting order', false);
INSERT INTO public.options VALUES (22152, 5539, 'Network weights', false);
INSERT INTO public.options VALUES (22154, 5540, 'Dataset deletion', false);
INSERT INTO public.options VALUES (22155, 5540, 'Sorting finish', false);
INSERT INTO public.options VALUES (22156, 5540, 'Reward removal', false);
INSERT INTO public.options VALUES (22158, 5541, 'Sorting datasets', false);
INSERT INTO public.options VALUES (22159, 5541, 'Compressing memory', false);
INSERT INTO public.options VALUES (22160, 5541, 'Removing states', false);
INSERT INTO public.options VALUES (22162, 5542, 'Datasets must be sorted', false);
INSERT INTO public.options VALUES (22163, 5542, 'Rewards must be removed', false);
INSERT INTO public.options VALUES (22164, 5542, 'States must be compressed', false);
INSERT INTO public.options VALUES (22166, 5543, 'Alan Turing', false);
INSERT INTO public.options VALUES (22167, 5543, 'Andrew Ng', false);
INSERT INTO public.options VALUES (22168, 5543, 'Geoffrey Hinton', false);
INSERT INTO public.options VALUES (22170, 5544, 'Sorting Algorithms', false);
INSERT INTO public.options VALUES (22171, 5544, 'Compression Techniques', false);
INSERT INTO public.options VALUES (22172, 5544, 'Encryption Methods', false);
INSERT INTO public.options VALUES (22174, 5545, 'Random decisions', false);
INSERT INTO public.options VALUES (22175, 5545, 'Dataset sorting', false);
INSERT INTO public.options VALUES (22176, 5545, 'Memory compression', false);
INSERT INTO public.options VALUES (22178, 5546, 'Linear Regression', false);
INSERT INTO public.options VALUES (22179, 5546, 'Decision Tree', false);
INSERT INTO public.options VALUES (22180, 5546, 'Clustering', false);
INSERT INTO public.options VALUES (22182, 5547, 'Sorting large datasets', false);
INSERT INTO public.options VALUES (22183, 5547, 'Removing rewards', false);
INSERT INTO public.options VALUES (22184, 5547, 'Compressing data', false);
INSERT INTO public.options VALUES (22186, 5548, 'Sorting Equation', false);
INSERT INTO public.options VALUES (22187, 5548, 'Compression Equation', false);
INSERT INTO public.options VALUES (22188, 5548, 'Dataset Equation', false);
INSERT INTO public.options VALUES (22190, 5549, 'Dataset format', false);
INSERT INTO public.options VALUES (22191, 5549, 'Sorting order', false);
INSERT INTO public.options VALUES (22192, 5549, 'Memory size', false);
INSERT INTO public.options VALUES (22194, 5550, 'Becomes random', false);
INSERT INTO public.options VALUES (22195, 5550, 'Depends on dataset', false);
INSERT INTO public.options VALUES (22196, 5550, 'Removes rewards', false);
INSERT INTO public.options VALUES (22198, 5551, 'Merge Sort', false);
INSERT INTO public.options VALUES (22199, 5551, 'Binary Search', false);
INSERT INTO public.options VALUES (22200, 5551, 'K-Means', false);
INSERT INTO public.options VALUES (22202, 5552, 'Dataset averages', false);
INSERT INTO public.options VALUES (22203, 5552, 'Sorting complexity', false);
INSERT INTO public.options VALUES (22204, 5552, 'Memory usage', false);
INSERT INTO public.options VALUES (22206, 5553, 'Minimum dataset', false);
INSERT INTO public.options VALUES (22207, 5553, 'Sorted input', false);
INSERT INTO public.options VALUES (22208, 5553, 'Compressed output', false);
INSERT INTO public.options VALUES (22210, 5554, 'Dataset entries', false);
INSERT INTO public.options VALUES (22211, 5554, 'Memory always', false);
INSERT INTO public.options VALUES (22212, 5554, 'Sorting time', false);
INSERT INTO public.options VALUES (22214, 5555, 'Sorting Algorithm', false);
INSERT INTO public.options VALUES (22215, 5555, 'Compression Rule', false);
INSERT INTO public.options VALUES (22216, 5555, 'Dataset Index', false);
INSERT INTO public.options VALUES (22218, 5556, 'Dataset size', false);
INSERT INTO public.options VALUES (22219, 5556, 'Sorting order', false);
INSERT INTO public.options VALUES (22220, 5556, 'Network speed', false);
INSERT INTO public.options VALUES (22222, 5557, 'Sorts datasets', false);
INSERT INTO public.options VALUES (22223, 5557, 'Removes actions', false);
INSERT INTO public.options VALUES (22224, 5557, 'Compresses rewards', false);
INSERT INTO public.options VALUES (22226, 5558, 'Static sorting problems', false);
INSERT INTO public.options VALUES (22227, 5558, 'Compression tasks', false);
INSERT INTO public.options VALUES (22228, 5558, 'Encryption tasks', false);
INSERT INTO public.options VALUES (22230, 5559, 'Datasets are reduced', false);
INSERT INTO public.options VALUES (22231, 5559, 'Sorting becomes faster', false);
INSERT INTO public.options VALUES (22232, 5559, 'Memory becomes larger', false);
INSERT INTO public.options VALUES (22234, 5560, 'Dataset is sorted', false);
INSERT INTO public.options VALUES (22235, 5560, 'Rewards are removed', false);
INSERT INTO public.options VALUES (22236, 5560, 'States are compressed', false);
INSERT INTO public.options VALUES (22238, 5561, 'Datasets must be compressed', false);
INSERT INTO public.options VALUES (22239, 5561, 'Sorting must be recursive', false);
INSERT INTO public.options VALUES (22240, 5561, 'Rewards must be minimized', false);
INSERT INTO public.options VALUES (22242, 5562, '{"text":"Sorting datasets","is_correct":false}', false);
INSERT INTO public.options VALUES (22243, 5562, '{"text":"Compressing rewards","is_correct":false}', false);
INSERT INTO public.options VALUES (22244, 5562, '{"text":"Removing states","is_correct":false}', false);
INSERT INTO public.options VALUES (22246, 5563, '{"text":"Dataset averages","is_correct":false}', false);
INSERT INTO public.options VALUES (22247, 5563, '{"text":"Sorting rules","is_correct":false}', false);
INSERT INTO public.options VALUES (22248, 5563, '{"text":"Compression formulas","is_correct":false}', false);
INSERT INTO public.options VALUES (22250, 5564, '{"text":"Infinite dataset","is_correct":false}', false);
INSERT INTO public.options VALUES (22251, 5564, '{"text":"Sorting completion","is_correct":false}', false);
INSERT INTO public.options VALUES (22252, 5564, '{"text":"Memory compression","is_correct":false}', false);
INSERT INTO public.options VALUES (22254, 5565, '{"text":"Model-based planning","is_correct":false}', false);
INSERT INTO public.options VALUES (22255, 5565, '{"text":"Supervised learning","is_correct":false}', false);
INSERT INTO public.options VALUES (22256, 5565, '{"text":"Unsupervised clustering","is_correct":false}', false);
INSERT INTO public.options VALUES (22258, 5566, '{"text":"Dataset size","is_correct":false}', false);
INSERT INTO public.options VALUES (22259, 5566, '{"text":"Sorting complexity","is_correct":false}', false);
INSERT INTO public.options VALUES (22260, 5566, '{"text":"Compression ratio","is_correct":false}', false);
INSERT INTO public.options VALUES (22262, 5567, '{"text":"After every step","is_correct":false}', false);
INSERT INTO public.options VALUES (22263, 5567, '{"text":"Before interaction","is_correct":false}', false);
INSERT INTO public.options VALUES (22264, 5567, '{"text":"Randomly","is_correct":false}', false);
INSERT INTO public.options VALUES (22266, 5568, '{"text":"Sorting partitions","is_correct":false}', false);
INSERT INTO public.options VALUES (22267, 5568, '{"text":"Dataset duplication","is_correct":false}', false);
INSERT INTO public.options VALUES (22268, 5568, '{"text":"Compression blocks","is_correct":false}', false);
INSERT INTO public.options VALUES (22270, 5569, '{"text":"Static tasks","is_correct":false}', false);
INSERT INTO public.options VALUES (22271, 5569, '{"text":"Sorting tasks","is_correct":false}', false);
INSERT INTO public.options VALUES (22272, 5569, '{"text":"Compression tasks","is_correct":false}', false);
INSERT INTO public.options VALUES (22274, 5570, '{"text":"Dataset format","is_correct":false}', false);
INSERT INTO public.options VALUES (22275, 5570, '{"text":"Sorting order","is_correct":false}', false);
INSERT INTO public.options VALUES (22276, 5570, '{"text":"Memory size","is_correct":false}', false);
INSERT INTO public.options VALUES (22278, 5571, '{"text":"Dataset mean","is_correct":false}', false);
INSERT INTO public.options VALUES (22279, 5571, '{"text":"Sorting speed","is_correct":false}', false);
INSERT INTO public.options VALUES (22280, 5571, '{"text":"Compression value","is_correct":false}', false);
INSERT INTO public.options VALUES (22282, 5572, '{"text":"Reward signal","is_correct":false}', false);
INSERT INTO public.options VALUES (22283, 5572, '{"text":"Episodes","is_correct":false}', false);
INSERT INTO public.options VALUES (22284, 5572, '{"text":"State transitions","is_correct":false}', false);
INSERT INTO public.options VALUES (22286, 5573, '{"text":"Sorting strategy","is_correct":false}', false);
INSERT INTO public.options VALUES (22287, 5573, '{"text":"Compression strategy","is_correct":false}', false);
INSERT INTO public.options VALUES (22288, 5573, '{"text":"Dataset pruning","is_correct":false}', false);
INSERT INTO public.options VALUES (22290, 5574, '{"text":"State is sorted","is_correct":false}', false);
INSERT INTO public.options VALUES (22291, 5574, '{"text":"Reward is removed","is_correct":false}', false);
INSERT INTO public.options VALUES (22292, 5574, '{"text":"Dataset is compressed","is_correct":false}', false);
INSERT INTO public.options VALUES (22294, 5575, '{"text":"Only once per dataset","is_correct":false}', false);
INSERT INTO public.options VALUES (22295, 5575, '{"text":"Only after sorting","is_correct":false}', false);
INSERT INTO public.options VALUES (22296, 5575, '{"text":"Never","is_correct":false}', false);
INSERT INTO public.options VALUES (22298, 5576, '{"text":"Sorting inputs","is_correct":false}', false);
INSERT INTO public.options VALUES (22299, 5576, '{"text":"Compressing rewards","is_correct":false}', false);
INSERT INTO public.options VALUES (22300, 5576, '{"text":"Removing actions","is_correct":false}', false);
INSERT INTO public.options VALUES (22302, 5577, '{"text":"Dataset shrinks","is_correct":false}', false);
INSERT INTO public.options VALUES (22303, 5577, '{"text":"Sorting finishes","is_correct":false}', false);
INSERT INTO public.options VALUES (22304, 5577, '{"text":"Memory fills","is_correct":false}', false);
INSERT INTO public.options VALUES (22306, 5578, '{"text":"Dataset function","is_correct":false}', false);
INSERT INTO public.options VALUES (22307, 5578, '{"text":"Sorting function","is_correct":false}', false);
INSERT INTO public.options VALUES (22308, 5578, '{"text":"Compression function","is_correct":false}', false);
INSERT INTO public.options VALUES (22310, 5579, '{"text":"Linear Regression","is_correct":false}', false);
INSERT INTO public.options VALUES (22311, 5579, '{"text":"Decision Tree","is_correct":false}', false);
INSERT INTO public.options VALUES (22312, 5579, '{"text":"Clustering","is_correct":false}', false);
INSERT INTO public.options VALUES (22314, 5580, '{"text":"They sort datasets","is_correct":false}', false);
INSERT INTO public.options VALUES (22315, 5580, '{"text":"They compress memory","is_correct":false}', false);
INSERT INTO public.options VALUES (22316, 5580, '{"text":"They remove rewards","is_correct":false}', false);
INSERT INTO public.options VALUES (22318, 5581, '{"text":"Dataset compression technique","is_correct":false}', false);
INSERT INTO public.options VALUES (22319, 5581, '{"text":"Sorting framework","is_correct":false}', false);
INSERT INTO public.options VALUES (22320, 5581, '{"text":"Static decision rule","is_correct":false}', false);
INSERT INTO public.options VALUES (22322, 5582, 'Complete episode return', false);
INSERT INTO public.options VALUES (22323, 5582, 'Dataset sorting', false);
INSERT INTO public.options VALUES (22324, 5582, 'Memory compression', false);
INSERT INTO public.options VALUES (22326, 5583, 'Final state only', false);
INSERT INTO public.options VALUES (22327, 5583, 'Random state', false);
INSERT INTO public.options VALUES (22328, 5583, 'Dataset state', false);
INSERT INTO public.options VALUES (22330, 5584, 'Dataset average', false);
INSERT INTO public.options VALUES (22331, 5584, 'Sorting complexity', false);
INSERT INTO public.options VALUES (22332, 5584, 'Memory usage', false);
INSERT INTO public.options VALUES (22334, 5585, 'Sorting method', false);
INSERT INTO public.options VALUES (22335, 5585, 'Compression method', false);
INSERT INTO public.options VALUES (22336, 5585, 'Clustering method', false);
INSERT INTO public.options VALUES (22338, 5586, 'Only after full episode', false);
INSERT INTO public.options VALUES (22339, 5586, 'Before interaction', false);
INSERT INTO public.options VALUES (22340, 5586, 'Randomly', false);
INSERT INTO public.options VALUES (22342, 5587, 'Dataset function', false);
INSERT INTO public.options VALUES (22343, 5587, 'Sorting function', false);
INSERT INTO public.options VALUES (22344, 5587, 'Compression function', false);
INSERT INTO public.options VALUES (22346, 5588, 'Linear Regression', false);
INSERT INTO public.options VALUES (22347, 5588, 'Decision Tree', false);
INSERT INTO public.options VALUES (22348, 5588, 'Clustering', false);
INSERT INTO public.options VALUES (22350, 5589, 'Only dataset', false);
INSERT INTO public.options VALUES (22351, 5589, 'Sorting rules', false);
INSERT INTO public.options VALUES (22352, 5589, 'Compression algorithm', false);
INSERT INTO public.options VALUES (22354, 5590, 'Reward signal', false);
INSERT INTO public.options VALUES (22355, 5590, 'State transitions', false);
INSERT INTO public.options VALUES (22356, 5590, 'Policy', false);
INSERT INTO public.options VALUES (22358, 5591, 'Dataset error', false);
INSERT INTO public.options VALUES (22359, 5591, 'Sorting error', false);
INSERT INTO public.options VALUES (22360, 5591, 'Compression error', false);
INSERT INTO public.options VALUES (22362, 5592, 'Dataset size', false);
INSERT INTO public.options VALUES (22363, 5592, 'Sorting speed', false);
INSERT INTO public.options VALUES (22364, 5592, 'Memory capacity', false);
INSERT INTO public.options VALUES (22366, 5593, 'Dataset ordering', false);
INSERT INTO public.options VALUES (22367, 5593, 'Compression ratio', false);
INSERT INTO public.options VALUES (22368, 5593, 'Reward removal', false);
INSERT INTO public.options VALUES (22370, 5594, 'Static datasets', false);
INSERT INTO public.options VALUES (22371, 5594, 'Sorting tasks', false);
INSERT INTO public.options VALUES (22372, 5594, 'Compression tasks', false);
INSERT INTO public.options VALUES (22374, 5595, 'Dataset shrinks', false);
INSERT INTO public.options VALUES (22375, 5595, 'Sorting finishes', false);
INSERT INTO public.options VALUES (22376, 5595, 'Memory fills', false);
INSERT INTO public.options VALUES (22378, 5596, 'Sorting datasets', false);
INSERT INTO public.options VALUES (22379, 5596, 'Compressing rewards', false);
INSERT INTO public.options VALUES (22380, 5596, 'Removing states', false);
INSERT INTO public.options VALUES (22382, 5597, 'Sorting equation', false);
INSERT INTO public.options VALUES (22383, 5597, 'Compression equation', false);
INSERT INTO public.options VALUES (22384, 5597, 'Dataset equation', false);
INSERT INTO public.options VALUES (22386, 5598, 'Final return only', false);
INSERT INTO public.options VALUES (22387, 5598, 'Dataset mean', false);
INSERT INTO public.options VALUES (22388, 5598, 'Sorting result', false);
INSERT INTO public.options VALUES (22390, 5599, 'Static', false);
INSERT INTO public.options VALUES (22391, 5599, 'Random', false);
INSERT INTO public.options VALUES (22392, 5599, 'Batch-only', false);
INSERT INTO public.options VALUES (22394, 5600, 'Sorting datasets', false);
INSERT INTO public.options VALUES (22395, 5600, 'Compressing memory', false);
INSERT INTO public.options VALUES (22396, 5600, 'Removing actions', false);
INSERT INTO public.options VALUES (22398, 5601, 'Dataset compression method', false);
INSERT INTO public.options VALUES (22399, 5601, 'Sorting framework', false);
INSERT INTO public.options VALUES (22400, 5601, 'Static decision rule', false);
INSERT INTO public.options VALUES (22402, 5602, 'Only one-step reward', false);
INSERT INTO public.options VALUES (22403, 5602, 'Dataset sorting', false);
INSERT INTO public.options VALUES (22404, 5602, 'Memory compression', false);
INSERT INTO public.options VALUES (22406, 5603, 'Dynamic Programming', false);
INSERT INTO public.options VALUES (22407, 5603, 'Sorting algorithm', false);
INSERT INTO public.options VALUES (22408, 5603, 'Compression method', false);
INSERT INTO public.options VALUES (22410, 5604, 'Immediate next state only', false);
INSERT INTO public.options VALUES (22411, 5604, 'Dataset mean', false);
INSERT INTO public.options VALUES (22412, 5604, 'Sorting result', false);
INSERT INTO public.options VALUES (22414, 5605, 'After every step', false);
INSERT INTO public.options VALUES (22415, 5605, 'Before interaction', false);
INSERT INTO public.options VALUES (22416, 5605, 'Randomly', false);
INSERT INTO public.options VALUES (22418, 5606, 'Dataset function', false);
INSERT INTO public.options VALUES (22419, 5606, 'Sorting function', false);
INSERT INTO public.options VALUES (22420, 5606, 'Compression function', false);
INSERT INTO public.options VALUES (22422, 5607, 'Dataset average', false);
INSERT INTO public.options VALUES (22423, 5607, 'Sorting complexity', false);
INSERT INTO public.options VALUES (22424, 5607, 'Memory usage', false);
INSERT INTO public.options VALUES (22426, 5608, 'Environment model', false);
INSERT INTO public.options VALUES (22427, 5608, 'Sorting rules', false);
INSERT INTO public.options VALUES (22428, 5608, 'Compression logic', false);
INSERT INTO public.options VALUES (22430, 5609, 'Static datasets', false);
INSERT INTO public.options VALUES (22431, 5609, 'Sorting tasks', false);
INSERT INTO public.options VALUES (22432, 5609, 'Compression tasks', false);
INSERT INTO public.options VALUES (22434, 5610, 'Linear Regression', false);
INSERT INTO public.options VALUES (22435, 5610, 'Decision Tree', false);
INSERT INTO public.options VALUES (22436, 5610, 'Clustering', false);
INSERT INTO public.options VALUES (22438, 5611, 'Dataset size', false);
INSERT INTO public.options VALUES (22439, 5611, 'Sorting speed', false);
INSERT INTO public.options VALUES (22440, 5611, 'Memory capacity', false);
INSERT INTO public.options VALUES (22442, 5612, 'Dataset ordering', false);
INSERT INTO public.options VALUES (22443, 5612, 'Compression ratio', false);
INSERT INTO public.options VALUES (22444, 5612, 'Reward removal', false);
INSERT INTO public.options VALUES (22446, 5613, 'Dataset shrinks', false);
INSERT INTO public.options VALUES (22447, 5613, 'Sorting finishes', false);
INSERT INTO public.options VALUES (22448, 5613, 'Memory fills', false);
INSERT INTO public.options VALUES (22450, 5614, 'Sorting datasets', false);
INSERT INTO public.options VALUES (22451, 5614, 'Compressing rewards', false);
INSERT INTO public.options VALUES (22452, 5614, 'Removing states', false);
INSERT INTO public.options VALUES (22454, 5615, 'Sorting equation', false);
INSERT INTO public.options VALUES (22455, 5615, 'Compression equation', false);
INSERT INTO public.options VALUES (22456, 5615, 'Dataset equation', false);
INSERT INTO public.options VALUES (22458, 5616, 'Lower variance', false);
INSERT INTO public.options VALUES (22459, 5616, 'Zero variance', false);
INSERT INTO public.options VALUES (22460, 5616, 'No variance', false);
INSERT INTO public.options VALUES (22462, 5617, 'It sorts datasets', false);
INSERT INTO public.options VALUES (22463, 5617, 'It compresses memory', false);
INSERT INTO public.options VALUES (22464, 5617, 'It removes actions', false);
INSERT INTO public.options VALUES (22466, 5618, 'Only current state', false);
INSERT INTO public.options VALUES (22467, 5618, 'Dataset index', false);
INSERT INTO public.options VALUES (22468, 5618, 'Sorting pointer', false);
INSERT INTO public.options VALUES (22470, 5619, 'Dynamic Programming', false);
INSERT INTO public.options VALUES (22471, 5619, 'Sorting evaluation', false);
INSERT INTO public.options VALUES (22472, 5619, 'Compression evaluation', false);
INSERT INTO public.options VALUES (22474, 5620, 'Reward signal', false);
INSERT INTO public.options VALUES (22475, 5620, 'Discount factor', false);
INSERT INTO public.options VALUES (22476, 5620, 'Episode returns', false);
INSERT INTO public.options VALUES (22478, 5621, 'Dataset compression method', false);
INSERT INTO public.options VALUES (22479, 5621, 'Sorting framework', false);
INSERT INTO public.options VALUES (22480, 5621, 'Static decision rule', false);
INSERT INTO public.options VALUES (22482, 5622, 'Sorting and Searching', false);
INSERT INTO public.options VALUES (22483, 5622, 'Compression and Encryption', false);
INSERT INTO public.options VALUES (22484, 5622, 'Regression and Clustering', false);
INSERT INTO public.options VALUES (22486, 5623, 'Dataset size', false);
INSERT INTO public.options VALUES (22487, 5623, 'Sorting speed', false);
INSERT INTO public.options VALUES (22488, 5623, 'Memory capacity', false);
INSERT INTO public.options VALUES (22490, 5624, 'Monte Carlo', false);
INSERT INTO public.options VALUES (22491, 5624, 'Dynamic Programming', false);
INSERT INTO public.options VALUES (22492, 5624, 'Q-Learning', false);
INSERT INTO public.options VALUES (22494, 5625, 'Sorting algorithm', false);
INSERT INTO public.options VALUES (22495, 5625, 'Compression method', false);
INSERT INTO public.options VALUES (22496, 5625, 'Regression method', false);
INSERT INTO public.options VALUES (22498, 5626, 'Sorting traces', false);
INSERT INTO public.options VALUES (22499, 5626, 'Compression traces', false);
INSERT INTO public.options VALUES (22500, 5626, 'Dataset traces', false);
INSERT INTO public.options VALUES (22502, 5627, 'Sorting datasets', false);
INSERT INTO public.options VALUES (22503, 5627, 'Compressing rewards', false);
INSERT INTO public.options VALUES (22504, 5627, 'Removing states', false);
INSERT INTO public.options VALUES (22506, 5628, 'Dataset function', false);
INSERT INTO public.options VALUES (22507, 5628, 'Sorting function', false);
INSERT INTO public.options VALUES (22508, 5628, 'Compression function', false);
INSERT INTO public.options VALUES (22510, 5629, 'Only after full episode', false);
INSERT INTO public.options VALUES (22511, 5629, 'Before interaction', false);
INSERT INTO public.options VALUES (22512, 5629, 'Randomly', false);
INSERT INTO public.options VALUES (22514, 5630, 'Static datasets', false);
INSERT INTO public.options VALUES (22515, 5630, 'Sorting tasks', false);
INSERT INTO public.options VALUES (22516, 5630, 'Compression tasks', false);
INSERT INTO public.options VALUES (22518, 5631, 'Linear Regression', false);
INSERT INTO public.options VALUES (22519, 5631, 'Decision Tree', false);
INSERT INTO public.options VALUES (22520, 5631, 'Clustering', false);
INSERT INTO public.options VALUES (22522, 5632, 'Sorting methods', false);
INSERT INTO public.options VALUES (22523, 5632, 'Compression methods', false);
INSERT INTO public.options VALUES (22524, 5632, 'Regression methods', false);
INSERT INTO public.options VALUES (22526, 5633, 'Sorting algorithms', false);
INSERT INTO public.options VALUES (22527, 5633, 'Compression algorithms', false);
INSERT INTO public.options VALUES (22528, 5633, 'Clustering algorithms', false);
INSERT INTO public.options VALUES (22530, 5634, 'Dataset format', false);
INSERT INTO public.options VALUES (22531, 5634, 'Sorting order', false);
INSERT INTO public.options VALUES (22532, 5634, 'Memory size', false);
INSERT INTO public.options VALUES (22534, 5635, 'Dataset size', false);
INSERT INTO public.options VALUES (22535, 5635, 'Sorting speed', false);
INSERT INTO public.options VALUES (22536, 5635, 'Reward removal', false);
INSERT INTO public.options VALUES (22538, 5636, 'Sorting datasets', false);
INSERT INTO public.options VALUES (22539, 5636, 'Compressing memory', false);
INSERT INTO public.options VALUES (22540, 5636, 'Removing actions', false);
INSERT INTO public.options VALUES (22542, 5637, 'Dataset shrinks', false);
INSERT INTO public.options VALUES (22543, 5637, 'Sorting finishes', false);
INSERT INTO public.options VALUES (22544, 5637, 'Memory fills', false);
INSERT INTO public.options VALUES (22546, 5638, 'Dataset formatting', false);
INSERT INTO public.options VALUES (22547, 5638, 'Sorting inputs', false);
INSERT INTO public.options VALUES (22548, 5638, 'Compression outputs', false);
INSERT INTO public.options VALUES (22550, 5639, 'Only dataset', false);
INSERT INTO public.options VALUES (22551, 5639, 'Only neural network', false);
INSERT INTO public.options VALUES (22552, 5639, 'Only sorting rules', false);
INSERT INTO public.options VALUES (22554, 5640, 'Sorting and Searching', false);
INSERT INTO public.options VALUES (22555, 5640, 'Compression and Encoding', false);
INSERT INTO public.options VALUES (22556, 5640, 'Regression and Classification', false);
INSERT INTO public.options VALUES (22558, 5641, 'Dataset compression method', false);
INSERT INTO public.options VALUES (22559, 5641, 'Sorting framework', false);
INSERT INTO public.options VALUES (22560, 5641, 'Static decision rule', false);
INSERT INTO public.options VALUES (22562, 5642, 'Only immediate reward', false);
INSERT INTO public.options VALUES (22563, 5642, 'Only final reward', false);
INSERT INTO public.options VALUES (22564, 5642, 'No rewards', false);
INSERT INTO public.options VALUES (22566, 5643, 'Sorting and Searching', false);
INSERT INTO public.options VALUES (22567, 5643, 'Compression and Encryption', false);
INSERT INTO public.options VALUES (22568, 5643, 'Regression and Clustering', false);
INSERT INTO public.options VALUES (22570, 5644, 'Monte Carlo', false);
INSERT INTO public.options VALUES (22571, 5644, 'Policy Iteration', false);
INSERT INTO public.options VALUES (22572, 5644, 'Q-learning', false);
INSERT INTO public.options VALUES (22574, 5645, 'Sorting algorithm', false);
INSERT INTO public.options VALUES (22575, 5645, 'Compression method', false);
INSERT INTO public.options VALUES (22576, 5645, 'Regression method', false);
INSERT INTO public.options VALUES (22578, 5646, 'Dataset average', false);
INSERT INTO public.options VALUES (22579, 5646, 'Sorting complexity', false);
INSERT INTO public.options VALUES (22580, 5646, 'Memory usage', false);
INSERT INTO public.options VALUES (22582, 5647, 'Dataset functions', false);
INSERT INTO public.options VALUES (22583, 5647, 'Sorting functions', false);
INSERT INTO public.options VALUES (22584, 5647, 'Compression functions', false);
INSERT INTO public.options VALUES (22586, 5648, 'Dataset size', false);
INSERT INTO public.options VALUES (22587, 5648, 'Sorting speed', false);
INSERT INTO public.options VALUES (22588, 5648, 'Memory capacity', false);
INSERT INTO public.options VALUES (22590, 5649, 'Static datasets', false);
INSERT INTO public.options VALUES (22591, 5649, 'Sorting tasks', false);
INSERT INTO public.options VALUES (22592, 5649, 'Compression tasks', false);
INSERT INTO public.options VALUES (22594, 5650, 'Linear Regression', false);
INSERT INTO public.options VALUES (22595, 5650, 'Decision Tree', false);
INSERT INTO public.options VALUES (22596, 5650, 'Clustering', false);
INSERT INTO public.options VALUES (22598, 5651, 'Only after full episode', false);
INSERT INTO public.options VALUES (22599, 5651, 'Before interaction', false);
INSERT INTO public.options VALUES (22600, 5651, 'Randomly', false);
INSERT INTO public.options VALUES (22602, 5652, 'Only dataset', false);
INSERT INTO public.options VALUES (22603, 5652, 'Sorting rules', false);
INSERT INTO public.options VALUES (22604, 5652, 'Compression logic', false);
INSERT INTO public.options VALUES (22606, 5653, 'Dataset ordering', false);
INSERT INTO public.options VALUES (22607, 5653, 'Sorting speed', false);
INSERT INTO public.options VALUES (22608, 5653, 'Memory usage', false);
INSERT INTO public.options VALUES (22610, 5654, 'Dataset mean', false);
INSERT INTO public.options VALUES (22611, 5654, 'Sorting result', false);
INSERT INTO public.options VALUES (22612, 5654, 'Compression ratio', false);
INSERT INTO public.options VALUES (22614, 5655, 'Sorting datasets', false);
INSERT INTO public.options VALUES (22615, 5655, 'Compressing memory', false);
INSERT INTO public.options VALUES (22616, 5655, 'Removing actions', false);
INSERT INTO public.options VALUES (22618, 5656, 'Dataset shrinks', false);
INSERT INTO public.options VALUES (22619, 5656, 'Sorting finishes', false);
INSERT INTO public.options VALUES (22620, 5656, 'Memory fills', false);
INSERT INTO public.options VALUES (22622, 5657, 'Dataset formatting', false);
INSERT INTO public.options VALUES (22623, 5657, 'Sorting inputs', false);
INSERT INTO public.options VALUES (22624, 5657, 'Compression outputs', false);
INSERT INTO public.options VALUES (22626, 5658, 'Sorting and Searching', false);
INSERT INTO public.options VALUES (22627, 5658, 'Compression and Encoding', false);
INSERT INTO public.options VALUES (22628, 5658, 'Regression and Classification', false);
INSERT INTO public.options VALUES (22630, 5659, 'Dataset format', false);
INSERT INTO public.options VALUES (22631, 5659, 'Sorting order', false);
INSERT INTO public.options VALUES (22632, 5659, 'Memory size', false);
INSERT INTO public.options VALUES (22634, 5660, 'They sort datasets', false);
INSERT INTO public.options VALUES (22635, 5660, 'They compress rewards', false);
INSERT INTO public.options VALUES (22636, 5660, 'They remove states', false);
INSERT INTO public.options VALUES (22638, 5661, 'Dataset compression method', false);
INSERT INTO public.options VALUES (22639, 5661, 'Sorting framework', false);
INSERT INTO public.options VALUES (22640, 5661, 'Static decision rule', false);
INSERT INTO public.options VALUES (22642, 5662, 'Learning from sorted datasets', false);
INSERT INTO public.options VALUES (22643, 5662, 'Learning from compressed rewards', false);
INSERT INTO public.options VALUES (22644, 5662, 'Learning without interaction', false);
INSERT INTO public.options VALUES (22646, 5663, 'Learning only from datasets', false);
INSERT INTO public.options VALUES (22647, 5663, 'Learning without rewards', false);
INSERT INTO public.options VALUES (22648, 5663, 'Learning from sorting algorithms', false);
INSERT INTO public.options VALUES (22650, 5664, 'Q-Learning', false);
INSERT INTO public.options VALUES (22651, 5664, 'Value Iteration', false);
INSERT INTO public.options VALUES (22652, 5664, 'Monte Carlo Planning', false);
INSERT INTO public.options VALUES (22654, 5665, 'SARSA', false);
INSERT INTO public.options VALUES (22655, 5665, 'Policy Iteration', false);
INSERT INTO public.options VALUES (22656, 5665, 'TD(0)', false);
INSERT INTO public.options VALUES (22658, 5666, 'Optimal actions always', false);
INSERT INTO public.options VALUES (22659, 5666, 'Dataset averages', false);
INSERT INTO public.options VALUES (22660, 5666, 'Sorting outputs', false);
INSERT INTO public.options VALUES (22662, 5667, 'Random dataset', false);
INSERT INTO public.options VALUES (22663, 5667, 'Sorting sequence', false);
INSERT INTO public.options VALUES (22664, 5667, 'Compression rule', false);
INSERT INTO public.options VALUES (22666, 5668, 'Optimal policy only', false);
INSERT INTO public.options VALUES (22667, 5668, 'Sorting policy', false);
INSERT INTO public.options VALUES (22668, 5668, 'Compression policy', false);
INSERT INTO public.options VALUES (22670, 5669, 'Dataset policy', false);
INSERT INTO public.options VALUES (22671, 5669, 'Sorting policy', false);
INSERT INTO public.options VALUES (22672, 5669, 'Reward policy', false);
INSERT INTO public.options VALUES (22674, 5670, 'Dataset removal', false);
INSERT INTO public.options VALUES (22675, 5670, 'Sorting acceleration', false);
INSERT INTO public.options VALUES (22676, 5670, 'Memory compression', false);
INSERT INTO public.options VALUES (22678, 5671, 'Always faster', false);
INSERT INTO public.options VALUES (22679, 5671, 'Dataset dependent', false);
INSERT INTO public.options VALUES (22680, 5671, 'Memory free', false);
INSERT INTO public.options VALUES (22682, 5672, 'They sort datasets', false);
INSERT INTO public.options VALUES (22683, 5672, 'They compress rewards', false);
INSERT INTO public.options VALUES (22684, 5672, 'They remove states', false);
INSERT INTO public.options VALUES (22686, 5673, 'Sorting sampling', false);
INSERT INTO public.options VALUES (22687, 5673, 'Compression sampling', false);
INSERT INTO public.options VALUES (22688, 5673, 'Dataset pruning', false);
INSERT INTO public.options VALUES (22690, 5674, 'Dataset size', false);
INSERT INTO public.options VALUES (22691, 5674, 'Sorting complexity', false);
INSERT INTO public.options VALUES (22692, 5674, 'Memory limit', false);
INSERT INTO public.options VALUES (22694, 5675, 'SARSA', false);
INSERT INTO public.options VALUES (22695, 5675, 'TD(1)', false);
INSERT INTO public.options VALUES (22696, 5675, 'Monte Carlo prediction', false);
INSERT INTO public.options VALUES (22698, 5676, 'Q-Learning', false);
INSERT INTO public.options VALUES (22699, 5676, 'Value Iteration', false);
INSERT INTO public.options VALUES (22700, 5676, 'Planning', false);
INSERT INTO public.options VALUES (22702, 5677, 'Sorting datasets', false);
INSERT INTO public.options VALUES (22703, 5677, 'Compressing rewards', false);
INSERT INTO public.options VALUES (22704, 5677, 'Removing actions', false);
INSERT INTO public.options VALUES (22706, 5678, 'Dataset ordering', false);
INSERT INTO public.options VALUES (22707, 5678, 'Sorting rule', false);
INSERT INTO public.options VALUES (22708, 5678, 'Memory usage', false);
INSERT INTO public.options VALUES (22710, 5679, 'Dataset mean', false);
INSERT INTO public.options VALUES (22711, 5679, 'Sorting pointer', false);
INSERT INTO public.options VALUES (22712, 5679, 'Compression value', false);
INSERT INTO public.options VALUES (22714, 5680, 'On-policy learning', false);
INSERT INTO public.options VALUES (22715, 5680, 'Sorting learning', false);
INSERT INTO public.options VALUES (22716, 5680, 'Compression learning', false);
INSERT INTO public.options VALUES (22718, 5681, 'Both sort datasets', false);
INSERT INTO public.options VALUES (22719, 5681, 'Both compress memory', false);
INSERT INTO public.options VALUES (22720, 5681, 'Both remove rewards', false);
INSERT INTO public.options VALUES (22722, 5682, 'Sorting-Action-Reward-State-Action', false);
INSERT INTO public.options VALUES (22723, 5682, 'State-Action-Regression-Sorting-Action', false);
INSERT INTO public.options VALUES (22724, 5682, 'State-Array-Reward-Search-Action', false);
INSERT INTO public.options VALUES (22726, 5683, 'Off-policy planning method', false);
INSERT INTO public.options VALUES (22727, 5683, 'Supervised learning algorithm', false);
INSERT INTO public.options VALUES (22728, 5683, 'Clustering algorithm', false);
INSERT INTO public.options VALUES (22730, 5684, 'Dataset function', false);
INSERT INTO public.options VALUES (22731, 5684, 'Sorting function', false);
INSERT INTO public.options VALUES (22732, 5684, 'Compression function', false);
INSERT INTO public.options VALUES (22734, 5685, 'Only optimal action', false);
INSERT INTO public.options VALUES (22735, 5685, 'Dataset ordering', false);
INSERT INTO public.options VALUES (22736, 5685, 'Sorting result', false);
INSERT INTO public.options VALUES (22738, 5686, 'Monte Carlo planning', false);
INSERT INTO public.options VALUES (22739, 5686, 'Dynamic Programming only', false);
INSERT INTO public.options VALUES (22740, 5686, 'Regression learning', false);
INSERT INTO public.options VALUES (22742, 5687, 'Sorting strategy', false);
INSERT INTO public.options VALUES (22743, 5687, 'Compression strategy', false);
INSERT INTO public.options VALUES (22744, 5687, 'Dataset pruning', false);
INSERT INTO public.options VALUES (22746, 5688, 'Only after full episode', false);
INSERT INTO public.options VALUES (22747, 5688, 'Before interaction', false);
INSERT INTO public.options VALUES (22748, 5688, 'Randomly', false);
INSERT INTO public.options VALUES (22750, 5689, 'It removes rewards', false);
INSERT INTO public.options VALUES (22751, 5689, 'It sorts datasets', false);
INSERT INTO public.options VALUES (22752, 5689, 'It compresses memory', false);
INSERT INTO public.options VALUES (22754, 5690, 'Dataset average', false);
INSERT INTO public.options VALUES (22755, 5690, 'Sorting complexity', false);
INSERT INTO public.options VALUES (22756, 5690, 'Memory usage', false);
INSERT INTO public.options VALUES (22758, 5691, 'Dataset size', false);
INSERT INTO public.options VALUES (22759, 5691, 'Sorting speed', false);
INSERT INTO public.options VALUES (22760, 5691, 'Compression ratio', false);
INSERT INTO public.options VALUES (22762, 5692, 'Linear Regression', false);
INSERT INTO public.options VALUES (22763, 5692, 'Decision Tree', false);
INSERT INTO public.options VALUES (22764, 5692, 'Clustering', false);
INSERT INTO public.options VALUES (22766, 5693, 'Only dataset', false);
INSERT INTO public.options VALUES (22767, 5693, 'Sorting rules', false);
INSERT INTO public.options VALUES (22768, 5693, 'Compression logic', false);
INSERT INTO public.options VALUES (22770, 5694, 'Dataset ordering', false);
INSERT INTO public.options VALUES (22771, 5694, 'Sorting speed', false);
INSERT INTO public.options VALUES (22772, 5694, 'Memory size', false);
INSERT INTO public.options VALUES (22774, 5695, 'Dataset sorting', false);
INSERT INTO public.options VALUES (22775, 5695, 'Compression level', false);
INSERT INTO public.options VALUES (22776, 5695, 'Reward removal', false);
INSERT INTO public.options VALUES (22778, 5696, 'Dataset shrinks', false);
INSERT INTO public.options VALUES (22779, 5696, 'Sorting finishes', false);
INSERT INTO public.options VALUES (22780, 5696, 'Memory fills', false);
INSERT INTO public.options VALUES (22782, 5697, 'It always uses optimal action', false);
INSERT INTO public.options VALUES (22783, 5697, 'It removes exploration', false);
INSERT INTO public.options VALUES (22784, 5697, 'It compresses rewards', false);
INSERT INTO public.options VALUES (22786, 5698, 'Sorting datasets', false);
INSERT INTO public.options VALUES (22787, 5698, 'Compressing memory', false);
INSERT INTO public.options VALUES (22788, 5698, 'Removing states', false);
INSERT INTO public.options VALUES (22790, 5699, 'Static datasets', false);
INSERT INTO public.options VALUES (22791, 5699, 'Sorting tasks', false);
INSERT INTO public.options VALUES (22792, 5699, 'Compression tasks', false);
INSERT INTO public.options VALUES (22794, 5700, 'Datasets are removed', false);
INSERT INTO public.options VALUES (22795, 5700, 'Sorting becomes faster', false);
INSERT INTO public.options VALUES (22796, 5700, 'Rewards disappear', false);
INSERT INTO public.options VALUES (22798, 5701, 'Dataset compression technique', false);
INSERT INTO public.options VALUES (22799, 5701, 'Sorting framework', false);
INSERT INTO public.options VALUES (22800, 5701, 'Static decision rule', false);
INSERT INTO public.options VALUES (22802, 5702, 'On-policy planning algorithm', false);
INSERT INTO public.options VALUES (22803, 5702, 'Supervised learning algorithm', false);
INSERT INTO public.options VALUES (22804, 5702, 'Clustering algorithm', false);
INSERT INTO public.options VALUES (22806, 5703, 'Dataset function', false);
INSERT INTO public.options VALUES (22807, 5703, 'Sorting function', false);
INSERT INTO public.options VALUES (22808, 5703, 'Compression function', false);
INSERT INTO public.options VALUES (22810, 5704, 'Next action taken', false);
INSERT INTO public.options VALUES (22811, 5704, 'Dataset ordering', false);
INSERT INTO public.options VALUES (22812, 5704, 'Sorting result', false);
INSERT INTO public.options VALUES (22814, 5705, 'Dataset size', false);
INSERT INTO public.options VALUES (22815, 5705, 'Sorting speed', false);
INSERT INTO public.options VALUES (22816, 5705, 'Compression ratio', false);
INSERT INTO public.options VALUES (22818, 5706, 'Monte Carlo planning', false);
INSERT INTO public.options VALUES (22819, 5706, 'Dynamic Programming only', false);
INSERT INTO public.options VALUES (22820, 5706, 'Regression learning', false);
INSERT INTO public.options VALUES (22822, 5707, 'Sorting strategy', false);
INSERT INTO public.options VALUES (22823, 5707, 'Compression strategy', false);
INSERT INTO public.options VALUES (22824, 5707, 'Dataset pruning', false);
INSERT INTO public.options VALUES (22826, 5708, 'Only after full episode', false);
INSERT INTO public.options VALUES (22827, 5708, 'Before interaction', false);
INSERT INTO public.options VALUES (22828, 5708, 'Randomly', false);
INSERT INTO public.options VALUES (22830, 5709, 'It removes rewards', false);
INSERT INTO public.options VALUES (22831, 5709, 'It sorts datasets', false);
INSERT INTO public.options VALUES (22832, 5709, 'It compresses memory', false);
INSERT INTO public.options VALUES (22834, 5710, 'Dataset average', false);
INSERT INTO public.options VALUES (22835, 5710, 'Sorting complexity', false);
INSERT INTO public.options VALUES (22836, 5710, 'Memory usage', false);
INSERT INTO public.options VALUES (22838, 5711, 'Linear Regression', false);
INSERT INTO public.options VALUES (22839, 5711, 'Decision Tree', false);
INSERT INTO public.options VALUES (22840, 5711, 'Clustering', false);
INSERT INTO public.options VALUES (22842, 5712, 'Only dataset', false);
INSERT INTO public.options VALUES (22843, 5712, 'Sorting rules', false);
INSERT INTO public.options VALUES (22844, 5712, 'Compression logic', false);
INSERT INTO public.options VALUES (22846, 5713, 'Dataset ordering', false);
INSERT INTO public.options VALUES (22847, 5713, 'Sorting speed', false);
INSERT INTO public.options VALUES (22848, 5713, 'Memory size', false);
INSERT INTO public.options VALUES (22850, 5714, 'Dataset sorting', false);
INSERT INTO public.options VALUES (22851, 5714, 'Compression level', false);
INSERT INTO public.options VALUES (22852, 5714, 'Reward removal', false);
INSERT INTO public.options VALUES (22854, 5715, 'Dataset shrinks', false);
INSERT INTO public.options VALUES (22855, 5715, 'Sorting finishes', false);
INSERT INTO public.options VALUES (22856, 5715, 'Memory fills', false);
INSERT INTO public.options VALUES (22858, 5716, 'It uses next action taken', false);
INSERT INTO public.options VALUES (22859, 5716, 'It removes exploration', false);
INSERT INTO public.options VALUES (22860, 5716, 'It compresses rewards', false);
INSERT INTO public.options VALUES (22862, 5717, 'Sorting datasets', false);
INSERT INTO public.options VALUES (22863, 5717, 'Compressing memory', false);
INSERT INTO public.options VALUES (22864, 5717, 'Removing states', false);
INSERT INTO public.options VALUES (22866, 5718, 'Static datasets', false);
INSERT INTO public.options VALUES (22867, 5718, 'Sorting tasks', false);
INSERT INTO public.options VALUES (22868, 5718, 'Compression tasks', false);
INSERT INTO public.options VALUES (22870, 5719, 'Datasets are removed', false);
INSERT INTO public.options VALUES (22871, 5719, 'Sorting becomes faster', false);
INSERT INTO public.options VALUES (22872, 5719, 'Rewards disappear', false);
INSERT INTO public.options VALUES (22874, 5720, 'Sorting systems', false);
INSERT INTO public.options VALUES (22875, 5720, 'Compression engines', false);
INSERT INTO public.options VALUES (22876, 5720, 'Database indexing', false);
INSERT INTO public.options VALUES (22878, 5721, 'Dataset compression technique', false);
INSERT INTO public.options VALUES (22879, 5721, 'Sorting framework', false);
INSERT INTO public.options VALUES (22880, 5721, 'Static decision rule', false);
INSERT INTO public.options VALUES (22882, 5722, 'Sort datasets', false);
INSERT INTO public.options VALUES (22883, 5722, 'Compress rewards', false);
INSERT INTO public.options VALUES (22884, 5722, 'Remove actions', false);
INSERT INTO public.options VALUES (22886, 5723, 'Dataset table', false);
INSERT INTO public.options VALUES (22887, 5723, 'Sorting structure', false);
INSERT INTO public.options VALUES (22888, 5723, 'Compression rule', false);
INSERT INTO public.options VALUES (22890, 5724, 'Binary Search Tree', false);
INSERT INTO public.options VALUES (22891, 5724, 'Merge Sort', false);
INSERT INTO public.options VALUES (22892, 5724, 'Hash Table', false);
INSERT INTO public.options VALUES (22894, 5725, 'Dataset size always', false);
INSERT INTO public.options VALUES (22895, 5725, 'Sorting complexity', false);
INSERT INTO public.options VALUES (22896, 5725, 'Reward signal', false);
INSERT INTO public.options VALUES (22898, 5726, 'Static sorting problems', false);
INSERT INTO public.options VALUES (22899, 5726, 'Compression tasks', false);
INSERT INTO public.options VALUES (22900, 5726, 'Encryption tasks', false);
INSERT INTO public.options VALUES (22902, 5727, 'Dataset average', false);
INSERT INTO public.options VALUES (22903, 5727, 'Sorting order', false);
INSERT INTO public.options VALUES (22904, 5727, 'Memory capacity', false);
INSERT INTO public.options VALUES (22906, 5728, 'Dataset size', false);
INSERT INTO public.options VALUES (22907, 5728, 'Sorting speed', false);
INSERT INTO public.options VALUES (22908, 5728, 'Compression ratio', false);
INSERT INTO public.options VALUES (22910, 5729, 'Sorting-search trade-off', false);
INSERT INTO public.options VALUES (22911, 5729, 'Memory-compression trade-off', false);
INSERT INTO public.options VALUES (22912, 5729, 'Speed-dataset trade-off', false);
INSERT INTO public.options VALUES (22914, 5730, 'Sorting algorithm', false);
INSERT INTO public.options VALUES (22915, 5730, 'Compression algorithm', false);
INSERT INTO public.options VALUES (22916, 5730, 'Clustering', false);
INSERT INTO public.options VALUES (22918, 5731, 'Sort datasets', false);
INSERT INTO public.options VALUES (22919, 5731, 'Compress rewards', false);
INSERT INTO public.options VALUES (22920, 5731, 'Remove policies', false);
INSERT INTO public.options VALUES (22922, 5732, 'Datasets shrink', false);
INSERT INTO public.options VALUES (22923, 5732, 'Sorting becomes slow', false);
INSERT INTO public.options VALUES (22924, 5732, 'Rewards disappear', false);
INSERT INTO public.options VALUES (22926, 5733, 'Sorting approximation', false);
INSERT INTO public.options VALUES (22927, 5733, 'Compression approximation', false);
INSERT INTO public.options VALUES (22928, 5733, 'Dataset approximation', false);
INSERT INTO public.options VALUES (22930, 5734, 'Binary search', false);
INSERT INTO public.options VALUES (22931, 5734, 'Merge sort', false);
INSERT INTO public.options VALUES (22932, 5734, 'Heap structure', false);
INSERT INTO public.options VALUES (22934, 5735, 'Sorting data', false);
INSERT INTO public.options VALUES (22935, 5735, 'Compressing memory', false);
INSERT INTO public.options VALUES (22936, 5735, 'Removing states', false);
INSERT INTO public.options VALUES (22938, 5736, 'Linear Regression only', false);
INSERT INTO public.options VALUES (22939, 5736, 'Sorting Model', false);
INSERT INTO public.options VALUES (22940, 5736, 'Compression Model', false);
INSERT INTO public.options VALUES (22942, 5737, 'Dataset deletion', false);
INSERT INTO public.options VALUES (22943, 5737, 'Sorting failure', false);
INSERT INTO public.options VALUES (22944, 5737, 'Reward removal', false);
INSERT INTO public.options VALUES (22946, 5738, 'Dataset rows', false);
INSERT INTO public.options VALUES (22947, 5738, 'Sorting steps', false);
INSERT INTO public.options VALUES (22948, 5738, 'Compression blocks', false);
INSERT INTO public.options VALUES (22950, 5739, 'Sorting systems', false);
INSERT INTO public.options VALUES (22951, 5739, 'Compression engines', false);
INSERT INTO public.options VALUES (22952, 5739, 'Database indexing', false);
INSERT INTO public.options VALUES (22954, 5740, 'Sorting policy', false);
INSERT INTO public.options VALUES (22955, 5740, 'Compressing policy', false);
INSERT INTO public.options VALUES (22956, 5740, 'Removing policy', false);
INSERT INTO public.options VALUES (22958, 5741, 'Dataset compression technique', false);
INSERT INTO public.options VALUES (22959, 5741, 'Sorting framework', false);
INSERT INTO public.options VALUES (22960, 5741, 'Static rule method', false);
INSERT INTO public.options VALUES (22962, 5742, 'Sort datasets', false);
INSERT INTO public.options VALUES (22963, 5742, 'Compress rewards', false);
INSERT INTO public.options VALUES (22964, 5742, 'Remove states', false);
INSERT INTO public.options VALUES (22966, 5743, 'Same as gradient', false);
INSERT INTO public.options VALUES (22967, 5743, 'Random direction', false);
INSERT INTO public.options VALUES (22968, 5743, 'Sorting direction', false);
INSERT INTO public.options VALUES (22970, 5744, 'Dataset size', false);
INSERT INTO public.options VALUES (22971, 5744, 'Sorting speed', false);
INSERT INTO public.options VALUES (22972, 5744, 'Compression ratio', false);
INSERT INTO public.options VALUES (22974, 5745, 'Dataset entries', false);
INSERT INTO public.options VALUES (22975, 5745, 'Sorting complexity', false);
INSERT INTO public.options VALUES (22976, 5745, 'Reward signal', false);
INSERT INTO public.options VALUES (22978, 5746, 'Sorting Error', false);
INSERT INTO public.options VALUES (22979, 5746, 'Compression Error', false);
INSERT INTO public.options VALUES (22980, 5746, 'Dataset Error', false);
INSERT INTO public.options VALUES (22982, 5747, 'Sorting arrays', false);
INSERT INTO public.options VALUES (22983, 5747, 'Compressing files', false);
INSERT INTO public.options VALUES (22984, 5747, 'Removing actions', false);
INSERT INTO public.options VALUES (22986, 5748, 'Binary Search', false);
INSERT INTO public.options VALUES (22987, 5748, 'Merge Sort', false);
INSERT INTO public.options VALUES (22988, 5748, 'Hashing', false);
INSERT INTO public.options VALUES (22990, 5749, 'Only once', false);
INSERT INTO public.options VALUES (22991, 5749, 'Randomly', false);
INSERT INTO public.options VALUES (22994, 5750, 'Dataset size', false);
INSERT INTO public.options VALUES (22995, 5750, 'Sorting order', false);
INSERT INTO public.options VALUES (22996, 5750, 'Memory size', false);
INSERT INTO public.options VALUES (22998, 5751, 'Dataset removal', false);
INSERT INTO public.options VALUES (22999, 5751, 'Sorting completion', false);
INSERT INTO public.options VALUES (23000, 5751, 'Memory compression', false);
INSERT INTO public.options VALUES (23002, 5752, 'Dataset expansion', false);
INSERT INTO public.options VALUES (23003, 5752, 'Sorting failure', false);
INSERT INTO public.options VALUES (23004, 5752, 'Reward explosion', false);
INSERT INTO public.options VALUES (23006, 5753, 'Full dataset always', false);
INSERT INTO public.options VALUES (23007, 5753, 'Sorted dataset', false);
INSERT INTO public.options VALUES (23008, 5753, 'Compressed dataset', false);
INSERT INTO public.options VALUES (23010, 5754, 'Only one sample', false);
INSERT INTO public.options VALUES (23011, 5754, 'Random sample', false);
INSERT INTO public.options VALUES (23012, 5754, 'Sorted sample', false);
INSERT INTO public.options VALUES (23014, 5755, 'Sorting datasets', false);
INSERT INTO public.options VALUES (23015, 5755, 'Compressing rewards', false);
INSERT INTO public.options VALUES (23016, 5755, 'Removing policies', false);
INSERT INTO public.options VALUES (23018, 5756, 'Sorting step', false);
INSERT INTO public.options VALUES (23019, 5756, 'Compression step', false);
INSERT INTO public.options VALUES (23020, 5756, 'Dataset pruning', false);
INSERT INTO public.options VALUES (23022, 5757, 'Dataset sorting', false);
INSERT INTO public.options VALUES (23023, 5757, 'Compression rule', false);
INSERT INTO public.options VALUES (23024, 5757, 'Reward removal', false);
INSERT INTO public.options VALUES (23026, 5758, 'Dataset index', false);
INSERT INTO public.options VALUES (23027, 5758, 'Sorting pointer', false);
INSERT INTO public.options VALUES (23028, 5758, 'Compression ratio', false);
INSERT INTO public.options VALUES (23030, 5759, 'Sorting arrays', false);
INSERT INTO public.options VALUES (23031, 5759, 'Compressing memory', false);
INSERT INTO public.options VALUES (23032, 5759, 'Removing states', false);
INSERT INTO public.options VALUES (23034, 5760, 'Dataset rows', false);
INSERT INTO public.options VALUES (23035, 5760, 'Sorting blocks', false);
INSERT INTO public.options VALUES (23036, 5760, 'Compression bits', false);
INSERT INTO public.options VALUES (23038, 5761, 'Dataset compression technique', false);
INSERT INTO public.options VALUES (23039, 5761, 'Sorting framework', false);
INSERT INTO public.options VALUES (23040, 5761, 'Static decision rule', false);
INSERT INTO public.options VALUES (23042, 5762, 'Single immediate reward', false);
INSERT INTO public.options VALUES (23043, 5762, 'Sorted dataset', false);
INSERT INTO public.options VALUES (23044, 5762, 'Compression rule', false);
INSERT INTO public.options VALUES (23046, 5763, 'Sorting algorithms', false);
INSERT INTO public.options VALUES (23047, 5763, 'Compression methods', false);
INSERT INTO public.options VALUES (23048, 5763, 'Database indexing', false);
INSERT INTO public.options VALUES (23050, 5764, 'Every action instantly', false);
INSERT INTO public.options VALUES (23051, 5764, 'Dataset sorting', false);
INSERT INTO public.options VALUES (23052, 5764, 'Reward removal', false);
INSERT INTO public.options VALUES (23054, 5765, 'Predicted next reward only', false);
INSERT INTO public.options VALUES (23055, 5765, 'Sorted return', false);
INSERT INTO public.options VALUES (23056, 5765, 'Compressed return', false);
INSERT INTO public.options VALUES (23058, 5766, 'Sorting error', false);
INSERT INTO public.options VALUES (23059, 5766, 'Compression error', false);
INSERT INTO public.options VALUES (23060, 5766, 'Dataset error', false);
INSERT INTO public.options VALUES (23062, 5767, 'Static sorting problems', false);
INSERT INTO public.options VALUES (23063, 5767, 'File compression', false);
INSERT INTO public.options VALUES (23064, 5767, 'Encryption tasks', false);
INSERT INTO public.options VALUES (23066, 5768, 'Only initial state', false);
INSERT INTO public.options VALUES (23067, 5768, 'Dataset indexing', false);
INSERT INTO public.options VALUES (23068, 5768, 'Sorting key', false);
INSERT INTO public.options VALUES (23070, 5769, 'Binary search', false);
INSERT INTO public.options VALUES (23071, 5769, 'Merge sort', false);
INSERT INTO public.options VALUES (23072, 5769, 'Hashing', false);
INSERT INTO public.options VALUES (23074, 5770, 'Reward signal', false);
INSERT INTO public.options VALUES (23075, 5770, 'States', false);
INSERT INTO public.options VALUES (23076, 5770, 'Actions', false);
INSERT INTO public.options VALUES (23078, 5771, 'Dataset size', false);
INSERT INTO public.options VALUES (23079, 5771, 'Sorting complexity', false);
INSERT INTO public.options VALUES (23080, 5771, 'Memory compression', false);
INSERT INTO public.options VALUES (23082, 5772, 'Biased always', false);
INSERT INTO public.options VALUES (23083, 5772, 'Deterministic sorting', false);
INSERT INTO public.options VALUES (23084, 5772, 'Compression based', false);
INSERT INTO public.options VALUES (23086, 5773, 'Sorted dataset', false);
INSERT INTO public.options VALUES (23087, 5773, 'Compression ratio', false);
INSERT INTO public.options VALUES (23088, 5773, 'Network size', false);
INSERT INTO public.options VALUES (23090, 5774, 'Sorting Model', false);
INSERT INTO public.options VALUES (23091, 5774, 'Compression Model', false);
INSERT INTO public.options VALUES (23092, 5774, 'Database Model', false);
INSERT INTO public.options VALUES (23094, 5775, 'Sorting order', false);
INSERT INTO public.options VALUES (23095, 5775, 'Compression path', false);
INSERT INTO public.options VALUES (23096, 5775, 'Dataset hierarchy', false);
INSERT INTO public.options VALUES (23098, 5776, 'Needs sorting algorithm', false);
INSERT INTO public.options VALUES (23099, 5776, 'Removes rewards', false);
INSERT INTO public.options VALUES (23100, 5776, 'Deletes states', false);
INSERT INTO public.options VALUES (23102, 5777, 'Only discrete sorting', false);
INSERT INTO public.options VALUES (23103, 5777, 'Compression tasks', false);
INSERT INTO public.options VALUES (23104, 5777, 'Encryption tasks', false);
INSERT INTO public.options VALUES (23106, 5778, 'Predicted Q only', false);
INSERT INTO public.options VALUES (23107, 5778, 'Sorted reward', false);
INSERT INTO public.options VALUES (23108, 5778, 'Compressed signal', false);
INSERT INTO public.options VALUES (23110, 5779, 'Sorting datasets', false);
INSERT INTO public.options VALUES (23111, 5779, 'Compressing memory', false);
INSERT INTO public.options VALUES (23112, 5779, 'Removing transitions', false);
INSERT INTO public.options VALUES (23114, 5780, 'Sorting rules', false);
INSERT INTO public.options VALUES (23115, 5780, 'Compression rules', false);
INSERT INTO public.options VALUES (23116, 5780, 'Dataset removal', false);
INSERT INTO public.options VALUES (23118, 5781, 'Dataset compression method', false);
INSERT INTO public.options VALUES (23119, 5781, 'Sorting framework', false);
INSERT INTO public.options VALUES (23120, 5781, 'Static decision rule', false);
INSERT INTO public.options VALUES (23122, 5782, 'Sorting datasets', false);
INSERT INTO public.options VALUES (23123, 5782, 'Compressing rewards', false);
INSERT INTO public.options VALUES (23124, 5782, 'Removing policies', false);
INSERT INTO public.options VALUES (23126, 5783, 'Sorting error', false);
INSERT INTO public.options VALUES (23127, 5783, 'Compression error', false);
INSERT INTO public.options VALUES (23128, 5783, 'Dataset error', false);
INSERT INTO public.options VALUES (23130, 5784, 'Dataset size', false);
INSERT INTO public.options VALUES (23131, 5784, 'Sorting order', false);
INSERT INTO public.options VALUES (23132, 5784, 'Memory usage', false);
INSERT INTO public.options VALUES (23134, 5785, 'It sorts half dataset', false);
INSERT INTO public.options VALUES (23135, 5785, 'It compresses partial memory', false);
INSERT INTO public.options VALUES (23136, 5785, 'It removes half actions', false);
INSERT INTO public.options VALUES (23138, 5786, 'Sorting update', false);
INSERT INTO public.options VALUES (23139, 5786, 'Compression update', false);
INSERT INTO public.options VALUES (23140, 5786, 'Dataset update', false);
INSERT INTO public.options VALUES (23142, 5787, 'Sorting and searching', false);
INSERT INTO public.options VALUES (23143, 5787, 'Compression and hashing', false);
INSERT INTO public.options VALUES (23144, 5787, 'Clustering and regression', false);
INSERT INTO public.options VALUES (23146, 5788, 'Only after episode ends', false);
INSERT INTO public.options VALUES (23147, 5788, 'Only after dataset sorting', false);
INSERT INTO public.options VALUES (23148, 5788, 'Only after compression', false);
INSERT INTO public.options VALUES (23150, 5789, 'Static sorting tasks', false);
INSERT INTO public.options VALUES (23151, 5789, 'File compression', false);
INSERT INTO public.options VALUES (23152, 5789, 'Encryption', false);
INSERT INTO public.options VALUES (23154, 5790, 'Sorting complexity', false);
INSERT INTO public.options VALUES (23155, 5790, 'Compression ratio', false);
INSERT INTO public.options VALUES (23156, 5790, 'Dataset indexing', false);
INSERT INTO public.options VALUES (23158, 5791, 'Dataset average', false);
INSERT INTO public.options VALUES (23159, 5791, 'Sorting speed', false);
INSERT INTO public.options VALUES (23160, 5791, 'Reward signal', false);
INSERT INTO public.options VALUES (23162, 5792, 'Static', false);
INSERT INTO public.options VALUES (23163, 5792, 'Random sorting', false);
INSERT INTO public.options VALUES (23164, 5792, 'Compression based', false);
INSERT INTO public.options VALUES (23166, 5793, 'Sorted dataset', false);
INSERT INTO public.options VALUES (23167, 5793, 'Compressed signal', false);
INSERT INTO public.options VALUES (23168, 5793, 'Memory block', false);
INSERT INTO public.options VALUES (23170, 5794, 'Dataset size', false);
INSERT INTO public.options VALUES (23171, 5794, 'Sorting key', false);
INSERT INTO public.options VALUES (23172, 5794, 'Compression level', false);
INSERT INTO public.options VALUES (23174, 5795, 'Sorting arrays', false);
INSERT INTO public.options VALUES (23175, 5795, 'Compressing files', false);
INSERT INTO public.options VALUES (23176, 5795, 'Removing rewards', false);
INSERT INTO public.options VALUES (23178, 5796, 'Sorting dataset', false);
INSERT INTO public.options VALUES (23179, 5796, 'Compressing signal', false);
INSERT INTO public.options VALUES (23180, 5796, 'Deleting actions', false);
INSERT INTO public.options VALUES (23182, 5797, 'Sorting engines', false);
INSERT INTO public.options VALUES (23183, 5797, 'Compression tools', false);
INSERT INTO public.options VALUES (23184, 5797, 'Database indexing', false);
INSERT INTO public.options VALUES (23186, 5798, 'Binary Search', false);
INSERT INTO public.options VALUES (23187, 5798, 'Merge Sort', false);
INSERT INTO public.options VALUES (23188, 5798, 'Hashing', false);
INSERT INTO public.options VALUES (23190, 5799, 'Dataset removal', false);
INSERT INTO public.options VALUES (23191, 5799, 'Sorting elimination', false);
INSERT INTO public.options VALUES (23192, 5799, 'Compression failure', false);
INSERT INTO public.options VALUES (23194, 5800, 'Sorting Model', false);
INSERT INTO public.options VALUES (23195, 5800, 'Compression Model', false);
INSERT INTO public.options VALUES (23196, 5800, 'Database Model', false);
INSERT INTO public.options VALUES (23198, 5801, 'Dataset compression method', false);
INSERT INTO public.options VALUES (23199, 5801, 'Sorting technique', false);
INSERT INTO public.options VALUES (23200, 5801, 'Static rule', false);
INSERT INTO public.options VALUES (23202, 5802, 'Sort datasets', false);
INSERT INTO public.options VALUES (23203, 5802, 'Compress rewards', false);
INSERT INTO public.options VALUES (23204, 5802, 'Remove policies', false);
INSERT INTO public.options VALUES (23206, 5803, 'Dataset index', false);
INSERT INTO public.options VALUES (23207, 5803, 'Sorting order', false);
INSERT INTO public.options VALUES (23208, 5803, 'Compression block', false);
INSERT INTO public.options VALUES (23210, 5804, 'Sorting algorithms', false);
INSERT INTO public.options VALUES (23211, 5804, 'Compression methods', false);
INSERT INTO public.options VALUES (23212, 5804, 'Database queries', false);
INSERT INTO public.options VALUES (23214, 5805, 'Dataset size', false);
INSERT INTO public.options VALUES (23215, 5805, 'Sorting key', false);
INSERT INTO public.options VALUES (23216, 5805, 'Compression ratio', false);
INSERT INTO public.options VALUES (23218, 5806, 'Sorting and searching', false);
INSERT INTO public.options VALUES (23219, 5806, 'Compression and hashing', false);
INSERT INTO public.options VALUES (23220, 5806, 'Clustering and regression', false);
INSERT INTO public.options VALUES (23222, 5807, 'Dataset removal', false);
INSERT INTO public.options VALUES (23223, 5807, 'Sorting speed', false);
INSERT INTO public.options VALUES (23224, 5807, 'Memory compression', false);
INSERT INTO public.options VALUES (23226, 5808, 'Monte Carlo', false);
INSERT INTO public.options VALUES (23227, 5808, 'Sorting algorithm', false);
INSERT INTO public.options VALUES (23228, 5808, 'Compression method', false);
INSERT INTO public.options VALUES (23230, 5809, 'TD(0)', false);
INSERT INTO public.options VALUES (23231, 5809, 'Sorting technique', false);
INSERT INTO public.options VALUES (23232, 5809, 'Compression technique', false);
INSERT INTO public.options VALUES (23234, 5810, 'Only at episode end', false);
INSERT INTO public.options VALUES (23235, 5810, 'After sorting', false);
INSERT INTO public.options VALUES (23236, 5810, 'After compression', false);
INSERT INTO public.options VALUES (23238, 5811, 'Dataset sorting', false);
INSERT INTO public.options VALUES (23239, 5811, 'Memory compression', false);
INSERT INTO public.options VALUES (23240, 5811, 'Encryption tasks', false);
INSERT INTO public.options VALUES (23242, 5812, 'Sorting techniques', false);
INSERT INTO public.options VALUES (23243, 5812, 'Compression rules', false);
INSERT INTO public.options VALUES (23244, 5812, 'Dataset structures', false);
INSERT INTO public.options VALUES (23246, 5813, 'Dataset size', false);
INSERT INTO public.options VALUES (23247, 5813, 'Sorting depth', false);
INSERT INTO public.options VALUES (23248, 5813, 'Compression rate', false);
INSERT INTO public.options VALUES (23250, 5814, 'Sorting datasets', false);
INSERT INTO public.options VALUES (23251, 5814, 'Compressing signals', false);
INSERT INTO public.options VALUES (23252, 5814, 'Removing actions', false);
INSERT INTO public.options VALUES (23254, 5815, 'Dataset size', false);
INSERT INTO public.options VALUES (23255, 5815, 'Sorting priority', false);
INSERT INTO public.options VALUES (23256, 5815, 'Memory capacity', false);
INSERT INTO public.options VALUES (23258, 5816, 'Merge Sort', false);
INSERT INTO public.options VALUES (23259, 5816, 'Binary Search', false);
INSERT INTO public.options VALUES (23260, 5816, 'Hash Tables', false);
INSERT INTO public.options VALUES (23262, 5817, 'Static sorting problems', false);
INSERT INTO public.options VALUES (23263, 5817, 'File compression', false);
INSERT INTO public.options VALUES (23264, 5817, 'Encryption systems', false);
INSERT INTO public.options VALUES (23266, 5818, 'Dataset sorting', false);
INSERT INTO public.options VALUES (23267, 5818, 'Compression signals', false);
INSERT INTO public.options VALUES (23268, 5818, 'Policy removal', false);
INSERT INTO public.options VALUES (23270, 5819, 'Sorting', false);
INSERT INTO public.options VALUES (23271, 5819, 'Compression', false);
INSERT INTO public.options VALUES (23272, 5819, 'Hashing', false);
INSERT INTO public.options VALUES (23274, 5820, 'Sorting keys', false);
INSERT INTO public.options VALUES (23275, 5820, 'Dataset pruning', false);
INSERT INTO public.options VALUES (23276, 5820, 'Memory compression', false);
INSERT INTO public.options VALUES (23278, 5821, 'Dataset compression technique', false);
INSERT INTO public.options VALUES (23279, 5821, 'Sorting framework', false);
INSERT INTO public.options VALUES (23280, 5821, 'Static rule', false);
INSERT INTO public.options VALUES (23282, 5822, 'Sorting Algorithms', false);
INSERT INTO public.options VALUES (23283, 5822, 'Compression Methods', false);
INSERT INTO public.options VALUES (23284, 5822, 'Database Queries', false);
INSERT INTO public.options VALUES (23286, 5823, 'Small datasets only', false);
INSERT INTO public.options VALUES (23287, 5823, 'Sorting numbers', false);
INSERT INTO public.options VALUES (23288, 5823, 'File compression', false);
INSERT INTO public.options VALUES (23290, 5824, 'Binary Search Tree', false);
INSERT INTO public.options VALUES (23291, 5824, 'Merge Sort', false);
INSERT INTO public.options VALUES (23292, 5824, 'Hash Table', false);
INSERT INTO public.options VALUES (23294, 5825, 'Sorting datasets', false);
INSERT INTO public.options VALUES (23295, 5825, 'Compressing rewards', false);
INSERT INTO public.options VALUES (23296, 5825, 'Removing states', false);
INSERT INTO public.options VALUES (23298, 5826, 'Binary Search', false);
INSERT INTO public.options VALUES (23299, 5826, 'K-Means', false);
INSERT INTO public.options VALUES (23300, 5826, 'Linear Regression', false);
INSERT INTO public.options VALUES (23302, 5827, 'Sorting techniques', false);
INSERT INTO public.options VALUES (23303, 5827, 'Compression tools', false);
INSERT INTO public.options VALUES (23304, 5827, 'Database indexing', false);
INSERT INTO public.options VALUES (23306, 5828, 'Sorting order', false);
INSERT INTO public.options VALUES (23307, 5828, 'Dataset deletion', false);
INSERT INTO public.options VALUES (23308, 5828, 'Reward removal', false);
INSERT INTO public.options VALUES (23310, 5829, 'Simple text editing', false);
INSERT INTO public.options VALUES (23311, 5829, 'File compression', false);
INSERT INTO public.options VALUES (23312, 5829, 'Static database queries', false);
INSERT INTO public.options VALUES (23314, 5830, 'Binary Tree', false);
INSERT INTO public.options VALUES (23315, 5830, 'Heap Structure', false);
INSERT INTO public.options VALUES (23316, 5830, 'Sorting Network', false);
INSERT INTO public.options VALUES (23318, 5831, 'Sorted dataset only', false);
INSERT INTO public.options VALUES (23319, 5831, 'Compression rules', false);
INSERT INTO public.options VALUES (23320, 5831, 'Static policy', false);
INSERT INTO public.options VALUES (23322, 5832, 'Sorting key', false);
INSERT INTO public.options VALUES (23323, 5832, 'Dataset index', false);
INSERT INTO public.options VALUES (23324, 5832, 'Compression bit', false);
INSERT INTO public.options VALUES (23326, 5833, 'Sort datasets', false);
INSERT INTO public.options VALUES (23327, 5833, 'Compress memory', false);
INSERT INTO public.options VALUES (23328, 5833, 'Remove rewards', false);
INSERT INTO public.options VALUES (23330, 5834, 'Sort faster', false);
INSERT INTO public.options VALUES (23331, 5834, 'Compress signals', false);
INSERT INTO public.options VALUES (23332, 5834, 'Delete policies', false);
INSERT INTO public.options VALUES (23334, 5835, 'Dataset removal', false);
INSERT INTO public.options VALUES (23335, 5835, 'Sorting failure', false);
INSERT INTO public.options VALUES (23336, 5835, 'Reward disappearance', false);
INSERT INTO public.options VALUES (23338, 5836, 'Dataset compression', false);
INSERT INTO public.options VALUES (23339, 5836, 'Sorting sequence', false);
INSERT INTO public.options VALUES (23340, 5836, 'Memory deletion', false);
INSERT INTO public.options VALUES (23342, 5837, 'Sort arrays', false);
INSERT INTO public.options VALUES (23343, 5837, 'Compress files', false);
INSERT INTO public.options VALUES (23344, 5837, 'Remove actions', false);
INSERT INTO public.options VALUES (23346, 5838, 'Static sorting problems', false);
INSERT INTO public.options VALUES (23347, 5838, 'Simple arithmetic', false);
INSERT INTO public.options VALUES (23348, 5838, 'File encryption', false);
INSERT INTO public.options VALUES (23350, 5839, 'Sorting-based', false);
INSERT INTO public.options VALUES (23351, 5839, 'Compression-based', false);
INSERT INTO public.options VALUES (23352, 5839, 'Hash-based', false);
INSERT INTO public.options VALUES (23354, 5840, 'Sorting datasets', false);
INSERT INTO public.options VALUES (23355, 5840, 'Compressing rewards', false);
INSERT INTO public.options VALUES (23356, 5840, 'Removing environment states', false);
INSERT INTO public.options VALUES (23358, 5841, 'Dataset compression technique', false);
INSERT INTO public.options VALUES (23359, 5841, 'Sorting framework', false);
INSERT INTO public.options VALUES (23360, 5841, 'Static rule method', false);
INSERT INTO public.options VALUES (23362, 5842, 'Sorting datasets', false);
INSERT INTO public.options VALUES (23363, 5842, 'Compressing rewards', false);
INSERT INTO public.options VALUES (23364, 5842, 'Removing states', false);
INSERT INTO public.options VALUES (23366, 5843, 'Dataset index', false);
INSERT INTO public.options VALUES (23367, 5843, 'Sorting key', false);
INSERT INTO public.options VALUES (23368, 5843, 'Compression block', false);
INSERT INTO public.options VALUES (23370, 5844, 'Binary search', false);
INSERT INTO public.options VALUES (23371, 5844, 'Merge sort', false);
INSERT INTO public.options VALUES (23372, 5844, 'Hashing', false);
INSERT INTO public.options VALUES (23374, 5845, 'Sorting datasets', false);
INSERT INTO public.options VALUES (23375, 5845, 'Compressing files', false);
INSERT INTO public.options VALUES (23376, 5845, 'Removing policies', false);
INSERT INTO public.options VALUES (23378, 5846, 'Sorting arrays', false);
INSERT INTO public.options VALUES (23379, 5846, 'Dataset pruning', false);
INSERT INTO public.options VALUES (23380, 5846, 'Memory compression', false);
INSERT INTO public.options VALUES (23382, 5847, 'Merge sort', false);
INSERT INTO public.options VALUES (23383, 5847, 'Binary search', false);
INSERT INTO public.options VALUES (23384, 5847, 'Linear regression', false);
INSERT INTO public.options VALUES (23386, 5848, 'Full MDP', false);
INSERT INTO public.options VALUES (23387, 5848, 'Sorting environment', false);
INSERT INTO public.options VALUES (23388, 5848, 'Compression environment', false);
INSERT INTO public.options VALUES (23390, 5849, 'Dataset size', false);
INSERT INTO public.options VALUES (23391, 5849, 'Sorting order', false);
INSERT INTO public.options VALUES (23392, 5849, 'Memory capacity', false);
INSERT INTO public.options VALUES (23394, 5850, 'Minimize dataset', false);
INSERT INTO public.options VALUES (23395, 5850, 'Sort data', false);
INSERT INTO public.options VALUES (23396, 5850, 'Compress rewards', false);
INSERT INTO public.options VALUES (23398, 5851, 'Sorting delay', false);
INSERT INTO public.options VALUES (23399, 5851, 'Compression loss', false);
INSERT INTO public.options VALUES (23402, 5852, 'Static sorting', false);
INSERT INTO public.options VALUES (23403, 5852, 'Compression bandit', false);
INSERT INTO public.options VALUES (23404, 5852, 'Dataset bandit', false);
INSERT INTO public.options VALUES (23406, 5853, 'Sorting', false);
INSERT INTO public.options VALUES (23407, 5853, 'Compression', false);
INSERT INTO public.options VALUES (23408, 5853, 'Policy removal', false);
INSERT INTO public.options VALUES (23410, 5854, 'Merge sort', false);
INSERT INTO public.options VALUES (23411, 5854, 'Binary search', false);
INSERT INTO public.options VALUES (23412, 5854, 'Hashing', false);
INSERT INTO public.options VALUES (23414, 5855, 'Sorting algorithm', false);
INSERT INTO public.options VALUES (23415, 5855, 'Compression model', false);
INSERT INTO public.options VALUES (23416, 5855, 'Database query', false);
INSERT INTO public.options VALUES (23418, 5856, 'Dataset size', false);
INSERT INTO public.options VALUES (23419, 5856, 'Sorting key', false);
INSERT INTO public.options VALUES (23420, 5856, 'Memory index', false);
INSERT INTO public.options VALUES (23422, 5857, 'Offline sorting', false);
INSERT INTO public.options VALUES (23423, 5857, 'Compression based', false);
INSERT INTO public.options VALUES (23424, 5857, 'Static', false);
INSERT INTO public.options VALUES (23426, 5858, 'Merge sort', false);
INSERT INTO public.options VALUES (23427, 5858, 'Binary search', false);
INSERT INTO public.options VALUES (23428, 5858, 'Hashing', false);
INSERT INTO public.options VALUES (23430, 5859, 'Reward', false);
INSERT INTO public.options VALUES (23431, 5859, 'Actions', false);
INSERT INTO public.options VALUES (23432, 5859, 'Policy', false);
INSERT INTO public.options VALUES (23434, 5860, 'Dataset size', false);
INSERT INTO public.options VALUES (23435, 5860, 'Sorting speed', false);
INSERT INTO public.options VALUES (23436, 5860, 'Compression rate', false);
INSERT INTO public.options VALUES (23438, 5861, 'Sorting datasets', false);
INSERT INTO public.options VALUES (23439, 5861, 'Compressing rewards', false);
INSERT INTO public.options VALUES (23440, 5861, 'Removing environment', false);
INSERT INTO public.options VALUES (23442, 5862, 'Dataset size', false);
INSERT INTO public.options VALUES (23443, 5862, 'Sorting order', false);
INSERT INTO public.options VALUES (23444, 5862, 'Compression ratio', false);
INSERT INTO public.options VALUES (23446, 5863, 'Sorting table', false);
INSERT INTO public.options VALUES (23447, 5863, 'Compression matrix', false);
INSERT INTO public.options VALUES (23448, 5863, 'Dataset list', false);
INSERT INTO public.options VALUES (23450, 5864, 'Sort datasets', false);
INSERT INTO public.options VALUES (23451, 5864, 'Compress rewards', false);
INSERT INTO public.options VALUES (23452, 5864, 'Remove states', false);
INSERT INTO public.options VALUES (23454, 5865, 'Merge Sort', false);
INSERT INTO public.options VALUES (23455, 5865, 'Binary Search', false);
INSERT INTO public.options VALUES (23456, 5865, 'K-Means', false);
INSERT INTO public.options VALUES (23458, 5866, 'Static sorting problems', false);
INSERT INTO public.options VALUES (23459, 5866, 'File compression', false);
INSERT INTO public.options VALUES (23460, 5866, 'Database indexing', false);
INSERT INTO public.options VALUES (23462, 5867, 'Sorting Theorem', false);
INSERT INTO public.options VALUES (23463, 5867, 'Compression Theorem', false);
INSERT INTO public.options VALUES (23464, 5867, 'Dataset Theorem', false);
INSERT INTO public.options VALUES (23466, 5868, 'Sorting key', false);
INSERT INTO public.options VALUES (23467, 5868, 'Dataset index', false);
INSERT INTO public.options VALUES (23468, 5868, 'Memory block', false);
INSERT INTO public.options VALUES (23470, 5869, 'Deterministic sorting', false);
INSERT INTO public.options VALUES (23471, 5869, 'Compression rules', false);
INSERT INTO public.options VALUES (23472, 5869, 'Dataset pruning', false);
INSERT INTO public.options VALUES (23474, 5870, 'Binary search', false);
INSERT INTO public.options VALUES (23475, 5870, 'Merge sort', false);
INSERT INTO public.options VALUES (23476, 5870, 'Hashing', false);
INSERT INTO public.options VALUES (23478, 5871, 'Dataset size', false);
INSERT INTO public.options VALUES (23479, 5871, 'Sorting complexity', false);
INSERT INTO public.options VALUES (23480, 5871, 'Memory usage', false);
INSERT INTO public.options VALUES (23482, 5872, 'Dataset size', false);
INSERT INTO public.options VALUES (23483, 5872, 'Sorting speed', false);
INSERT INTO public.options VALUES (23484, 5872, 'Compression ratio', false);
INSERT INTO public.options VALUES (23486, 5873, 'After sorting', false);
INSERT INTO public.options VALUES (23487, 5873, 'After compression', false);
INSERT INTO public.options VALUES (23488, 5873, 'After dataset deletion', false);
INSERT INTO public.options VALUES (23490, 5874, 'Reward signal', false);
INSERT INTO public.options VALUES (23491, 5874, 'Actions', false);
INSERT INTO public.options VALUES (23492, 5874, 'States', false);
INSERT INTO public.options VALUES (23494, 5875, 'Sorting failure', false);
INSERT INTO public.options VALUES (23495, 5875, 'Compression loss', false);
INSERT INTO public.options VALUES (23496, 5875, 'Dataset removal', false);
INSERT INTO public.options VALUES (23498, 5876, 'Sorting datasets', false);
INSERT INTO public.options VALUES (23499, 5876, 'Compressing memory', false);
INSERT INTO public.options VALUES (23500, 5876, 'Removing rewards', false);
INSERT INTO public.options VALUES (23502, 5877, 'Sorting Model', false);
INSERT INTO public.options VALUES (23503, 5877, 'Compression Model', false);
INSERT INTO public.options VALUES (23504, 5877, 'Database Model', false);
INSERT INTO public.options VALUES (23506, 5878, 'Merge sort', false);
INSERT INTO public.options VALUES (23507, 5878, 'Binary search', false);
INSERT INTO public.options VALUES (23508, 5878, 'Hash tables', false);
INSERT INTO public.options VALUES (23510, 5879, 'Sorting based', false);
INSERT INTO public.options VALUES (23511, 5879, 'Compression based', false);
INSERT INTO public.options VALUES (23512, 5879, 'Static', false);
INSERT INTO public.options VALUES (23514, 5880, 'Dataset rows', false);
INSERT INTO public.options VALUES (23515, 5880, 'Sorting blocks', false);
INSERT INTO public.options VALUES (23516, 5880, 'Compression bits', false);
INSERT INTO public.options VALUES (23518, 5881, 'Dataset compression method', false);
INSERT INTO public.options VALUES (23519, 5881, 'Sorting framework', false);
INSERT INTO public.options VALUES (23520, 5881, 'Static decision rule', false);
INSERT INTO public.options VALUES (23522, 5882, 'Sorting and searching', false);
INSERT INTO public.options VALUES (23523, 5882, 'Compression and hashing', false);
INSERT INTO public.options VALUES (23524, 5882, 'Dataset indexing and pruning', false);
INSERT INTO public.options VALUES (23526, 5883, 'Sorting datasets', false);
INSERT INTO public.options VALUES (23527, 5883, 'Compressing rewards', false);
INSERT INTO public.options VALUES (23528, 5883, 'Removing states', false);
INSERT INTO public.options VALUES (23530, 5884, 'Dataset size', false);
INSERT INTO public.options VALUES (23531, 5884, 'Sorting speed', false);
INSERT INTO public.options VALUES (23532, 5884, 'Compression ratio', false);
INSERT INTO public.options VALUES (23534, 5885, 'Sorting key', false);
INSERT INTO public.options VALUES (23535, 5885, 'Dataset index', false);
INSERT INTO public.options VALUES (23536, 5885, 'Memory pointer', false);
INSERT INTO public.options VALUES (23538, 5886, 'Dataset entries', false);
INSERT INTO public.options VALUES (23539, 5886, 'Sorting complexity', false);
INSERT INTO public.options VALUES (23540, 5886, 'Compression load', false);
INSERT INTO public.options VALUES (23542, 5887, 'Offline sorting', false);
INSERT INTO public.options VALUES (23543, 5887, 'Static compression', false);
INSERT INTO public.options VALUES (23544, 5887, 'Dataset deletion', false);
INSERT INTO public.options VALUES (23546, 5888, 'Binary search', false);
INSERT INTO public.options VALUES (23547, 5888, 'Merge sort', false);
INSERT INTO public.options VALUES (23548, 5888, 'Hashing', false);
INSERT INTO public.options VALUES (23550, 5889, 'Dataset average', false);
INSERT INTO public.options VALUES (23551, 5889, 'Sorting index', false);
INSERT INTO public.options VALUES (23552, 5889, 'Compression factor', false);
INSERT INTO public.options VALUES (23554, 5890, 'Static sorting tasks', false);
INSERT INTO public.options VALUES (23555, 5890, 'File compression', false);
INSERT INTO public.options VALUES (23556, 5890, 'Database queries', false);
INSERT INTO public.options VALUES (23558, 5891, 'Merge Sort', false);
INSERT INTO public.options VALUES (23559, 5891, 'Binary Search', false);
INSERT INTO public.options VALUES (23560, 5891, 'K-Means', false);
INSERT INTO public.options VALUES (23562, 5892, 'Sorting datasets', false);
INSERT INTO public.options VALUES (23563, 5892, 'Compressing memory', false);
INSERT INTO public.options VALUES (23564, 5892, 'Removing policies', false);
INSERT INTO public.options VALUES (23566, 5893, 'Sorting', false);
INSERT INTO public.options VALUES (23567, 5893, 'Compression', false);
INSERT INTO public.options VALUES (23568, 5893, 'Hashing', false);
INSERT INTO public.options VALUES (23570, 5894, 'Sorting Model', false);
INSERT INTO public.options VALUES (23571, 5894, 'Compression Model', false);
INSERT INTO public.options VALUES (23572, 5894, 'Database Model', false);
INSERT INTO public.options VALUES (23574, 5895, 'Only after episode end', false);
INSERT INTO public.options VALUES (23575, 5895, 'After sorting', false);
INSERT INTO public.options VALUES (23576, 5895, 'After compression', false);
INSERT INTO public.options VALUES (23578, 5896, 'Binary search', false);
INSERT INTO public.options VALUES (23579, 5896, 'Merge sort', false);
INSERT INTO public.options VALUES (23580, 5896, 'Hashing', false);
INSERT INTO public.options VALUES (23582, 5897, 'Sorting arrays', false);
INSERT INTO public.options VALUES (23583, 5897, 'Compressing files', false);
INSERT INTO public.options VALUES (23584, 5897, 'Deleting rewards', false);
INSERT INTO public.options VALUES (23586, 5898, 'Dataset removal', false);
INSERT INTO public.options VALUES (23587, 5898, 'Sorting failure', false);
INSERT INTO public.options VALUES (23588, 5898, 'Compression loss', false);
INSERT INTO public.options VALUES (23590, 5899, 'Binary trees', false);
INSERT INTO public.options VALUES (23591, 5899, 'Heap structures', false);
INSERT INTO public.options VALUES (23592, 5899, 'Sorting networks', false);
INSERT INTO public.options VALUES (23594, 5900, 'Sorted dataset', false);
INSERT INTO public.options VALUES (23595, 5900, 'Compression signal', false);
INSERT INTO public.options VALUES (23596, 5900, 'Memory index', false);
INSERT INTO public.options VALUES (23598, 5901, 'Dataset compression technique', false);
INSERT INTO public.options VALUES (23599, 5901, 'Sorting framework', false);
INSERT INTO public.options VALUES (23600, 5901, 'Static decision rule', false);
INSERT INTO public.options VALUES (23602, 5902, 'Dataset size', false);
INSERT INTO public.options VALUES (23603, 5902, 'Sorting complexity', false);
INSERT INTO public.options VALUES (23604, 5902, 'Compression ratio', false);
INSERT INTO public.options VALUES (23606, 5903, 'Binary Search', false);
INSERT INTO public.options VALUES (23607, 5903, 'Merge Sort', false);
INSERT INTO public.options VALUES (23608, 5903, 'Hash Tables', false);
INSERT INTO public.options VALUES (23610, 5904, 'Dataset compression', false);
INSERT INTO public.options VALUES (23611, 5904, 'Sorting arrays', false);
INSERT INTO public.options VALUES (23612, 5904, 'Memory deletion', false);
INSERT INTO public.options VALUES (23614, 5905, 'Sort datasets', false);
INSERT INTO public.options VALUES (23615, 5905, 'Compress rewards', false);
INSERT INTO public.options VALUES (23616, 5905, 'Remove actions', false);
INSERT INTO public.options VALUES (23618, 5906, 'Sort faster', false);
INSERT INTO public.options VALUES (23619, 5906, 'Compress signals', false);
INSERT INTO public.options VALUES (23620, 5906, 'Delete policies', false);
INSERT INTO public.options VALUES (23622, 5907, 'Sorting Error', false);
INSERT INTO public.options VALUES (23623, 5907, 'Compression Error', false);
INSERT INTO public.options VALUES (23624, 5907, 'Dataset Error', false);
INSERT INTO public.options VALUES (23626, 5908, 'Binary search', false);
INSERT INTO public.options VALUES (23627, 5908, 'Merge sort', false);
INSERT INTO public.options VALUES (23628, 5908, 'Hashing', false);
INSERT INTO public.options VALUES (23630, 5909, 'Sorting-based', false);
INSERT INTO public.options VALUES (23631, 5909, 'Compression-based', false);
INSERT INTO public.options VALUES (23632, 5909, 'Hash-based', false);
INSERT INTO public.options VALUES (23634, 5910, 'Sorted dataset', false);
INSERT INTO public.options VALUES (23635, 5910, 'Compression factor', false);
INSERT INTO public.options VALUES (23636, 5910, 'Memory index', false);
INSERT INTO public.options VALUES (23638, 5911, 'Sorting datasets', false);
INSERT INTO public.options VALUES (23639, 5911, 'File compression', false);
INSERT INTO public.options VALUES (23640, 5911, 'Database indexing', false);
INSERT INTO public.options VALUES (23642, 5912, 'Sorted arrays', false);
INSERT INTO public.options VALUES (23643, 5912, 'Compressed files', false);
INSERT INTO public.options VALUES (23644, 5912, 'Deleted rewards', false);
INSERT INTO public.options VALUES (23646, 5913, 'Dataset compression', false);
INSERT INTO public.options VALUES (23647, 5913, 'Sorting logic', false);
INSERT INTO public.options VALUES (23648, 5913, 'Memory deletion', false);
INSERT INTO public.options VALUES (23650, 5914, 'Sorting', false);
INSERT INTO public.options VALUES (23651, 5914, 'Compression', false);
INSERT INTO public.options VALUES (23652, 5914, 'Hashing', false);
INSERT INTO public.options VALUES (23654, 5915, 'Sorted dataset only', false);
INSERT INTO public.options VALUES (23655, 5915, 'Compression rules', false);
INSERT INTO public.options VALUES (23656, 5915, 'Static policy', false);
INSERT INTO public.options VALUES (23658, 5916, 'Binary Tree', false);
INSERT INTO public.options VALUES (23659, 5916, 'Heap', false);
INSERT INTO public.options VALUES (23660, 5916, 'Sorting Network', false);
INSERT INTO public.options VALUES (23662, 5917, 'Dataset removal', false);
INSERT INTO public.options VALUES (23663, 5917, 'Sorting failure', false);
INSERT INTO public.options VALUES (23664, 5917, 'Compression loss', false);
INSERT INTO public.options VALUES (23666, 5918, 'Every step always', false);
INSERT INTO public.options VALUES (23667, 5918, 'After sorting', false);
INSERT INTO public.options VALUES (23668, 5918, 'After compression', false);
INSERT INTO public.options VALUES (23670, 5919, 'Static sorting problems', false);
INSERT INTO public.options VALUES (23671, 5919, 'File compression', false);
INSERT INTO public.options VALUES (23672, 5919, 'Encryption', false);
INSERT INTO public.options VALUES (23674, 5920, 'Sort faster', false);
INSERT INTO public.options VALUES (23675, 5920, 'Compress memory', false);
INSERT INTO public.options VALUES (23676, 5920, 'Delete policies', false);
INSERT INTO public.options VALUES (23678, 5921, 'Dataset compression technique', false);
INSERT INTO public.options VALUES (23679, 5921, 'Sorting framework', false);
INSERT INTO public.options VALUES (23680, 5921, 'Static decision rule', false);
INSERT INTO public.options VALUES (23682, 5922, 'Dataset sorting delay', false);
INSERT INTO public.options VALUES (23683, 5922, 'Memory compression error', false);
INSERT INTO public.options VALUES (23684, 5922, 'Policy removal', false);
INSERT INTO public.options VALUES (23686, 5923, 'One network', false);
INSERT INTO public.options VALUES (23687, 5923, 'Three networks', false);
INSERT INTO public.options VALUES (23688, 5923, 'No network', false);
INSERT INTO public.options VALUES (23690, 5924, 'Dataset sorting', false);
INSERT INTO public.options VALUES (23691, 5924, 'Reward compression', false);
INSERT INTO public.options VALUES (23692, 5924, 'Memory deletion', false);
INSERT INTO public.options VALUES (23694, 5925, 'Sorting arrays', false);
INSERT INTO public.options VALUES (23695, 5925, 'Compressing signals', false);
INSERT INTO public.options VALUES (23696, 5925, 'Removing actions', false);
INSERT INTO public.options VALUES (23698, 5926, 'Sorting datasets', false);
INSERT INTO public.options VALUES (23699, 5926, 'Compression logic', false);
INSERT INTO public.options VALUES (23700, 5926, 'Static policy', false);
INSERT INTO public.options VALUES (23702, 5927, 'Dataset removal', false);
INSERT INTO public.options VALUES (23703, 5927, 'Sorting complexity', false);
INSERT INTO public.options VALUES (23704, 5927, 'Compression ratio', false);
INSERT INTO public.options VALUES (23706, 5928, 'Sorted dataset', false);
INSERT INTO public.options VALUES (23707, 5928, 'Compressed reward', false);
INSERT INTO public.options VALUES (23708, 5928, 'Memory index', false);
INSERT INTO public.options VALUES (23710, 5929, 'Sorting-based learning', false);
INSERT INTO public.options VALUES (23711, 5929, 'Compression-based learning', false);
INSERT INTO public.options VALUES (23712, 5929, 'Static learning', false);
INSERT INTO public.options VALUES (23714, 5930, 'Sorting buffer', false);
INSERT INTO public.options VALUES (23715, 5930, 'Compression buffer', false);
INSERT INTO public.options VALUES (23716, 5930, 'Dataset pruning', false);
INSERT INTO public.options VALUES (23718, 5931, 'Binary search', false);
INSERT INTO public.options VALUES (23719, 5931, 'Merge sort', false);
INSERT INTO public.options VALUES (23720, 5931, 'Hashing', false);
INSERT INTO public.options VALUES (23722, 5932, 'Dataset size', false);
INSERT INTO public.options VALUES (23723, 5932, 'Sorting delay', false);
INSERT INTO public.options VALUES (23724, 5932, 'Memory compression', false);
INSERT INTO public.options VALUES (23726, 5933, 'Random sorted action', false);
INSERT INTO public.options VALUES (23727, 5933, 'Compressed action', false);
INSERT INTO public.options VALUES (23728, 5933, 'Deleted action', false);
INSERT INTO public.options VALUES (23730, 5934, 'Static sorting problems', false);
INSERT INTO public.options VALUES (23731, 5934, 'File compression', false);
INSERT INTO public.options VALUES (23732, 5934, 'Simple arithmetic', false);
INSERT INTO public.options VALUES (23734, 5935, 'Target network', false);
INSERT INTO public.options VALUES (23735, 5935, 'Sorting network', false);
INSERT INTO public.options VALUES (23736, 5935, 'Compression network', false);
INSERT INTO public.options VALUES (23738, 5936, 'Every step always', false);
INSERT INTO public.options VALUES (23739, 5936, 'After sorting', false);
INSERT INTO public.options VALUES (23740, 5936, 'After compression', false);
INSERT INTO public.options VALUES (23742, 5937, 'Sorting-based', false);
INSERT INTO public.options VALUES (23743, 5937, 'Compression-based', false);
INSERT INTO public.options VALUES (23744, 5937, 'Hash-based', false);
INSERT INTO public.options VALUES (23746, 5938, 'Sorting Algorithms', false);
INSERT INTO public.options VALUES (23747, 5938, 'Compression Techniques', false);
INSERT INTO public.options VALUES (23748, 5938, 'Database Optimization', false);
INSERT INTO public.options VALUES (23750, 5939, 'Sorting', false);
INSERT INTO public.options VALUES (23751, 5939, 'Compression', false);
INSERT INTO public.options VALUES (23752, 5939, 'Hashing', false);
INSERT INTO public.options VALUES (23754, 5940, 'Dataset compression', false);
INSERT INTO public.options VALUES (23755, 5940, 'Sorting accuracy', false);
INSERT INTO public.options VALUES (23756, 5940, 'Memory deletion', false);
INSERT INTO public.options VALUES (23758, 5941, 'Dataset compression method', false);
INSERT INTO public.options VALUES (23759, 5941, 'Sorting framework', false);
INSERT INTO public.options VALUES (23760, 5941, 'Static decision rule', false);
INSERT INTO public.options VALUES (23762, 5942, 'Sorting datasets', false);
INSERT INTO public.options VALUES (23763, 5942, 'File compression', false);
INSERT INTO public.options VALUES (23764, 5942, 'Static database queries', false);
INSERT INTO public.options VALUES (23766, 5943, 'Dataset indexing', false);
INSERT INTO public.options VALUES (23767, 5943, 'Sorting engines', false);
INSERT INTO public.options VALUES (23768, 5943, 'Compression tools', false);
INSERT INTO public.options VALUES (23770, 5944, 'Sort databases', false);
INSERT INTO public.options VALUES (23771, 5944, 'Compress images', false);
INSERT INTO public.options VALUES (23772, 5944, 'Delete rewards', false);
INSERT INTO public.options VALUES (23774, 5945, 'Sorting algorithms', false);
INSERT INTO public.options VALUES (23775, 5945, 'Compression networks', false);
INSERT INTO public.options VALUES (23776, 5945, 'Static data processing', false);
INSERT INTO public.options VALUES (23778, 5946, 'Dataset sorting', false);
INSERT INTO public.options VALUES (23779, 5946, 'Memory compression', false);
INSERT INTO public.options VALUES (23780, 5946, 'Policy deletion', false);
INSERT INTO public.options VALUES (23782, 5947, 'Sorting medical datasets', false);
INSERT INTO public.options VALUES (23783, 5947, 'Compressing patient records', false);
INSERT INTO public.options VALUES (23784, 5947, 'Removing rewards', false);
INSERT INTO public.options VALUES (23786, 5948, 'Sorting hardware', false);
INSERT INTO public.options VALUES (23787, 5948, 'Compressing sensors', false);
INSERT INTO public.options VALUES (23788, 5948, 'Deleting actions', false);
INSERT INTO public.options VALUES (23790, 5949, 'Dataset indexing', false);
INSERT INTO public.options VALUES (23791, 5949, 'Sorting tasks', false);
INSERT INTO public.options VALUES (23792, 5949, 'Compression routines', false);
INSERT INTO public.options VALUES (23794, 5950, 'Sorting text files', false);
INSERT INTO public.options VALUES (23795, 5950, 'Compressing language', false);
INSERT INTO public.options VALUES (23796, 5950, 'Removing grammar', false);
INSERT INTO public.options VALUES (23798, 5951, 'Dataset sorting', false);
INSERT INTO public.options VALUES (23799, 5951, 'Compression techniques', false);
INSERT INTO public.options VALUES (23800, 5951, 'Policy deletion', false);
INSERT INTO public.options VALUES (23802, 5952, 'Sorting traffic datasets', false);
INSERT INTO public.options VALUES (23803, 5952, 'Compressing vehicle data', false);
INSERT INTO public.options VALUES (23804, 5952, 'Deleting sensors', false);
INSERT INTO public.options VALUES (23806, 5953, 'Sorting industry', false);
INSERT INTO public.options VALUES (23807, 5953, 'Compression sector', false);
INSERT INTO public.options VALUES (23808, 5953, 'Static manufacturing', false);
INSERT INTO public.options VALUES (23810, 5954, 'Sorting logs', false);
INSERT INTO public.options VALUES (23811, 5954, 'Compressing memory', false);
INSERT INTO public.options VALUES (23812, 5954, 'Removing servers', false);
INSERT INTO public.options VALUES (23814, 5955, 'Dataset deletion', false);
INSERT INTO public.options VALUES (23815, 5955, 'Sorting products', false);
INSERT INTO public.options VALUES (23816, 5955, 'Compression planning', false);
INSERT INTO public.options VALUES (23818, 5956, 'Sorting student lists', false);
INSERT INTO public.options VALUES (23819, 5956, 'Compressing exams', false);
INSERT INTO public.options VALUES (23820, 5956, 'Removing rewards', false);
INSERT INTO public.options VALUES (23822, 5957, 'Sorting sensor data', false);
INSERT INTO public.options VALUES (23823, 5957, 'Compression flight', false);
INSERT INTO public.options VALUES (23824, 5957, 'Deleting policies', false);
INSERT INTO public.options VALUES (23826, 5958, 'Dataset sorting', false);
INSERT INTO public.options VALUES (23827, 5958, 'Compression routines', false);
INSERT INTO public.options VALUES (23828, 5958, 'Policy deletion', false);
INSERT INTO public.options VALUES (23830, 5959, 'Sorting videos', false);
INSERT INTO public.options VALUES (23831, 5959, 'Compressing streams', false);
INSERT INTO public.options VALUES (23832, 5959, 'Deleting rewards', false);
INSERT INTO public.options VALUES (23834, 5960, 'Sorting players', false);
INSERT INTO public.options VALUES (23835, 5960, 'Compressing scores', false);
INSERT INTO public.options VALUES (23836, 5960, 'Deleting rules', false);
INSERT INTO public.options VALUES (23838, 5961, 'Dataset compression method', false);
INSERT INTO public.options VALUES (23839, 5961, 'Sorting framework', false);
INSERT INTO public.options VALUES (23840, 5961, 'Static rule method', false);
INSERT INTO public.options VALUES (23842, 5962, 'Single agent sorting datasets', false);
INSERT INTO public.options VALUES (23843, 5962, 'Compressing rewards', false);
INSERT INTO public.options VALUES (23844, 5962, 'Removing policies', false);
INSERT INTO public.options VALUES (23846, 5963, 'Only sort data', false);
INSERT INTO public.options VALUES (23847, 5963, 'Only compress memory', false);
INSERT INTO public.options VALUES (23848, 5963, 'Only remove states', false);
INSERT INTO public.options VALUES (23850, 5964, 'Sorted dataset', false);
INSERT INTO public.options VALUES (23851, 5964, 'Compressed network', false);
INSERT INTO public.options VALUES (23852, 5964, 'Static table', false);
INSERT INTO public.options VALUES (23854, 5965, 'Sort arrays', false);
INSERT INTO public.options VALUES (23855, 5965, 'Compress files', false);
INSERT INTO public.options VALUES (23856, 5965, 'Delete rewards', false);
INSERT INTO public.options VALUES (23858, 5966, 'Sorting system', false);
INSERT INTO public.options VALUES (23859, 5966, 'Compression engine', false);
INSERT INTO public.options VALUES (23860, 5966, 'Dataset manager', false);
INSERT INTO public.options VALUES (23862, 5967, 'Sorting theory', false);
INSERT INTO public.options VALUES (23863, 5967, 'Compression theory', false);
INSERT INTO public.options VALUES (23864, 5967, 'Dataset theory', false);
INSERT INTO public.options VALUES (23866, 5968, 'Dataset deletion', false);
INSERT INTO public.options VALUES (23867, 5968, 'Sorting delay', false);
INSERT INTO public.options VALUES (23868, 5968, 'Compression ratio', false);
INSERT INTO public.options VALUES (23870, 5969, 'Datasets are sorted', false);
INSERT INTO public.options VALUES (23871, 5969, 'Rewards are compressed', false);
INSERT INTO public.options VALUES (23872, 5969, 'Policies are removed', false);
INSERT INTO public.options VALUES (23874, 5970, 'Sorting training', false);
INSERT INTO public.options VALUES (23875, 5970, 'Compression training', false);
INSERT INTO public.options VALUES (23876, 5970, 'Dataset pruning', false);
INSERT INTO public.options VALUES (23878, 5971, 'Sorting independently', false);
INSERT INTO public.options VALUES (23879, 5971, 'Compressing independently', false);
INSERT INTO public.options VALUES (23880, 5971, 'Deleting independently', false);
INSERT INTO public.options VALUES (23882, 5972, 'Sorting databases', false);
INSERT INTO public.options VALUES (23883, 5972, 'File compression', false);
INSERT INTO public.options VALUES (23884, 5972, 'Static query processing', false);
INSERT INTO public.options VALUES (23886, 5973, 'Sort datasets', false);
INSERT INTO public.options VALUES (23887, 5973, 'Compress signals', false);
INSERT INTO public.options VALUES (23888, 5973, 'Remove rewards', false);
INSERT INTO public.options VALUES (23890, 5974, 'Sorting equilibrium', false);
INSERT INTO public.options VALUES (23891, 5974, 'Compression equilibrium', false);
INSERT INTO public.options VALUES (23892, 5974, 'Dataset equilibrium', false);
INSERT INTO public.options VALUES (23894, 5975, 'Sorted reward', false);
INSERT INTO public.options VALUES (23895, 5975, 'Compressed reward', false);
INSERT INTO public.options VALUES (23896, 5975, 'Deleted reward', false);
INSERT INTO public.options VALUES (23898, 5976, 'Datasets shrink', false);
INSERT INTO public.options VALUES (23899, 5976, 'Sorting fails', false);
INSERT INTO public.options VALUES (23900, 5976, 'Compression increases', false);
INSERT INTO public.options VALUES (23902, 5977, 'Sorting critic', false);
INSERT INTO public.options VALUES (23903, 5977, 'Compression critic', false);
INSERT INTO public.options VALUES (23904, 5977, 'Dataset critic', false);
INSERT INTO public.options VALUES (23906, 5978, 'Sorting tasks', false);
INSERT INTO public.options VALUES (23907, 5978, 'File compression', false);
INSERT INTO public.options VALUES (23908, 5978, 'Static indexing', false);
INSERT INTO public.options VALUES (23910, 5979, 'Sort datasets', false);
INSERT INTO public.options VALUES (23911, 5979, 'Compress rewards', false);
INSERT INTO public.options VALUES (23912, 5979, 'Delete policies', false);
INSERT INTO public.options VALUES (23914, 5980, 'Dataset size only', false);
INSERT INTO public.options VALUES (23915, 5980, 'Sorting depth', false);
INSERT INTO public.options VALUES (23916, 5980, 'Compression blocks', false);
INSERT INTO public.options VALUES (23918, 5981, 'Dataset compression technique', false);
INSERT INTO public.options VALUES (23919, 5981, 'Sorting framework', false);
INSERT INTO public.options VALUES (23920, 5981, 'Static rule method', false);


--
-- Data for Name: options_backup; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.options_backup VALUES (1, 1, 'Collection of elements of same type');
INSERT INTO public.options_backup VALUES (2, 1, 'Collection of different data types');
INSERT INTO public.options_backup VALUES (3, 1, 'Dynamic structure');
INSERT INTO public.options_backup VALUES (4, 1, 'Tree structure');
INSERT INTO public.options_backup VALUES (5, 2, 'Random memory');
INSERT INTO public.options_backup VALUES (6, 2, 'Contiguous memory');
INSERT INTO public.options_backup VALUES (7, 2, 'Heap only');
INSERT INTO public.options_backup VALUES (8, 2, 'Stack only');
INSERT INTO public.options_backup VALUES (9, 3, '0');
INSERT INTO public.options_backup VALUES (10, 3, '1');
INSERT INTO public.options_backup VALUES (11, 3, '-1');
INSERT INTO public.options_backup VALUES (12, 3, 'Depends');
INSERT INTO public.options_backup VALUES (13, 4, 'O(n)');
INSERT INTO public.options_backup VALUES (14, 4, 'O(log n)');
INSERT INTO public.options_backup VALUES (15, 4, 'O(1)');
INSERT INTO public.options_backup VALUES (16, 4, 'O(n²)');
INSERT INTO public.options_backup VALUES (17, 5, 'Slow access');
INSERT INTO public.options_backup VALUES (18, 5, 'Fixed size');
INSERT INTO public.options_backup VALUES (19, 5, 'Complex syntax');
INSERT INTO public.options_backup VALUES (20, 5, 'High memory');
INSERT INTO public.options_backup VALUES (21, 6, 'Access');
INSERT INTO public.options_backup VALUES (22, 6, 'Insertion');
INSERT INTO public.options_backup VALUES (23, 6, 'Reading');
INSERT INTO public.options_backup VALUES (24, 6, 'Indexing');
INSERT INTO public.options_backup VALUES (25, 7, 'Dynamic');
INSERT INTO public.options_backup VALUES (26, 7, 'Fixed');
INSERT INTO public.options_backup VALUES (27, 7, 'Random');
INSERT INTO public.options_backup VALUES (28, 7, 'Unlimited');
INSERT INTO public.options_backup VALUES (29, 8, 'Linear');
INSERT INTO public.options_backup VALUES (30, 8, 'Binary');
INSERT INTO public.options_backup VALUES (31, 8, 'Both');
INSERT INTO public.options_backup VALUES (32, 8, 'None');
INSERT INTO public.options_backup VALUES (33, 9, 'Sorted array');
INSERT INTO public.options_backup VALUES (34, 9, 'Small array');
INSERT INTO public.options_backup VALUES (35, 9, 'Linked list');
INSERT INTO public.options_backup VALUES (36, 9, 'Tree');
INSERT INTO public.options_backup VALUES (37, 10, '1D');
INSERT INTO public.options_backup VALUES (38, 10, '2D');
INSERT INTO public.options_backup VALUES (39, 10, '3D');
INSERT INTO public.options_backup VALUES (40, 10, 'Jagged');
INSERT INTO public.options_backup VALUES (41, 11, 'O(1)');
INSERT INTO public.options_backup VALUES (42, 11, 'O(log n)');
INSERT INTO public.options_backup VALUES (43, 11, 'O(n)');
INSERT INTO public.options_backup VALUES (44, 11, 'O(n²)');
INSERT INTO public.options_backup VALUES (45, 12, 'Array');
INSERT INTO public.options_backup VALUES (46, 12, 'Linked List');
INSERT INTO public.options_backup VALUES (47, 12, 'Stack');
INSERT INTO public.options_backup VALUES (48, 12, 'Queue');
INSERT INTO public.options_backup VALUES (49, 13, 'At compile time');
INSERT INTO public.options_backup VALUES (50, 13, 'At runtime');
INSERT INTO public.options_backup VALUES (51, 13, 'Both');
INSERT INTO public.options_backup VALUES (52, 13, 'Never');
INSERT INTO public.options_backup VALUES (53, 14, '0');
INSERT INTO public.options_backup VALUES (54, 14, '1');
INSERT INTO public.options_backup VALUES (55, 14, 'Depends on OS');
INSERT INTO public.options_backup VALUES (56, 14, '-1');
INSERT INTO public.options_backup VALUES (57, 15, 'Array');
INSERT INTO public.options_backup VALUES (58, 15, 'Linked List');
INSERT INTO public.options_backup VALUES (59, 15, 'Same');
INSERT INTO public.options_backup VALUES (60, 15, 'Depends');
INSERT INTO public.options_backup VALUES (61, 16, 'O(1)');
INSERT INTO public.options_backup VALUES (62, 16, 'O(n)');
INSERT INTO public.options_backup VALUES (63, 16, 'O(log n)');
INSERT INTO public.options_backup VALUES (64, 16, 'O(n²)');
INSERT INTO public.options_backup VALUES (65, 17, 'O(1)');
INSERT INTO public.options_backup VALUES (66, 17, 'O(log n)');
INSERT INTO public.options_backup VALUES (67, 17, 'O(n)');
INSERT INTO public.options_backup VALUES (68, 17, 'O(n²)');
INSERT INTO public.options_backup VALUES (69, 18, '2D');
INSERT INTO public.options_backup VALUES (70, 18, 'Jagged');
INSERT INTO public.options_backup VALUES (71, 18, '3D');
INSERT INTO public.options_backup VALUES (72, 18, 'Static');
INSERT INTO public.options_backup VALUES (73, 19, 'Heap');
INSERT INTO public.options_backup VALUES (74, 19, 'Stack');
INSERT INTO public.options_backup VALUES (75, 19, 'Contiguous blocks');
INSERT INTO public.options_backup VALUES (76, 19, 'Registers');
INSERT INTO public.options_backup VALUES (77, 20, 'Frequent insertions');
INSERT INTO public.options_backup VALUES (78, 20, 'Random access');
INSERT INTO public.options_backup VALUES (79, 20, 'Dynamic resizing');
INSERT INTO public.options_backup VALUES (80, 20, 'Recursion');
INSERT INTO public.options_backup VALUES (81, 21, 'Data Structure Algorithm');
INSERT INTO public.options_backup VALUES (82, 21, 'Data Science Analysis');
INSERT INTO public.options_backup VALUES (83, 21, 'Data Structures and Algorithms');
INSERT INTO public.options_backup VALUES (84, 21, 'Data Storage Algorithm');
INSERT INTO public.options_backup VALUES (85, 22, 'A programming language');
INSERT INTO public.options_backup VALUES (86, 22, 'A way to store and organize data');
INSERT INTO public.options_backup VALUES (87, 22, 'A compiler');
INSERT INTO public.options_backup VALUES (88, 22, 'An operating system');
INSERT INTO public.options_backup VALUES (89, 23, 'A hardware device');
INSERT INTO public.options_backup VALUES (90, 23, 'A step-by-step procedure');
INSERT INTO public.options_backup VALUES (91, 23, 'A database');
INSERT INTO public.options_backup VALUES (92, 23, 'A programming language');
INSERT INTO public.options_backup VALUES (93, 24, 'Tree');
INSERT INTO public.options_backup VALUES (94, 24, 'Graph');
INSERT INTO public.options_backup VALUES (95, 24, 'Stack');
INSERT INTO public.options_backup VALUES (96, 24, 'Heap');
INSERT INTO public.options_backup VALUES (97, 25, 'Array');
INSERT INTO public.options_backup VALUES (98, 25, 'Queue');
INSERT INTO public.options_backup VALUES (99, 25, 'Stack');
INSERT INTO public.options_backup VALUES (100, 25, 'Tree');
INSERT INTO public.options_backup VALUES (101, 26, 'To increase code length');
INSERT INTO public.options_backup VALUES (102, 26, 'To optimize performance');
INSERT INTO public.options_backup VALUES (103, 26, 'To reduce UI bugs');
INSERT INTO public.options_backup VALUES (104, 26, 'To write HTML');
INSERT INTO public.options_backup VALUES (105, 27, 'Queue');
INSERT INTO public.options_backup VALUES (106, 27, 'Stack');
INSERT INTO public.options_backup VALUES (107, 27, 'Array');
INSERT INTO public.options_backup VALUES (108, 27, 'Tree');
INSERT INTO public.options_backup VALUES (109, 28, 'Stack');
INSERT INTO public.options_backup VALUES (110, 28, 'Queue');
INSERT INTO public.options_backup VALUES (111, 28, 'Tree');
INSERT INTO public.options_backup VALUES (112, 28, 'Graph');
INSERT INTO public.options_backup VALUES (113, 29, 'Array');
INSERT INTO public.options_backup VALUES (114, 29, 'Stack');
INSERT INTO public.options_backup VALUES (115, 29, 'Algorithm');
INSERT INTO public.options_backup VALUES (116, 29, 'Queue');
INSERT INTO public.options_backup VALUES (117, 30, 'Ticket counter');
INSERT INTO public.options_backup VALUES (118, 30, 'Undo/Redo');
INSERT INTO public.options_backup VALUES (119, 30, 'ATM queue');
INSERT INTO public.options_backup VALUES (120, 30, 'Traffic signal');
INSERT INTO public.options_backup VALUES (121, 31, 'Undo operation');
INSERT INTO public.options_backup VALUES (122, 31, 'Stack of plates');
INSERT INTO public.options_backup VALUES (123, 31, 'Line at bank');
INSERT INTO public.options_backup VALUES (124, 31, 'Recursion');
INSERT INTO public.options_backup VALUES (125, 32, 'Array');
INSERT INTO public.options_backup VALUES (126, 32, 'Stack');
INSERT INTO public.options_backup VALUES (127, 32, 'Hash Table');
INSERT INTO public.options_backup VALUES (128, 32, 'Queue');
INSERT INTO public.options_backup VALUES (129, 33, 'Array');
INSERT INTO public.options_backup VALUES (130, 33, 'Linked List');
INSERT INTO public.options_backup VALUES (131, 33, 'Static array');
INSERT INTO public.options_backup VALUES (132, 33, 'Tuple');
INSERT INTO public.options_backup VALUES (133, 34, 'Queue');
INSERT INTO public.options_backup VALUES (134, 34, 'Stack');
INSERT INTO public.options_backup VALUES (135, 34, 'Array');
INSERT INTO public.options_backup VALUES (136, 34, 'Graph');
INSERT INTO public.options_backup VALUES (137, 35, 'Array');
INSERT INTO public.options_backup VALUES (138, 35, 'Linked List');
INSERT INTO public.options_backup VALUES (139, 35, 'Stack');
INSERT INTO public.options_backup VALUES (140, 35, 'Queue');
INSERT INTO public.options_backup VALUES (141, 36, 'Java');
INSERT INTO public.options_backup VALUES (142, 36, 'C++');
INSERT INTO public.options_backup VALUES (143, 36, 'Python');
INSERT INTO public.options_backup VALUES (144, 36, 'Algorithm');
INSERT INTO public.options_backup VALUES (145, 37, 'UI design');
INSERT INTO public.options_backup VALUES (146, 37, 'Efficient problem solving');
INSERT INTO public.options_backup VALUES (147, 37, 'Web styling');
INSERT INTO public.options_backup VALUES (148, 37, 'Animations');
INSERT INTO public.options_backup VALUES (149, 38, 'Array');
INSERT INTO public.options_backup VALUES (150, 38, 'Queue');
INSERT INTO public.options_backup VALUES (151, 38, 'Tree');
INSERT INTO public.options_backup VALUES (152, 38, 'Stack');
INSERT INTO public.options_backup VALUES (153, 39, 'Graph');
INSERT INTO public.options_backup VALUES (154, 39, 'Array');
INSERT INTO public.options_backup VALUES (155, 39, 'Stack');
INSERT INTO public.options_backup VALUES (156, 39, 'Queue');
INSERT INTO public.options_backup VALUES (157, 40, 'Graphic design');
INSERT INTO public.options_backup VALUES (158, 40, 'Game logic');
INSERT INTO public.options_backup VALUES (159, 40, 'Problem solving');
INSERT INTO public.options_backup VALUES (160, 40, 'Video editing');
INSERT INTO public.options_backup VALUES (161, 41, 'Divisible by 1 & itself');
INSERT INTO public.options_backup VALUES (162, 41, 'Even number');
INSERT INTO public.options_backup VALUES (163, 41, 'Odd number');
INSERT INTO public.options_backup VALUES (164, 41, 'Composite');
INSERT INTO public.options_backup VALUES (165, 42, 'Prime');
INSERT INTO public.options_backup VALUES (166, 42, 'Composite');
INSERT INTO public.options_backup VALUES (167, 42, 'Odd');
INSERT INTO public.options_backup VALUES (168, 42, 'None');
INSERT INTO public.options_backup VALUES (169, 43, 'Least Common Multiple');
INSERT INTO public.options_backup VALUES (170, 43, 'Large Common Multiple');
INSERT INTO public.options_backup VALUES (171, 43, 'Lowest Common Mode');
INSERT INTO public.options_backup VALUES (172, 43, 'None');
INSERT INTO public.options_backup VALUES (173, 44, 'Greatest Common Divisor');
INSERT INTO public.options_backup VALUES (174, 44, 'Global Common Divisor');
INSERT INTO public.options_backup VALUES (175, 44, 'General Common Divisor');
INSERT INTO public.options_backup VALUES (176, 44, 'None');
INSERT INTO public.options_backup VALUES (177, 45, 'Quotient');
INSERT INTO public.options_backup VALUES (178, 45, 'Remainder');
INSERT INTO public.options_backup VALUES (179, 45, 'Product');
INSERT INTO public.options_backup VALUES (180, 45, 'Sum');
INSERT INTO public.options_backup VALUES (181, 46, '3');
INSERT INTO public.options_backup VALUES (182, 46, '2');
INSERT INTO public.options_backup VALUES (183, 46, '5');
INSERT INTO public.options_backup VALUES (184, 46, '7');
INSERT INTO public.options_backup VALUES (185, 47, '0');
INSERT INTO public.options_backup VALUES (186, 47, '2');
INSERT INTO public.options_backup VALUES (187, 47, '4');
INSERT INTO public.options_backup VALUES (188, 47, '1');
INSERT INTO public.options_backup VALUES (189, 48, '0');
INSERT INTO public.options_backup VALUES (190, 48, '1');
INSERT INTO public.options_backup VALUES (191, 48, 'Undefined');
INSERT INTO public.options_backup VALUES (192, 48, 'Infinity');
INSERT INTO public.options_backup VALUES (193, 49, '1');
INSERT INTO public.options_backup VALUES (194, 49, '3');
INSERT INTO public.options_backup VALUES (195, 49, '0');
INSERT INTO public.options_backup VALUES (196, 49, '2');
INSERT INTO public.options_backup VALUES (197, 50, '+');
INSERT INTO public.options_backup VALUES (198, 50, '*');
INSERT INTO public.options_backup VALUES (199, 50, '^');
INSERT INTO public.options_backup VALUES (200, 50, '%');
INSERT INTO public.options_backup VALUES (201, 51, 'Logic');
INSERT INTO public.options_backup VALUES (202, 51, 'Optimization');
INSERT INTO public.options_backup VALUES (203, 51, 'Efficiency');
INSERT INTO public.options_backup VALUES (204, 51, 'All');
INSERT INTO public.options_backup VALUES (205, 52, '0,1');
INSERT INTO public.options_backup VALUES (206, 52, '1,2');
INSERT INTO public.options_backup VALUES (207, 52, '2,3');
INSERT INTO public.options_backup VALUES (208, 52, '1,3');
INSERT INTO public.options_backup VALUES (209, 53, 'Infinite');
INSERT INTO public.options_backup VALUES (210, 53, 'Limited');
INSERT INTO public.options_backup VALUES (211, 53, 'Odd only');
INSERT INTO public.options_backup VALUES (212, 53, 'Even only');
INSERT INTO public.options_backup VALUES (213, 54, '10');
INSERT INTO public.options_backup VALUES (214, 54, '20');
INSERT INTO public.options_backup VALUES (215, 54, '25');
INSERT INTO public.options_backup VALUES (216, 54, '30');
INSERT INTO public.options_backup VALUES (217, 55, '9');
INSERT INTO public.options_backup VALUES (218, 55, '27');
INSERT INTO public.options_backup VALUES (219, 55, '18');
INSERT INTO public.options_backup VALUES (220, 55, '6');
INSERT INTO public.options_backup VALUES (221, 56, '2');
INSERT INTO public.options_backup VALUES (222, 56, '8');
INSERT INTO public.options_backup VALUES (223, 56, '10');
INSERT INTO public.options_backup VALUES (224, 56, '16');
INSERT INTO public.options_backup VALUES (225, 57, '2');
INSERT INTO public.options_backup VALUES (226, 57, '8');
INSERT INTO public.options_backup VALUES (227, 57, '10');
INSERT INTO public.options_backup VALUES (228, 57, '16');
INSERT INTO public.options_backup VALUES (229, 58, 'Yes');
INSERT INTO public.options_backup VALUES (230, 58, 'No');
INSERT INTO public.options_backup VALUES (231, 58, 'Sometimes');
INSERT INTO public.options_backup VALUES (232, 58, 'Rarely');
INSERT INTO public.options_backup VALUES (233, 59, '1');
INSERT INTO public.options_backup VALUES (234, 59, '5');
INSERT INTO public.options_backup VALUES (235, 59, '10');
INSERT INTO public.options_backup VALUES (236, 59, '15');
INSERT INTO public.options_backup VALUES (237, 60, '12');
INSERT INTO public.options_backup VALUES (238, 60, '24');
INSERT INTO public.options_backup VALUES (239, 60, '6');
INSERT INTO public.options_backup VALUES (240, 60, '4');
INSERT INTO public.options_backup VALUES (241, 61, 'Loop');
INSERT INTO public.options_backup VALUES (242, 61, 'Stack');
INSERT INTO public.options_backup VALUES (243, 61, 'Queue');
INSERT INTO public.options_backup VALUES (244, 61, 'Graph');
INSERT INTO public.options_backup VALUES (245, 62, 'Queue');
INSERT INTO public.options_backup VALUES (246, 62, 'Stack');
INSERT INTO public.options_backup VALUES (247, 62, 'Graph');
INSERT INTO public.options_backup VALUES (248, 62, 'Tree');
INSERT INTO public.options_backup VALUES (249, 63, 'Sorting');
INSERT INTO public.options_backup VALUES (250, 63, 'Traversal');
INSERT INTO public.options_backup VALUES (251, 63, 'Hashing');
INSERT INTO public.options_backup VALUES (252, 63, 'Graph');
INSERT INTO public.options_backup VALUES (253, 64, 'Sorted array');
INSERT INTO public.options_backup VALUES (254, 64, 'Unsorted');
INSERT INTO public.options_backup VALUES (255, 64, 'Linked list');
INSERT INTO public.options_backup VALUES (256, 64, 'Graph');
INSERT INTO public.options_backup VALUES (257, 65, 'Loop');
INSERT INTO public.options_backup VALUES (258, 65, 'Set');
INSERT INTO public.options_backup VALUES (259, 65, 'Array');
INSERT INTO public.options_backup VALUES (260, 65, 'Stack');
INSERT INTO public.options_backup VALUES (261, 66, 'Stack');
INSERT INTO public.options_backup VALUES (262, 66, 'Queue');
INSERT INTO public.options_backup VALUES (263, 66, 'Both');
INSERT INTO public.options_backup VALUES (264, 66, 'None');
INSERT INTO public.options_backup VALUES (265, 67, 'Sorting');
INSERT INTO public.options_backup VALUES (266, 67, 'Hashing');
INSERT INTO public.options_backup VALUES (267, 67, 'Both');
INSERT INTO public.options_backup VALUES (268, 67, 'None');
INSERT INTO public.options_backup VALUES (269, 68, 'Hash map');
INSERT INTO public.options_backup VALUES (270, 68, 'Loop');
INSERT INTO public.options_backup VALUES (271, 68, 'Both');
INSERT INTO public.options_backup VALUES (272, 68, 'None');
INSERT INTO public.options_backup VALUES (273, 69, 'Start');
INSERT INTO public.options_backup VALUES (274, 69, 'End');
INSERT INTO public.options_backup VALUES (275, 69, 'Stop condition');
INSERT INTO public.options_backup VALUES (276, 69, 'None');
INSERT INTO public.options_backup VALUES (277, 70, 'O(n)');
INSERT INTO public.options_backup VALUES (278, 70, 'O(n²)');
INSERT INTO public.options_backup VALUES (279, 70, 'O(2^n)');
INSERT INTO public.options_backup VALUES (280, 70, 'O(log n)');
INSERT INTO public.options_backup VALUES (281, 71, 'Subarray');
INSERT INTO public.options_backup VALUES (282, 71, 'Sorting');
INSERT INTO public.options_backup VALUES (283, 71, 'Graph');
INSERT INTO public.options_backup VALUES (284, 71, 'Tree');
INSERT INTO public.options_backup VALUES (285, 72, 'Queries');
INSERT INTO public.options_backup VALUES (286, 72, 'Sorting');
INSERT INTO public.options_backup VALUES (287, 72, 'Searching');
INSERT INTO public.options_backup VALUES (288, 72, 'Deletion');
INSERT INTO public.options_backup VALUES (289, 73, 'DFS');
INSERT INTO public.options_backup VALUES (290, 73, 'BFS');
INSERT INTO public.options_backup VALUES (291, 73, 'Sorting');
INSERT INTO public.options_backup VALUES (292, 73, 'Queue');
INSERT INTO public.options_backup VALUES (293, 74, 'BFS');
INSERT INTO public.options_backup VALUES (294, 74, 'DFS');
INSERT INTO public.options_backup VALUES (295, 74, 'Recursion');
INSERT INTO public.options_backup VALUES (296, 74, 'Sorting');
INSERT INTO public.options_backup VALUES (297, 75, 'Speed');
INSERT INTO public.options_backup VALUES (298, 75, 'Operations');
INSERT INTO public.options_backup VALUES (299, 75, 'Memory');
INSERT INTO public.options_backup VALUES (300, 75, 'UI');
INSERT INTO public.options_backup VALUES (301, 76, 'Extra memory');
INSERT INTO public.options_backup VALUES (302, 76, 'Input size');
INSERT INTO public.options_backup VALUES (303, 76, 'Output size');
INSERT INTO public.options_backup VALUES (304, 76, 'Time');
INSERT INTO public.options_backup VALUES (305, 77, 'Practice');
INSERT INTO public.options_backup VALUES (306, 77, 'Reading');
INSERT INTO public.options_backup VALUES (307, 77, 'Watching');
INSERT INTO public.options_backup VALUES (308, 77, 'Skipping');
INSERT INTO public.options_backup VALUES (309, 78, 'Logic');
INSERT INTO public.options_backup VALUES (310, 78, 'Coding');
INSERT INTO public.options_backup VALUES (311, 78, 'Confidence');
INSERT INTO public.options_backup VALUES (312, 78, 'All');
INSERT INTO public.options_backup VALUES (313, 79, 'Boundary input');
INSERT INTO public.options_backup VALUES (314, 79, 'Normal case');
INSERT INTO public.options_backup VALUES (315, 79, 'Wrong input');
INSERT INTO public.options_backup VALUES (316, 79, 'None');
INSERT INTO public.options_backup VALUES (317, 80, 'Perfect');
INSERT INTO public.options_backup VALUES (318, 80, 'Confused');
INSERT INTO public.options_backup VALUES (319, 80, 'Slow');
INSERT INTO public.options_backup VALUES (320, 80, 'None');
INSERT INTO public.options_backup VALUES (321, 81, 'LIFO');
INSERT INTO public.options_backup VALUES (322, 81, 'FIFO');
INSERT INTO public.options_backup VALUES (323, 81, 'Random');
INSERT INTO public.options_backup VALUES (324, 81, 'Priority');
INSERT INTO public.options_backup VALUES (325, 82, 'Insert');
INSERT INTO public.options_backup VALUES (326, 82, 'Delete');
INSERT INTO public.options_backup VALUES (327, 82, 'View');
INSERT INTO public.options_backup VALUES (328, 82, 'Sort');
INSERT INTO public.options_backup VALUES (329, 83, 'Front');
INSERT INTO public.options_backup VALUES (330, 83, 'Rear');
INSERT INTO public.options_backup VALUES (331, 83, 'Middle');
INSERT INTO public.options_backup VALUES (332, 83, 'Any');
INSERT INTO public.options_backup VALUES (333, 84, 'Undo');
INSERT INTO public.options_backup VALUES (334, 84, 'Call stack');
INSERT INTO public.options_backup VALUES (335, 84, 'Ticket line');
INSERT INTO public.options_backup VALUES (336, 84, 'Sorting');
INSERT INTO public.options_backup VALUES (337, 85, 'Scheduling');
INSERT INTO public.options_backup VALUES (338, 85, 'Undo');
INSERT INTO public.options_backup VALUES (339, 85, 'Recursion');
INSERT INTO public.options_backup VALUES (340, 85, 'Parsing');
INSERT INTO public.options_backup VALUES (341, 86, 'Full');
INSERT INTO public.options_backup VALUES (342, 86, 'Empty');
INSERT INTO public.options_backup VALUES (343, 86, 'Sorted');
INSERT INTO public.options_backup VALUES (344, 86, 'Deleted');
INSERT INTO public.options_backup VALUES (345, 87, 'Empty');
INSERT INTO public.options_backup VALUES (346, 87, 'Full');
INSERT INTO public.options_backup VALUES (347, 87, 'Sorted');
INSERT INTO public.options_backup VALUES (348, 87, 'Deleted');
INSERT INTO public.options_backup VALUES (349, 88, 'Linear DS');
INSERT INTO public.options_backup VALUES (350, 88, 'Non-linear DS');
INSERT INTO public.options_backup VALUES (351, 88, 'Tree');
INSERT INTO public.options_backup VALUES (352, 88, 'Graph');
INSERT INTO public.options_backup VALUES (353, 89, 'Space');
INSERT INTO public.options_backup VALUES (354, 89, 'Speed');
INSERT INTO public.options_backup VALUES (355, 89, 'Security');
INSERT INTO public.options_backup VALUES (356, 89, 'UI');
INSERT INTO public.options_backup VALUES (357, 90, 'Array');
INSERT INTO public.options_backup VALUES (358, 90, 'Linked list');
INSERT INTO public.options_backup VALUES (359, 90, 'Both');
INSERT INTO public.options_backup VALUES (360, 90, 'None');
INSERT INTO public.options_backup VALUES (361, 91, 'First element');
INSERT INTO public.options_backup VALUES (362, 91, 'Last');
INSERT INTO public.options_backup VALUES (363, 91, 'Middle');
INSERT INTO public.options_backup VALUES (364, 91, 'None');
INSERT INTO public.options_backup VALUES (365, 92, 'Last element');
INSERT INTO public.options_backup VALUES (366, 92, 'First');
INSERT INTO public.options_backup VALUES (367, 92, 'Middle');
INSERT INTO public.options_backup VALUES (368, 92, 'None');
INSERT INTO public.options_backup VALUES (369, 93, 'FIFO');
INSERT INTO public.options_backup VALUES (370, 93, 'Highest priority');
INSERT INTO public.options_backup VALUES (371, 93, 'Random');
INSERT INTO public.options_backup VALUES (372, 93, 'Last');
INSERT INTO public.options_backup VALUES (373, 94, 'Allowed');
INSERT INTO public.options_backup VALUES (374, 94, 'Not allowed');
INSERT INTO public.options_backup VALUES (375, 94, 'Partial');
INSERT INTO public.options_backup VALUES (376, 94, 'None');
INSERT INTO public.options_backup VALUES (377, 95, 'Yes');
INSERT INTO public.options_backup VALUES (378, 95, 'No');
INSERT INTO public.options_backup VALUES (379, 95, 'Sometimes');
INSERT INTO public.options_backup VALUES (380, 95, 'Never');
INSERT INTO public.options_backup VALUES (381, 96, 'Rear');
INSERT INTO public.options_backup VALUES (382, 96, 'Front');
INSERT INTO public.options_backup VALUES (383, 96, 'Middle');
INSERT INTO public.options_backup VALUES (384, 96, 'Any');
INSERT INTO public.options_backup VALUES (385, 97, 'Front');
INSERT INTO public.options_backup VALUES (386, 97, 'Rear');
INSERT INTO public.options_backup VALUES (387, 97, 'Any');
INSERT INTO public.options_backup VALUES (388, 97, 'Middle');
INSERT INTO public.options_backup VALUES (389, 98, 'Deque');
INSERT INTO public.options_backup VALUES (390, 98, 'Stack');
INSERT INTO public.options_backup VALUES (391, 98, 'Heap');
INSERT INTO public.options_backup VALUES (392, 98, 'Tree');
INSERT INTO public.options_backup VALUES (393, 99, 'No');
INSERT INTO public.options_backup VALUES (394, 99, 'Yes');
INSERT INTO public.options_backup VALUES (395, 99, 'Same');
INSERT INTO public.options_backup VALUES (396, 99, 'Depends');
INSERT INTO public.options_backup VALUES (397, 100, 'Order');
INSERT INTO public.options_backup VALUES (398, 100, 'Priority');
INSERT INTO public.options_backup VALUES (399, 100, 'Random');
INSERT INTO public.options_backup VALUES (400, 100, 'None');
INSERT INTO public.options_backup VALUES (401, 101, 'Sorting data');
INSERT INTO public.options_backup VALUES (402, 101, 'Finding an element in data');
INSERT INTO public.options_backup VALUES (403, 101, 'Deleting data');
INSERT INTO public.options_backup VALUES (404, 101, 'Updating data');
INSERT INTO public.options_backup VALUES (405, 102, 'Binary Search');
INSERT INTO public.options_backup VALUES (406, 102, 'Linear Search');
INSERT INTO public.options_backup VALUES (407, 102, 'Jump Search');
INSERT INTO public.options_backup VALUES (408, 102, 'Interpolation Search');
INSERT INTO public.options_backup VALUES (409, 103, 'O(1)');
INSERT INTO public.options_backup VALUES (410, 103, 'O(log n)');
INSERT INTO public.options_backup VALUES (411, 103, 'O(n)');
INSERT INTO public.options_backup VALUES (412, 103, 'O(n log n)');
INSERT INTO public.options_backup VALUES (413, 104, 'Unsorted array');
INSERT INTO public.options_backup VALUES (414, 104, 'Sorted array');
INSERT INTO public.options_backup VALUES (415, 104, 'Linked list');
INSERT INTO public.options_backup VALUES (416, 104, 'Graph');
INSERT INTO public.options_backup VALUES (417, 105, 'O(n)');
INSERT INTO public.options_backup VALUES (418, 105, 'O(log n)');
INSERT INTO public.options_backup VALUES (419, 105, 'O(n²)');
INSERT INTO public.options_backup VALUES (420, 105, 'O(1)');
INSERT INTO public.options_backup VALUES (421, 106, 'Linear');
INSERT INTO public.options_backup VALUES (422, 106, 'Binary');
INSERT INTO public.options_backup VALUES (423, 106, 'Jump');
INSERT INTO public.options_backup VALUES (424, 106, 'DFS');
INSERT INTO public.options_backup VALUES (425, 107, 'Sequential search');
INSERT INTO public.options_backup VALUES (426, 107, 'Divide search');
INSERT INTO public.options_backup VALUES (427, 107, 'Fast search');
INSERT INTO public.options_backup VALUES (428, 107, 'Hash search');
INSERT INTO public.options_backup VALUES (429, 108, 'O(n)');
INSERT INTO public.options_backup VALUES (430, 108, 'O(log n)');
INSERT INTO public.options_backup VALUES (431, 108, 'O(1)');
INSERT INTO public.options_backup VALUES (432, 108, 'O(n log n)');
INSERT INTO public.options_backup VALUES (433, 109, 'Greedy');
INSERT INTO public.options_backup VALUES (434, 109, 'Divide & Conquer');
INSERT INTO public.options_backup VALUES (435, 109, 'Dynamic');
INSERT INTO public.options_backup VALUES (436, 109, 'Backtracking');
INSERT INTO public.options_backup VALUES (437, 110, 'O(1)');
INSERT INTO public.options_backup VALUES (438, 110, 'O(log n)');
INSERT INTO public.options_backup VALUES (439, 110, 'O(n)');
INSERT INTO public.options_backup VALUES (440, 110, 'O(n²)');
INSERT INTO public.options_backup VALUES (441, 111, 'Arranging data');
INSERT INTO public.options_backup VALUES (442, 111, 'Locating data');
INSERT INTO public.options_backup VALUES (443, 111, 'Deleting data');
INSERT INTO public.options_backup VALUES (444, 111, 'Encrypting data');
INSERT INTO public.options_backup VALUES (445, 112, 'Linear');
INSERT INTO public.options_backup VALUES (446, 112, 'Binary');
INSERT INTO public.options_backup VALUES (447, 112, 'Both same');
INSERT INTO public.options_backup VALUES (448, 112, 'None');
INSERT INTO public.options_backup VALUES (449, 113, 'Array is sorted');
INSERT INTO public.options_backup VALUES (450, 113, 'Array is unsorted');
INSERT INTO public.options_backup VALUES (451, 113, 'Array is small');
INSERT INTO public.options_backup VALUES (452, 113, 'Array is empty');
INSERT INTO public.options_backup VALUES (453, 114, 'Sorted only');
INSERT INTO public.options_backup VALUES (454, 114, 'Unsorted only');
INSERT INTO public.options_backup VALUES (455, 114, 'Both');
INSERT INTO public.options_backup VALUES (456, 114, 'None');
INSERT INTO public.options_backup VALUES (457, 115, 'n');
INSERT INTO public.options_backup VALUES (458, 115, 'log n');
INSERT INTO public.options_backup VALUES (459, 115, 'n²');
INSERT INTO public.options_backup VALUES (460, 115, '1');
INSERT INTO public.options_backup VALUES (461, 116, 'Data retrieval');
INSERT INTO public.options_backup VALUES (462, 116, 'Data sorting');
INSERT INTO public.options_backup VALUES (463, 116, 'Data deletion');
INSERT INTO public.options_backup VALUES (464, 116, 'UI design');
INSERT INTO public.options_backup VALUES (465, 117, 'Binary');
INSERT INTO public.options_backup VALUES (466, 117, 'Linear');
INSERT INTO public.options_backup VALUES (467, 117, 'Merge');
INSERT INTO public.options_backup VALUES (468, 117, 'Jump');
INSERT INTO public.options_backup VALUES (469, 118, 'O(1)');
INSERT INTO public.options_backup VALUES (470, 118, 'O(log n)');
INSERT INTO public.options_backup VALUES (471, 118, 'O(n)');
INSERT INTO public.options_backup VALUES (472, 118, 'O(n²)');
INSERT INTO public.options_backup VALUES (473, 119, 'O(1)');
INSERT INTO public.options_backup VALUES (474, 119, 'O(n)');
INSERT INTO public.options_backup VALUES (475, 119, 'O(log n)');
INSERT INTO public.options_backup VALUES (476, 119, 'O(n²)');
INSERT INTO public.options_backup VALUES (477, 120, 'Speed');
INSERT INTO public.options_backup VALUES (478, 120, 'Accuracy');
INSERT INTO public.options_backup VALUES (479, 120, 'Performance');
INSERT INTO public.options_backup VALUES (480, 120, 'Efficiency');
INSERT INTO public.options_backup VALUES (481, 121, 'Finding data');
INSERT INTO public.options_backup VALUES (482, 121, 'Arranging data');
INSERT INTO public.options_backup VALUES (483, 121, 'Deleting data');
INSERT INTO public.options_backup VALUES (484, 121, 'Encrypting data');
INSERT INTO public.options_backup VALUES (485, 122, 'Merge');
INSERT INTO public.options_backup VALUES (486, 122, 'Quick');
INSERT INTO public.options_backup VALUES (487, 122, 'Bubble');
INSERT INTO public.options_backup VALUES (488, 122, 'Heap');
INSERT INTO public.options_backup VALUES (489, 123, 'O(n)');
INSERT INTO public.options_backup VALUES (490, 123, 'O(n²)');
INSERT INTO public.options_backup VALUES (491, 123, 'O(log n)');
INSERT INTO public.options_backup VALUES (492, 123, 'O(n log n)');
INSERT INTO public.options_backup VALUES (493, 124, 'Bubble');
INSERT INTO public.options_backup VALUES (494, 124, 'Insertion');
INSERT INTO public.options_backup VALUES (495, 124, 'Quick');
INSERT INTO public.options_backup VALUES (496, 124, 'Selection');
INSERT INTO public.options_backup VALUES (497, 125, 'Greedy');
INSERT INTO public.options_backup VALUES (498, 125, 'Divide & Conquer');
INSERT INTO public.options_backup VALUES (499, 125, 'Backtracking');
INSERT INTO public.options_backup VALUES (500, 125, 'DP');
INSERT INTO public.options_backup VALUES (501, 126, 'O(n)');
INSERT INTO public.options_backup VALUES (502, 126, 'O(n log n)');
INSERT INTO public.options_backup VALUES (503, 126, 'O(n²)');
INSERT INTO public.options_backup VALUES (504, 126, 'O(log n)');
INSERT INTO public.options_backup VALUES (505, 127, 'Quick');
INSERT INTO public.options_backup VALUES (506, 127, 'Heap');
INSERT INTO public.options_backup VALUES (507, 127, 'Bubble');
INSERT INTO public.options_backup VALUES (508, 127, 'Selection');
INSERT INTO public.options_backup VALUES (509, 128, 'O(n)');
INSERT INTO public.options_backup VALUES (510, 128, 'O(n²)');
INSERT INTO public.options_backup VALUES (511, 128, 'O(n log n)');
INSERT INTO public.options_backup VALUES (512, 128, 'O(log n)');
INSERT INTO public.options_backup VALUES (513, 129, 'O(n)');
INSERT INTO public.options_backup VALUES (514, 129, 'O(n²)');
INSERT INTO public.options_backup VALUES (515, 129, 'O(log n)');
INSERT INTO public.options_backup VALUES (516, 129, 'O(1)');
INSERT INTO public.options_backup VALUES (517, 130, 'O(n)');
INSERT INTO public.options_backup VALUES (518, 130, 'O(n log n)');
INSERT INTO public.options_backup VALUES (519, 130, 'O(n²)');
INSERT INTO public.options_backup VALUES (520, 130, 'O(log n)');
INSERT INTO public.options_backup VALUES (521, 131, 'Searching speed');
INSERT INTO public.options_backup VALUES (522, 131, 'UI');
INSERT INTO public.options_backup VALUES (523, 131, 'Security');
INSERT INTO public.options_backup VALUES (524, 131, 'Storage');
INSERT INTO public.options_backup VALUES (525, 132, 'Merge');
INSERT INTO public.options_backup VALUES (526, 132, 'Quick');
INSERT INTO public.options_backup VALUES (527, 132, 'Bubble');
INSERT INTO public.options_backup VALUES (528, 132, 'Insertion');
INSERT INTO public.options_backup VALUES (529, 133, 'Stack');
INSERT INTO public.options_backup VALUES (530, 133, 'Queue');
INSERT INTO public.options_backup VALUES (531, 133, 'Heap');
INSERT INTO public.options_backup VALUES (532, 133, 'Tree');
INSERT INTO public.options_backup VALUES (533, 134, 'Adjacent elements');
INSERT INTO public.options_backup VALUES (534, 134, 'Random');
INSERT INTO public.options_backup VALUES (535, 134, 'Middle');
INSERT INTO public.options_backup VALUES (536, 134, 'Ends');
INSERT INTO public.options_backup VALUES (537, 135, 'Small data');
INSERT INTO public.options_backup VALUES (538, 135, 'Huge data');
INSERT INTO public.options_backup VALUES (539, 135, 'Random data');
INSERT INTO public.options_backup VALUES (540, 135, 'Graphs');
INSERT INTO public.options_backup VALUES (541, 136, 'Ascending');
INSERT INTO public.options_backup VALUES (542, 136, 'Descending');
INSERT INTO public.options_backup VALUES (543, 136, 'Both');
INSERT INTO public.options_backup VALUES (544, 136, 'None');
INSERT INTO public.options_backup VALUES (545, 137, 'Merge');
INSERT INTO public.options_backup VALUES (546, 137, 'Quick');
INSERT INTO public.options_backup VALUES (547, 137, 'Both');
INSERT INTO public.options_backup VALUES (548, 137, 'None');
INSERT INTO public.options_backup VALUES (549, 138, 'Quick');
INSERT INTO public.options_backup VALUES (550, 138, 'Merge');
INSERT INTO public.options_backup VALUES (551, 138, 'Both');
INSERT INTO public.options_backup VALUES (552, 138, 'None');
INSERT INTO public.options_backup VALUES (553, 139, 'Keeps order');
INSERT INTO public.options_backup VALUES (554, 139, 'Fast');
INSERT INTO public.options_backup VALUES (555, 139, 'Memory efficient');
INSERT INTO public.options_backup VALUES (556, 139, 'Random');
INSERT INTO public.options_backup VALUES (557, 140, 'Binary search');
INSERT INTO public.options_backup VALUES (558, 140, 'Linear search');
INSERT INTO public.options_backup VALUES (559, 140, 'Hashing');
INSERT INTO public.options_backup VALUES (560, 140, 'Stack');
INSERT INTO public.options_backup VALUES (561, 141, 'FIFO');
INSERT INTO public.options_backup VALUES (562, 141, 'LIFO');
INSERT INTO public.options_backup VALUES (563, 141, 'Random');
INSERT INTO public.options_backup VALUES (564, 141, 'Priority');
INSERT INTO public.options_backup VALUES (565, 142, 'Remove');
INSERT INTO public.options_backup VALUES (566, 142, 'Insert');
INSERT INTO public.options_backup VALUES (567, 142, 'Peek');
INSERT INTO public.options_backup VALUES (568, 142, 'Delete');
INSERT INTO public.options_backup VALUES (569, 143, 'Bottom');
INSERT INTO public.options_backup VALUES (570, 143, 'Middle');
INSERT INTO public.options_backup VALUES (571, 143, 'Top');
INSERT INTO public.options_backup VALUES (572, 143, 'Any');
INSERT INTO public.options_backup VALUES (573, 144, 'Queue');
INSERT INTO public.options_backup VALUES (574, 144, 'Undo');
INSERT INTO public.options_backup VALUES (575, 144, 'Sorting');
INSERT INTO public.options_backup VALUES (576, 144, 'Graph');
INSERT INTO public.options_backup VALUES (577, 145, 'First');
INSERT INTO public.options_backup VALUES (578, 145, 'Last');
INSERT INTO public.options_backup VALUES (579, 145, 'Top');
INSERT INTO public.options_backup VALUES (580, 145, 'Bottom');
INSERT INTO public.options_backup VALUES (581, 146, 'Empty');
INSERT INTO public.options_backup VALUES (582, 146, 'Full');
INSERT INTO public.options_backup VALUES (583, 146, 'Sorted');
INSERT INTO public.options_backup VALUES (584, 146, 'Deleted');
INSERT INTO public.options_backup VALUES (585, 147, 'Pop empty');
INSERT INTO public.options_backup VALUES (586, 147, 'Push full');
INSERT INTO public.options_backup VALUES (587, 147, 'Peek');
INSERT INTO public.options_backup VALUES (588, 147, 'Traverse');
INSERT INTO public.options_backup VALUES (589, 148, 'Recursion');
INSERT INTO public.options_backup VALUES (590, 148, 'Queue');
INSERT INTO public.options_backup VALUES (591, 148, 'Graph');
INSERT INTO public.options_backup VALUES (592, 148, 'Array');
INSERT INTO public.options_backup VALUES (593, 149, 'Queue');
INSERT INTO public.options_backup VALUES (594, 149, 'Stack');
INSERT INTO public.options_backup VALUES (595, 149, 'Tree');
INSERT INTO public.options_backup VALUES (596, 149, 'Graph');
INSERT INTO public.options_backup VALUES (597, 150, 'Insert');
INSERT INTO public.options_backup VALUES (598, 150, 'Delete');
INSERT INTO public.options_backup VALUES (599, 150, 'View top');
INSERT INTO public.options_backup VALUES (600, 150, 'Sort');
INSERT INTO public.options_backup VALUES (601, 151, 'Linear DS');
INSERT INTO public.options_backup VALUES (602, 151, 'Non-linear DS');
INSERT INTO public.options_backup VALUES (603, 151, 'Tree');
INSERT INTO public.options_backup VALUES (604, 151, 'Graph');
INSERT INTO public.options_backup VALUES (605, 152, 'Recursion');
INSERT INTO public.options_backup VALUES (606, 152, 'Sorting');
INSERT INTO public.options_backup VALUES (607, 152, 'Searching');
INSERT INTO public.options_backup VALUES (608, 152, 'UI');
INSERT INTO public.options_backup VALUES (609, 153, 'Dynamic');
INSERT INTO public.options_backup VALUES (610, 153, 'Static');
INSERT INTO public.options_backup VALUES (611, 153, 'Heap');
INSERT INTO public.options_backup VALUES (612, 153, 'Disk');
INSERT INTO public.options_backup VALUES (613, 154, 'Fixed');
INSERT INTO public.options_backup VALUES (614, 154, 'Infinite');
INSERT INTO public.options_backup VALUES (615, 154, 'Dynamic');
INSERT INTO public.options_backup VALUES (616, 154, 'None');
INSERT INTO public.options_backup VALUES (617, 155, 'Stack');
INSERT INTO public.options_backup VALUES (618, 155, 'Queue');
INSERT INTO public.options_backup VALUES (619, 155, 'Array');
INSERT INTO public.options_backup VALUES (620, 155, 'Graph');
INSERT INTO public.options_backup VALUES (621, 156, 'Array');
INSERT INTO public.options_backup VALUES (622, 156, 'Linked List');
INSERT INTO public.options_backup VALUES (623, 156, 'Both');
INSERT INTO public.options_backup VALUES (624, 156, 'None');
INSERT INTO public.options_backup VALUES (625, 157, 'Heap');
INSERT INTO public.options_backup VALUES (626, 157, 'Stack');
INSERT INTO public.options_backup VALUES (627, 157, 'Queue');
INSERT INTO public.options_backup VALUES (628, 157, 'Array');
INSERT INTO public.options_backup VALUES (629, 158, 'Queue');
INSERT INTO public.options_backup VALUES (630, 158, 'Stack');
INSERT INTO public.options_backup VALUES (631, 158, 'Tree');
INSERT INTO public.options_backup VALUES (632, 158, 'Graph');
INSERT INTO public.options_backup VALUES (633, 159, 'Allowed');
INSERT INTO public.options_backup VALUES (634, 159, 'Not allowed');
INSERT INTO public.options_backup VALUES (635, 159, 'Partial');
INSERT INTO public.options_backup VALUES (636, 159, 'None');
INSERT INTO public.options_backup VALUES (637, 160, 'Random');
INSERT INTO public.options_backup VALUES (638, 160, 'Sequential');
INSERT INTO public.options_backup VALUES (639, 160, 'Top only');
INSERT INTO public.options_backup VALUES (640, 160, 'Bottom');
INSERT INTO public.options_backup VALUES (641, 161, 'Collection of characters');
INSERT INTO public.options_backup VALUES (642, 161, 'Collection of numbers');
INSERT INTO public.options_backup VALUES (643, 161, 'Boolean value');
INSERT INTO public.options_backup VALUES (644, 161, 'Tree node');
INSERT INTO public.options_backup VALUES (645, 162, 'Array of chars');
INSERT INTO public.options_backup VALUES (646, 162, 'Stack');
INSERT INTO public.options_backup VALUES (647, 162, 'Queue');
INSERT INTO public.options_backup VALUES (648, 162, 'Tree');
INSERT INTO public.options_backup VALUES (649, 163, '0');
INSERT INTO public.options_backup VALUES (650, 163, '1');
INSERT INTO public.options_backup VALUES (651, 163, '-1');
INSERT INTO public.options_backup VALUES (652, 163, 'Depends');
INSERT INTO public.options_backup VALUES (653, 164, 'Concatenation');
INSERT INTO public.options_backup VALUES (654, 164, 'Deletion');
INSERT INTO public.options_backup VALUES (655, 164, 'Traversal');
INSERT INTO public.options_backup VALUES (656, 164, 'All');
INSERT INTO public.options_backup VALUES (657, 165, 'O(1)');
INSERT INTO public.options_backup VALUES (658, 165, 'O(n)');
INSERT INTO public.options_backup VALUES (659, 165, 'O(log n)');
INSERT INTO public.options_backup VALUES (660, 165, 'O(n²)');
INSERT INTO public.options_backup VALUES (661, 166, 'C');
INSERT INTO public.options_backup VALUES (662, 166, 'C++');
INSERT INTO public.options_backup VALUES (663, 166, 'Java');
INSERT INTO public.options_backup VALUES (664, 166, 'Assembly');
INSERT INTO public.options_backup VALUES (665, 167, 'char[]');
INSERT INTO public.options_backup VALUES (666, 167, 'int[]');
INSERT INTO public.options_backup VALUES (667, 167, 'bool[]');
INSERT INTO public.options_backup VALUES (668, 167, 'float[]');
INSERT INTO public.options_backup VALUES (669, 168, 'Part of string');
INSERT INTO public.options_backup VALUES (670, 168, 'Whole string');
INSERT INTO public.options_backup VALUES (671, 168, 'New string only');
INSERT INTO public.options_backup VALUES (672, 168, 'Invalid');
INSERT INTO public.options_backup VALUES (673, 169, 'compare()');
INSERT INTO public.options_backup VALUES (674, 169, 'strcmp()');
INSERT INTO public.options_backup VALUES (675, 169, 'check()');
INSERT INTO public.options_backup VALUES (676, 169, 'equal()');
INSERT INTO public.options_backup VALUES (677, 170, 'O(1)');
INSERT INTO public.options_backup VALUES (678, 170, 'O(log n)');
INSERT INTO public.options_backup VALUES (679, 170, 'O(n)');
INSERT INTO public.options_backup VALUES (680, 170, 'O(n²)');
INSERT INTO public.options_backup VALUES (681, 171, 'String');
INSERT INTO public.options_backup VALUES (682, 171, 'StringBuilder');
INSERT INTO public.options_backup VALUES (683, 171, 'char');
INSERT INTO public.options_backup VALUES (684, 171, 'int');
INSERT INTO public.options_backup VALUES (685, 172, 'O(1)');
INSERT INTO public.options_backup VALUES (686, 172, 'O(n)');
INSERT INTO public.options_backup VALUES (687, 172, 'O(log n)');
INSERT INTO public.options_backup VALUES (688, 172, 'O(n²)');
INSERT INTO public.options_backup VALUES (689, 173, 'O(n)');
INSERT INTO public.options_backup VALUES (690, 173, 'O(1)');
INSERT INTO public.options_backup VALUES (691, 173, 'O(log n)');
INSERT INTO public.options_backup VALUES (692, 173, 'O(n²)');
INSERT INTO public.options_backup VALUES (693, 174, 'Pattern matching');
INSERT INTO public.options_backup VALUES (694, 174, 'Sorting');
INSERT INTO public.options_backup VALUES (695, 174, 'Searching');
INSERT INTO public.options_backup VALUES (696, 174, 'Insertion');
INSERT INTO public.options_backup VALUES (697, 175, 'American Standard Code');
INSERT INTO public.options_backup VALUES (698, 175, 'American Standard Code for Information Interchange');
INSERT INTO public.options_backup VALUES (699, 175, 'Advanced System Code');
INSERT INTO public.options_backup VALUES (700, 175, 'None');
INSERT INTO public.options_backup VALUES (701, 176, 'English');
INSERT INTO public.options_backup VALUES (702, 176, 'ASCII');
INSERT INTO public.options_backup VALUES (703, 176, 'Multiple languages');
INSERT INTO public.options_backup VALUES (704, 176, 'Binary');
INSERT INTO public.options_backup VALUES (705, 177, 'Length');
INSERT INTO public.options_backup VALUES (706, 177, 'Characters');
INSERT INTO public.options_backup VALUES (707, 177, 'Hash');
INSERT INTO public.options_backup VALUES (708, 177, 'All');
INSERT INTO public.options_backup VALUES (709, 178, 'Split');
INSERT INTO public.options_backup VALUES (710, 178, 'Join');
INSERT INTO public.options_backup VALUES (711, 178, 'Multiply');
INSERT INTO public.options_backup VALUES (712, 178, 'Replace');
INSERT INTO public.options_backup VALUES (713, 179, 'Pattern matching');
INSERT INTO public.options_backup VALUES (714, 179, 'DFS');
INSERT INTO public.options_backup VALUES (715, 179, 'BFS');
INSERT INTO public.options_backup VALUES (716, 179, 'Sorting');
INSERT INTO public.options_backup VALUES (717, 180, 'Numeric operations');
INSERT INTO public.options_backup VALUES (718, 180, 'Text processing');
INSERT INTO public.options_backup VALUES (719, 180, 'Graph traversal');
INSERT INTO public.options_backup VALUES (720, 180, 'Sorting');
INSERT INTO public.options_backup VALUES (721, 181, 'Actual execution time');
INSERT INTO public.options_backup VALUES (722, 181, 'Number of operations vs input size');
INSERT INTO public.options_backup VALUES (723, 181, 'CPU speed');
INSERT INTO public.options_backup VALUES (724, 181, 'RAM size');
INSERT INTO public.options_backup VALUES (725, 182, 'Execution time');
INSERT INTO public.options_backup VALUES (726, 182, 'Input size');
INSERT INTO public.options_backup VALUES (727, 182, 'Extra memory used');
INSERT INTO public.options_backup VALUES (728, 182, 'Output size');
INSERT INTO public.options_backup VALUES (729, 183, 'Big-O');
INSERT INTO public.options_backup VALUES (730, 183, 'Big-Ω');
INSERT INTO public.options_backup VALUES (731, 183, 'Big-Θ');
INSERT INTO public.options_backup VALUES (732, 183, 'Little-o');
INSERT INTO public.options_backup VALUES (733, 184, 'Big-O');
INSERT INTO public.options_backup VALUES (734, 184, 'Big-Ω');
INSERT INTO public.options_backup VALUES (735, 184, 'Big-Θ');
INSERT INTO public.options_backup VALUES (736, 184, 'Little-o');
INSERT INTO public.options_backup VALUES (737, 185, 'Big-O');
INSERT INTO public.options_backup VALUES (738, 185, 'Big-Ω');
INSERT INTO public.options_backup VALUES (739, 185, 'Big-Θ');
INSERT INTO public.options_backup VALUES (740, 185, 'Little-o');
INSERT INTO public.options_backup VALUES (741, 186, 'O(n)');
INSERT INTO public.options_backup VALUES (742, 186, 'O(log n)');
INSERT INTO public.options_backup VALUES (743, 186, 'O(n²)');
INSERT INTO public.options_backup VALUES (744, 186, 'O(1)');
INSERT INTO public.options_backup VALUES (745, 187, 'O(log n)');
INSERT INTO public.options_backup VALUES (746, 187, 'O(1)');
INSERT INTO public.options_backup VALUES (747, 187, 'O(n)');
INSERT INTO public.options_backup VALUES (748, 187, 'O(n log n)');
INSERT INTO public.options_backup VALUES (749, 188, 'O(n)');
INSERT INTO public.options_backup VALUES (750, 188, 'O(log n)');
INSERT INTO public.options_backup VALUES (751, 188, 'O(1)');
INSERT INTO public.options_backup VALUES (752, 188, 'O(n²)');
INSERT INTO public.options_backup VALUES (753, 189, 'O(1)');
INSERT INTO public.options_backup VALUES (754, 189, 'O(log n)');
INSERT INTO public.options_backup VALUES (755, 189, 'O(n)');
INSERT INTO public.options_backup VALUES (756, 189, 'O(n²)');
INSERT INTO public.options_backup VALUES (757, 190, 'O(n)');
INSERT INTO public.options_backup VALUES (758, 190, 'O(n log n)');
INSERT INTO public.options_backup VALUES (759, 190, 'O(n²)');
INSERT INTO public.options_backup VALUES (760, 190, 'O(2n)');
INSERT INTO public.options_backup VALUES (761, 191, 'O(1)');
INSERT INTO public.options_backup VALUES (762, 191, 'O(n)');
INSERT INTO public.options_backup VALUES (763, 191, 'O(log n)');
INSERT INTO public.options_backup VALUES (764, 191, 'O(n²)');
INSERT INTO public.options_backup VALUES (765, 192, 'Best case');
INSERT INTO public.options_backup VALUES (766, 192, 'Worst case');
INSERT INTO public.options_backup VALUES (767, 192, 'Big-O');
INSERT INTO public.options_backup VALUES (768, 192, 'Average case');
INSERT INTO public.options_backup VALUES (769, 193, 'O(n)');
INSERT INTO public.options_backup VALUES (770, 193, 'O(log n)');
INSERT INTO public.options_backup VALUES (771, 193, 'O(1)');
INSERT INTO public.options_backup VALUES (772, 193, 'O(n²)');
INSERT INTO public.options_backup VALUES (773, 194, 'O(n)');
INSERT INTO public.options_backup VALUES (774, 194, 'O(n log n)');
INSERT INTO public.options_backup VALUES (775, 194, 'O(n²)');
INSERT INTO public.options_backup VALUES (776, 194, 'O(log n)');
INSERT INTO public.options_backup VALUES (777, 195, 'O(1)');
INSERT INTO public.options_backup VALUES (778, 195, 'O(n)');
INSERT INTO public.options_backup VALUES (779, 195, 'O(log n)');
INSERT INTO public.options_backup VALUES (780, 195, 'O(n²)');
INSERT INTO public.options_backup VALUES (781, 196, 'To write more code');
INSERT INTO public.options_backup VALUES (782, 196, 'To optimize algorithms');
INSERT INTO public.options_backup VALUES (783, 196, 'To reduce UI');
INSERT INTO public.options_backup VALUES (784, 196, 'To increase RAM');
INSERT INTO public.options_backup VALUES (785, 197, 'Unsorted array');
INSERT INTO public.options_backup VALUES (786, 197, 'Sorted array');
INSERT INTO public.options_backup VALUES (787, 197, 'Graph');
INSERT INTO public.options_backup VALUES (788, 197, 'Tree');
INSERT INTO public.options_backup VALUES (789, 198, 'O(n)');
INSERT INTO public.options_backup VALUES (790, 198, 'O(log n)');
INSERT INTO public.options_backup VALUES (791, 198, 'O(n!)');
INSERT INTO public.options_backup VALUES (792, 198, 'O(n/2)');
INSERT INTO public.options_backup VALUES (793, 199, 'Best');
INSERT INTO public.options_backup VALUES (794, 199, 'Average');
INSERT INTO public.options_backup VALUES (795, 199, 'Worst');
INSERT INTO public.options_backup VALUES (796, 199, 'Random');
INSERT INTO public.options_backup VALUES (797, 200, 'UI design');
INSERT INTO public.options_backup VALUES (798, 200, 'Performance comparison');
INSERT INTO public.options_backup VALUES (799, 200, 'Styling');
INSERT INTO public.options_backup VALUES (800, 200, 'Animations');
INSERT INTO public.options_backup VALUES (801, 201, 'Yes');
INSERT INTO public.options_backup VALUES (802, 201, 'No');
INSERT INTO public.options_backup VALUES (803, 201, 'Sometimes');
INSERT INTO public.options_backup VALUES (804, 201, 'Depends');
INSERT INTO public.options_backup VALUES (805, 202, 'dfwf');
INSERT INTO public.options_backup VALUES (806, 202, 'wfwf');
INSERT INTO public.options_backup VALUES (807, 202, 'wfwf');
INSERT INTO public.options_backup VALUES (808, 202, 'wfwf');
INSERT INTO public.options_backup VALUES (809, 203, 'Immediate reward only');
INSERT INTO public.options_backup VALUES (810, 203, 'Optimal dataset');
INSERT INTO public.options_backup VALUES (811, 203, 'Value functions recursively');
INSERT INTO public.options_backup VALUES (812, 203, 'Learning rate');
INSERT INTO public.options_backup VALUES (813, 204, 'Future state values');
INSERT INTO public.options_backup VALUES (814, 204, 'Learning rate');
INSERT INTO public.options_backup VALUES (815, 204, 'Batch size');
INSERT INTO public.options_backup VALUES (816, 204, 'Dataset size');
INSERT INTO public.options_backup VALUES (817, 205, 'Random policy');
INSERT INTO public.options_backup VALUES (818, 205, 'Optimal value function');
INSERT INTO public.options_backup VALUES (819, 205, 'Exploration rate');
INSERT INTO public.options_backup VALUES (820, 205, 'Environment size');
INSERT INTO public.options_backup VALUES (821, 206, 'Divide and conquer');
INSERT INTO public.options_backup VALUES (822, 206, 'Dynamic programming');
INSERT INTO public.options_backup VALUES (823, 206, 'Clustering');
INSERT INTO public.options_backup VALUES (824, 206, 'Gradient descent');
INSERT INTO public.options_backup VALUES (825, 207, 'Q(s,a)');
INSERT INTO public.options_backup VALUES (826, 207, 'V(s)');
INSERT INTO public.options_backup VALUES (827, 207, 'R(s,a)');
INSERT INTO public.options_backup VALUES (828, 207, 'P(s)');
INSERT INTO public.options_backup VALUES (829, 208, 'V(s)');
INSERT INTO public.options_backup VALUES (830, 208, 'T(s)');
INSERT INTO public.options_backup VALUES (831, 208, 'Q(s,a)');
INSERT INTO public.options_backup VALUES (832, 208, 'R(s)');
INSERT INTO public.options_backup VALUES (833, 209, 'Alpha');
INSERT INTO public.options_backup VALUES (834, 209, 'Beta');
INSERT INTO public.options_backup VALUES (835, 209, 'Gamma');
INSERT INTO public.options_backup VALUES (836, 209, 'Theta');
INSERT INTO public.options_backup VALUES (837, 210, 'Future rewards');
INSERT INTO public.options_backup VALUES (838, 210, 'Immediate rewards');
INSERT INTO public.options_backup VALUES (839, 210, 'Infinite rewards');
INSERT INTO public.options_backup VALUES (840, 210, 'No rewards');
INSERT INTO public.options_backup VALUES (841, 211, 'Value depends on itself indirectly');
INSERT INTO public.options_backup VALUES (842, 211, 'No dependency');
INSERT INTO public.options_backup VALUES (843, 211, 'Only immediate reward matters');
INSERT INTO public.options_backup VALUES (844, 211, 'Policy is fixed');
INSERT INTO public.options_backup VALUES (845, 212, 'Minimum');
INSERT INTO public.options_backup VALUES (846, 212, 'Maximum');
INSERT INTO public.options_backup VALUES (847, 212, 'Average');
INSERT INTO public.options_backup VALUES (848, 212, 'Sum only');
INSERT INTO public.options_backup VALUES (849, 213, 'K-means');
INSERT INTO public.options_backup VALUES (850, 213, 'Linear regression');
INSERT INTO public.options_backup VALUES (851, 213, 'Value Iteration');
INSERT INTO public.options_backup VALUES (852, 213, 'Naive Bayes');
INSERT INTO public.options_backup VALUES (853, 214, 'Bellman optimality equation');
INSERT INTO public.options_backup VALUES (854, 214, 'Supervised learning rule');
INSERT INTO public.options_backup VALUES (855, 214, 'Clustering rule');
INSERT INTO public.options_backup VALUES (856, 214, 'Regression rule');
INSERT INTO public.options_backup VALUES (857, 215, 'Optimal policy only');
INSERT INTO public.options_backup VALUES (858, 215, 'Any given policy');
INSERT INTO public.options_backup VALUES (859, 215, 'Random dataset');
INSERT INTO public.options_backup VALUES (860, 215, 'No policy');
INSERT INTO public.options_backup VALUES (861, 216, 'Supervised learning');
INSERT INTO public.options_backup VALUES (862, 216, 'Reinforcement Learning');
INSERT INTO public.options_backup VALUES (863, 216, 'Clustering');
INSERT INTO public.options_backup VALUES (864, 216, 'Data preprocessing');
INSERT INTO public.options_backup VALUES (865, 217, 'Immediate reward only');
INSERT INTO public.options_backup VALUES (866, 217, 'Reward plus discounted future value');
INSERT INTO public.options_backup VALUES (867, 217, 'Learning rate');
INSERT INTO public.options_backup VALUES (868, 217, 'Action probability');
INSERT INTO public.options_backup VALUES (869, 218, 'Optimization through recursion');
INSERT INTO public.options_backup VALUES (870, 218, 'Random search');
INSERT INTO public.options_backup VALUES (871, 218, 'Clustering');
INSERT INTO public.options_backup VALUES (872, 218, 'Data normalization');
INSERT INTO public.options_backup VALUES (873, 219, 'Optimal hyperparameters');
INSERT INTO public.options_backup VALUES (874, 219, 'Optimal policy');
INSERT INTO public.options_backup VALUES (875, 219, 'Dataset labels');
INSERT INTO public.options_backup VALUES (876, 219, 'Model architecture');
INSERT INTO public.options_backup VALUES (877, 220, 'Markov property');
INSERT INTO public.options_backup VALUES (878, 220, 'Independent samples');
INSERT INTO public.options_backup VALUES (879, 220, 'No rewards');
INSERT INTO public.options_backup VALUES (880, 220, 'Static policy only');
INSERT INTO public.options_backup VALUES (881, 221, 'Convergence');
INSERT INTO public.options_backup VALUES (882, 221, 'Overfitting');
INSERT INTO public.options_backup VALUES (883, 221, 'Underfitting');
INSERT INTO public.options_backup VALUES (884, 221, 'Randomization');
INSERT INTO public.options_backup VALUES (885, 222, 'Deep Learning only');
INSERT INTO public.options_backup VALUES (886, 222, 'Dynamic programming methods in RL');
INSERT INTO public.options_backup VALUES (887, 222, 'Clustering algorithms');
INSERT INTO public.options_backup VALUES (888, 222, 'Regression models');
INSERT INTO public.options_backup VALUES (889, 223, 'Agent');
INSERT INTO public.options_backup VALUES (890, 223, 'Environment');
INSERT INTO public.options_backup VALUES (891, 223, 'Reward');
INSERT INTO public.options_backup VALUES (892, 223, 'All of the above');
INSERT INTO public.options_backup VALUES (893, 224, 'Policy');
INSERT INTO public.options_backup VALUES (894, 224, 'Dataset');
INSERT INTO public.options_backup VALUES (895, 224, 'Batch size');
INSERT INTO public.options_backup VALUES (896, 224, 'Optimizer');
INSERT INTO public.options_backup VALUES (897, 225, 'Current situation of the agent');
INSERT INTO public.options_backup VALUES (898, 225, 'Final reward');
INSERT INTO public.options_backup VALUES (899, 225, 'Learning rate');
INSERT INTO public.options_backup VALUES (900, 225, 'Hidden layer');
INSERT INTO public.options_backup VALUES (901, 226, 'State transitions');
INSERT INTO public.options_backup VALUES (902, 226, 'Feedback to the agent');
INSERT INTO public.options_backup VALUES (903, 226, 'Policy mapping');
INSERT INTO public.options_backup VALUES (904, 226, 'Dataset size');
INSERT INTO public.options_backup VALUES (905, 227, 'Mapping from states to actions');
INSERT INTO public.options_backup VALUES (906, 227, 'Mapping from actions to rewards');
INSERT INTO public.options_backup VALUES (907, 227, 'Mapping from rewards to states');
INSERT INTO public.options_backup VALUES (908, 227, 'Mapping from dataset to model');
INSERT INTO public.options_backup VALUES (909, 228, 'Immediate reward only');
INSERT INTO public.options_backup VALUES (910, 228, 'Expected cumulative reward');
INSERT INTO public.options_backup VALUES (911, 228, 'Number of states');
INSERT INTO public.options_backup VALUES (912, 228, 'Action probability only');
INSERT INTO public.options_backup VALUES (913, 229, 'V(s)');
INSERT INTO public.options_backup VALUES (914, 229, 'R(s)');
INSERT INTO public.options_backup VALUES (915, 229, 'Q(s, a)');
INSERT INTO public.options_backup VALUES (916, 229, 'P(s)');
INSERT INTO public.options_backup VALUES (917, 230, 'Exploration rate');
INSERT INTO public.options_backup VALUES (918, 230, 'Importance of future rewards');
INSERT INTO public.options_backup VALUES (919, 230, 'Learning rate');
INSERT INTO public.options_backup VALUES (920, 230, 'Number of episodes');
INSERT INTO public.options_backup VALUES (921, 231, 'Focuses on immediate reward');
INSERT INTO public.options_backup VALUES (922, 231, 'Ignores future rewards');
INSERT INTO public.options_backup VALUES (923, 231, 'Considers long-term rewards');
INSERT INTO public.options_backup VALUES (924, 231, 'Stops learning');
INSERT INTO public.options_backup VALUES (925, 232, 'Next state');
INSERT INTO public.options_backup VALUES (926, 232, 'Reward');
INSERT INTO public.options_backup VALUES (927, 232, 'Both next state and reward');
INSERT INTO public.options_backup VALUES (928, 232, 'Policy');
INSERT INTO public.options_backup VALUES (929, 233, 'Chance of moving to next state');
INSERT INTO public.options_backup VALUES (930, 233, 'Reward value');
INSERT INTO public.options_backup VALUES (931, 233, 'Policy type');
INSERT INTO public.options_backup VALUES (932, 233, 'Action count');
INSERT INTO public.options_backup VALUES (933, 234, 'Random action selection');
INSERT INTO public.options_backup VALUES (934, 234, 'Fixed action for a state');
INSERT INTO public.options_backup VALUES (935, 234, 'No reward');
INSERT INTO public.options_backup VALUES (936, 234, 'Multiple states');
INSERT INTO public.options_backup VALUES (937, 235, 'Fixed action always');
INSERT INTO public.options_backup VALUES (938, 235, 'No actions');
INSERT INTO public.options_backup VALUES (939, 235, 'Probability distribution over actions');
INSERT INTO public.options_backup VALUES (940, 235, 'Zero reward');
INSERT INTO public.options_backup VALUES (941, 236, 'Immediate reward');
INSERT INTO public.options_backup VALUES (942, 236, 'Total discounted reward');
INSERT INTO public.options_backup VALUES (943, 236, 'Learning rate');
INSERT INTO public.options_backup VALUES (944, 236, 'Episode length');
INSERT INTO public.options_backup VALUES (945, 237, 'Choosing new vs best known actions');
INSERT INTO public.options_backup VALUES (946, 237, 'Reducing dataset size');
INSERT INTO public.options_backup VALUES (947, 237, 'Changing optimizer');
INSERT INTO public.options_backup VALUES (948, 237, 'Removing rewards');
INSERT INTO public.options_backup VALUES (949, 238, 'Future rewards');
INSERT INTO public.options_backup VALUES (950, 238, 'Speed of updating values');
INSERT INTO public.options_backup VALUES (951, 238, 'State transitions');
INSERT INTO public.options_backup VALUES (952, 238, 'Number of actions');
INSERT INTO public.options_backup VALUES (953, 239, 'Start of episode');
INSERT INTO public.options_backup VALUES (954, 239, 'End of episode');
INSERT INTO public.options_backup VALUES (955, 239, 'Reward increase');
INSERT INTO public.options_backup VALUES (956, 239, 'Policy update');
INSERT INTO public.options_backup VALUES (957, 240, 'Optimal policy');
INSERT INTO public.options_backup VALUES (958, 240, 'Random policy');
INSERT INTO public.options_backup VALUES (959, 240, 'Greedy policy');
INSERT INTO public.options_backup VALUES (960, 240, 'Static policy');
INSERT INTO public.options_backup VALUES (961, 241, 'Q(s,a)');
INSERT INTO public.options_backup VALUES (962, 241, 'V(s)');
INSERT INTO public.options_backup VALUES (963, 241, 'R(s)');
INSERT INTO public.options_backup VALUES (964, 241, 'T(s)');
INSERT INTO public.options_backup VALUES (965, 242, 'Single step only');
INSERT INTO public.options_backup VALUES (966, 242, 'Sequential time steps');
INSERT INTO public.options_backup VALUES (967, 242, 'Parallel batches');
INSERT INTO public.options_backup VALUES (968, 242, 'Static dataset');
INSERT INTO public.options_backup VALUES (969, 243, 'Decision Trees');
INSERT INTO public.options_backup VALUES (970, 243, 'Neural Networks');
INSERT INTO public.options_backup VALUES (971, 243, 'K-means');
INSERT INTO public.options_backup VALUES (972, 243, 'Linear Regression');
INSERT INTO public.options_backup VALUES (973, 244, 'Transition matrix');
INSERT INTO public.options_backup VALUES (974, 244, 'Neural network function approximator');
INSERT INTO public.options_backup VALUES (975, 244, 'Reward table');
INSERT INTO public.options_backup VALUES (976, 244, 'Policy list');
INSERT INTO public.options_backup VALUES (977, 245, 'State space is small');
INSERT INTO public.options_backup VALUES (978, 245, 'State space is very large');
INSERT INTO public.options_backup VALUES (979, 245, 'No rewards exist');
INSERT INTO public.options_backup VALUES (980, 245, 'No actions exist');
INSERT INTO public.options_backup VALUES (981, 246, 'Store labels');
INSERT INTO public.options_backup VALUES (982, 246, 'Break correlation between samples');
INSERT INTO public.options_backup VALUES (983, 246, 'Reduce dataset size');
INSERT INTO public.options_backup VALUES (984, 246, 'Stop learning');
INSERT INTO public.options_backup VALUES (985, 247, 'Increase randomness');
INSERT INTO public.options_backup VALUES (986, 247, 'Stabilize learning');
INSERT INTO public.options_backup VALUES (987, 247, 'Remove rewards');
INSERT INTO public.options_backup VALUES (988, 247, 'Change environment');
INSERT INTO public.options_backup VALUES (989, 248, 'Image clustering');
INSERT INTO public.options_backup VALUES (990, 248, 'Atari games');
INSERT INTO public.options_backup VALUES (991, 248, 'Linear regression');
INSERT INTO public.options_backup VALUES (992, 248, 'Database indexing');
INSERT INTO public.options_backup VALUES (993, 249, 'SARSA');
INSERT INTO public.options_backup VALUES (994, 249, 'Policy Gradient');
INSERT INTO public.options_backup VALUES (995, 249, 'Q-Learning');
INSERT INTO public.options_backup VALUES (996, 249, 'Monte Carlo');
INSERT INTO public.options_backup VALUES (997, 250, 'Experience Replay buffer');
INSERT INTO public.options_backup VALUES (998, 250, 'Random environment');
INSERT INTO public.options_backup VALUES (999, 250, 'Policy update');
INSERT INTO public.options_backup VALUES (1000, 250, 'Reward signal');
INSERT INTO public.options_backup VALUES (1001, 251, 'Classification error');
INSERT INTO public.options_backup VALUES (1002, 251, 'Temporal Difference error');
INSERT INTO public.options_backup VALUES (1003, 251, 'Clustering distance');
INSERT INTO public.options_backup VALUES (1004, 251, 'Regression slope');
INSERT INTO public.options_backup VALUES (1005, 252, 'R + γ max Q(s'', a'')');
INSERT INTO public.options_backup VALUES (1006, 252, 'R only');
INSERT INTO public.options_backup VALUES (1007, 252, 'Q(s,a) only');
INSERT INTO public.options_backup VALUES (1008, 252, 'γ only');
INSERT INTO public.options_backup VALUES (1009, 253, 'To increase speed');
INSERT INTO public.options_backup VALUES (1010, 253, 'To reduce instability');
INSERT INTO public.options_backup VALUES (1011, 253, 'To remove exploration');
INSERT INTO public.options_backup VALUES (1012, 253, 'To change rewards');
INSERT INTO public.options_backup VALUES (1013, 254, 'Continuous action spaces only');
INSERT INTO public.options_backup VALUES (1014, 254, 'Discrete action spaces');
INSERT INTO public.options_backup VALUES (1015, 254, 'Clustering problems');
INSERT INTO public.options_backup VALUES (1016, 254, 'Regression tasks');
INSERT INTO public.options_backup VALUES (1017, 255, 'Only rewards');
INSERT INTO public.options_backup VALUES (1018, 255, 'Only states');
INSERT INTO public.options_backup VALUES (1019, 255, 'State, action, reward, next state tuples');
INSERT INTO public.options_backup VALUES (1020, 255, 'Policy parameters');
INSERT INTO public.options_backup VALUES (1021, 256, 'Sequential training');
INSERT INTO public.options_backup VALUES (1022, 256, 'Random sampling from memory');
INSERT INTO public.options_backup VALUES (1023, 256, 'Ignoring rewards');
INSERT INTO public.options_backup VALUES (1024, 256, 'Removing states');
INSERT INTO public.options_backup VALUES (1025, 257, 'Large state space');
INSERT INTO public.options_backup VALUES (1026, 257, 'Small dataset');
INSERT INTO public.options_backup VALUES (1027, 257, 'No rewards');
INSERT INTO public.options_backup VALUES (1028, 257, 'No actions');
INSERT INTO public.options_backup VALUES (1029, 258, 'Reducing overestimation bias');
INSERT INTO public.options_backup VALUES (1030, 258, 'Removing target network');
INSERT INTO public.options_backup VALUES (1031, 258, 'Ignoring discount factor');
INSERT INTO public.options_backup VALUES (1032, 258, 'Stopping exploration');
INSERT INTO public.options_backup VALUES (1033, 259, 'State value and advantage function');
INSERT INTO public.options_backup VALUES (1034, 259, 'Reward and state');
INSERT INTO public.options_backup VALUES (1035, 259, 'Policy and model');
INSERT INTO public.options_backup VALUES (1036, 259, 'Dataset and labels');
INSERT INTO public.options_backup VALUES (1037, 260, 'Backpropagation');
INSERT INTO public.options_backup VALUES (1038, 260, 'Clustering');
INSERT INTO public.options_backup VALUES (1039, 260, 'Regression only');
INSERT INTO public.options_backup VALUES (1040, 260, 'No optimization');
INSERT INTO public.options_backup VALUES (1041, 261, 'Model-based RL');
INSERT INTO public.options_backup VALUES (1042, 261, 'Value-based model-free RL');
INSERT INTO public.options_backup VALUES (1043, 261, 'Supervised learning');
INSERT INTO public.options_backup VALUES (1044, 261, 'Clustering');
INSERT INTO public.options_backup VALUES (1045, 262, 'Maximize cumulative reward');
INSERT INTO public.options_backup VALUES (1046, 262, 'Minimize dataset');
INSERT INTO public.options_backup VALUES (1047, 262, 'Reduce actions');
INSERT INTO public.options_backup VALUES (1048, 262, 'Eliminate states');
INSERT INTO public.options_backup VALUES (1049, 263, 'Agent');
INSERT INTO public.options_backup VALUES (1050, 263, 'Environment');
INSERT INTO public.options_backup VALUES (1051, 263, 'Reward');
INSERT INTO public.options_backup VALUES (1052, 263, 'Label');
INSERT INTO public.options_backup VALUES (1053, 264, 'States');
INSERT INTO public.options_backup VALUES (1054, 264, 'Rewards');
INSERT INTO public.options_backup VALUES (1055, 264, 'Actions');
INSERT INTO public.options_backup VALUES (1056, 264, 'Policies');
INSERT INTO public.options_backup VALUES (1057, 265, 'Action taken');
INSERT INTO public.options_backup VALUES (1058, 265, 'Current situation');
INSERT INTO public.options_backup VALUES (1059, 265, 'Future reward');
INSERT INTO public.options_backup VALUES (1060, 265, 'Policy');
INSERT INTO public.options_backup VALUES (1061, 266, 'Feedback from environment');
INSERT INTO public.options_backup VALUES (1062, 266, 'Decision made by the agent');
INSERT INTO public.options_backup VALUES (1063, 266, 'State transition');
INSERT INTO public.options_backup VALUES (1064, 266, 'Learning rate');
INSERT INTO public.options_backup VALUES (1065, 267, 'Before action');
INSERT INTO public.options_backup VALUES (1066, 267, 'After action');
INSERT INTO public.options_backup VALUES (1067, 267, 'Before episode');
INSERT INTO public.options_backup VALUES (1068, 267, 'Before policy');
INSERT INTO public.options_backup VALUES (1069, 268, 'Reward');
INSERT INTO public.options_backup VALUES (1070, 268, 'Policy');
INSERT INTO public.options_backup VALUES (1071, 268, 'Value function');
INSERT INTO public.options_backup VALUES (1072, 268, 'Action');
INSERT INTO public.options_backup VALUES (1073, 269, 'Reward function');
INSERT INTO public.options_backup VALUES (1074, 269, 'Policy');
INSERT INTO public.options_backup VALUES (1075, 269, 'Value function');
INSERT INTO public.options_backup VALUES (1076, 269, 'State');
INSERT INTO public.options_backup VALUES (1077, 270, 'Next state only');
INSERT INTO public.options_backup VALUES (1078, 270, 'Reward only');
INSERT INTO public.options_backup VALUES (1079, 270, 'Next state and reward');
INSERT INTO public.options_backup VALUES (1080, 270, 'Policy');
INSERT INTO public.options_backup VALUES (1081, 271, 'Reward function');
INSERT INTO public.options_backup VALUES (1082, 271, 'Policy');
INSERT INTO public.options_backup VALUES (1083, 271, 'Value function');
INSERT INTO public.options_backup VALUES (1084, 271, 'State');
INSERT INTO public.options_backup VALUES (1085, 272, 'Reward only');
INSERT INTO public.options_backup VALUES (1086, 272, 'State transition and reward');
INSERT INTO public.options_backup VALUES (1087, 272, 'Policy');
INSERT INTO public.options_backup VALUES (1088, 272, 'Actions only');
INSERT INTO public.options_backup VALUES (1089, 273, 'Agent');
INSERT INTO public.options_backup VALUES (1090, 273, 'Environment');
INSERT INTO public.options_backup VALUES (1091, 273, 'Reward');
INSERT INTO public.options_backup VALUES (1092, 273, 'Model');
INSERT INTO public.options_backup VALUES (1093, 274, 'State');
INSERT INTO public.options_backup VALUES (1094, 274, 'Reward');
INSERT INTO public.options_backup VALUES (1095, 274, 'Dataset');
INSERT INTO public.options_backup VALUES (1096, 274, 'Batch size');
INSERT INTO public.options_backup VALUES (1097, 275, 'Immediate reward');
INSERT INTO public.options_backup VALUES (1098, 275, 'Number of actions');
INSERT INTO public.options_backup VALUES (1099, 275, 'Cumulative reward');
INSERT INTO public.options_backup VALUES (1100, 275, 'Episode length');
INSERT INTO public.options_backup VALUES (1101, 276, 'State-value function');
INSERT INTO public.options_backup VALUES (1102, 276, 'Action-value function');
INSERT INTO public.options_backup VALUES (1103, 276, 'Reward function');
INSERT INTO public.options_backup VALUES (1104, 276, 'Environment');
INSERT INTO public.options_backup VALUES (1105, 277, 'R(s)');
INSERT INTO public.options_backup VALUES (1106, 277, 'Q(s,a)');
INSERT INTO public.options_backup VALUES (1107, 277, 'V(s)');
INSERT INTO public.options_backup VALUES (1108, 277, 'P(s)');
INSERT INTO public.options_backup VALUES (1109, 278, 'V(s)');
INSERT INTO public.options_backup VALUES (1110, 278, 'R(s)');
INSERT INTO public.options_backup VALUES (1111, 278, 'Q(s,a)');
INSERT INTO public.options_backup VALUES (1112, 278, 'T(s)');
INSERT INTO public.options_backup VALUES (1113, 279, 'Learning rate');
INSERT INTO public.options_backup VALUES (1114, 279, 'Discount factor');
INSERT INTO public.options_backup VALUES (1115, 279, 'Exploration rate');
INSERT INTO public.options_backup VALUES (1116, 279, 'Batch size');
INSERT INTO public.options_backup VALUES (1117, 280, 'Policy');
INSERT INTO public.options_backup VALUES (1118, 280, 'Reward');
INSERT INTO public.options_backup VALUES (1119, 280, 'State');
INSERT INTO public.options_backup VALUES (1120, 280, 'Environment');
INSERT INTO public.options_backup VALUES (1121, 281, 'Policy');
INSERT INTO public.options_backup VALUES (1122, 281, 'Agent');
INSERT INTO public.options_backup VALUES (1123, 281, 'Reward');
INSERT INTO public.options_backup VALUES (1124, 281, 'Action');
INSERT INTO public.options_backup VALUES (1125, 282, 'Initial state');
INSERT INTO public.options_backup VALUES (1126, 282, 'Terminal state');
INSERT INTO public.options_backup VALUES (1127, 282, 'Reward function');
INSERT INTO public.options_backup VALUES (1128, 282, 'Policy');
INSERT INTO public.options_backup VALUES (1129, 283, 'Labeled data');
INSERT INTO public.options_backup VALUES (1130, 283, 'Reward and punishment');
INSERT INTO public.options_backup VALUES (1131, 283, 'Clustering');
INSERT INTO public.options_backup VALUES (1132, 283, 'Regression');
INSERT INTO public.options_backup VALUES (1133, 284, 'Supervision');
INSERT INTO public.options_backup VALUES (1134, 284, 'Trial and error');
INSERT INTO public.options_backup VALUES (1135, 284, 'Predefined rules');
INSERT INTO public.options_backup VALUES (1136, 284, 'Data labeling');
INSERT INTO public.options_backup VALUES (1137, 285, 'Minimize error');
INSERT INTO public.options_backup VALUES (1138, 285, 'Maximize cumulative reward');
INSERT INTO public.options_backup VALUES (1139, 285, 'Reduce dataset size');
INSERT INTO public.options_backup VALUES (1140, 285, 'Increase model depth');
INSERT INTO public.options_backup VALUES (1141, 286, 'Uses rewards instead of labels');
INSERT INTO public.options_backup VALUES (1142, 286, 'Uses only images');
INSERT INTO public.options_backup VALUES (1143, 286, 'Requires no data');
INSERT INTO public.options_backup VALUES (1144, 286, 'Is deterministic');
INSERT INTO public.options_backup VALUES (1145, 287, 'Predictor');
INSERT INTO public.options_backup VALUES (1146, 287, 'Agent');
INSERT INTO public.options_backup VALUES (1147, 287, 'Trainer');
INSERT INTO public.options_backup VALUES (1148, 287, 'Observer');
INSERT INTO public.options_backup VALUES (1149, 288, 'State');
INSERT INTO public.options_backup VALUES (1150, 288, 'Policy');
INSERT INTO public.options_backup VALUES (1151, 288, 'Environment');
INSERT INTO public.options_backup VALUES (1152, 288, 'Model');
INSERT INTO public.options_backup VALUES (1153, 289, 'Input data');
INSERT INTO public.options_backup VALUES (1154, 289, 'Feedback signal');
INSERT INTO public.options_backup VALUES (1155, 289, 'State');
INSERT INTO public.options_backup VALUES (1156, 289, 'Output layer');
INSERT INTO public.options_backup VALUES (1157, 290, 'Linear equations');
INSERT INTO public.options_backup VALUES (1158, 290, 'Markov Decision Processes');
INSERT INTO public.options_backup VALUES (1159, 290, 'Neural graphs');
INSERT INTO public.options_backup VALUES (1160, 290, 'Clusters');
INSERT INTO public.options_backup VALUES (1161, 291, 'Exploit known rewards');
INSERT INTO public.options_backup VALUES (1162, 291, 'Try new actions');
INSERT INTO public.options_backup VALUES (1163, 291, 'Stop learning');
INSERT INTO public.options_backup VALUES (1164, 291, 'Remove states');
INSERT INTO public.options_backup VALUES (1165, 292, 'Random selection');
INSERT INTO public.options_backup VALUES (1166, 292, 'Using best known action');
INSERT INTO public.options_backup VALUES (1167, 292, 'Ignoring rewards');
INSERT INTO public.options_backup VALUES (1168, 292, 'Resetting model');
INSERT INTO public.options_backup VALUES (1169, 293, 'Reward is zero');
INSERT INTO public.options_backup VALUES (1170, 293, 'Terminal state is reached');
INSERT INTO public.options_backup VALUES (1171, 293, 'Agent stops');
INSERT INTO public.options_backup VALUES (1172, 293, 'Policy changes');
INSERT INTO public.options_backup VALUES (1173, 294, 'Gaming');
INSERT INTO public.options_backup VALUES (1174, 294, 'Robotics');
INSERT INTO public.options_backup VALUES (1175, 294, 'Self-driving cars');
INSERT INTO public.options_backup VALUES (1176, 294, 'All of the above');
INSERT INTO public.options_backup VALUES (1177, 295, 'Instant return');
INSERT INTO public.options_backup VALUES (1178, 295, 'Reinforcement signal');
INSERT INTO public.options_backup VALUES (1179, 295, 'Feedback');
INSERT INTO public.options_backup VALUES (1180, 295, 'Gain');
INSERT INTO public.options_backup VALUES (1181, 296, 'Interaction');
INSERT INTO public.options_backup VALUES (1182, 296, 'Environment');
INSERT INTO public.options_backup VALUES (1183, 296, 'Labeled dataset');
INSERT INTO public.options_backup VALUES (1184, 296, 'Reward');
INSERT INTO public.options_backup VALUES (1185, 297, 'Regression');
INSERT INTO public.options_backup VALUES (1186, 297, 'Reinforcement Learning');
INSERT INTO public.options_backup VALUES (1187, 297, 'Clustering');
INSERT INTO public.options_backup VALUES (1188, 297, 'Classification');
INSERT INTO public.options_backup VALUES (1189, 298, 'Discount factor');
INSERT INTO public.options_backup VALUES (1190, 298, 'Learning rate');
INSERT INTO public.options_backup VALUES (1191, 298, 'Epoch');
INSERT INTO public.options_backup VALUES (1192, 298, 'Batch size');
INSERT INTO public.options_backup VALUES (1193, 299, 'Reward only');
INSERT INTO public.options_backup VALUES (1194, 299, 'State');
INSERT INTO public.options_backup VALUES (1195, 299, 'Policy');
INSERT INTO public.options_backup VALUES (1196, 299, 'Dataset');
INSERT INTO public.options_backup VALUES (1197, 300, 'State');
INSERT INTO public.options_backup VALUES (1198, 300, 'Reward');
INSERT INTO public.options_backup VALUES (1199, 300, 'Policy');
INSERT INTO public.options_backup VALUES (1200, 300, 'All of the above');
INSERT INTO public.options_backup VALUES (1201, 301, 'Randomness');
INSERT INTO public.options_backup VALUES (1202, 301, 'Policy');
INSERT INTO public.options_backup VALUES (1203, 301, 'Dataset');
INSERT INTO public.options_backup VALUES (1204, 301, 'Labels');
INSERT INTO public.options_backup VALUES (1205, 302, 'Artificial Intelligence');
INSERT INTO public.options_backup VALUES (1206, 302, 'Database systems');
INSERT INTO public.options_backup VALUES (1207, 302, 'Networking');
INSERT INTO public.options_backup VALUES (1208, 302, 'Hardware design');
INSERT INTO public.options_backup VALUES (1209, 303, '(S, A, R)');
INSERT INTO public.options_backup VALUES (1210, 303, '(S, A, P, R, gamma)');
INSERT INTO public.options_backup VALUES (1211, 303, '(A, R, gamma)');
INSERT INTO public.options_backup VALUES (1212, 303, '(S, P, gamma)');
INSERT INTO public.options_backup VALUES (1213, 304, 'States');
INSERT INTO public.options_backup VALUES (1214, 304, 'Signals');
INSERT INTO public.options_backup VALUES (1215, 304, 'Steps');
INSERT INTO public.options_backup VALUES (1216, 304, 'Samples');
INSERT INTO public.options_backup VALUES (1217, 305, 'Agents');
INSERT INTO public.options_backup VALUES (1218, 305, 'Actions');
INSERT INTO public.options_backup VALUES (1219, 305, 'Attributes');
INSERT INTO public.options_backup VALUES (1220, 305, 'Algorithms');
INSERT INTO public.options_backup VALUES (1221, 306, 'Policy');
INSERT INTO public.options_backup VALUES (1222, 306, 'Probability of transition');
INSERT INTO public.options_backup VALUES (1223, 306, 'Performance');
INSERT INTO public.options_backup VALUES (1224, 306, 'Prediction');
INSERT INTO public.options_backup VALUES (1225, 307, 'Future depends only on current state');
INSERT INTO public.options_backup VALUES (1226, 307, 'Future depends on all past states');
INSERT INTO public.options_backup VALUES (1227, 307, 'Rewards are constant');
INSERT INTO public.options_backup VALUES (1228, 307, 'Actions are fixed');
INSERT INTO public.options_backup VALUES (1229, 308, 'R');
INSERT INTO public.options_backup VALUES (1230, 308, 'Q');
INSERT INTO public.options_backup VALUES (1231, 308, 'V');
INSERT INTO public.options_backup VALUES (1232, 308, 'T');
INSERT INTO public.options_backup VALUES (1233, 309, 'Learning rate');
INSERT INTO public.options_backup VALUES (1234, 309, 'Discount factor');
INSERT INTO public.options_backup VALUES (1235, 309, 'Transition probability');
INSERT INTO public.options_backup VALUES (1236, 309, 'Policy rate');
INSERT INTO public.options_backup VALUES (1237, 310, 'Ignores future rewards');
INSERT INTO public.options_backup VALUES (1238, 310, 'Considers only immediate reward');
INSERT INTO public.options_backup VALUES (1239, 310, 'Fully considers future rewards');
INSERT INTO public.options_backup VALUES (1240, 310, 'Stops learning');
INSERT INTO public.options_backup VALUES (1241, 311, 'Next state is fixed for a state-action pair');
INSERT INTO public.options_backup VALUES (1242, 311, 'Random rewards');
INSERT INTO public.options_backup VALUES (1243, 311, 'No actions allowed');
INSERT INTO public.options_backup VALUES (1244, 311, 'Multiple agents');
INSERT INTO public.options_backup VALUES (1245, 312, 'No randomness');
INSERT INTO public.options_backup VALUES (1246, 312, 'Random state transitions');
INSERT INTO public.options_backup VALUES (1247, 312, 'Fixed rewards only');
INSERT INTO public.options_backup VALUES (1248, 312, 'Single state');
INSERT INTO public.options_backup VALUES (1249, 313, 'P(s'' | s, a)');
INSERT INTO public.options_backup VALUES (1250, 313, 'R(s)');
INSERT INTO public.options_backup VALUES (1251, 313, 'Q(s,a)');
INSERT INTO public.options_backup VALUES (1252, 313, 'V(s)');
INSERT INTO public.options_backup VALUES (1253, 314, 'There is no reward');
INSERT INTO public.options_backup VALUES (1254, 314, 'There are terminal states');
INSERT INTO public.options_backup VALUES (1255, 314, 'Gamma is zero');
INSERT INTO public.options_backup VALUES (1256, 314, 'Policy is fixed');
INSERT INTO public.options_backup VALUES (1257, 315, 'Optimal dataset');
INSERT INTO public.options_backup VALUES (1258, 315, 'Optimal policy');
INSERT INTO public.options_backup VALUES (1259, 315, 'Optimal batch size');
INSERT INTO public.options_backup VALUES (1260, 315, 'Optimal model depth');
INSERT INTO public.options_backup VALUES (1261, 316, 'Q-learning');
INSERT INTO public.options_backup VALUES (1262, 316, 'SARSA');
INSERT INTO public.options_backup VALUES (1263, 316, 'Value Iteration');
INSERT INTO public.options_backup VALUES (1264, 316, 'K-means');
INSERT INTO public.options_backup VALUES (1265, 317, 'Bellman Optimality Equation');
INSERT INTO public.options_backup VALUES (1266, 317, 'Gradient Descent');
INSERT INTO public.options_backup VALUES (1267, 317, 'Clustering');
INSERT INTO public.options_backup VALUES (1268, 317, 'Backpropagation');
INSERT INTO public.options_backup VALUES (1269, 318, 'Policy evaluation and improvement');
INSERT INTO public.options_backup VALUES (1270, 318, 'Random search');
INSERT INTO public.options_backup VALUES (1271, 318, 'Supervised training');
INSERT INTO public.options_backup VALUES (1272, 318, 'Clustering');
INSERT INTO public.options_backup VALUES (1273, 319, 'Immediate reward only');
INSERT INTO public.options_backup VALUES (1274, 319, 'Sum of discounted rewards');
INSERT INTO public.options_backup VALUES (1275, 319, 'Learning rate');
INSERT INTO public.options_backup VALUES (1276, 319, 'Transition count');
INSERT INTO public.options_backup VALUES (1277, 320, 'Only immediate reward');
INSERT INTO public.options_backup VALUES (1278, 320, 'Only future rewards');
INSERT INTO public.options_backup VALUES (1279, 320, 'All past rewards');
INSERT INTO public.options_backup VALUES (1280, 320, 'Infinite rewards');
INSERT INTO public.options_backup VALUES (1281, 321, 'Image classification');
INSERT INTO public.options_backup VALUES (1282, 321, 'Sequential decision making');
INSERT INTO public.options_backup VALUES (1283, 321, 'Clustering');
INSERT INTO public.options_backup VALUES (1284, 321, 'Data cleaning');
INSERT INTO public.options_backup VALUES (1285, 322, 'Immediate reward');
INSERT INTO public.options_backup VALUES (1286, 322, 'Expected cumulative reward');
INSERT INTO public.options_backup VALUES (1287, 322, 'Dataset size');
INSERT INTO public.options_backup VALUES (1288, 322, 'Number of states');
INSERT INTO public.options_backup VALUES (1289, 323, 'A reward function');
INSERT INTO public.options_backup VALUES (1290, 323, 'A mapping from states to actions');
INSERT INTO public.options_backup VALUES (1291, 323, 'A value function');
INSERT INTO public.options_backup VALUES (1292, 323, 'A transition model');
INSERT INTO public.options_backup VALUES (1293, 324, 'Random action');
INSERT INTO public.options_backup VALUES (1294, 324, 'Multiple actions');
INSERT INTO public.options_backup VALUES (1295, 324, 'One fixed action for a state');
INSERT INTO public.options_backup VALUES (1296, 324, 'No action');
INSERT INTO public.options_backup VALUES (1297, 325, 'Fixed rule');
INSERT INTO public.options_backup VALUES (1298, 325, 'Probability distribution');
INSERT INTO public.options_backup VALUES (1299, 325, 'Immediate reward only');
INSERT INTO public.options_backup VALUES (1300, 325, 'Learning rate');
INSERT INTO public.options_backup VALUES (1301, 326, 'π');
INSERT INTO public.options_backup VALUES (1302, 326, 'π*');
INSERT INTO public.options_backup VALUES (1303, 326, 'V*');
INSERT INTO public.options_backup VALUES (1304, 326, 'Q');
INSERT INTO public.options_backup VALUES (1305, 327, 'Maximum estimated value');
INSERT INTO public.options_backup VALUES (1306, 327, 'Random selection');
INSERT INTO public.options_backup VALUES (1307, 327, 'Minimum reward');
INSERT INTO public.options_backup VALUES (1308, 327, 'Environment size');
INSERT INTO public.options_backup VALUES (1309, 328, 'Learning rate and discount factor');
INSERT INTO public.options_backup VALUES (1310, 328, 'Exploration and exploitation');
INSERT INTO public.options_backup VALUES (1311, 328, 'States and rewards');
INSERT INTO public.options_backup VALUES (1312, 328, 'Policy and value');
INSERT INTO public.options_backup VALUES (1313, 329, 'Always explores');
INSERT INTO public.options_backup VALUES (1314, 329, 'Always exploits');
INSERT INTO public.options_backup VALUES (1315, 329, 'Stops learning');
INSERT INTO public.options_backup VALUES (1316, 329, 'Randomly selects actions');
INSERT INTO public.options_backup VALUES (1317, 330, 'Always exploits');
INSERT INTO public.options_backup VALUES (1318, 330, 'Always explores');
INSERT INTO public.options_backup VALUES (1319, 330, 'Chooses optimal action');
INSERT INTO public.options_backup VALUES (1320, 330, 'Ignores rewards');
INSERT INTO public.options_backup VALUES (1321, 331, 'Only one action allowed');
INSERT INTO public.options_backup VALUES (1322, 331, 'All actions have non-zero probability');
INSERT INTO public.options_backup VALUES (1323, 331, 'No exploration');
INSERT INTO public.options_backup VALUES (1324, 331, 'Deterministic behavior');
INSERT INTO public.options_backup VALUES (1325, 332, 'Reduce rewards');
INSERT INTO public.options_backup VALUES (1326, 332, 'Improve policy using value function');
INSERT INTO public.options_backup VALUES (1327, 332, 'Increase dataset size');
INSERT INTO public.options_backup VALUES (1328, 332, 'Stop iteration');
INSERT INTO public.options_backup VALUES (1329, 333, 'Based on value');
INSERT INTO public.options_backup VALUES (1330, 333, 'Uniformly at random');
INSERT INTO public.options_backup VALUES (1331, 333, 'Based on reward only');
INSERT INTO public.options_backup VALUES (1332, 333, 'Deterministically');
INSERT INTO public.options_backup VALUES (1333, 334, 'Optimal action');
INSERT INTO public.options_backup VALUES (1334, 334, 'Value of a given policy');
INSERT INTO public.options_backup VALUES (1335, 334, 'Learning rate');
INSERT INTO public.options_backup VALUES (1336, 334, 'Transition matrix');
INSERT INTO public.options_backup VALUES (1337, 335, 'Policy gradient methods');
INSERT INTO public.options_backup VALUES (1338, 335, 'K-means clustering');
INSERT INTO public.options_backup VALUES (1339, 335, 'Linear regression');
INSERT INTO public.options_backup VALUES (1340, 335, 'Naive Bayes');
INSERT INTO public.options_backup VALUES (1341, 336, 'Value function');
INSERT INTO public.options_backup VALUES (1342, 336, 'Policy parameters');
INSERT INTO public.options_backup VALUES (1343, 336, 'Transition probabilities');
INSERT INTO public.options_backup VALUES (1344, 336, 'Dataset size');
INSERT INTO public.options_backup VALUES (1345, 337, 'Learns about one policy while following another');
INSERT INTO public.options_backup VALUES (1346, 337, 'Learns about and follows the same policy');
INSERT INTO public.options_backup VALUES (1347, 337, 'Ignores policy');
INSERT INTO public.options_backup VALUES (1348, 337, 'Uses supervised labels');
INSERT INTO public.options_backup VALUES (1349, 338, 'Learns about a different policy than it follows');
INSERT INTO public.options_backup VALUES (1350, 338, 'Uses only one policy');
INSERT INTO public.options_backup VALUES (1351, 338, 'Stops exploration');
INSERT INTO public.options_backup VALUES (1352, 338, 'Uses no rewards');
INSERT INTO public.options_backup VALUES (1353, 339, 'Greedy');
INSERT INTO public.options_backup VALUES (1354, 339, 'Deterministic');
INSERT INTO public.options_backup VALUES (1355, 339, 'Epsilon-greedy with high epsilon');
INSERT INTO public.options_backup VALUES (1356, 339, 'Optimal policy');
INSERT INTO public.options_backup VALUES (1357, 340, 'Policy does not change during learning');
INSERT INTO public.options_backup VALUES (1358, 340, 'Random policy');
INSERT INTO public.options_backup VALUES (1359, 340, 'Optimal policy');
INSERT INTO public.options_backup VALUES (1360, 340, 'Soft policy');
INSERT INTO public.options_backup VALUES (1361, 341, 'Policy evaluation and policy improvement');
INSERT INTO public.options_backup VALUES (1362, 341, 'Clustering and regression');
INSERT INTO public.options_backup VALUES (1363, 341, 'Exploration only');
INSERT INTO public.options_backup VALUES (1364, 341, 'Random updates');
INSERT INTO public.options_backup VALUES (1365, 342, 'Minimize dataset');
INSERT INTO public.options_backup VALUES (1366, 342, 'Maximize expected cumulative reward');
INSERT INTO public.options_backup VALUES (1367, 342, 'Reduce computation');
INSERT INTO public.options_backup VALUES (1368, 342, 'Eliminate states');
INSERT INTO public.options_backup VALUES (1369, 343, 'Model-based learning');
INSERT INTO public.options_backup VALUES (1370, 343, 'Supervised learning');
INSERT INTO public.options_backup VALUES (1371, 343, 'Model-free learning');
INSERT INTO public.options_backup VALUES (1372, 343, 'Unsupervised learning');
INSERT INTO public.options_backup VALUES (1373, 344, 'Quantity');
INSERT INTO public.options_backup VALUES (1374, 344, 'Quality');
INSERT INTO public.options_backup VALUES (1375, 344, 'Query');
INSERT INTO public.options_backup VALUES (1376, 344, 'Queue');
INSERT INTO public.options_backup VALUES (1377, 345, 'Immediate reward');
INSERT INTO public.options_backup VALUES (1378, 345, 'Expected future reward for taking action a in state s');
INSERT INTO public.options_backup VALUES (1379, 345, 'Learning rate');
INSERT INTO public.options_backup VALUES (1380, 345, 'Transition probability');
INSERT INTO public.options_backup VALUES (1381, 346, 'Bellman optimality equation');
INSERT INTO public.options_backup VALUES (1382, 346, 'Linear regression equation');
INSERT INTO public.options_backup VALUES (1383, 346, 'K-means update rule');
INSERT INTO public.options_backup VALUES (1384, 346, 'Gradient descent rule');
INSERT INTO public.options_backup VALUES (1385, 347, 'Minimum');
INSERT INTO public.options_backup VALUES (1386, 347, 'Maximum');
INSERT INTO public.options_backup VALUES (1387, 347, 'Average');
INSERT INTO public.options_backup VALUES (1388, 347, 'Sum only');
INSERT INTO public.options_backup VALUES (1389, 348, 'On-policy algorithm');
INSERT INTO public.options_backup VALUES (1390, 348, 'Off-policy algorithm');
INSERT INTO public.options_backup VALUES (1391, 348, 'Supervised algorithm');
INSERT INTO public.options_backup VALUES (1392, 348, 'Clustering algorithm');
INSERT INTO public.options_backup VALUES (1393, 349, 'γ');
INSERT INTO public.options_backup VALUES (1394, 349, 'π');
INSERT INTO public.options_backup VALUES (1395, 349, 'α');
INSERT INTO public.options_backup VALUES (1396, 349, 'β');
INSERT INTO public.options_backup VALUES (1397, 350, 'α');
INSERT INTO public.options_backup VALUES (1398, 350, 'γ');
INSERT INTO public.options_backup VALUES (1399, 350, 'θ');
INSERT INTO public.options_backup VALUES (1400, 350, 'λ');
INSERT INTO public.options_backup VALUES (1401, 351, 'Very slow');
INSERT INTO public.options_backup VALUES (1402, 351, 'More sensitive to new information');
INSERT INTO public.options_backup VALUES (1403, 351, 'Completely stable');
INSERT INTO public.options_backup VALUES (1404, 351, 'Independent of reward');
INSERT INTO public.options_backup VALUES (1405, 352, 'States only');
INSERT INTO public.options_backup VALUES (1406, 352, 'Actions only');
INSERT INTO public.options_backup VALUES (1407, 352, 'State-action values');
INSERT INTO public.options_backup VALUES (1408, 352, 'Rewards only');
INSERT INTO public.options_backup VALUES (1409, 353, 'Transition model');
INSERT INTO public.options_backup VALUES (1410, 353, 'Reward signal');
INSERT INTO public.options_backup VALUES (1411, 353, 'State space');
INSERT INTO public.options_backup VALUES (1412, 353, 'Actions');
INSERT INTO public.options_backup VALUES (1413, 354, 'Random value');
INSERT INTO public.options_backup VALUES (1414, 354, 'Immediate reward only');
INSERT INTO public.options_backup VALUES (1415, 354, 'Reward plus discounted max future Q-value');
INSERT INTO public.options_backup VALUES (1416, 354, 'Zero');
INSERT INTO public.options_backup VALUES (1417, 355, 'Exploration is sufficient');
INSERT INTO public.options_backup VALUES (1418, 355, 'No rewards are given');
INSERT INTO public.options_backup VALUES (1419, 355, 'Gamma is zero');
INSERT INTO public.options_backup VALUES (1420, 355, 'Learning rate is fixed at 1');
INSERT INTO public.options_backup VALUES (1421, 356, 'Epsilon-greedy');
INSERT INTO public.options_backup VALUES (1422, 356, 'Clustering');
INSERT INTO public.options_backup VALUES (1423, 356, 'Linear regression');
INSERT INTO public.options_backup VALUES (1424, 356, 'Naive Bayes');
INSERT INTO public.options_backup VALUES (1425, 357, 'R + γ max Q(s'', a'')');
INSERT INTO public.options_backup VALUES (1426, 357, 'R only');
INSERT INTO public.options_backup VALUES (1427, 357, 'Q(s,a) only');
INSERT INTO public.options_backup VALUES (1428, 357, 'γ only');
INSERT INTO public.options_backup VALUES (1429, 358, 'Discrete state-action spaces');
INSERT INTO public.options_backup VALUES (1430, 358, 'Only supervised datasets');
INSERT INTO public.options_backup VALUES (1431, 358, 'Clustering problems');
INSERT INTO public.options_backup VALUES (1432, 358, 'Regression tasks');
INSERT INTO public.options_backup VALUES (1433, 359, 'Requires full model');
INSERT INTO public.options_backup VALUES (1434, 359, 'Simple and model-free');
INSERT INTO public.options_backup VALUES (1435, 359, 'No exploration needed');
INSERT INTO public.options_backup VALUES (1436, 359, 'No rewards needed');
INSERT INTO public.options_backup VALUES (1437, 360, 'After full episode only');
INSERT INTO public.options_backup VALUES (1438, 360, 'At each time step');
INSERT INTO public.options_backup VALUES (1439, 360, 'Only once');
INSERT INTO public.options_backup VALUES (1440, 360, 'Without reward');
INSERT INTO public.options_backup VALUES (1441, 361, 'Decision tree');
INSERT INTO public.options_backup VALUES (1442, 361, 'Neural network');
INSERT INTO public.options_backup VALUES (1443, 361, 'K-means');
INSERT INTO public.options_backup VALUES (1444, 361, 'Linear model');
INSERT INTO public.options_backup VALUES (1445, 362, 'Optimal value function');
INSERT INTO public.options_backup VALUES (1446, 362, 'Optimal dataset');
INSERT INTO public.options_backup VALUES (1447, 362, 'Optimal clustering');
INSERT INTO public.options_backup VALUES (1448, 362, 'Optimal regression model');
INSERT INTO public.options_backup VALUES (1449, 363, 'Supervised and Unsupervised');
INSERT INTO public.options_backup VALUES (1450, 363, 'Model-based and Model-free');
INSERT INTO public.options_backup VALUES (1451, 363, 'Regression and Classification');
INSERT INTO public.options_backup VALUES (1452, 363, 'Clustering and Prediction');
INSERT INTO public.options_backup VALUES (1453, 364, 'Only reward signal');
INSERT INTO public.options_backup VALUES (1454, 364, 'Full environment model');
INSERT INTO public.options_backup VALUES (1455, 364, 'Labeled dataset');
INSERT INTO public.options_backup VALUES (1456, 364, 'No states');
INSERT INTO public.options_backup VALUES (1457, 365, 'State space');
INSERT INTO public.options_backup VALUES (1458, 365, 'Reward signal');
INSERT INTO public.options_backup VALUES (1459, 365, 'Environment model');
INSERT INTO public.options_backup VALUES (1460, 365, 'Actions');
INSERT INTO public.options_backup VALUES (1461, 366, 'Model-based RL');
INSERT INTO public.options_backup VALUES (1462, 366, 'Model-free RL');
INSERT INTO public.options_backup VALUES (1463, 366, 'Supervised learning');
INSERT INTO public.options_backup VALUES (1464, 366, 'Clustering');
INSERT INTO public.options_backup VALUES (1465, 367, 'Model-based RL');
INSERT INTO public.options_backup VALUES (1466, 367, 'Model-free RL');
INSERT INTO public.options_backup VALUES (1467, 367, 'Deep Learning');
INSERT INTO public.options_backup VALUES (1468, 367, 'Regression');
INSERT INTO public.options_backup VALUES (1469, 368, 'Value function');
INSERT INTO public.options_backup VALUES (1470, 368, 'Policy');
INSERT INTO public.options_backup VALUES (1471, 368, 'Transition model');
INSERT INTO public.options_backup VALUES (1472, 368, 'Dataset');
INSERT INTO public.options_backup VALUES (1473, 369, 'Policy parameters directly');
INSERT INTO public.options_backup VALUES (1474, 369, 'State or action values');
INSERT INTO public.options_backup VALUES (1475, 369, 'Dataset labels');
INSERT INTO public.options_backup VALUES (1476, 369, 'Environment structure');
INSERT INTO public.options_backup VALUES (1477, 370, 'Supervised and Unsupervised learning');
INSERT INTO public.options_backup VALUES (1478, 370, 'Policy-based and Value-based methods');
INSERT INTO public.options_backup VALUES (1479, 370, 'Clustering and Regression');
INSERT INTO public.options_backup VALUES (1480, 370, 'Model-free and Model-based');
INSERT INTO public.options_backup VALUES (1481, 371, 'Learning about the same policy being followed');
INSERT INTO public.options_backup VALUES (1482, 371, 'Learning from another policy');
INSERT INTO public.options_backup VALUES (1483, 371, 'No policy used');
INSERT INTO public.options_backup VALUES (1484, 371, 'Supervised training');
INSERT INTO public.options_backup VALUES (1485, 372, 'Learning and following same policy');
INSERT INTO public.options_backup VALUES (1486, 372, 'Learning about a different policy');
INSERT INTO public.options_backup VALUES (1487, 372, 'No exploration');
INSERT INTO public.options_backup VALUES (1488, 372, 'Ignoring rewards');
INSERT INTO public.options_backup VALUES (1489, 373, 'Off-policy learning');
INSERT INTO public.options_backup VALUES (1490, 373, 'On-policy learning');
INSERT INTO public.options_backup VALUES (1491, 373, 'Model-based learning');
INSERT INTO public.options_backup VALUES (1492, 373, 'Supervised learning');
INSERT INTO public.options_backup VALUES (1493, 374, 'Model-based RL');
INSERT INTO public.options_backup VALUES (1494, 374, 'Value-based model-free RL');
INSERT INTO public.options_backup VALUES (1495, 374, 'Supervised learning');
INSERT INTO public.options_backup VALUES (1496, 374, 'Clustering');
INSERT INTO public.options_backup VALUES (1497, 375, 'Value-based method');
INSERT INTO public.options_backup VALUES (1498, 375, 'Policy-based method');
INSERT INTO public.options_backup VALUES (1499, 375, 'Model-based method');
INSERT INTO public.options_backup VALUES (1500, 375, 'Clustering method');
INSERT INTO public.options_backup VALUES (1501, 376, 'Model-free RL');
INSERT INTO public.options_backup VALUES (1502, 376, 'Model-based RL');
INSERT INTO public.options_backup VALUES (1503, 376, 'Supervised learning');
INSERT INTO public.options_backup VALUES (1504, 376, 'Regression');
INSERT INTO public.options_backup VALUES (1505, 377, 'Model-free RL');
INSERT INTO public.options_backup VALUES (1506, 377, 'Model-based RL');
INSERT INTO public.options_backup VALUES (1507, 377, 'Clustering');
INSERT INTO public.options_backup VALUES (1508, 377, 'Regression');
INSERT INTO public.options_backup VALUES (1509, 378, 'Continuous action spaces');
INSERT INTO public.options_backup VALUES (1510, 378, 'Clustering tasks');
INSERT INTO public.options_backup VALUES (1511, 378, 'Regression only');
INSERT INTO public.options_backup VALUES (1512, 378, 'Supervised learning only');
INSERT INTO public.options_backup VALUES (1513, 379, 'Requires more computation');
INSERT INTO public.options_backup VALUES (1514, 379, 'Needs no environment knowledge');
INSERT INTO public.options_backup VALUES (1515, 379, 'Ignores rewards');
INSERT INTO public.options_backup VALUES (1516, 379, 'Works without states');
INSERT INTO public.options_backup VALUES (1517, 380, 'Uses environment simulation');
INSERT INTO public.options_backup VALUES (1518, 380, 'Learns directly from experience');
INSERT INTO public.options_backup VALUES (1519, 380, 'Needs full transition model');
INSERT INTO public.options_backup VALUES (1520, 380, 'Ignores actions');
INSERT INTO public.options_backup VALUES (1521, 381, 'Model-based RL');
INSERT INTO public.options_backup VALUES (1522, 381, 'Clustering');
INSERT INTO public.options_backup VALUES (1523, 381, 'Regression');
INSERT INTO public.options_backup VALUES (1524, 381, 'Supervised learning');
INSERT INTO public.options_backup VALUES (1525, 382, 'Minimize dataset');
INSERT INTO public.options_backup VALUES (1526, 382, 'Maximize cumulative reward');
INSERT INTO public.options_backup VALUES (1527, 382, 'Reduce states');
INSERT INTO public.options_backup VALUES (1528, 382, 'Increase labels');
INSERT INTO public.options_backup VALUES (1529, 383, 'State-Action-Reward-State-Action');
INSERT INTO public.options_backup VALUES (1530, 383, 'State-Action-Reward-System-Algorithm');
INSERT INTO public.options_backup VALUES (1531, 383, 'Sample-Action-Reward-State-Action');
INSERT INTO public.options_backup VALUES (1532, 383, 'State-Reward-Action-System-Algorithm');
INSERT INTO public.options_backup VALUES (1533, 384, 'Model-based learning');
INSERT INTO public.options_backup VALUES (1534, 384, 'Off-policy learning');
INSERT INTO public.options_backup VALUES (1535, 384, 'On-policy learning');
INSERT INTO public.options_backup VALUES (1536, 384, 'Supervised learning');
INSERT INTO public.options_backup VALUES (1537, 385, 'Maximum future Q-value');
INSERT INTO public.options_backup VALUES (1538, 385, 'Actual next action’s Q-value');
INSERT INTO public.options_backup VALUES (1539, 385, 'Immediate reward only');
INSERT INTO public.options_backup VALUES (1540, 385, 'Average reward');
INSERT INTO public.options_backup VALUES (1541, 386, 'Bellman expectation equation');
INSERT INTO public.options_backup VALUES (1542, 386, 'Linear regression');
INSERT INTO public.options_backup VALUES (1543, 386, 'K-means clustering');
INSERT INTO public.options_backup VALUES (1544, 386, 'Naive Bayes');
INSERT INTO public.options_backup VALUES (1545, 387, 'Random policy only');
INSERT INTO public.options_backup VALUES (1546, 387, 'Current policy');
INSERT INTO public.options_backup VALUES (1547, 387, 'Optimal policy only');
INSERT INTO public.options_backup VALUES (1548, 387, 'No policy');
INSERT INTO public.options_backup VALUES (1549, 388, 'SARSA is off-policy');
INSERT INTO public.options_backup VALUES (1550, 388, 'SARSA uses max operator');
INSERT INTO public.options_backup VALUES (1551, 388, 'SARSA follows the same policy it learns');
INSERT INTO public.options_backup VALUES (1552, 388, 'SARSA ignores rewards');
INSERT INTO public.options_backup VALUES (1553, 389, 'γ');
INSERT INTO public.options_backup VALUES (1554, 389, 'α');
INSERT INTO public.options_backup VALUES (1555, 389, 'π');
INSERT INTO public.options_backup VALUES (1556, 389, 'θ');
INSERT INTO public.options_backup VALUES (1557, 390, 'α');
INSERT INTO public.options_backup VALUES (1558, 390, 'β');
INSERT INTO public.options_backup VALUES (1559, 390, 'γ');
INSERT INTO public.options_backup VALUES (1560, 390, 'λ');
INSERT INTO public.options_backup VALUES (1561, 391, 'Uses actual next action');
INSERT INTO public.options_backup VALUES (1562, 391, 'Uses maximum action');
INSERT INTO public.options_backup VALUES (1563, 391, 'Ignores discount factor');
INSERT INTO public.options_backup VALUES (1564, 391, 'Does not explore');
INSERT INTO public.options_backup VALUES (1565, 392, 'R + γ max Q(s'', a'')');
INSERT INTO public.options_backup VALUES (1566, 392, 'R + γ Q(s'', a'')');
INSERT INTO public.options_backup VALUES (1567, 392, 'R only');
INSERT INTO public.options_backup VALUES (1568, 392, 'Q(s,a) only');
INSERT INTO public.options_backup VALUES (1569, 393, 'After each step');
INSERT INTO public.options_backup VALUES (1570, 393, 'After full training only');
INSERT INTO public.options_backup VALUES (1571, 393, 'Without rewards');
INSERT INTO public.options_backup VALUES (1572, 393, 'Only at terminal state');
INSERT INTO public.options_backup VALUES (1573, 394, 'Epsilon-greedy');
INSERT INTO public.options_backup VALUES (1574, 394, 'Clustering');
INSERT INTO public.options_backup VALUES (1575, 394, 'Regression');
INSERT INTO public.options_backup VALUES (1576, 394, 'Decision tree');
INSERT INTO public.options_backup VALUES (1577, 395, 'Risk-sensitive environments');
INSERT INTO public.options_backup VALUES (1578, 395, 'Clustering problems');
INSERT INTO public.options_backup VALUES (1579, 395, 'Regression tasks');
INSERT INTO public.options_backup VALUES (1580, 395, 'Supervised tasks only');
INSERT INTO public.options_backup VALUES (1581, 396, 'Exploration is sufficient');
INSERT INTO public.options_backup VALUES (1582, 396, 'No actions taken');
INSERT INTO public.options_backup VALUES (1583, 396, 'Gamma is zero');
INSERT INTO public.options_backup VALUES (1584, 396, 'Rewards are negative');
INSERT INTO public.options_backup VALUES (1585, 397, 'Transition probabilities');
INSERT INTO public.options_backup VALUES (1586, 397, 'Full environment model');
INSERT INTO public.options_backup VALUES (1587, 397, 'Only reward and next state');
INSERT INTO public.options_backup VALUES (1588, 397, 'Dataset labels');
INSERT INTO public.options_backup VALUES (1589, 398, 'Take safer paths');
INSERT INTO public.options_backup VALUES (1590, 398, 'Be more aggressive');
INSERT INTO public.options_backup VALUES (1591, 398, 'Ignore policy');
INSERT INTO public.options_backup VALUES (1592, 398, 'Ignore exploration');
INSERT INTO public.options_backup VALUES (1593, 399, 'Model-based RL');
INSERT INTO public.options_backup VALUES (1594, 399, 'Model-free RL');
INSERT INTO public.options_backup VALUES (1595, 399, 'Supervised learning');
INSERT INTO public.options_backup VALUES (1596, 399, 'Clustering');
INSERT INTO public.options_backup VALUES (1597, 400, 'States only');
INSERT INTO public.options_backup VALUES (1598, 400, 'Actions only');
INSERT INTO public.options_backup VALUES (1599, 400, 'State-action values');
INSERT INTO public.options_backup VALUES (1600, 400, 'Rewards only');
INSERT INTO public.options_backup VALUES (1601, 401, 'Simple and stable learning');
INSERT INTO public.options_backup VALUES (1602, 401, 'No need for rewards');
INSERT INTO public.options_backup VALUES (1603, 401, 'No exploration required');
INSERT INTO public.options_backup VALUES (1604, 401, 'Works only with neural networks');
INSERT INTO public.options_backup VALUES (1605, 402, 'Optimal Q-values following current policy');
INSERT INTO public.options_backup VALUES (1606, 402, 'Optimal dataset');
INSERT INTO public.options_backup VALUES (1607, 402, 'Optimal clustering');
INSERT INTO public.options_backup VALUES (1608, 402, 'Optimal regression model');


--
-- Data for Name: purchases; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.purchases VALUES (1, 10, '2026-03-28 13:37:39.282006', 'pay_SWZe4VWdpvhSnw', '2027-03-28 13:37:39.282006', 81, 'jignesh@gmail.com');
INSERT INTO public.purchases VALUES (2, 10, '2026-03-28 13:45:39.234638', 'pay_SWZmZ4qE42kwrw', '2027-03-28 13:45:39.234638', 81, 'jignesh@gmail.com');
INSERT INTO public.purchases VALUES (3, 9, '2026-03-28 13:51:37.162348', 'pay_SWZsu00EAsz0FW', '2027-03-28 13:51:37.162348', 81, 'jp1@gmail.com');
INSERT INTO public.purchases VALUES (4, 12, '2026-03-28 14:00:33.496493', 'pay_SWa2IRPl1aaD50', '2027-03-28 14:00:33.496493', 81, 'aalap@gmail.com');
INSERT INTO public.purchases VALUES (5, 12, '2026-03-28 15:03:01.484831', 'pay_SWb5bhfAT19wvX', '2027-03-28 15:03:01.484831', 81, 'aalap@gmail.com');


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.questions VALUES (5102, 1, 'What does DSA stand for?');
INSERT INTO public.questions VALUES (5103, 1, 'What is a data structure?');
INSERT INTO public.questions VALUES (5104, 1, 'What is an algorithm?');
INSERT INTO public.questions VALUES (5105, 1, 'Which is a linear data structure?');
INSERT INTO public.questions VALUES (5106, 1, 'Which is a non-linear data structure?');
INSERT INTO public.questions VALUES (5107, 1, 'Why are data structures important?');
INSERT INTO public.questions VALUES (5108, 1, 'Which data structure follows LIFO?');
INSERT INTO public.questions VALUES (5109, 1, 'Which data structure follows FIFO?');
INSERT INTO public.questions VALUES (5110, 1, 'Which is not a data structure?');
INSERT INTO public.questions VALUES (5111, 1, 'Which is a real-life example of stack?');
INSERT INTO public.questions VALUES (5112, 1, 'Which is a real-life example of queue?');
INSERT INTO public.questions VALUES (5113, 1, 'Which data structure uses key-value pairs?');
INSERT INTO public.questions VALUES (5114, 1, 'Which data structure is dynamic?');
INSERT INTO public.questions VALUES (5115, 1, 'Which data structure is best for recursion?');
INSERT INTO public.questions VALUES (5116, 1, 'Which is faster for indexed access?');
INSERT INTO public.questions VALUES (5117, 1, 'Which is language independent?');
INSERT INTO public.questions VALUES (5118, 1, 'What is the main goal of DSA?');
INSERT INTO public.questions VALUES (5119, 1, 'Which data structure is hierarchical?');
INSERT INTO public.questions VALUES (5120, 1, 'Which data structure represents relationships?');
INSERT INTO public.questions VALUES (5121, 1, 'DSA is mainly used in?');
INSERT INTO public.questions VALUES (5122, 3, 'What is an array?');
INSERT INTO public.questions VALUES (5123, 3, 'Array elements are stored in?');
INSERT INTO public.questions VALUES (5124, 3, 'Index of first element?');
INSERT INTO public.questions VALUES (5125, 3, 'Access time of array element?');
INSERT INTO public.questions VALUES (5126, 3, 'Main drawback of array?');
INSERT INTO public.questions VALUES (5127, 3, 'Which operation is costly?');
INSERT INTO public.questions VALUES (5128, 3, 'Array size is?');
INSERT INTO public.questions VALUES (5129, 3, 'Which search works on array?');
INSERT INTO public.questions VALUES (5130, 3, 'Binary search needs?');
INSERT INTO public.questions VALUES (5131, 3, 'Which array stores rows & columns?');
INSERT INTO public.questions VALUES (5132, 3, 'Time complexity of array traversal?');
INSERT INTO public.questions VALUES (5133, 3, 'Which is dynamic alternative?');
INSERT INTO public.questions VALUES (5134, 3, 'Memory allocation happens?');
INSERT INTO public.questions VALUES (5135, 3, 'Array index starts from?');
INSERT INTO public.questions VALUES (5136, 3, 'Which is faster?');
INSERT INTO public.questions VALUES (5137, 3, 'Insertion at end complexity?');
INSERT INTO public.questions VALUES (5138, 3, 'Deletion from array cost?');
INSERT INTO public.questions VALUES (5139, 3, 'Which array allows varying row size?');
INSERT INTO public.questions VALUES (5140, 3, 'Array stores data in?');
INSERT INTO public.questions VALUES (5141, 3, 'Best use of array?');
INSERT INTO public.questions VALUES (5142, 4, 'What is a string?');
INSERT INTO public.questions VALUES (5143, 4, 'Strings are stored as?');
INSERT INTO public.questions VALUES (5144, 4, 'String indexing starts from?');
INSERT INTO public.questions VALUES (5145, 4, 'Which operation is common?');
INSERT INTO public.questions VALUES (5146, 4, 'Time complexity of string length?');
INSERT INTO public.questions VALUES (5147, 4, 'Strings are immutable in?');
INSERT INTO public.questions VALUES (5148, 4, 'Which stores characters?');
INSERT INTO public.questions VALUES (5149, 4, 'Substring is?');
INSERT INTO public.questions VALUES (5150, 4, 'Which function compares strings?');
INSERT INTO public.questions VALUES (5151, 4, 'String traversal complexity?');
INSERT INTO public.questions VALUES (5152, 4, 'Which is mutable?');
INSERT INTO public.questions VALUES (5153, 4, 'Palindrome check complexity?');
INSERT INTO public.questions VALUES (5154, 4, 'String reverse complexity?');
INSERT INTO public.questions VALUES (5155, 4, 'Which uses regex?');
INSERT INTO public.questions VALUES (5156, 4, 'ASCII stands for?');
INSERT INTO public.questions VALUES (5157, 4, 'Unicode supports?');
INSERT INTO public.questions VALUES (5158, 4, 'String comparison uses?');
INSERT INTO public.questions VALUES (5159, 4, 'Which is not string operation?');
INSERT INTO public.questions VALUES (5160, 4, 'String search example?');
INSERT INTO public.questions VALUES (5161, 4, 'Best use of string?');
INSERT INTO public.questions VALUES (5162, 5, 'What is searching?');
INSERT INTO public.questions VALUES (5163, 5, 'Which is the simplest searching algorithm?');
INSERT INTO public.questions VALUES (5164, 5, 'Time complexity of linear search (worst case)?');
INSERT INTO public.questions VALUES (5165, 5, 'Binary search works on?');
INSERT INTO public.questions VALUES (5166, 5, 'Time complexity of binary search?');
INSERT INTO public.questions VALUES (5167, 5, 'Which search divides array into halves?');
INSERT INTO public.questions VALUES (5168, 5, 'Linear search is also called?');
INSERT INTO public.questions VALUES (5169, 5, 'Best case of linear search?');
INSERT INTO public.questions VALUES (5170, 5, 'Binary search uses which approach?');
INSERT INTO public.questions VALUES (5171, 5, 'Binary search worst case?');
INSERT INTO public.questions VALUES (5172, 5, 'Searching means?');
INSERT INTO public.questions VALUES (5173, 5, 'Which is faster generally?');
INSERT INTO public.questions VALUES (5174, 5, 'Binary search fails if?');
INSERT INTO public.questions VALUES (5175, 5, 'Linear search works on?');
INSERT INTO public.questions VALUES (5176, 5, 'Binary search recursive depth?');
INSERT INTO public.questions VALUES (5177, 5, 'Searching is used for?');
INSERT INTO public.questions VALUES (5178, 5, 'Which is not searching algorithm?');
INSERT INTO public.questions VALUES (5179, 5, 'Binary search space complexity?');
INSERT INTO public.questions VALUES (5180, 5, 'Linear search space complexity?');
INSERT INTO public.questions VALUES (5181, 5, 'Searching improves?');
INSERT INTO public.questions VALUES (5182, 6, 'What is sorting?');
INSERT INTO public.questions VALUES (5183, 6, 'Which sorting is simplest?');
INSERT INTO public.questions VALUES (5184, 6, 'Bubble sort complexity?');
INSERT INTO public.questions VALUES (5185, 6, 'Which is fastest generally?');
INSERT INTO public.questions VALUES (5186, 6, 'Merge sort uses?');
INSERT INTO public.questions VALUES (5187, 6, 'Merge sort time complexity?');
INSERT INTO public.questions VALUES (5188, 6, 'Which is stable sort?');
INSERT INTO public.questions VALUES (5189, 6, 'Selection sort complexity?');
INSERT INTO public.questions VALUES (5190, 6, 'Insertion sort best case?');
INSERT INTO public.questions VALUES (5191, 6, 'Quick sort worst case?');
INSERT INTO public.questions VALUES (5192, 6, 'Sorting improves?');
INSERT INTO public.questions VALUES (5193, 6, 'Which sort uses pivot?');
INSERT INTO public.questions VALUES (5194, 6, 'Heap sort uses?');
INSERT INTO public.questions VALUES (5195, 6, 'Bubble sort compares?');
INSERT INTO public.questions VALUES (5196, 6, 'Insertion sort is good for?');
INSERT INTO public.questions VALUES (5197, 6, 'Sorting order can be?');
INSERT INTO public.questions VALUES (5198, 6, 'Which is in-place sort?');
INSERT INTO public.questions VALUES (5199, 6, 'Which uses recursion?');
INSERT INTO public.questions VALUES (5200, 6, 'Stable sort means?');
INSERT INTO public.questions VALUES (5201, 6, 'Sorting is required for?');
INSERT INTO public.questions VALUES (5202, 7, 'Prime number is?');
INSERT INTO public.questions VALUES (5203, 7, '2 is?');
INSERT INTO public.questions VALUES (5204, 7, 'LCM stands for?');
INSERT INTO public.questions VALUES (5205, 7, 'GCD means?');
INSERT INTO public.questions VALUES (5206, 7, 'Modulo operator gives?');
INSERT INTO public.questions VALUES (5207, 7, 'Even number divisible by?');
INSERT INTO public.questions VALUES (5208, 7, 'Odd numbers end with?');
INSERT INTO public.questions VALUES (5209, 7, 'Factorial of 0?');
INSERT INTO public.questions VALUES (5210, 7, '10 % 3 = ?');
INSERT INTO public.questions VALUES (5211, 7, 'Power operator is?');
INSERT INTO public.questions VALUES (5212, 7, 'Math helps in?');
INSERT INTO public.questions VALUES (5213, 7, 'Fibonacci starts with?');
INSERT INTO public.questions VALUES (5214, 7, 'Prime numbers are?');
INSERT INTO public.questions VALUES (5215, 7, 'Square of 5?');
INSERT INTO public.questions VALUES (5216, 7, 'Cube of 3?');
INSERT INTO public.questions VALUES (5217, 7, 'Binary number system base?');
INSERT INTO public.questions VALUES (5218, 7, 'Decimal system base?');
INSERT INTO public.questions VALUES (5219, 7, 'Math used in DSA?');
INSERT INTO public.questions VALUES (5220, 7, 'GCD of 10 & 5?');
INSERT INTO public.questions VALUES (5221, 7, 'LCM of 4 & 6?');
INSERT INTO public.questions VALUES (5222, 8, 'Stack follows?');
INSERT INTO public.questions VALUES (5223, 8, 'Push operation?');
INSERT INTO public.questions VALUES (5224, 8, 'Pop removes?');
INSERT INTO public.questions VALUES (5225, 8, 'Stack real example?');
INSERT INTO public.questions VALUES (5226, 8, 'Top pointer refers to?');
INSERT INTO public.questions VALUES (5227, 8, 'Stack overflow means?');
INSERT INTO public.questions VALUES (5228, 8, 'Stack underflow?');
INSERT INTO public.questions VALUES (5229, 8, 'Which uses stack?');
INSERT INTO public.questions VALUES (5230, 8, 'Infix to postfix uses?');
INSERT INTO public.questions VALUES (5231, 8, 'Peek operation?');
INSERT INTO public.questions VALUES (5232, 8, 'Stack is?');
INSERT INTO public.questions VALUES (5233, 8, 'Call stack used in?');
INSERT INTO public.questions VALUES (5234, 8, 'Stack memory?');
INSERT INTO public.questions VALUES (5235, 8, 'Stack size is?');
INSERT INTO public.questions VALUES (5236, 8, 'Expression evaluation uses?');
INSERT INTO public.questions VALUES (5237, 8, 'Stack can be implemented by?');
INSERT INTO public.questions VALUES (5238, 8, 'Recursive calls stored in?');
INSERT INTO public.questions VALUES (5239, 8, 'Undo feature uses?');
INSERT INTO public.questions VALUES (5240, 8, 'Stack traversal?');
INSERT INTO public.questions VALUES (5241, 8, 'Stack access?');
INSERT INTO public.questions VALUES (5242, 9, 'Queue follows?');
INSERT INTO public.questions VALUES (5243, 9, 'Enqueue means?');
INSERT INTO public.questions VALUES (5244, 9, 'Dequeue removes?');
INSERT INTO public.questions VALUES (5245, 9, 'Queue real example?');
INSERT INTO public.questions VALUES (5246, 9, 'Queue used in?');
INSERT INTO public.questions VALUES (5247, 9, 'Overflow in queue?');
INSERT INTO public.questions VALUES (5248, 9, 'Underflow in queue?');
INSERT INTO public.questions VALUES (5249, 9, 'Queue is?');
INSERT INTO public.questions VALUES (5250, 9, 'Circular queue advantage?');
INSERT INTO public.questions VALUES (5251, 9, 'Queue implemented using?');
INSERT INTO public.questions VALUES (5252, 9, 'Front pointer?');
INSERT INTO public.questions VALUES (5253, 9, 'Rear pointer?');
INSERT INTO public.questions VALUES (5254, 9, 'Priority queue removes?');
INSERT INTO public.questions VALUES (5255, 9, 'Queue traversal?');
INSERT INTO public.questions VALUES (5256, 9, 'Queue used in BFS?');
INSERT INTO public.questions VALUES (5257, 9, 'Queue insertion end?');
INSERT INTO public.questions VALUES (5258, 9, 'Queue deletion from?');
INSERT INTO public.questions VALUES (5259, 9, 'Double ended queue?');
INSERT INTO public.questions VALUES (5260, 9, 'Queue is faster than stack?');
INSERT INTO public.questions VALUES (5261, 9, 'Queue maintains?');
INSERT INTO public.questions VALUES (5262, 10, 'Reverse array uses?');
INSERT INTO public.questions VALUES (5263, 10, 'Palindrome check uses?');
INSERT INTO public.questions VALUES (5264, 10, 'Max element search?');
INSERT INTO public.questions VALUES (5265, 10, 'Binary search requires?');
INSERT INTO public.questions VALUES (5266, 10, 'Duplicate detection uses?');
INSERT INTO public.questions VALUES (5267, 10, 'Array rotation uses?');
INSERT INTO public.questions VALUES (5268, 10, 'Anagram check uses?');
INSERT INTO public.questions VALUES (5269, 10, 'Two sum problem uses?');
INSERT INTO public.questions VALUES (5270, 10, 'Recursion base case?');
INSERT INTO public.questions VALUES (5271, 10, 'Fibonacci recursion complexity?');
INSERT INTO public.questions VALUES (5272, 10, 'Sliding window used for?');
INSERT INTO public.questions VALUES (5273, 10, 'Prefix sum optimizes?');
INSERT INTO public.questions VALUES (5274, 10, 'Stack used in?');
INSERT INTO public.questions VALUES (5275, 10, 'Queue used in?');
INSERT INTO public.questions VALUES (5276, 10, 'Time complexity analysis?');
INSERT INTO public.questions VALUES (5277, 10, 'Space complexity counts?');
INSERT INTO public.questions VALUES (5278, 10, 'Best practice for DSA?');
INSERT INTO public.questions VALUES (5279, 10, 'Problem solving improves?');
INSERT INTO public.questions VALUES (5280, 10, 'Edge case means?');
INSERT INTO public.questions VALUES (5281, 10, 'Practice makes?');
INSERT INTO public.questions VALUES (5282, 2, 'What does time complexity measure?');
INSERT INTO public.questions VALUES (5283, 2, 'What does space complexity measure?');
INSERT INTO public.questions VALUES (5284, 2, 'Worst case complexity is represented by?');
INSERT INTO public.questions VALUES (5285, 2, 'Best case complexity is represented by?');
INSERT INTO public.questions VALUES (5286, 2, 'Average case complexity is represented by?');
INSERT INTO public.questions VALUES (5287, 2, 'Time complexity of binary search?');
INSERT INTO public.questions VALUES (5288, 2, 'Time complexity of linear search?');
INSERT INTO public.questions VALUES (5289, 2, 'Fastest time complexity?');
INSERT INTO public.questions VALUES (5290, 2, 'Slowest growth?');
INSERT INTO public.questions VALUES (5291, 2, 'Time complexity of nested loop (n x n)?');
INSERT INTO public.questions VALUES (5292, 2, 'Space complexity of recursion?');
INSERT INTO public.questions VALUES (5293, 2, 'Which ignores constants?');
INSERT INTO public.questions VALUES (5294, 2, 'Time complexity of array access?');
INSERT INTO public.questions VALUES (5295, 2, 'Which grows fastest?');
INSERT INTO public.questions VALUES (5296, 2, 'Space complexity of algorithm with no extra memory?');
INSERT INTO public.questions VALUES (5297, 2, 'Why analyze complexity?');
INSERT INTO public.questions VALUES (5298, 2, 'Binary search works on?');
INSERT INTO public.questions VALUES (5299, 2, 'Which is not valid?');
INSERT INTO public.questions VALUES (5300, 2, 'Most used complexity?');
INSERT INTO public.questions VALUES (5301, 2, 'Time complexity helps in?');
INSERT INTO public.questions VALUES (5302, 81, 'What is the main objective of Reinforcement Learning?');
INSERT INTO public.questions VALUES (5303, 81, 'Which component interacts with the environment and learns from feedback?');
INSERT INTO public.questions VALUES (5304, 81, 'In Reinforcement Learning, the environment refers to?');
INSERT INTO public.questions VALUES (5305, 81, 'What represents the current situation observed by the agent?');
INSERT INTO public.questions VALUES (5306, 81, 'What is an action in Reinforcement Learning?');
INSERT INTO public.questions VALUES (5307, 81, 'Which concept defines the strategy followed by an agent?');
INSERT INTO public.questions VALUES (5308, 81, 'What is the feedback signal indicating good or bad action?');
INSERT INTO public.questions VALUES (5309, 81, 'RL learning is mainly based on?');
INSERT INTO public.questions VALUES (5310, 81, 'RL differs from supervised learning because?');
INSERT INTO public.questions VALUES (5311, 81, 'What determines environment change after an action?');
INSERT INTO public.questions VALUES (5312, 81, 'Sequence of states, actions and rewards is called?');
INSERT INTO public.questions VALUES (5313, 81, 'Which parameter controls importance of future rewards?');
INSERT INTO public.questions VALUES (5314, 81, 'Symbol used for discount factor?');
INSERT INTO public.questions VALUES (5315, 81, 'Trying new actions is called?');
INSERT INTO public.questions VALUES (5316, 81, 'Choosing known rewarding action is?');
INSERT INTO public.questions VALUES (5317, 81, 'Important balance in RL?');
INSERT INTO public.questions VALUES (5318, 81, 'Which AI field studies agents learning via interaction?');
INSERT INTO public.questions VALUES (5319, 81, 'Real world RL application?');
INSERT INTO public.questions VALUES (5320, 81, 'RL is suitable for?');
INSERT INTO public.questions VALUES (5321, 81, 'Overall RL learning process?');
INSERT INTO public.questions VALUES (5322, 82, 'Which component in the Reinforcement Learning framework is responsible for making decisions and learning from experience?');
INSERT INTO public.questions VALUES (5323, 82, 'In the Reinforcement Learning framework, the environment represents?');
INSERT INTO public.questions VALUES (5324, 82, 'Which element represents the situation observed by the agent at a given time?');
INSERT INTO public.questions VALUES (5325, 82, 'The action taken by an agent influences?');
INSERT INTO public.questions VALUES (5326, 82, 'Which component provides feedback to the agent about the quality of action?');
INSERT INTO public.questions VALUES (5327, 82, 'Policy in RL framework is?');
INSERT INTO public.questions VALUES (5328, 82, 'Which element determines how environment moves from one state to another?');
INSERT INTO public.questions VALUES (5329, 82, 'Main objective of agent in RL framework?');
INSERT INTO public.questions VALUES (5330, 82, 'Long-term accumulated reward is called?');
INSERT INTO public.questions VALUES (5331, 82, 'Parameter deciding importance of future rewards?');
INSERT INTO public.questions VALUES (5332, 82, 'Sequence of interactions until terminal state?');
INSERT INTO public.questions VALUES (5333, 82, 'Component used to evaluate expected future reward from state?');
INSERT INTO public.questions VALUES (5334, 82, 'Function estimating reward for taking action in state?');
INSERT INTO public.questions VALUES (5335, 82, 'Probability of moving from one state to another after action?');
INSERT INTO public.questions VALUES (5336, 82, 'Which part helps agent improve policy based on experience?');
INSERT INTO public.questions VALUES (5337, 82, 'Trade-off deciding whether to try new actions or use known ones?');
INSERT INTO public.questions VALUES (5338, 82, 'Which component determines how agent learns from rewards?');
INSERT INTO public.questions VALUES (5339, 82, 'Rule describing how agent selects action based on state?');
INSERT INTO public.questions VALUES (5340, 82, 'Which characteristic allows agent to learn optimal behavior?');
INSERT INTO public.questions VALUES (5341, 82, 'Best summary of RL framework?');
INSERT INTO public.questions VALUES (5342, 83, 'What does the Markov property state in Reinforcement Learning?');
INSERT INTO public.questions VALUES (5343, 83, 'Which of the following is NOT a fundamental component of MDP?');
INSERT INTO public.questions VALUES (5344, 83, 'State space in MDP represents?');
INSERT INTO public.questions VALUES (5345, 83, 'Action space refers to?');
INSERT INTO public.questions VALUES (5346, 83, 'Which function defines probability of moving to next state?');
INSERT INTO public.questions VALUES (5347, 83, 'Purpose of reward function in MDP?');
INSERT INTO public.questions VALUES (5348, 83, 'Primary objective in solving MDP?');
INSERT INTO public.questions VALUES (5349, 83, 'Strategy determining action in a state?');
INSERT INTO public.questions VALUES (5350, 83, 'Notation for transition probability?');
INSERT INTO public.questions VALUES (5351, 83, 'Parameter discounting future rewards?');
INSERT INTO public.questions VALUES (5352, 83, 'Symbol commonly used for discount factor?');
INSERT INTO public.questions VALUES (5353, 83, 'Expected total reward from a state is?');
INSERT INTO public.questions VALUES (5354, 83, 'Concept ensuring dependence only on current state?');
INSERT INTO public.questions VALUES (5355, 83, 'Theoretical foundation of most RL algorithms?');
INSERT INTO public.questions VALUES (5356, 83, 'Best type of problems modeled by MDP?');
INSERT INTO public.questions VALUES (5357, 83, 'Relationship between states, actions and rewards?');
INSERT INTO public.questions VALUES (5358, 83, 'Real-world MDP example?');
INSERT INTO public.questions VALUES (5359, 83, 'Component determining likelihood of next state?');
INSERT INTO public.questions VALUES (5360, 83, 'Concept measuring how good a state is?');
INSERT INTO public.questions VALUES (5361, 83, 'Best summary of MDP?');
INSERT INTO public.questions VALUES (5362, 84, 'State-value function represents what in Reinforcement Learning?');
INSERT INTO public.questions VALUES (5363, 84, 'Common notation for state-value function?');
INSERT INTO public.questions VALUES (5364, 84, 'State-value function evaluates?');
INSERT INTO public.questions VALUES (5365, 84, 'State-value function depends on?');
INSERT INTO public.questions VALUES (5366, 84, 'Notation for state-value function under policy π?');
INSERT INTO public.questions VALUES (5367, 84, 'State-value function helps in?');
INSERT INTO public.questions VALUES (5368, 84, 'Which component estimates future reward expectation?');
INSERT INTO public.questions VALUES (5369, 84, 'State-value function is mainly used in?');
INSERT INTO public.questions VALUES (5370, 84, 'Expected return from state s is calculated using?');
INSERT INTO public.questions VALUES (5371, 84, 'State-value function improves?');
INSERT INTO public.questions VALUES (5372, 84, 'Which RL methods use value functions extensively?');
INSERT INTO public.questions VALUES (5373, 84, 'Higher value of V(s) indicates?');
INSERT INTO public.questions VALUES (5374, 84, 'State-value function is defined for?');
INSERT INTO public.questions VALUES (5375, 84, 'State-value function helps agent to?');
INSERT INTO public.questions VALUES (5376, 84, 'Which concept links state-value and action-value?');
INSERT INTO public.questions VALUES (5377, 84, 'State-value estimation becomes accurate when?');
INSERT INTO public.questions VALUES (5378, 84, 'State-value function helps to measure?');
INSERT INTO public.questions VALUES (5379, 84, 'Value functions are central to?');
INSERT INTO public.questions VALUES (5380, 84, 'Which function evaluates policy performance?');
INSERT INTO public.questions VALUES (5381, 84, 'Best summary of state-value function?');
INSERT INTO public.questions VALUES (5382, 85, 'What does the action-value function represent in Reinforcement Learning?');
INSERT INTO public.questions VALUES (5383, 85, 'Common notation for action-value function?');
INSERT INTO public.questions VALUES (5384, 85, 'Action-value function evaluates?');
INSERT INTO public.questions VALUES (5385, 85, 'Action-value function is useful for?');
INSERT INTO public.questions VALUES (5386, 85, 'Notation for action-value under policy π?');
INSERT INTO public.questions VALUES (5387, 85, 'Which RL algorithm directly estimates Q-values?');
INSERT INTO public.questions VALUES (5388, 85, 'Higher Q-value means?');
INSERT INTO public.questions VALUES (5389, 85, 'Action-value function helps in?');
INSERT INTO public.questions VALUES (5390, 85, 'Which function compares multiple actions in a state?');
INSERT INTO public.questions VALUES (5391, 85, 'Action-value depends on?');
INSERT INTO public.questions VALUES (5392, 85, 'Expected return from state-action pair is?');
INSERT INTO public.questions VALUES (5393, 85, 'Action-value function is central to?');
INSERT INTO public.questions VALUES (5394, 85, 'Relationship between V(s) and Q(s,a)?');
INSERT INTO public.questions VALUES (5395, 85, 'Which RL method uses Q-table?');
INSERT INTO public.questions VALUES (5396, 85, 'Action-value estimation improves when?');
INSERT INTO public.questions VALUES (5397, 85, 'Which function guides optimal action selection?');
INSERT INTO public.questions VALUES (5398, 85, 'Q(s,a) helps agent to?');
INSERT INTO public.questions VALUES (5399, 85, 'Action-value functions are estimated using?');
INSERT INTO public.questions VALUES (5400, 85, 'Which concept links action-value with optimal policy?');
INSERT INTO public.questions VALUES (5401, 85, 'Best summary of action-value function?');
INSERT INTO public.questions VALUES (5402, 86, 'What idea does the Bellman equation mainly represent?');
INSERT INTO public.questions VALUES (5403, 86, 'Bellman equation is mainly used to compute?');
INSERT INTO public.questions VALUES (5404, 86, 'Who introduced Bellman equations?');
INSERT INTO public.questions VALUES (5405, 86, 'Value of a state equals which two components?');
INSERT INTO public.questions VALUES (5406, 86, 'Recursive nature of value functions is based on?');
INSERT INTO public.questions VALUES (5407, 86, 'Bellman equation for V(s) expresses value in terms of?');
INSERT INTO public.questions VALUES (5408, 86, 'Equation defining expected return under policy?');
INSERT INTO public.questions VALUES (5409, 86, 'Which probability distribution is used in expectation?');
INSERT INTO public.questions VALUES (5410, 86, 'Bellman equation relies on which concept?');
INSERT INTO public.questions VALUES (5411, 86, 'Which RL algorithms rely heavily on Bellman equations?');
INSERT INTO public.questions VALUES (5412, 86, 'Bellman equations operate on which framework?');
INSERT INTO public.questions VALUES (5413, 86, 'Bellman equation for Q-values relates to?');
INSERT INTO public.questions VALUES (5414, 86, 'Which parameter controls future reward importance?');
INSERT INTO public.questions VALUES (5415, 86, 'Symbol commonly used for discount factor?');
INSERT INTO public.questions VALUES (5416, 86, 'Which concept ensures value depends on best future actions?');
INSERT INTO public.questions VALUES (5417, 86, 'Bellman expectation equation is used when?');
INSERT INTO public.questions VALUES (5418, 86, 'Bellman optimality equation determines?');
INSERT INTO public.questions VALUES (5419, 86, 'Bellman equations break problems using?');
INSERT INTO public.questions VALUES (5420, 86, 'Role of Bellman equations in RL?');
INSERT INTO public.questions VALUES (5421, 86, 'Best summary of Bellman equations?');
INSERT INTO public.questions VALUES (5422, 87, 'What does an optimal policy represent in Reinforcement Learning?');
INSERT INTO public.questions VALUES (5423, 87, 'Common notation for optimal policy?');
INSERT INTO public.questions VALUES (5424, 87, 'Optimal value function represents?');
INSERT INTO public.questions VALUES (5425, 87, 'Notation for optimal state-value function?');
INSERT INTO public.questions VALUES (5426, 87, 'Notation for optimal action-value function?');
INSERT INTO public.questions VALUES (5427, 87, 'What does V*(s) indicate?');
INSERT INTO public.questions VALUES (5428, 87, 'Relationship between optimal state and action value?');
INSERT INTO public.questions VALUES (5429, 87, 'Which principle states optimal policy can be derived once optimal value known?');
INSERT INTO public.questions VALUES (5430, 87, 'Selecting best action based on highest reward is?');
INSERT INTO public.questions VALUES (5431, 87, 'Optimal value property ensures?');
INSERT INTO public.questions VALUES (5432, 87, 'Which algorithm estimates optimal Q*(s,a)?');
INSERT INTO public.questions VALUES (5433, 87, 'Which method repeatedly updates value estimates?');
INSERT INTO public.questions VALUES (5434, 87, 'Algorithm alternating evaluation and improvement?');
INSERT INTO public.questions VALUES (5435, 87, 'Relationship between value functions and policies?');
INSERT INTO public.questions VALUES (5436, 87, 'Concept using max action value to compute optimal state value?');
INSERT INTO public.questions VALUES (5437, 87, 'Optimal policies guarantee?');
INSERT INTO public.questions VALUES (5438, 87, 'Technique updating state values until convergence?');
INSERT INTO public.questions VALUES (5439, 87, 'Which function directly selects best action?');
INSERT INTO public.questions VALUES (5440, 87, 'Policy stability means?');
INSERT INTO public.questions VALUES (5441, 87, 'Best summary of optimality in RL?');
INSERT INTO public.questions VALUES (5442, 88, 'Bellman Optimality Equation helps to determine?');
INSERT INTO public.questions VALUES (5443, 88, 'Notation for optimal state-value function?');
INSERT INTO public.questions VALUES (5444, 88, 'Notation for optimal action-value function?');
INSERT INTO public.questions VALUES (5445, 88, 'Optimal state value is computed using which operation?');
INSERT INTO public.questions VALUES (5446, 88, 'Bellman optimality equation expresses value as?');
INSERT INTO public.questions VALUES (5447, 88, 'Which RL algorithms rely on Bellman optimality updates?');
INSERT INTO public.questions VALUES (5448, 88, 'Bellman optimality equations are based on?');
INSERT INTO public.questions VALUES (5449, 88, 'Parameter controlling importance of future rewards?');
INSERT INTO public.questions VALUES (5450, 88, 'Symbol commonly used for discount factor?');
INSERT INTO public.questions VALUES (5451, 88, 'Principle stating optimal action maximizes future reward?');
INSERT INTO public.questions VALUES (5452, 88, 'Optimal state value depends on?');
INSERT INTO public.questions VALUES (5453, 88, 'Bellman optimality equation computes?');
INSERT INTO public.questions VALUES (5454, 88, 'Which RL method repeatedly applies optimality updates?');
INSERT INTO public.questions VALUES (5455, 88, 'Algorithm learning optimal Q-values iteratively?');
INSERT INTO public.questions VALUES (5456, 88, 'Bellman optimality equations allow problems to be broken into?');
INSERT INTO public.questions VALUES (5457, 88, 'Optimal state value equals?');
INSERT INTO public.questions VALUES (5458, 88, 'Optimal policy can be derived using?');
INSERT INTO public.questions VALUES (5459, 88, 'Bellman optimality equation for Q*(s,a) relates to?');
INSERT INTO public.questions VALUES (5460, 88, 'Which operator ensures best action selection?');
INSERT INTO public.questions VALUES (5461, 88, 'Best summary of Bellman optimality equations?');
INSERT INTO public.questions VALUES (5462, 89, 'Dynamic Programming methods in RL require what assumption?');
INSERT INTO public.questions VALUES (5463, 89, 'Dynamic Programming is mainly used for?');
INSERT INTO public.questions VALUES (5464, 89, 'Which two main DP methods are used in RL?');
INSERT INTO public.questions VALUES (5465, 89, 'Dynamic Programming updates are based on?');
INSERT INTO public.questions VALUES (5466, 89, 'DP methods compute value functions using?');
INSERT INTO public.questions VALUES (5467, 89, 'Which condition must hold for DP to work effectively?');
INSERT INTO public.questions VALUES (5468, 89, 'Dynamic Programming assumes environment is?');
INSERT INTO public.questions VALUES (5469, 89, 'DP methods improve policy using?');
INSERT INTO public.questions VALUES (5470, 89, 'Value updates in DP continue until?');
INSERT INTO public.questions VALUES (5471, 89, 'Which RL framework is most associated with DP?');
INSERT INTO public.questions VALUES (5472, 89, 'DP provides?');
INSERT INTO public.questions VALUES (5473, 89, 'DP algorithms require computation over?');
INSERT INTO public.questions VALUES (5474, 89, 'Which concept ensures DP breaks problem into subproblems?');
INSERT INTO public.questions VALUES (5475, 89, 'DP assumes transition probabilities are?');
INSERT INTO public.questions VALUES (5476, 89, 'Policy evaluation step computes?');
INSERT INTO public.questions VALUES (5477, 89, 'Policy improvement step selects?');
INSERT INTO public.questions VALUES (5478, 89, 'Dynamic Programming can be computationally?');
INSERT INTO public.questions VALUES (5479, 89, 'DP methods are mainly used in?');
INSERT INTO public.questions VALUES (5480, 89, 'Which update equation DP repeatedly applies?');
INSERT INTO public.questions VALUES (5481, 89, 'Best summary of Dynamic Programming in RL?');
INSERT INTO public.questions VALUES (5482, 90, 'Policy Iteration is mainly used to find?');
INSERT INTO public.questions VALUES (5483, 90, 'Policy Iteration consists of which two main steps?');
INSERT INTO public.questions VALUES (5484, 90, 'Policy Evaluation step computes?');
INSERT INTO public.questions VALUES (5485, 90, 'Policy Improvement step selects actions based on?');
INSERT INTO public.questions VALUES (5486, 90, 'Policy Iteration repeatedly alternates between?');
INSERT INTO public.questions VALUES (5487, 90, 'Policy Iteration converges when?');
INSERT INTO public.questions VALUES (5488, 90, 'Stable policy means?');
INSERT INTO public.questions VALUES (5489, 90, 'Policy Iteration requires knowledge of?');
INSERT INTO public.questions VALUES (5490, 90, 'Policy Iteration is an example of?');
INSERT INTO public.questions VALUES (5491, 90, 'Which equation is used during policy evaluation?');
INSERT INTO public.questions VALUES (5492, 90, 'Policy improvement uses which operator?');
INSERT INTO public.questions VALUES (5493, 90, 'Policy Iteration guarantees?');
INSERT INTO public.questions VALUES (5494, 90, 'Value function update continues until?');
INSERT INTO public.questions VALUES (5495, 90, 'Policy Iteration is computationally?');
INSERT INTO public.questions VALUES (5496, 90, 'Policy Iteration improves decision-making by?');
INSERT INTO public.questions VALUES (5497, 90, 'Policy Iteration is mainly used in?');
INSERT INTO public.questions VALUES (5498, 90, 'Policy evaluation step solves which function?');
INSERT INTO public.questions VALUES (5499, 90, 'Policy improvement step updates?');
INSERT INTO public.questions VALUES (5500, 90, 'Which framework is Policy Iteration based on?');
INSERT INTO public.questions VALUES (5501, 90, 'Best summary of Policy Iteration?');
INSERT INTO public.questions VALUES (5502, 91, 'Value Iteration is mainly used to compute?');
INSERT INTO public.questions VALUES (5503, 91, 'Value Iteration is based on which equation?');
INSERT INTO public.questions VALUES (5504, 91, 'Value Iteration directly updates?');
INSERT INTO public.questions VALUES (5505, 91, 'Value Iteration combines which two steps?');
INSERT INTO public.questions VALUES (5506, 91, 'Value Iteration uses which operator over actions?');
INSERT INTO public.questions VALUES (5507, 91, 'Value Iteration continues until?');
INSERT INTO public.questions VALUES (5508, 91, 'Value Iteration requires knowledge of?');
INSERT INTO public.questions VALUES (5509, 91, 'Value Iteration is an example of?');
INSERT INTO public.questions VALUES (5510, 91, 'After convergence, optimal policy is obtained by?');
INSERT INTO public.questions VALUES (5511, 91, 'Value Iteration computes value updates for?');
INSERT INTO public.questions VALUES (5512, 91, 'Which framework does Value Iteration operate on?');
INSERT INTO public.questions VALUES (5513, 91, 'Value Iteration guarantees?');
INSERT INTO public.questions VALUES (5514, 91, 'Value Iteration is computationally?');
INSERT INTO public.questions VALUES (5515, 91, 'Value Iteration uses which concept?');
INSERT INTO public.questions VALUES (5516, 91, 'Optimal state value depends on?');
INSERT INTO public.questions VALUES (5517, 91, 'Value Iteration improves decision-making by?');
INSERT INTO public.questions VALUES (5518, 91, 'Which RL algorithm is closely related to Value Iteration?');
INSERT INTO public.questions VALUES (5519, 91, 'Value Iteration is mainly used in?');
INSERT INTO public.questions VALUES (5520, 91, 'Policy extraction after Value Iteration uses?');
INSERT INTO public.questions VALUES (5521, 91, 'Best summary of Value Iteration?');
INSERT INTO public.questions VALUES (5522, 92, 'What does planning mean in Reinforcement Learning?');
INSERT INTO public.questions VALUES (5523, 92, 'Planning methods require?');
INSERT INTO public.questions VALUES (5524, 92, 'Planning allows an agent to?');
INSERT INTO public.questions VALUES (5525, 92, 'Which framework is planning mainly applied on?');
INSERT INTO public.questions VALUES (5526, 92, 'Planning improves policy using?');
INSERT INTO public.questions VALUES (5527, 92, 'Planning methods rely on which updates?');
INSERT INTO public.questions VALUES (5528, 92, 'Planning can reduce?');
INSERT INTO public.questions VALUES (5529, 92, 'Model-based RL methods use?');
INSERT INTO public.questions VALUES (5530, 92, 'Planning helps estimate?');
INSERT INTO public.questions VALUES (5531, 92, 'Which DP methods are used for planning?');
INSERT INTO public.questions VALUES (5532, 92, 'Planning uses which type of experience?');
INSERT INTO public.questions VALUES (5533, 92, 'Planning improves decision-making by?');
INSERT INTO public.questions VALUES (5534, 92, 'Which component predicts next state in planning?');
INSERT INTO public.questions VALUES (5535, 92, 'Planning algorithms update value estimates?');
INSERT INTO public.questions VALUES (5536, 92, 'Planning can speed up learning because?');
INSERT INTO public.questions VALUES (5537, 92, 'Which RL paradigm combines planning and learning?');
INSERT INTO public.questions VALUES (5538, 92, 'Planning mainly helps in?');
INSERT INTO public.questions VALUES (5539, 92, 'Planning requires knowledge of?');
INSERT INTO public.questions VALUES (5540, 92, 'Planning updates continue until?');
INSERT INTO public.questions VALUES (5541, 92, 'Best summary of planning in RL?');
INSERT INTO public.questions VALUES (5542, 93, 'The Principle of Optimality states that?');
INSERT INTO public.questions VALUES (5543, 93, 'Which researcher introduced the Principle of Optimality?');
INSERT INTO public.questions VALUES (5544, 93, 'The Principle of Optimality is mainly used in?');
INSERT INTO public.questions VALUES (5545, 93, 'According to this principle, an optimal solution can be built from?');
INSERT INTO public.questions VALUES (5546, 93, 'Which framework in RL heavily relies on this principle?');
INSERT INTO public.questions VALUES (5547, 93, 'The Principle of Optimality helps in?');
INSERT INTO public.questions VALUES (5548, 93, 'Which equation is based on the Principle of Optimality?');
INSERT INTO public.questions VALUES (5549, 93, 'In RL, optimal decision-making depends on?');
INSERT INTO public.questions VALUES (5550, 93, 'The principle ensures that optimal policy from any state?');
INSERT INTO public.questions VALUES (5551, 93, 'Which RL methods use this principle directly?');
INSERT INTO public.questions VALUES (5552, 93, 'The principle allows recursive computation of?');
INSERT INTO public.questions VALUES (5553, 93, 'Optimal policy guarantees?');
INSERT INTO public.questions VALUES (5554, 93, 'The principle helps to reduce?');
INSERT INTO public.questions VALUES (5555, 93, 'Which RL concept is derived from this principle?');
INSERT INTO public.questions VALUES (5556, 93, 'Optimal value of a state depends on?');
INSERT INTO public.questions VALUES (5557, 93, 'The principle is important because it?');
INSERT INTO public.questions VALUES (5558, 93, 'Which type of problems benefit most from this principle?');
INSERT INTO public.questions VALUES (5559, 93, 'Principle of Optimality is useful in planning because?');
INSERT INTO public.questions VALUES (5560, 93, 'Optimal substructure property means?');
INSERT INTO public.questions VALUES (5561, 93, 'Best summary of Principle of Optimality?');
INSERT INTO public.questions VALUES (5562, 94, 'Monte Carlo methods in Reinforcement Learning are mainly based on?');
INSERT INTO public.questions VALUES (5563, 94, 'Monte Carlo methods estimate value functions using?');
INSERT INTO public.questions VALUES (5564, 94, 'Monte Carlo methods require?');
INSERT INTO public.questions VALUES (5565, 94, 'Which type of learning is used in Monte Carlo methods?');
INSERT INTO public.questions VALUES (5566, 94, 'Monte Carlo prediction is used to estimate?');
INSERT INTO public.questions VALUES (5567, 94, 'Monte Carlo methods update value estimates?');
INSERT INTO public.questions VALUES (5568, 94, 'Monte Carlo methods rely on which concept?');
INSERT INTO public.questions VALUES (5569, 94, 'Which type of tasks are Monte Carlo methods suitable for?');
INSERT INTO public.questions VALUES (5570, 94, 'Monte Carlo control is used to find?');
INSERT INTO public.questions VALUES (5571, 94, 'Which value is computed in Monte Carlo return?');
INSERT INTO public.questions VALUES (5572, 94, 'Monte Carlo methods do NOT require?');
INSERT INTO public.questions VALUES (5573, 94, 'Which strategy helps balance exploration in Monte Carlo control?');
INSERT INTO public.questions VALUES (5574, 94, 'First-visit Monte Carlo updates value when?');
INSERT INTO public.questions VALUES (5575, 94, 'Every-visit Monte Carlo updates value?');
INSERT INTO public.questions VALUES (5576, 94, 'Monte Carlo learning improves policy by?');
INSERT INTO public.questions VALUES (5577, 94, 'Monte Carlo methods converge when?');
INSERT INTO public.questions VALUES (5578, 94, 'Monte Carlo methods estimate which function directly?');
INSERT INTO public.questions VALUES (5579, 94, 'Which RL framework supports Monte Carlo learning?');
INSERT INTO public.questions VALUES (5580, 94, 'Monte Carlo methods are useful because?');
INSERT INTO public.questions VALUES (5581, 94, 'Best summary of Monte Carlo methods?');
INSERT INTO public.questions VALUES (5582, 95, 'TD(0) updates value estimates using?');
INSERT INTO public.questions VALUES (5583, 95, 'TD(0) update depends on which state?');
INSERT INTO public.questions VALUES (5584, 95, 'TD(0) target is?');
INSERT INTO public.questions VALUES (5585, 95, 'TD(0) is an example of?');
INSERT INTO public.questions VALUES (5586, 95, 'TD(0) learning occurs?');
INSERT INTO public.questions VALUES (5587, 95, 'TD(0) mainly estimates?');
INSERT INTO public.questions VALUES (5588, 95, 'Which framework supports TD(0)?');
INSERT INTO public.questions VALUES (5589, 95, 'TD(0) requires?');
INSERT INTO public.questions VALUES (5590, 95, 'TD(0) does NOT require?');
INSERT INTO public.questions VALUES (5591, 95, 'TD error in TD(0) represents?');
INSERT INTO public.questions VALUES (5592, 95, 'Discount factor in TD(0) controls?');
INSERT INTO public.questions VALUES (5593, 95, 'Learning rate in TD(0) controls?');
INSERT INTO public.questions VALUES (5594, 95, 'TD(0) learning is suitable for?');
INSERT INTO public.questions VALUES (5595, 95, 'TD(0) converges when?');
INSERT INTO public.questions VALUES (5596, 95, 'TD(0) improves policy by?');
INSERT INTO public.questions VALUES (5597, 95, 'TD(0) learning mainly uses which equation?');
INSERT INTO public.questions VALUES (5598, 95, 'TD(0) bootstraps from?');
INSERT INTO public.questions VALUES (5599, 95, 'TD(0) update is?');
INSERT INTO public.questions VALUES (5600, 95, 'TD(0) learning helps in?');
INSERT INTO public.questions VALUES (5601, 95, 'Best summary of TD(0)?');
INSERT INTO public.questions VALUES (5602, 96, 'TD(1) updates value estimates using?');
INSERT INTO public.questions VALUES (5603, 96, 'TD(1) is equivalent to which method?');
INSERT INTO public.questions VALUES (5604, 96, 'TD(1) bootstraps from?');
INSERT INTO public.questions VALUES (5605, 96, 'TD(1) updates occur?');
INSERT INTO public.questions VALUES (5606, 96, 'TD(1) mainly estimates?');
INSERT INTO public.questions VALUES (5607, 96, 'Return used in TD(1) is?');
INSERT INTO public.questions VALUES (5608, 96, 'TD(1) requires?');
INSERT INTO public.questions VALUES (5609, 96, 'TD(1) is suitable for?');
INSERT INTO public.questions VALUES (5610, 96, 'Which framework supports TD(1)?');
INSERT INTO public.questions VALUES (5611, 96, 'Discount factor in TD(1) controls?');
INSERT INTO public.questions VALUES (5612, 96, 'Learning rate in TD(1) controls?');
INSERT INTO public.questions VALUES (5613, 96, 'TD(1) learning converges when?');
INSERT INTO public.questions VALUES (5614, 96, 'TD(1) learning improves policy by?');
INSERT INTO public.questions VALUES (5615, 96, 'TD(1) update uses which equation?');
INSERT INTO public.questions VALUES (5616, 96, 'TD(1) has variance compared to TD(0)?');
INSERT INTO public.questions VALUES (5617, 96, 'TD(1) learning is useful because?');
INSERT INTO public.questions VALUES (5618, 96, 'TD(1) requires storing?');
INSERT INTO public.questions VALUES (5619, 96, 'TD(1) learning is also known as?');
INSERT INTO public.questions VALUES (5620, 96, 'TD(1) does NOT use?');
INSERT INTO public.questions VALUES (5621, 96, 'Best summary of TD(1)?');
INSERT INTO public.questions VALUES (5622, 97, 'TD(λ) combines ideas from which two methods?');
INSERT INTO public.questions VALUES (5623, 97, 'The parameter λ in TD(λ) controls?');
INSERT INTO public.questions VALUES (5624, 97, 'When λ = 0, TD(λ) becomes?');
INSERT INTO public.questions VALUES (5625, 97, 'When λ = 1, TD(λ) becomes similar to?');
INSERT INTO public.questions VALUES (5626, 97, 'TD(λ) uses which concept to assign credit to previous states?');
INSERT INTO public.questions VALUES (5627, 97, 'Eligibility traces help in?');
INSERT INTO public.questions VALUES (5628, 97, 'TD(λ) mainly estimates?');
INSERT INTO public.questions VALUES (5629, 97, 'TD(λ) learning occurs?');
INSERT INTO public.questions VALUES (5630, 97, 'TD(λ) is suitable for?');
INSERT INTO public.questions VALUES (5631, 97, 'Which framework supports TD(λ)?');
INSERT INTO public.questions VALUES (5632, 97, 'TD(λ) reduces variance compared to?');
INSERT INTO public.questions VALUES (5633, 97, 'TD(λ) introduces bias compared to?');
INSERT INTO public.questions VALUES (5634, 97, 'TD(λ) update depends on?');
INSERT INTO public.questions VALUES (5635, 97, 'Eligibility trace decays using?');
INSERT INTO public.questions VALUES (5636, 97, 'TD(λ) helps improve learning by?');
INSERT INTO public.questions VALUES (5637, 97, 'TD(λ) learning converges when?');
INSERT INTO public.questions VALUES (5638, 97, 'TD(λ) is mainly used for?');
INSERT INTO public.questions VALUES (5639, 97, 'TD(λ) requires?');
INSERT INTO public.questions VALUES (5640, 97, 'TD(λ) generalizes which methods?');
INSERT INTO public.questions VALUES (5641, 97, 'Best summary of TD(λ)?');
INSERT INTO public.questions VALUES (5642, 98, 'k-step estimators in RL use how many rewards for update?');
INSERT INTO public.questions VALUES (5643, 98, 'k-step methods combine ideas from?');
INSERT INTO public.questions VALUES (5644, 98, 'When k = 1, k-step estimator becomes?');
INSERT INTO public.questions VALUES (5645, 98, 'When k is very large, k-step estimator becomes similar to?');
INSERT INTO public.questions VALUES (5646, 98, 'k-step return includes?');
INSERT INTO public.questions VALUES (5647, 98, 'k-step estimators mainly estimate?');
INSERT INTO public.questions VALUES (5648, 98, 'k-step estimators help control?');
INSERT INTO public.questions VALUES (5649, 98, 'k-step methods are useful for?');
INSERT INTO public.questions VALUES (5650, 98, 'Which framework supports k-step estimators?');
INSERT INTO public.questions VALUES (5651, 98, 'k-step estimators update values?');
INSERT INTO public.questions VALUES (5652, 98, 'k-step learning requires?');
INSERT INTO public.questions VALUES (5653, 98, 'Discount factor in k-step return controls?');
INSERT INTO public.questions VALUES (5654, 98, 'Bootstrapping occurs in k-step estimators using?');
INSERT INTO public.questions VALUES (5655, 98, 'k-step methods can improve learning by?');
INSERT INTO public.questions VALUES (5656, 98, 'k-step estimators converge when?');
INSERT INTO public.questions VALUES (5657, 98, 'k-step learning is mainly used for?');
INSERT INTO public.questions VALUES (5658, 98, 'k-step estimators generalize which methods?');
INSERT INTO public.questions VALUES (5659, 98, 'Value update in k-step methods depends on?');
INSERT INTO public.questions VALUES (5660, 98, 'k-step estimators are incremental because?');
INSERT INTO public.questions VALUES (5661, 98, 'Best summary of k-step estimators?');
INSERT INTO public.questions VALUES (5662, 99, 'On-policy learning means?');
INSERT INTO public.questions VALUES (5663, 99, 'Off-policy learning means?');
INSERT INTO public.questions VALUES (5664, 99, 'Which algorithm is an example of on-policy learning?');
INSERT INTO public.questions VALUES (5665, 99, 'Which algorithm is an example of off-policy learning?');
INSERT INTO public.questions VALUES (5666, 99, 'On-policy learning updates value estimates using?');
INSERT INTO public.questions VALUES (5667, 99, 'Off-policy learning updates value estimates using?');
INSERT INTO public.questions VALUES (5668, 99, 'Which policy is used for behavior in off-policy learning?');
INSERT INTO public.questions VALUES (5669, 99, 'Which policy is evaluated in off-policy learning?');
INSERT INTO public.questions VALUES (5670, 99, 'Off-policy learning allows?');
INSERT INTO public.questions VALUES (5671, 99, 'On-policy methods are usually?');
INSERT INTO public.questions VALUES (5672, 99, 'Off-policy methods are useful because?');
INSERT INTO public.questions VALUES (5673, 99, 'Which concept helps off-policy learning correct distribution mismatch?');
INSERT INTO public.questions VALUES (5674, 99, 'In on-policy learning, exploration is controlled by?');
INSERT INTO public.questions VALUES (5675, 99, 'Which method directly learns optimal Q-values?');
INSERT INTO public.questions VALUES (5676, 99, 'Which method learns action values following same policy?');
INSERT INTO public.questions VALUES (5677, 99, 'Off-policy learning improves efficiency by?');
INSERT INTO public.questions VALUES (5678, 99, 'On-policy learning updates depend on?');
INSERT INTO public.questions VALUES (5679, 99, 'Off-policy learning update uses?');
INSERT INTO public.questions VALUES (5680, 99, 'Which learning type is more flexible for optimal control?');
INSERT INTO public.questions VALUES (5681, 99, 'Best summary of on-policy vs off-policy learning?');
INSERT INTO public.questions VALUES (5682, 100, 'SARSA stands for?');
INSERT INTO public.questions VALUES (5683, 100, 'SARSA is an example of?');
INSERT INTO public.questions VALUES (5684, 100, 'SARSA updates which function?');
INSERT INTO public.questions VALUES (5685, 100, 'SARSA update depends on?');
INSERT INTO public.questions VALUES (5686, 100, 'SARSA uses which learning type?');
INSERT INTO public.questions VALUES (5687, 100, 'SARSA policy improvement is usually done using?');
INSERT INTO public.questions VALUES (5688, 100, 'SARSA learning occurs?');
INSERT INTO public.questions VALUES (5689, 100, 'SARSA is safer because?');
INSERT INTO public.questions VALUES (5690, 100, 'SARSA update target includes?');
INSERT INTO public.questions VALUES (5691, 100, 'SARSA mainly aims to learn?');
INSERT INTO public.questions VALUES (5692, 100, 'Which framework supports SARSA?');
INSERT INTO public.questions VALUES (5693, 100, 'SARSA requires?');
INSERT INTO public.questions VALUES (5694, 100, 'Discount factor in SARSA controls?');
INSERT INTO public.questions VALUES (5695, 100, 'Learning rate in SARSA controls?');
INSERT INTO public.questions VALUES (5696, 100, 'SARSA converges when?');
INSERT INTO public.questions VALUES (5697, 100, 'SARSA differs from Q-Learning because?');
INSERT INTO public.questions VALUES (5698, 100, 'SARSA improves learning by?');
INSERT INTO public.questions VALUES (5699, 100, 'SARSA is suitable for?');
INSERT INTO public.questions VALUES (5700, 100, 'SARSA learns safer paths in risky environments because?');
INSERT INTO public.questions VALUES (5701, 100, 'Best summary of SARSA?');
INSERT INTO public.questions VALUES (5702, 101, 'Q-Learning is an example of?');
INSERT INTO public.questions VALUES (5703, 101, 'Q-Learning updates which function?');
INSERT INTO public.questions VALUES (5704, 101, 'Q-Learning update uses?');
INSERT INTO public.questions VALUES (5705, 101, 'Q-Learning aims to learn?');
INSERT INTO public.questions VALUES (5706, 101, 'Q-Learning belongs to which learning type?');
INSERT INTO public.questions VALUES (5707, 101, 'Q-Learning policy improvement is usually done using?');
INSERT INTO public.questions VALUES (5708, 101, 'Q-Learning learning occurs?');
INSERT INTO public.questions VALUES (5709, 101, 'Q-Learning is considered off-policy because?');
INSERT INTO public.questions VALUES (5710, 101, 'Q-Learning update target includes?');
INSERT INTO public.questions VALUES (5711, 101, 'Which framework supports Q-Learning?');
INSERT INTO public.questions VALUES (5712, 101, 'Q-Learning requires?');
INSERT INTO public.questions VALUES (5713, 101, 'Discount factor in Q-Learning controls?');
INSERT INTO public.questions VALUES (5714, 101, 'Learning rate in Q-Learning controls?');
INSERT INTO public.questions VALUES (5715, 101, 'Q-Learning converges when?');
INSERT INTO public.questions VALUES (5716, 101, 'Q-Learning differs from SARSA because?');
INSERT INTO public.questions VALUES (5717, 101, 'Q-Learning improves learning by?');
INSERT INTO public.questions VALUES (5718, 101, 'Q-Learning is suitable for?');
INSERT INTO public.questions VALUES (5719, 101, 'Q-Learning learns optimal paths even with exploration because?');
INSERT INTO public.questions VALUES (5720, 101, 'Q-Learning is widely used in?');
INSERT INTO public.questions VALUES (5721, 101, 'Best summary of Q-Learning?');
INSERT INTO public.questions VALUES (5722, 102, 'Function approximation in RL is mainly used to?');
INSERT INTO public.questions VALUES (5723, 102, 'Instead of storing value for each state, function approximation uses?');
INSERT INTO public.questions VALUES (5724, 102, 'Which model is commonly used for function approximation?');
INSERT INTO public.questions VALUES (5725, 102, 'Function approximation helps reduce?');
INSERT INTO public.questions VALUES (5726, 102, 'Which RL problem benefits most from function approximation?');
INSERT INTO public.questions VALUES (5727, 102, 'Value function approximation estimates?');
INSERT INTO public.questions VALUES (5728, 102, 'Action-value approximation estimates?');
INSERT INTO public.questions VALUES (5729, 102, 'Function approximation introduces which trade-off?');
INSERT INTO public.questions VALUES (5730, 102, 'Which learning method is used to train approximators?');
INSERT INTO public.questions VALUES (5731, 102, 'Feature representation in RL helps?');
INSERT INTO public.questions VALUES (5732, 102, 'Function approximation is required because?');
INSERT INTO public.questions VALUES (5733, 102, 'Which type of approximation uses linear combination of features?');
INSERT INTO public.questions VALUES (5734, 102, 'Non-linear approximation is mainly done using?');
INSERT INTO public.questions VALUES (5735, 102, 'Function approximation improves learning by?');
INSERT INTO public.questions VALUES (5736, 102, 'Which RL framework supports function approximation?');
INSERT INTO public.questions VALUES (5737, 102, 'Function approximation may cause?');
INSERT INTO public.questions VALUES (5738, 102, 'Which parameter defines model complexity?');
INSERT INTO public.questions VALUES (5739, 102, 'Function approximation is widely used in?');
INSERT INTO public.questions VALUES (5740, 102, 'Policy approximation means?');
INSERT INTO public.questions VALUES (5741, 102, 'Best summary of function approximation?');
INSERT INTO public.questions VALUES (5742, 103, 'Gradient Descent in RL is mainly used to?');
INSERT INTO public.questions VALUES (5743, 103, 'Gradient descent updates parameters in which direction?');
INSERT INTO public.questions VALUES (5744, 103, 'Learning rate in gradient descent controls?');
INSERT INTO public.questions VALUES (5745, 103, 'Gradient descent minimizes?');
INSERT INTO public.questions VALUES (5746, 103, 'Which function is commonly minimized in value approximation?');
INSERT INTO public.questions VALUES (5747, 103, 'Gradient descent is useful for?');
INSERT INTO public.questions VALUES (5748, 103, 'Which RL method uses gradient descent extensively?');
INSERT INTO public.questions VALUES (5749, 103, 'Gradient descent updates occur?');
INSERT INTO public.questions VALUES (5750, 103, 'Which parameter determines convergence speed?');
INSERT INTO public.questions VALUES (5751, 103, 'Too high learning rate may cause?');
INSERT INTO public.questions VALUES (5752, 103, 'Too small learning rate may cause?');
INSERT INTO public.questions VALUES (5753, 103, 'Stochastic gradient descent updates parameters using?');
INSERT INTO public.questions VALUES (5754, 103, 'Batch gradient descent uses?');
INSERT INTO public.questions VALUES (5755, 103, 'Gradient descent helps RL agent by?');
INSERT INTO public.questions VALUES (5756, 103, 'Which optimization concept helps avoid local minima?');
INSERT INTO public.questions VALUES (5757, 103, 'Gradient descent mainly requires?');
INSERT INTO public.questions VALUES (5758, 103, 'Parameter update formula uses?');
INSERT INTO public.questions VALUES (5759, 103, 'Gradient descent improves learning by?');
INSERT INTO public.questions VALUES (5760, 103, 'Which model parameter is updated in RL approximators?');
INSERT INTO public.questions VALUES (5761, 103, 'Best summary of Gradient Descent?');
INSERT INTO public.questions VALUES (5762, 104, 'Gradient Monte Carlo method updates parameters using?');
INSERT INTO public.questions VALUES (5763, 104, 'Gradient Monte Carlo belongs to which learning category?');
INSERT INTO public.questions VALUES (5764, 104, 'In Gradient Monte Carlo, learning occurs after?');
INSERT INTO public.questions VALUES (5765, 104, 'Which return is used in Gradient Monte Carlo updates?');
INSERT INTO public.questions VALUES (5766, 104, 'Gradient Monte Carlo reduces which error?');
INSERT INTO public.questions VALUES (5767, 104, 'Which type of problems suit Monte Carlo methods?');
INSERT INTO public.questions VALUES (5768, 104, 'Gradient Monte Carlo requires?');
INSERT INTO public.questions VALUES (5769, 104, 'Which optimization technique is used to update weights?');
INSERT INTO public.questions VALUES (5770, 104, 'Monte Carlo learning does not require?');
INSERT INTO public.questions VALUES (5771, 104, 'Which value estimate is improved using Gradient Monte Carlo?');
INSERT INTO public.questions VALUES (5772, 104, 'Gradient Monte Carlo updates are?');
INSERT INTO public.questions VALUES (5773, 104, 'Monte Carlo return depends on?');
INSERT INTO public.questions VALUES (5774, 104, 'Which RL framework supports Gradient Monte Carlo?');
INSERT INTO public.questions VALUES (5775, 104, 'Gradient Monte Carlo helps learn?');
INSERT INTO public.questions VALUES (5776, 104, 'Which limitation exists in Monte Carlo methods?');
INSERT INTO public.questions VALUES (5777, 104, 'Gradient Monte Carlo can be applied to?');
INSERT INTO public.questions VALUES (5778, 104, 'Which update target is used?');
INSERT INTO public.questions VALUES (5779, 104, 'Gradient Monte Carlo improves policy by?');
INSERT INTO public.questions VALUES (5780, 104, 'Monte Carlo methods rely on?');
INSERT INTO public.questions VALUES (5781, 104, 'Best summary of Gradient Monte Carlo?');
INSERT INTO public.questions VALUES (5782, 105, 'Semi-Gradient TD methods are mainly used for?');
INSERT INTO public.questions VALUES (5783, 105, 'Semi-Gradient TD updates parameters using?');
INSERT INTO public.questions VALUES (5784, 105, 'TD error represents?');
INSERT INTO public.questions VALUES (5785, 105, 'Semi-Gradient TD is called ‘semi’ because?');
INSERT INTO public.questions VALUES (5786, 105, 'Which update rule is used in Semi-Gradient TD?');
INSERT INTO public.questions VALUES (5787, 105, 'Semi-Gradient TD combines ideas of?');
INSERT INTO public.questions VALUES (5788, 105, 'Semi-Gradient TD can learn?');
INSERT INTO public.questions VALUES (5789, 105, 'Which RL task benefits from Semi-Gradient TD?');
INSERT INTO public.questions VALUES (5790, 105, 'Semi-Gradient TD reduces which limitation?');
INSERT INTO public.questions VALUES (5791, 105, 'Which value estimate is updated?');
INSERT INTO public.questions VALUES (5792, 105, 'Semi-Gradient TD learning is generally?');
INSERT INTO public.questions VALUES (5793, 105, 'TD target in Semi-Gradient TD includes?');
INSERT INTO public.questions VALUES (5794, 105, 'Which parameter controls update size?');
INSERT INTO public.questions VALUES (5795, 105, 'Semi-Gradient TD improves learning by?');
INSERT INTO public.questions VALUES (5796, 105, 'Bootstrapping means?');
INSERT INTO public.questions VALUES (5797, 105, 'Semi-Gradient TD is commonly used in?');
INSERT INTO public.questions VALUES (5798, 105, 'Which RL method uses semi-gradient idea?');
INSERT INTO public.questions VALUES (5799, 105, 'Semi-Gradient TD helps achieve?');
INSERT INTO public.questions VALUES (5800, 105, 'Which framework supports Semi-Gradient TD?');
INSERT INTO public.questions VALUES (5801, 105, 'Best summary of Semi-Gradient TD?');
INSERT INTO public.questions VALUES (5802, 106, 'Eligibility traces in RL help to?');
INSERT INTO public.questions VALUES (5803, 106, 'Eligibility trace represents?');
INSERT INTO public.questions VALUES (5804, 106, 'Eligibility traces are mainly used with?');
INSERT INTO public.questions VALUES (5805, 106, 'Which parameter controls decay of eligibility traces?');
INSERT INTO public.questions VALUES (5806, 106, 'Eligibility traces combine ideas of?');
INSERT INTO public.questions VALUES (5807, 106, 'Eligibility traces help improve?');
INSERT INTO public.questions VALUES (5808, 106, 'When λ = 0, eligibility traces behave like?');
INSERT INTO public.questions VALUES (5809, 106, 'When λ = 1, eligibility traces behave like?');
INSERT INTO public.questions VALUES (5810, 106, 'Eligibility traces are updated?');
INSERT INTO public.questions VALUES (5811, 106, 'Eligibility traces help solve?');
INSERT INTO public.questions VALUES (5812, 106, 'Replacing traces and accumulating traces are?');
INSERT INTO public.questions VALUES (5813, 106, 'Eligibility traces decay over time using?');
INSERT INTO public.questions VALUES (5814, 106, 'Eligibility traces improve convergence by?');
INSERT INTO public.questions VALUES (5815, 106, 'Eligibility trace value indicates?');
INSERT INTO public.questions VALUES (5816, 106, 'Eligibility traces are commonly used in?');
INSERT INTO public.questions VALUES (5817, 106, 'Eligibility traces support learning in?');
INSERT INTO public.questions VALUES (5818, 106, 'Eligibility traces help propagate?');
INSERT INTO public.questions VALUES (5819, 106, 'Which learning concept uses eligibility traces?');
INSERT INTO public.questions VALUES (5820, 106, 'Eligibility traces require?');
INSERT INTO public.questions VALUES (5821, 106, 'Best summary of eligibility traces?');
INSERT INTO public.questions VALUES (5822, 107, 'Deep Reinforcement Learning combines Reinforcement Learning with?');
INSERT INTO public.questions VALUES (5823, 107, 'Deep RL is mainly used to handle?');
INSERT INTO public.questions VALUES (5824, 107, 'Which model is commonly used in Deep RL for function approximation?');
INSERT INTO public.questions VALUES (5825, 107, 'Deep RL agents learn policies by?');
INSERT INTO public.questions VALUES (5826, 107, 'Which famous algorithm introduced Deep RL success in Atari games?');
INSERT INTO public.questions VALUES (5827, 107, 'Deep RL helps overcome limitation of?');
INSERT INTO public.questions VALUES (5828, 107, 'Which concept allows Deep RL to generalize learning?');
INSERT INTO public.questions VALUES (5829, 107, 'Deep RL is useful in which real-world domain?');
INSERT INTO public.questions VALUES (5830, 107, 'Which network type is widely used in Deep RL vision tasks?');
INSERT INTO public.questions VALUES (5831, 107, 'Deep RL training requires?');
INSERT INTO public.questions VALUES (5832, 107, 'Which learning signal is used to update deep networks in RL?');
INSERT INTO public.questions VALUES (5833, 107, 'Experience Replay in Deep RL is used to?');
INSERT INTO public.questions VALUES (5834, 107, 'Target Networks in Deep RL help?');
INSERT INTO public.questions VALUES (5835, 107, 'Which challenge exists in Deep RL?');
INSERT INTO public.questions VALUES (5836, 107, 'Deep RL agents aim to learn?');
INSERT INTO public.questions VALUES (5837, 107, 'Deep RL uses gradient descent to?');
INSERT INTO public.questions VALUES (5838, 107, 'Deep RL is suitable for?');
INSERT INTO public.questions VALUES (5839, 107, 'Which exploration strategy is common in Deep RL?');
INSERT INTO public.questions VALUES (5840, 107, 'Deep RL improves performance by?');
INSERT INTO public.questions VALUES (5841, 107, 'Best summary of Deep Reinforcement Learning?');
INSERT INTO public.questions VALUES (5842, 108, 'Multi-Armed Bandit problem mainly deals with?');
INSERT INTO public.questions VALUES (5843, 108, 'In bandit problems, each arm represents?');
INSERT INTO public.questions VALUES (5844, 108, 'Which strategy selects a random action with probability ε?');
INSERT INTO public.questions VALUES (5845, 108, 'Exploitation in bandits means?');
INSERT INTO public.questions VALUES (5846, 108, 'Exploration in bandits refers to?');
INSERT INTO public.questions VALUES (5847, 108, 'Which algorithm uses confidence bounds to select actions?');
INSERT INTO public.questions VALUES (5848, 108, 'Bandit problems assume?');
INSERT INTO public.questions VALUES (5849, 108, 'Reward in bandits depends only on?');
INSERT INTO public.questions VALUES (5850, 108, 'Which objective is used in bandit learning?');
INSERT INTO public.questions VALUES (5851, 108, 'Regret in bandit problem measures?');
INSERT INTO public.questions VALUES (5852, 108, 'Which bandit variant handles changing reward distributions?');
INSERT INTO public.questions VALUES (5853, 108, 'Optimistic initialization encourages?');
INSERT INTO public.questions VALUES (5854, 108, 'Which method selects action based on probability matching?');
INSERT INTO public.questions VALUES (5855, 108, 'Bandit problems are simplified form of?');
INSERT INTO public.questions VALUES (5856, 108, 'Which estimate is updated after each reward?');
INSERT INTO public.questions VALUES (5857, 108, 'Bandit learning is typically?');
INSERT INTO public.questions VALUES (5858, 108, 'Which exploration method uses softmax probabilities?');
INSERT INTO public.questions VALUES (5859, 108, 'Bandit setting does not consider?');
INSERT INTO public.questions VALUES (5860, 108, 'Which performance metric evaluates learning quality?');
INSERT INTO public.questions VALUES (5861, 108, 'Best summary of Multi-Armed Bandits?');
INSERT INTO public.questions VALUES (5862, 109, 'Policy Gradient methods directly optimize?');
INSERT INTO public.questions VALUES (5863, 109, 'In policy gradient, policy is usually represented as?');
INSERT INTO public.questions VALUES (5864, 109, 'Policy gradient updates aim to?');
INSERT INTO public.questions VALUES (5865, 109, 'Which algorithm is a basic policy gradient method?');
INSERT INTO public.questions VALUES (5866, 109, 'Policy gradient methods are suitable for?');
INSERT INTO public.questions VALUES (5867, 109, 'Policy gradient relies on which theorem?');
INSERT INTO public.questions VALUES (5868, 109, 'Which signal guides parameter updates in policy gradient?');
INSERT INTO public.questions VALUES (5869, 109, 'Policy gradient methods often use?');
INSERT INTO public.questions VALUES (5870, 109, 'Which optimization method is commonly used?');
INSERT INTO public.questions VALUES (5871, 109, 'Baseline subtraction helps reduce?');
INSERT INTO public.questions VALUES (5872, 109, 'Which value is maximized in policy gradient?');
INSERT INTO public.questions VALUES (5873, 109, 'Policy gradient methods update policy?');
INSERT INTO public.questions VALUES (5874, 109, 'Policy gradient methods avoid need for?');
INSERT INTO public.questions VALUES (5875, 109, 'Which challenge exists in policy gradient?');
INSERT INTO public.questions VALUES (5876, 109, 'Policy gradient improves learning by?');
INSERT INTO public.questions VALUES (5877, 109, 'Which RL framework supports policy gradient?');
INSERT INTO public.questions VALUES (5878, 109, 'Policy gradient can be combined with?');
INSERT INTO public.questions VALUES (5879, 109, 'Policy gradient methods are usually?');
INSERT INTO public.questions VALUES (5880, 109, 'Which parameter type is updated?');
INSERT INTO public.questions VALUES (5881, 109, 'Best summary of policy gradient methods?');
INSERT INTO public.questions VALUES (5882, 110, 'Actor-Critic methods combine which two main components?');
INSERT INTO public.questions VALUES (5883, 110, 'In Actor-Critic architecture, the actor is responsible for?');
INSERT INTO public.questions VALUES (5884, 110, 'The critic evaluates?');
INSERT INTO public.questions VALUES (5885, 110, 'Which signal is used by the critic to guide the actor?');
INSERT INTO public.questions VALUES (5886, 110, 'Actor-Critic methods help reduce?');
INSERT INTO public.questions VALUES (5887, 110, 'Which type of learning is typically used in Actor-Critic?');
INSERT INTO public.questions VALUES (5888, 110, 'The actor updates its policy using?');
INSERT INTO public.questions VALUES (5889, 110, 'Which value estimate is used by the critic?');
INSERT INTO public.questions VALUES (5890, 110, 'Actor-Critic methods are suitable for?');
INSERT INTO public.questions VALUES (5891, 110, 'Which algorithm is an example of Actor-Critic?');
INSERT INTO public.questions VALUES (5892, 110, 'Critic helps improve learning by?');
INSERT INTO public.questions VALUES (5893, 110, 'Actor-Critic uses which RL concept heavily?');
INSERT INTO public.questions VALUES (5894, 110, 'Which framework supports Actor-Critic learning?');
INSERT INTO public.questions VALUES (5895, 110, 'Actor-Critic updates happen?');
INSERT INTO public.questions VALUES (5896, 110, 'Which optimization method is used to update actor parameters?');
INSERT INTO public.questions VALUES (5897, 110, 'Actor-Critic improves performance by?');
INSERT INTO public.questions VALUES (5898, 110, 'Which challenge may occur in Actor-Critic training?');
INSERT INTO public.questions VALUES (5899, 110, 'Actor-Critic architecture usually uses?');
INSERT INTO public.questions VALUES (5900, 110, 'Actor selects actions according to?');
INSERT INTO public.questions VALUES (5901, 110, 'Best summary of Actor-Critic methods?');
INSERT INTO public.questions VALUES (5902, 111, 'Deep Q Network (DQN) is used to approximate?');
INSERT INTO public.questions VALUES (5903, 111, 'DQN combines Q-Learning with?');
INSERT INTO public.questions VALUES (5904, 111, 'Which problem does DQN solve compared to tabular Q-learning?');
INSERT INTO public.questions VALUES (5905, 111, 'Experience Replay in DQN is used to?');
INSERT INTO public.questions VALUES (5906, 111, 'Target Network in DQN helps?');
INSERT INTO public.questions VALUES (5907, 111, 'Which loss function is commonly used in DQN?');
INSERT INTO public.questions VALUES (5908, 111, 'DQN updates network weights using?');
INSERT INTO public.questions VALUES (5909, 111, 'Which exploration strategy is commonly used in DQN?');
INSERT INTO public.questions VALUES (5910, 111, 'The Q-target in DQN includes?');
INSERT INTO public.questions VALUES (5911, 111, 'Which environment type made DQN famous?');
INSERT INTO public.questions VALUES (5912, 111, 'Replay buffer stores?');
INSERT INTO public.questions VALUES (5913, 111, 'DQN mainly learns?');
INSERT INTO public.questions VALUES (5914, 111, 'Which RL concept is heavily used in DQN?');
INSERT INTO public.questions VALUES (5915, 111, 'DQN training requires?');
INSERT INTO public.questions VALUES (5916, 111, 'Which network type is commonly used in DQN for image input?');
INSERT INTO public.questions VALUES (5917, 111, 'Which issue can occur in naive Q-learning with function approximation?');
INSERT INTO public.questions VALUES (5918, 111, 'Target network parameters are updated?');
INSERT INTO public.questions VALUES (5919, 111, 'DQN is mainly suitable for?');
INSERT INTO public.questions VALUES (5920, 111, 'Reward clipping in DQN helps?');
INSERT INTO public.questions VALUES (5921, 111, 'Best summary of DQN?');
INSERT INTO public.questions VALUES (5922, 112, 'Double DQN was introduced to solve which main issue in standard DQN?');
INSERT INTO public.questions VALUES (5923, 112, 'Double DQN uses how many neural networks?');
INSERT INTO public.questions VALUES (5924, 112, 'In Double DQN, one network is mainly used for?');
INSERT INTO public.questions VALUES (5925, 112, 'The second network in Double DQN is used for?');
INSERT INTO public.questions VALUES (5926, 112, 'Which concept reduces overoptimistic value estimation?');
INSERT INTO public.questions VALUES (5927, 112, 'Double DQN improves?');
INSERT INTO public.questions VALUES (5928, 112, 'Target Q-value in Double DQN uses?');
INSERT INTO public.questions VALUES (5929, 112, 'Which RL learning style does Double DQN follow?');
INSERT INTO public.questions VALUES (5930, 112, 'Double DQN still uses which mechanism from DQN?');
INSERT INTO public.questions VALUES (5931, 112, 'Which update method is used to train network weights?');
INSERT INTO public.questions VALUES (5932, 112, 'Double DQN helps reduce?');
INSERT INTO public.questions VALUES (5933, 112, 'Which action is chosen during policy execution?');
INSERT INTO public.questions VALUES (5934, 112, 'Double DQN improves performance in?');
INSERT INTO public.questions VALUES (5935, 112, 'Which network parameters are updated more frequently?');
INSERT INTO public.questions VALUES (5936, 112, 'Target network parameters are updated?');
INSERT INTO public.questions VALUES (5937, 112, 'Double DQN still uses which exploration strategy?');
INSERT INTO public.questions VALUES (5938, 112, 'Double DQN belongs to which broader category?');
INSERT INTO public.questions VALUES (5939, 112, 'Which RL concept is still used for value updates?');
INSERT INTO public.questions VALUES (5940, 112, 'Double DQN provides better?');
INSERT INTO public.questions VALUES (5941, 112, 'Best summary of Double DQN?');
INSERT INTO public.questions VALUES (5942, 113, 'Reinforcement Learning is widely used in?');
INSERT INTO public.questions VALUES (5943, 113, 'Which RL application involves learning to play games?');
INSERT INTO public.questions VALUES (5944, 113, 'RL is useful in recommendation systems to?');
INSERT INTO public.questions VALUES (5945, 113, 'Which domain uses RL for traffic signal control?');
INSERT INTO public.questions VALUES (5946, 113, 'RL is used in finance for?');
INSERT INTO public.questions VALUES (5947, 113, 'Which healthcare application uses RL?');
INSERT INTO public.questions VALUES (5948, 113, 'RL helps robots by?');
INSERT INTO public.questions VALUES (5949, 113, 'Which RL application is used in energy systems?');
INSERT INTO public.questions VALUES (5950, 113, 'RL in natural language processing helps in?');
INSERT INTO public.questions VALUES (5951, 113, 'Which RL application is used in advertising?');
INSERT INTO public.questions VALUES (5952, 113, 'Autonomous driving systems use RL for?');
INSERT INTO public.questions VALUES (5953, 113, 'Which industry uses RL for supply chain optimization?');
INSERT INTO public.questions VALUES (5954, 113, 'RL in cloud computing helps?');
INSERT INTO public.questions VALUES (5955, 113, 'Which RL application is used in marketing?');
INSERT INTO public.questions VALUES (5956, 113, 'RL can be used in education systems for?');
INSERT INTO public.questions VALUES (5957, 113, 'Which RL application involves drone navigation?');
INSERT INTO public.questions VALUES (5958, 113, 'Industrial automation uses RL for?');
INSERT INTO public.questions VALUES (5959, 113, 'RL helps video streaming platforms by?');
INSERT INTO public.questions VALUES (5960, 113, 'Which sports application uses RL?');
INSERT INTO public.questions VALUES (5961, 113, 'Best summary of RL applications?');
INSERT INTO public.questions VALUES (5962, 114, 'Multi-Agent Reinforcement Learning involves?');
INSERT INTO public.questions VALUES (5963, 114, 'Agents in multi-agent systems may?');
INSERT INTO public.questions VALUES (5964, 114, 'Which environment type is common in multi-agent RL?');
INSERT INTO public.questions VALUES (5965, 114, 'A cooperative multi-agent system aims to?');
INSERT INTO public.questions VALUES (5966, 114, 'A competitive multi-agent system is also called?');
INSERT INTO public.questions VALUES (5967, 114, 'Which concept models strategic interaction among agents?');
INSERT INTO public.questions VALUES (5968, 114, 'Multi-agent RL increases which challenge?');
INSERT INTO public.questions VALUES (5969, 114, 'Non-stationarity occurs because?');
INSERT INTO public.questions VALUES (5970, 114, 'Which learning paradigm allows agents to share information?');
INSERT INTO public.questions VALUES (5971, 114, 'Decentralized execution means?');
INSERT INTO public.questions VALUES (5972, 114, 'Which application uses multi-agent RL?');
INSERT INTO public.questions VALUES (5973, 114, 'Communication between agents helps?');
INSERT INTO public.questions VALUES (5974, 114, 'Which equilibrium concept is studied in competitive settings?');
INSERT INTO public.questions VALUES (5975, 114, 'Which reward type is common in cooperative tasks?');
INSERT INTO public.questions VALUES (5976, 114, 'Credit assignment problem becomes harder because?');
INSERT INTO public.questions VALUES (5977, 114, 'Which training approach uses global state information?');
INSERT INTO public.questions VALUES (5978, 114, 'Multi-agent RL is useful in?');
INSERT INTO public.questions VALUES (5979, 114, 'Agents must learn to?');
INSERT INTO public.questions VALUES (5980, 114, 'Which complexity increases with more agents?');
INSERT INTO public.questions VALUES (5981, 114, 'Best summary of Multi-Agent RL?');


--
-- Data for Name: questions_backup; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.questions_backup VALUES (1, 3, 'What is an array?', 0);
INSERT INTO public.questions_backup VALUES (2, 3, 'Array elements are stored in?', 1);
INSERT INTO public.questions_backup VALUES (3, 3, 'Index of first element?', 0);
INSERT INTO public.questions_backup VALUES (4, 3, 'Access time of array element?', 2);
INSERT INTO public.questions_backup VALUES (5, 3, 'Main drawback of array?', 1);
INSERT INTO public.questions_backup VALUES (6, 3, 'Which operation is costly?', 1);
INSERT INTO public.questions_backup VALUES (7, 3, 'Array size is?', 1);
INSERT INTO public.questions_backup VALUES (8, 3, 'Which search works on array?', 2);
INSERT INTO public.questions_backup VALUES (9, 3, 'Binary search needs?', 0);
INSERT INTO public.questions_backup VALUES (10, 3, 'Which array stores rows & columns?', 1);
INSERT INTO public.questions_backup VALUES (11, 3, 'Time complexity of array traversal?', 2);
INSERT INTO public.questions_backup VALUES (12, 3, 'Which is dynamic alternative?', 1);
INSERT INTO public.questions_backup VALUES (13, 3, 'Memory allocation happens?', 0);
INSERT INTO public.questions_backup VALUES (14, 3, 'Array index starts from?', 0);
INSERT INTO public.questions_backup VALUES (15, 3, 'Which is faster?', 0);
INSERT INTO public.questions_backup VALUES (16, 3, 'Insertion at end complexity?', 0);
INSERT INTO public.questions_backup VALUES (17, 3, 'Deletion from array cost?', 2);
INSERT INTO public.questions_backup VALUES (18, 3, 'Which array allows varying row size?', 1);
INSERT INTO public.questions_backup VALUES (19, 3, 'Array stores data in?', 2);
INSERT INTO public.questions_backup VALUES (20, 3, 'Best use of array?', 1);
INSERT INTO public.questions_backup VALUES (21, 1, 'What does DSA stand for?', 2);
INSERT INTO public.questions_backup VALUES (22, 1, 'What is a data structure?', 1);
INSERT INTO public.questions_backup VALUES (23, 1, 'What is an algorithm?', 1);
INSERT INTO public.questions_backup VALUES (24, 1, 'Which is a linear data structure?', 2);
INSERT INTO public.questions_backup VALUES (25, 1, 'Which is a non-linear data structure?', 3);
INSERT INTO public.questions_backup VALUES (26, 1, 'Why are data structures important?', 1);
INSERT INTO public.questions_backup VALUES (27, 1, 'Which data structure follows LIFO?', 1);
INSERT INTO public.questions_backup VALUES (28, 1, 'Which data structure follows FIFO?', 1);
INSERT INTO public.questions_backup VALUES (29, 1, 'Which is not a data structure?', 2);
INSERT INTO public.questions_backup VALUES (30, 1, 'Which is a real-life example of stack?', 1);
INSERT INTO public.questions_backup VALUES (31, 1, 'Which is a real-life example of queue?', 2);
INSERT INTO public.questions_backup VALUES (32, 1, 'Which data structure uses key-value pairs?', 2);
INSERT INTO public.questions_backup VALUES (33, 1, 'Which data structure is dynamic?', 1);
INSERT INTO public.questions_backup VALUES (34, 1, 'Which data structure is best for recursion?', 1);
INSERT INTO public.questions_backup VALUES (35, 1, 'Which is faster for indexed access?', 0);
INSERT INTO public.questions_backup VALUES (36, 1, 'Which is language independent?', 3);
INSERT INTO public.questions_backup VALUES (37, 1, 'What is the main goal of DSA?', 1);
INSERT INTO public.questions_backup VALUES (38, 1, 'Which data structure is hierarchical?', 2);
INSERT INTO public.questions_backup VALUES (39, 1, 'Which data structure represents relationships?', 0);
INSERT INTO public.questions_backup VALUES (40, 1, 'DSA is mainly used in?', 2);
INSERT INTO public.questions_backup VALUES (41, 7, 'Prime number is?', 0);
INSERT INTO public.questions_backup VALUES (42, 7, '2 is?', 0);
INSERT INTO public.questions_backup VALUES (43, 7, 'LCM stands for?', 0);
INSERT INTO public.questions_backup VALUES (44, 7, 'GCD means?', 0);
INSERT INTO public.questions_backup VALUES (45, 7, 'Modulo operator gives?', 1);
INSERT INTO public.questions_backup VALUES (46, 7, 'Even number divisible by?', 1);
INSERT INTO public.questions_backup VALUES (47, 7, 'Odd numbers end with?', 3);
INSERT INTO public.questions_backup VALUES (48, 7, 'Factorial of 0?', 1);
INSERT INTO public.questions_backup VALUES (49, 7, '10 % 3 = ?', 0);
INSERT INTO public.questions_backup VALUES (50, 7, 'Power operator is?', 2);
INSERT INTO public.questions_backup VALUES (51, 7, 'Math helps in?', 3);
INSERT INTO public.questions_backup VALUES (52, 7, 'Fibonacci starts with?', 0);
INSERT INTO public.questions_backup VALUES (53, 7, 'Prime numbers are?', 0);
INSERT INTO public.questions_backup VALUES (54, 7, 'Square of 5?', 2);
INSERT INTO public.questions_backup VALUES (55, 7, 'Cube of 3?', 1);
INSERT INTO public.questions_backup VALUES (56, 7, 'Binary number system base?', 0);
INSERT INTO public.questions_backup VALUES (57, 7, 'Decimal system base?', 2);
INSERT INTO public.questions_backup VALUES (58, 7, 'Math used in DSA?', 0);
INSERT INTO public.questions_backup VALUES (59, 7, 'GCD of 10 & 5?', 1);
INSERT INTO public.questions_backup VALUES (60, 7, 'LCM of 4 & 6?', 0);
INSERT INTO public.questions_backup VALUES (61, 10, 'Reverse array uses?', 1);
INSERT INTO public.questions_backup VALUES (62, 10, 'Palindrome check uses?', 1);
INSERT INTO public.questions_backup VALUES (63, 10, 'Max element search?', 1);
INSERT INTO public.questions_backup VALUES (64, 10, 'Binary search requires?', 0);
INSERT INTO public.questions_backup VALUES (65, 10, 'Duplicate detection uses?', 1);
INSERT INTO public.questions_backup VALUES (66, 10, 'Array rotation uses?', 2);
INSERT INTO public.questions_backup VALUES (67, 10, 'Anagram check uses?', 2);
INSERT INTO public.questions_backup VALUES (68, 10, 'Two sum problem uses?', 2);
INSERT INTO public.questions_backup VALUES (69, 10, 'Recursion base case?', 2);
INSERT INTO public.questions_backup VALUES (70, 10, 'Fibonacci recursion complexity?', 2);
INSERT INTO public.questions_backup VALUES (71, 10, 'Sliding window used for?', 0);
INSERT INTO public.questions_backup VALUES (72, 10, 'Prefix sum optimizes?', 0);
INSERT INTO public.questions_backup VALUES (73, 10, 'Stack used in?', 0);
INSERT INTO public.questions_backup VALUES (74, 10, 'Queue used in?', 0);
INSERT INTO public.questions_backup VALUES (75, 10, 'Time complexity analysis?', 1);
INSERT INTO public.questions_backup VALUES (76, 10, 'Space complexity counts?', 0);
INSERT INTO public.questions_backup VALUES (77, 10, 'Best practice for DSA?', 0);
INSERT INTO public.questions_backup VALUES (78, 10, 'Problem solving improves?', 3);
INSERT INTO public.questions_backup VALUES (79, 10, 'Edge case means?', 0);
INSERT INTO public.questions_backup VALUES (80, 10, 'Practice makes?', 0);
INSERT INTO public.questions_backup VALUES (81, 9, 'Queue follows?', 1);
INSERT INTO public.questions_backup VALUES (82, 9, 'Enqueue means?', 0);
INSERT INTO public.questions_backup VALUES (83, 9, 'Dequeue removes?', 0);
INSERT INTO public.questions_backup VALUES (84, 9, 'Queue real example?', 2);
INSERT INTO public.questions_backup VALUES (85, 9, 'Queue used in?', 0);
INSERT INTO public.questions_backup VALUES (86, 9, 'Overflow in queue?', 0);
INSERT INTO public.questions_backup VALUES (87, 9, 'Underflow in queue?', 0);
INSERT INTO public.questions_backup VALUES (88, 9, 'Queue is?', 0);
INSERT INTO public.questions_backup VALUES (89, 9, 'Circular queue advantage?', 0);
INSERT INTO public.questions_backup VALUES (90, 9, 'Queue implemented using?', 2);
INSERT INTO public.questions_backup VALUES (91, 9, 'Front pointer?', 0);
INSERT INTO public.questions_backup VALUES (92, 9, 'Rear pointer?', 0);
INSERT INTO public.questions_backup VALUES (93, 9, 'Priority queue removes?', 1);
INSERT INTO public.questions_backup VALUES (94, 9, 'Queue traversal?', 0);
INSERT INTO public.questions_backup VALUES (95, 9, 'Queue used in BFS?', 0);
INSERT INTO public.questions_backup VALUES (96, 9, 'Queue insertion end?', 0);
INSERT INTO public.questions_backup VALUES (97, 9, 'Queue deletion from?', 0);
INSERT INTO public.questions_backup VALUES (98, 9, 'Double ended queue?', 0);
INSERT INTO public.questions_backup VALUES (99, 9, 'Queue is faster than stack?', 3);
INSERT INTO public.questions_backup VALUES (100, 9, 'Queue maintains?', 0);
INSERT INTO public.questions_backup VALUES (101, 5, 'What is searching?', 1);
INSERT INTO public.questions_backup VALUES (102, 5, 'Which is the simplest searching algorithm?', 1);
INSERT INTO public.questions_backup VALUES (103, 5, 'Time complexity of linear search (worst case)?', 2);
INSERT INTO public.questions_backup VALUES (104, 5, 'Binary search works on?', 1);
INSERT INTO public.questions_backup VALUES (105, 5, 'Time complexity of binary search?', 1);
INSERT INTO public.questions_backup VALUES (106, 5, 'Which search divides array into halves?', 1);
INSERT INTO public.questions_backup VALUES (107, 5, 'Linear search is also called?', 0);
INSERT INTO public.questions_backup VALUES (108, 5, 'Best case of linear search?', 2);
INSERT INTO public.questions_backup VALUES (109, 5, 'Binary search uses which approach?', 1);
INSERT INTO public.questions_backup VALUES (110, 5, 'Binary search worst case?', 1);
INSERT INTO public.questions_backup VALUES (111, 5, 'Searching means?', 1);
INSERT INTO public.questions_backup VALUES (112, 5, 'Which is faster generally?', 1);
INSERT INTO public.questions_backup VALUES (113, 5, 'Binary search fails if?', 1);
INSERT INTO public.questions_backup VALUES (114, 5, 'Linear search works on?', 2);
INSERT INTO public.questions_backup VALUES (115, 5, 'Binary search recursive depth?', 1);
INSERT INTO public.questions_backup VALUES (116, 5, 'Searching is used for?', 0);
INSERT INTO public.questions_backup VALUES (117, 5, 'Which is not searching algorithm?', 2);
INSERT INTO public.questions_backup VALUES (118, 5, 'Binary search space complexity?', 1);
INSERT INTO public.questions_backup VALUES (119, 5, 'Linear search space complexity?', 0);
INSERT INTO public.questions_backup VALUES (120, 5, 'Searching improves?', 3);
INSERT INTO public.questions_backup VALUES (121, 6, 'What is sorting?', 1);
INSERT INTO public.questions_backup VALUES (122, 6, 'Which sorting is simplest?', 2);
INSERT INTO public.questions_backup VALUES (123, 6, 'Bubble sort complexity?', 1);
INSERT INTO public.questions_backup VALUES (124, 6, 'Which is fastest generally?', 2);
INSERT INTO public.questions_backup VALUES (125, 6, 'Merge sort uses?', 1);
INSERT INTO public.questions_backup VALUES (126, 6, 'Merge sort time complexity?', 1);
INSERT INTO public.questions_backup VALUES (127, 6, 'Which is stable sort?', 2);
INSERT INTO public.questions_backup VALUES (128, 6, 'Selection sort complexity?', 1);
INSERT INTO public.questions_backup VALUES (129, 6, 'Insertion sort best case?', 0);
INSERT INTO public.questions_backup VALUES (130, 6, 'Quick sort worst case?', 2);
INSERT INTO public.questions_backup VALUES (131, 6, 'Sorting improves?', 0);
INSERT INTO public.questions_backup VALUES (132, 6, 'Which sort uses pivot?', 1);
INSERT INTO public.questions_backup VALUES (133, 6, 'Heap sort uses?', 2);
INSERT INTO public.questions_backup VALUES (134, 6, 'Bubble sort compares?', 0);
INSERT INTO public.questions_backup VALUES (135, 6, 'Insertion sort is good for?', 0);
INSERT INTO public.questions_backup VALUES (136, 6, 'Sorting order can be?', 2);
INSERT INTO public.questions_backup VALUES (137, 6, 'Which is in-place sort?', 1);
INSERT INTO public.questions_backup VALUES (138, 6, 'Which uses recursion?', 2);
INSERT INTO public.questions_backup VALUES (139, 6, 'Stable sort means?', 0);
INSERT INTO public.questions_backup VALUES (140, 6, 'Sorting is required for?', 0);
INSERT INTO public.questions_backup VALUES (141, 8, 'Stack follows?', 1);
INSERT INTO public.questions_backup VALUES (142, 8, 'Push operation?', 1);
INSERT INTO public.questions_backup VALUES (143, 8, 'Pop removes?', 2);
INSERT INTO public.questions_backup VALUES (144, 8, 'Stack real example?', 1);
INSERT INTO public.questions_backup VALUES (145, 8, 'Top pointer refers to?', 2);
INSERT INTO public.questions_backup VALUES (146, 8, 'Stack overflow means?', 1);
INSERT INTO public.questions_backup VALUES (147, 8, 'Stack underflow?', 0);
INSERT INTO public.questions_backup VALUES (148, 8, 'Which uses stack?', 0);
INSERT INTO public.questions_backup VALUES (149, 8, 'Infix to postfix uses?', 1);
INSERT INTO public.questions_backup VALUES (150, 8, 'Peek operation?', 2);
INSERT INTO public.questions_backup VALUES (151, 8, 'Stack is?', 0);
INSERT INTO public.questions_backup VALUES (152, 8, 'Call stack used in?', 0);
INSERT INTO public.questions_backup VALUES (153, 8, 'Stack memory?', 1);
INSERT INTO public.questions_backup VALUES (154, 8, 'Stack size is?', 0);
INSERT INTO public.questions_backup VALUES (155, 8, 'Expression evaluation uses?', 0);
INSERT INTO public.questions_backup VALUES (156, 8, 'Stack can be implemented by?', 2);
INSERT INTO public.questions_backup VALUES (157, 8, 'Recursive calls stored in?', 1);
INSERT INTO public.questions_backup VALUES (158, 8, 'Undo feature uses?', 1);
INSERT INTO public.questions_backup VALUES (159, 8, 'Stack traversal?', 1);
INSERT INTO public.questions_backup VALUES (160, 8, 'Stack access?', 2);
INSERT INTO public.questions_backup VALUES (161, 4, 'What is a string?', 0);
INSERT INTO public.questions_backup VALUES (162, 4, 'Strings are stored as?', 0);
INSERT INTO public.questions_backup VALUES (163, 4, 'String indexing starts from?', 0);
INSERT INTO public.questions_backup VALUES (164, 4, 'Which operation is common?', 3);
INSERT INTO public.questions_backup VALUES (165, 4, 'Time complexity of string length?', 0);
INSERT INTO public.questions_backup VALUES (166, 4, 'Strings are immutable in?', 2);
INSERT INTO public.questions_backup VALUES (167, 4, 'Which stores characters?', 0);
INSERT INTO public.questions_backup VALUES (168, 4, 'Substring is?', 0);
INSERT INTO public.questions_backup VALUES (169, 4, 'Which function compares strings?', 1);
INSERT INTO public.questions_backup VALUES (170, 4, 'String traversal complexity?', 2);
INSERT INTO public.questions_backup VALUES (171, 4, 'Which is mutable?', 1);
INSERT INTO public.questions_backup VALUES (172, 4, 'Palindrome check complexity?', 1);
INSERT INTO public.questions_backup VALUES (173, 4, 'String reverse complexity?', 0);
INSERT INTO public.questions_backup VALUES (174, 4, 'Which uses regex?', 0);
INSERT INTO public.questions_backup VALUES (175, 4, 'ASCII stands for?', 1);
INSERT INTO public.questions_backup VALUES (176, 4, 'Unicode supports?', 2);
INSERT INTO public.questions_backup VALUES (177, 4, 'String comparison uses?', 3);
INSERT INTO public.questions_backup VALUES (178, 4, 'Which is not string operation?', 2);
INSERT INTO public.questions_backup VALUES (179, 4, 'String search example?', 0);
INSERT INTO public.questions_backup VALUES (180, 4, 'Best use of string?', 1);
INSERT INTO public.questions_backup VALUES (181, 2, 'What does time complexity measure?', 1);
INSERT INTO public.questions_backup VALUES (182, 2, 'What does space complexity measure?', 2);
INSERT INTO public.questions_backup VALUES (183, 2, 'Worst case complexity is represented by?', 0);
INSERT INTO public.questions_backup VALUES (184, 2, 'Best case complexity is represented by?', 1);
INSERT INTO public.questions_backup VALUES (185, 2, 'Average case complexity is represented by?', 2);
INSERT INTO public.questions_backup VALUES (186, 2, 'Time complexity of binary search?', 1);
INSERT INTO public.questions_backup VALUES (187, 2, 'Time complexity of linear search?', 2);
INSERT INTO public.questions_backup VALUES (188, 2, 'Fastest time complexity?', 2);
INSERT INTO public.questions_backup VALUES (189, 2, 'Slowest growth?', 0);
INSERT INTO public.questions_backup VALUES (190, 2, 'Time complexity of nested loop (n x n)?', 2);
INSERT INTO public.questions_backup VALUES (191, 2, 'Space complexity of recursion?', 1);
INSERT INTO public.questions_backup VALUES (192, 2, 'Which ignores constants?', 2);
INSERT INTO public.questions_backup VALUES (193, 2, 'Time complexity of array access?', 2);
INSERT INTO public.questions_backup VALUES (194, 2, 'Which grows fastest?', 2);
INSERT INTO public.questions_backup VALUES (195, 2, 'Space complexity of algorithm with no extra memory?', 0);
INSERT INTO public.questions_backup VALUES (196, 2, 'Why analyze complexity?', 1);
INSERT INTO public.questions_backup VALUES (197, 2, 'Binary search works on?', 1);
INSERT INTO public.questions_backup VALUES (198, 2, 'Which is not valid?', 3);
INSERT INTO public.questions_backup VALUES (199, 2, 'Most used complexity?', 2);
INSERT INTO public.questions_backup VALUES (200, 2, 'Time complexity helps in?', 1);
INSERT INTO public.questions_backup VALUES (201, 3, 'Array size fixed?', 0);
INSERT INTO public.questions_backup VALUES (202, 3, 'Jignesh Prajaparti', 1);
INSERT INTO public.questions_backup VALUES (203, 20, 'The Bellman Equation is used to compute:', 2);
INSERT INTO public.questions_backup VALUES (204, 20, 'The Bellman expectation equation relates a value function to:', 0);
INSERT INTO public.questions_backup VALUES (205, 20, 'The Bellman optimality equation is used to find:', 1);
INSERT INTO public.questions_backup VALUES (206, 20, 'The Bellman equation follows which principle?', 1);
INSERT INTO public.questions_backup VALUES (207, 20, 'State-value function is denoted as:', 1);
INSERT INTO public.questions_backup VALUES (208, 20, 'Action-value function is denoted as:', 2);
INSERT INTO public.questions_backup VALUES (209, 20, 'The Bellman equation includes which factor to discount future rewards?', 2);
INSERT INTO public.questions_backup VALUES (210, 20, 'If gamma is close to 0, the Bellman equation emphasizes:', 1);
INSERT INTO public.questions_backup VALUES (211, 20, 'The recursive nature of Bellman equation means:', 0);
INSERT INTO public.questions_backup VALUES (212, 20, 'Bellman optimality equation uses which operator?', 1);
INSERT INTO public.questions_backup VALUES (213, 20, 'Which algorithm directly uses Bellman update?', 2);
INSERT INTO public.questions_backup VALUES (214, 20, 'Q-learning update rule is derived from:', 0);
INSERT INTO public.questions_backup VALUES (215, 20, 'The Bellman expectation equation applies to:', 1);
INSERT INTO public.questions_backup VALUES (216, 20, 'The Bellman equation is mainly used in:', 1);
INSERT INTO public.questions_backup VALUES (217, 20, 'In Bellman equation, V(s) equals:', 1);
INSERT INTO public.questions_backup VALUES (218, 20, 'The main idea behind Bellman equation is:', 0);
INSERT INTO public.questions_backup VALUES (219, 20, 'The Bellman equation helps in computing:', 1);
INSERT INTO public.questions_backup VALUES (220, 20, 'The Bellman equation assumes:', 0);
INSERT INTO public.questions_backup VALUES (221, 20, 'Bellman update improves values iteratively until:', 0);
INSERT INTO public.questions_backup VALUES (222, 20, 'Bellman equation is fundamental for:', 1);
INSERT INTO public.questions_backup VALUES (223, 12, 'Which of the following is a core component of Reinforcement Learning?', 3);
INSERT INTO public.questions_backup VALUES (224, 12, 'The agent selects actions based on:', 0);
INSERT INTO public.questions_backup VALUES (225, 12, 'A state represents:', 0);
INSERT INTO public.questions_backup VALUES (226, 12, 'Reward function defines:', 1);
INSERT INTO public.questions_backup VALUES (227, 12, 'Policy is best defined as:', 0);
INSERT INTO public.questions_backup VALUES (228, 12, 'Value function estimates:', 1);
INSERT INTO public.questions_backup VALUES (229, 12, 'Action-value function is denoted as:', 2);
INSERT INTO public.questions_backup VALUES (230, 12, 'The discount factor (gamma) controls:', 1);
INSERT INTO public.questions_backup VALUES (231, 12, 'If gamma is close to 1, the agent:', 2);
INSERT INTO public.questions_backup VALUES (232, 12, 'The environment provides:', 2);
INSERT INTO public.questions_backup VALUES (233, 12, 'Transition probability defines:', 0);
INSERT INTO public.questions_backup VALUES (234, 12, 'A deterministic policy means:', 1);
INSERT INTO public.questions_backup VALUES (235, 12, 'A stochastic policy means:', 2);
INSERT INTO public.questions_backup VALUES (236, 12, 'The return G_t represents:', 1);
INSERT INTO public.questions_backup VALUES (237, 12, 'Exploration-exploitation tradeoff deals with:', 0);
INSERT INTO public.questions_backup VALUES (238, 12, 'The learning rate alpha controls:', 1);
INSERT INTO public.questions_backup VALUES (239, 12, 'Terminal state indicates:', 1);
INSERT INTO public.questions_backup VALUES (240, 12, 'The policy that maximizes value function is called:', 0);
INSERT INTO public.questions_backup VALUES (241, 12, 'State-value function is denoted as:', 1);
INSERT INTO public.questions_backup VALUES (242, 12, 'In RL, interaction happens in:', 1);
INSERT INTO public.questions_backup VALUES (243, 19, 'Deep Q-Network (DQN) combines Q-Learning with:', 1);
INSERT INTO public.questions_backup VALUES (244, 19, 'DQN replaces the Q-table with:', 1);
INSERT INTO public.questions_backup VALUES (245, 19, 'DQN is useful when:', 1);
INSERT INTO public.questions_backup VALUES (246, 19, 'Experience Replay in DQN is used to:', 1);
INSERT INTO public.questions_backup VALUES (247, 19, 'Target Network in DQN helps to:', 1);
INSERT INTO public.questions_backup VALUES (248, 19, 'DQN was famously applied to:', 1);
INSERT INTO public.questions_backup VALUES (249, 19, 'DQN is based on which algorithm?', 2);
INSERT INTO public.questions_backup VALUES (250, 19, 'Mini-batch training in DQN comes from:', 0);
INSERT INTO public.questions_backup VALUES (251, 19, 'The loss function in DQN minimizes:', 1);
INSERT INTO public.questions_backup VALUES (252, 19, 'Target value in DQN is:', 0);
INSERT INTO public.questions_backup VALUES (253, 19, 'Why is a separate target network used?', 1);
INSERT INTO public.questions_backup VALUES (254, 19, 'DQN is suitable for:', 1);
INSERT INTO public.questions_backup VALUES (255, 19, 'Experience replay stores:', 2);
INSERT INTO public.questions_backup VALUES (256, 19, 'DQN reduces correlation between samples by:', 1);
INSERT INTO public.questions_backup VALUES (257, 19, 'The main challenge DQN addresses is:', 0);
INSERT INTO public.questions_backup VALUES (258, 19, 'Double DQN improves DQN by:', 0);
INSERT INTO public.questions_backup VALUES (259, 19, 'Dueling DQN separates:', 0);
INSERT INTO public.questions_backup VALUES (260, 19, 'DQN training requires:', 0);
INSERT INTO public.questions_backup VALUES (261, 19, 'DQN is categorized under:', 1);
INSERT INTO public.questions_backup VALUES (262, 19, 'The ultimate goal of DQN is to:', 0);
INSERT INTO public.questions_backup VALUES (263, 13, 'Which of the following is NOT an element of Reinforcement Learning?', 3);
INSERT INTO public.questions_backup VALUES (264, 13, 'The agent interacts with the environment by taking:', 2);
INSERT INTO public.questions_backup VALUES (265, 13, 'State in RL represents:', 1);
INSERT INTO public.questions_backup VALUES (266, 13, 'Action is defined as:', 1);
INSERT INTO public.questions_backup VALUES (267, 13, 'Reward is given:', 1);
INSERT INTO public.questions_backup VALUES (268, 13, 'Which element defines how good a state is?', 2);
INSERT INTO public.questions_backup VALUES (269, 13, 'Which element tells the agent what to do?', 1);
INSERT INTO public.questions_backup VALUES (270, 13, 'The environment responds to an action with:', 2);
INSERT INTO public.questions_backup VALUES (271, 13, 'Which element predicts future rewards?', 2);
INSERT INTO public.questions_backup VALUES (272, 13, 'Model of environment defines:', 1);
INSERT INTO public.questions_backup VALUES (273, 13, 'Which element is optional in RL?', 3);
INSERT INTO public.questions_backup VALUES (274, 13, 'Policy depends on:', 0);
INSERT INTO public.questions_backup VALUES (275, 13, 'The agent’s objective is to maximize:', 2);
INSERT INTO public.questions_backup VALUES (276, 13, 'Which element evaluates actions?', 1);
INSERT INTO public.questions_backup VALUES (277, 13, 'Value function is represented as:', 2);
INSERT INTO public.questions_backup VALUES (278, 13, 'Action-value function is represented as:', 2);
INSERT INTO public.questions_backup VALUES (279, 13, 'Which element controls future reward importance?', 1);
INSERT INTO public.questions_backup VALUES (280, 13, 'Which element decides randomness in action selection?', 0);
INSERT INTO public.questions_backup VALUES (281, 13, 'Environment is external to the:', 1);
INSERT INTO public.questions_backup VALUES (282, 13, 'Which element ends an episode?', 1);
INSERT INTO public.questions_backup VALUES (283, 11, 'Reinforcement Learning is mainly based on:', 1);
INSERT INTO public.questions_backup VALUES (284, 11, 'In RL, learning happens through:', 1);
INSERT INTO public.questions_backup VALUES (285, 11, 'The main objective of RL is to:', 1);
INSERT INTO public.questions_backup VALUES (286, 11, 'RL is different from supervised learning because it:', 0);
INSERT INTO public.questions_backup VALUES (287, 11, 'The learner in RL is called:', 1);
INSERT INTO public.questions_backup VALUES (288, 11, 'The world in which the agent operates is called:', 2);
INSERT INTO public.questions_backup VALUES (289, 11, 'Reward in RL is:', 1);
INSERT INTO public.questions_backup VALUES (290, 11, 'RL problems are often modeled as:', 1);
INSERT INTO public.questions_backup VALUES (291, 11, 'Exploration helps the agent to:', 1);
INSERT INTO public.questions_backup VALUES (292, 11, 'Exploitation means:', 1);
INSERT INTO public.questions_backup VALUES (293, 11, 'An episode ends when:', 1);
INSERT INTO public.questions_backup VALUES (294, 11, 'RL is widely used in:', 3);
INSERT INTO public.questions_backup VALUES (295, 11, 'Immediate reward is also called:', 1);
INSERT INTO public.questions_backup VALUES (296, 11, 'RL does NOT require:', 2);
INSERT INTO public.questions_backup VALUES (297, 11, 'Sequential decision making is a feature of:', 1);
INSERT INTO public.questions_backup VALUES (298, 11, 'Long-term reward is calculated using:', 0);
INSERT INTO public.questions_backup VALUES (299, 11, 'The agent observes the:', 1);
INSERT INTO public.questions_backup VALUES (300, 11, 'Action is chosen based on:', 2);
INSERT INTO public.questions_backup VALUES (301, 11, 'Trial-and-error learning improves:', 1);
INSERT INTO public.questions_backup VALUES (302, 11, 'Reinforcement Learning belongs to:', 0);
INSERT INTO public.questions_backup VALUES (303, 15, 'A Markov Decision Process is defined by which tuple?', 1);
INSERT INTO public.questions_backup VALUES (304, 15, 'In MDP, S represents:', 0);
INSERT INTO public.questions_backup VALUES (305, 15, 'In MDP, A represents:', 1);
INSERT INTO public.questions_backup VALUES (306, 15, 'P in MDP stands for:', 1);
INSERT INTO public.questions_backup VALUES (307, 15, 'The Markov property states that:', 0);
INSERT INTO public.questions_backup VALUES (308, 15, 'The reward function in MDP is denoted as:', 0);
INSERT INTO public.questions_backup VALUES (309, 15, 'Gamma (γ) in MDP represents:', 1);
INSERT INTO public.questions_backup VALUES (310, 15, 'If γ = 1, the agent:', 2);
INSERT INTO public.questions_backup VALUES (311, 15, 'A deterministic MDP means:', 0);
INSERT INTO public.questions_backup VALUES (312, 15, 'A stochastic MDP means:', 1);
INSERT INTO public.questions_backup VALUES (313, 15, 'Transition probability is written as:', 0);
INSERT INTO public.questions_backup VALUES (314, 15, 'An MDP becomes episodic when:', 1);
INSERT INTO public.questions_backup VALUES (315, 15, 'The objective in MDP is to find:', 1);
INSERT INTO public.questions_backup VALUES (316, 15, 'Which algorithm solves MDP when model is known?', 2);
INSERT INTO public.questions_backup VALUES (317, 15, 'Value Iteration is based on:', 0);
INSERT INTO public.questions_backup VALUES (318, 15, 'Policy Iteration involves:', 0);
INSERT INTO public.questions_backup VALUES (319, 15, 'The return in MDP is:', 1);
INSERT INTO public.questions_backup VALUES (320, 15, 'If γ = 0, the agent considers:', 0);
INSERT INTO public.questions_backup VALUES (321, 15, 'MDP framework is mainly used for:', 1);
INSERT INTO public.questions_backup VALUES (322, 15, 'An optimal policy maximizes:', 1);
INSERT INTO public.questions_backup VALUES (323, 16, 'A policy in Reinforcement Learning is:', 1);
INSERT INTO public.questions_backup VALUES (324, 16, 'A deterministic policy selects:', 2);
INSERT INTO public.questions_backup VALUES (325, 16, 'A stochastic policy selects actions based on:', 1);
INSERT INTO public.questions_backup VALUES (326, 16, 'The optimal policy is denoted as:', 1);
INSERT INTO public.questions_backup VALUES (327, 16, 'A greedy policy chooses action based on:', 0);
INSERT INTO public.questions_backup VALUES (328, 16, 'An epsilon-greedy policy balances:', 1);
INSERT INTO public.questions_backup VALUES (329, 16, 'If epsilon = 0 in epsilon-greedy, the agent:', 1);
INSERT INTO public.questions_backup VALUES (330, 16, 'If epsilon = 1 in epsilon-greedy, the agent:', 1);
INSERT INTO public.questions_backup VALUES (331, 16, 'Soft policy means:', 1);
INSERT INTO public.questions_backup VALUES (332, 16, 'Policy improvement step aims to:', 1);
INSERT INTO public.questions_backup VALUES (333, 16, 'Random policy selects actions:', 1);
INSERT INTO public.questions_backup VALUES (334, 16, 'Policy evaluation computes:', 1);
INSERT INTO public.questions_backup VALUES (335, 16, 'A parameterized policy is commonly used in:', 0);
INSERT INTO public.questions_backup VALUES (336, 16, 'Policy gradient methods directly optimize:', 1);
INSERT INTO public.questions_backup VALUES (337, 16, 'In on-policy learning, the agent:', 1);
INSERT INTO public.questions_backup VALUES (338, 16, 'In off-policy learning, the agent:', 0);
INSERT INTO public.questions_backup VALUES (339, 16, 'Which policy encourages more exploration?', 2);
INSERT INTO public.questions_backup VALUES (340, 16, 'A fixed policy means:', 0);
INSERT INTO public.questions_backup VALUES (341, 16, 'Policy iteration consists of:', 0);
INSERT INTO public.questions_backup VALUES (342, 16, 'The ultimate goal of policy learning is to:', 1);
INSERT INTO public.questions_backup VALUES (343, 17, 'Q-Learning is a type of:', 2);
INSERT INTO public.questions_backup VALUES (344, 17, 'Q in Q-Learning stands for:', 1);
INSERT INTO public.questions_backup VALUES (345, 17, 'Q(s, a) represents:', 1);
INSERT INTO public.questions_backup VALUES (346, 17, 'Q-Learning uses which equation for updating?', 0);
INSERT INTO public.questions_backup VALUES (347, 17, 'The Q-Learning update rule includes which operator?', 1);
INSERT INTO public.questions_backup VALUES (348, 17, 'Q-Learning is considered:', 1);
INSERT INTO public.questions_backup VALUES (349, 17, 'The learning rate in Q-Learning is denoted by:', 2);
INSERT INTO public.questions_backup VALUES (350, 17, 'The discount factor in Q-Learning is denoted by:', 1);
INSERT INTO public.questions_backup VALUES (351, 17, 'If α is very high, learning becomes:', 1);
INSERT INTO public.questions_backup VALUES (352, 17, 'Q-table stores:', 2);
INSERT INTO public.questions_backup VALUES (353, 17, 'Q-Learning does NOT require:', 0);
INSERT INTO public.questions_backup VALUES (354, 17, 'The update rule for Q-Learning moves Q-value toward:', 2);
INSERT INTO public.questions_backup VALUES (355, 17, 'Q-Learning converges to optimal policy when:', 0);
INSERT INTO public.questions_backup VALUES (356, 17, 'Which strategy is commonly used with Q-Learning?', 0);
INSERT INTO public.questions_backup VALUES (357, 17, 'The target in Q-Learning is:', 0);
INSERT INTO public.questions_backup VALUES (358, 17, 'Q-Learning works well for:', 0);
INSERT INTO public.questions_backup VALUES (359, 17, 'The main advantage of Q-Learning is:', 1);
INSERT INTO public.questions_backup VALUES (360, 17, 'Q-Learning updates are performed:', 1);
INSERT INTO public.questions_backup VALUES (361, 17, 'Deep Q-Network (DQN) replaces Q-table with:', 1);
INSERT INTO public.questions_backup VALUES (362, 17, 'Q-Learning aims to learn:', 0);
INSERT INTO public.questions_backup VALUES (363, 14, 'Reinforcement Learning is mainly divided into:', 1);
INSERT INTO public.questions_backup VALUES (364, 14, 'Model-based RL requires:', 1);
INSERT INTO public.questions_backup VALUES (365, 14, 'Model-free RL does NOT require:', 2);
INSERT INTO public.questions_backup VALUES (366, 14, 'Q-Learning is an example of:', 1);
INSERT INTO public.questions_backup VALUES (367, 14, 'Value Iteration belongs to:', 0);
INSERT INTO public.questions_backup VALUES (368, 14, 'Policy-based methods directly optimize:', 1);
INSERT INTO public.questions_backup VALUES (369, 14, 'Value-based methods learn:', 1);
INSERT INTO public.questions_backup VALUES (370, 14, 'Actor-Critic methods combine:', 1);
INSERT INTO public.questions_backup VALUES (371, 14, 'On-policy learning means:', 0);
INSERT INTO public.questions_backup VALUES (372, 14, 'Off-policy learning means:', 1);
INSERT INTO public.questions_backup VALUES (373, 14, 'SARSA is an example of:', 1);
INSERT INTO public.questions_backup VALUES (374, 14, 'Deep Q-Network (DQN) belongs to:', 1);
INSERT INTO public.questions_backup VALUES (375, 14, 'Policy Gradient is:', 1);
INSERT INTO public.questions_backup VALUES (376, 14, 'Monte Carlo methods are examples of:', 0);
INSERT INTO public.questions_backup VALUES (377, 14, 'Temporal Difference (TD) learning belongs to:', 0);
INSERT INTO public.questions_backup VALUES (378, 14, 'Actor-Critic methods are useful for:', 0);
INSERT INTO public.questions_backup VALUES (379, 14, 'Model-based RL generally:', 0);
INSERT INTO public.questions_backup VALUES (380, 14, 'Model-free RL generally:', 1);
INSERT INTO public.questions_backup VALUES (381, 14, 'Which method combines planning and learning?', 0);
INSERT INTO public.questions_backup VALUES (382, 14, 'The main goal of all RL types is to:', 1);
INSERT INTO public.questions_backup VALUES (383, 18, 'SARSA stands for:', 0);
INSERT INTO public.questions_backup VALUES (384, 18, 'SARSA is a type of:', 2);
INSERT INTO public.questions_backup VALUES (385, 18, 'SARSA updates Q-value using:', 1);
INSERT INTO public.questions_backup VALUES (386, 18, 'The SARSA update rule is based on:', 0);
INSERT INTO public.questions_backup VALUES (387, 18, 'In SARSA, the next action is selected using:', 1);
INSERT INTO public.questions_backup VALUES (388, 18, 'The key difference between SARSA and Q-Learning is:', 2);
INSERT INTO public.questions_backup VALUES (389, 18, 'The learning rate in SARSA is denoted by:', 1);
INSERT INTO public.questions_backup VALUES (390, 18, 'The discount factor in SARSA is denoted by:', 2);
INSERT INTO public.questions_backup VALUES (391, 18, 'SARSA is more conservative than Q-Learning because it:', 0);
INSERT INTO public.questions_backup VALUES (392, 18, 'The update target in SARSA is:', 1);
INSERT INTO public.questions_backup VALUES (393, 18, 'SARSA performs updates:', 0);
INSERT INTO public.questions_backup VALUES (394, 18, 'Which strategy is commonly used with SARSA?', 0);
INSERT INTO public.questions_backup VALUES (395, 18, 'SARSA works well in:', 0);
INSERT INTO public.questions_backup VALUES (396, 18, 'SARSA converges when:', 0);
INSERT INTO public.questions_backup VALUES (397, 18, 'SARSA requires knowledge of:', 2);
INSERT INTO public.questions_backup VALUES (398, 18, 'Compared to Q-Learning, SARSA tends to:', 0);
INSERT INTO public.questions_backup VALUES (399, 18, 'SARSA belongs to which category?', 1);
INSERT INTO public.questions_backup VALUES (400, 18, 'The Q-table in SARSA stores:', 2);
INSERT INTO public.questions_backup VALUES (401, 18, 'The main advantage of SARSA is:', 0);
INSERT INTO public.questions_backup VALUES (402, 18, 'SARSA aims to learn:', 0);


--
-- Data for Name: quiz_results; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.quiz_results VALUES (1, NULL, 'arrays', NULL, NULL, '2026-03-07 11:54:13.864129');
INSERT INTO public.quiz_results VALUES (3, 1, 'arrays', 8, 10, '2026-03-07 11:57:34.329527');
INSERT INTO public.quiz_results VALUES (4, 1, 'arrays', 2, 22, '2026-03-07 12:11:01.32524');
INSERT INTO public.quiz_results VALUES (5, 1, 'dsa_intro', 5, 10, '2026-03-07 12:21:17.112479');
INSERT INTO public.quiz_results VALUES (6, 1, 'rl_reinforcement_types', 5, 20, '2026-03-07 16:34:59.014207');


--
-- Data for Name: topics; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.topics VALUES (81, 'rl_intro', 'rl_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (82, 'rl_framework', 'rl_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (83, 'rl_mdp', 'rl_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (84, 'rl_state_value_function', 'rl_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (85, 'rl_action_value_function', 'rl_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (86, 'rl_bellman_equations', 'rl_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (87, 'rl_optimality_of_value_functions', 'rl_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (88, 'rl_bellman_optimality_equations', 'rl_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (89, 'rl_dynamic_programming', 'rl_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (90, 'rl_policy_iteration', 'rl_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (91, 'rl_value_iteration', 'rl_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (92, 'rl_planning_mdp', 'rl_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (93, 'rl_principle_of_optimality', 'rl_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (94, 'rl_monte_carlo', 'rl_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (95, 'rl_td0', 'rl_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (96, 'rl_td1', 'rl_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (97, 'rl_tdlambda', 'rl_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (98, 'rl_k_step', 'rl_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (99, 'rl_on_off_policy', 'rl_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (100, 'rl_sarsa', 'rl_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (101, 'rl_q_learning', 'rl_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (102, 'rl_function_approximation', 'rl_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (103, 'rl_gradient_descent_methods', 'rl_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (104, 'rl_gradient_monte_carlo', 'rl_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (105, 'rl_semi_gradient_td', 'rl_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (106, 'rl_eligibility_traces', 'rl_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (107, 'rl_intro_deep_rl', 'rl_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (108, 'rl_multi_armed_bandits', 'rl_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (109, 'rl_policy_gradient', 'rl_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (110, 'rl_actor_critic', 'rl_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (111, 'rl_dqn', 'rl_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (112, 'rl_double_dqn', 'rl_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (113, 'rl_applications', 'rl_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (114, 'rl_multi_agent', 'rl_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (1, 'dsa_intro', 'dsa_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (3, 'arrays', 'dsa_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (4, 'strings', 'dsa_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (5, 'searching', 'dsa_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (6, 'sorting', 'dsa_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (7, 'maths', 'dsa_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (8, 'stack', 'dsa_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (9, 'queue', 'dsa_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (10, 'practice', 'dsa_full_course', NULL, NULL, 0, NULL, 0);
INSERT INTO public.topics VALUES (2, 'time_space', 'dsa_full_course', NULL, NULL, 0, NULL, 0);


--
-- Data for Name: user_streaks; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.user_streaks VALUES (1, 1, '2026-03-07', 1);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES (2, 'Rahul', 'rahul@test.com', '2026-03-07 12:15:21.05688', '$2b$10$nEbsd/yFUAs7VJxJle/DUeaNIgO6SWQjUM/Kix04df9T0uGOQ4GJq');
INSERT INTO public.users VALUES (3, 'Jignesh Prajapati ', 'Hello@gmail.com', '2026-03-07 12:45:10.559472', '$2b$10$MEtRkDo/1Z2Fo7laxSmZieTWNa78rEKVsf1tqlQap6thERHVyjSFK');
INSERT INTO public.users VALUES (4, 'Aalap', 'Aalap@gmail.com', '2026-03-07 12:49:16.084563', '$2b$10$muz9Q5kcRE2xEhQ4VSItiOrM1lt9AQHe06HTJKsCuJSz5tcF3xLZu');
INSERT INTO public.users VALUES (5, 'Help', 'help@gmail.com', '2026-03-09 10:33:15.120217', '$2b$10$6my0maclr15xF3CEOMUxNOLZnUQPA9aVpGHvjt0PPj2ywN0UHl3SO');
INSERT INTO public.users VALUES (6, 'Hello jp', 'hello@gmail.com', '2026-03-16 14:04:13.448805', '$2b$10$e/Q9BsuvULqTllK2vAXotetMUBlAmjKbmc0.Rd5mZJkgEhRqX3U8y');
INSERT INTO public.users VALUES (7, 'Hello jignesh', 'Jignesh@gmail.com', '2026-03-21 13:51:05.93434', '$2b$10$ECjXz/QnMkkGR4aNYWMo3OifHC8ZQcyWfFIRVmqgR4JLXsOuc9QJG');
INSERT INTO public.users VALUES (8, 'Jp', 'jp@gmail.com', '2026-03-23 10:37:27.309133', '$2b$10$AuHdpJW20rDRj5lniUt6bO6VRDHZze8IaKXhUlgj7DBy5rnc6HTSu');
INSERT INTO public.users VALUES (9, 'Hellllll', 'jp1@gmail.com', '2026-03-23 14:18:44.108322', '$2b$10$f3rXIO2I5tcXhFM2KAk8zec/DmRgcA0XKZIWPH0YEIhE49Sel3PAy');
INSERT INTO public.users VALUES (1, 'Test User', 'test@example.com', '2026-03-07 11:57:14.299099', 'default_password');
INSERT INTO public.users VALUES (10, 'Jignesh prajapati', 'jignesh@gmail.com', '2026-03-27 15:46:36.372796', '$2b$10$mJDccYB55KLRIjKITGZ4e.uPn3bYh129FEW/IgrKrHdTh68FfcK1C');
INSERT INTO public.users VALUES (11, 'Prajapati Jp', 'jigneshjp@gmail.com', '2026-03-28 11:43:03.174179', '$2b$10$2q02tpNCSA.amsUXzNEeMevFi4E8NNPNluMkp/eys7Zov/rYwKIoK');
INSERT INTO public.users VALUES (12, 'Aalap', 'aalap@gmail.com', '2026-03-28 13:59:43.942583', '$2b$10$54mw9UQ0sxn/mzAjJyUa2.//HY0szlM.Ya72swsgDwxYPW0cKpAfK');
INSERT INTO public.users VALUES (13, 'Zenis', 'zenis@gmail.com', '2026-03-28 15:31:35.816781', '$2b$10$/OYMaS8Yp/72RAsIa19p..RkYTFtOjbD7tJJCGpex.Or1lqU1CIyu');


--
-- Name: admins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admins_id_seq', 1, true);


--
-- Name: attempt_responses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.attempt_responses_id_seq', 1041, true);


--
-- Name: attempts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.attempts_id_seq', 173, true);


--
-- Name: daily_quiz_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.daily_quiz_id_seq', 1, true);


--
-- Name: daily_quiz_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.daily_quiz_log_id_seq', 1, false);


--
-- Name: daily_quiz_results_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.daily_quiz_results_id_seq', 37, true);


--
-- Name: options_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.options_id_seq', 23920, true);


--
-- Name: purchases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.purchases_id_seq', 5, true);


--
-- Name: questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.questions_id_seq', 5981, true);


--
-- Name: quiz_results_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quiz_results_id_seq', 6, true);


--
-- Name: topics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.topics_id_seq', 114, true);


--
-- Name: user_streaks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_streaks_id_seq', 1, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 13, true);


--
-- Name: admins admins_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_email_key UNIQUE (email);


--
-- Name: admins admins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (id);


--
-- Name: attempt_responses attempt_responses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attempt_responses
    ADD CONSTRAINT attempt_responses_pkey PRIMARY KEY (id);


--
-- Name: attempts attempts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attempts
    ADD CONSTRAINT attempts_pkey PRIMARY KEY (id);


--
-- Name: daily_quiz_log daily_quiz_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.daily_quiz_log
    ADD CONSTRAINT daily_quiz_log_pkey PRIMARY KEY (id);


--
-- Name: daily_quiz daily_quiz_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.daily_quiz
    ADD CONSTRAINT daily_quiz_pkey PRIMARY KEY (id);


--
-- Name: daily_quiz daily_quiz_quiz_date_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.daily_quiz
    ADD CONSTRAINT daily_quiz_quiz_date_key UNIQUE (quiz_date);


--
-- Name: daily_quiz_results daily_quiz_results_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.daily_quiz_results
    ADD CONSTRAINT daily_quiz_results_pkey PRIMARY KEY (id);


--
-- Name: options options_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.options
    ADD CONSTRAINT options_pkey PRIMARY KEY (id);


--
-- Name: purchases purchases_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchases
    ADD CONSTRAINT purchases_pkey PRIMARY KEY (id);


--
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- Name: quiz_results quiz_results_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_results
    ADD CONSTRAINT quiz_results_pkey PRIMARY KEY (id);


--
-- Name: topics topics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topics
    ADD CONSTRAINT topics_pkey PRIMARY KEY (id);


--
-- Name: topics topics_topic_key_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topics
    ADD CONSTRAINT topics_topic_key_key UNIQUE (topic_key);


--
-- Name: attempt_responses unique_attempt_question; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attempt_responses
    ADD CONSTRAINT unique_attempt_question UNIQUE (attempt_id, question_id);


--
-- Name: users unique_email; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT unique_email UNIQUE (email);


--
-- Name: user_streaks user_streaks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_streaks
    ADD CONSTRAINT user_streaks_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_attempt_response_attempt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_attempt_response_attempt ON public.attempt_responses USING btree (attempt_id);


--
-- Name: idx_attempt_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_attempt_user ON public.attempts USING btree (user_id);


--
-- Name: idx_options_question; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_options_question ON public.options USING btree (question_id);


--
-- Name: idx_questions_topic; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_questions_topic ON public.questions USING btree (topic_id);


--
-- Name: unique_question; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX unique_question ON public.questions USING btree (topic_id, question);


--
-- Name: daily_quiz_log daily_quiz_log_topic_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.daily_quiz_log
    ADD CONSTRAINT daily_quiz_log_topic_id_fkey FOREIGN KEY (topic_id) REFERENCES public.topics(id);


--
-- Name: attempt_responses fk_attempt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attempt_responses
    ADD CONSTRAINT fk_attempt FOREIGN KEY (attempt_id) REFERENCES public.attempts(id) ON DELETE CASCADE;


--
-- Name: attempt_responses fk_option; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attempt_responses
    ADD CONSTRAINT fk_option FOREIGN KEY (selected_option_id) REFERENCES public.options(id);


--
-- Name: purchases fk_purchase_topic; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchases
    ADD CONSTRAINT fk_purchase_topic FOREIGN KEY (topic_id) REFERENCES public.topics(id);


--
-- Name: attempt_responses fk_question; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attempt_responses
    ADD CONSTRAINT fk_question FOREIGN KEY (question_id) REFERENCES public.questions(id);


--
-- Name: attempts fk_topic; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attempts
    ADD CONSTRAINT fk_topic FOREIGN KEY (topic_id) REFERENCES public.topics(id);


--
-- Name: attempts fk_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attempts
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: options options_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.options
    ADD CONSTRAINT options_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id);


--
-- Name: questions questions_topic_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_topic_id_fkey FOREIGN KEY (topic_id) REFERENCES public.topics(id);


--
-- Name: quiz_results quiz_results_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_results
    ADD CONSTRAINT quiz_results_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: user_streaks user_streaks_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_streaks
    ADD CONSTRAINT user_streaks_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--


