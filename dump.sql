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
-- Name: ai_match_feedback; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ai_match_feedback (
    feedback_id integer NOT NULL,
    job_id integer,
    user_id integer NOT NULL,
    match_percentage numeric(5,2),
    user_rating integer,
    feedback_text text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT ai_match_feedback_user_rating_check CHECK (((user_rating >= 1) AND (user_rating <= 5)))
);


ALTER TABLE public.ai_match_feedback OWNER TO postgres;

--
-- Name: ai_match_feedback_feedback_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ai_match_feedback_feedback_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ai_match_feedback_feedback_id_seq OWNER TO postgres;

--
-- Name: ai_match_feedback_feedback_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ai_match_feedback_feedback_id_seq OWNED BY public.ai_match_feedback.feedback_id;


--
-- Name: ai_model_parameters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ai_model_parameters (
    parameter_id integer NOT NULL,
    parameter_name character varying(100) NOT NULL,
    parameter_value jsonb NOT NULL,
    description text,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.ai_model_parameters OWNER TO postgres;

--
-- Name: ai_model_parameters_parameter_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ai_model_parameters_parameter_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ai_model_parameters_parameter_id_seq OWNER TO postgres;

--
-- Name: ai_model_parameters_parameter_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ai_model_parameters_parameter_id_seq OWNED BY public.ai_model_parameters.parameter_id;


--
-- Name: application_answers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.application_answers (
    answer_id integer NOT NULL,
    application_id integer NOT NULL,
    question_id integer NOT NULL,
    answer_text text NOT NULL
);


ALTER TABLE public.application_answers OWNER TO postgres;

--
-- Name: application_answers_answer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.application_answers_answer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.application_answers_answer_id_seq OWNER TO postgres;

--
-- Name: application_answers_answer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.application_answers_answer_id_seq OWNED BY public.application_answers.answer_id;


--
-- Name: application_statuses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.application_statuses (
    status_id integer NOT NULL,
    status_name character varying(50) NOT NULL
);


ALTER TABLE public.application_statuses OWNER TO postgres;

--
-- Name: application_statuses_status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.application_statuses_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.application_statuses_status_id_seq OWNER TO postgres;

--
-- Name: application_statuses_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.application_statuses_status_id_seq OWNED BY public.application_statuses.status_id;


--
-- Name: career_paths; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.career_paths (
    path_id integer NOT NULL,
    path_name character varying(255) NOT NULL,
    description text,
    industry character varying(100),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.career_paths OWNER TO postgres;

--
-- Name: career_paths_path_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.career_paths_path_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.career_paths_path_id_seq OWNER TO postgres;

--
-- Name: career_paths_path_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.career_paths_path_id_seq OWNED BY public.career_paths.path_id;


--
-- Name: career_positions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.career_positions (
    position_id integer NOT NULL,
    path_id integer NOT NULL,
    position_name character varying(255) NOT NULL,
    level integer NOT NULL,
    avg_salary_min numeric(12,2),
    avg_salary_max numeric(12,2),
    salary_currency character varying(3) DEFAULT 'USD'::character varying,
    description text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.career_positions OWNER TO postgres;

--
-- Name: career_positions_position_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.career_positions_position_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.career_positions_position_id_seq OWNER TO postgres;

--
-- Name: career_positions_position_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.career_positions_position_id_seq OWNED BY public.career_positions.position_id;


--
-- Name: companies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.companies (
    company_id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    website_url text,
    logo_url text,
    size character varying(50),
    industry character varying(100),
    founded_year integer,
    headquarters_location character varying(255),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.companies OWNER TO postgres;

--
-- Name: companies_company_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.companies_company_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.companies_company_id_seq OWNER TO postgres;

--
-- Name: companies_company_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.companies_company_id_seq OWNED BY public.companies.company_id;


--
-- Name: company_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.company_users (
    company_user_id integer NOT NULL,
    company_id integer NOT NULL,
    user_id integer NOT NULL,
    role character varying(100) NOT NULL,
    is_admin boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.company_users OWNER TO postgres;

--
-- Name: company_users_company_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.company_users_company_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.company_users_company_user_id_seq OWNER TO postgres;

--
-- Name: company_users_company_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.company_users_company_user_id_seq OWNED BY public.company_users.company_user_id;


--
-- Name: conversation_participants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conversation_participants (
    participant_id integer NOT NULL,
    conversation_id integer NOT NULL,
    user_id integer NOT NULL,
    joined_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    left_at timestamp with time zone,
    is_active boolean DEFAULT true
);


ALTER TABLE public.conversation_participants OWNER TO postgres;

--
-- Name: conversation_participants_participant_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.conversation_participants_participant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.conversation_participants_participant_id_seq OWNER TO postgres;

--
-- Name: conversation_participants_participant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.conversation_participants_participant_id_seq OWNED BY public.conversation_participants.participant_id;


--
-- Name: conversation_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conversation_types (
    type_id integer NOT NULL,
    type_name character varying(50) NOT NULL
);


ALTER TABLE public.conversation_types OWNER TO postgres;

--
-- Name: conversation_types_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.conversation_types_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.conversation_types_type_id_seq OWNER TO postgres;

--
-- Name: conversation_types_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.conversation_types_type_id_seq OWNED BY public.conversation_types.type_id;


--
-- Name: conversations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conversations (
    conversation_id integer NOT NULL,
    type_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.conversations OWNER TO postgres;

--
-- Name: conversations_conversation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.conversations_conversation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.conversations_conversation_id_seq OWNER TO postgres;

--
-- Name: conversations_conversation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.conversations_conversation_id_seq OWNED BY public.conversations.conversation_id;


--
-- Name: education; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.education (
    education_id integer NOT NULL,
    user_id integer NOT NULL,
    institution_name character varying(255) NOT NULL,
    degree character varying(255) NOT NULL,
    field_of_study character varying(255),
    start_date date NOT NULL,
    end_date date,
    is_current boolean DEFAULT false,
    description text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.education OWNER TO postgres;

--
-- Name: education_education_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.education_education_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.education_education_id_seq OWNER TO postgres;

--
-- Name: education_education_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.education_education_id_seq OWNED BY public.education.education_id;


--
-- Name: experience; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.experience (
    experience_id integer NOT NULL,
    user_id integer NOT NULL,
    company_name character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    location character varying(255),
    is_remote boolean DEFAULT false,
    start_date date NOT NULL,
    end_date date,
    is_current boolean DEFAULT false,
    description text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.experience OWNER TO postgres;

--
-- Name: experience_experience_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.experience_experience_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.experience_experience_id_seq OWNER TO postgres;

--
-- Name: experience_experience_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.experience_experience_id_seq OWNED BY public.experience.experience_id;


--
-- Name: experience_levels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.experience_levels (
    level_id integer NOT NULL,
    level_name character varying(50) NOT NULL
);


ALTER TABLE public.experience_levels OWNER TO postgres;

--
-- Name: experience_levels_level_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.experience_levels_level_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.experience_levels_level_id_seq OWNER TO postgres;

--
-- Name: experience_levels_level_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.experience_levels_level_id_seq OWNED BY public.experience_levels.level_id;


--
-- Name: interview_feedback; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.interview_feedback (
    feedback_id integer NOT NULL,
    interview_id integer NOT NULL,
    given_by_user_id integer NOT NULL,
    rating integer,
    comments text,
    strengths text,
    weaknesses text,
    recommendation character varying(50),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT interview_feedback_rating_check CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE public.interview_feedback OWNER TO postgres;

--
-- Name: interview_feedback_feedback_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.interview_feedback_feedback_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.interview_feedback_feedback_id_seq OWNER TO postgres;

--
-- Name: interview_feedback_feedback_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.interview_feedback_feedback_id_seq OWNED BY public.interview_feedback.feedback_id;


--
-- Name: interview_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.interview_types (
    type_id integer NOT NULL,
    type_name character varying(50) NOT NULL
);


ALTER TABLE public.interview_types OWNER TO postgres;

--
-- Name: interview_types_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.interview_types_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.interview_types_type_id_seq OWNER TO postgres;

--
-- Name: interview_types_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.interview_types_type_id_seq OWNED BY public.interview_types.type_id;


--
-- Name: interviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.interviews (
    interview_id integer NOT NULL,
    application_id integer NOT NULL,
    scheduled_by_user_id integer NOT NULL,
    interview_type_id integer NOT NULL,
    scheduled_at timestamp with time zone NOT NULL,
    duration_minutes integer NOT NULL,
    location_or_link text,
    notes text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.interviews OWNER TO postgres;

--
-- Name: interviews_interview_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.interviews_interview_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.interviews_interview_id_seq OWNER TO postgres;

--
-- Name: interviews_interview_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.interviews_interview_id_seq OWNED BY public.interviews.interview_id;


--
-- Name: job_applications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_applications (
    application_id integer NOT NULL,
    job_id integer NOT NULL,
    user_id integer NOT NULL,
    cv_id integer,
    cover_letter text,
    status_id integer NOT NULL,
    match_percentage numeric(5,2),
    applied_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.job_applications OWNER TO postgres;

--
-- Name: job_applications_application_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.job_applications_application_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.job_applications_application_id_seq OWNER TO postgres;

--
-- Name: job_applications_application_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.job_applications_application_id_seq OWNED BY public.job_applications.application_id;


--
-- Name: job_skills; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_skills (
    job_skill_id integer NOT NULL,
    job_id integer NOT NULL,
    skill_id integer NOT NULL,
    importance_level integer,
    is_required boolean DEFAULT false,
    CONSTRAINT job_skills_importance_level_check CHECK (((importance_level >= 1) AND (importance_level <= 5)))
);


ALTER TABLE public.job_skills OWNER TO postgres;

--
-- Name: job_skills_job_skill_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.job_skills_job_skill_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.job_skills_job_skill_id_seq OWNER TO postgres;

--
-- Name: job_skills_job_skill_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.job_skills_job_skill_id_seq OWNED BY public.job_skills.job_skill_id;


--
-- Name: job_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_types (
    job_type_id integer NOT NULL,
    type_name character varying(50) NOT NULL
);


ALTER TABLE public.job_types OWNER TO postgres;

--
-- Name: job_types_job_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.job_types_job_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.job_types_job_type_id_seq OWNER TO postgres;

--
-- Name: job_types_job_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.job_types_job_type_id_seq OWNED BY public.job_types.job_type_id;


--
-- Name: jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jobs (
    job_id integer NOT NULL,
    company_id integer NOT NULL,
    created_by_user_id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text NOT NULL,
    job_type_id integer,
    location_id integer,
    location_description character varying(255),
    experience_level_id integer,
    salary_min numeric(12,2),
    salary_max numeric(12,2),
    salary_currency character varying(3) DEFAULT 'USD'::character varying,
    is_salary_visible boolean DEFAULT true,
    application_deadline timestamp with time zone,
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.jobs OWNER TO postgres;

--
-- Name: jobs_job_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jobs_job_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jobs_job_id_seq OWNER TO postgres;

--
-- Name: jobs_job_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jobs_job_id_seq OWNED BY public.jobs.job_id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messages (
    message_id integer NOT NULL,
    conversation_id integer NOT NULL,
    sender_id integer NOT NULL,
    message_text text NOT NULL,
    sent_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    is_read boolean DEFAULT false
);


ALTER TABLE public.messages OWNER TO postgres;

--
-- Name: messages_message_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.messages_message_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.messages_message_id_seq OWNER TO postgres;

--
-- Name: messages_message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.messages_message_id_seq OWNED BY public.messages.message_id;


--
-- Name: notification_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notification_types (
    type_id integer NOT NULL,
    type_name character varying(100) NOT NULL,
    template text NOT NULL
);


ALTER TABLE public.notification_types OWNER TO postgres;

--
-- Name: notification_types_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notification_types_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notification_types_type_id_seq OWNER TO postgres;

--
-- Name: notification_types_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notification_types_type_id_seq OWNED BY public.notification_types.type_id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications (
    notification_id integer NOT NULL,
    user_id integer NOT NULL,
    type_id integer NOT NULL,
    related_id integer,
    is_read boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.notifications OWNER TO postgres;

--
-- Name: notifications_notification_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notifications_notification_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notifications_notification_id_seq OWNER TO postgres;

--
-- Name: notifications_notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notifications_notification_id_seq OWNED BY public.notifications.notification_id;


--
-- Name: password_resets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.password_resets (
    reset_id integer NOT NULL,
    user_id integer NOT NULL,
    token text NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.password_resets OWNER TO postgres;

--
-- Name: password_resets_reset_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.password_resets_reset_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.password_resets_reset_id_seq OWNER TO postgres;

--
-- Name: password_resets_reset_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.password_resets_reset_id_seq OWNED BY public.password_resets.reset_id;


--
-- Name: portfolio_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.portfolio_items (
    portfolio_id integer NOT NULL,
    user_id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    project_url text,
    image_url text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.portfolio_items OWNER TO postgres;

--
-- Name: portfolio_items_portfolio_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.portfolio_items_portfolio_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.portfolio_items_portfolio_id_seq OWNER TO postgres;

--
-- Name: portfolio_items_portfolio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.portfolio_items_portfolio_id_seq OWNED BY public.portfolio_items.portfolio_id;


--
-- Name: position_required_skills; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.position_required_skills (
    position_skill_id integer NOT NULL,
    position_id integer NOT NULL,
    skill_id integer NOT NULL,
    importance_level integer,
    CONSTRAINT position_required_skills_importance_level_check CHECK (((importance_level >= 1) AND (importance_level <= 5)))
);


ALTER TABLE public.position_required_skills OWNER TO postgres;

--
-- Name: position_required_skills_position_skill_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.position_required_skills_position_skill_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.position_required_skills_position_skill_id_seq OWNER TO postgres;

--
-- Name: position_required_skills_position_skill_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.position_required_skills_position_skill_id_seq OWNED BY public.position_required_skills.position_skill_id;


--
-- Name: screening_questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.screening_questions (
    question_id integer NOT NULL,
    job_id integer NOT NULL,
    question_text text NOT NULL,
    is_required boolean DEFAULT true,
    question_order integer NOT NULL
);


ALTER TABLE public.screening_questions OWNER TO postgres;

--
-- Name: screening_questions_question_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.screening_questions_question_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.screening_questions_question_id_seq OWNER TO postgres;

--
-- Name: screening_questions_question_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.screening_questions_question_id_seq OWNED BY public.screening_questions.question_id;


--
-- Name: skill_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.skill_categories (
    category_id integer NOT NULL,
    category_name character varying(100) NOT NULL,
    description text
);


ALTER TABLE public.skill_categories OWNER TO postgres;

--
-- Name: skill_categories_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.skill_categories_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.skill_categories_category_id_seq OWNER TO postgres;

--
-- Name: skill_categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.skill_categories_category_id_seq OWNED BY public.skill_categories.category_id;


--
-- Name: skill_endorsements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.skill_endorsements (
    endorsement_id integer NOT NULL,
    user_skill_id integer NOT NULL,
    endorsed_by_user_id integer NOT NULL,
    endorsement_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.skill_endorsements OWNER TO postgres;

--
-- Name: skill_endorsements_endorsement_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.skill_endorsements_endorsement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.skill_endorsements_endorsement_id_seq OWNER TO postgres;

--
-- Name: skill_endorsements_endorsement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.skill_endorsements_endorsement_id_seq OWNED BY public.skill_endorsements.endorsement_id;


--
-- Name: skills; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.skills (
    skill_id integer NOT NULL,
    skill_name character varying(255) NOT NULL,
    category_id integer,
    description text,
    is_technical boolean DEFAULT true
);


ALTER TABLE public.skills OWNER TO postgres;

--
-- Name: skills_skill_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.skills_skill_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.skills_skill_id_seq OWNER TO postgres;

--
-- Name: skills_skill_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.skills_skill_id_seq OWNED BY public.skills.skill_id;


--
-- Name: social_profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.social_profiles (
    profile_id integer NOT NULL,
    user_id integer NOT NULL,
    provider character varying(50) NOT NULL,
    provider_id character varying(255) NOT NULL,
    profile_url text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.social_profiles OWNER TO postgres;

--
-- Name: social_profiles_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.social_profiles_profile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.social_profiles_profile_id_seq OWNER TO postgres;

--
-- Name: social_profiles_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.social_profiles_profile_id_seq OWNED BY public.social_profiles.profile_id;


--
-- Name: user_activities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_activities (
    activity_id integer NOT NULL,
    user_id integer NOT NULL,
    activity_type character varying(100) NOT NULL,
    related_id integer,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.user_activities OWNER TO postgres;

--
-- Name: user_activities_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_activities_activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_activities_activity_id_seq OWNER TO postgres;

--
-- Name: user_activities_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_activities_activity_id_seq OWNED BY public.user_activities.activity_id;


--
-- Name: user_career_paths; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_career_paths (
    user_path_id integer NOT NULL,
    user_id integer NOT NULL,
    position_id integer NOT NULL,
    is_current boolean DEFAULT false,
    is_goal boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.user_career_paths OWNER TO postgres;

--
-- Name: user_career_paths_user_path_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_career_paths_user_path_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_career_paths_user_path_id_seq OWNER TO postgres;

--
-- Name: user_career_paths_user_path_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_career_paths_user_path_id_seq OWNED BY public.user_career_paths.user_path_id;


--
-- Name: user_cvs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_cvs (
    cv_id integer NOT NULL,
    user_id integer NOT NULL,
    file_name character varying(255) NOT NULL,
    file_url text NOT NULL,
    is_default boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.user_cvs OWNER TO postgres;

--
-- Name: user_cvs_cv_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_cvs_cv_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_cvs_cv_id_seq OWNER TO postgres;

--
-- Name: user_cvs_cv_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_cvs_cv_id_seq OWNED BY public.user_cvs.cv_id;


--
-- Name: user_preferences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_preferences (
    preference_id integer NOT NULL,
    user_id integer NOT NULL,
    preference_key character varying(100) NOT NULL,
    preference_value jsonb NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.user_preferences OWNER TO postgres;

--
-- Name: user_preferences_preference_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_preferences_preference_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_preferences_preference_id_seq OWNER TO postgres;

--
-- Name: user_preferences_preference_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_preferences_preference_id_seq OWNED BY public.user_preferences.preference_id;


--
-- Name: user_skills; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_skills (
    user_skill_id integer NOT NULL,
    user_id integer NOT NULL,
    skill_id integer NOT NULL,
    proficiency_level integer,
    years_experience numeric(4,1),
    is_verified boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT user_skills_proficiency_level_check CHECK (((proficiency_level >= 1) AND (proficiency_level <= 5)))
);


ALTER TABLE public.user_skills OWNER TO postgres;

--
-- Name: user_skills_user_skill_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_skills_user_skill_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_skills_user_skill_id_seq OWNER TO postgres;

--
-- Name: user_skills_user_skill_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_skills_user_skill_id_seq OWNED BY public.user_skills.user_skill_id;


--
-- Name: user_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_types (
    type_id integer NOT NULL,
    type_name character varying(50) NOT NULL
);


ALTER TABLE public.user_types OWNER TO postgres;

--
-- Name: user_types_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_types_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_types_type_id_seq OWNER TO postgres;

--
-- Name: user_types_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_types_type_id_seq OWNED BY public.user_types.type_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    user_type_id integer NOT NULL,
    email character varying(255) NOT NULL,
    password_hash text NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    phone_number character varying(50),
    profile_picture_url text,
    bio text,
    is_verified boolean DEFAULT false,
    is_active boolean DEFAULT true,
    remember_me_token text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: work_locations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.work_locations (
    location_id integer NOT NULL,
    location_type character varying(50) NOT NULL
);


ALTER TABLE public.work_locations OWNER TO postgres;

--
-- Name: work_locations_location_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.work_locations_location_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.work_locations_location_id_seq OWNER TO postgres;

--
-- Name: work_locations_location_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.work_locations_location_id_seq OWNED BY public.work_locations.location_id;


--
-- Name: ai_match_feedback feedback_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ai_match_feedback ALTER COLUMN feedback_id SET DEFAULT nextval('public.ai_match_feedback_feedback_id_seq'::regclass);


--
-- Name: ai_model_parameters parameter_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ai_model_parameters ALTER COLUMN parameter_id SET DEFAULT nextval('public.ai_model_parameters_parameter_id_seq'::regclass);


--
-- Name: application_answers answer_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application_answers ALTER COLUMN answer_id SET DEFAULT nextval('public.application_answers_answer_id_seq'::regclass);


--
-- Name: application_statuses status_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application_statuses ALTER COLUMN status_id SET DEFAULT nextval('public.application_statuses_status_id_seq'::regclass);


--
-- Name: career_paths path_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.career_paths ALTER COLUMN path_id SET DEFAULT nextval('public.career_paths_path_id_seq'::regclass);


--
-- Name: career_positions position_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.career_positions ALTER COLUMN position_id SET DEFAULT nextval('public.career_positions_position_id_seq'::regclass);


--
-- Name: companies company_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies ALTER COLUMN company_id SET DEFAULT nextval('public.companies_company_id_seq'::regclass);


--
-- Name: company_users company_user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.company_users ALTER COLUMN company_user_id SET DEFAULT nextval('public.company_users_company_user_id_seq'::regclass);


--
-- Name: conversation_participants participant_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversation_participants ALTER COLUMN participant_id SET DEFAULT nextval('public.conversation_participants_participant_id_seq'::regclass);


--
-- Name: conversation_types type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversation_types ALTER COLUMN type_id SET DEFAULT nextval('public.conversation_types_type_id_seq'::regclass);


--
-- Name: conversations conversation_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations ALTER COLUMN conversation_id SET DEFAULT nextval('public.conversations_conversation_id_seq'::regclass);


--
-- Name: education education_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.education ALTER COLUMN education_id SET DEFAULT nextval('public.education_education_id_seq'::regclass);


--
-- Name: experience experience_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.experience ALTER COLUMN experience_id SET DEFAULT nextval('public.experience_experience_id_seq'::regclass);


--
-- Name: experience_levels level_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.experience_levels ALTER COLUMN level_id SET DEFAULT nextval('public.experience_levels_level_id_seq'::regclass);


--
-- Name: interview_feedback feedback_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interview_feedback ALTER COLUMN feedback_id SET DEFAULT nextval('public.interview_feedback_feedback_id_seq'::regclass);


--
-- Name: interview_types type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interview_types ALTER COLUMN type_id SET DEFAULT nextval('public.interview_types_type_id_seq'::regclass);


--
-- Name: interviews interview_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interviews ALTER COLUMN interview_id SET DEFAULT nextval('public.interviews_interview_id_seq'::regclass);


--
-- Name: job_applications application_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_applications ALTER COLUMN application_id SET DEFAULT nextval('public.job_applications_application_id_seq'::regclass);


--
-- Name: job_skills job_skill_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_skills ALTER COLUMN job_skill_id SET DEFAULT nextval('public.job_skills_job_skill_id_seq'::regclass);


--
-- Name: job_types job_type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_types ALTER COLUMN job_type_id SET DEFAULT nextval('public.job_types_job_type_id_seq'::regclass);


--
-- Name: jobs job_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs ALTER COLUMN job_id SET DEFAULT nextval('public.jobs_job_id_seq'::regclass);


--
-- Name: messages message_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages ALTER COLUMN message_id SET DEFAULT nextval('public.messages_message_id_seq'::regclass);


--
-- Name: notification_types type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_types ALTER COLUMN type_id SET DEFAULT nextval('public.notification_types_type_id_seq'::regclass);


--
-- Name: notifications notification_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications ALTER COLUMN notification_id SET DEFAULT nextval('public.notifications_notification_id_seq'::regclass);


--
-- Name: password_resets reset_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_resets ALTER COLUMN reset_id SET DEFAULT nextval('public.password_resets_reset_id_seq'::regclass);


--
-- Name: portfolio_items portfolio_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.portfolio_items ALTER COLUMN portfolio_id SET DEFAULT nextval('public.portfolio_items_portfolio_id_seq'::regclass);


--
-- Name: position_required_skills position_skill_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.position_required_skills ALTER COLUMN position_skill_id SET DEFAULT nextval('public.position_required_skills_position_skill_id_seq'::regclass);


--
-- Name: screening_questions question_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.screening_questions ALTER COLUMN question_id SET DEFAULT nextval('public.screening_questions_question_id_seq'::regclass);


--
-- Name: skill_categories category_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skill_categories ALTER COLUMN category_id SET DEFAULT nextval('public.skill_categories_category_id_seq'::regclass);


--
-- Name: skill_endorsements endorsement_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skill_endorsements ALTER COLUMN endorsement_id SET DEFAULT nextval('public.skill_endorsements_endorsement_id_seq'::regclass);


--
-- Name: skills skill_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skills ALTER COLUMN skill_id SET DEFAULT nextval('public.skills_skill_id_seq'::regclass);


--
-- Name: social_profiles profile_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.social_profiles ALTER COLUMN profile_id SET DEFAULT nextval('public.social_profiles_profile_id_seq'::regclass);


--
-- Name: user_activities activity_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_activities ALTER COLUMN activity_id SET DEFAULT nextval('public.user_activities_activity_id_seq'::regclass);


--
-- Name: user_career_paths user_path_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_career_paths ALTER COLUMN user_path_id SET DEFAULT nextval('public.user_career_paths_user_path_id_seq'::regclass);


--
-- Name: user_cvs cv_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_cvs ALTER COLUMN cv_id SET DEFAULT nextval('public.user_cvs_cv_id_seq'::regclass);


--
-- Name: user_preferences preference_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_preferences ALTER COLUMN preference_id SET DEFAULT nextval('public.user_preferences_preference_id_seq'::regclass);


--
-- Name: user_skills user_skill_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_skills ALTER COLUMN user_skill_id SET DEFAULT nextval('public.user_skills_user_skill_id_seq'::regclass);


--
-- Name: user_types type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_types ALTER COLUMN type_id SET DEFAULT nextval('public.user_types_type_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Name: work_locations location_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.work_locations ALTER COLUMN location_id SET DEFAULT nextval('public.work_locations_location_id_seq'::regclass);


--
-- Data for Name: ai_match_feedback; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ai_match_feedback (feedback_id, job_id, user_id, match_percentage, user_rating, feedback_text, created_at) FROM stdin;
\.


--
-- Data for Name: ai_model_parameters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ai_model_parameters (parameter_id, parameter_name, parameter_value, description, updated_at) FROM stdin;
\.


--
-- Data for Name: application_answers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.application_answers (answer_id, application_id, question_id, answer_text) FROM stdin;
\.


--
-- Data for Name: application_statuses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.application_statuses (status_id, status_name) FROM stdin;
1	Applied
2	Screening
3	Interview
4	Testing
5	Offer
6	Hired
7	Rejected
\.


--
-- Data for Name: career_paths; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.career_paths (path_id, path_name, description, industry, created_at) FROM stdin;
\.


--
-- Data for Name: career_positions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.career_positions (position_id, path_id, position_name, level, avg_salary_min, avg_salary_max, salary_currency, description, created_at) FROM stdin;
\.


--
-- Data for Name: companies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.companies (company_id, name, description, website_url, logo_url, size, industry, founded_year, headquarters_location, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: company_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.company_users (company_user_id, company_id, user_id, role, is_admin, created_at) FROM stdin;
\.


--
-- Data for Name: conversation_participants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conversation_participants (participant_id, conversation_id, user_id, joined_at, left_at, is_active) FROM stdin;
\.


--
-- Data for Name: conversation_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conversation_types (type_id, type_name) FROM stdin;
1	Direct
2	Group
3	System
4	AI-Assistant
\.


--
-- Data for Name: conversations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conversations (conversation_id, type_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: education; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.education (education_id, user_id, institution_name, degree, field_of_study, start_date, end_date, is_current, description, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: experience; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.experience (experience_id, user_id, company_name, title, location, is_remote, start_date, end_date, is_current, description, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: experience_levels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.experience_levels (level_id, level_name) FROM stdin;
1	Entry-level
2	Mid-level
3	Senior
4	Executive
5	Internship
\.


--
-- Data for Name: interview_feedback; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.interview_feedback (feedback_id, interview_id, given_by_user_id, rating, comments, strengths, weaknesses, recommendation, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: interview_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.interview_types (type_id, type_name) FROM stdin;
1	Phone
2	Video
3	In-person
4	Technical
5	Panel
\.


--
-- Data for Name: interviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.interviews (interview_id, application_id, scheduled_by_user_id, interview_type_id, scheduled_at, duration_minutes, location_or_link, notes, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: job_applications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_applications (application_id, job_id, user_id, cv_id, cover_letter, status_id, match_percentage, applied_at, updated_at) FROM stdin;
\.


--
-- Data for Name: job_skills; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_skills (job_skill_id, job_id, skill_id, importance_level, is_required) FROM stdin;
\.


--
-- Data for Name: job_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_types (job_type_id, type_name) FROM stdin;
1	Full-time
2	Part-time
3	Contract
4	Temporary
5	Internship
6	Freelance
\.


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jobs (job_id, company_id, created_by_user_id, title, description, job_type_id, location_id, location_description, experience_level_id, salary_min, salary_max, salary_currency, is_salary_visible, application_deadline, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.messages (message_id, conversation_id, sender_id, message_text, sent_at, is_read) FROM stdin;
\.


--
-- Data for Name: notification_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notification_types (type_id, type_name, template) FROM stdin;
1	New Message	You have a new message from {{sender}}
2	Job Match	We found a new job match for you: {{job_title}}
3	Application Status	Your application for {{job_title}} has been updated to {{status}}
4	Interview Schedule	You have an interview scheduled for {{job_title}} on {{datetime}}
5	Profile View	Your profile was viewed by {{company}}
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications (notification_id, user_id, type_id, related_id, is_read, created_at) FROM stdin;
\.


--
-- Data for Name: password_resets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.password_resets (reset_id, user_id, token, expires_at, created_at) FROM stdin;
\.


--
-- Data for Name: portfolio_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.portfolio_items (portfolio_id, user_id, title, description, project_url, image_url, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: position_required_skills; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.position_required_skills (position_skill_id, position_id, skill_id, importance_level) FROM stdin;
\.


--
-- Data for Name: screening_questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.screening_questions (question_id, job_id, question_text, is_required, question_order) FROM stdin;
\.


--
-- Data for Name: skill_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.skill_categories (category_id, category_name, description) FROM stdin;
\.


--
-- Data for Name: skill_endorsements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.skill_endorsements (endorsement_id, user_skill_id, endorsed_by_user_id, endorsement_date) FROM stdin;
\.


--
-- Data for Name: skills; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.skills (skill_id, skill_name, category_id, description, is_technical) FROM stdin;
\.


--
-- Data for Name: social_profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.social_profiles (profile_id, user_id, provider, provider_id, profile_url, created_at) FROM stdin;
\.


--
-- Data for Name: user_activities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_activities (activity_id, user_id, activity_type, related_id, metadata, created_at) FROM stdin;
\.


--
-- Data for Name: user_career_paths; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_career_paths (user_path_id, user_id, position_id, is_current, is_goal, created_at) FROM stdin;
\.


--
-- Data for Name: user_cvs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_cvs (cv_id, user_id, file_name, file_url, is_default, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: user_preferences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_preferences (preference_id, user_id, preference_key, preference_value, updated_at) FROM stdin;
\.


--
-- Data for Name: user_skills; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_skills (user_skill_id, user_id, skill_id, proficiency_level, years_experience, is_verified, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: user_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_types (type_id, type_name) FROM stdin;
1	Job Seeker
2	Employer
3	Recruiter
4	Admin
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, user_type_id, email, password_hash, first_name, last_name, phone_number, profile_picture_url, bio, is_verified, is_active, remember_me_token, created_at, updated_at) FROM stdin;
1	1	janedoe@example.com	$2b$10$DcdORkF4dEN3SWjg.zj9a.TzJHG7r/EQJe4P1vEbi9xdU9/v0xkFK	Jane	Doe	+254712345678	https://i.pravatar.cc/150?img=5	Passionate frontend developer looking for remote opportunities.	f	t	\N	2025-04-15 16:07:39.035562+03	2025-04-15 16:07:39.035562+03
\.


--
-- Data for Name: work_locations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.work_locations (location_id, location_type) FROM stdin;
1	Remote
2	On-site
3	Hybrid
\.


--
-- Name: ai_match_feedback_feedback_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ai_match_feedback_feedback_id_seq', 1, false);


--
-- Name: ai_model_parameters_parameter_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ai_model_parameters_parameter_id_seq', 1, false);


--
-- Name: application_answers_answer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.application_answers_answer_id_seq', 1, false);


--
-- Name: application_statuses_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.application_statuses_status_id_seq', 7, true);


--
-- Name: career_paths_path_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.career_paths_path_id_seq', 1, false);


--
-- Name: career_positions_position_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.career_positions_position_id_seq', 1, false);


--
-- Name: companies_company_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.companies_company_id_seq', 1, false);


--
-- Name: company_users_company_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.company_users_company_user_id_seq', 1, false);


--
-- Name: conversation_participants_participant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.conversation_participants_participant_id_seq', 1, false);


--
-- Name: conversation_types_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.conversation_types_type_id_seq', 4, true);


--
-- Name: conversations_conversation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.conversations_conversation_id_seq', 1, false);


--
-- Name: education_education_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.education_education_id_seq', 1, false);


--
-- Name: experience_experience_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.experience_experience_id_seq', 1, false);


--
-- Name: experience_levels_level_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.experience_levels_level_id_seq', 5, true);


--
-- Name: interview_feedback_feedback_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.interview_feedback_feedback_id_seq', 1, false);


--
-- Name: interview_types_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.interview_types_type_id_seq', 5, true);


--
-- Name: interviews_interview_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.interviews_interview_id_seq', 1, false);


--
-- Name: job_applications_application_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.job_applications_application_id_seq', 1, false);


--
-- Name: job_skills_job_skill_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.job_skills_job_skill_id_seq', 1, false);


--
-- Name: job_types_job_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.job_types_job_type_id_seq', 6, true);


--
-- Name: jobs_job_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jobs_job_id_seq', 1, false);


--
-- Name: messages_message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.messages_message_id_seq', 1, false);


--
-- Name: notification_types_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notification_types_type_id_seq', 5, true);


--
-- Name: notifications_notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notifications_notification_id_seq', 1, false);


--
-- Name: password_resets_reset_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.password_resets_reset_id_seq', 1, false);


--
-- Name: portfolio_items_portfolio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.portfolio_items_portfolio_id_seq', 1, false);


--
-- Name: position_required_skills_position_skill_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.position_required_skills_position_skill_id_seq', 1, false);


--
-- Name: screening_questions_question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.screening_questions_question_id_seq', 1, false);


--
-- Name: skill_categories_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.skill_categories_category_id_seq', 1, false);


--
-- Name: skill_endorsements_endorsement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.skill_endorsements_endorsement_id_seq', 1, false);


--
-- Name: skills_skill_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.skills_skill_id_seq', 1, false);


--
-- Name: social_profiles_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.social_profiles_profile_id_seq', 1, false);


--
-- Name: user_activities_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_activities_activity_id_seq', 1, false);


--
-- Name: user_career_paths_user_path_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_career_paths_user_path_id_seq', 1, false);


--
-- Name: user_cvs_cv_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_cvs_cv_id_seq', 1, false);


--
-- Name: user_preferences_preference_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_preferences_preference_id_seq', 1, false);


--
-- Name: user_skills_user_skill_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_skills_user_skill_id_seq', 1, false);


--
-- Name: user_types_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_types_type_id_seq', 4, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 1, true);


--
-- Name: work_locations_location_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.work_locations_location_id_seq', 3, true);


--
-- Name: ai_match_feedback ai_match_feedback_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ai_match_feedback
    ADD CONSTRAINT ai_match_feedback_pkey PRIMARY KEY (feedback_id);


--
-- Name: ai_model_parameters ai_model_parameters_parameter_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ai_model_parameters
    ADD CONSTRAINT ai_model_parameters_parameter_name_key UNIQUE (parameter_name);


--
-- Name: ai_model_parameters ai_model_parameters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ai_model_parameters
    ADD CONSTRAINT ai_model_parameters_pkey PRIMARY KEY (parameter_id);


--
-- Name: application_answers application_answers_application_id_question_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application_answers
    ADD CONSTRAINT application_answers_application_id_question_id_key UNIQUE (application_id, question_id);


--
-- Name: application_answers application_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application_answers
    ADD CONSTRAINT application_answers_pkey PRIMARY KEY (answer_id);


--
-- Name: application_statuses application_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application_statuses
    ADD CONSTRAINT application_statuses_pkey PRIMARY KEY (status_id);


--
-- Name: application_statuses application_statuses_status_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application_statuses
    ADD CONSTRAINT application_statuses_status_name_key UNIQUE (status_name);


--
-- Name: career_paths career_paths_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.career_paths
    ADD CONSTRAINT career_paths_pkey PRIMARY KEY (path_id);


--
-- Name: career_positions career_positions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.career_positions
    ADD CONSTRAINT career_positions_pkey PRIMARY KEY (position_id);


--
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (company_id);


--
-- Name: company_users company_users_company_id_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.company_users
    ADD CONSTRAINT company_users_company_id_user_id_key UNIQUE (company_id, user_id);


--
-- Name: company_users company_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.company_users
    ADD CONSTRAINT company_users_pkey PRIMARY KEY (company_user_id);


--
-- Name: conversation_participants conversation_participants_conversation_id_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversation_participants
    ADD CONSTRAINT conversation_participants_conversation_id_user_id_key UNIQUE (conversation_id, user_id);


--
-- Name: conversation_participants conversation_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversation_participants
    ADD CONSTRAINT conversation_participants_pkey PRIMARY KEY (participant_id);


--
-- Name: conversation_types conversation_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversation_types
    ADD CONSTRAINT conversation_types_pkey PRIMARY KEY (type_id);


--
-- Name: conversation_types conversation_types_type_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversation_types
    ADD CONSTRAINT conversation_types_type_name_key UNIQUE (type_name);


--
-- Name: conversations conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT conversations_pkey PRIMARY KEY (conversation_id);


--
-- Name: education education_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.education
    ADD CONSTRAINT education_pkey PRIMARY KEY (education_id);


--
-- Name: experience_levels experience_levels_level_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.experience_levels
    ADD CONSTRAINT experience_levels_level_name_key UNIQUE (level_name);


--
-- Name: experience_levels experience_levels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.experience_levels
    ADD CONSTRAINT experience_levels_pkey PRIMARY KEY (level_id);


--
-- Name: experience experience_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.experience
    ADD CONSTRAINT experience_pkey PRIMARY KEY (experience_id);


--
-- Name: interview_feedback interview_feedback_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interview_feedback
    ADD CONSTRAINT interview_feedback_pkey PRIMARY KEY (feedback_id);


--
-- Name: interview_types interview_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interview_types
    ADD CONSTRAINT interview_types_pkey PRIMARY KEY (type_id);


--
-- Name: interview_types interview_types_type_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interview_types
    ADD CONSTRAINT interview_types_type_name_key UNIQUE (type_name);


--
-- Name: interviews interviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interviews
    ADD CONSTRAINT interviews_pkey PRIMARY KEY (interview_id);


--
-- Name: job_applications job_applications_job_id_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_applications
    ADD CONSTRAINT job_applications_job_id_user_id_key UNIQUE (job_id, user_id);


--
-- Name: job_applications job_applications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_applications
    ADD CONSTRAINT job_applications_pkey PRIMARY KEY (application_id);


--
-- Name: job_skills job_skills_job_id_skill_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_skills
    ADD CONSTRAINT job_skills_job_id_skill_id_key UNIQUE (job_id, skill_id);


--
-- Name: job_skills job_skills_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_skills
    ADD CONSTRAINT job_skills_pkey PRIMARY KEY (job_skill_id);


--
-- Name: job_types job_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_types
    ADD CONSTRAINT job_types_pkey PRIMARY KEY (job_type_id);


--
-- Name: job_types job_types_type_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_types
    ADD CONSTRAINT job_types_type_name_key UNIQUE (type_name);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (job_id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (message_id);


--
-- Name: notification_types notification_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_types
    ADD CONSTRAINT notification_types_pkey PRIMARY KEY (type_id);


--
-- Name: notification_types notification_types_type_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_types
    ADD CONSTRAINT notification_types_type_name_key UNIQUE (type_name);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (notification_id);


--
-- Name: password_resets password_resets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_resets
    ADD CONSTRAINT password_resets_pkey PRIMARY KEY (reset_id);


--
-- Name: portfolio_items portfolio_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.portfolio_items
    ADD CONSTRAINT portfolio_items_pkey PRIMARY KEY (portfolio_id);


--
-- Name: position_required_skills position_required_skills_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.position_required_skills
    ADD CONSTRAINT position_required_skills_pkey PRIMARY KEY (position_skill_id);


--
-- Name: position_required_skills position_required_skills_position_id_skill_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.position_required_skills
    ADD CONSTRAINT position_required_skills_position_id_skill_id_key UNIQUE (position_id, skill_id);


--
-- Name: screening_questions screening_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.screening_questions
    ADD CONSTRAINT screening_questions_pkey PRIMARY KEY (question_id);


--
-- Name: skill_categories skill_categories_category_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skill_categories
    ADD CONSTRAINT skill_categories_category_name_key UNIQUE (category_name);


--
-- Name: skill_categories skill_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skill_categories
    ADD CONSTRAINT skill_categories_pkey PRIMARY KEY (category_id);


--
-- Name: skill_endorsements skill_endorsements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skill_endorsements
    ADD CONSTRAINT skill_endorsements_pkey PRIMARY KEY (endorsement_id);


--
-- Name: skill_endorsements skill_endorsements_user_skill_id_endorsed_by_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skill_endorsements
    ADD CONSTRAINT skill_endorsements_user_skill_id_endorsed_by_user_id_key UNIQUE (user_skill_id, endorsed_by_user_id);


--
-- Name: skills skills_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_pkey PRIMARY KEY (skill_id);


--
-- Name: skills skills_skill_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_skill_name_key UNIQUE (skill_name);


--
-- Name: social_profiles social_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.social_profiles
    ADD CONSTRAINT social_profiles_pkey PRIMARY KEY (profile_id);


--
-- Name: social_profiles social_profiles_user_id_provider_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.social_profiles
    ADD CONSTRAINT social_profiles_user_id_provider_key UNIQUE (user_id, provider);


--
-- Name: user_activities user_activities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_activities
    ADD CONSTRAINT user_activities_pkey PRIMARY KEY (activity_id);


--
-- Name: user_career_paths user_career_paths_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_career_paths
    ADD CONSTRAINT user_career_paths_pkey PRIMARY KEY (user_path_id);


--
-- Name: user_career_paths user_career_paths_user_id_position_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_career_paths
    ADD CONSTRAINT user_career_paths_user_id_position_id_key UNIQUE (user_id, position_id);


--
-- Name: user_cvs user_cvs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_cvs
    ADD CONSTRAINT user_cvs_pkey PRIMARY KEY (cv_id);


--
-- Name: user_preferences user_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_preferences
    ADD CONSTRAINT user_preferences_pkey PRIMARY KEY (preference_id);


--
-- Name: user_preferences user_preferences_user_id_preference_key_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_preferences
    ADD CONSTRAINT user_preferences_user_id_preference_key_key UNIQUE (user_id, preference_key);


--
-- Name: user_skills user_skills_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_skills
    ADD CONSTRAINT user_skills_pkey PRIMARY KEY (user_skill_id);


--
-- Name: user_skills user_skills_user_id_skill_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_skills
    ADD CONSTRAINT user_skills_user_id_skill_id_key UNIQUE (user_id, skill_id);


--
-- Name: user_types user_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_types
    ADD CONSTRAINT user_types_pkey PRIMARY KEY (type_id);


--
-- Name: user_types user_types_type_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_types
    ADD CONSTRAINT user_types_type_name_key UNIQUE (type_name);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: work_locations work_locations_location_type_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.work_locations
    ADD CONSTRAINT work_locations_location_type_key UNIQUE (location_type);


--
-- Name: work_locations work_locations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.work_locations
    ADD CONSTRAINT work_locations_pkey PRIMARY KEY (location_id);


--
-- Name: ai_match_feedback ai_match_feedback_job_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ai_match_feedback
    ADD CONSTRAINT ai_match_feedback_job_id_fkey FOREIGN KEY (job_id) REFERENCES public.jobs(job_id);


--
-- Name: ai_match_feedback ai_match_feedback_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ai_match_feedback
    ADD CONSTRAINT ai_match_feedback_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: application_answers application_answers_application_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application_answers
    ADD CONSTRAINT application_answers_application_id_fkey FOREIGN KEY (application_id) REFERENCES public.job_applications(application_id);


--
-- Name: application_answers application_answers_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application_answers
    ADD CONSTRAINT application_answers_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.screening_questions(question_id);


--
-- Name: career_positions career_positions_path_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.career_positions
    ADD CONSTRAINT career_positions_path_id_fkey FOREIGN KEY (path_id) REFERENCES public.career_paths(path_id);


--
-- Name: company_users company_users_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.company_users
    ADD CONSTRAINT company_users_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(company_id);


--
-- Name: company_users company_users_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.company_users
    ADD CONSTRAINT company_users_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: conversation_participants conversation_participants_conversation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversation_participants
    ADD CONSTRAINT conversation_participants_conversation_id_fkey FOREIGN KEY (conversation_id) REFERENCES public.conversations(conversation_id);


--
-- Name: conversation_participants conversation_participants_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversation_participants
    ADD CONSTRAINT conversation_participants_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: conversations conversations_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT conversations_type_id_fkey FOREIGN KEY (type_id) REFERENCES public.conversation_types(type_id);


--
-- Name: education education_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.education
    ADD CONSTRAINT education_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: experience experience_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.experience
    ADD CONSTRAINT experience_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: interview_feedback interview_feedback_given_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interview_feedback
    ADD CONSTRAINT interview_feedback_given_by_user_id_fkey FOREIGN KEY (given_by_user_id) REFERENCES public.users(user_id);


--
-- Name: interview_feedback interview_feedback_interview_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interview_feedback
    ADD CONSTRAINT interview_feedback_interview_id_fkey FOREIGN KEY (interview_id) REFERENCES public.interviews(interview_id);


--
-- Name: interviews interviews_application_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interviews
    ADD CONSTRAINT interviews_application_id_fkey FOREIGN KEY (application_id) REFERENCES public.job_applications(application_id);


--
-- Name: interviews interviews_interview_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interviews
    ADD CONSTRAINT interviews_interview_type_id_fkey FOREIGN KEY (interview_type_id) REFERENCES public.interview_types(type_id);


--
-- Name: interviews interviews_scheduled_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interviews
    ADD CONSTRAINT interviews_scheduled_by_user_id_fkey FOREIGN KEY (scheduled_by_user_id) REFERENCES public.users(user_id);


--
-- Name: job_applications job_applications_cv_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_applications
    ADD CONSTRAINT job_applications_cv_id_fkey FOREIGN KEY (cv_id) REFERENCES public.user_cvs(cv_id);


--
-- Name: job_applications job_applications_job_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_applications
    ADD CONSTRAINT job_applications_job_id_fkey FOREIGN KEY (job_id) REFERENCES public.jobs(job_id);


--
-- Name: job_applications job_applications_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_applications
    ADD CONSTRAINT job_applications_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.application_statuses(status_id);


--
-- Name: job_applications job_applications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_applications
    ADD CONSTRAINT job_applications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: job_skills job_skills_job_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_skills
    ADD CONSTRAINT job_skills_job_id_fkey FOREIGN KEY (job_id) REFERENCES public.jobs(job_id);


--
-- Name: job_skills job_skills_skill_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_skills
    ADD CONSTRAINT job_skills_skill_id_fkey FOREIGN KEY (skill_id) REFERENCES public.skills(skill_id);


--
-- Name: jobs jobs_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(company_id);


--
-- Name: jobs jobs_created_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_created_by_user_id_fkey FOREIGN KEY (created_by_user_id) REFERENCES public.users(user_id);


--
-- Name: jobs jobs_experience_level_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_experience_level_id_fkey FOREIGN KEY (experience_level_id) REFERENCES public.experience_levels(level_id);


--
-- Name: jobs jobs_job_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_job_type_id_fkey FOREIGN KEY (job_type_id) REFERENCES public.job_types(job_type_id);


--
-- Name: jobs jobs_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.work_locations(location_id);


--
-- Name: messages messages_conversation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_conversation_id_fkey FOREIGN KEY (conversation_id) REFERENCES public.conversations(conversation_id);


--
-- Name: messages messages_sender_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_sender_id_fkey FOREIGN KEY (sender_id) REFERENCES public.users(user_id);


--
-- Name: notifications notifications_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_type_id_fkey FOREIGN KEY (type_id) REFERENCES public.notification_types(type_id);


--
-- Name: notifications notifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: password_resets password_resets_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_resets
    ADD CONSTRAINT password_resets_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: portfolio_items portfolio_items_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.portfolio_items
    ADD CONSTRAINT portfolio_items_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: position_required_skills position_required_skills_position_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.position_required_skills
    ADD CONSTRAINT position_required_skills_position_id_fkey FOREIGN KEY (position_id) REFERENCES public.career_positions(position_id);


--
-- Name: position_required_skills position_required_skills_skill_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.position_required_skills
    ADD CONSTRAINT position_required_skills_skill_id_fkey FOREIGN KEY (skill_id) REFERENCES public.skills(skill_id);


--
-- Name: screening_questions screening_questions_job_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.screening_questions
    ADD CONSTRAINT screening_questions_job_id_fkey FOREIGN KEY (job_id) REFERENCES public.jobs(job_id);


--
-- Name: skill_endorsements skill_endorsements_endorsed_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skill_endorsements
    ADD CONSTRAINT skill_endorsements_endorsed_by_user_id_fkey FOREIGN KEY (endorsed_by_user_id) REFERENCES public.users(user_id);


--
-- Name: skill_endorsements skill_endorsements_user_skill_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skill_endorsements
    ADD CONSTRAINT skill_endorsements_user_skill_id_fkey FOREIGN KEY (user_skill_id) REFERENCES public.user_skills(user_skill_id);


--
-- Name: skills skills_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.skill_categories(category_id);


--
-- Name: social_profiles social_profiles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.social_profiles
    ADD CONSTRAINT social_profiles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: user_activities user_activities_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_activities
    ADD CONSTRAINT user_activities_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: user_career_paths user_career_paths_position_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_career_paths
    ADD CONSTRAINT user_career_paths_position_id_fkey FOREIGN KEY (position_id) REFERENCES public.career_positions(position_id);


--
-- Name: user_career_paths user_career_paths_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_career_paths
    ADD CONSTRAINT user_career_paths_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: user_cvs user_cvs_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_cvs
    ADD CONSTRAINT user_cvs_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: user_preferences user_preferences_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_preferences
    ADD CONSTRAINT user_preferences_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: user_skills user_skills_skill_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_skills
    ADD CONSTRAINT user_skills_skill_id_fkey FOREIGN KEY (skill_id) REFERENCES public.skills(skill_id);


--
-- Name: user_skills user_skills_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_skills
    ADD CONSTRAINT user_skills_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: users users_user_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_user_type_id_fkey FOREIGN KEY (user_type_id) REFERENCES public.user_types(type_id);


--
-- PostgreSQL database dump complete
--

