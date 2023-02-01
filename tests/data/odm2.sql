--
-- PostgreSQL database dump
--

-- Dumped from database version 12.4
-- Dumped by pg_dump version 15.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: odm2; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA odm2;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: actionannotations; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.actionannotations (
    bridgeid integer NOT NULL,
    actionid integer NOT NULL,
    annotationid integer NOT NULL
);


--
-- Name: actionannotations_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.actionannotations_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: actionannotations_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.actionannotations_bridgeid_seq OWNED BY odm2.actionannotations.bridgeid;


--
-- Name: actionby; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.actionby (
    bridgeid integer NOT NULL,
    actionid integer NOT NULL,
    affiliationid integer NOT NULL,
    isactionlead boolean NOT NULL,
    roledescription character varying(5000)
);


--
-- Name: actionby_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.actionby_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: actionby_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.actionby_bridgeid_seq OWNED BY odm2.actionby.bridgeid;


--
-- Name: actiondirectives; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.actiondirectives (
    bridgeid integer NOT NULL,
    actionid integer NOT NULL,
    directiveid integer NOT NULL
);


--
-- Name: actiondirectives_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.actiondirectives_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: actiondirectives_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.actiondirectives_bridgeid_seq OWNED BY odm2.actiondirectives.bridgeid;


--
-- Name: actionextensionpropertyvalues; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.actionextensionpropertyvalues (
    bridgeid integer NOT NULL,
    actionid integer NOT NULL,
    propertyid integer NOT NULL,
    propertyvalue character varying(255) NOT NULL
);


--
-- Name: actionextensionpropertyvalues_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.actionextensionpropertyvalues_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: actionextensionpropertyvalues_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.actionextensionpropertyvalues_bridgeid_seq OWNED BY odm2.actionextensionpropertyvalues.bridgeid;


--
-- Name: actions; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.actions (
    actionid integer NOT NULL,
    actiontypecv character varying(255) NOT NULL,
    methodid integer NOT NULL,
    begindatetime timestamp without time zone NOT NULL,
    begindatetimeutcoffset integer NOT NULL,
    enddatetime timestamp without time zone,
    enddatetimeutcoffset integer,
    actiondescription character varying(5000),
    actionfilelink character varying(255)
);


--
-- Name: actions_actionid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.actions_actionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: actions_actionid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.actions_actionid_seq OWNED BY odm2.actions.actionid;


--
-- Name: affiliations; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.affiliations (
    affiliationid integer NOT NULL,
    personid integer NOT NULL,
    organizationid integer,
    isprimaryorganizationcontact boolean,
    affiliationstartdate date NOT NULL,
    affiliationenddate date,
    primaryphone character varying(50),
    primaryemail character varying(255) NOT NULL,
    primaryaddress character varying(255),
    personlink character varying(255)
);


--
-- Name: affiliations_affiliationid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.affiliations_affiliationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: affiliations_affiliationid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.affiliations_affiliationid_seq OWNED BY odm2.affiliations.affiliationid;


--
-- Name: annotations; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.annotations (
    annotationid integer NOT NULL,
    annotationtypecv character varying(255) NOT NULL,
    annotationcode character varying(50),
    annotationtext character varying(500) NOT NULL,
    annotationdatetime timestamp without time zone,
    annotationutcoffset integer,
    annotationlink character varying(255),
    annotatorid integer,
    citationid integer,
    annotationjson json
);


--
-- Name: annotations_annotationid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.annotations_annotationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: annotations_annotationid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.annotations_annotationid_seq OWNED BY odm2.annotations.annotationid;


--
-- Name: authorlists; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.authorlists (
    bridgeid integer NOT NULL,
    citationid integer NOT NULL,
    personid integer NOT NULL,
    authororder integer NOT NULL
);


--
-- Name: authorlists_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.authorlists_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: authorlists_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.authorlists_bridgeid_seq OWNED BY odm2.authorlists.bridgeid;


--
-- Name: calibrationactions; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.calibrationactions (
    actionid integer NOT NULL,
    calibrationcheckvalue double precision,
    instrumentoutputvariableid integer NOT NULL,
    calibrationequation character varying(255)
);


--
-- Name: calibrationreferenceequipment; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.calibrationreferenceequipment (
    bridgeid integer NOT NULL,
    actionid integer NOT NULL,
    equipmentid integer NOT NULL
);


--
-- Name: calibrationreferenceequipment_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.calibrationreferenceequipment_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: calibrationreferenceequipment_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.calibrationreferenceequipment_bridgeid_seq OWNED BY odm2.calibrationreferenceequipment.bridgeid;


--
-- Name: calibrationstandards; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.calibrationstandards (
    bridgeid integer NOT NULL,
    actionid integer NOT NULL,
    referencematerialid integer NOT NULL
);


--
-- Name: calibrationstandards_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.calibrationstandards_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: calibrationstandards_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.calibrationstandards_bridgeid_seq OWNED BY odm2.calibrationstandards.bridgeid;


--
-- Name: categoricalresults; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.categoricalresults (
    resultid bigint NOT NULL,
    xlocation double precision,
    xlocationunitsid integer,
    ylocation double precision,
    ylocationunitsid integer,
    zlocation double precision,
    zlocationunitsid integer,
    spatialreferenceid integer,
    qualitycodecv character varying(255) NOT NULL
);


--
-- Name: categoricalresultvalueannotations; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.categoricalresultvalueannotations (
    bridgeid integer NOT NULL,
    valueid bigint NOT NULL,
    annotationid integer NOT NULL
);


--
-- Name: categoricalresultvalueannotations_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.categoricalresultvalueannotations_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categoricalresultvalueannotations_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.categoricalresultvalueannotations_bridgeid_seq OWNED BY odm2.categoricalresultvalueannotations.bridgeid;


--
-- Name: categoricalresultvalues; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.categoricalresultvalues (
    valueid bigint NOT NULL,
    resultid bigint NOT NULL,
    datavalue character varying(255) NOT NULL,
    valuedatetime timestamp without time zone NOT NULL,
    valuedatetimeutcoffset integer NOT NULL
);


--
-- Name: categoricalresultvalues_valueid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.categoricalresultvalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categoricalresultvalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.categoricalresultvalues_valueid_seq OWNED BY odm2.categoricalresultvalues.valueid;


--
-- Name: citationextensionpropertyvalues; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.citationextensionpropertyvalues (
    bridgeid integer NOT NULL,
    citationid integer NOT NULL,
    propertyid integer NOT NULL,
    propertyvalue character varying(255) NOT NULL
);


--
-- Name: citationextensionpropertyvalues_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.citationextensionpropertyvalues_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: citationextensionpropertyvalues_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.citationextensionpropertyvalues_bridgeid_seq OWNED BY odm2.citationextensionpropertyvalues.bridgeid;


--
-- Name: citationexternalidentifiers; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.citationexternalidentifiers (
    bridgeid integer NOT NULL,
    citationid integer NOT NULL,
    externalidentifiersystemid integer NOT NULL,
    citationexternalidentifier character varying(255) NOT NULL,
    citationexternalidentifieruri character varying(255)
);


--
-- Name: citationexternalidentifiers_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.citationexternalidentifiers_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: citationexternalidentifiers_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.citationexternalidentifiers_bridgeid_seq OWNED BY odm2.citationexternalidentifiers.bridgeid;


--
-- Name: citations; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.citations (
    citationid integer NOT NULL,
    title character varying(255) NOT NULL,
    publisher character varying(255) NOT NULL,
    publicationyear integer NOT NULL,
    citationlink character varying(255)
);


--
-- Name: citations_citationid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.citations_citationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: citations_citationid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.citations_citationid_seq OWNED BY odm2.citations.citationid;


--
-- Name: cv_actiontype; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.cv_actiontype (
    term character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    definition character varying(5000),
    category character varying(255),
    sourcevocabularyuri character varying(255)
);


--
-- Name: cv_aggregationstatistic; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.cv_aggregationstatistic (
    term character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    definition character varying(5000),
    category character varying(255),
    sourcevocabularyuri character varying(255)
);


--
-- Name: cv_annotationtype; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.cv_annotationtype (
    term character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    definition character varying(5000),
    category character varying(255),
    sourcevocabularyuri character varying(255)
);


--
-- Name: cv_censorcode; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.cv_censorcode (
    term character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    definition character varying(5000),
    category character varying(255),
    sourcevocabularyuri character varying(255)
);


--
-- Name: cv_dataqualitytype; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.cv_dataqualitytype (
    term character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    definition character varying(5000),
    category character varying(255),
    sourcevocabularyuri character varying(255)
);


--
-- Name: cv_datasettype; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.cv_datasettype (
    term character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    definition character varying(5000),
    category character varying(255),
    sourcevocabularyuri character varying(255)
);


--
-- Name: cv_directivetype; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.cv_directivetype (
    term character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    definition character varying(5000),
    category character varying(255),
    sourcevocabularyuri character varying(255)
);


--
-- Name: cv_elevationdatum; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.cv_elevationdatum (
    term character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    definition character varying(5000),
    category character varying(255),
    sourcevocabularyuri character varying(255)
);


--
-- Name: cv_equipmenttype; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.cv_equipmenttype (
    term character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    definition character varying(5000),
    category character varying(255),
    sourcevocabularyuri character varying(255)
);


--
-- Name: cv_medium; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.cv_medium (
    term character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    definition character varying(5000),
    category character varying(255),
    sourcevocabularyuri character varying(255)
);


--
-- Name: cv_methodtype; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.cv_methodtype (
    term character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    definition character varying(5000),
    category character varying(255),
    sourcevocabularyuri character varying(255)
);


--
-- Name: cv_organizationtype; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.cv_organizationtype (
    term character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    definition character varying(5000),
    category character varying(255),
    sourcevocabularyuri character varying(255)
);


--
-- Name: cv_propertydatatype; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.cv_propertydatatype (
    term character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    definition character varying(5000),
    category character varying(255),
    sourcevocabularyuri character varying(255)
);


--
-- Name: cv_qualitycode; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.cv_qualitycode (
    term character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    definition character varying(5000),
    category character varying(255),
    sourcevocabularyuri character varying(255)
);


--
-- Name: cv_relationshiptype; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.cv_relationshiptype (
    term character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    definition character varying(5000),
    category character varying(255),
    sourcevocabularyuri character varying(255)
);


--
-- Name: cv_resulttype; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.cv_resulttype (
    term character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    definition character varying(5000),
    category character varying(255),
    sourcevocabularyuri character varying(255)
);


--
-- Name: cv_samplingfeaturegeotype; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.cv_samplingfeaturegeotype (
    term character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    definition character varying(5000),
    category character varying(255),
    sourcevocabularyuri character varying(255)
);


--
-- Name: cv_samplingfeaturetype; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.cv_samplingfeaturetype (
    term character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    definition character varying(5000),
    category character varying(255),
    sourcevocabularyuri character varying(255)
);


--
-- Name: cv_sitetype; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.cv_sitetype (
    term character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    definition character varying(5000),
    category character varying(255),
    sourcevocabularyuri character varying(255)
);


--
-- Name: cv_spatialoffsettype; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.cv_spatialoffsettype (
    term character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    definition character varying(5000),
    category character varying(255),
    sourcevocabularyuri character varying(255)
);


--
-- Name: cv_speciation; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.cv_speciation (
    term character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    definition character varying(5000),
    category character varying(255),
    sourcevocabularyuri character varying(255)
);


--
-- Name: cv_specimentype; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.cv_specimentype (
    term character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    definition character varying(5000),
    category character varying(255),
    sourcevocabularyuri character varying(255)
);


--
-- Name: cv_status; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.cv_status (
    term character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    definition character varying(5000),
    category character varying(255),
    sourcevocabularyuri character varying(255)
);


--
-- Name: cv_taxonomicclassifiertype; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.cv_taxonomicclassifiertype (
    term character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    definition character varying(5000),
    category character varying(255),
    sourcevocabularyuri character varying(255)
);


--
-- Name: cv_unitstype; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.cv_unitstype (
    term character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    definition character varying(5000),
    category character varying(255),
    sourcevocabularyuri character varying(255)
);


--
-- Name: cv_variablename; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.cv_variablename (
    term character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    definition character varying(5000),
    category character varying(255),
    sourcevocabularyuri character varying(255)
);


--
-- Name: cv_variabletype; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.cv_variabletype (
    term character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    definition character varying(5000),
    category character varying(255),
    sourcevocabularyuri character varying(255)
);


--
-- Name: dataloggerfilecolumns; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.dataloggerfilecolumns (
    dataloggerfilecolumnid integer NOT NULL,
    resultid bigint,
    dataloggerfileid integer NOT NULL,
    instrumentoutputvariableid integer NOT NULL,
    columnlabel character varying(50) NOT NULL,
    columndescription character varying(5000),
    measurementequation character varying(255),
    scaninterval double precision,
    scanintervalunitsid integer,
    recordinginterval double precision,
    recordingintervalunitsid integer,
    aggregationstatisticcv character varying(255)
);


--
-- Name: dataloggerfilecolumns_dataloggerfilecolumnid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.dataloggerfilecolumns_dataloggerfilecolumnid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dataloggerfilecolumns_dataloggerfilecolumnid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.dataloggerfilecolumns_dataloggerfilecolumnid_seq OWNED BY odm2.dataloggerfilecolumns.dataloggerfilecolumnid;


--
-- Name: dataloggerfiles; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.dataloggerfiles (
    dataloggerfileid integer NOT NULL,
    programid integer NOT NULL,
    dataloggerfilename character varying(255) NOT NULL,
    dataloggerfiledescription character varying(5000),
    dataloggerfilelink character varying(255)
);


--
-- Name: dataloggerfiles_dataloggerfileid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.dataloggerfiles_dataloggerfileid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dataloggerfiles_dataloggerfileid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.dataloggerfiles_dataloggerfileid_seq OWNED BY odm2.dataloggerfiles.dataloggerfileid;


--
-- Name: dataloggerprogramfiles; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.dataloggerprogramfiles (
    programid integer NOT NULL,
    affiliationid integer NOT NULL,
    programname character varying(255) NOT NULL,
    programdescription character varying(5000),
    programversion character varying(50),
    programfilelink character varying(255)
);


--
-- Name: dataloggerprogramfiles_programid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.dataloggerprogramfiles_programid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dataloggerprogramfiles_programid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.dataloggerprogramfiles_programid_seq OWNED BY odm2.dataloggerprogramfiles.programid;


--
-- Name: dataquality; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.dataquality (
    dataqualityid integer NOT NULL,
    dataqualitytypecv character varying(255) NOT NULL,
    dataqualitycode character varying(255) NOT NULL,
    dataqualityvalue double precision,
    dataqualityvalueunitsid integer,
    dataqualitydescription character varying(5000),
    dataqualitylink character varying(255)
);


--
-- Name: dataquality_dataqualityid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.dataquality_dataqualityid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dataquality_dataqualityid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.dataquality_dataqualityid_seq OWNED BY odm2.dataquality.dataqualityid;


--
-- Name: datasetcitations; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.datasetcitations (
    bridgeid integer NOT NULL,
    datasetid integer NOT NULL,
    relationshiptypecv character varying(255) NOT NULL,
    citationid integer NOT NULL
);


--
-- Name: datasetcitations_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.datasetcitations_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: datasetcitations_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.datasetcitations_bridgeid_seq OWNED BY odm2.datasetcitations.bridgeid;


--
-- Name: datasets; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.datasets (
    datasetid integer NOT NULL,
    datasetuuid uuid NOT NULL,
    datasettypecv character varying(255) NOT NULL,
    datasetcode character varying(50) NOT NULL,
    datasettitle character varying(255) NOT NULL,
    datasetabstract character varying(5000) NOT NULL
);


--
-- Name: datasets_datasetid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.datasets_datasetid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: datasets_datasetid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.datasets_datasetid_seq OWNED BY odm2.datasets.datasetid;


--
-- Name: datasetsresults; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.datasetsresults (
    bridgeid integer NOT NULL,
    datasetid integer NOT NULL,
    resultid bigint NOT NULL
);


--
-- Name: datasetsresults_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.datasetsresults_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: datasetsresults_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.datasetsresults_bridgeid_seq OWNED BY odm2.datasetsresults.bridgeid;


--
-- Name: derivationequations; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.derivationequations (
    derivationequationid integer NOT NULL,
    derivationequation character varying(255) NOT NULL
);


--
-- Name: derivationequations_derivationequationid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.derivationequations_derivationequationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: derivationequations_derivationequationid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.derivationequations_derivationequationid_seq OWNED BY odm2.derivationequations.derivationequationid;


--
-- Name: directives; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.directives (
    directiveid integer NOT NULL,
    directivetypecv character varying(255) NOT NULL,
    directivedescription character varying(5000) NOT NULL,
    directivename character varying(255),
    onumbers character varying(255)
);


--
-- Name: directives_directiveid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.directives_directiveid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: directives_directiveid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.directives_directiveid_seq OWNED BY odm2.directives.directiveid;


--
-- Name: equipment; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.equipment (
    equipmentid integer NOT NULL,
    equipmentcode character varying(50) NOT NULL,
    equipmentname character varying(255) NOT NULL,
    equipmenttypecv character varying(255) NOT NULL,
    equipmentmodelid integer NOT NULL,
    equipmentserialnumber character varying(50) NOT NULL,
    equipmentownerid integer NOT NULL,
    equipmentvendorid integer NOT NULL,
    equipmentpurchasedate timestamp without time zone NOT NULL,
    equipmentpurchaseordernumber character varying(50),
    equipmentdescription character varying(5000),
    equipmentdocumentationlink character varying(255)
);


--
-- Name: equipment_equipmentid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.equipment_equipmentid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: equipment_equipmentid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.equipment_equipmentid_seq OWNED BY odm2.equipment.equipmentid;


--
-- Name: equipmentannotations; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.equipmentannotations (
    bridgeid integer NOT NULL,
    equipmentid integer NOT NULL,
    annotationid integer NOT NULL
);


--
-- Name: equipmentannotations_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.equipmentannotations_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: equipmentannotations_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.equipmentannotations_bridgeid_seq OWNED BY odm2.equipmentannotations.bridgeid;


--
-- Name: equipmentmodels; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.equipmentmodels (
    equipmentmodelid integer NOT NULL,
    modelmanufacturerid integer NOT NULL,
    modelpartnumber character varying(50),
    modelname character varying(255) NOT NULL,
    modeldescription character varying(5000),
    isinstrument boolean NOT NULL,
    modelspecificationsfilelink character varying(255),
    modellink character varying(255)
);


--
-- Name: equipmentmodels_equipmentmodelid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.equipmentmodels_equipmentmodelid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: equipmentmodels_equipmentmodelid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.equipmentmodels_equipmentmodelid_seq OWNED BY odm2.equipmentmodels.equipmentmodelid;


--
-- Name: equipmentused; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.equipmentused (
    bridgeid integer NOT NULL,
    actionid integer NOT NULL,
    equipmentid integer NOT NULL
);


--
-- Name: equipmentused_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.equipmentused_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: equipmentused_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.equipmentused_bridgeid_seq OWNED BY odm2.equipmentused.bridgeid;


--
-- Name: extensionproperties; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.extensionproperties (
    propertyid integer NOT NULL,
    propertyname character varying(255) NOT NULL,
    propertydescription character varying(5000),
    propertydatatypecv character varying(255) NOT NULL,
    propertyunitsid integer
);


--
-- Name: extensionproperties_propertyid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.extensionproperties_propertyid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: extensionproperties_propertyid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.extensionproperties_propertyid_seq OWNED BY odm2.extensionproperties.propertyid;


--
-- Name: externalidentifiersystems; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.externalidentifiersystems (
    externalidentifiersystemid integer NOT NULL,
    externalidentifiersystemname character varying(255) NOT NULL,
    identifiersystemorganizationid integer NOT NULL,
    externalidentifiersystemdescription character varying(5000),
    externalidentifiersystemurl character varying(255)
);


--
-- Name: externalidentifiersystems_externalidentifiersystemid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.externalidentifiersystems_externalidentifiersystemid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: externalidentifiersystems_externalidentifiersystemid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.externalidentifiersystems_externalidentifiersystemid_seq OWNED BY odm2.externalidentifiersystems.externalidentifiersystemid;


--
-- Name: featureactions; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.featureactions (
    featureactionid integer NOT NULL,
    samplingfeatureid integer NOT NULL,
    actionid integer NOT NULL
);


--
-- Name: featureactions_featureactionid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.featureactions_featureactionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: featureactions_featureactionid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.featureactions_featureactionid_seq OWNED BY odm2.featureactions.featureactionid;


--
-- Name: instrumentoutputvariables; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.instrumentoutputvariables (
    instrumentoutputvariableid integer NOT NULL,
    modelid integer NOT NULL,
    variableid integer NOT NULL,
    instrumentmethodid integer NOT NULL,
    instrumentresolution character varying(255),
    instrumentaccuracy character varying(255),
    instrumentrawoutputunitsid integer NOT NULL
);


--
-- Name: instrumentoutputvariables_instrumentoutputvariableid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.instrumentoutputvariables_instrumentoutputvariableid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: instrumentoutputvariables_instrumentoutputvariableid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.instrumentoutputvariables_instrumentoutputvariableid_seq OWNED BY odm2.instrumentoutputvariables.instrumentoutputvariableid;


--
-- Name: kafka_records; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.kafka_records (
    topic text NOT NULL,
    key text NOT NULL,
    payload json NOT NULL
);


--
-- Name: maintenanceactions; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.maintenanceactions (
    actionid integer NOT NULL,
    isfactoryservice boolean NOT NULL,
    maintenancecode character varying(50),
    maintenancereason character varying(500)
);


--
-- Name: measurementresults; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.measurementresults (
    resultid bigint NOT NULL,
    xlocation double precision,
    xlocationunitsid integer,
    ylocation double precision,
    ylocationunitsid integer,
    zlocation double precision,
    zlocationunitsid integer,
    spatialreferenceid integer,
    censorcodecv character varying(255) NOT NULL,
    qualitycodecv character varying(255) NOT NULL,
    aggregationstatisticcv character varying(255) NOT NULL,
    timeaggregationinterval double precision NOT NULL,
    timeaggregationintervalunitsid integer NOT NULL
);


--
-- Name: measurementresultvalueannotations; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.measurementresultvalueannotations (
    bridgeid integer NOT NULL,
    valueid bigint NOT NULL,
    annotationid integer NOT NULL
);


--
-- Name: measurementresultvalueannotations_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.measurementresultvalueannotations_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: measurementresultvalueannotations_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.measurementresultvalueannotations_bridgeid_seq OWNED BY odm2.measurementresultvalueannotations.bridgeid;


--
-- Name: measurementresultvalues; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.measurementresultvalues (
    valueid bigint NOT NULL,
    resultid bigint NOT NULL,
    datavalue double precision NOT NULL,
    valuedatetime timestamp without time zone NOT NULL,
    valuedatetimeutcoffset integer NOT NULL
);


--
-- Name: measurementresultvalues_valueid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.measurementresultvalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: measurementresultvalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.measurementresultvalues_valueid_seq OWNED BY odm2.measurementresultvalues.valueid;


--
-- Name: methodannotations; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.methodannotations (
    bridgeid integer NOT NULL,
    methodid integer NOT NULL,
    annotationid integer NOT NULL
);


--
-- Name: methodannotations_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.methodannotations_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: methodannotations_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.methodannotations_bridgeid_seq OWNED BY odm2.methodannotations.bridgeid;


--
-- Name: methodcitations; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.methodcitations (
    bridgeid integer NOT NULL,
    methodid integer NOT NULL,
    relationshiptypecv character varying(255) NOT NULL,
    citationid integer NOT NULL
);


--
-- Name: methodcitations_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.methodcitations_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: methodcitations_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.methodcitations_bridgeid_seq OWNED BY odm2.methodcitations.bridgeid;


--
-- Name: methodextensionpropertyvalues; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.methodextensionpropertyvalues (
    bridgeid integer NOT NULL,
    methodid integer NOT NULL,
    propertyid integer NOT NULL,
    propertyvalue character varying(255) NOT NULL
);


--
-- Name: methodextensionpropertyvalues_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.methodextensionpropertyvalues_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: methodextensionpropertyvalues_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.methodextensionpropertyvalues_bridgeid_seq OWNED BY odm2.methodextensionpropertyvalues.bridgeid;


--
-- Name: methodexternalidentifiers; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.methodexternalidentifiers (
    bridgeid integer NOT NULL,
    methodid integer NOT NULL,
    externalidentifiersystemid integer NOT NULL,
    methodexternalidentifier character varying(255) NOT NULL,
    methodexternalidentifieruri character varying(255)
);


--
-- Name: methodexternalidentifiers_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.methodexternalidentifiers_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: methodexternalidentifiers_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.methodexternalidentifiers_bridgeid_seq OWNED BY odm2.methodexternalidentifiers.bridgeid;


--
-- Name: methods; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.methods (
    methodid integer NOT NULL,
    methodtypecv character varying(255) NOT NULL,
    methodcode character varying(50) NOT NULL,
    methodname character varying(255) NOT NULL,
    methoddescription character varying(5000),
    methodlink character varying(255),
    organizationid integer
);


--
-- Name: methods_methodid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.methods_methodid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: methods_methodid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.methods_methodid_seq OWNED BY odm2.methods.methodid;


--
-- Name: modelaffiliations; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.modelaffiliations (
    bridgeid integer NOT NULL,
    modelid integer NOT NULL,
    affiliationid integer NOT NULL,
    isprimary boolean NOT NULL,
    roledescription character varying(5000)
);


--
-- Name: modelaffiliations_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.modelaffiliations_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: modelaffiliations_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.modelaffiliations_bridgeid_seq OWNED BY odm2.modelaffiliations.bridgeid;


--
-- Name: models; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.models (
    modelid integer NOT NULL,
    modelcode character varying(50) NOT NULL,
    modelname character varying(255) NOT NULL,
    modeldescription character varying(5000),
    version character varying(255),
    modellink character varying(255)
);


--
-- Name: models_modelid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.models_modelid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: models_modelid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.models_modelid_seq OWNED BY odm2.models.modelid;


--
-- Name: organizations; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.organizations (
    organizationid integer NOT NULL,
    organizationtypecv character varying(255) NOT NULL,
    organizationcode character varying(50) NOT NULL,
    organizationname character varying(255) NOT NULL,
    organizationdescription character varying(5000),
    organizationlink character varying(255),
    parentorganizationid integer
);


--
-- Name: organizations_organizationid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.organizations_organizationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: organizations_organizationid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.organizations_organizationid_seq OWNED BY odm2.organizations.organizationid;


--
-- Name: people; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.people (
    personid integer NOT NULL,
    personfirstname character varying(255) NOT NULL,
    personmiddlename character varying(255),
    personlastname character varying(255) NOT NULL
);


--
-- Name: people_personid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.people_personid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: people_personid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.people_personid_seq OWNED BY odm2.people.personid;


--
-- Name: personexternalidentifiers; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.personexternalidentifiers (
    bridgeid integer NOT NULL,
    personid integer NOT NULL,
    externalidentifiersystemid integer NOT NULL,
    personexternalidentifier character varying(255) NOT NULL,
    personexternalidentifieruri character varying(255)
);


--
-- Name: personexternalidentifiers_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.personexternalidentifiers_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: personexternalidentifiers_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.personexternalidentifiers_bridgeid_seq OWNED BY odm2.personexternalidentifiers.bridgeid;


--
-- Name: pointcoverageresults; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.pointcoverageresults (
    resultid bigint NOT NULL,
    zlocation double precision,
    zlocationunitsid integer,
    spatialreferenceid integer,
    intendedxspacing double precision,
    intendedxspacingunitsid integer,
    intendedyspacing double precision,
    intendedyspacingunitsid integer,
    aggregationstatisticcv character varying(255) NOT NULL,
    timeaggregationinterval double precision NOT NULL,
    timeaggregationintervalunitsid integer NOT NULL
);


--
-- Name: pointcoverageresultvalueannotations; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.pointcoverageresultvalueannotations (
    bridgeid bigint NOT NULL,
    valueid bigint NOT NULL,
    annotationid integer NOT NULL
);


--
-- Name: pointcoverageresultvalueannotations_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.pointcoverageresultvalueannotations_bridgeid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pointcoverageresultvalueannotations_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.pointcoverageresultvalueannotations_bridgeid_seq OWNED BY odm2.pointcoverageresultvalueannotations.bridgeid;


--
-- Name: pointcoverageresultvalues; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.pointcoverageresultvalues (
    valueid bigint NOT NULL,
    resultid bigint NOT NULL,
    datavalue double precision NOT NULL,
    valuedatetime timestamp without time zone NOT NULL,
    valuedatetimeutcoffset integer NOT NULL,
    xlocation double precision NOT NULL,
    xlocationunitsid integer NOT NULL,
    ylocation double precision NOT NULL,
    ylocationunitsid integer NOT NULL,
    censorcodecv character varying(255) NOT NULL,
    qualitycodecv character varying(255) NOT NULL
);


--
-- Name: pointcoverageresultvalues_valueid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.pointcoverageresultvalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pointcoverageresultvalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.pointcoverageresultvalues_valueid_seq OWNED BY odm2.pointcoverageresultvalues.valueid;


--
-- Name: processinglevels; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.processinglevels (
    processinglevelid integer NOT NULL,
    processinglevelcode character varying(50) NOT NULL,
    definition character varying(5000),
    explanation character varying(5000)
);


--
-- Name: processinglevels_processinglevelid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.processinglevels_processinglevelid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: processinglevels_processinglevelid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.processinglevels_processinglevelid_seq OWNED BY odm2.processinglevels.processinglevelid;


--
-- Name: profileresults; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.profileresults (
    resultid bigint NOT NULL,
    xlocation double precision,
    xlocationunitsid integer,
    ylocation double precision,
    ylocationunitsid integer,
    spatialreferenceid integer,
    intendedzspacing double precision,
    intendedzspacingunitsid integer,
    intendedtimespacing double precision,
    intendedtimespacingunitsid integer,
    aggregationstatisticcv character varying(255) NOT NULL
);


--
-- Name: profileresultvalueannotations; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.profileresultvalueannotations (
    bridgeid integer NOT NULL,
    valueid bigint NOT NULL,
    annotationid integer NOT NULL
);


--
-- Name: profileresultvalueannotations_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.profileresultvalueannotations_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: profileresultvalueannotations_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.profileresultvalueannotations_bridgeid_seq OWNED BY odm2.profileresultvalueannotations.bridgeid;


--
-- Name: profileresultvalues; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.profileresultvalues (
    valueid bigint NOT NULL,
    resultid bigint NOT NULL,
    datavalue double precision NOT NULL,
    valuedatetime timestamp without time zone NOT NULL,
    valuedatetimeutcoffset integer NOT NULL,
    zlocation double precision NOT NULL,
    zaggregationinterval double precision NOT NULL,
    zlocationunitsid integer NOT NULL,
    censorcodecv character varying(255) NOT NULL,
    qualitycodecv character varying(255) NOT NULL,
    timeaggregationinterval double precision NOT NULL,
    timeaggregationintervalunitsid integer NOT NULL
);


--
-- Name: profileresultvalues_valueid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.profileresultvalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: profileresultvalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.profileresultvalues_valueid_seq OWNED BY odm2.profileresultvalues.valueid;


--
-- Name: projectexternalidentifiers; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.projectexternalidentifiers (
    bridgeid integer NOT NULL,
    projectid integer NOT NULL,
    externalidentifiersystemid integer NOT NULL,
    projectexternalidentifier character varying(255) NOT NULL,
    projectexternalidentifieruri character varying(255)
);


--
-- Name: projectexternalidentifiers_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.projectexternalidentifiers_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projectexternalidentifiers_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.projectexternalidentifiers_bridgeid_seq OWNED BY odm2.projectexternalidentifiers.bridgeid;


--
-- Name: projects; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.projects (
    projectid bigint NOT NULL,
    projectname text NOT NULL,
    projectdescription text,
    projectnumbers text[]
);


--
-- Name: projects_projectid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.projects_projectid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projects_projectid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.projects_projectid_seq OWNED BY odm2.projects.projectid;


--
-- Name: projectstationexternalidentifiers; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.projectstationexternalidentifiers (
    bridgeid integer NOT NULL,
    projectstationid integer NOT NULL,
    externalidentifiersystemid integer NOT NULL,
    projectstationexternalidentifier character varying(255) NOT NULL,
    projectstationexternalidentifieruri character varying(255)
);


--
-- Name: projectstationexternalidentifiers_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.projectstationexternalidentifiers_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projectstationexternalidentifiers_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.projectstationexternalidentifiers_bridgeid_seq OWNED BY odm2.projectstationexternalidentifiers.bridgeid;


--
-- Name: projectstations; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.projectstations (
    projectstationid bigint NOT NULL,
    projectstationcode text NOT NULL,
    projectstationname text NOT NULL,
    projectid integer NOT NULL,
    samplingfeatureid integer NOT NULL
);


--
-- Name: projectstations_projectstationid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.projectstations_projectstationid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projectstations_projectstationid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.projectstations_projectstationid_seq OWNED BY odm2.projectstations.projectstationid;


--
-- Name: referencematerialexternalidentifiers; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.referencematerialexternalidentifiers (
    bridgeid integer NOT NULL,
    referencematerialid integer NOT NULL,
    externalidentifiersystemid integer NOT NULL,
    referencematerialexternalidentifier character varying(255) NOT NULL,
    referencematerialexternalidentifieruri character varying(255)
);


--
-- Name: referencematerialexternalidentifiers_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.referencematerialexternalidentifiers_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: referencematerialexternalidentifiers_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.referencematerialexternalidentifiers_bridgeid_seq OWNED BY odm2.referencematerialexternalidentifiers.bridgeid;


--
-- Name: referencematerials; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.referencematerials (
    referencematerialid integer NOT NULL,
    referencematerialmediumcv character varying(255) NOT NULL,
    referencematerialorganizationid integer NOT NULL,
    referencematerialcode character varying(50) NOT NULL,
    referencemateriallotcode character varying(255),
    referencematerialpurchasedate timestamp without time zone,
    referencematerialexpirationdate timestamp without time zone,
    referencematerialcertificatelink character varying(255),
    samplingfeatureid integer
);


--
-- Name: referencematerials_referencematerialid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.referencematerials_referencematerialid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: referencematerials_referencematerialid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.referencematerials_referencematerialid_seq OWNED BY odm2.referencematerials.referencematerialid;


--
-- Name: referencematerialvalues; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.referencematerialvalues (
    referencematerialvalueid integer NOT NULL,
    referencematerialid integer NOT NULL,
    referencematerialvalue double precision NOT NULL,
    referencematerialaccuracy double precision,
    variableid integer NOT NULL,
    unitsid integer NOT NULL,
    citationid integer
);


--
-- Name: referencematerialvalues_referencematerialvalueid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.referencematerialvalues_referencematerialvalueid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: referencematerialvalues_referencematerialvalueid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.referencematerialvalues_referencematerialvalueid_seq OWNED BY odm2.referencematerialvalues.referencematerialvalueid;


--
-- Name: relatedactions; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.relatedactions (
    relationid integer NOT NULL,
    actionid integer NOT NULL,
    relationshiptypecv character varying(255) NOT NULL,
    relatedactionid integer NOT NULL
);


--
-- Name: relatedactions_relationid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.relatedactions_relationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: relatedactions_relationid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.relatedactions_relationid_seq OWNED BY odm2.relatedactions.relationid;


--
-- Name: relatedannotations; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.relatedannotations (
    relationid integer NOT NULL,
    annotationid integer NOT NULL,
    relationshiptypecv character varying(255) NOT NULL,
    relatedannotationid integer NOT NULL
);


--
-- Name: relatedannotations_relationid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.relatedannotations_relationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: relatedannotations_relationid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.relatedannotations_relationid_seq OWNED BY odm2.relatedannotations.relationid;


--
-- Name: relatedcitations; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.relatedcitations (
    relationid integer NOT NULL,
    citationid integer NOT NULL,
    relationshiptypecv character varying(255) NOT NULL,
    relatedcitationid integer NOT NULL
);


--
-- Name: relatedcitations_relationid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.relatedcitations_relationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: relatedcitations_relationid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.relatedcitations_relationid_seq OWNED BY odm2.relatedcitations.relationid;


--
-- Name: relateddatasets; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.relateddatasets (
    relationid integer NOT NULL,
    datasetid integer NOT NULL,
    relationshiptypecv character varying(255) NOT NULL,
    relateddatasetid integer NOT NULL,
    versioncode character varying(50)
);


--
-- Name: relateddatasets_relationid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.relateddatasets_relationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: relateddatasets_relationid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.relateddatasets_relationid_seq OWNED BY odm2.relateddatasets.relationid;


--
-- Name: relatedequipment; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.relatedequipment (
    relationid integer NOT NULL,
    equipmentid integer NOT NULL,
    relationshiptypecv character varying(255) NOT NULL,
    relatedequipmentid integer NOT NULL,
    relationshipstartdatetime timestamp without time zone NOT NULL,
    relationshipstartdatetimeutcoffset integer NOT NULL,
    relationshipenddatetime timestamp without time zone,
    relationshipenddatetimeutcoffset integer
);


--
-- Name: relatedequipment_relationid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.relatedequipment_relationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: relatedequipment_relationid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.relatedequipment_relationid_seq OWNED BY odm2.relatedequipment.relationid;


--
-- Name: relatedfeatures; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.relatedfeatures (
    relationid integer NOT NULL,
    samplingfeatureid integer NOT NULL,
    relationshiptypecv character varying(255) NOT NULL,
    relatedfeatureid integer NOT NULL,
    spatialoffsetid integer
);


--
-- Name: relatedfeatures_relationid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.relatedfeatures_relationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: relatedfeatures_relationid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.relatedfeatures_relationid_seq OWNED BY odm2.relatedfeatures.relationid;


--
-- Name: relatedmodels; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.relatedmodels (
    relatedid integer NOT NULL,
    modelid integer NOT NULL,
    relationshiptypecv character varying(255) NOT NULL,
    relatedmodelid integer NOT NULL
);


--
-- Name: relatedmodels_relatedid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.relatedmodels_relatedid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: relatedmodels_relatedid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.relatedmodels_relatedid_seq OWNED BY odm2.relatedmodels.relatedid;


--
-- Name: relatedresults; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.relatedresults (
    relationid integer NOT NULL,
    resultid bigint NOT NULL,
    relationshiptypecv character varying(255) NOT NULL,
    relatedresultid bigint NOT NULL,
    versioncode character varying(50),
    relatedresultsequencenumber integer
);


--
-- Name: relatedresults_relationid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.relatedresults_relationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: relatedresults_relationid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.relatedresults_relationid_seq OWNED BY odm2.relatedresults.relationid;


--
-- Name: relatedtaxonomicclassifiers; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.relatedtaxonomicclassifiers (
    relationid integer NOT NULL,
    taxonomicclassifierid integer NOT NULL,
    relationshiptypecv character varying(255) NOT NULL,
    relatedtaxonomicclassifierid integer NOT NULL
);


--
-- Name: relatedtaxonomicclassifiers_relationid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.relatedtaxonomicclassifiers_relationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: relatedtaxonomicclassifiers_relationid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.relatedtaxonomicclassifiers_relationid_seq OWNED BY odm2.relatedtaxonomicclassifiers.relationid;


--
-- Name: resultannotations; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.resultannotations (
    bridgeid integer NOT NULL,
    resultid bigint NOT NULL,
    annotationid integer NOT NULL,
    begindatetime timestamp without time zone NOT NULL,
    enddatetime timestamp without time zone NOT NULL
);


--
-- Name: resultannotations_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.resultannotations_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: resultannotations_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.resultannotations_bridgeid_seq OWNED BY odm2.resultannotations.bridgeid;


--
-- Name: resultderivationequations; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.resultderivationequations (
    resultid bigint NOT NULL,
    derivationequationid integer NOT NULL
);


--
-- Name: resultextensionpropertyvalues; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.resultextensionpropertyvalues (
    bridgeid integer NOT NULL,
    resultid bigint NOT NULL,
    propertyid integer NOT NULL,
    propertyvalue character varying(255) NOT NULL
);


--
-- Name: resultextensionpropertyvalues_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.resultextensionpropertyvalues_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: resultextensionpropertyvalues_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.resultextensionpropertyvalues_bridgeid_seq OWNED BY odm2.resultextensionpropertyvalues.bridgeid;


--
-- Name: resultnormalizationvalues; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.resultnormalizationvalues (
    resultid bigint NOT NULL,
    normalizedbyreferencematerialvalueid integer NOT NULL
);


--
-- Name: results; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.results (
    resultid bigint NOT NULL,
    resultuuid uuid NOT NULL,
    featureactionid integer NOT NULL,
    resulttypecv character varying(255) NOT NULL,
    variableid integer NOT NULL,
    unitsid integer NOT NULL,
    taxonomicclassifierid integer,
    processinglevelid integer NOT NULL,
    resultdatetime timestamp without time zone,
    resultdatetimeutcoffset bigint,
    validdatetime timestamp without time zone,
    validdatetimeutcoffset bigint,
    statuscv character varying(255),
    sampledmediumcv character varying(255) NOT NULL,
    valuecount integer NOT NULL
);


--
-- Name: results_resultid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.results_resultid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: results_resultid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.results_resultid_seq OWNED BY odm2.results.resultid;


--
-- Name: resultsdataquality; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.resultsdataquality (
    bridgeid integer NOT NULL,
    resultid bigint NOT NULL,
    dataqualityid integer NOT NULL
);


--
-- Name: resultsdataquality_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.resultsdataquality_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: resultsdataquality_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.resultsdataquality_bridgeid_seq OWNED BY odm2.resultsdataquality.bridgeid;


--
-- Name: samplingfeatureannotations; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.samplingfeatureannotations (
    bridgeid integer NOT NULL,
    samplingfeatureid integer NOT NULL,
    annotationid integer NOT NULL
);


--
-- Name: samplingfeatureannotations_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.samplingfeatureannotations_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: samplingfeatureannotations_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.samplingfeatureannotations_bridgeid_seq OWNED BY odm2.samplingfeatureannotations.bridgeid;


--
-- Name: samplingfeatureextensionpropertyvalues; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.samplingfeatureextensionpropertyvalues (
    bridgeid integer NOT NULL,
    samplingfeatureid integer NOT NULL,
    propertyid integer NOT NULL,
    propertyvalue character varying(255) NOT NULL
);


--
-- Name: samplingfeatureextensionpropertyvalues_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.samplingfeatureextensionpropertyvalues_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: samplingfeatureextensionpropertyvalues_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.samplingfeatureextensionpropertyvalues_bridgeid_seq OWNED BY odm2.samplingfeatureextensionpropertyvalues.bridgeid;


--
-- Name: samplingfeatureexternalidentifiers; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.samplingfeatureexternalidentifiers (
    bridgeid integer NOT NULL,
    samplingfeatureid integer NOT NULL,
    externalidentifiersystemid integer NOT NULL,
    samplingfeatureexternalidentifier character varying(255) NOT NULL,
    samplingfeatureexternalidentifieruri character varying(255)
);


--
-- Name: samplingfeatureexternalidentifiers_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.samplingfeatureexternalidentifiers_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: samplingfeatureexternalidentifiers_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.samplingfeatureexternalidentifiers_bridgeid_seq OWNED BY odm2.samplingfeatureexternalidentifiers.bridgeid;


--
-- Name: samplingfeatures; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.samplingfeatures (
    samplingfeatureid integer NOT NULL,
    samplingfeatureuuid uuid NOT NULL,
    samplingfeaturetypecv character varying(255) NOT NULL,
    samplingfeaturecode character varying(100) NOT NULL,
    samplingfeaturename character varying(255),
    samplingfeaturedescription character varying(5000),
    samplingfeaturegeotypecv character varying(255),
    featuregeometry public.geometry(Geometry,4326),
    featuregeometrywkt character varying(8000),
    elevation_m double precision,
    elevationdatumcv character varying(255)
);


--
-- Name: samplingfeatures_samplingfeatureid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.samplingfeatures_samplingfeatureid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: samplingfeatures_samplingfeatureid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.samplingfeatures_samplingfeatureid_seq OWNED BY odm2.samplingfeatures.samplingfeatureid;


--
-- Name: sectionresults; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.sectionresults (
    resultid bigint NOT NULL,
    ylocation double precision,
    ylocationunitsid integer,
    spatialreferenceid integer,
    intendedxspacing double precision,
    intendedxspacingunitsid integer,
    intendedzspacing double precision,
    intendedzspacingunitsid integer,
    intendedtimespacing double precision,
    intendedtimespacingunitsid integer,
    aggregationstatisticcv character varying(255) NOT NULL
);


--
-- Name: sectionresultvalueannotations; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.sectionresultvalueannotations (
    bridgeid integer NOT NULL,
    valueid bigint NOT NULL,
    annotationid integer NOT NULL
);


--
-- Name: sectionresultvalueannotations_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.sectionresultvalueannotations_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sectionresultvalueannotations_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.sectionresultvalueannotations_bridgeid_seq OWNED BY odm2.sectionresultvalueannotations.bridgeid;


--
-- Name: sectionresultvalues; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.sectionresultvalues (
    valueid bigint NOT NULL,
    resultid bigint NOT NULL,
    datavalue double precision NOT NULL,
    valuedatetime timestamp without time zone NOT NULL,
    valuedatetimeutcoffset integer NOT NULL,
    xlocation double precision NOT NULL,
    xaggregationinterval double precision NOT NULL,
    xlocationunitsid integer NOT NULL,
    zlocation bigint NOT NULL,
    zaggregationinterval double precision NOT NULL,
    zlocationunitsid integer NOT NULL,
    censorcodecv character varying(255) NOT NULL,
    qualitycodecv character varying(255) NOT NULL,
    aggregationstatisticcv character varying(255) NOT NULL,
    timeaggregationinterval double precision NOT NULL,
    timeaggregationintervalunitsid integer NOT NULL
);


--
-- Name: sectionresultvalues_valueid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.sectionresultvalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sectionresultvalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.sectionresultvalues_valueid_seq OWNED BY odm2.sectionresultvalues.valueid;


--
-- Name: simulations; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.simulations (
    simulationid integer NOT NULL,
    actionid integer NOT NULL,
    simulationname character varying(255) NOT NULL,
    simulationdescription character varying(5000),
    simulationstartdatetime timestamp without time zone NOT NULL,
    simulationstartdatetimeutcoffset integer NOT NULL,
    simulationenddatetime timestamp without time zone NOT NULL,
    simulationenddatetimeutcoffset integer NOT NULL,
    timestepvalue double precision NOT NULL,
    timestepunitsid integer NOT NULL,
    inputdatasetid integer,
    modelid integer NOT NULL
);


--
-- Name: simulations_simulationid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.simulations_simulationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: simulations_simulationid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.simulations_simulationid_seq OWNED BY odm2.simulations.simulationid;


--
-- Name: sites; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.sites (
    samplingfeatureid integer NOT NULL,
    sitetypecv character varying(255) NOT NULL,
    latitude double precision NOT NULL,
    longitude double precision NOT NULL,
    spatialreferenceid integer NOT NULL
);


--
-- Name: spatialoffsets; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.spatialoffsets (
    spatialoffsetid integer NOT NULL,
    spatialoffsettypecv character varying(255) NOT NULL,
    offset1value double precision NOT NULL,
    offset1unitid integer NOT NULL,
    offset2value double precision,
    offset2unitid integer,
    offset3value double precision,
    offset3unitid integer
);


--
-- Name: spatialoffsets_spatialoffsetid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.spatialoffsets_spatialoffsetid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: spatialoffsets_spatialoffsetid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.spatialoffsets_spatialoffsetid_seq OWNED BY odm2.spatialoffsets.spatialoffsetid;


--
-- Name: spatialreferenceexternalidentifiers; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.spatialreferenceexternalidentifiers (
    bridgeid integer NOT NULL,
    spatialreferenceid integer NOT NULL,
    externalidentifiersystemid integer NOT NULL,
    spatialreferenceexternalidentifier character varying(255) NOT NULL,
    spatialreferenceexternalidentifieruri character varying(255)
);


--
-- Name: spatialreferenceexternalidentifiers_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.spatialreferenceexternalidentifiers_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: spatialreferenceexternalidentifiers_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.spatialreferenceexternalidentifiers_bridgeid_seq OWNED BY odm2.spatialreferenceexternalidentifiers.bridgeid;


--
-- Name: spatialreferences; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.spatialreferences (
    spatialreferenceid integer NOT NULL,
    srscode character varying(50),
    srsname character varying(255) NOT NULL,
    srsdescription character varying(5000),
    srslink character varying(255)
);


--
-- Name: spatialreferences_spatialreferenceid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.spatialreferences_spatialreferenceid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: spatialreferences_spatialreferenceid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.spatialreferences_spatialreferenceid_seq OWNED BY odm2.spatialreferences.spatialreferenceid;


--
-- Name: specimenbatchpostions; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.specimenbatchpostions (
    featureactionid integer NOT NULL,
    batchpositionnumber integer NOT NULL,
    batchpositionlabel character varying(255)
);


--
-- Name: specimens; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.specimens (
    samplingfeatureid integer NOT NULL,
    specimentypecv character varying(255) NOT NULL,
    specimenmediumcv character varying(255) NOT NULL,
    isfieldspecimen boolean NOT NULL
);


--
-- Name: specimentaxonomicclassifiers; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.specimentaxonomicclassifiers (
    bridgeid integer NOT NULL,
    samplingfeatureid integer NOT NULL,
    taxonomicclassifierid integer NOT NULL,
    citationid integer
);


--
-- Name: specimentaxonomicclassifiers_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.specimentaxonomicclassifiers_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: specimentaxonomicclassifiers_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.specimentaxonomicclassifiers_bridgeid_seq OWNED BY odm2.specimentaxonomicclassifiers.bridgeid;


--
-- Name: spectraresults; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.spectraresults (
    resultid bigint NOT NULL,
    xlocation double precision,
    xlocationunitsid integer,
    ylocation double precision,
    ylocationunitsid integer,
    zlocation double precision,
    zlocationunitsid integer,
    spatialreferenceid integer,
    intendedwavelengthspacing double precision,
    intendedwavelengthspacingunitsid integer,
    aggregationstatisticcv character varying(255) NOT NULL
);


--
-- Name: spectraresultvalueannotations; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.spectraresultvalueannotations (
    bridgeid integer NOT NULL,
    valueid bigint NOT NULL,
    annotationid integer NOT NULL
);


--
-- Name: spectraresultvalueannotations_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.spectraresultvalueannotations_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: spectraresultvalueannotations_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.spectraresultvalueannotations_bridgeid_seq OWNED BY odm2.spectraresultvalueannotations.bridgeid;


--
-- Name: spectraresultvalues; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.spectraresultvalues (
    valueid bigint NOT NULL,
    resultid bigint NOT NULL,
    datavalue double precision NOT NULL,
    valuedatetime timestamp without time zone NOT NULL,
    valuedatetimeutcoffset integer NOT NULL,
    excitationwavelength double precision NOT NULL,
    emissionwavelength double precision NOT NULL,
    wavelengthunitsid integer NOT NULL,
    censorcodecv character varying(255) NOT NULL,
    qualitycodecv character varying(255) NOT NULL,
    timeaggregationinterval double precision NOT NULL,
    timeaggregationintervalunitsid integer NOT NULL
);


--
-- Name: spectraresultvalues_valueid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.spectraresultvalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: spectraresultvalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.spectraresultvalues_valueid_seq OWNED BY odm2.spectraresultvalues.valueid;


--
-- Name: taxonomicclassifierexternalidentifiers; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.taxonomicclassifierexternalidentifiers (
    bridgeid integer NOT NULL,
    taxonomicclassifierid integer NOT NULL,
    externalidentifiersystemid integer NOT NULL,
    taxonomicclassifierexternalidentifier character varying(255) NOT NULL,
    taxonomicclassifierexternalidentifieruri character varying(255)
);


--
-- Name: taxonomicclassifierexternalidentifiers_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.taxonomicclassifierexternalidentifiers_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: taxonomicclassifierexternalidentifiers_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.taxonomicclassifierexternalidentifiers_bridgeid_seq OWNED BY odm2.taxonomicclassifierexternalidentifiers.bridgeid;


--
-- Name: taxonomicclassifiers; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.taxonomicclassifiers (
    taxonomicclassifierid integer NOT NULL,
    taxonomicclassifiertypecv character varying(255) NOT NULL,
    taxonomicclassifiername character varying(255) NOT NULL,
    taxonomicclassifiercommonname character varying(255),
    taxonomicclassifierdescription character varying(5000),
    parenttaxonomicclassifierid integer
);


--
-- Name: taxonomicclassifiers_taxonomicclassifierid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.taxonomicclassifiers_taxonomicclassifierid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: taxonomicclassifiers_taxonomicclassifierid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.taxonomicclassifiers_taxonomicclassifierid_seq OWNED BY odm2.taxonomicclassifiers.taxonomicclassifierid;


--
-- Name: taxonomicclassifiersannotations; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.taxonomicclassifiersannotations (
    bridgeid integer NOT NULL,
    taxonomicclassifierid integer NOT NULL,
    annotationid integer NOT NULL
);


--
-- Name: taxonomicclassifiersannotations_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.taxonomicclassifiersannotations_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: taxonomicclassifiersannotations_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.taxonomicclassifiersannotations_bridgeid_seq OWNED BY odm2.taxonomicclassifiersannotations.bridgeid;


--
-- Name: timeseriesresults; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.timeseriesresults (
    resultid bigint NOT NULL,
    xlocation double precision,
    xlocationunitsid integer,
    ylocation double precision,
    ylocationunitsid integer,
    zlocation double precision,
    zlocationunitsid integer,
    spatialreferenceid integer,
    intendedtimespacing double precision,
    intendedtimespacingunitsid integer,
    aggregationstatisticcv character varying(255) NOT NULL
);


--
-- Name: timeseriesresultvalueannotations; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.timeseriesresultvalueannotations (
    bridgeid integer NOT NULL,
    valueid bigint NOT NULL,
    annotationid integer NOT NULL
);


--
-- Name: timeseriesresultvalueannotations_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.timeseriesresultvalueannotations_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: timeseriesresultvalueannotations_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.timeseriesresultvalueannotations_bridgeid_seq OWNED BY odm2.timeseriesresultvalueannotations.bridgeid;


--
-- Name: timeseriesresultvalues; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.timeseriesresultvalues (
    valueid bigint NOT NULL,
    resultid bigint NOT NULL,
    datavalue double precision NOT NULL,
    valuedatetime timestamp without time zone NOT NULL,
    valuedatetimeutcoffset integer NOT NULL,
    censorcodecv character varying(255) NOT NULL,
    qualitycodecv character varying(255) NOT NULL,
    timeaggregationinterval double precision NOT NULL,
    timeaggregationintervalunitsid integer NOT NULL
);


--
-- Name: timeseriesresultvalues_valueid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.timeseriesresultvalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: timeseriesresultvalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.timeseriesresultvalues_valueid_seq OWNED BY odm2.timeseriesresultvalues.valueid;


--
-- Name: trackresultlocations; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.trackresultlocations (
    valuedatetime timestamp without time zone NOT NULL,
    trackpoint public.geometry(Point,4326) NOT NULL,
    qualitycodecv character varying(255) NOT NULL,
    samplingfeatureid integer NOT NULL
);


--
-- Name: trackresults; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.trackresults (
    resultid bigint NOT NULL,
    intendedtimespacing double precision,
    intendedtimespacingunitsid integer,
    aggregationstatisticcv character varying(255) NOT NULL
);


--
-- Name: trackresultvalues; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.trackresultvalues (
    valuedatetime timestamp without time zone NOT NULL,
    datavalue double precision NOT NULL,
    qualitycodecv character varying(255) NOT NULL,
    resultid bigint NOT NULL
);


--
-- Name: trajectoryresults; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.trajectoryresults (
    resultid bigint NOT NULL,
    spatialreferenceid integer,
    intendedtrajectoryspacing double precision,
    intendedtrajectoryspacingunitsid integer,
    intendedtimespacing double precision,
    intendedtimespacingunitsid integer,
    aggregationstatisticcv character varying(255) NOT NULL
);


--
-- Name: trajectoryresultvalueannotations; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.trajectoryresultvalueannotations (
    bridgeid integer NOT NULL,
    valueid bigint NOT NULL,
    annotationid integer NOT NULL
);


--
-- Name: trajectoryresultvalueannotations_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.trajectoryresultvalueannotations_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: trajectoryresultvalueannotations_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.trajectoryresultvalueannotations_bridgeid_seq OWNED BY odm2.trajectoryresultvalueannotations.bridgeid;


--
-- Name: trajectoryresultvalues; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.trajectoryresultvalues (
    valueid bigint NOT NULL,
    resultid bigint NOT NULL,
    datavalue double precision NOT NULL,
    valuedatetime timestamp without time zone NOT NULL,
    valuedatetimeutcoffset integer NOT NULL,
    xlocation double precision NOT NULL,
    xlocationunitsid integer NOT NULL,
    ylocation double precision NOT NULL,
    ylocationunitsid integer NOT NULL,
    zlocation double precision NOT NULL,
    zlocationunitsid integer NOT NULL,
    trajectorydistance double precision NOT NULL,
    trajectorydistanceaggregationinterval double precision NOT NULL,
    trajectorydistanceunitsid integer NOT NULL,
    censorcodecv character varying(255) NOT NULL,
    qualitycodecv character varying(255) NOT NULL,
    timeaggregationinterval double precision NOT NULL,
    timeaggregationintervalunitsid integer NOT NULL
);


--
-- Name: trajectoryresultvalues_valueid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.trajectoryresultvalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: trajectoryresultvalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.trajectoryresultvalues_valueid_seq OWNED BY odm2.trajectoryresultvalues.valueid;


--
-- Name: transectresults; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.transectresults (
    resultid bigint NOT NULL,
    zlocation double precision,
    zlocationunitsid integer,
    spatialreferenceid integer,
    intendedtransectspacing double precision,
    intendedtransectspacingunitsid integer,
    intendedtimespacing double precision,
    intendedtimespacingunitsid integer,
    aggregationstatisticcv character varying(255) NOT NULL
);


--
-- Name: transectresultvalueannotations; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.transectresultvalueannotations (
    bridgeid integer NOT NULL,
    valueid bigint NOT NULL,
    annotationid integer NOT NULL
);


--
-- Name: transectresultvalueannotations_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.transectresultvalueannotations_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: transectresultvalueannotations_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.transectresultvalueannotations_bridgeid_seq OWNED BY odm2.transectresultvalueannotations.bridgeid;


--
-- Name: transectresultvalues; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.transectresultvalues (
    valueid bigint NOT NULL,
    resultid bigint NOT NULL,
    datavalue double precision NOT NULL,
    valuedatetime timestamp without time zone NOT NULL,
    valuedatetimeutcoffset integer NOT NULL,
    xlocation double precision NOT NULL,
    xlocationunitsid integer NOT NULL,
    ylocation double precision NOT NULL,
    ylocationunitsid integer NOT NULL,
    transectdistance double precision NOT NULL,
    transectdistanceaggregationinterval double precision NOT NULL,
    transectdistanceunitsid integer NOT NULL,
    censorcodecv character varying(255) NOT NULL,
    qualitycodecv character varying(255) NOT NULL,
    aggregationstatisticcv character varying(255) NOT NULL,
    timeaggregationinterval double precision NOT NULL,
    timeaggregationintervalunitsid integer NOT NULL
);


--
-- Name: transectresultvalues_valueid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.transectresultvalues_valueid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: transectresultvalues_valueid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.transectresultvalues_valueid_seq OWNED BY odm2.transectresultvalues.valueid;


--
-- Name: units; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.units (
    unitsid integer NOT NULL,
    unitstypecv character varying(255) NOT NULL,
    unitsabbreviation character varying(50) NOT NULL,
    unitsname character varying(255) NOT NULL,
    unitslink character varying(255)
);


--
-- Name: units_unitsid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.units_unitsid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: units_unitsid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.units_unitsid_seq OWNED BY odm2.units.unitsid;


--
-- Name: variableextensionpropertyvalues; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.variableextensionpropertyvalues (
    bridgeid integer NOT NULL,
    variableid integer NOT NULL,
    propertyid integer NOT NULL,
    propertyvalue character varying(255) NOT NULL
);


--
-- Name: variableextensionpropertyvalues_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.variableextensionpropertyvalues_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: variableextensionpropertyvalues_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.variableextensionpropertyvalues_bridgeid_seq OWNED BY odm2.variableextensionpropertyvalues.bridgeid;


--
-- Name: variableexternalidentifiers; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.variableexternalidentifiers (
    bridgeid integer NOT NULL,
    variableid integer NOT NULL,
    externalidentifiersystemid integer NOT NULL,
    variableexternalidentifer character varying(255) NOT NULL,
    variableexternalidentifieruri character varying(255)
);


--
-- Name: variableexternalidentifiers_bridgeid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.variableexternalidentifiers_bridgeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: variableexternalidentifiers_bridgeid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.variableexternalidentifiers_bridgeid_seq OWNED BY odm2.variableexternalidentifiers.bridgeid;


--
-- Name: variables; Type: TABLE; Schema: odm2; Owner: -
--

CREATE TABLE odm2.variables (
    variableid integer NOT NULL,
    variabletypecv character varying(255) NOT NULL,
    variablecode character varying(50) NOT NULL,
    variablenamecv character varying(255) NOT NULL,
    variabledefinition character varying(5000),
    speciationcv character varying(255),
    nodatavalue double precision NOT NULL
);


--
-- Name: variables_variableid_seq; Type: SEQUENCE; Schema: odm2; Owner: -
--

CREATE SEQUENCE odm2.variables_variableid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: variables_variableid_seq; Type: SEQUENCE OWNED BY; Schema: odm2; Owner: -
--

ALTER SEQUENCE odm2.variables_variableid_seq OWNED BY odm2.variables.variableid;


--
-- Name: actionannotations bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.actionannotations ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.actionannotations_bridgeid_seq'::regclass);


--
-- Name: actionby bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.actionby ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.actionby_bridgeid_seq'::regclass);


--
-- Name: actiondirectives bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.actiondirectives ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.actiondirectives_bridgeid_seq'::regclass);


--
-- Name: actionextensionpropertyvalues bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.actionextensionpropertyvalues ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.actionextensionpropertyvalues_bridgeid_seq'::regclass);


--
-- Name: actions actionid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.actions ALTER COLUMN actionid SET DEFAULT nextval('odm2.actions_actionid_seq'::regclass);


--
-- Name: affiliations affiliationid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.affiliations ALTER COLUMN affiliationid SET DEFAULT nextval('odm2.affiliations_affiliationid_seq'::regclass);


--
-- Name: annotations annotationid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.annotations ALTER COLUMN annotationid SET DEFAULT nextval('odm2.annotations_annotationid_seq'::regclass);


--
-- Name: authorlists bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.authorlists ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.authorlists_bridgeid_seq'::regclass);


--
-- Name: calibrationreferenceequipment bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.calibrationreferenceequipment ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.calibrationreferenceequipment_bridgeid_seq'::regclass);


--
-- Name: calibrationstandards bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.calibrationstandards ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.calibrationstandards_bridgeid_seq'::regclass);


--
-- Name: categoricalresultvalueannotations bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.categoricalresultvalueannotations ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.categoricalresultvalueannotations_bridgeid_seq'::regclass);


--
-- Name: categoricalresultvalues valueid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.categoricalresultvalues ALTER COLUMN valueid SET DEFAULT nextval('odm2.categoricalresultvalues_valueid_seq'::regclass);


--
-- Name: citationextensionpropertyvalues bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.citationextensionpropertyvalues ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.citationextensionpropertyvalues_bridgeid_seq'::regclass);


--
-- Name: citationexternalidentifiers bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.citationexternalidentifiers ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.citationexternalidentifiers_bridgeid_seq'::regclass);


--
-- Name: citations citationid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.citations ALTER COLUMN citationid SET DEFAULT nextval('odm2.citations_citationid_seq'::regclass);


--
-- Name: dataloggerfilecolumns dataloggerfilecolumnid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.dataloggerfilecolumns ALTER COLUMN dataloggerfilecolumnid SET DEFAULT nextval('odm2.dataloggerfilecolumns_dataloggerfilecolumnid_seq'::regclass);


--
-- Name: dataloggerfiles dataloggerfileid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.dataloggerfiles ALTER COLUMN dataloggerfileid SET DEFAULT nextval('odm2.dataloggerfiles_dataloggerfileid_seq'::regclass);


--
-- Name: dataloggerprogramfiles programid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.dataloggerprogramfiles ALTER COLUMN programid SET DEFAULT nextval('odm2.dataloggerprogramfiles_programid_seq'::regclass);


--
-- Name: dataquality dataqualityid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.dataquality ALTER COLUMN dataqualityid SET DEFAULT nextval('odm2.dataquality_dataqualityid_seq'::regclass);


--
-- Name: datasetcitations bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.datasetcitations ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.datasetcitations_bridgeid_seq'::regclass);


--
-- Name: datasets datasetid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.datasets ALTER COLUMN datasetid SET DEFAULT nextval('odm2.datasets_datasetid_seq'::regclass);


--
-- Name: datasetsresults bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.datasetsresults ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.datasetsresults_bridgeid_seq'::regclass);


--
-- Name: derivationequations derivationequationid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.derivationequations ALTER COLUMN derivationequationid SET DEFAULT nextval('odm2.derivationequations_derivationequationid_seq'::regclass);


--
-- Name: directives directiveid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.directives ALTER COLUMN directiveid SET DEFAULT nextval('odm2.directives_directiveid_seq'::regclass);


--
-- Name: equipment equipmentid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.equipment ALTER COLUMN equipmentid SET DEFAULT nextval('odm2.equipment_equipmentid_seq'::regclass);


--
-- Name: equipmentannotations bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.equipmentannotations ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.equipmentannotations_bridgeid_seq'::regclass);


--
-- Name: equipmentmodels equipmentmodelid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.equipmentmodels ALTER COLUMN equipmentmodelid SET DEFAULT nextval('odm2.equipmentmodels_equipmentmodelid_seq'::regclass);


--
-- Name: equipmentused bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.equipmentused ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.equipmentused_bridgeid_seq'::regclass);


--
-- Name: extensionproperties propertyid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.extensionproperties ALTER COLUMN propertyid SET DEFAULT nextval('odm2.extensionproperties_propertyid_seq'::regclass);


--
-- Name: externalidentifiersystems externalidentifiersystemid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.externalidentifiersystems ALTER COLUMN externalidentifiersystemid SET DEFAULT nextval('odm2.externalidentifiersystems_externalidentifiersystemid_seq'::regclass);


--
-- Name: featureactions featureactionid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.featureactions ALTER COLUMN featureactionid SET DEFAULT nextval('odm2.featureactions_featureactionid_seq'::regclass);


--
-- Name: instrumentoutputvariables instrumentoutputvariableid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.instrumentoutputvariables ALTER COLUMN instrumentoutputvariableid SET DEFAULT nextval('odm2.instrumentoutputvariables_instrumentoutputvariableid_seq'::regclass);


--
-- Name: measurementresultvalueannotations bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.measurementresultvalueannotations ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.measurementresultvalueannotations_bridgeid_seq'::regclass);


--
-- Name: measurementresultvalues valueid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.measurementresultvalues ALTER COLUMN valueid SET DEFAULT nextval('odm2.measurementresultvalues_valueid_seq'::regclass);


--
-- Name: methodannotations bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.methodannotations ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.methodannotations_bridgeid_seq'::regclass);


--
-- Name: methodcitations bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.methodcitations ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.methodcitations_bridgeid_seq'::regclass);


--
-- Name: methodextensionpropertyvalues bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.methodextensionpropertyvalues ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.methodextensionpropertyvalues_bridgeid_seq'::regclass);


--
-- Name: methodexternalidentifiers bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.methodexternalidentifiers ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.methodexternalidentifiers_bridgeid_seq'::regclass);


--
-- Name: methods methodid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.methods ALTER COLUMN methodid SET DEFAULT nextval('odm2.methods_methodid_seq'::regclass);


--
-- Name: modelaffiliations bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.modelaffiliations ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.modelaffiliations_bridgeid_seq'::regclass);


--
-- Name: models modelid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.models ALTER COLUMN modelid SET DEFAULT nextval('odm2.models_modelid_seq'::regclass);


--
-- Name: organizations organizationid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.organizations ALTER COLUMN organizationid SET DEFAULT nextval('odm2.organizations_organizationid_seq'::regclass);


--
-- Name: people personid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.people ALTER COLUMN personid SET DEFAULT nextval('odm2.people_personid_seq'::regclass);


--
-- Name: personexternalidentifiers bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.personexternalidentifiers ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.personexternalidentifiers_bridgeid_seq'::regclass);


--
-- Name: pointcoverageresultvalueannotations bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.pointcoverageresultvalueannotations ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.pointcoverageresultvalueannotations_bridgeid_seq'::regclass);


--
-- Name: pointcoverageresultvalues valueid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.pointcoverageresultvalues ALTER COLUMN valueid SET DEFAULT nextval('odm2.pointcoverageresultvalues_valueid_seq'::regclass);


--
-- Name: processinglevels processinglevelid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.processinglevels ALTER COLUMN processinglevelid SET DEFAULT nextval('odm2.processinglevels_processinglevelid_seq'::regclass);


--
-- Name: profileresultvalueannotations bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.profileresultvalueannotations ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.profileresultvalueannotations_bridgeid_seq'::regclass);


--
-- Name: profileresultvalues valueid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.profileresultvalues ALTER COLUMN valueid SET DEFAULT nextval('odm2.profileresultvalues_valueid_seq'::regclass);


--
-- Name: projectexternalidentifiers bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.projectexternalidentifiers ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.projectexternalidentifiers_bridgeid_seq'::regclass);


--
-- Name: projects projectid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.projects ALTER COLUMN projectid SET DEFAULT nextval('odm2.projects_projectid_seq'::regclass);


--
-- Name: projectstationexternalidentifiers bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.projectstationexternalidentifiers ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.projectstationexternalidentifiers_bridgeid_seq'::regclass);


--
-- Name: projectstations projectstationid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.projectstations ALTER COLUMN projectstationid SET DEFAULT nextval('odm2.projectstations_projectstationid_seq'::regclass);


--
-- Name: referencematerialexternalidentifiers bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.referencematerialexternalidentifiers ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.referencematerialexternalidentifiers_bridgeid_seq'::regclass);


--
-- Name: referencematerials referencematerialid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.referencematerials ALTER COLUMN referencematerialid SET DEFAULT nextval('odm2.referencematerials_referencematerialid_seq'::regclass);


--
-- Name: referencematerialvalues referencematerialvalueid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.referencematerialvalues ALTER COLUMN referencematerialvalueid SET DEFAULT nextval('odm2.referencematerialvalues_referencematerialvalueid_seq'::regclass);


--
-- Name: relatedactions relationid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedactions ALTER COLUMN relationid SET DEFAULT nextval('odm2.relatedactions_relationid_seq'::regclass);


--
-- Name: relatedannotations relationid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedannotations ALTER COLUMN relationid SET DEFAULT nextval('odm2.relatedannotations_relationid_seq'::regclass);


--
-- Name: relatedcitations relationid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedcitations ALTER COLUMN relationid SET DEFAULT nextval('odm2.relatedcitations_relationid_seq'::regclass);


--
-- Name: relateddatasets relationid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relateddatasets ALTER COLUMN relationid SET DEFAULT nextval('odm2.relateddatasets_relationid_seq'::regclass);


--
-- Name: relatedequipment relationid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedequipment ALTER COLUMN relationid SET DEFAULT nextval('odm2.relatedequipment_relationid_seq'::regclass);


--
-- Name: relatedfeatures relationid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedfeatures ALTER COLUMN relationid SET DEFAULT nextval('odm2.relatedfeatures_relationid_seq'::regclass);


--
-- Name: relatedmodels relatedid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedmodels ALTER COLUMN relatedid SET DEFAULT nextval('odm2.relatedmodels_relatedid_seq'::regclass);


--
-- Name: relatedresults relationid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedresults ALTER COLUMN relationid SET DEFAULT nextval('odm2.relatedresults_relationid_seq'::regclass);


--
-- Name: relatedtaxonomicclassifiers relationid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedtaxonomicclassifiers ALTER COLUMN relationid SET DEFAULT nextval('odm2.relatedtaxonomicclassifiers_relationid_seq'::regclass);


--
-- Name: resultannotations bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.resultannotations ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.resultannotations_bridgeid_seq'::regclass);


--
-- Name: resultextensionpropertyvalues bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.resultextensionpropertyvalues ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.resultextensionpropertyvalues_bridgeid_seq'::regclass);


--
-- Name: results resultid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.results ALTER COLUMN resultid SET DEFAULT nextval('odm2.results_resultid_seq'::regclass);


--
-- Name: resultsdataquality bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.resultsdataquality ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.resultsdataquality_bridgeid_seq'::regclass);


--
-- Name: samplingfeatureannotations bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.samplingfeatureannotations ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.samplingfeatureannotations_bridgeid_seq'::regclass);


--
-- Name: samplingfeatureextensionpropertyvalues bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.samplingfeatureextensionpropertyvalues ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.samplingfeatureextensionpropertyvalues_bridgeid_seq'::regclass);


--
-- Name: samplingfeatureexternalidentifiers bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.samplingfeatureexternalidentifiers ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.samplingfeatureexternalidentifiers_bridgeid_seq'::regclass);


--
-- Name: samplingfeatures samplingfeatureid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.samplingfeatures ALTER COLUMN samplingfeatureid SET DEFAULT nextval('odm2.samplingfeatures_samplingfeatureid_seq'::regclass);


--
-- Name: sectionresultvalueannotations bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.sectionresultvalueannotations ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.sectionresultvalueannotations_bridgeid_seq'::regclass);


--
-- Name: sectionresultvalues valueid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.sectionresultvalues ALTER COLUMN valueid SET DEFAULT nextval('odm2.sectionresultvalues_valueid_seq'::regclass);


--
-- Name: simulations simulationid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.simulations ALTER COLUMN simulationid SET DEFAULT nextval('odm2.simulations_simulationid_seq'::regclass);


--
-- Name: spatialoffsets spatialoffsetid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.spatialoffsets ALTER COLUMN spatialoffsetid SET DEFAULT nextval('odm2.spatialoffsets_spatialoffsetid_seq'::regclass);


--
-- Name: spatialreferenceexternalidentifiers bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.spatialreferenceexternalidentifiers ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.spatialreferenceexternalidentifiers_bridgeid_seq'::regclass);


--
-- Name: spatialreferences spatialreferenceid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.spatialreferences ALTER COLUMN spatialreferenceid SET DEFAULT nextval('odm2.spatialreferences_spatialreferenceid_seq'::regclass);


--
-- Name: specimentaxonomicclassifiers bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.specimentaxonomicclassifiers ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.specimentaxonomicclassifiers_bridgeid_seq'::regclass);


--
-- Name: spectraresultvalueannotations bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.spectraresultvalueannotations ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.spectraresultvalueannotations_bridgeid_seq'::regclass);


--
-- Name: spectraresultvalues valueid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.spectraresultvalues ALTER COLUMN valueid SET DEFAULT nextval('odm2.spectraresultvalues_valueid_seq'::regclass);


--
-- Name: taxonomicclassifierexternalidentifiers bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.taxonomicclassifierexternalidentifiers ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.taxonomicclassifierexternalidentifiers_bridgeid_seq'::regclass);


--
-- Name: taxonomicclassifiers taxonomicclassifierid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.taxonomicclassifiers ALTER COLUMN taxonomicclassifierid SET DEFAULT nextval('odm2.taxonomicclassifiers_taxonomicclassifierid_seq'::regclass);


--
-- Name: taxonomicclassifiersannotations bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.taxonomicclassifiersannotations ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.taxonomicclassifiersannotations_bridgeid_seq'::regclass);


--
-- Name: timeseriesresultvalueannotations bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.timeseriesresultvalueannotations ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.timeseriesresultvalueannotations_bridgeid_seq'::regclass);


--
-- Name: timeseriesresultvalues valueid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.timeseriesresultvalues ALTER COLUMN valueid SET DEFAULT nextval('odm2.timeseriesresultvalues_valueid_seq'::regclass);


--
-- Name: trajectoryresultvalueannotations bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.trajectoryresultvalueannotations ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.trajectoryresultvalueannotations_bridgeid_seq'::regclass);


--
-- Name: trajectoryresultvalues valueid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.trajectoryresultvalues ALTER COLUMN valueid SET DEFAULT nextval('odm2.trajectoryresultvalues_valueid_seq'::regclass);


--
-- Name: transectresultvalueannotations bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.transectresultvalueannotations ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.transectresultvalueannotations_bridgeid_seq'::regclass);


--
-- Name: transectresultvalues valueid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.transectresultvalues ALTER COLUMN valueid SET DEFAULT nextval('odm2.transectresultvalues_valueid_seq'::regclass);


--
-- Name: units unitsid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.units ALTER COLUMN unitsid SET DEFAULT nextval('odm2.units_unitsid_seq'::regclass);


--
-- Name: variableextensionpropertyvalues bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.variableextensionpropertyvalues ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.variableextensionpropertyvalues_bridgeid_seq'::regclass);


--
-- Name: variableexternalidentifiers bridgeid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.variableexternalidentifiers ALTER COLUMN bridgeid SET DEFAULT nextval('odm2.variableexternalidentifiers_bridgeid_seq'::regclass);


--
-- Name: variables variableid; Type: DEFAULT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.variables ALTER COLUMN variableid SET DEFAULT nextval('odm2.variables_variableid_seq'::regclass);


--
-- Data for Name: actionannotations; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.actionannotations (bridgeid, actionid, annotationid) FROM stdin;
\.


--
-- Data for Name: actionby; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.actionby (bridgeid, actionid, affiliationid, isactionlead, roledescription) FROM stdin;
1	1	1	t	\N
2	2	1	t	\N
3	3	1	t	\N
4	4	1	t	\N
5	5	1	t	\N
6	6	1	t	\N
7	7	1	t	\N
8	8	1	t	\N
9	9	1	t	\N
10	10	1	t	\N
11	11	1	t	\N
12	12	1	t	\N
13	13	1	t	\N
14	14	1	t	\N
15	15	1	t	\N
16	16	1	t	\N
17	17	1	t	\N
18	18	1	t	\N
19	19	1	t	\N
20	20	1	t	\N
21	21	1	t	\N
22	22	1	t	\N
23	23	1	t	\N
24	24	1	t	\N
25	25	1	t	\N
26	26	1	t	\N
27	27	1	t	\N
28	28	1	t	\N
29	29	1	t	\N
30	30	1	t	\N
31	31	1	t	\N
32	32	1	t	\N
33	33	1	t	\N
34	34	1	t	\N
35	35	1	t	\N
36	36	1	t	\N
37	37	1	t	\N
38	38	1	t	\N
39	39	1	t	\N
40	40	1	t	\N
41	41	1	t	\N
42	42	1	t	\N
43	43	1	t	\N
44	44	1	t	\N
45	45	1	t	\N
46	46	1	t	\N
47	47	1	t	\N
48	48	1	t	\N
49	49	1	t	\N
50	50	1	t	\N
51	51	1	t	\N
52	52	1	t	\N
53	53	1	t	\N
54	54	1	t	\N
55	55	1	t	\N
56	56	1	t	\N
57	57	1	t	\N
58	58	1	t	\N
59	59	1	t	\N
60	60	1	t	\N
61	61	1	t	\N
62	62	1	t	\N
63	63	1	t	\N
64	64	1	t	\N
65	65	1	t	\N
66	66	1	t	\N
67	67	1	t	\N
68	68	1	t	\N
69	69	1	t	\N
70	70	1	t	\N
71	71	1	t	\N
72	72	1	t	\N
73	73	1	t	\N
74	74	1	t	\N
75	75	1	t	\N
76	76	1	t	\N
77	77	1	t	\N
78	78	1	t	\N
79	79	1	t	\N
80	80	1	t	\N
81	81	1	t	\N
82	82	1	t	\N
83	83	1	t	\N
84	84	1	t	\N
85	85	1	t	\N
86	86	1	t	\N
87	87	1	t	\N
88	88	1	t	\N
89	89	1	t	\N
90	90	1	t	\N
91	91	1	t	\N
92	92	1	t	\N
93	93	1	t	\N
94	94	1	t	\N
95	95	1	t	\N
96	96	1	t	\N
97	97	1	t	\N
98	98	1	t	\N
99	99	1	t	\N
100	100	1	t	\N
101	101	1	t	\N
102	102	1	t	\N
103	103	1	t	\N
104	104	1	t	\N
105	105	1	t	\N
106	106	1	t	\N
107	107	1	t	\N
108	108	1	t	\N
109	109	1	t	\N
110	110	1	t	\N
111	111	1	t	\N
112	112	1	t	\N
113	113	1	t	\N
114	114	1	t	\N
115	115	1	t	\N
116	116	1	t	\N
117	117	1	t	\N
118	118	1	t	\N
119	119	1	t	\N
120	120	1	t	\N
121	121	1	t	\N
122	122	1	t	\N
123	123	1	t	\N
124	124	1	t	\N
125	125	1	t	\N
126	126	1	t	\N
127	127	1	t	\N
128	128	1	t	\N
129	129	1	t	\N
130	130	1	t	\N
131	131	1	t	\N
132	132	1	t	\N
133	133	1	t	\N
134	134	1	t	\N
\.


--
-- Data for Name: actiondirectives; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.actiondirectives (bridgeid, actionid, directiveid) FROM stdin;
\.


--
-- Data for Name: actionextensionpropertyvalues; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.actionextensionpropertyvalues (bridgeid, actionid, propertyid, propertyvalue) FROM stdin;
\.


--
-- Data for Name: actions; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.actions (actionid, actiontypecv, methodid, begindatetime, begindatetimeutcoffset, enddatetime, enddatetimeutcoffset, actiondescription, actionfilelink) FROM stdin;
1	Instrument deployment	1	2023-01-31 18:25:28.187404	0	\N	\N	\N	\N
2	Instrument deployment	1	2023-01-31 18:25:28.194575	0	\N	\N	\N	\N
3	Instrument deployment	1	2023-01-31 18:25:28.199179	0	\N	\N	\N	\N
4	Instrument deployment	1	2023-01-31 18:25:28.203667	0	\N	\N	\N	\N
5	Instrument deployment	1	2023-01-31 18:25:28.208033	0	\N	\N	\N	\N
6	Instrument deployment	1	2023-01-31 18:25:28.212354	0	\N	\N	\N	\N
7	Instrument deployment	1	2023-01-31 18:25:28.216201	0	\N	\N	\N	\N
8	Instrument deployment	1	2023-01-31 18:25:28.219379	0	\N	\N	\N	\N
9	Instrument deployment	1	2023-01-31 18:25:28.222481	0	\N	\N	\N	\N
10	Instrument deployment	1	2023-01-31 18:25:28.225672	0	\N	\N	\N	\N
11	Instrument deployment	1	2023-01-31 18:25:28.228798	0	\N	\N	\N	\N
12	Instrument deployment	1	2023-01-31 18:25:28.231946	0	\N	\N	\N	\N
13	Instrument deployment	1	2023-01-31 18:25:28.235165	0	\N	\N	\N	\N
14	Instrument deployment	1	2023-01-31 18:25:28.238289	0	\N	\N	\N	\N
15	Instrument deployment	1	2023-01-31 18:25:28.241529	0	\N	\N	\N	\N
16	Instrument deployment	1	2023-01-31 18:25:28.244703	0	\N	\N	\N	\N
17	Instrument deployment	1	2023-01-31 18:25:28.247859	0	\N	\N	\N	\N
18	Instrument deployment	1	2023-01-31 18:25:28.250985	0	\N	\N	\N	\N
19	Instrument deployment	1	2023-01-31 18:25:28.254093	0	\N	\N	\N	\N
20	Instrument deployment	1	2023-01-31 18:25:28.257181	0	\N	\N	\N	\N
21	Instrument deployment	1	2023-01-31 18:25:28.260311	0	\N	\N	\N	\N
22	Instrument deployment	1	2023-01-31 18:25:28.263532	0	\N	\N	\N	\N
23	Instrument deployment	1	2023-01-31 18:25:28.266683	0	\N	\N	\N	\N
24	Instrument deployment	1	2023-01-31 18:25:28.26979	0	\N	\N	\N	\N
25	Instrument deployment	1	2023-01-31 18:25:28.272867	0	\N	\N	\N	\N
26	Instrument deployment	1	2023-01-31 18:25:28.27593	0	\N	\N	\N	\N
27	Instrument deployment	1	2023-01-31 18:25:28.279134	0	\N	\N	\N	\N
28	Instrument deployment	1	2023-01-31 18:25:28.282293	0	\N	\N	\N	\N
29	Instrument deployment	1	2023-01-31 18:25:28.285357	0	\N	\N	\N	\N
30	Instrument deployment	1	2023-01-31 18:25:28.288419	0	\N	\N	\N	\N
31	Instrument deployment	1	2023-01-31 18:25:28.291482	0	\N	\N	\N	\N
32	Instrument deployment	1	2023-01-31 18:25:28.294601	0	\N	\N	\N	\N
33	Instrument deployment	1	2023-01-31 18:25:28.297841	0	\N	\N	\N	\N
34	Instrument deployment	1	2023-01-31 18:25:28.300974	0	\N	\N	\N	\N
35	Instrument deployment	1	2023-01-31 18:25:28.304076	0	\N	\N	\N	\N
36	Instrument deployment	1	2023-01-31 18:25:28.307233	0	\N	\N	\N	\N
37	Instrument deployment	1	2023-01-31 18:25:28.310499	0	\N	\N	\N	\N
38	Instrument deployment	1	2023-01-31 18:25:28.313702	0	\N	\N	\N	\N
39	Instrument deployment	1	2023-01-31 18:25:28.318025	0	\N	\N	\N	\N
40	Instrument deployment	1	2023-01-31 18:25:28.321275	0	\N	\N	\N	\N
41	Instrument deployment	1	2023-01-31 18:25:28.324355	0	\N	\N	\N	\N
42	Instrument deployment	1	2023-01-31 18:25:28.32754	0	\N	\N	\N	\N
43	Instrument deployment	1	2023-01-31 18:25:28.330687	0	\N	\N	\N	\N
44	Instrument deployment	1	2023-01-31 18:25:28.33446	0	\N	\N	\N	\N
45	Instrument deployment	1	2023-01-31 18:25:28.337587	0	\N	\N	\N	\N
46	Instrument deployment	1	2023-01-31 18:25:28.340699	0	\N	\N	\N	\N
47	Instrument deployment	1	2023-01-31 18:25:28.344223	0	\N	\N	\N	\N
48	Instrument deployment	1	2023-01-31 18:25:28.347425	0	\N	\N	\N	\N
49	Instrument deployment	1	2023-01-31 18:25:28.350599	0	\N	\N	\N	\N
50	Instrument deployment	1	2023-01-31 18:25:28.353692	0	\N	\N	\N	\N
51	Instrument deployment	1	2023-01-31 18:25:28.356888	0	\N	\N	\N	\N
52	Instrument deployment	1	2023-01-31 18:25:28.360206	0	\N	\N	\N	\N
53	Instrument deployment	1	2023-01-31 18:25:28.363369	0	\N	\N	\N	\N
54	Instrument deployment	1	2023-01-31 18:25:28.366477	0	\N	\N	\N	\N
55	Instrument deployment	1	2023-01-31 18:25:28.369558	0	\N	\N	\N	\N
56	Instrument deployment	1	2023-01-31 18:25:28.372774	0	\N	\N	\N	\N
57	Instrument deployment	1	2023-01-31 18:25:28.375824	0	\N	\N	\N	\N
58	Instrument deployment	1	2023-01-31 18:25:28.379173	0	\N	\N	\N	\N
59	Instrument deployment	1	2023-01-31 18:25:28.382293	0	\N	\N	\N	\N
60	Instrument deployment	1	2023-01-31 18:25:28.385465	0	\N	\N	\N	\N
61	Instrument deployment	1	2023-01-31 18:25:28.388526	0	\N	\N	\N	\N
62	Instrument deployment	1	2023-01-31 18:25:28.391572	0	\N	\N	\N	\N
63	Instrument deployment	1	2023-01-31 18:25:28.39466	0	\N	\N	\N	\N
64	Instrument deployment	1	2023-01-31 18:25:28.397732	0	\N	\N	\N	\N
65	Instrument deployment	1	2023-01-31 18:25:28.400829	0	\N	\N	\N	\N
66	Instrument deployment	1	2023-01-31 18:25:28.4041	0	\N	\N	\N	\N
67	Instrument deployment	1	2023-01-31 18:25:28.407274	0	\N	\N	\N	\N
68	Instrument deployment	1	2023-01-31 18:25:28.410367	0	\N	\N	\N	\N
69	Instrument deployment	1	2023-01-31 18:25:28.413482	0	\N	\N	\N	\N
70	Instrument deployment	1	2023-01-31 18:25:28.416602	0	\N	\N	\N	\N
71	Instrument deployment	1	2023-01-31 18:25:28.419938	0	\N	\N	\N	\N
72	Instrument deployment	1	2023-01-31 18:25:28.423498	0	\N	\N	\N	\N
73	Instrument deployment	1	2023-01-31 18:25:28.426723	0	\N	\N	\N	\N
74	Instrument deployment	1	2023-01-31 18:25:28.429953	0	\N	\N	\N	\N
75	Instrument deployment	1	2023-01-31 18:25:28.433233	0	\N	\N	\N	\N
76	Instrument deployment	1	2023-01-31 18:25:28.436966	0	\N	\N	\N	\N
77	Instrument deployment	1	2023-01-31 18:25:28.440638	0	\N	\N	\N	\N
78	Instrument deployment	1	2023-01-31 18:25:28.44434	0	\N	\N	\N	\N
79	Instrument deployment	1	2023-01-31 18:25:28.448101	0	\N	\N	\N	\N
80	Instrument deployment	1	2023-01-31 18:25:28.4518	0	\N	\N	\N	\N
81	Instrument deployment	1	2023-01-31 18:25:28.455461	0	\N	\N	\N	\N
82	Instrument deployment	1	2023-01-31 18:25:28.459229	0	\N	\N	\N	\N
83	Instrument deployment	1	2023-01-31 18:25:28.46257	0	\N	\N	\N	\N
84	Instrument deployment	1	2023-01-31 18:25:28.465823	0	\N	\N	\N	\N
85	Instrument deployment	1	2023-01-31 18:25:28.468975	0	\N	\N	\N	\N
86	Instrument deployment	1	2023-01-31 18:25:28.472104	0	\N	\N	\N	\N
87	Instrument deployment	1	2023-01-31 18:25:28.475258	0	\N	\N	\N	\N
88	Instrument deployment	1	2023-01-31 18:25:28.478596	0	\N	\N	\N	\N
89	Instrument deployment	1	2023-01-31 18:25:28.481784	0	\N	\N	\N	\N
90	Instrument deployment	1	2023-01-31 18:25:28.484933	0	\N	\N	\N	\N
91	Instrument deployment	1	2023-01-31 18:25:28.488066	0	\N	\N	\N	\N
92	Instrument deployment	1	2023-01-31 18:25:28.491194	0	\N	\N	\N	\N
93	Instrument deployment	1	2023-01-31 18:25:28.494522	0	\N	\N	\N	\N
94	Instrument deployment	1	2023-01-31 18:25:28.497727	0	\N	\N	\N	\N
95	Instrument deployment	1	2023-01-31 18:25:28.500832	0	\N	\N	\N	\N
96	Instrument deployment	1	2023-01-31 18:25:28.503924	0	\N	\N	\N	\N
97	Instrument deployment	1	2023-01-31 18:25:28.50711	0	\N	\N	\N	\N
98	Instrument deployment	1	2023-01-31 18:25:28.510405	0	\N	\N	\N	\N
99	Instrument deployment	1	2023-01-31 18:25:28.513762	0	\N	\N	\N	\N
100	Instrument deployment	1	2023-01-31 18:25:28.516941	0	\N	\N	\N	\N
101	Instrument deployment	1	2023-01-31 18:25:28.520082	0	\N	\N	\N	\N
102	Instrument deployment	1	2023-01-31 18:25:28.523199	0	\N	\N	\N	\N
103	Instrument deployment	1	2023-01-31 18:25:28.526401	0	\N	\N	\N	\N
104	Instrument deployment	1	2023-01-31 18:25:28.529558	0	\N	\N	\N	\N
105	Instrument deployment	1	2023-01-31 18:25:28.532684	0	\N	\N	\N	\N
106	Instrument deployment	1	2023-01-31 18:25:28.535805	0	\N	\N	\N	\N
107	Instrument deployment	1	2023-01-31 18:25:28.539168	0	\N	\N	\N	\N
108	Instrument deployment	1	2023-01-31 18:25:28.542374	0	\N	\N	\N	\N
109	Instrument deployment	1	2023-01-31 18:25:28.545666	0	\N	\N	\N	\N
110	Instrument deployment	1	2023-01-31 18:25:28.548901	0	\N	\N	\N	\N
111	Instrument deployment	1	2023-01-31 18:25:28.552304	0	\N	\N	\N	\N
112	Instrument deployment	1	2023-01-31 18:25:28.555506	0	\N	\N	\N	\N
113	Instrument deployment	1	2023-01-31 18:25:28.55863	0	\N	\N	\N	\N
114	Instrument deployment	1	2023-01-31 18:25:28.561866	0	\N	\N	\N	\N
115	Instrument deployment	1	2023-01-31 18:25:28.565019	0	\N	\N	\N	\N
116	Instrument deployment	1	2023-01-31 18:25:28.568113	0	\N	\N	\N	\N
117	Instrument deployment	1	2023-01-31 18:25:28.571183	0	\N	\N	\N	\N
118	Instrument deployment	1	2023-01-31 18:25:28.574366	0	\N	\N	\N	\N
119	Instrument deployment	1	2023-01-31 18:25:28.578287	0	\N	\N	\N	\N
120	Instrument deployment	1	2023-01-31 18:25:28.581607	0	\N	\N	\N	\N
121	Instrument deployment	1	2023-01-31 18:25:28.584819	0	\N	\N	\N	\N
122	Instrument deployment	1	2023-01-31 18:25:28.588006	0	\N	\N	\N	\N
123	Instrument deployment	1	2023-01-31 18:25:28.591156	0	\N	\N	\N	\N
124	Instrument deployment	1	2023-01-31 18:25:28.594363	0	\N	\N	\N	\N
125	Instrument deployment	1	2023-01-31 18:25:28.597793	0	\N	\N	\N	\N
126	Instrument deployment	1	2023-01-31 18:25:28.600925	0	\N	\N	\N	\N
127	Instrument deployment	1	2023-01-31 18:25:28.604	0	\N	\N	\N	\N
128	Instrument deployment	1	2023-01-31 18:25:28.607079	0	\N	\N	\N	\N
129	Instrument deployment	1	2023-01-31 18:25:28.610292	0	\N	\N	\N	\N
130	Instrument deployment	1	2023-01-31 18:25:28.61379	0	\N	\N	\N	\N
131	Instrument deployment	1	2023-01-31 18:25:28.616992	0	\N	\N	\N	\N
132	Instrument deployment	1	2023-01-31 18:25:28.620164	0	\N	\N	\N	\N
133	Instrument deployment	1	2023-01-31 18:25:28.62328	0	\N	\N	\N	\N
134	Instrument deployment	1	2023-01-31 18:43:37.094932	0	\N	\N	\N	\N
\.


--
-- Data for Name: affiliations; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.affiliations (affiliationid, personid, organizationid, isprimaryorganizationcontact, affiliationstartdate, affiliationenddate, primaryphone, primaryemail, primaryaddress, personlink) FROM stdin;
1	1	1	f	2018-12-15	\N	\N	unknownemployee@niva.no	\N	\N
\.


--
-- Data for Name: annotations; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.annotations (annotationid, annotationtypecv, annotationcode, annotationtext, annotationdatetime, annotationutcoffset, annotationlink, annotatorid, citationid, annotationjson) FROM stdin;
1	Method annotation	\N	The json field holds the parameters with which this method will be executed	\N	\N	\N	\N	\N	{"verbose": "-v", "bits": "--32", "output": "--mzXML", "filter": " --filter \\"scanEvent 1-2\\""}
2	Method annotation	\N	The json field holds the parameters with which this method will be executed	\N	\N	\N	\N	\N	{"verbose": "-v", "bits": "--32", "output": "--mzXML"}
3	Method annotation	\N	The json field holds the parameters with which this method will be executed	\N	\N	\N	\N	\N	{"mz_range": [0, 0], "n_iter": 20000, "n_scan": 300, "mz_res": 20000, "mz_win": 0.02, "adj_r2": 0.75, "min_int": 1000, "int_var": 5, "s2n": 2, "min_nscan": 3}
4	Method annotation	\N	The json field holds the parameters with which this method will be executed	\N	\N	\N	\N	\N	{"mz_range": [0, 0], "n_iter": 200, "n_scan": 300, "mz_res": 20000, "mz_win": 0.02, "adj_r2": 0.75, "min_int": 1000, "int_var": 5, "s2n": 2, "min_nscan": 3}
5	Method annotation	\N	The json field holds the parameters with which this method will be executed	\N	\N	\N	\N	\N	{"mz_range": [0, 0], "n_iter": 20000, "n_scan": 300, "mz_res": 20000, "mz_win": 0.02, "adj_r2": 0.75, "min_int": 1000, "int_var": 5, "s2n": 2, "min_nscan": 3, "safd": "e9f11c2"}
6	Method annotation	\N	The json field holds the parameters with which this method will be executed	\N	\N	\N	\N	\N	{"mz_range": [0, 0], "n_iter": 20000, "n_scan": 300, "mz_res": 20000, "mz_win": 0.02, "adj_r2": 0.75, "min_int": 4000, "int_var": 5, "s2n": 2, "min_nscan": 3, "safd": "e9f11c2"}
7	Method annotation	\N	The json field holds the parameters with which this method will be executed	\N	\N	\N	\N	\N	{"mz_range": [120, 600], "n_iter": 20000, "n_scan": 300, "mz_res": 70000, "mz_win": 0.02, "adj_r2": 0.75, "min_int": 100000, "int_var": 5, "s2n": 2, "min_nscan": 3, "safd": "e9f11c2"}
8	Method annotation	\N	The json field holds the parameters with which this method will be executed	\N	\N	\N	\N	\N	{"mz_range": [120, 600], "n_iter": 10000, "n_scan": 300, "mz_res": 70000, "mz_win": 0.02, "adj_r2": 0.75, "min_int": 100000, "int_var": 5, "s2n": 2, "min_nscan": 3, "safd": "e9f11c2"}
9	Method annotation	\N	The json field holds the parameters with which this method will be executed	\N	\N	\N	\N	\N	{"mz_range": [120, 600], "n_iter": 2, "n_scan": 300, "mz_res": 70000, "mz_win": 0.02, "adj_r2": 0.75, "min_int": 100000, "int_var": 5, "s2n": 2, "min_nscan": 3, "safd": "e9f11c2"}
10	Method annotation	\N	The json field holds the parameters with which this method will be executed	\N	\N	\N	\N	\N	{"mz_range": [120, 600], "n_iter": 20000, "n_scan": 300, "mz_res": 70000, "mz_win": 0.02, "adj_r2": 0.75, "min_int": 4000, "int_var": 5, "s2n": 2, "min_nscan": 3, "safd": "e9f11c2"}
11	Method annotation	\N	The json field holds the parameters with which this method will be executed	\N	\N	\N	\N	\N	{"mz_range": [0, 0], "n_iter": 200, "n_scan": 300, "mz_res": 20000, "mz_win": 0.02, "adj_r2": 0.75, "min_int": 1000, "int_var": 5, "s2n": 2, "min_nscan": 3, "safd": "e9f11c2"}
12	Method annotation	\N	The json field holds the parameters with which this method will be executed	\N	\N	\N	\N	\N	{"mz_range": [0, 0], "mass_win_per": 0.8, "ret_win_per": 0.5, "delta_mass": 0.004, "min_int_frag": 300, "r_thresh": 0.75}
13	Method annotation	\N	The json field holds the parameters with which this method will be executed	\N	\N	\N	\N	\N	{"mz_range": [0, 0], "mass_win_per": 0.8, "ret_win_per": 0.5, "delta_mass": 0.004, "min_int_frag": 300, "r_thresh": 0.75, "compcreate": "76f14c5"}
14	Method annotation	\N	The json field holds the parameters with which this method will be executed	\N	\N	\N	\N	\N	{"mz_range": [0, 0], "mass_win_per": 0.8, "ret_win_per": 0.5, "delta_mass": 0.004, "min_int_frag": 300, "r_thresh": 0.75, "compcreate": "7e4f21e"}
15	Method annotation	\N	The json field holds the parameters with which this method will be executed	\N	\N	\N	\N	\N	{"mz_range": [0, 0], "mass_win_per": 0.8, "ret_win_per": 0.5, "delta_mass": 0.004, "min_int_frag": 300, "r_thresh": 0.75, "compcreate": "7e4f21e"}
16	Method annotation	\N	The json field holds the parameters with which this method will be executed	\N	\N	\N	\N	\N	{"mz_range": [120, 600], "mass_win_per": 0.8, "ret_win_per": 0.5, "delta_mass": 0.004, "min_int_frag": 100000, "r_thresh": 0.75, "compcreate": "7e4f21e"}
17	Method annotation	\N	The json field holds the parameters with which this method will be executed	\N	\N	\N	\N	\N	{"id_feature_wgts": [1, 1, 1, 1, 1, 1, 1]}
18	Method annotation	\N	The json field holds the parameters with which this method will be executed	\N	\N	\N	\N	\N	{"id_feature_wgts": [1, 1, 1, 1, 1, 1, 1], "ulsa": "b1fa044"}
19	Method annotation	\N	The json field holds the parameters with which this method will be executed	\N	\N	\N	\N	\N	{"id_feature_wgts": [1, 1, 1, 1, 1, 1, 1], "ulsa": "1ede498"}
20	Method annotation	\N	The json field holds the parameters with which this method will be executed	\N	\N	\N	\N	\N	{"id_feature_wgts": [1, 1, 1, 1, 1, 1, 1], "ulsa": "7301d29"}
21	Method annotation	\N	The json field holds the parameters with which this method will be executed	\N	\N	\N	\N	\N	{"id_feature_wgts": [1, 1, 1, 1, 1, 1, 1], "ulsa": "6cbad51"}
22	Method annotation	\N	The json field holds the parameters with which this method will be executed	\N	\N	\N	\N	\N	{"id_feature_wgts": [1, 1, 1, 1, 1, 1, 1], "ulsa": "45382eb"}
23	Specimen annotation	\N	Non-target mass spectrometry	\N	\N	\N	\N	\N	\N
24	Specimen annotation	\N	blank	\N	\N	\N	\N	\N	\N
25	Specimen annotation	\N	subject	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: authorlists; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.authorlists (bridgeid, citationid, personid, authororder) FROM stdin;
\.


--
-- Data for Name: calibrationactions; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.calibrationactions (actionid, calibrationcheckvalue, instrumentoutputvariableid, calibrationequation) FROM stdin;
\.


--
-- Data for Name: calibrationreferenceequipment; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.calibrationreferenceequipment (bridgeid, actionid, equipmentid) FROM stdin;
\.


--
-- Data for Name: calibrationstandards; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.calibrationstandards (bridgeid, actionid, referencematerialid) FROM stdin;
\.


--
-- Data for Name: categoricalresults; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.categoricalresults (resultid, xlocation, xlocationunitsid, ylocation, ylocationunitsid, zlocation, zlocationunitsid, spatialreferenceid, qualitycodecv) FROM stdin;
\.


--
-- Data for Name: categoricalresultvalueannotations; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.categoricalresultvalueannotations (bridgeid, valueid, annotationid) FROM stdin;
\.


--
-- Data for Name: categoricalresultvalues; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.categoricalresultvalues (valueid, resultid, datavalue, valuedatetime, valuedatetimeutcoffset) FROM stdin;
\.


--
-- Data for Name: citationextensionpropertyvalues; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.citationextensionpropertyvalues (bridgeid, citationid, propertyid, propertyvalue) FROM stdin;
\.


--
-- Data for Name: citationexternalidentifiers; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.citationexternalidentifiers (bridgeid, citationid, externalidentifiersystemid, citationexternalidentifier, citationexternalidentifieruri) FROM stdin;
\.


--
-- Data for Name: citations; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.citations (citationid, title, publisher, publicationyear, citationlink) FROM stdin;
\.


--
-- Data for Name: cv_actiontype; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.cv_actiontype (term, name, definition, category, sourcevocabularyuri) FROM stdin;
cruise	Cruise	A specialized form of an expedition action that involves an ocean-going vessel. Cruise actions are typically parents to other related Actions.	FieldActivity	\N
dataRetrieval	Data retrieval	The act of retrieving data from a datalogger deployed at a monitoring site.	Equipment	\N
derivation	Derivation	The act of creating results by deriving them from other results.	Observation	\N
equipmentDeployment	Equipment deployment	The act of placing equipment that will not make observations at or within a sampling feature. Actions involving the deployment of instruments should use the more specific term Instrument deployment.	Equipment	\N
equipmentMaintenance	Equipment maintenance	The act of performing regular or periodic upkeep or servicing of field or laboratory equipment. Maintenance may be performed in the field, in a laboratory, or at a factory maintenance center.	Equipment	\N
equipmentProgramming	Equipment programming	The act of creating or modifying the data collection program running on a datalogger or other equipment deployed at a monitoring site.	Equipment	\N
equipmentRetrieval	Equipment retrieval	The act of recovering a piece of equipment that made no observations from a deployment at a sampling feature or other location. For instruments, the more specific term Instrument retrieval should be used.	Equipment	\N
estimation	Estimation	The act of creating results by estimation or professional judgement.	Observation	\N
expedition	Expedition	A field visit action in which many sites are visited over a continguous period of time, often involving serveral investigators, and typically having a specific purpose.  Expedition actions are typically parents to other related Actions.	FieldActivity	\N
fieldActivity	Field activity	A generic, non-specific action type performed in the field at or on a sampling feature.	FieldActivity	\N
genericNonObservation	Generic non-observation	A generic, non-specific action type that does not produce a result.	Other	\N
instrumentCalibration	Instrument calibration	The act of calibrating an instrument either in the field or in a laboratory. The instrument may be an in situ field sensor or a laboratory instrument.  An instrument is the subclass of equipment that is capable of making an observation to produce a result.	Equipment	\N
instrumentDeployment	Instrument deployment	The act of deploying an in situ instrument or sensor that creates an observation result.  This term is a specific form of the Observation actions category of actions, which is the only category of actions that can produce observation results.	Observation	\N
instrumentRetrieval	Instrument retrieval	The act of recovering an in situ instrument (which made observations) from a sampling feature. This action ends an instrument deployment action.	Equipment	\N
observation	Observation	The general act of making an observation. This term should be used when a Result is generated but the more specific terms of Instrument deployment or Specimen analysis are not applicable.	Observation	\N
simulation	Simulation	The act of calculating results through the use of a simulation model.	Observation	\N
siteVisit	Site visit	A field visit action in which a single site is visited for one or more other possible actions (i.e., specimen collection, equipment maintenance, etc.).  Site visit actions are typically parents to other related actions.	FieldActivity	\N
specimenAnalysis	Specimen analysis	The analysis of a specimen ex situ using an instrument, typically in a laboratory, for the purpose of measuring properties of that specimen.	Observation	\N
specimenCollection	Specimen collection	The collection of a specimen in the field.	SamplingFeature	\N
specimenFractionation	Specimen fractionation	The process of separating a specimen into multiple different fractions or size classes.	SamplingFeature	\N
specimenPreparation	Specimen preparation	The processing of a specimen collected in the field to produce a sample suitable for analysis using a particular analytical procedure.	SamplingFeature	\N
specimenPreservation	Specimen preservation	The act of preserving a specimen collected in the field to produce a sample suitable for analysis using a particular analytical procedure.	SamplingFeature	\N
submersibleLaunch	Submersible launch	The act of deploying a submersible from a vessel or ship.	FieldActivity	\N
\.


--
-- Data for Name: cv_aggregationstatistic; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.cv_aggregationstatistic (term, name, definition, category, sourcevocabularyuri) FROM stdin;
average	Average	The values represent the average over a time interval, such as daily mean discharge or daily mean temperature.		\N
bestEasySystematicEstimator	Best easy systematic estimator	Best Easy Systematic Estimator BES = (Q1 +2Q2 +Q3)/4. Q1, Q2, and Q3 are first, second, and third quartiles. See Woodcock, F. and Engel, C., 2005: Operational Consensus Forecasts.Weather and Forecasting, 20, 101-111. (http://www.bom.gov.au/nmoc/bulletins/60/article_by_Woodcock_in_Weather_and_Forecasting.pdf) and Wonnacott, T. H., and R. J. Wonnacott, 1972: Introductory Statistics. Wiley, 510 pp.		\N
categorical	Categorical	The values are categorical rather than continuous valued quantities.		\N
confidenceInterval	Confidence Interval	In statistics, a confidence interval (CI) is a type of interval estimate of a statistical parameter. It is an observed interval (i.e., it is calculated from the observations), in principle different from sample to sample, that frequently includes the value of an unobservable parameter of interest if the experiment is repeated. How frequently the observed interval contains the parameter is determined by the confidence level or confidence coefficient.		\N
constantOverInterval	Constant over interval	The values are quantities that can be interpreted as constant for all time, or over the time interval to a subsequent measurement of the same variable at the same site.		\N
continuous	Continuous	A quantity specified at a particular instant in time measured with sufficient frequency (small spacing) to be interpreted as a continuous record of the phenomenon.		\N
cumulative	Cumulative	The values represent the cumulative value of a variable measured or calculated up to a given instant of time, such as cumulative volume of flow or cumulative precipitation.		\N
incremental	Incremental	The values represent the incremental value of a variable over a time interval, such as the incremental volume of flow or incremental precipitation.		\N
maximum	Maximum	The values are the maximum values occurring at some time during a time interval, such as annual maximum discharge or a daily maximum air temperature.		\N
median	Median	The values represent the median over a time interval, such as daily median discharge or daily median temperature.		\N
minimum	Minimum	The values are the minimum values occurring at some time during a time interval, such as 7-day low flow for a year or the daily minimum temperature.		\N
mode	Mode	The values are the most frequent values occurring at some time during a time interval, such as annual most frequent wind direction.		\N
sporadic	Sporadic	The phenomenon is sampled at a particular instant in time but with a frequency that is too coarse for interpreting the record as continuous. This would be the case when the spacing is significantly larger than the support and the time scale of fluctuation of the phenomenon, such as for example infrequent water quality samples.		\N
standardDeviation	Standard deviation	The values represent the standard deviation of a set of observations made over a time interval. Standard deviation computed using the unbiased formula SQRT(SUM((Xi-mean)^2)/(n-1)) are preferred. The specific formula used to compute variance can be noted in the methods description.		\N
standardErrorOfMean	Standard error of mean	The standard error of the mean (SEM) quantifies the precision of the mean. It is a measure of how far your sample mean is likely to be from the true population mean. It is expressed in the same units as the data.		\N
standardErrorOfTheMean	Standard error of the mean	The standard error of the mean (SEM) quantifies the precision of the mean. It is a measure of how far your sample mean is likely to be from the true population mean. It is expressed in the same units as the data.		\N
unknown	Unknown	The aggregation statistic is unknown.		\N
variance	Variance	The values represent the variance of a set of observations made over a time interval. Variance computed using the unbiased formula SUM((Xi-mean)^2)/(n-1) are preferred. The specific formula used to compute variance can be noted in the methods description.		\N
\.


--
-- Data for Name: cv_annotationtype; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.cv_annotationtype (term, name, definition, category, sourcevocabularyuri) FROM stdin;
actionAnnotation	Action annotation	An annotation or qualifying comment about an Action	Annotation	\N
actionGroup	Action group	A group of actions such as those that are part of a cruise, expedition, experiment, project, etc.	Group	\N
categoricalResultValueAnnotation	Categorical result value annotation	An annotation or data qualifying comment applied to a data value from a categorical Result	Annotation	\N
dataSetAnnotation	Dataset annotation	An annotation or qualifying comment about a DataSet	Annotation	\N
equipmentAnnotation	Equipment annotation	An annotation or qualifying comment about a piece of Equipment	Annotation	\N
measurementResultValueAnnotation	Measurement result value annotation	An annotation or data qualifying comment applied to a data value from a measurement Result	Annotation	\N
methodAnnotation	Method annotation	An annotation or qualifiying comment about a Method	Annotation	\N
organizationAnnotation	Organization annotation	An annotation or qualifiying comment about an Organization	Annotation	\N
personAnnotation	Person annotation	An annotation or qualifying comment about a Person	Annotation	\N
personGroup	Person group	A group of people such as a research team, project team, etc.	Group	\N
pointCoverageResultValueAnnotation	Point coverage result value annotation	An annotation or data qualifying comment applied to a data value from a point coverage Result	Annotation	\N
profileResultValueAnnotation	Profile result value annotation	An annotation or data qualifying comment applied to a data value from a profile Result	Annotation	\N
resultAnnotation	Result annotation	An annotation or qualifying comment about a Result	Annotation	\N
samplingFeatureAnnotation	Sampling feature annotation	An annotation or qualifiying comment about a SamplingFeature	Annotation	\N
sectionResultValueAnnotation	Section result value annotation	An annotation or data qualifying comment applied to a data value from a section Result	Annotation	\N
siteAnnotation	Site annotation	An annotation or qualifying comment about a Site	Annotation	\N
siteGroup	Site group	A group of sites such as a transect, station, observatory, monitoring collection, etc.	Group	\N
specimenAnnotation	Specimen annotation	An annotation or qualifying comment about a Specimen	Annotation	\N
specimenGroup	Specimen group	A group of specimens such as an analysis batch, profile, experiment, etc.	Group	\N
spectraResultValueAnnotation	Spectra result value annotation	An annotation or data qualifying comment applied to a data value from a spectra Result	Annotation	\N
timeSeriesResultValueAnnotation	Time series result value annotation	An annotation or data qualifying comment applied to a data value from a time series Result	Annotation	\N
trajectoryResultValueAnnotation	Trajectory result value annotation	An annotation or data qualifying comment applied to a data value from a trajectory Result	Annotation	\N
transectResultValueAnnotation	Transect result value annotation	An annotation or data qualifying comment applied to a data value from a transect Result	Annotation	\N
valueGroup	Value group	A group of data values such as those from a profile, analysis, spectra, publication table, dataset, incident reports, etc.	Group	\N
variableAnnotation	Variable annotation	An annotation or qualifying comment about a Variable	Annotation	\N
taxonomicClassifierAnnotation	Taxonomic classifier annotation	An annotation or qualifying comment about an TaxonomicClassifier.	Annotation	\N
\.


--
-- Data for Name: cv_censorcode; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.cv_censorcode (term, name, definition, category, sourcevocabularyuri) FROM stdin;
greaterThan	Greater than	The value is known to be greater than the recorded value.		\N
lessThan	Less than	The value is known to be less than the recorded value.		\N
nonDetect	Non-detect	The value was reported as a non-detect. The recorded value represents the level at which the anlalyte can be detected.		\N
notCensored	Not censored	The reported value is not censored.		\N
presentButNotQuantified	Present but not quantified	The anlayte is known to be present, but was not quantified. The recorded value represents the level below which the analyte can no longer be quantified.		\N
unknown	Unknown	It is unknown whether the data value as reported is censored.		\N
discarded	Discarded	Measurement point categorised as bad measurement by a domain expert.	\N	\N
approved	Approved	Measurement point categorised as good measurement by a domain expert.	\N	\N
corrected	Corrected	Measurement point corrected by a domain expert.	\N	\N
\.


--
-- Data for Name: cv_dataqualitytype; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.cv_dataqualitytype (term, name, definition, category, sourcevocabularyuri) FROM stdin;
accuracy	Accuracy	The degree of closeness of a measurement of a quantity to that quantity's true value.		\N
methodDetectionLimit	Method detection limit	The minimum concentration of a substance that can be distinguished from the absence of that substance within a stated confidence limit (generally 1%) given a particular analytical method.		\N
physicalLimitLowerBound	Physical limit lower bound	This describes a numeric value below which measured values should be considered suspect. This numeric value should be empirically derived.		\N
physicalLimitUpperBound	Physical limit upper bound	This describes a numeric value above which measured values should be considered suspect. This numeric value should be empirically derived.		\N
precision	Precision	The degree to which repeated measurements under unchanged conditions show the same results.		\N
reportingLevel	Reporting level	The smallest concentration of analyte that can be reported by laboratory.		\N
\.


--
-- Data for Name: cv_datasettype; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.cv_datasettype (term, name, definition, category, sourcevocabularyuri) FROM stdin;
multiTimeSeries	Multi-time series	A Dataset that contains multiple time series Results. This corresponds to the YAML Observations Data Archive (YODA) multi-time series profile.		\N
multiVariableSpecimenMeasurements	Multi-variable specimen measurements	A dataset that contains multiple measurement Results derived from Specimens. This corresponds to the YAML Observations Data Archive (YODA) specimen time series profile.		\N
other	Other	A set of Results that has been grouped into a Dataset because they are logically related. The group does not conform to any particular profile.		\N
singleTimeSeries	Single time series	A Dataset that contains a single time series Result. This corresponds to the YAML Observations Data Archive (YODA) singe time series profile.		\N
specimenTimeSeries	Specimen time series	A dataset that contains multiple measurement Results derived from Specimens. This corresponds to the YAML Observations Data Archive (YODA) specimen time series profile.		\N
\.


--
-- Data for Name: cv_directivetype; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.cv_directivetype (term, name, definition, category, sourcevocabularyuri) FROM stdin;
fieldCampaign	Field campaign	A sampling event conducted in the field during which instruments may be deployed and during which samples may be collected. Field campaigns typically have a focus such as characterizing a particular environment, quantifying a particular phenomenon, answering a particular research question, etc. and may last for hours, days, weeks, months, or even longer.		\N
monitoringProgram	Monitoring program	Environmental monitoring that is conducted according to a formal plan that may reflect the overall objectives of an organization, references specific strategies that help deliver the objectives and details of specific projects or tasks, and that contains a listing of what is being monitored, how that monitoring is taking place, and the time-scale over which monitoring should take place.		\N
project	Project	A collaborative enterprise, involving research or design, the is carefully planned to achieve a particular aim.		\N
\.


--
-- Data for Name: cv_elevationdatum; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.cv_elevationdatum (term, name, definition, category, sourcevocabularyuri) FROM stdin;
AHD	AHD	Australian Height Datum. Height datum used for standardised elevations across Australia. The datum surface is defined as that which passes through mean sea level at the 30 specified tide gauges and through points at zero AHD height vertically below the other basic junction points.		\N
EGM96	EGM96	EGM96 (Earth Gravitational Model 1996) is a geopotential model of the Earth consisting of spherical harmonic coefficients complete to degree and order 360.		\N
MSL	MSL	Mean Sea Level		\N
NAVD88	NAVD88	North American Vertical Datum of 1988		\N
NGVD29	NGVD29	National Geodetic Vertical Datum of 1929		\N
Unknown	Unknown	The vertical datum is unknown		\N
\.


--
-- Data for Name: cv_equipmenttype; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.cv_equipmenttype (term, name, definition, category, sourcevocabularyuri) FROM stdin;
antenna	Antenna	An electrical device that converts electric power into radio waves and vice versa.	Communications component	\N
automaticLevel	Automatic level	A survey level that makes use of a compensator that ensures the line of sight remains horizontal once the operator has roughly leveled the instrument.	Instrument	\N
battery	Battery	A device consisting of one or more electrochemical cells that convert stored chemical energy into electrical energy.	Power component	\N
cable	Cable	Two or more wires running side by side and bonded, twisted, or braided together to form a single assembly.	Peripheral component	\N
camera	Camera	A device used to create photographic images		\N
chargeRegulator	Charge regulator	An electroinic device that limits the rate at which electric current is added to or drawn from electric batteries.	Power component	\N
datalogger	Datalogger	An electronic device that records data over time or in relation to location either with a built in instrument or sensor or via external instruments and sensors.	Datalogger	\N
electronicDevice	Electronic device	A generic electronic device		\N
enclosure	Enclosure	A cabinet or box within which electrical or electronic equipment are mounted to protect them from the environment.	Platform	\N
fluorometer	Fluorometer	A device used to measure paramters of flouroescence, including its intensity and wavelength distribution of emission spectrum after excitation by a certain spectrum of light.	Sensor	\N
globalPositioningSystemReceiver	Global positioning system receiver	A device that accurately calculates geographical location by receiving information from Global Positioning System satellites.	Sensor	\N
interface	Interface	A device used to couple multiple other devices.		\N
laboratoryInstrument	Laboratory instrument	Any type of equipment, apparatus or device designed, constructed and refined to use well proven physical principles, relationships or technology to facilitate or enable the pursuit, acquisition, transduction and storage of repeatable, verifiable data, usually consisting of sets numerical measurements made upon otherwise unknown, unproven quantities, properties, phenomena, materials, forces or etc.	Instrument	\N
levelStaff	Level staff	A graduate wooden, fiberglass, or aluminum rod used to determine differences in elevation.	Instrument	\N
mast	Mast	A pole that supports sensors, instruments, or measurement peripherals.	Observation platform	\N
measurementTower	Measurement tower	A free standing tower that supports measuring instruments or sensors.	Observation platform	\N
multiplexer	Multiplexer	A device that selects one of several analog or digital input signals and forwards the selected input into a single line.		\N
powerSupply	Power supply	An electronic device that supplies electric energy to an electrical load. The primary function of a power supply is to convert one form of electrical energy to another (e.g., solar to chemical).	Power component	\N
pressureTransducer	Pressure transducer	A sensor that measures pressure, typically of gases or liquids.	Sensor	\N
radio	Radio	A device that transfers information via electromagnetic signals through the atmosphere or free space.	Communications component	\N
sampler	Sampler	A device used to collect specimens for later ex situ analysis.	Sampling device	\N
sensor	Sensor	A device that detects events or changes in quantities and provides a corresponding output, generally as an electrical or optical signal.	Sensor	\N
solarPanel	Solar panel	A photovoltaic module that is electrically connected and mounted on a supporting structure.  Used to generate and supply electricity.	Power component	\N
stormBox	Storm box	An enclosure used to protect electronic equipment used for stormwater sampling.	Platform	\N
totalStation	Total station	An electronic and optical instrument used in modern surveying and building construction.  A total station is an electronic theodoloite integrated with an electronic distance meter to read slope distances from the instrument to a particular point.	Instrument	\N
tripod	Tripod	A portable, three-legged frame used as a platform for supporting the weight and maintaining the stability of some other object. Typically used as a data collection platform to which sensors are attached.	Observation platform	\N
turbidimeter	Turbidimeter	A water quality sensor that monitors light reflected off the particles suspended in water.	Sensor	\N
waterQualitySonde	Water quality sonde	A water quality monitoring instrument having multiple attached sensors.	Sensor	\N
\.


--
-- Data for Name: cv_medium; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.cv_medium (term, name, definition, category, sourcevocabularyuri) FROM stdin;
air	Air	Specimen collection of ambient air or sensor emplaced to measure properties of ambient air.		\N
equipment	Equipment	An instrument, sensor or other piece of human-made equipment upon which a measurement is made, such as datalogger temperature or battery voltage.		\N
gas	Gas	Gas phase specimen or sensor emplaced to measure properties of a gas.		\N
habitat	Habitat	A habitat is an ecological or environmental area that is inhabited by a particular species of animal, plant, or other type of organism.		\N
ice	Ice	Sample collected as frozen water or sensor emplaced to measure properties of ice.		\N
liquidAqueous	Liquid aqueous	Specimen collected as liquid water or sensor emplaced to measure properties of water in sampled environment.		\N
liquidOrganic	Liquid organic	Specimen collected as an organic liquid.		\N
mineral	Mineral	Specimen collected as a mineral.		\N
notApplicable	Not applicable	There is no applicable sampled medium.  		\N
organism	Organism	Data collected about a species at organism level.		\N
other	Other	Other.		\N
particulate	Particulate	Specimen collected from particulates suspended in a paticulate-fluid mixture. Examples include particulates in water or air.		\N
regolith	Regolith	The entire unconsolidated or secondarily recemented cover that overlies more coherent bedrock, that has been formed by weathering, erosion, transport and/or deposition of the older material. The regolith thus includes fractured and weathered basement rocks, saprolites, soils, organic accumulations, volcanic material, glacial deposits, colluvium, alluvium, evaporitic sediments, aeolian deposits and ground water.\r\nEverything from fresh rock to fresh air.		\N
rock	Rock	Specimen collected from a naturally occuring solid aggregate of one or more minerals.		\N
sediment	Sediment	Specimen collected from material broken down by processes of weathering and erosion and subsequently transported by the action of wind, water, or ice, and/or by the force of gravity acting on the particles. Sensors may also be emplaced to measure sediment properties.		\N
snow	Snow	Observation in, of or sample taken from snow.		\N
soil	Soil	Specimen collected from soil or sensor emplaced to measure properties of soil. Soil includes the mixture of minerals, organic matter, gasses, liquids, and organisms that make up the upper layer of earth in which plants grow. 		\N
tissue	Tissue	Sample of a living organism's tissue or sensor emplaced to measure property of tissue.		\N
unknown	Unknown	The sampled medium is unknown.		\N
vegetation	Vegetation	The plants of an area considered in general or as communities, but not taxonomically.		\N
\.


--
-- Data for Name: cv_methodtype; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.cv_methodtype (term, name, definition, category, sourcevocabularyuri) FROM stdin;
cruise	Cruise	A method for performing a cruise action.	FieldActivity	\N
dataRetrieval	Data retrieval	A method for retrieving data from a datalogger deployed at a monitoring site.	Equipment	\N
derivation	Derivation	A method for creating results by deriving them from other results.	Observation	\N
equipmentDeployment	Equipment deployment	A method for deploying a piece of equipment that will not make observations at a sampling feature.	Observation	\N
equipmentMaintenance	Equipment maintenance	A method for performing periodic upkeep or servicing of field or laboratory equipment. Maintenance may be performed in the field, in a laboratory, or at a factory maintenance center.	Equipment	\N
equipmentProgramming	Equipment programming	A method for creating or modifying the data collection program running on a datalogger or other equipment deployed at a monitoring site. 		\N
equipmentRetrieval	Equipment retrieval	A method for retrieving equipment from a sampling feature at which or on which it was deployed.	Equipment	\N
estimation	Estimation	A method for creating results by estimation or professional judgement.	Observation	\N
expedition	Expedition	A method for performing an expedition action.	FieldActivity	\N
fieldActivity	Field activity	A method for performing an activity in the field at or on a sampling feature.	FieldActivity	\N
genericNonObservation	Generic non-observation	A method for completing a non-specific action that does not produce a result.	Other	\N
instrumentCalibration	Instrument calibration	A method for calibrating an instrument either in the field or in the laboratory. 	Equipment	\N
instrumentContinuingCalibrationVerification	Instrument Continuing Calibration Verification	A method for verifying the instrument or meter calibration by measuring a calibration standard of known value as if it were a sample and comparing the measured result to the calibration acceptance criteria listed in the Standard Operating Procedure.	Method	\N
instrumentDeployment	Instrument deployment	A method for deploying an instrument to make observations at a sampling feature.	Observation	\N
instrumentRetrieval	Instrument retrieval	A method for retrieving or recovering an instrument that has been deployed at a smpling feature.	Equipment	\N
observation	Observation	A method for creating observation results. This term should be used when a Result is generated but the more specific terms of Instrument deployment or Specimen analysis are not applicable.	Observation	\N
simulation	Simulation	A method for creating results by running a simulation model.	Observation	\N
siteVisit	Site visit	A method for performing a site visit action.	FieldActivity	\N
specimenAnalysis	Specimen analysis	A method for ex situ analysis of a specimen using an instrument, typically in a laboratory, for the purpose of measuring properties of a specimen.	Observation	\N
specimenCollection	Specimen collection	A method for collecting a specimen for ex situ analysis.	SamplingFeature	\N
specimenFractionation	Specimen fractionation	A method for separating a specimen into multiple different fractions or size classes.	SamplingFeature	\N
specimenPreparation	Specimen preparation	A method for processing a specimen collected in the field to produce a sample suitable for analysis using a particular analytical procedure.	SamplingFeature	\N
specimenPreservation	Specimen preservation	A method for preserving a specimen either in the field or in a laboratory prior to ex situ analysis.	SamplingFeature	\N
submersibleLaunch	Submersible launch	A method for launching a submersible from a vessel or ship.	FieldActivity	\N
unknown	Unknown	The method type is unknown.	Other	\N
\.


--
-- Data for Name: cv_organizationtype; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.cv_organizationtype (term, name, definition, category, sourcevocabularyuri) FROM stdin;
analyticalLaboratory	Analytical laboratory	A laboratory within which ex situ analysis of of environmental samples is performed.		\N
association	Association	A group of persons associated for a common purpose.		\N
center	Center	A place where some function or activity occurs.		\N
college	College	An institution of higher education.		\N
company	Company	An business entity that provides services.		\N
consortium	Consortium	An association of individuals or organizations for the purpose of engaging in a joint venture.		\N
department	Department	A subdivision or unit within a university, institution, or agency.		\N
division	Division	A section of a large company, agency, or organization.		\N
faithBasedOrganization	Faith-based organization	An organization whose values are based on faith and/or beliefs, which has a mission based on social values of the particular faith, and which most often draws its activists (leaders, staff, volunteers) from a particular faith group.		\N
foundation	Foundation	An institution or organization supported by a donation or legacy appropriation.		\N
fundingOrganization	Funding organization	An organization that funds research or creative works.		\N
governmentAgency	Government agency	A department or other administrative unit of a government.		\N
institute	Institute	An organization founded to promote a cause.		\N
laboratory	Laboratory	A room, building, or institution equipped for scientific research, experimentation, or analysis.		\N
library	Library	An institution that holds books and or other forms of stored information for use by the public or other experts.		\N
manufacturer	Manufacturer	A person or company that makes a product.		\N
museum	Museum	A building or institution dedicated to the acquisition, conservation, study, exhibition, and educational interpretation of objects having scientific, historical, cultural, or artistic value.		\N
natureCenter	Nature center	An organization that promotes outdoor exploration, provides nature education, and or fosters appreciation and stewardship of the natural world.		\N
nonProfitOrganization	Non-profit organization	An organization dedicated to furthering a particular social cause or advocating for a shared point of view. In economic terms, it is an organization that uses its surplus of revenues to further achieve its ultimate objective, rather than distributing its income to the organization's shareholders, leaders, or members. Non-profits are tax exempt or charitable, meaning they do not pay income tax on the money that they receive for their organization. They can operate in religious, scientific, research, or educational settings.		\N
park	Park	An organization that operates federal, state, county, or municipal parks.		\N
program	Program	A set of structured activities.		\N
publisher	Publisher	An organization that publishes data.		\N
researchAgency	Research agency	A department or other administrative unit of a government with the express purpose of conducting research.		\N
researchInstitute	Research institute	An organization founded to conduct research.		\N
researchOrganization	Research organization	A group of cooperating researchers.		\N
schoolPrimary	School primary	An educational institution providing primary education.		\N
schoolSecondary	School secondary	An educational institution providing secondary education.		\N
studentOrganization	Student organization	A group of students who associate for a particular purpose. 		\N
university	University	An institution of higher education.		\N
unknown	Unknown	The organization type is unknown.		\N
vendor	Vendor	A person or company that sells a product.		\N
youthGroup	Youth group	A group of young people that meet and participate in a variety of activities.		\N
\.


--
-- Data for Name: cv_propertydatatype; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.cv_propertydatatype (term, name, definition, category, sourcevocabularyuri) FROM stdin;
boolean	Boolean	A boolean type is typically a logical type that can be either "true" or "false".		\N
controlledList	Controlled list	A predefined list of strings that a user can select from.		\N
floatingPointNumber	Floating point number	A floating-point number represents a limited-precision rational number that may have a fractional part. 		\N
integer	Integer	An integer data type can hold a whole number, but no fraction. Integers may be either signed (allowing negative values) or unsigned (nonnegative values only). 		\N
string	String	An array of characters including letters, digits, punctuation marks, symbols, etc.		\N
\.


--
-- Data for Name: cv_qualitycode; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.cv_qualitycode (term, name, definition, category, sourcevocabularyuri) FROM stdin;
bad	Bad	A quality assessment has been made and enough of the data quality objectives have not been met that the observation has been assessed to be of bad quality.		\N
good	Good	A quality assessment has been made and all data quality objectives have been met.		\N
marginal	Marginal	A quality assessment has been made and one or more data quality objectives has not been met. The observation may be suspect and has been assessed to be of marginal quality.		\N
none	None	No data quality assessment has been made.		\N
unknown	Unknown	The quality of the observation is unknown.		\N
\.


--
-- Data for Name: cv_relationshiptype; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.cv_relationshiptype (term, name, definition, category, sourcevocabularyuri) FROM stdin;
cites	Cites	Use to indicate a relation to the work that the resource is citing/quoting.		\N
compiles	Compiles	One to many relationship that denotes that the one source resource has been assembled from the target resources through a process of integration and harmonization (as opposed to simple aggregation).	aggregate	\N
continues	Continues	Use to indicate the resource is a continuation of the work referenced by the related identifier.		\N
documents	Documents	Use to indicate the relation to the work which is documentation.		\N
hasPart	Has part	Use to indicate the resource is a container of another resource.		\N
isAttachedTo	Is attached to	Used to indicate that one entity is attached to another. For example this term can be used to express the fact that a piece of equipment is attached to a related piece of equipment.		\N
isChildOf	Is child of	Used to indicate that one entity is an immediate child of another entity. For example, this term can be used to express the fact that an instrument deployment Action is the child of a site visit Action.		\N
isCitationFor	Is citation for	Used to indicate the relationship between a Citation and the entity for which it is the Citation.		\N
isCitedBy	Is cited by	Use to indicate the relation to a work that cites/quotes this data.		\N
isCompiledBy	Is compiled by	Use to indicate the resource or data is compiled/created by using another resource or dataset.		\N
isContinuedBy	Is continued by	Use to indicate the resource is continued by the work referenced by the related identifier.		\N
isDerivedFrom	Is derived from	Used to indicate the relation to the works from which the resource was derived.		\N
isDocumentedBy	Is documented by	Use to indicate the work is documentation about/explaining the resource referenced by the related identifier.		\N
isIdenticalTo	Is identical to	Used to indicate the relation to a work that is identical to the resource.		\N
isNewVersionOf	Is new version of	Use to indicate the resource is a new edition of an old resource, where the new edition has been modified or updated.		\N
isOriginalFormOf	Is original form of	Use to indicate the relation to the works which are variant or different forms of the resource.		\N
isPartOf	Is part of	Use to indicate the resource is a portion of another resource.		\N
isPreviousVersionOf	Is previous version of	Use to indicate the resource is a previous edition of a newer resource.		\N
isReferencedBy	Is referenced by	Use to indicate the resource is used as a source of information by another resource.		\N
isRelatedTo	Is related to	Used to indicate that one entity has a complex relationship with another entity that is not a simple, hierarchical parent-child relationship. For example, this term can be used to express the fact that an instrument cleaning Action is related to an instrument deployment action even though it may be performed as part of a separate site visit.		\N
isRetrievalfor	Is retrieval for	Use to indicate the action is a retrieval of a previous deployment.	Action	\N
isReviewedBy	Is reviewed by	Used to indicate that the work is reviewed by another resource.		\N
isSourceOf	Is source of	Used to indicate the relation to the works that were the source of the resource.		\N
isSupplementTo	Is supplement to	Use to indicate the relation to the work to which the resource is a supplement.		\N
isSupplementedBy	Is supplemented by	Use to indicate the relation to the work(s) which are supplements of the resource.		\N
isVariantFormOf	Is variant form of	Use to indicate the resource is a variant or different form of another resource, e.g. calculated or calibrated form or different packaging.		\N
references	References	Use to indicate the relation to the work which is used as a source of information of the resource.		\N
Reviews	Reviews	Used to indicate that the work reviews another resource.		\N
wasCollectedAt	Was collected at	Used to indicate that one entity was collected at the location of another entity. For example, thirs term can be used to express the fact that a specimen SamplingFeature was collected at a site SamplingFeature.		\N
\.


--
-- Data for Name: cv_resulttype; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.cv_resulttype (term, name, definition, category, sourcevocabularyuri) FROM stdin;
categoryObservation	Category observation	A single ResultValue for a single Variable, measured on or at a single SamplingFeature, using a single Method.	Measurement	\N
countObservation	Count observation	A single ResultValue for a single Variable, counted on or at a single SamplingFeature, using a single Method, and having a specific ProcessingLevel.	Measurement	\N
measurement	Measurement	A single ResultValue for a single Variable, measured on or at a SamplingFeature, using a single Method, with specific Units, and having a specific ProcessingLevel.	Measurement	\N
pointCoverage	Point coverage	A series of ResultValues for a single Variable, measured on or at a single SamplingFeature, using a single Method, with specific Units, having a specific ProcessingLevel, with a fixed ValueDateTime, but measured over varying X,Y locations, where X and Y are horizontal coordinates.	Coverage	\N
profileCoverage	Profile coverage	A series of ResultValues for a single Variable, measured on or at a single SamplingFeature, using a single Method, with specific Units, having a specific ProcessingLevel, but measured over multiple locations along a depth profile with only one varying location dimension (e.g., Z, where Z is depth). ValueDateTime may be fixed or controlled.	Coverage	\N
sectionCoverage	Section coverage	A series of ResultValues for a single Variable, measured on or at a single SamplingFeature, using a single Method, with specific Units, having a specific ProcessingLevel, but measured over varying X (horizontal) and Z (depth) coordinates. ValueDateTime may be fixed or controlled.	Coverage	\N
spectraCoverage	Spectra coverage	A series of ResultValues for a single Variable, measured on or at a single SamplingFeature, using a single Method, with specific Units, having a specific ProcessingLevel, but measured over multiple wavelengths of light. ValueDateTime may be fixed or controlled.	Coverage	\N
temporalObservation	Temporal observation	A single ResultValue for a single Variable, measured on or at a SamplingFeature, using a single Method, with specific Units, and having a specific ProcessingLevel.	Measurement	\N
timeSeriesCoverage	Time series coverage	A series of ResultValues for a single Variable, measured on or at a single SamplingFeature of fixed location, using a single Method, with specific Units, having a specific ProcessingLevel, but measured over time.	Coverage	\N
trajectoryCoverage	Trajectory coverage	A series of ResultValues for a single Variable, measured on a single SamplingFeature, using a single Method, with specific Units, having a specific ProcessingLevel, but measured over varying X,Y, Z, and D locations, where X and Y are horizontal coordinates, Z is a vertical coordinate, and D is the distance along the trajectory. ValueDateTime may be fixed (DTS Temperature) or controlled (glider).	Coverage	\N
transectCoverage	Transect coverage	A series of ResultValues for a single Variable, measured on or at a single SamplingFeature, using a single Method, with specific Units, having a specific ProcessingLevel, but measured over multiple locations along a transect having varying location dimensions (e.g.,  X and/or Y, where X and Y are horizontal coordintes). ValueDateTime may be fixed or controlled.	Coverage	\N
truthObservation	Truth observation	A single ResultValue for a single Variable, measured on or at a single SamplingFeature, using a single Method.	Measurement	\N
trackSeriesCoverage	Track series coverage	A series of ResultValues for a single Variable, measured with a moving platform or some sort of variable location, using a single Method, with specific Units, having a specific ProcessingLevel, and measured over time.	Coverage	\N
\.


--
-- Data for Name: cv_samplingfeaturegeotype; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.cv_samplingfeaturegeotype (term, name, definition, category, sourcevocabularyuri) FROM stdin;
lineString	Line string	A subclass of a Curve using linear interpolation between points. A Curve is a 1-dimensional geometric object usually stored as a sequence of Points. Represented in 2D coordinates by FeatureGeometry.	2D	\N
multiLineString	Multi line string	A collection of individual lines, used as a single feature. Represented in 2D coordinates by FeatureGeometry.	2D	\N
multiPoint	Multi point	A collection of individual points, used as a single feature. Represented in 2D coordinates by FeatureGeometry.	2D	\N
multiPolygon	Multi polygon	A collection of individual polygons, used as a single feature. Represented in 2D coordinates by FeatureGeometry.	2D	\N
notApplicable	Not applicable	The sampling feature has no applicable geospatial feature type	Non-spatial	\N
point	Point	Topological 0-dimensional geometric primitive representing a position. Represented in 2D coordinates by FeatureGeometry.	2D	\N
polygon	Polygon	A planar Surface defined by 1 exterior boundary and 0 or more interior boundaries. Each interior boundary defines a hole in the Polygon. Polygons are topologically closed. Polygons are a subclass of Surface that is planar. A Surface is a 2-dimensonal geometric object. Represented in 2D coordinates by FeatureGeometry.	2D	\N
volume	Volume	A three dimensional space enclosed by some closed boundary.	3D	\N
\.


--
-- Data for Name: cv_samplingfeaturetype; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.cv_samplingfeaturetype (term, name, definition, category, sourcevocabularyuri) FROM stdin;
borehole	Borehole	A narrow shaft bored into the ground, either vertically or horizontally. A borehole includes the hole cavity and walls surrounding that cavity.  	SamplingCurve	\N
crossSection	Cross section	The intersection of a body in three-dimensional space with a plane.  Represented as a polygon. 	SamplingSurface	\N
CTD	CTD	A CTD (Conductivity, Temperature, and Depth) cast is a water column depth profile collected over a specific and relatively short date-time range, that can be considered as a parent specimen.	Specimen	\N
depthInterval	Depth interval	A discrete segment along a longer vertical path, such as a borehole, soil profile or other depth profile, in which an observation or specimen is collected over the distance between the upper and lower depth limits of the interval. A Depth Interval is a sub-type of Interval.	SamplingCurve	\N
ecologicalLandClassification	Ecological land classification	Ecological land classification is a cartographical delineation of distinct ecological areas, identified by their geology, topography, soils, vegetation, climate conditions, living species, habitats, water resources, as well as anthropic factors. These factors control and influence biotic composition and ecological processes.	SamplingSurface	\N
excavation	Excavation	An artificially constructed cavity in the earth that is deeper than the soil, larger than a well bore, and substantially open to the atmosphere. The diameter of an excavation is typically similar or larger than the depth. Excavations include building-foundation diggings, roadway cuts, and surface mines.	SamplingSolid	\N
fieldArea	Field area	A location at which field experiments or observations of ambient conditions are conducted. A field area may contain many sites and has a geographical footprint that can be represented by a polygon.	SamplingSurface	\N
flightline	Flightline	A path along which an aircraft travels while measuring a phenomena of study.	SamplingCurve	\N
interval	Interval	A discrete segment along a longer path in which an observation or specimen is collected over the distance between the upper and lower bounds of the interval. A Depth Interval is a sub-type of Interval.	SamplingCurve	\N
observationWell	Observation well	A hole or shaft constructed in the earth intended to be used to locate, sample, or develop groundwater, oil, gas, or some other subsurface material. The diameter of a well is typically much smaller than the depth. Wells are also used to artificially recharge groundwater or to pressurize oil and gas production zones. Specific kinds of wells should be specified in the SamplingFeature description. For example, underground waste-disposal wells should be classified as waste injection wells.	SamplingCurve	\N
profile	Profile	A one-dimensional grid at fixed (x, y, t) coordinates within a four-dimensional (x, y, z, t) coordinate reference system. The grid axis is aligned with the coordinate reference system z-axis. Typically used to characterize or measure phenomena as a function of depth.	SamplingCurve	\N
quadrat	Quadrat	A small plot used to isolate a standard unit of area for study of the distribution of an item over a large area.	SamplingSurface	\N
scene	Scene	A two-dimensional visual extent within a physical environment.	SamplingSurface	\N
shipsTrack	Ships track	A path along which a ship or vessel travels while measuring a phenomena of study.  Represented as a line connecting the ship's consecutive positions on the surface of the earth.	SamplingCurve	\N
site	Site	A facility or location at which observations have been collected. A site may have instruments or equipment installed and may contain multiple other sampling features (e.g., a stream gage, weather station, observation well, etc.). Additionally, many specimen sampling features may be collected at a site. Sites are also often referred to as stations. A site is represented as a point, but it may have a geographical footprint that is not a point. The site coordinates serve as a reference for the site and offsets may be specified from this reference location.	SamplingPoint	\N
soilPitSection	Soil pit section	Two-dimensional vertical face of a soil pit that is described and sampled.	SamplingSurface	\N
specimen	Specimen	A physical sample (object or entity) obtained for observations, typically performed ex situ, often in a laboratory.  	Specimen	\N
streamGage	Stream gage	A location used to monitor and test terrestrial bodies of water. Hydrometric measurements of water level, surface elevation ("stage") and/or volumetric discharge (flow) are generally taken, and observations of biota and water quality may also be made. 	SamplingPoint	\N
trajectory	Trajectory	The path that a moving object follows through space as a function of time. A trajectory can be described by the geometry of the path or as the position of the object over time. 	SamplingCurve	\N
transect	Transect	A path along which ocurrences of a phenomena of study are counted or measured.	SamplingCurve	\N
traverse	Traverse	A field control network consisting of survey stations placed along a line or path of travel.	SamplingCurve	\N
waterQualityStation	Water quality station	A location used to monitor and test the quality of terrestrial bodies of water. Water quality stations may be locations at which physical water samples are collected for ex situ analysis.  Water qulaity stations may also have instruments and equipment for continuous, in situ measurement of water quality variables. 	SamplingPoint	\N
weatherStation	Weather station	A facility, either on land or sea, with instruments and equipment for measuring atmospheric conditions to provide information for weather forecasts and to study weather and climate.	SamplingPoint	\N
\.


--
-- Data for Name: cv_sitetype; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.cv_sitetype (term, name, definition, category, sourcevocabularyuri) FROM stdin;
aggregateGroundwaterUse	Aggregate groundwater use	An Aggregate Groundwater Withdrawal/Return site represents an aggregate of specific sites where groundwater is withdrawn or returned which is defined by a geographic area or some other common characteristic. An aggregate groundwater site type is used when it is not possible or practical to describe the specific sites as springs or as any type of well including 'multiple wells', or when water-use information is only available for the aggregate. 	Aggregated Use Sites	\N
aggregateSurfaceWaterUse	Aggregate surface-water-use	An Aggregate Surface-Water Diversion/Return site represents an aggregate of specific sites where surface water is diverted or returned which is defined by a geographic area or some other common characteristic. An aggregate surface-water site type is used when it is not possible or practical to describe the specific sites as diversions, outfalls, or land application sites, or when water-use information is only available for the aggregate. 	Aggregated Use Sites	\N
aggregateWaterUseEstablishment	Aggregate water-use establishment	An Aggregate Water-Use Establishment represents an aggregate class of water-using establishments or individuals that are associated with a specific geographic location and water-use category, such as all the industrial users located within a county or all self-supplied domestic users in a county. An aggregate water-use establishment site type is used when specific information needed to create sites for the individual facilities or users is not available or when it is not desirable to store the site-specific information in the database. 	Aggregated Use Sites	\N
animalWasteLagoon	Animal waste lagoon	A facility for storage and/or biological treatment of wastes from livestock operations. Animal-waste lagoons are earthen structures ranging from pits to large ponds, and contain manure which has been diluted with building washwater, rainfall, and surface runoff. In treatment lagoons, the waste becomes partially liquefied and stabilized by bacterial action before the waste is disposed of on the land and the water is discharged or re-used.	Facility Sites	\N
atmosphere	Atmosphere	A site established primarily to measure meteorological properties or atmospheric deposition.	Atmospheric Sites	\N
canal	Canal	An artificial watercourse designed for navigation, drainage, or irrigation by connecting two or more bodies of water; it is larger than a ditch.	Surface Water Sites	\N
cave	Cave	A natural open space within a rock formation large enough to accommodate a human. A cave may have an opening to the outside, is always underground, and sometimes submerged. Caves commonly occur by the dissolution of soluble rocks, generally limestone, but may also be created within the voids of large-rock aggregations, in openings along seismic faults, and in lava formations.	Groundwater Sites	\N
cistern	Cistern	An artificial, non-pressurized reservoir filled by gravity flow and used for water storage. The reservoir may be located above, at, or below ground level. The water may be supplied from diversion of precipitation, surface, or groundwater sources.	Water Infrastructure Sites	\N
coastal	Coastal	An oceanic site that is located off-shore beyond the tidal mixing zone (estuary) but close enough to the shore that the investigator considers the presence of the coast to be important. Coastal sites typically are within three nautical miles of the shore.	Surface Water Sites	\N
combinedSewer	Combined sewer	An underground conduit created to convey storm drainage and waste products into a wastewater-treatment plant, stream, reservoir, or disposal site.	Water Infrastructure Sites	\N
composite	Composite	A Composite site represents an aggregation of specific sites defined by a geographic location at which multiple sampling features have been installed. For example, a composite site might consist of a location on a stream where a streamflow gage, weather station, and shallow groundwater well have been installed.	Composite Sites	\N
criticalZoneObservatories	Critical Zone Observatories	Critical Zone Observatories (CZOs) address pressing interdisciplinary scientific questions concerning geological, physical, chemical, and biological processes and their couplings that govern critical zone system dynamics.	Observatory Sites	\N
ditch	Ditch	An excavation artificially dug in the ground, either lined or unlined, for conveying water for drainage or irrigation; it is smaller than a canal.	Surface Water Sites	\N
diversion	Diversion	A site where water is withdrawn or diverted from a surface-water body (e.g. the point where the upstream end of a canal intersects a stream, or point where water is withdrawn from a reservoir). Includes sites where water is pumped for use elsewhere.	Surface Water Sites	\N
estuary	Estuary	A coastal inlet of the sea or ocean; esp. the mouth of a river, where tide water normally mixes with stream water (modified, Webster). Salinity in estuaries typically ranges from 1 to 25 Practical Salinity Units (psu), as compared oceanic values around 35-psu. See also: tidal stream and coastal.	Surface Water Sites	\N
facility	Facility	A non-ambient location where environmental measurements are expected to be strongly influenced by current or previous activities of humans. *Sites identified with a "facility" primary site type must be further classified with one of the applicable secondary site types.	Facility Sites	\N
fieldPastureOrchardOrNursery	Field, Pasture, Orchard, or Nursery	A water-using facility characterized by an area where plants are grown for transplanting, for use as stocks for budding and grafting, or for sale. Irrigation water may or may not be applied.	Facility Sites	\N
glacier	Glacier	Body of land ice that consists of recrystallized snow accumulated on the surface of the ground and moves slowly downslope (WSP-1541A) over a period of years or centuries. Since glacial sites move, the lat-long precision for these sites is usually coarse.	Glacier Sites	\N
golfCourse	Golf course	A place-of-use, either public or private, where the game of golf is played. A golf course typically uses water for irrigation purposes. Should not be used if the site is a specific hydrologic feature or facility; but can be used especially for the water-use sites.	Facility Sites	\N
groundwaterDrain	Groundwater drain	An underground pipe or tunnel through which groundwater is artificially diverted to surface water for the purpose of reducing erosion or lowering the water table. A drain is typically open to the atmosphere at the lowest elevation, in contrast to a well which is open at the highest point.	Groundwater Sites	\N
house	House	A residential building for a single or small number of families.	Facility Sites	\N
hydroelectricPlant	Hydroelectric plant	A facility that generates electric power by converting potential energy of water into kinetic energy. Typically, turbine generators are turned by falling water.	Facility Sites	\N
waterSupplyTreatmentPlant	Water-supply treatment plant	A facility where water is treated prior to use for consumption or other purpose.	Facility Sites	\N
laboratoryOrSamplePreparationArea	Laboratory or sample-preparation area	A site where some types of quality-control samples are collected, and where equipment and supplies for environmental sampling are prepared. Equipment blank samples are commonly collected at this site type, as are samples of locally produced deionized water. This site type is typically used when the data are either not associated with a unique environmental data-collection site, or where blank water supplies are designated by Center offices with unique station IDs.	Facility Sites	\N
lakeReservoirImpoundment	Lake, Reservoir, Impoundment	An inland body of standing fresh or saline water that is generally too deep to permit submerged aquatic vegetation to take root across the entire body (cf: wetland). This site type includes an expanded part of a river, a reservoir behind a dam, and a natural or excavated depression containing a water body without surface-water inlet and/or outlet.	Surface Water Sites	\N
land	Land	A location on the surface of the earth that is not normally saturated with water. Land sites are appropriate for sampling vegetation, overland flow of water, or measuring land-surface properties such as temperature. (See also: Wetland).	Land Sites	\N
landfill	Landfill	A typically dry location on the surface of the land where primarily solid waste products are currently, or previously have been, aggregated and sometimes covered with a veneer of soil. See also: Wastewater disposal and waste-injection well.	Facility Sites	\N
networkInfrastructure	Network infrastructure	A site that is primarily associated with monitoring or telemetry network infrastructure. For example a radio repeater or remote radio base station.	infrastructure	\N
ocean	Ocean	Site in the open ocean, gulf, or sea. (See also: Coastal, Estuary, and Tidal stream).	Surface Water Sites	\N
outcrop	Outcrop	The part of a rock formation that appears at the surface of the surrounding land.	Land Sites	\N
outfall	Outfall	A site where water or wastewater is returned to a surface-water body, e.g. the point where wastewater is returned to a stream. Typically, the discharge end of an effluent pipe.	Facility Sites	\N
pavement	Pavement	A surface site where the land surface is covered by a relatively impermeable material, such as concrete or asphalt. Pavement sites are typically part of transportation infrastructure, such as roadways, parking lots, or runways.	Land Sites	\N
playa	Playa	A dried-up, vegetation-free, flat-floored area composed of thin, evenly stratified sheets of fine clay, silt or sand, and represents the bottom part of a shallow, completely closed or undrained desert lake basin in which water accumulates and is quickly evaporated, usually leaving deposits of soluble salts.	Land Sites	\N
septicSystem	Septic system	A site within or in close proximity to a subsurface sewage disposal system that generally consists of: (1) a septic tank where settling of solid material occurs, (2) a distribution system that transfers fluid from the tank to (3) a leaching system that disperses the effluent into the ground.	Water Infrastructure Sites	\N
shore	Shore	The land along the edge of the sea, a lake, or a wide river where the investigator considers the proximity of the water body to be important. Land adjacent to a reservoir, lake, impoundment, or oceanic site type is considered part of the shore when it includes a beach or bank between the high and low water marks.	Land Sites	\N
sinkhole	Sinkhole	A crater formed when the roof of a cavern collapses; usually found in limestone areas. Surface water and precipitation that enters a sinkhole usually evaporates or infiltrates into the ground, rather than draining into a stream.	Land Sites	\N
soilHole	Soil hole	A small excavation into soil at the top few meters of earth surface. Soil generally includes some organic matter derived from plants. Soil holes are created to measure soil composition and properties. Sometimes electronic probes are inserted into soil holes to measure physical properties, and (or) the extracted soil is analyzed.	Land Sites	\N
spring	Spring	A location at which the water table intersects the land surface, resulting in a natural flow of groundwater to the surface. Springs may be perennial, intermittent, or ephemeral.	Spring Sites	\N
stormSewer	Storm sewer	An underground conduit created to convey storm drainage into a stream channel or reservoir. If the sewer also conveys liquid waste products, then the "combined sewer" secondary site type should be used.	Water Infrastructure Sites	\N
stream	Stream	A body of running water moving under gravity flow in a defined channel. The channel may be entirely natural, or altered by engineering practices through straightening, dredging, and (or) lining. An entirely artificial channel should be qualified with the "canal" or "ditch" secondary site type.	Surface Water Sites	\N
subsurface	Subsurface	A location below the land surface, but not a well, soil hole, or excavation.	Groundwater Sites	\N
thermoelectricPlant	Thermoelectric plant	A facility that uses water in the generation of electricity from heat. Typically turbine generators are driven by steam. The heat may be caused by various means, including combustion, nuclear reactions, and geothermal processes.	Facility Sites	\N
tidalStream	Tidal stream	A stream reach where the flow is influenced by the tide, but where the water chemistry is not normally influenced. A site where ocean water typically mixes with stream water should be coded as an estuary.	Surface Water Sites	\N
tunnelShaftMine	Tunnel, shaft, or mine	A constructed subsurface open space large enough to accommodate a human that is not substantially open to the atmosphere and is not a well. The excavation may have been for minerals, transportation, or other purposes. See also: Excavation.	Groundwater Sites	\N
unknown	Unknown	Site type is unknown.	Unknown	\N
unsaturatedZone	Unsaturated zone	A site equipped to measure conditions in the subsurface deeper than a soil hole, but above the water table or other zone of saturation.	Groundwater Sites	\N
volcanicVent	Volcanic vent	Vent from which volcanic gases escape to the atmosphere. Also known as fumarole.	Geologic Sites	\N
wastewaterLandApplication	Wastewater land application	A site where the disposal of waste water on land occurs. Use "waste-injection well" for underground waste-disposal sites.	Land Sites	\N
wastewaterSewer	Wastewater sewer	An underground conduit created to convey liquid and semisolid domestic, commercial, or industrial waste into a treatment plant, stream, reservoir, or disposal site. If the sewer also conveys storm water, then the "combined sewer" secondary site type should be used.	Water Infrastructure Sites	\N
wastewaterTreatmentPlant	Wastewater-treatment plant	A facility where wastewater is treated to reduce concentrations of dissolved and (or) suspended materials prior to discharge or reuse.	Facility Sites	\N
waterDistributionSystem	Water-distribution system	A site located somewhere on a networked infrastructure that distributes treated or untreated water to multiple domestic, industrial, institutional, and (or) commercial users. May be owned by a municipality or community, a water district, or a private concern.	Water Infrastructure Sites	\N
waterUseEstablishment	Water-use establishment	A place-of-use (a water using facility that is associated with a specific geographical point location, such as a business or industrial user) that cannot be specified with any other facility secondary type. Water-use place-of-use sites are establishments such as a factory, mill, store, warehouse, farm, ranch, or bank. See also: Aggregate water-use-establishment.	Facility Sites	\N
wetland	Wetland	Land where saturation with water is the dominant factor determining the nature of soil development and the types of plant and animal communities living in the soil and on its surface (Cowardin, December 1979). Wetlands are found from the tundra to the tropics and on every continent except Antarctica. Wetlands are areas that are inundated or saturated by surface or groundwater at a frequency and duration sufficient to support, and that under normal circumstances do support, a prevalence of vegetation typically adapted for life in saturated soil conditions. Wetlands generally include swamps, marshes, bogs and similar areas. Wetlands may be forested or unforested, and naturally or artificially created.	Surface Water Sites	\N
\.


--
-- Data for Name: cv_spatialoffsettype; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.cv_spatialoffsettype (term, name, definition, category, sourcevocabularyuri) FROM stdin;
cartesianOffset	Cartesian offset	Offset expressed using cartesian coordinates where X is distance along axis aligned with true north, Y is distace aligned with true east, and Z is distance aligned straight up. Depths are expressed a negative numbers. The origin of the coordinate system is typically defined in the site description. 	3D	\N
depth	Depth	Depth below the earth or water surface. Values are expressed as negative numbers and become more negative in the downward direction.	1D	\N
depthInterval	Depth interval	Depth interval below the earth or water surface. The mininum depth value is expressed first and then maximum depth value. Values are expresssed as negative numbers and become more negative in the downward direction.	2D	\N
depthDirectional	Depth, directional	Depth below the earth or water surface along a non-vertical line. The first coordinate is the angle of the ray from north expressed in degrees. The second coordinate is the angle of the ray from horizontal expressed in negative degrees. The distance along the ray is expressed as a positive number that increases with distance along the ray. 	3D	\N
height	Height	Height above the earth or water surface. Values are positive and increase in the upward direction.	1D	\N
heightInterval	Height interval	Height interval above the earth or water surface. The minimum height value is expressed first and then the maximum height value. Values increase in the upward direction.	2D	\N
heightDirectional	Height, directional	Height above the earth or water surface along a non-vertical line. The first coordinate is the angle of the ray from north expressed in degrees. The second coordinate is the angle of the ray from horizontal expressed in positive degrees. The distance along the ray is expressed as a positive number that increases with distance along the ray. 	3D	\N
longitudinalInterval	Longitudinal interval	Interval along a horizontal or longitudinal ray. The first coordinate is the angle from north expressed in degrees of the longitudinal array. The second coordinate is the minimum distance along the ray at which the longitudinal interval begins. The third coordinate is the maximium distance along the ray at which the longitudinal interval ends.	3D	\N
radialHorizontalOffset	Radial horizontal offset	Offset expressed as a distance along a ray that originates from a central point. The angle of the ray is expressed as the first offset coordinate in degrees. The distance along the ray is expressed as the second offset coordinate.	2D	\N
radialHorizontalOffsetWithDepth	Radial horizontal offset with depth	Offset expressed as a distance along a ray that originates from a central point with a third coordinate that indicates the depth below the earth or water surface. The angle of the ray is expressed as the first offset coordinate in degrees. The distance along the ray is expressed as the second offset coordinate. The depth below the earth or water surface is expressed as the third coordinate.	3D	\N
radialHorizontalOffsetWithHeight	Radial horizontal offset with height	Offset expressed as a distance along a ray that originates from a central point with a third coordinate that indicates the height above the earth or water surface. The angle of the ray is expressed as the first offset coordinate in degrees. The distance along the ray is expressed as the second offset coordinate. The height above the earth or water surface is expressed as the third coordinate.	3D	\N
\.


--
-- Data for Name: cv_speciation; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.cv_speciation (term, name, definition, category, sourcevocabularyuri) FROM stdin;
Ag	Ag	Expressed as silver		\N
Al	Al	Expressed as aluminium		\N
As	As	Expressed as arsenic		\N
B	B	Expressed as boron		\N
Ba	Ba	Expressed as barium		\N
Be	Be	Expressed as beryllium		\N
Br	Br	Expressed as bromine		\N
C	C	Expressed as carbon		\N
C10H10O4	C10H10O4	Expressed as dimethyl terephthalate		\N
C10H4_CH3_4	C10H4(CH3)4	Expressed as tetramethylnaphthalene		\N
C10H5_CH3_3	C10H5(CH3)3	Expressed as trimethylnaphthalene		\N
C10H6_CH3_2	C10H6(CH3)2	Expressed as dimethylnaphthalene		\N
C10H7C2H5	C10H7C2H5	Expressed as ethylnaphthalene		\N
C10H7CH3	C10H7CH3	Expressed as methylnaphthalene		\N
C10H8	C10H8	Expressed as naphthalene		\N
C12H10	C12H10	Expressed as C12H10, e.g., acenaphthene, biphenyl		\N
C12H14O4	C12H14O4	Expressed as diethyl phthalate		\N
C12H8	C12H8	Expressed as acenaphthylene		\N
C12H8O	C12H8O	Expressed as dibenzofuran		\N
C12H8S	C12H8S	Expressed as dibenzothiophene		\N
C12H9N	C12H9N	Expressed as carbazole		\N
C13H10	C13H10	Expressed as fluorene		\N
C13H10S	C13H10S	Expressed as methyldibenzothiophene		\N
C14H10	C14H10	Expressed as phenanthrene		\N
C14H12	C14H12	Expressed as methylfluorene		\N
C15H12	C15H12	Expressed as C15H12, e.g., methylphenanthrene, Methylanthracene		\N
C15H32	C15H32	Expressed as C15 n-alkane		\N
C16H10	C16H10	Expressed as C16H10, e.g., fluoranthene, pyrene		\N
C16H14	C16H14	Expressed as dimethylphenanthrene		\N
C16H34	C16H34	Expressed as C16 n-alkane		\N
C17H12	C17H12	Expressed as C17H12, e.g., benzo(a)fluorene, methylfluoranthene, methylpyrene		\N
C17H36	C17H36	Expressed as C17 n-alkane		\N
C18H12	C18H12	Expressed as C18H12, e.g., benz(a)anthracene, chrysene, triphenylene		\N
C18H18	C18H18	Expressed as retene		\N
C18H38	C18H38	Expressed as C18 n-alkane		\N
C19H14	C19H14	Expressed as methylchrysene		\N
C19H20O4	C19H20O4	Expressed as benzyl butyl pththalate		\N
C19H40	C19H40	Expressed as C19 n-alkane		\N
C20H12	C20H12	Expressed as C20H12, e.g., benzo(b)fluoranthene, benzo(e)pyrene, perylene		\N
C20H42	C20H42	Expressed as C20 n-alkane		\N
C21H44	C21H44	Expressed as C21 n-alkane		\N
C22H14	C22H14	Expressed as Dibenz(a,h)anthracene		\N
C22H46	C22H46	Expressed as C22 n-alkane		\N
C23H48	C23H48	Expressed as C23 n-alkane		\N
C24H50	C24H50	Expressed as C24 n-alkane		\N
C25H52	C25H52	Expressed as C25 n-alkane		\N
C26H54	C26H54	Expressed as C26 n-alkane		\N
C27H56	C27H56	Expressed as C27 n-alkane		\N
C28H58	C28H58	Expressed as C28 n-alkane		\N
C29H60	C29H60	Expressed as C29 n-alkane		\N
C2Cl4	C2Cl4	Expressed as tetrachloroethylene		\N
C2Cl6	C2Cl6	Expressed as hexachloroethane		\N
C2H2Cl4	C2H2Cl4	Expressed as tetrachloroethane		\N
C2H3Cl	C2H3Cl	Expressed as vinyl chloride		\N
C2H3Cl3	C2H3Cl3	Expressed as trichloroethane		\N
C2H4Cl2	C2H4Cl2	Expressed as dichloroethane		\N
C2H5Cl	C2H5Cl	Expressed as chloroethane		\N
C2H6	C2H6	Expressed as ethane		\N
C2H6O2	C2H6O2	Expressed as Ethylene glycol		\N
C2HCl3	C2HCl3	Expressed as trichloroethylene		\N
C31H64	C31H64	Expressed as C31 n-alkane		\N
C3H6O	C3H6O	Expressed as acetone		\N
C4Cl6	C4Cl6	Expressed as hexchlorobutadiene		\N
C4H8Cl2O	C4H8Cl2O	Expressed as bis(chloroethyl) ether		\N
C4H8O	C4H8O	Expressed as butanone		\N
C5Cl6	C5Cl6	Expressed as hexachlorocyclopentadiene		\N
C6Cl6	C6Cl6	Expressed as hexachlorobenzene		\N
C6H3Cl3	C6H3Cl3	Expressed as trichlorobenzene		\N
C6H4_CH3_2	C6H4(CH3)2	Expressed as xylenes		\N
C6H4Cl2	C6H4Cl2	Expressed as dichlorobenzene		\N
C6H4N2O5	C6H4N2O5	Expressed as dinitrophenol		\N
C6H5Cl	C6H5Cl	Expressed as chlorobenzene		\N
C6H5NH2	C6H5NH2	Expressed as aniline		\N
C6H5NO2	C6H5NO2	Expressed as nitrobenzene		\N
C6H5OH	C6H5OH	Expressed as phenol		\N
C6H6	C6H6	Expressed as benzene		\N
C6HCl5O	C6HCl5O	Expressed as pentachlorophenol		\N
C7H6N2O4	C7H6N2O4	Expressed as dinitrotoluene		\N
C7H8	C7H8	Expressed as Toluene		\N
C8H10	C8H10	Expressed as ethylbenzene		\N
C8H8	C8H8	Expressed as styrene		\N
C9H14O	C9H14O	Expressed as isophorone		\N
Ca	Ca	Expressed as calcium		\N
CaCO3	CaCO3	Expressed as calcium carbonate		\N
Cd	Cd	Expressed as cadmium		\N
CH2Cl2	CH2Cl2	Expressed as dichloromethane		\N
CH3Br	CH3Br	Expressed as bromomethane		\N
CH3Cl	CH3Cl	Expressed as chloromethane		\N
CH3Hg	CH3Hg	Expressed at methylmercury		\N
CH4	CH4	Expressed as methane		\N
CHBr2Cl	CHBr2Cl	Expressed as dibromochloromethane		\N
CHBr3	CHBr3	Expressed as bromoform		\N
CHBrCl2	CHBrCl2	Expressed as bromodichloromethane		\N
CHCl3	CHCl3	Expressed as chloroform		\N
Cl	Cl	Expressed as chlorine		\N
CN-	CN-	Expressed as cyanide		\N
Co	Co	Expressed as cobalt		\N
CO2	CO2	Expressed as carbon dioxide		\N
CO3	CO3	Expressed as carbonate		\N
Cr	Cr	Expressed as chromium		\N
Cu	Cu	Expressed as copper		\N
delta2H	delta 2H	Expressed as deuterium		\N
deltaN15	delta N15	Expressed as nitrogen-15		\N
deltaO18	delta O18	Expressed as oxygen-18		\N
EC	EC	Expressed as electrical conductivity		\N
F	F	Expressed as fluorine		\N
Fe	Fe	Expressed as iron		\N
H2O	H2O	Expressed as water		\N
HCO3	HCO3	Expressed as hydrogen carbonate		\N
Hg	Hg	Expressed as mercury		\N
K	K	Expressed as potassium		\N
Mg	Mg	Expressed as magnesium		\N
Mn	Mn	Expressed as manganese		\N
Mo	Mo	Expressed as molybdenum		\N
N	N	Expressed as nitrogen		\N
Na	Na	Expressed as sodium		\N
NH4	NH4	Expressed as ammonium		\N
Ni	Ni	Expressed as nickel		\N
NO2	NO2	Expressed as nitrite		\N
NO3	NO3	Expressed as nitrate		\N
notApplicable	Not Applicable	Speciation is not applicable		\N
O2	O2	Expressed as oxygen (O2)		\N
P	P	Expressed as phosphorus		\N
Pb	Pb	Expressed as lead		\N
pH	pH	Expressed as pH		\N
PO4	PO4	Expressed as phosphate		\N
Ra	Ra	Expressed as Radium. Also known as "radium equivalent." The radium equivalent concept allows a single index or number to describe the gamma output from different mixtures of uranium (i.e., radium), thorium, and 40K in a material.		\N
Re	Re	Expressed as rhenium		\N
S	S	Expressed as Sulfur		\N
Sb	Sb	Expressed as antimony		\N
Se	Se	Expressed as selenium		\N
Si	Si	Expressed as silicon		\N
SiO2	SiO2	Expressed as silicate		\N
Sn	Sn	Expressed as tin		\N
SO4	SO4	Expressed as Sulfate		\N
Sr	Sr	Expressed as strontium		\N
TA	TA	Expressed as total alkalinity		\N
Th	Th	Expressed as thorium		\N
Ti	Ti	Expressed as titanium		\N
Tl	Tl	Expressed as thallium		\N
U	U	Expressed as uranium		\N
unknown	Unknown	Speciation is unknown		\N
V	V	Expressed as vanadium		\N
Zn	Zn	Expressed as zinc		\N
Zr	Zr	Expressed as zirconium		\N
\.


--
-- Data for Name: cv_specimentype; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.cv_specimentype (term, name, definition, category, sourcevocabularyuri) FROM stdin;
automated	Automated	Sample collected using an automated sampler.		\N
biota	Biota	A specimen consisting of all or part of a biological organism, including flora or fauna.		\N
core	Core	Long cylindrical cores		\N
coreHalfRound	Core half round	Half-cylindrical products of along-axis split of a whole round		\N
corePiece	Core piece	Material occurring between unambiguous [as curated] breaks in recovery.		\N
coreQuarterRound	Core quarter round	Quarter-cylindrical products of along-axis split of a half round.		\N
coreSection	Core section	Arbitrarily cut segments of a "core"		\N
coreSectionHalf	Core section half	Half-cylindrical products of along-axis split of a section or its component fragments through a selected diameter.		\N
coreSub-Piece	Core sub-piece	Unambiguously mated portion of a larger piece noted for curatorial management of the material.		\N
coreWholeRound	Core whole round	Cylindrical segments of core or core section material.		\N
cuttings	Cuttings	Loose, coarse, unconsolidated material suspended in drilling fluid.		\N
dredge	Dredge	A group of rocks collected by dragging a dredge along the seafloor.		\N
foliageDigestion	Foliage digestion	Sample that consists of a digestion of plant foliage		\N
foliageLeaching	Foliage leaching	Sample that consists of leachate from foliage		\N
forestFloorDigestion	Forest floor digestion	Sample that consists of a digestion of forest floor material		\N
grab	Grab	A sample (sometimes mechanically collected) from a deposit or area, not intended to be representative of the deposit or area.		\N
individualSample	Individual sample	A sample that is an individual unit, including rock hand samples, a biological specimen, or a bottle of fluid.		\N
litterFallDigestion	Litter fall digestion	Sample that consists of a digestion of litter fall		\N
orientedCore	Oriented core	Core that can be positioned on the surface in the same way that it was arranged in the borehole before extraction.		\N
other	Other	Sample does not fit any of the existing type designations. It is expected that further detailed description of the particular sample be provided.		\N
petriDishDryDeposition	Petri dish (dry deposition)	Sample from dry deposition in a petri dish		\N
precipitationBulk	Precipitation bulk	Sample from bulk precipitation		\N
rockPowder	Rock powder	A sample created from pulverizing a rock to powder.		\N
standardReferenceSpecimen	Standard reference specimen	Standard reference specimen		\N
terrestrialSection	Terrestrial section	A sample of a section of the near-surface Earth, generally in the critical zone.		\N
theSpecimenTypeIsUnknown	The specimen type is unknown	The specimen type is unknown		\N
thinSection	Thin section	Thin section		\N
\.


--
-- Data for Name: cv_status; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.cv_status (term, name, definition, category, sourcevocabularyuri) FROM stdin;
complete	Complete	Data collection is complete. No new data values will be added.		\N
ongoing	Ongoing	Data collection is ongoing.  New data values will be added periodically.		\N
planned	Planned	Data collection is planned. Resulting data values do not yet exist, but will eventually.		\N
unknown	Unknown	The status of data collection is unknown.		\N
\.


--
-- Data for Name: cv_taxonomicclassifiertype; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.cv_taxonomicclassifiertype (term, name, definition, category, sourcevocabularyuri) FROM stdin;
biology	Biology	A taxonomy containing terms associated with biological organisms.		\N
chemistry	Chemistry	A taxonomy containing terms associated with chemistry, chemical analysis or processes.		\N
climate	Climate	A taxonomy containing terms associated with the climate, weather, or atmospheric processes.		\N
geology	Geology	A taxonomy containing terms associated with geology or geological processes.		\N
hydrology	Hydrology	A taxonomy containing terms associated with hydrologic variables or processes.		\N
instrumentation	Instrumentation	A taxonomy containing terms associated with instrumentation and instrument properties such as battery voltages, data logger temperatures, often useful for diagnosis.		\N
lithology	Lithology	A taxonomy containing terms associated with lithology.		\N
rock	Rock	A taxonomy containing terms describing rocks.		\N
soil	Soil	A taxonomy containing terms associated with soil variables or processes		\N
soilColor	Soil color	A taxonomy containing terms describing soil color.	Soil	\N
soilHorizon	Soil horizon	A taxonomy containing terms describing soil horizons.	Soil	\N
soilStructure	Soil structure	A taxonomy containing terms describing soil structure.	Soil	\N
soilTexture	Soil texture	A taxonomy containing terms describing soil texture.	Soil	\N
waterQuality	Water quality	A taxonomy containing terms associated with water quality variables or processes.		\N
\.


--
-- Data for Name: cv_unitstype; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.cv_unitstype (term, name, definition, category, sourcevocabularyuri) FROM stdin;
absorbedDose	Absorbed dose	Absorbed dose (also known as Total Ionizing Dose, TID) is a measure of the energy deposited in a medium by ionizing radiation. It is equal to the energy deposited per unit mass of medium, and so has the unit J/kg, which is given the special name Gray (Gy). Note that the absorbed dose is not a good indicator of the likely biological effect. 1 Gy of alpha radiation would be much more biologically damaging than 1 Gy of photon radiation for example. Appropriate weighting factors can be applied reflecting the different relative biological effects to find the equivalent dose. The risk of stoctic effects due to radiation exposure can be quantified using the effective dose, which is a weighted average of the equivalent dose to each organ depending upon its radiosensitivity. When ionising radiation is used to treat cancer, the doctor will usually prescribe the radiotherapy treatment in Gy. When risk from ionising radiation is being discussed, a related unit, the Sievert is used.	Radiology	\N
absorbedDoseRate	Absorbed dose rate	Absorbed dose per unit time.	Radiology	\N
amountOfInformation	Amount of Information	In computing and telecommunications, a unit of information is the capacity of some standard data storage system or communication channel, used to measure the capacities of other systems and channels. In information theory, units of information are also used to measure the information contents or entropy of random variables.	Information	\N
angle	Angle	In geometry, an angle (or plane angle) is the figure formed by two rays or line segments, called the sides of the angle, sharing a common endpoint, called the vertex of the angle. Euclid defines a plane angle as the inclination to each other, in a plane, of two lines which meet each other, and do not lie straight with respect to each other.	Space and Time	\N
angularAcceleration	Angular acceleration	Angular acceleration is the rate of change of angular velocity over time. Measurement of the change made in the rate of change of an angle that a spinning object undergoes per unit time. It is a vector quantity. Also called Rotational acceleration. In SI units, it is measured in radians per second squared (rad/s^2), and is usually denoted by the Greek letter alpha.	Space and Time	\N
angularMass	Angular mass	The units of angular mass have dimensions of mass * area. They are used to measure the moment of inertia or rotational inertia.	Space and Time	\N
angularMomentum	Angular momentum	Quantity of rotational motion. Linear momentum is the quantity obtained by multiplying the mass of a body by its linear velocity. Angular momentum is the quantity obtained by multiplying the moment of inertia of a body by its angular velocity. The momentum of a system of particles is given by the sum of the momenta of the individual particles which make up the system or by the product of the total mass of the system and the velocity of the center of gravity of the system. The momentum of a continuous medium is given by the integral of the velocity over the mass of the medium or by the product of the total mass of the medium and the velocity of the center of gravity of the medium. In physics, the angular momentum of an object rotating about some reference point is the measure of the extent to which the object will continue to rotate about that point unless acted upon by an external torque. In particular, if a point mass rotates about an axis, then the angular momentum with respect to a point on the axis is related to the mass of the object, the velocity and the distance of the mass to the axis. While the motion associated with linear momentum has no absolute frame of reference, the rotation associated with angular momentum is sometimes spoken of as being measured relative to the fixed stars.  The physical quantity "action" has the same units as angular momentum.	Mechanics	\N
angularVelocityOrFrequency	Angular velocity or frequency	The change of angle per unit time; specifically, in celestial mechanics, the change in angle of the radius vector per unit time.  Angular frequency is a scalar measure of rotation rate. It is the magnitude of the vector quantity angular velocity.	Space and Time	\N
area	Area	Area is a quantity expressing the two-dimensional size of a defined part of a surface, typically a region bounded by a closed curve.	Space and Time	\N
areaAngle	Area angle		Space and Time	\N
areaPerLength	Area per length	A type of Linear Density.	Space and Time	\N
areaTemperature	Area temperature		Thermodynamics	\N
areaThermalExpansion	Area thermal expansion	When the temperature of a substance changes, the energy that is stored in the intermolecular bonds between atoms changes. When the stored energy increases, so does the length of the molecular bonds. As a result, solids typically expand in response to heating and contract on cooling; this dimensional response to temperature change is expressed by its coefficient of thermal expansion. Different coefficients of thermal expansion can be defined for a substance depending on whether the expansion is measured by: * linear thermal expansion * area thermal expansion * volumetric thermal expansion These characteristics are closely related. The volumetric thermal expansion coefficient can be defined for both liquids and solids. The linear thermal expansion can only be defined for solids, and is common in engineering applications. Some substances expand when cooled, such as freezing water, so they have negative thermal expansion coefficients. [Wikipedia: https://en.wikipedia.org/wiki/Thermal_expansion]	Thermodynamics	\N
areaTime	Area time		Space and Time	\N
areaTimeTemperature	Area time temperature		Thermodynamics	\N
arealFlux	Areal flux	Areal flux is the rate of flow of mass across a unit area per time	Mechanics	\N
biologicalActivity	Biological activity	Units used mainly in chemical and biochemical laboratories.	Chemistry	\N
catalyticActivity	Catalytic activity	Catalytic activity is usually denoted by the symbol z and measured in mol/s, a unit which was called katal and defined the SI unit for catalytic activity since 1999. Catalytic activity is not a kind of reaction rate, but a property of the catalyst under certain conditions, in relation to a specific chemical reaction. Catalytic activity of one katal (Symbol 1 kat = 1mol/s) of a catalyst means an amount of that catalyst (substance, in Mol) that leads to a net reaction of one Mol per second of the reactants to the resulting reagents or other outcome which was intended for this chemical reaction. A catalyst may and usually will have different catalytic activity for distinct reactions. [Wikipedia: https://en.wikipedia.org/wiki/Catalysis]	Chemistry	\N
color	Color	Units used to describe hue and coloration.	Dimensionless	\N
concentrationCountPerCount	Concentration count per count	The count of one substance per unit count of another substance, also known as mole fraction or numeric concentration.	Dimensionless Ratio	\N
concentrationCountPerMass	Concentration count per mass	Amount of substance or a count/number of items per unit mass.  This is most often called molality or molal concentration. This contrasts with the definition of molarity which is based on a specified volume of solution. A commonly used unit for molality used in chemistry is mol/kg. A solution of concentration 1 mol/kg is also sometimes denoted as 1 molal.	Chemistry	\N
concentrationCountPerVolume	Concentration count per volume	Amount of substance or a count/number of items per unit volume. Concentration impliles the amount of one substance/item within another substance.	Chemistry	\N
concentrationOrDensityMassPerVolume	Concentration or density mass per volume	The mass of one substance per unit volume of another substance.  These units are commonly used in both density and concentration measurements	Chemistry	\N
concentrationPercentSaturation	Concentration percent saturation	The amount of a substance dissolved in a solution compared with the amount dissolved in the solution at saturation concentration, expressed as a percent. 	Chemistry	\N
concentrationVolumePerVolume	Concentration volume per volume	The volume of one substance per unit volume of another substance. This is used for volume percents or the ppm of a gas mixture.	Dimensionless Ratio	\N
count	Count	Count or amount of substance is a standards-defined quantity that measures the size of an ensemble of elementary entities, such as atoms, molecules, electrons, and other particles. It is a macroscopic property and it is sometimes referred to as chemical amount. The International System of Units (SI) defines the amount of substance to be proportional to the number of elementary entities present. The SI unit for amount of substance is the mole. It has the unit symbol mol.	Base Quantity	\N
countPerArea	Count per area	The areal density of a given amount of a substance.  This unit group is also used for pixel densities (often incorrectly called resolution).	Space and Time	\N
countPerLength	Count per length	The length density of a given amount of a substance.  This unit group is also used for image and TV resolutions measured in lines.  This is distinct from "inverse length" in that there is something specific being counted per unit length, that is, the numerator is not dimensionless.	Space and Time	\N
currency	Currency	A currency (from Middle English: curraunt, "in circulation", from Latin: currens, -entis) in the most specific use of the word refers to money in any form when in actual use or circulation as a medium of exchange, especially circulating banknotes and coins.  A more general definition is that a currency is a system of money (monetary units) in common use, especially in a nation. [Wikipedia; https://en.wikipedia.org/wiki/Currency]	Financial	\N
dataRate	Data rate	The frequency derived from the period of time required to transmit one bit. This represents the amount of data transferred per second by a communications channel or a computing or storage device. Data rate is measured in units of bits per second (written "b/s" or "bps"), bytes per second (Bps), or baud. When applied to data rate, the multiplier prefixes "kilo-", "mega-", "giga-", etc. (and their abbreviations, "k", "M", "G", etc.) always denote powers of 1000. For example, 64 kbps is 64,000 bits per second. This contrasts with units of storage which use different prefixes to denote multiplication by powers of 1024, e.g. 1 kibibit = 1024 bits.	Information	\N
diffusivity	Diffusivity	Used for kinematic viscosity (also known as momentum diffusivity) and thermal diffusivity.  The Kinematic Viscosity of a fluid is the dynamic viscosity divided by the fluid density.  In heat transfer analysis, thermal diffusivity (usually denoted ? but a, ?, and D are also used) is the thermal conductivity divided by density and specific heat capacity at constant pressure. It measures the ability of a material to conduct thermal energy relative to its ability to store thermal energy.	Fluid Mechanics	\N
dimensionless	Dimensionless	Any unit or combination of units that has no dimensions.  A Dimensionless Unit is a quantity for which all the exponents of the factors corresponding to the base quantities in its quantity dimension are zero.	Dimensionless	\N
doseEquivalent	Dose equivalent	Equivalent dose or radiation dosage is a dose quantity used in radiological protection to represent the stochastic health effects (probability of cancer induction and genetic damage) of low levels of ionizing radiation on the human body. It is based on the physical quantity absorbed dose, but takes into account the biological effectiveness of the radiation, which is dependent on the radiation type and energy. [Wikipedia: https://en.wikipedia.org/wiki/Absorbed_dose]	Radiology	\N
dynamicViscosity	Dynamic viscosity	The dynamic (shear) viscosity of a fluid expresses its resistance to shearing flows, where adjacent layers move parallel to each other with different speeds. Both the physical unit of dynamic viscosity in SI Poiseuille (Pl) and the cgs units Poise (P) come from Jean Léonard Marie Poiseuille. The poiseuille, which is never used, is equivalent to the pascal-second (Pa·s), or (N·s)/m2, or kg/(m·s).	Fluid Mechanics	\N
electricalCapacitance	Electrical capacitance	Capacitance is the ability of a body to store an electrical charge.	Electricity and Magnetism	\N
electricalCharge	Electrical charge	Electric charge is the physical property of matter that causes it to experience a force when placed in an electromagnetic field. The SI derived unit of electric charge is the coulomb (C), although in electrical engineering it is also common to use the ampere-hour (Ah), and in chemistry it is common to use the elementary charge (e) as a unit. The symbol Q is often used to denote charge. [Wikipedia: https://en.wikipedia.org/wiki/Electric_charge]	Electricity and Magnetism	\N
electricalChargeLineDensity	Electrical charge line density	The linear charge density is the amount of electric charge in a line. It is measured in coulombs per metre (C/m). Since there are positive as well as negative charges, the charge density can take on negative values. [Wikipedia]	Electricity and Magnetism	\N
electricalChargePerCount	Electrical charge per count	The amount of electrical charge within a given count of something.	Electricity and Magnetism	\N
electricalChargePerMass	Electrical charge per mass	Unit group for radiation exposure and gyromagnetic ratios	Electricity and Magnetism	\N
electricalChargeVolumeDensity	Electrical charge volume density	In electromagnetism, charge density is a measure of electric charge per unit volume of space, in one, two or three dimensions. More specifically: the linear, surface, or volume charge density is the amount of electric charge per unit length, surface area, or volume, respectively. The respective SI units are C·m?1, C·m?2 or C·m?3.	Electricity and Magnetism	\N
electricalConductance	Electrical conductance	Conductance is the reciprocal of resistance and is different from conductivitiy (specific conductance).  Conductance is the ease with which an electric current passes through a conductor.  The SI unit of electrical resistance is the ohm (?), while electrical conductance is measured in siemens (S).  [Wikipedia: https://en.wikipedia.org/wiki/Electrical_resistance_and_conductance]	Electricity and Magnetism	\N
energyPerArea	Energy per area	Energy per area density is the amount of energy stored in a given system or region of space per unit area.  Has the same dimensionality as force per unit length.	Mechanics	\N
energyPerAreaElectricalCharge	Energy per area electrical charge		Electricity and Magnetism	\N
energyPerSquareMagneticFluxDensity	Energy per square magnetic flux density		Electricity and Magnetism	\N
electricalConductivity	Electrical conductivity	Electrical conductivity or specific conductance is the reciprocal of electrical resistivity, and measures a material's ability to conduct an electric current. It is commonly represented by the Greek letter ? (sigma), but ? (kappa) (especially in electrical engineering) or ? (gamma) are also occasionally used. Its SI unit is siemens per metre (S/m) and CGSE unit is reciprocal second (s?1).  [Wikipedia: https://en.wikipedia.org/wiki/Electrical_resistivity_and_conductivity]	Electricity and Magnetism	\N
electricalCurrent	Electrical current	An electric current is a flow of electric charge. In electric circuits this charge is often carried by moving electrons in a wire. It can also be carried by ions in an electrolyte, or by both ions and electrons such as in a plasma.  The SI unit for measuring an electric current is the ampere, which is the flow of electric charge across a surface at the rate of one coulomb per second. [Wikipedia: https://en.wikipedia.org/wiki/Electric_current]	Base Quantity	\N
electricalCurrentDensity	Electrical current density	Electric current density is a measure of the density of flow of electric charge; it is the electric current per unit area of cross section. Electric current density is a vector-valued quantity.	Electricity and Magnetism	\N
electricalCurrentPerAngle	Electrical current per angle		Electricity and Magnetism	\N
electricalCurrentPerEnergy	Electrical current per energy		Electricity and Magnetism	\N
electricalDipoleMoment	Electrical dipole moment	In physics, the electric dipole moment is a measure of the separation of positive and negative electrical charges in a system of electric charges, that is, a measure of the charge system's overall polarity. The SI units are Coulomb-meter (C m). [Wikipedia: https://en.wikipedia.org/wiki/Electric_dipole_moment]	Electricity and Magnetism	\N
electricalFieldStrength	Electrical field strength	The strength of the electric field at a given point is defined as the force that would be exerted on a positive test charge of +1 coulomb placed at that point; the direction of the field is given by the direction of that force. Electric fields contain electrical energy with energy density proportional to the square of the field intensity. The electric field is to charge as gravitational acceleration is to mass and force density is to volume.	Electricity and Magnetism	\N
electricalFlux	Electrical flux	The Electric Flux through an area is defined as the electric field multiplied by the area of the surface projected in a plane perpendicular to the field. Electric Flux is a scalar-valued quantity.	Electricity and Magnetism	\N
electricalFluxDensity	Electrical flux density	In physics, the electric flux density (or electric displacement field), denoted by D, is a vector field that appears in Maxwell's equations. It accounts for the effects of free and bound charge within materials. "D" stands for "displacement", as in the related concept of displacement current in dielectrics. In free space, the electric displacement field is equivalent to flux density, a concept that lends understanding to Gauss's law.	Electricity and Magnetism	\N
electricalPermittivity	Electrical permittivity	In electromagnetism, absolute permittivity is the measure of the resistance that is encountered when forming an electric field in a medium. In other words, permittivity is a measure of how an electric field affects, and is affected by, a dielectric medium. The permittivity of a medium describes how much electric field (more correctly, flux) is 'generated' per unit charge in that medium. More electric flux exists in a medium with a low permittivity (per unit charge) because of polarization effects. Permittivity is directly related to electric susceptibility, which is a measure of how easily a dielectric polarizes in response to an electric field. Thus, permittivity relates to a material's ability to resist an electric field and "permit" is a misnomer.  In SI units, permittivity ? is measured in farads per meter (F/m)	Electricity and Magnetism	\N
electricalQuadrupoleMoment	Electrical quadrupole moment	The Electric Quadrupole Moment is a quantity which describes the effective shape of the ellipsoid of nuclear charge distribution. A non-zero quadrupole moment Q indicates that the charge distribution is not spherically symmetric. By convention, the value of Q is taken to be positive if the ellipsoid is prolate and negative if it is oblate. In general, the electric quadrupole moment is tensor-valued.	Electricity and Magnetism	\N
electricalResistance	Electrical resistance	Electrical resistance is a ratio of the degree to which an object opposes an electric current through it, measured in ohms. Its reciprocal quantity is electrical conductance measured in siemens.	Electricity and Magnetism	\N
electricalResistivity	Electrical resistivity	Electrical resistivity (also known as resistivity, specific electrical resistance, or volume resistivity) is an intrinsic property that quantifies how strongly a given material opposes the flow of electric current. A low resistivity indicates a material that readily allows the movement of electric charge. Resistivity is commonly represented by the Greek letter ? (rho). The SI unit of electrical resistivity is the ohm?metre (??m)[1][2][3] although other units like ohm?centimetre (??cm) are also in use. [Wikipedia: https://en.wikipedia.org/wiki/Electrical_resistivity_and_conductivity]	Electricity and Magnetism	\N
electromotiveForce	Electromotive force	In physics, electromotive force, or most commonly emf (seldom capitalized), voltage, or (occasionally) electromotance is "that which tends to cause current (actual electrons and ions) to flow.". More formally, emf is the external work expended per unit of charge to produce an electric potential difference across two open-circuited terminals.[2][3] The electric potential difference is created by separating positive and negative charges, thereby generating an electric field.[4][5] The created electrical potential difference drives current flow if a circuit is attached to the source of emf. When current flows, however, the voltage across the terminals of the source of emf is no longer the open-circuit value, due to voltage drops inside the device due to its internal resistance. [Wikipedia: https://en.wikipedia.org/wiki/Electromotive_force]	Electricity and Magnetism	\N
energy	Energy	In physics, energy is a property of objects which can be transferred to other objects or converted into different forms, but cannot be created or destroyed.  Energy, work, and heat all have identical units.	Space and Time	\N
energyDensity	Energy density	Energy density is the amount of energy stored in a given system or region of space per unit volume or mass, though the latter is more accurately termed specific energy.	Mechanics	\N
energyFlux	Energy flux	Energy flux is the rate of transfer of energy through a surface. The quantity is defined in two different ways, depending on the context.  In the first context, it is the rate of energy transfer per unit area (SI units: W·m?2 = J·m?2·s?1). This is a vector quantity, its components being determined in terms of the normal (perpendicular) direction to the surface of measurement. This is sometimes called energy flux density, to distinguish it from the second definition. Radiative flux, heat flux, and sound energy flux are specific cases of energy flux density. In the second context, it is the total rate of energy transfer (SI units: W = J·s?1). This is sometimes informally called energy current.		\N
fluidPermeance	Fluid permeance	Permeance is closely related to permeability, but it refers to the extent of penetration of a specific object with given thickness by a liquid or a gas.  It is the degee to which a materal or membrane transmits another substance.  Units of permeance are volumetric output per unit membrane area per unit trans-membrane pressure. Permeance is also referred to as pressure-normalized flux.	Fluid Mechanics	\N
fluidResistance	Fluid resistance	In fluid dynamics, drag (sometimes called air resistance, a type of friction, or fluid resistance, another type of friction or fluid friction) refers to forces acting opposite to the relative motion of any object moving with respect to a surrounding fluid. [Wikipedia: https://en.wikipedia.org/wiki/Drag_%28physics%29]	Fluid Mechanics	\N
fluidity	Fluidity	The reciprocal of viscosity is fluidity, usually symbolized by ? = 1 / ? or F = 1 / ?, depending on the convention used, measured in reciprocal poise (cm·s·g?1), sometimes called the rhe. Fluidity is seldom used in engineering practice. [Wikipedia: https://en.wikipedia.org/wiki/Viscosity]	Fluid Mechanics	\N
fluorescence	Fluorescence	Fluorescence is the emission of light by a substance that has absorbed light or other electromagnetic radiation.	Dimensionless	\N
force	Force	Force is an influence that causes mass to accelerate. It may be experienced as a lift, a push, or a pull. Force is defined by Newton's Second Law as F = m · a, where F is force, m is mass and a is acceleration. Net force is mathematically equal to the time rate of change of the momentum of the body on which it acts. Since momentum is a vector quantity (has both a magnitude and direction), force also is a vector quantity.	Mechanics	\N
forcePerLength	Force per length	The amount of force applied per unit length.  Frequenty used for surface tension.	Mechanics	\N
frequency	Frequency	Frequency is the number of occurrences of a repeating event per unit time. The repetition of the events may be periodic (i.e. the length of time between event repetitions is fixed) or aperiodic (i.e. the length of time between event repetitions varies). Therefore, we distinguish between periodic and aperiodic frequencies. In the SI system, periodic frequency is measured in hertz (Hz) or multiples of hertz, while aperiodic frequency is measured in becquerel (Bq).	Space and Time	\N
gravitationalAttraction	Gravitational attraction	Gravity or gravitation is a natural phenomenon by which all things attract one another including stars, planets, galaxies and even light and sub-atomic particles. Gravity is responsible for the formation of the universe (e.g. creating spheres of hydrogen, igniting them under pressure to form stars and grouping them in to galaxies). Without gravity, the universe would be without thermal energy and composed only of equally spaced particles. On Earth, gravity gives weight to physical objects and causes the tides. Gravity has an infinite range, and it cannot be absorbed, transformed, or shielded against. [Wikipedia: https://en.wikipedia.org/wiki/Gravity]	Mechanics	\N
heatCapacity	Heat capacity	Heat capacity, or thermal capacity, is a measurable physical quantity equal to the ratio of the heat added to (or removed from) an object to the resulting temperature change. The SI unit of heat capacity is joule per kelvin and the dimensional form is L2MT?2??1. [Wikipedia: https://en.wikipedia.org/wiki/Heat_capacity]	Thermodynamics	\N
heatTransferCoefficient	Heat transfer Coefficient	The heat transfer coefficient or film coefficient, in thermodynamics and in mechanics is the proportionality coefficient between the heat flux and the thermodynamic driving force for the flow of heat (i.e., the temperature difference, ?T)	Thermodynamics	\N
Hyperpolarizability	Hyperpolarizability	The hyperpolarizability, a nonlinear-optical property of a molecule, is the second-order electric susceptibility per unit volume. [Wikipedia: https://en.wikipedia.org/wiki/Hyperpolarizability]	Electricity and Magnetism	\N
illuminance	Illuminance	Illuminance (also know as luminous emittance or luminous flux per area), is the total luminous flux incident on a surface, per unit area. It is a measure of the intensity of the incident light, wavelength-weighted by the luminosity function to correlate with human brightness perception.	Photometry	\N
inductance	Inductance	Inductance is an electromagentic quantity that characterizes a circuit's resistance to any change of electric current; a change in the electric current through induces an opposing electromotive force (EMF). Quantitatively, inductance is proportional to the magnetic flux per unit of electric current.	Electricity and Magnetism	\N
inverseCount	Inverse count		Chemistry	\N
inverseEnergy	Inverse energy		Mechanics	\N
inverseLength	Inverse length	The inverse of length - frequently used for absorption or attenuation coefficients and wave numbers.  This can also be used to for extrinsic curvature where the unit 'diopter' is used.	Space and Time	\N
inverseLengthTemperature	Inverse length temperature		Thermodynamics	\N
inverseMagneticFlux	Inverse magnetic flux		Electricity and Magnetism	\N
inversePermittivity	Inverse permittivity		Electricity and Magnetism	\N
inverseSquareEnergy	Inverse square energy		Mechanics	\N
inverseTimeTemperature	Inverse time temperature		Thermodynamics	\N
inverseVolume	Inverse volume		Space and Time	\N
jerk	Jerk	In physics, jerk, also known as jolt, surge, or lurch, is the rate of change of acceleration; that is, the derivative of acceleration with respect to time, and as such the second derivative of velocity, or the third derivative of position. [Wikipedia: https://en.wikipedia.org/wiki/Jerk_%28physics%29]	Mechanics	\N
length	Length	In the International System of Quantities, length is any quantity with dimension distance.  [Wikipedia: https://en.wikipedia.org/wiki/Length]	Base Quantity	\N
lengthEnergy	Length energy		Mechanics	\N
lengthFraction	Length fraction	The ratio or two lengths, often used to measure slope or scale.	Space and Time	\N
lengthIntegratedMassConcentration	Length integrated mass concentration	A mass concentration per unit length.  These units can be used to measure concentration inputs of a chemical along the length of a waterway.	Chemistry	\N
lengthMass	Length mass		Mechanics	\N
lengthMolarEnergy	Length molar energy		Chemistry	\N
lengthPerMagneticFlux	Length per magnetic flux		Electricity and Magnetism	\N
lengthTemperature	Length temperature		Thermodynamics	\N
lengthTemperatureTime	Length temperature time		Thermodynamics	\N
level	Level	"Psuedo Units" defined from a log ratio.  This includes any number of units like deciBels where the unit is derived as a log ratio of two other units.  The logarithm distinguishes these from other dimensionless ratios.	Dimensionless Ratio	\N
linearAcceleration	Linear acceleration	Linear acceleration, in physics, is the rate at which the velocity of an object changes over time. Velocity and acceleration are vector quantities, with magnitude and direction that add according to the parallelogram law. The SI unit for acceleration is the metre per second squared (m/s2).	Mechanics	\N
linearEnergyTransfer	Linear energy transfer	Linear energy transfer (LET) is a term used in dosimetry. It describes the action of radiation upon matter. It is identical to the retarding force acting on a charged ionizing particle travelling through the matter.  It describes how much energy an ionising particle transfers to the material transversed per unit distance. By definition, LET is a positive quantity. LET depends on the nature of the radiation as well as on the material traversed. [Wikipedia: https://en.wikipedia.org/wiki/Linear_energy_transfer]	Atomic Physics	\N
linearMomentum	Linear momentum	In classical mechanics, linear momentum or translational momentum (pl. momenta; SI unit kg m/s, or equivalently, N s) is the product of the mass and velocity of an object.	Mechanics	\N
linearThermalExpansion	Linear thermal expansion	When the temperature of a substance changes, the energy that is stored in the intermolecular bonds between atoms changes. When the stored energy increases, so does the length of the molecular bonds. As a result, solids typically expand in response to heating and contract on cooling; this dimensional response to temperature change is expressed by its coefficient of thermal expansion. Different coefficients of thermal expansion can be defined for a substance depending on whether the expansion is measured by: * linear thermal expansion * area thermal expansion * volumetric thermal expansion These characteristics are closely related. The volumetric thermal expansion coefficient can be defined for both liquids and solids. The linear thermal expansion can only be defined for solids, and is common in engineering applications. Some substances expand when cooled, such as freezing water, so they have negative thermal expansion coefficients. [Wikipedia: https://en.wikipedia.org/wiki/Thermal_expansion]	Thermodynamics	\N
linearVelocity	Linear velocity	Velocity is the rate of change of the position of an object, equivalent to a specification of its speed and direction of motion.Velocity is an important concept in kinematics, the branch of classical mechanics which describes the motion of bodies.Velocity is a vector physical quantity; both magnitude and direction are required to define it. The scalar absolute value (magnitude) of velocity is called "speed", a quantity that is measured in metres per second (m/s or m·s?1) in the SI (metric) system.	Mechanics	\N
luminance	Luminance	Luminance is a photometric measure of the luminous intensity per unit area of light travelling in a given direction. It describes the amount of light that passes through or is emitted from a particular area, and falls within a given solid angle.	Photometry	\N
luminousEfficacy	Luminous efficacy	Luminous Efficacy is the ratio of luminous flux (in lumens) to power (usually measured in watts). Depending on context, the power can be either the radiant flux of the source's output, or it can be the total electric power consumed by the source.	Photometry	\N
luminousEnergy	Luminous Energy	In photometry, luminous energy is the perceived energy of light. This is sometimes called the quantity of light. Luminous energy is not the same as radiant energy, the corresponding objective physical quantity. This is because the human eye can only see light in the visible spectrum and has different sensitivities to light of different wavelengths within the spectrum. When adapted for bright conditions (photopic vision), the eye is most sensitive to light at a wavelength of 555 nm. Light with a given amount of radiant energy will have more luminous energy if the wavelength is 555 nm than if the wavelength is longer or shorter. Light whose wavelength is well outside the visible spectrum has a luminous energy of zero, regardless of the amount of radiant energy present.	Photometry	\N
luminousFlux	Luminous flux	Luminous Flux or Luminous Power is the measure of the perceived power of light. It differs from radiant flux, the measure of the total power of light emitted, in that luminous flux is adjusted to reflect the varying sensitivity of the human eye to different wavelengths of light.	Photometry	\N
luminousIntensity	Luminous intensity	Luminous Intensity is a measure of the wavelength-weighted power emitted by a light source in a particular direction per unit solid angle. The weighting is determined by the luminosity function, a standardized model of the sensitivity of the human eye to different wavelengths.	Base Quantity	\N
magneticDipoleMoment	Magnetic dipole moment	The magnetic moment of a system is a measure of the magnitude and the direction of its magnetism. Magnetic moment usually refers to its Magnetic Dipole Moment, and quantifies the contribution of the system's internal magnetism to the external dipolar magnetic field produced by the system (that is, the component of the external magnetic field that is inversely proportional to the cube of the distance to the observer). The Magnetic Dipole Moment is a vector-valued quantity.	Electricity and Magnetism	\N
magneticFieldStrength	Magnetic field strength	The magnetic field strength, H (also called magnetic field intensity, magnetizing field, or magnetic field), characterizes how the true Magnetic Field B influences the organization of magnetic dipoles in a given medium.	Electricity and Magnetism	\N
magneticFlux	Magnetic flux	Magnetic Flux is the product of the average magnetic field times the perpendicular area that it penetrates.	Electricity and Magnetism	\N
magneticFluxDensity	Magnetic flux density	The Magnetic flux density, B (also called magnetic induction or magnetic field), is a fundamental field in electrodynamics which characterizes the magnetic force exerted by electric currents. It is closely related to the auxillary magnetic field H.	Electricity and Magnetism	\N
magneticFluxPerLength	Magnetic flux per length	Magnetic Flux Per Unit Length	Electricity and Magnetism	\N
magneticPermeability	Magnetic permeability	Permeability is the degree of magnetization of a material that responds linearly to an applied magnetic field. In general permeability is a tensor-valued quantity.	Electricity and Magnetism	\N
magnetomotiveForce	Magnetomotive force	Magnetomotive force is any physical cause that produces magnetic flux. In other words, it is a field of magnetism (measured in tesla) that has area (measured in square meters), so that (Tesla)(Area)= Flux. It is analogous to electromotive force or voltage in electricity. MMF usually describes electric wire coils in a way so scientists can measure or predict the actual force a wire coil can generate. [Wikipedia: https://en.wikipedia.org/wiki/Magnetomotive_force]	Electricity and Magnetism	\N
mass	Mass	In physics, mass is a property of a physical body which determines the strength of its mutual gravitational attraction to other bodies, its resistance to being accelerated by a force, and in the theory of relativity gives the mass–energy content of a system. The SI unit of mass is the kilogram (kg).	Base Quantity	\N
massCount	Mass count		Chemistry	\N
massCountTemperature	Mass count temperature		Chemistry	\N
massFlux	Mass flux	In physics and engineering, mass flux is the rate of mass flow per unit area, perfectly overlapping with the momentum density, the momentum per unit volume. The common symbols are j, J, q, Q, ?, or ? (Greek lower or capital Phi), sometimes with subscript m to indicate mass is the flowing quantity. Its SI units are kg s?1 m?2. Mass flux can also refer to an alternate form of flux in Fick's law that includes the molecular mass, or in Darcy's law that includes the mass density.  [Wikipedia: https://en.wikipedia.org/wiki/Mass_flux]	Chemistry	\N
massFraction	Mass fraction	In chemistry, the mass fraction is the ratio of one substance with mass to the mass of the total mixture , defined asThe sum of all the mass fractions is equal to 1:Mass fraction can also be expressed, with a denominator of 100, as percentage by weight (wt%). It is one way of expressing the composition of a mixture in a dimensionless size; mole fraction (percentage by moles, mol%) and volume fraction (percentage by volume, vol%) are others. For elemental analysis, mass fraction (or "mass percent composition") can also refer to the ratio of the mass of one element to the total mass of a compound. It can be calculated for any compound using its empirical formula. or its chemical formula	Dimensionless Ratio	\N
massNormalizedParticleLoading	Mass normalized particle loading	The number of particles or organisms per unit time per unit mass.	Chemistry	\N
massPerArea	Mass per area		Chemistry	\N
massPerElectricalCharge	Mass per electrical charge		Chemistry	\N
massPerLength	Mass per length		Mechanics	\N
massPerTime	Mass per time	In physics and engineering, mass flow rate is the mass of a substance which passes per unit of time. [Wikipedia: https://en.wikipedia.org/wiki/Mass_flow_rate]	Mechanics	\N
massTemperature	Mass temperature		Thermodynamics	\N
molarAngularMomentum	Molar angular momentum	The angular momentum per mole of substance.  Used for measuring electron orbitals.	Chemistry	\N
molarConductivity	Molar conductivity	Molar conductivity is defined as the conductivity of an electrolyte solution divided by the molar concentration of the electrolyte, and so measures the efficiency with which a given electrolyte conducts electricity in solution. Its units are siemens per meter per molarity, or siemens meter-squared per mole. The usual symbol is a capital lambda, ?, or ?m. Or Molar conductivity of a solution at a given concentration is the conductance of the volume (V) of the solution containing one mole of electrolyte kept between two electrodes with area of cross section (A) and at a distance of unit length. [Wikipedia: https://en.wikipedia.org/wiki/Molar_conductivity]	Chemistry	\N
molarEnergy	Molar energy	The amount of energy per mole of substance	Chemistry	\N
molarHeatCapacity	Molar heat capacity	The molar heat capacity is the heat capacity per unit amount of a pure substance. [Wikipedia: https://en.wikipedia.org/wiki/Heat_capacity]	Thermodynamics	\N
molarMass	Molar mass	In chemistry, the molar mass M is a physical property defined as the mass of a given substance (chemical element or chemical compound) divided by its amount of substance.  The base SI unit for molar mass is kg/mol. However, for historical reasons, molar masses are almost always expressed in g/mol. [Wikipedia: https://en.wikipedia.org/wiki/Molar_mass]	Chemistry	\N
molarVolume	Molar volume	The molar volume, symbol Vm, is the volume occupied by one mole of a substance (chemical element or chemical compound) at a given temperature and pressure. It is equal to the molar mass (M) divided by the mass density (?). [Wikipedia: https://en.wikipedia.org/wiki/Molar_volume]	Chemistry	\N
other	Other	A unit that does not belong in any of the other groups.  These units have dimensionality, but are generally strangely compounded or calculated	Dimensionless	\N
particleFlux	Particle flux	The number of particles, organisms, or moles of substance going through a specific area in a given amount of time.	Chemistry	\N
particleLoading	Particle loading	The number of particles, organisms, or moles of substance appearing in a given amount of time.	Chemistry	\N
pH	pH	In chemistry, pH (/pi??e?t?/) is a numeric scale used to specify the acidity or alkalinity of an aqueous solution. It is the negative of the logarithm to base 10 of the activity of the hydrogen ion. Solutions with a pH less than 7 are acidic and solutions with a pH greater than 7 are alkaline or basic. Pure water is neutral, being neither an acid nor a base. Contrary to popular belief, the pH value can be less than 0 or greater than 14 for very strong acids and bases respectively. [Wikipedia: https://en.wikipedia.org/wiki/PH]	Chemistry	\N
polarizability	Polarizability	Polarizability is the relative tendency of a charge distribution, like the electron cloud of an atom or molecule, to be distorted from its normal shape by an external electric field, which may be caused by the presence of a nearby ion or dipole.  The electronic polarizability ? is defined as the ratio of the induced dipole moment of an atom to the electric field that produces this dipole moment. Polarizability is often a scalar valued quantity, however in the general case it is tensor-valued.	Electricity and Magnetism	\N
potentialVorticity	Potential vorticity	Potential vorticity (PV) is a quantity which is proportional to the dot product of vorticity and stratification that, following a parcel of air or water, can only be changed by diabatic or frictional processes. It is a useful concept for understanding the generation of vorticity in cyclogenesis (the birth and development of a cyclone), especially along the polar front, and in analyzing flow in the ocean. [Wikipedia: https://en.wikipedia.org/wiki/Potential_vorticity]	Fluid Mechanics	\N
power	Power	Power is the rate at which work is performed or energy is transmitted, or the amount of energy required or expended for a given unit of time. As a rate of change of work done or the energy of a subsystem, power is: P = W/t where P is power W is work t is time.  Heat flow rate follows identical units to Power	Mechanics	\N
powerArea	Power area		Mechanics	\N
powerAreaPerSolidAngle	Power area per solid angle		Mechanics	\N
powerPerArea	Power per area	A general term for heat flow rate per unit area, power per unit area, irradiance, radient emmitance, and radiosity.  All these terms are sometimes referred to as "intensity."	Mechanics	\N
powerPerAreaQuarticTemperature	Power per area quartic temperature	The units of the Stefan-Boltzmann constant.  The Stefan–Boltzmann law states that the total energy radiated per unit surface area of a black body across all wavelengths per unit time (also known as the black-body radiant exitance or emissive power), j*, is directly proportional to the fourth power of the black body's thermodynamic temperature.  The constant of proportionality ?, called the Stefan–Boltzmann constant or Stefan's constant, derives from other known constants of nature. The value of the constant is5.670373 x 10^8 Wm^-2K^-4.  [Wikipedia: https://en.wikipedia.org/wiki/Stefan%E2%80%93Boltzmann_constant]	Thermodynamics	\N
powerPerElectricalCharge	Power per electrical charge		Electricity and Magnetism	\N
pressureOrStress	Pressure or stress	Pressure is an effect which occurs when a force is applied on a surface. Pressure is the amount of force acting on a unit area. Pressure is distinct from stress, as the former is the ratio of the component of force normal to a surface to the surface area. Stress is a tensor that relates the vector force to the vector area.	Space and Time	\N
pressureOrStressRate	Pressure or stress rate		Space and Time	\N
quarticElectricDipoleMomentPerCubicEnergy	Quartic electrical dipole moment per cubic energy		Electricity and Magnetism	\N
radiance	Radiance	In radiometry, radiance is the radiant flux emitted, reflected, transmitted or received by a surface, per unit solid angle per unit projected area. Radiance is used to characterize diffuse emission and reflection of electromagnetic radiation, or to quantify emission of neutrinos and other particles. This is a directional quantity. Historically, radiance is called "intensity" and spectral radiance is called "specific intensity". [Wikipedia: https://en.wikipedia.org/wiki/Radiance]	Radiology	\N
radiantIntensity	Radiant Intensity	Radiant flux emitted, reflected, transmitted or received, per unit solid angle. This is a directional quantity. [Wikipedia: https://en.wikipedia.org/wiki/Radiant_intensity]	Radiology	\N
radioactivity	Radioactivity	Activity is the term used to characterise the number of nuclei which disintegrate in a radioactive substance per unit time. Activity is usually measured in Becquerels (Bq), where 1 Bq is 1 disintegration per second.	Quantum Mechanics	\N
radioactivityPerVolume	Radioactivity per volume	The amount of radioactivity per unit volume	Quantum Mechanics	\N
salinity	Salinity	Salinity is the saltiness or dissolved salt content of a body of water. Salinity is an important factor in determining many aspects of the chemistryof natural waters and of biological processes within it, and is a thermodynamic state variable that, along with temperature and pressure, governs physical characteristics like the density and heat capacity of the water. The use of electrical conductivity measurements to estimate the ionic content of seawater led to the development of the so-called practical salinity scale 1978 (PSS-78). Salinities measured using PSS-78 do not have units. The 'unit' of PSU (denoting practical salinity unit) is sometimes added to PSS-78 measurements, however this is officially discouraged.	Chemistry	\N
satelliteResolution	Satellite resolution	In remote sensing, a satellite's resolution is defined as the size on the earth of the smallest individual component or dot (called a pixel) from which the image is constituted.  This is also reffered to as the ground sample distance.	Space and Time	\N
snap	Snap	In physics, jounce or snap is the fourth derivative of the position vector with respect to time, with the first, second, and third derivatives being velocity, acceleration, and jerk, respectively; hence, the jounce is the rate of change of the jerk with respect to time. [Wikipedia: https://en.wikipedia.org/wiki/Jounce]	Mechanics	\N
solidAngle	Solid angle	The solid angle subtended by a surface S is defined as the surface area of a unit sphere covered by the surface S's projection onto the sphere. A solid angle is related to the surface of a sphere in the same way an ordinary angle is related to the circumference of a circle. Since the total surface area of the unit sphere is 4*pi, the measure of solid angle will always be between 0 and 4*pi.	Space and Time	\N
specificEnergy	Specific energy	Specific energy is energy per unit mass. (It is also sometimes called "energy density," though "energy density" more precisely means energy per unit volume.) The SI unit for specific energy is the joule per kilogram (J/kg). Other units still in use in some contexts are the kilocalorie per gram (Cal/g or kcal/g), mostly in food-related topics, watt hours per kilogram in the field of batteries, and the Imperial unit BTU per pound (BTU/lb), in some engineering and applied technical fields.	Mechanics	\N
specificHeatCapacity	Specific heat capacity	The specific heat capacity, often simply called specific heat, is the heat capacity per unit mass of a material.  It is the amount of heat needed to raise the temperature of a certain mass 1 degree Celsius.	Thermodynamics	\N
specificHeatPressure	Specific heat pressure	Specific heat at a constant pressure.	Thermodynamics	\N
specificHeatVolume	Specific heat volume	Specific heat per constant volume.	Thermodynamics	\N
specificRadioactivity	Specific radioactivity	Specific activity is the activity per mass quantity of a radionuclide and is a physical property of that radionuclide. [Wikipedia: https://en.wikipedia.org/wiki/Specific_activity]	Quantum Mechanics	\N
specificSurfaceArea	Specific surface area	Specific surface area "SSA" is a property of solids which is the total surface area of a material per unit of mass. It is a derived scientific value that can be used to determine the type and properties of a material (e.g. soil, snow). It is defined by surface area divided by mass (with units of m²/kg).	Mechanics	\N
specificVolume	Specific volume	Specific volume (?) is the volume occupied by a unit of mass of a material. It is equal to the inverse of density.	Mechanics	\N
stableIsotopeDelta	Stable isotope delta	For stable isotopes, isotope ratios are typically reported using the delta (?) notation where ? represents the ratio of heavy isotope to light isotope in the sample over the same ratio of a standard reference material, reported using units of in "per mil" (‰, parts per thousand) and reported relative to the specific standard reference material.	Chemistry	\N
standardGravitationalParameter	Standard gravitational parameter	In celestial mechanics, the standard gravitational parameter ? of a celestial body is the product of the gravitational constant G and the mass M of the body. [Wikipedia: https://en.wikipedia.org/wiki/Standard_gravitational_parameter]	Mechanics	\N
temperature	Temperature	A temperature is a numerical measure of hot and cold. Its measurement is by detection of heat radiation or particle velocity or kinetic energy, or by the bulk behavior of a thermometric material. It may be calibrated in any of various temperature scales, Celsius, Fahrenheit, Kelvin, etc. The fundamental physical definition of temperature is provided by thermodynamics.	Base Quantity	\N
temperatureCount	Temperature count		Thermodynamics	\N
temperaturePerMagneticFluxDensity	Temperature per magnetic flux density		Thermodynamics	\N
temperaturePerTime	Temperature per time		Thermodynamics	\N
thermalConductivity	Thermal conductivity	In physics, thermal conductivity (often denoted k, ?, or ?) is the property of a material to conduct heat. Thermal conductivity of materials is temperature dependent. The reciprocal of thermal conductivity is called thermal resistivity.	Thermodynamics	\N
thermalInsulance	Thermal insulance	The inverse of the heat transfer coefficient.	Thermodynamics	\N
thermalResistance	Thermal resistance	Thermal resistance is a heat property and a measurement of a temperature difference by which an object or material resists a heat flow. Thermal resistance is the reciprocal of thermal conductance. (Absolute) thermal resistance R in K/W is a property of a particular component. For example, a characteristic of a heat sink. Specific thermal resistance or specific thermal resistivity R? in (K·m)/W is a material constant.	Thermodynamics	\N
thermalResistivity	Thermal resistivity	The reciprocal of thermal conductivity is thermal resistivity, measured in kelvin-metres per watt (K*m/W). Also called Specific Thermal Resistance.	Thermodynamics	\N
thrustToMassRatio	Thrust to mass ratio	Thrust-to-weight ratio is a dimensionless ratio of thrust to weight of a rocket, jet engine, propeller engine, or a vehicle propelled by such an engine that indicates the performance of the engine or vehicle. [Wikipedia: https://en.wikipedia.org/wiki/Thrust-to-weight_ratio]	Mechanics	\N
time	Time	Time is a basic component of the measuring system used to sequence events, to compare the durations of events and the intervals between them, and to quantify the motions of objects.	Base Quantity	\N
timeSquared	Time squared		Space and Time	\N
torque	Torque	In physics, a torque (?) is a vector that measures the tendency of a force to rotate an object about some axis [1]. The magnitude of a torque is defined as force times its lever arm [2]. Just as a force is a push or a pull, a torque can be thought of as a twist. The SI unit for torque is newton meters (N m). In U.S. customary units, it is measured in foot pounds (ft lbf) (also known as 'pounds feet'). Mathematically, the torque on a particle (which has the position r in some reference frame) can be defined as the cross product: ? = r x F where r is the particle's position vector relative to the fulcrum F is the force acting on the particles, or, more generally, torque can be defined as the rate of change of angular momentum, ? = dL/dt where L is the angular momentum vector t stands for time.	Mechanics	\N
turbidity	Turbidity	Turbidity is the cloudiness or haziness of a fluid, or of air, caused by individual particles (suspended solids) that are generally invisible to the naked eye, similar to smoke in air. Turbidity in open water is often caused by phytoplankton and the measurement of turbidity is a key test of water quality. The higher the turbidity, the higher the risk of the drinkers developing gastrointestinal diseases, especially for immune-compromised people, because contaminants like virus or bacteria can become attached to the suspended solid. The suspended solids interfere with water disinfection with chlorine because the particles act as shields for the virus and bacteria. Similarly suspended solids can protect bacteria from UV sterilisation of water. Fluids can contain suspended solid matter consisting of particles of many different sizes. While some suspended material will be large enough and heavy enough to settle rapidly to the bottom container if a liquid sample is left to stand (the settleable solids), very small particles will settle only very slowly or not at all if the sample is regularly agitated or the particles are colloidal. These small solid particles cause the liquid to appear turbid.	Chemistry	\N
volume	Volume		Space and Time	\N
volumeThermalExpansion	Volume thermal expansion	When the temperature of a substance changes, the energy that is stored in the intermolecular bonds between atoms changes. When the stored energy increases, so does the length of the molecular bonds. As a result, solids typically expand in response to heating and contract on cooling; this dimensional response to temperature change is expressed by its coefficient of thermal expansion. Different coefficients of thermal expansion can be defined for a substance depending on whether the expansion is measured by: * linear thermal expansion * area thermal expansion * volumetric thermal expansion These characteristics are closely related. The volumetric thermal expansion coefficient can be defined for both liquids and solids. The linear thermal expansion can only be defined for solids, and is common in engineering applications. Some substances expand when cooled, such as freezing water, so they have negative thermal expansion coefficients.	Thermodynamics	\N
volumetricFlowRate	Volumetric flow rate	Volume Per Unit Time, or Volumetric flow rate, is the volume of fluid that passes through a given surface per unit of time (as opposed to a unit surface).	Mechanics	\N
volumetricFlux	Volumetric flux	In fluid dynamics, the volumetric flux is the rate of volume flow across a unit area (m3·s?1·m?2). Volumetric flux = liters/(second*area). The density of a particular property in a fluid's volume, multiplied with the volumetric flux of the fluid, thus defines the advective flux of that property.  The volumetric flux through a porous medium is often modelled using Darcy's law. Volumetric flux is not to be confused with volumetric flow rate, which is the volume of fluid that passes through a given surface per unit of time (as opposed to a unit surface).  [Wikipedia: https://en.wikipedia.org/wiki/Volumetric_flux] Also used for hydraulic conductivity.	Mechanics	\N
volumetricHeatCapacity	Volumetric heat capacity	Volumetric heat capacity (VHC), also termed volume-specific heat capacity, describes the ability of a given volume of a substance to store internal energy while undergoing a given temperature change, but without undergoing a phase transition. It is different from specific heat capacity in that the VHC is a 'per unit volume' measure of the relationship between thermal energy and temperature of a material, while the specific heat is a 'per unit mass' measure (or occasionally per molar quantity of the material).	Thermodynamics	\N
volumetricProductivity	Volumetric productivity	In ecology, productivity or production refers to the rate of generation of biomass in an ecosystem. It is usually expressed in units of mass per unit surface (or volume) per unit time, for instance grams per square metre per day (g m?2 d?1). The mass unit may relate to dry matter or to the mass of carbon generated. Productivity of autotrophs such as plants is called primary productivity, while that of heterotrophs such as animals is called secondary productivity. [Wikipedia: https://en.wikipedia.org/wiki/Productivity_%28ecology%29]	Chemistry	\N
yank	Yank	Yank is the rate of change of force.	Mechanics	\N
inverseSteradianMeter	Inverse Steradian Meter			\N
\.


--
-- Data for Name: cv_variablename; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.cv_variablename (term, name, definition, category, sourcevocabularyuri) FROM stdin;
1_1_1_Trichloroethane	1,1,1-Trichloroethane	1,1,1-Trichloroethane (C2H3Cl3)		\N
1_1_2_2_Tetrachloroethane	1,1,2,2-Tetrachloroethane	1,1,2,2-Tetrachloroethane (C2H2Cl4)		\N
1_1_2_Trichloroethane	1,1,2-Trichloroethane	1,1,2-Trichloroethane (C2H3Cl3)		\N
1_1_Dichloroethane	1,1-Dichloroethane	1,1-Dichloroethane (C2H4Cl2)		\N
1_1_Dichloroethene	1,1-Dichloroethene	1,1-Dichloroethene (C2H2Cl2)		\N
1_2_3_Trimethylbenzene	1,2,3-Trimethylbenzene	1,2,3-Trimethylbenzene (C9H12)		\N
1_2_4_5_Tetrachlorobenzene	1,2,4,5-tetrachlorobenzene	1,2,4,5-tetrachlorobenzene (C6H2Cl4)		\N
1_2_4_Trichlorobenzene	1,2,4-Trichlorobenzene	1,2,4-Trichlorobenzene (C6H3Cl3)		\N
1_2_4_Trimethylbenzene	1,2,4-Trimethylbenzene	1,2,4-Trimethylbenzene		\N
1_2_Dibromo_3_Chloropropane	1,2-Dibromo-3-chloropropane	1,2-Dibromo-3-chloropropane (C3H5Br2Cl)		\N
1_2_Dichlorobenzene	1,2-Dichlorobenzene	1,2-Dichlorobenzene (C6H4Cl2)		\N
1_2_Dichloroethane	1,2-Dichloroethane	1,2-Dichloroethane (C2H4Cl2)		\N
1_2_Dichloropropane	1,2-Dichloropropane	1,2-Dichloropropane (C3H6Cl2)		\N
1_2_Dimethylnaphthalene	1,2-Dimethylnaphthalene	1,2-Dimethylnaphthalene (C10H6(CH3)2), a polycyclic aromatic hydrocarbon (PAH)		\N
1_2_Dinitrobenzene	1,2-Dinitrobenzene	1,2-Dinitrobenzene (C6H4N2O4)		\N
1_2_Diphenylhydrazine	1,2-Diphenylhydrazine	1,2-Diphenylhydrazine (C12H12N2)		\N
1_3_5_Trimethylbenzene	1,3,5-Trimethylbenzene	1,3,5-Trimethylbenzene (C6H3(CH3)3)		\N
1_3_Dichlorobenzene	1,3-Dichlorobenzene	1,3-Dichlorobenzene (C6H4Cl2)		\N
1_3_Dimethyladamantane	1,3-Dimethyladamantane	1,3-Dimethyladamantane (C12H20).		\N
1_3_Dimethylnaphthalene	1,3-Dimethylnaphthalene	1,3-Dimethylnaphthalene (C10H6(CH3)2), a polycyclic aromatic hydrocarbon (PAH)		\N
1_3_Dinitrobenzene	1,3-Dinitrobenzene	1,3-Dinitrobenzene (C6H4N2O4)		\N
1_4_5_8_Tetramethylnaphthalene	1,4,5,8-Tetramethylnaphthalene	1,4,5,8-Tetramethylnaphthalene (C14H16), a polycyclic aromatic hydrocarbon (PAH)		\N
1_4_5_Trimethylnaphthalene	1,4,5-Trimethylnaphthalene	1,4,5-Trimethylnaphthalene (C10H5(CH3)3), a polycyclic aromatic hydrocarbon (PAH)		\N
1_4_6_Trimethylnaphthalene	1,4,6-Trimethylnaphthalene	1,4,6-Trimethylnaphthalene (C10H5(CH3)3), a polycyclic aromatic hydrocarbon (PAH)		\N
1_4_Dichlorobenzene	1,4-Dichlorobenzene	1,4-Dichlorobenzene (C6H4Cl2)		\N
1_4_Dimethylnaphthalene	1,4-Dimethylnaphthalene	1,4-Dimethylnaphthalene (C10H6(CH3)2), a polycyclic aromatic hydrocarbon (PAH)		\N
1_4_Dinitrobenzene	1,4-Dinitrobenzene	1,4-Dinitrobenzene (C6H4N2O4)		\N
1_5_Dimethylnaphthalene	1,5-Dimethylnaphthalene	1,5-Dimethylnaphthalene (C10H6(CH3)2), a polycyclic aromatic hydrocarbon (PAH)		\N
1_6_7_Trimethylnaphthalene	1,6,7-Trimethylnaphthalene	1,6,7-Trimethylnaphthalene (C10H5(CH3)3), a polycyclic aromatic hydrocarbon (PAH)		\N
1_6_Dimethylnaphthalene	1,6-Dimethylnaphthalene	1,6-Dimethylnaphthalene (C10H6(CH3)2), a polycyclic aromatic hydrocarbon (PAH)		\N
1_8_Dimethylnaphthalene	1,8-Dimethylnaphthalene	1,8-Dimethylnaphthalene (C10H6(CH3)2), a polycyclic aromatic hydrocarbon (PAH)		\N
1_Chloronaphthalene	1-Chloronaphthalene	1-Chloronaphthalene (C10H7Cl)		\N
1_Ethylnaphthalene	1-Ethylnaphthalene	1-Ethylnaphthalene (C10H7C2H5), a polycyclic aromatic hydrocarbon (PAH)		\N
1_Methylanthracene	1-Methylanthracene	1-Methylanthracene (C15H12), a polycyclic aromatic hydrocarbon (PAH)		\N
1_Methyldibenzothiophene	1-Methyldibenzothiophene	1-Methyldibenzothiophene (C13H10S)		\N
1_Methylfluorene	1-Methylfluorene	1-Methylfluorene (C14H12), a polycyclic aromatic hydrocarbon (PAH)		\N
1_Methylnaphthalene	1-Methylnaphthalene	1-Methylnaphthalene (C10H7CH3), a polycyclic aromatic hydrocarbon (PAH)		\N
1_Methylphenanthrene	1-Methylphenanthrene	1-Methylphenanthrene (C15H12), a polycyclic aromatic hydrocarbon (PAH)		\N
1_NaphthalenolMethylcarbamate	1-Naphthalenol methylcarbamate	1-Naphthalenol methylcarbamate (C12H11NO2)		\N
19_Hexanoyloxyfucoxanthin	19-Hexanoyloxyfucoxanthin	The phytoplankton pigment 19-Hexanoyloxyfucoxanthin		\N
2_2_DichlorovinylDimethylPhosphate	2,2-dichlorovinyl dimethyl phosphate	2,2-dichlorovinyl dimethyl phosphate (C4H7Cl2O4P)		\N
2_3_4_6_Tetrachlorophenol	2,3,4,6-Tetrachlorophenol	2,3,4,6-Tetrachlorophenol (C6H2Cl4O)		\N
2_3_5_Trimethylnaphthalene	2,3,5-Trimethylnaphthalene	2,3,5-Trimethylnaphthalene (C13H14), a polycyclic aromatic hydrocarbon (PAH)		\N
2_3_6_Trimethylnaphthalene	2,3,6-Trimethylnaphthalene	2,3,6-Trimethylnaphthalene (C10H5(CH3)3), a polycyclic aromatic hydrocarbon (PAH)		\N
2_3_Dimethylnaphthalene	2,3-Dimethylnaphthalene	2,3-Dimethylnaphthalene (C10H6(CH3)2), a polycyclic aromatic hydrocarbon (PAH)		\N
2_4_5_Trichlorophenol	2,4,5-Trichlorophenol	2,4,5-Trichlorophenol (C6H3Cl3O)		\N
2_4_6_Trichlorophenol	2,4,6-Trichlorophenol	2,4,6-Trichlorophenol (TCP) (C6H2Cl3OH)		\N
2_4_Dichlorophenol	2,4-Dichlorophenol	2,4-Dichlorophenol (C6H4Cl2O)		\N
2_4_Dimethylphenol	2,4-Dimethylphenol	2,4-Dimethylphenol (C8H10O)		\N
2_4_Dinitrophenol	2,4-Dinitrophenol	2,4-Dinitrophenol (C6H4N2O5)		\N
2_4_Dinitrotoluene	2,4-Dinitrotoluene	2,4-Dinitrotoluene (C7H6N2O4)		\N
2_6_Dichlorophenol	2,6-Dichlorophenol	2,6-Dichlorophenol (C6H4Cl2O)		\N
2_6_Dinitrotoluene	2,6-Dinitrotoluene	2,6-Dinitrotoluene (C7H6N2O4)		\N
2_7_Dimethylnaphthalene	2,7-Dimethylnaphthalene	2,7-Dimethylnaphthalene (C10H6(CH3)2), a polycyclic aromatic hydrocarbon (PAH)		\N
2_Butanone_MEK	2-Butanone (MEK)	2-Butanone (MEK) (C4H8O)		\N
2_Butoxyethanol	2-Butoxyethanol	2-Butoxyethanol (CH3(CH2)2CH2OCH2OH)		\N
2_Chloronaphthalene	2-Chloronaphthalene	2-Chloronaphthalene (C10H7Cl)		\N
2_Chlorophenol	2-Chlorophenol	2-Chlorophenol (C6H5ClO)		\N
2_Hexanone	2-Hexanone	2-Hexanone (C6H12O)		\N
2_Methylanthracene	2-Methylanthracene	2-Methylanthracene (C15H12), a polycyclic aromatic hydrocarbon (PAH)		\N
2_Methyldibenzothiophene	2-Methyldibenzothiophene	2-Methyldibenzothiophene (C13H10S), a polycyclic aromatic hydrocarbon (PAH)		\N
2_Methylnaphthalene	2-Methylnaphthalene	2-Methylnaphthalene (C10H7CH3), a polycyclic aromatic hydrocarbon (PAH)		\N
2_Methylphenanthrene	2-Methylphenanthrene	2-Methylphenanthrene (C15H12), a polycyclic aromatic hydrocarbon (PAH)		\N
2_Methylphenol	2-Methylphenol	2-Methylphenol (C7H8O)		\N
2_Nitroaniline	2-Nitroaniline	2-Nitroaniline (C6H6N2O2)		\N
2_Nitrophenol	2-Nitrophenol	2-Nitrophenol (C6H5NO3)		\N
3_3_Dichlorobenzidine	3,3-Dichlorobenzidine	3,3-Dichlorobenzidine (C12H10Cl2N2)		\N
3_6_Dimethylphenanthrene	3,6-Dimethylphenanthrene	3,6-Dimethylphenanthrene (C16H14), a polycyclic aromatic hydrocarbon (PAH)		\N
3_Nitroaniline	3-Nitroaniline	3-Nitroaniline (C6H6N2O2)		\N
4_4_DDD	4,4-DDD	Dichlorodiphenyldichloroethane (C14H10Cl4)		\N
4_4_DDE	4,4-DDE	Dichlorodiphenyldichloroethylene (C14H8Cl4)		\N
4_4_DDT	4,4-DDT	Dichlorodiphenyltrichloroethane (C14H9Cl5)		\N
4_4_Methylenebis_2_Chloroaniline	4,4-Methylenebis(2-chloroaniline)	4,4'-Methylenebis(2-chloroaniline) (C13H12Cl2N2)		\N
4_4_Methylenebis_N_N_Dimethylaniline	4,4-Methylenebis(N,N-dimethylaniline)	4,4'-Methylenebis(N,N-dimethylaniline) (C17H22N2)		\N
4_6_Dinitro_2_Methylphenol	4,6-Dinitro-2-methylphenol	4,6-Dinitro-2-methylphenol (C7H6N2O5)		\N
4_BromophenylphenylEther	4-Bromophenylphenyl ether	4-Bromophenylphenyl ether (C12H9BrO)		\N
4_Chloro_3_Methylphenol	4-Chloro-3-methylphenol	4-Chloro-3-methylphenol (C7H7ClO)		\N
4_Chloroaniline	4-Chloroaniline	4-Chloroaniline (C6H6ClN)		\N
4_ChlorophenylphenylEther	4-Chlorophenylphenyl ether	4-Chlorophenylphenyl ether (C12H9ClO)		\N
4_Methylchrysene	4-Methylchrysene	4-Methylchrysene (C19H14), a polycyclic aromatic hydrocarbon (PAH)		\N
4_Methyldibenzothiophene	4-Methyldibenzothiophene	4-Methyldibenzothiophene (C13H10S), a polycyclic aromatic hydrocarbon (PAH)		\N
4_Methylphenol	4-Methylphenol	4-Methylphenol (C7H8O)		\N
4_Nitroaniline	4-Nitroaniline	4-Nitroaniline (C6H6N2O2)		\N
4_Nitrophenol	4-Nitrophenol	4-Nitrophenol (C6H5NO3)		\N
9_cis_Neoxanthin	9 cis-Neoxanthin	The phytoplankton pigment  9 cis-Neoxanthin		\N
9_10_Dimethylanthracene	9,10-Dimethylanthracene	9,10-Dimethylanthracene (C16H14), a polycyclic aromatic hydrocarbon (PAH)		\N
absorbance	Absorbance	The amount of radiation absorbed by a material		\N
absorbanceUltraviolet	Absorbance, ultraviolet	Absorbance of ultraviolet light at a specified wavelength, typically at 254 or 280 nm for water samples. Not normalized to DOC concentration like variables such as SUVA280.		\N
abundance	Abundance	The relative representation of a species in a particular ecosystem. If this generic term is used, the publisher should specify/qualify the species, class, etc. being measured in the method, qualifier, or other appropriate field.		\N
acenaphthene	Acenaphthene	Acenaphthene (C12H10)		\N
acenaphthylene	Acenaphthylene	Acenaphthylene (C12H8), a polycyclic aromatic hydrocarbon (PAH)		\N
acetate	Acetate	Acetate		\N
aceticAcid	Acetic Acid	Acetic Acid (C2H4O2)		\N
acetone	Acetone	Acetone (C3H6O)		\N
acetophenone	Acetophenone	Acetophenone (C6H5C(O)CH3)		\N
acidNeutralizingCapacity	Acid neutralizing capacity	Acid neutralizing capacity		\N
acidPhosphatase	Acid phosphatase	Phosphatase enzymes are used by soil microorganisms to access organically bound phosphate nutrients. An assay on the rates of activity of these enzymes may be used to ascertain biological demand for phosphates in the soil. Some plant roots, especially cluster roots, exude carboxylates that perform acid phosphatase activity, helping to mobilise phosphorus in nutrient-deficient soils.	Chemistry	\N
acidityCO2Acidity	Acidity, CO2 acidity	CO2 acidity		\N
acidityExchange	Acidity, exchange	The total amount of the Cation Exchange Capacity (CEC) of a soil that is due to H+ and Al3+ ions. It is a proportion of the total acidity and it is dependent on the type of soil and the percentage of the CEC that is composed of exchangeable bases (Ca2+, Mg2+, K+).		\N
acidityHot	Acidity, hot	Hot Acidity		\N
acidityMineralAcidity	Acidity, mineral acidity	Mineral Acidity		\N
acidityTotalAcidity	Acidity, total acidity	Total acidity		\N
activityAcidPhosphatase	Activity, acid phosphatase	Assay for microbial activity using acid phosphatase		\N
activityBetaGlucosidase	Activity, beta-glucosidase	Assay for microbial activity using beta-glucosidase		\N
activityBetaNAcetylGlucosaminidase	Activity, beta-N-acetyl glucosaminidase	Assay for microbial activity using beta-N-acetyl glucosaminidase		\N
activityPhenolOxidase	Activity, phenol oxidase	Assay for microbial activity using phenol oxidase		\N
adamantane	Adamantane	Adamantane (C10H16)		\N
agencyCode	Agency code	Code for the agency which analyzed the sample		\N
albedo	Albedo	The ratio of reflected to incident light.		\N
albite	Albite	Albite is a plagioclase feldspar mineral. It is the sodium endmember of the plagioclase solid solution series. As such it represents a plagioclase with less than 10% anorthite content.		\N
aldrin	Aldrin	Aldrin (C12H8Cl6)		\N
alkaliFeldspar	Alkali feldspar	The alkali feldspar group are those feldspar minerals rich in the alkali elements like potassium and sodium. The alkali feldspars include albite, anorthoclase, microcline, orthoclase and sanidine.		\N
alkalinity	Alkalinity	Alkalinity is the capacity of water to resist changes in pH that would make the water more acidic. It should not be confused with basicity which is an absolute measurement on the pH scale. Alkalinity is the strength of a buffer solution composed of weak acids and their conjugate bases. It is measured by titrating the solution with a monoprotic acid such as HCl until its pH changes abruptly, or it reaches a known endpoint where that happens. Alkalinity is expressed in units of meq/L (milliequivalents per liter), which corresponds to the amount of monoprotic acid added as a titrant in millimoles per liter.		\N
alkalinityBicarbonate	Alkalinity, bicarbonate	Bicarbonate Alkalinity		\N
alkalinityCarbonate	Alkalinity, carbonate	Carbonate Alkalinity		\N
alkalinityCarbonatePlusBicarbonate	Alkalinity, carbonate plus bicarbonate	Alkalinity, carbonate plus bicarbonate		\N
alkalinityHydroxide	Alkalinity, hydroxide	Hydroxide Alkalinity		\N
alkalinityTotal	Alkalinity, total	Total Alkalinity		\N
alloxanthin	Alloxanthin	The phytoplankton pigment Alloxanthin		\N
alluviumDepth	Alluvium depth	Alluvium is loose, unconsolidated (not cemented together into a solid rock) soil or sediment that has been eroded, reshaped by water in some form, and redeposited in a non-marine setting. Alluvium is typically made up of a variety of materials, including fine particles of silt and clay and larger particles of sand and gravel. When this loose alluvial material is deposited or cemented into a lithological unit, or lithified, it is called an alluvial deposit.		\N
benzo_b_fluoranthene	Benzo(b)fluoranthene	Benzo(b)fluoranthene (C20H12), a polycyclic aromatic hydrocarbon (PAH)		\N
alphaNAcetylglucosaminidase	Alpha-N-Acetylglucosaminidase	An enzyme with system name alpha-N-acetyl-D-glucosaminide N-acetylglucosaminohydrolase.[1][2][3][4] This enzyme catalyses the following chemical reaction: Hydrolysis of terminal non-reducing N-acetyl-D-glucosamine residues in N-acetyl-alpha-D-glucosaminides.	Chemistry	\N
altitude	Altitude	Altitude or height (sometimes known as depth) is defined based on the context in which it is used (aviation, geometry, geographical survey, sport, atmospheric pressure, and many more). As a general definition, altitude is a distance measurement, usually in the vertical or "up" direction, between a reference datum and a point or object. The reference datum also often varies according to the context. Although the term altitude is commonly used to mean the height above sea level of a location, in geography the term elevation is often preferred for this usage.		\N
aluminum	Aluminum	Aluminium (in Commonwealth English) or Aluminum (in American English) is a chemical element in the boron group with symbol Al and atomic number 13. It is a silvery-white, soft, nonmagnetic, ductile metal.		\N
aluminumDissolved	Aluminum, dissolved	Dissolved Aluminum (Al)		\N
aluminumParticulate	Aluminum, particulate	Particulate aluminum in suspension		\N
aluminumTotal	Aluminum, total	Aluminum (Al). Total indicates was measured on a whole water sample.		\N
ammoniumFlux	Ammonium flux	Ammonium (NH4) flux		\N
amphibole	Amphibole	Amphibole is an important group of inosilicate minerals, forming prism or needlelike crystals, composed of double chain SiO 4 tetrahedra, linked at the vertices and generally containing ions of iron and/or magnesium in their structures.		\N
aniline	Aniline	Aniline (C6H7N)		\N
anthracene	Anthracene	Anthracene (C14H10), a polycyclic aromatic hydrocarbon (PAH)		\N
antimony	Antimony	Antimony is a chemical element with symbol Sb and atomic number 51. A lustrous gray metalloid, it is found in nature mainly as the sulfide mineral stibnite (Sb2S3).		\N
antimonyDissolved	Antimony, dissolved	Dissolved antimony (Sb)."Dissolved" indicates measurement was on a filtered sample.		\N
antimonyDistributionCoefficient	Antimony, distribution coefficient	Ratio of concentrations of antimony in two phases in equilibrium with each other. Phases must be specified.		\N
antimonyParticulate	Antimony, particulate	Particulate antimony (Sb) in suspension		\N
antimonyTotal	Antimony, total	Total antimony (Sb). "Total" indicates was measured on a whole water (unfiltered) sample.		\N
apophyllite	Apophyllite	The name apophyllite refers to a specific group of phyllosilicates, a class of minerals. Originally, the group name referred to a specific mineral, but was redefined in 1978 to stand for a class of minerals of similar chemical makeup that comprise a solid solution series, and includes the members fluorapophyllite-(K), fluorapophyllite-(Na), hydroxyapophyllite-(K).		\N
area	Area	Area of a measurement location		\N
areaBasal	Area, basal	Basal area is the area of a given section of land that is occupied by the cross-section of tree trunks and stems at the base. The term is used in forest management and forest ecology.		\N
argon	Argon	Argon		\N
argonDissolved	Argon, dissolved	Dissolved Argon		\N
aroclor_1016	Aroclor-1016	Aroclor-1016 (C24H13Cl7), a PCB mixture		\N
aroclor_1242	Aroclor-1242	Aroclor-1242 (C12H6Cl4), a PCB mixture		\N
aroclor_1254	Aroclor-1254	Aroclor-1254 (C12H5Cl5), a PCB mixture		\N
aroclor_1260	Aroclor-1260	Aroclor-1260 (C12H3Cl7), a PCB mixture		\N
arsenic	Arsenic	Arsenic is a chemical element with symbol As and atomic number 33. Arsenic occurs in many minerals, usually in combination with sulfur and metals, but also as a pure elemental crystal. Arsenic is a metalloid. It has various allotropes, but only the gray form, which has a metallic appearance, is important to industry.		\N
arsenicDissolved	Arsenic, dissolved	Dissolved Arsenic. For chemical terms, dissolved represents a filtered sample.		\N
arsenicDistributionCoefficient	Arsenic, distribution coefficient	Ratio of concentrations of arsenic in two phases in equilibrium with each other. Phases must be specified.		\N
arsenicParticulate	Arsenic, particulate	Particulate arsenic (As) in suspension		\N
arsenicTotal	Arsenic, total	Total arsenic (As). Total indicates was measured on a whole water sample.		\N
aspect	Aspect	Aspect identifies the downslope direction of the maximum rate of change in value from each raster DEM cell to its neighbors.		\N
asteridaeCoverage	Asteridae coverage	Areal coverage of the plant Asteridae		\N
augelite	Augelite	Augelite is an aluminium phosphate mineral with formula: Al2(PO4)(OH)3. The shade varies from colorless to white, yellow or rose. Its crystal system is monoclinic		\N
barium	Barium	Barium is a chemical element with symbol Ba and atomic number 56. It is the fifth element in group 2 and is a soft, silvery alkaline earth metal. Because of its high chemical reactivity, barium is never found in nature as a free element. Its hydroxide, known in pre-modern times as baryta, does not occur as a mineral, but can be prepared by heating barium carbonate.		\N
bariumDissolved	Barium, dissolved	Dissolved Barium (Ba)		\N
bariumDistributionCoefficient	Barium, distribution coefficient	Ratio of concentrations of barium in two phases in equilibrium with each other. Phases must be specified		\N
bariumParticulate	Barium, particulate	Particulate barium (Ba) in suspension		\N
bariumTotal	Barium, total	Total Barium (Ba). For chemical terms, "total" indicates an unfiltered sample.		\N
barometricPressure	Barometric pressure	Barometric pressure		\N
baseSaturation	Base saturation	Percent base saturation (BS) is the percentage of the Cation Exchange Capacity (CEC) occupied by the basic cations Ca2+, Mg2+ and K+.		\N
baseflow	Baseflow	The portion of streamflow (discharge) that is supplied by groundwater sources.		\N
batisMaritimaCoverage	Batis maritima Coverage	Areal coverage of the plant Batis maritima		\N
batteryTemperature	Battery temperature	The battery temperature of a datalogger or sensing system		\N
batteryVoltage	Battery voltage	The battery voltage of a datalogger or sensing system, often recorded as an indicator of data reliability		\N
bedrockType	Bedrock type	In geology, bedrock is the lithified rock that lies under a loose softer material called regolith at the surface of the Earth or other terrestrial planets.		\N
benthos	Benthos	Benthic species		\N
benz_a_anthracene	Benz(a)anthracene	Benz(a)anthracene (C18H12), a polycyclic aromatic hydrocarbon (PAH)		\N
benzene	Benzene	Benzene (C6H6)		\N
benzo_a_pyrene	Benzo(a)pyrene	Benzo(a)pyrene (C20H12), a polycyclic aromatic hydrocarbon (PAH)		\N
benzo_b_fluorene	Benzo(b)fluorene	Benzo(b)fluorene (C17H12), a polycyclic aromatic hydrocarbon (PAH)		\N
benzo_e_pyrene	Benzo(e)pyrene	Benzo(e)pyrene (C20H12), a polycyclic aromatic hydrocarbon (PAH)		\N
benzo_g_h_i_perylene	Benzo(g,h,i)perylene	Benzo(g,h,i)perylene (C22H12), a polycyclic aromatic hydrocarbon (PAH)		\N
benzo_k_fluoranthene	Benzo(k)fluoranthene	Benzo(k)fluoranthene (C20H12), a polycyclic aromatic hydrocarbon (PAH)		\N
benzoicAcid	Benzoic acid	Benzoic acid (C7H6O2)		\N
benzylAlcohol	Benzyl alcohol	Benzyl alcohol (C7H8O)		\N
beryllium	Beryllium	Beryllium is a chemical element with symbol Be and atomic number 4. It is a relatively rare element in the universe, usually occurring as a product of the spallation of larger atomic nuclei that have collided with cosmic rays. Within the cores of stars beryllium is depleted as it is fused and creates larger elements. It is a divalent element which occurs naturally only in combination with other elements in minerals. Notable gemstones which contain beryllium include beryl (aquamarine, emerald) and chrysoberyl. As a free element it is a steel-gray, strong, lightweight and brittle alkaline earth metal.		\N
berylliumDissolved	Beryllium, dissolved	Dissolved Beryllium (Be) . For chemical terms, "dissolved"indicates a filtered sample.		\N
berylliumTotal	Beryllium, total	Total Beryllium (Be). For chemical terms, "total" indicates an unfiltered sample.		\N
berylium_10	Beryllium-10	Beryllium-10 (10Be) is a radioactive isotope of beryllium.		\N
betaGlucosidase	Beta-glucosidase	Beta-glucosidase catalyzes the hydrolysis of the glycosidic bonds to terminal non-reducing residues in beta-D-glucosides and oligosaccharides, with release of glucose.	Chemistry	\N
bicarbonate	Bicarbonate	Bicarbonate (HCO3-)		\N
bifenthrin	Bifenthrin	Bifenthrin (C23H22ClF3O2)		\N
biogenicSilica	Biogenic silica	Hydrated silica (SiO2 nH20)		\N
biomass	Biomass	Mass of living biological organisms in a given area or ecosystem at a given time. If this generic term is used, the publisher should specify/qualify the species, class, etc. being measured in the method, qualifier, or other appropriate field.		\N
biomassAboveGround	Biomass, above-ground	The biomass is the mass of living biological organisms in a given area or ecosystem at a given time on or above the surface of the ground		\N
biomassMicrobial	Biomass, microbial	Microbial biomass (bacteria and fungi) is a measure of the mass of the living component of soil organic matter.		\N
biomassPhytoplankton	Biomass, phytoplankton	Total mass of phytoplankton, per unit area or volume		\N
biomassSoilBacterialDeoxyribonucleicAcid	Biomass, soil bacterial deoxyribonucleic acid (DNA)	Total dry mass of soil bacterial deoxyribonucleic acid (DNA) per unit mass of soil		\N
biomassTotal	Biomass, total	Total biomass		\N
biomassVegetation	Biomass, vegetation	Total dry mass of plant material per unit area or volume		\N
biphenyl	Biphenyl	Biphenyl ((C6H5)2), a polycyclic aromatic hydrocarbon (PAH), also known as diphenyl or phenylbenzene or 1,1'-biphenyl or lemonene		\N
bis_2_Chloroethoxy_Methane	Bis(2-chloroethoxy)methane	Bis(2-chloroethoxy)methane (C5H10Cl2O2)		\N
bis_2_Chloroethyl_Ether	bis(2-Chloroethyl)ether	bis(2-Chloroethyl)ether (C4H8Cl2O)		\N
bis_2_Ethylhexyl_Phthalate	Bis-(2-ethylhexyl) phthalate	Bis-(2-ethylhexyl) phthalate (C6H4(C8H17COO)2)		\N
bis_2_ChloroisopropylEther	bis-2-chloroisopropyl ether	bis-2-chloroisopropyl ether (C6H12Cl2O)		\N
bismuth	Bismuth	Bismuth is a chemical element with symbol Bi and atomic number 83. It is a pentavalent post-transition metal and one of the pnictogens with chemical properties resembling its lighter homologs arsenic and antimony. Elemental bismuth may occur naturally, although its sulfide and oxide form important commercial ores. The free element is 86% as dense as lead. It is a brittle metal with a silvery white color when freshly produced, but surface oxidation can give it a pink tinge. Bismuth is marginally radioactive, and the most naturally diamagnetic element, and has one of the lowest values of thermal conductivity among metals.		\N
blue_GreenAlgae_Cyanobacteria_Phycocyanin	Blue-green algae (cyanobacteria), phycocyanin	Blue-green algae (cyanobacteria) with phycocyanin pigments		\N
BOD1	BOD1	1-day Biochemical Oxygen Demand		\N
BOD2Carbonaceous	BOD2, carbonaceous	2-day Carbonaceous Biochemical Oxygen Demand		\N
BOD20	BOD20	20-day Biochemical Oxygen Demand		\N
BOD20Carbonaceous	BOD20, carbonaceous	20-day Carbonaceous Biochemical Oxygen Demand		\N
BOD20Nitrogenous	BOD20, nitrogenous	20-day Nitrogenous Biochemical Oxygen Demand		\N
BOD3Carbonaceous	BOD3, carbonaceous	3-day Carbonaceous Biochemical Oxygen Demand		\N
BOD4Carbonaceous	BOD4, carbonaceous	4-day Carbonaceous Biological Oxygen Demand		\N
BOD5	BOD5	5-day Biochemical Oxygen Demand		\N
BOD5Carbonaceous	BOD5, carbonaceous	5-day Carbonaceous Biochemical Oxygen Demand		\N
BOD5Nitrogenous	BOD5, nitrogenous	5-day Nitrogenous Biochemical Oxygen Demand		\N
BOD6Carbonaceous	BOD6, carbonaceous	6-day Carbonaceous Biological Oxygen Demand		\N
BOD7Carbonaceous	BOD7, carbonaceous	7-day Carbonaceous Biochemical Oxygen Demand		\N
BODu	BODu	Ultimate Biochemical Oxygen Demand		\N
BODuCarbonaceous	BODu, carbonaceous	Carbonaceous Ultimate Biochemical Oxygen Demand		\N
BODuNitrogenous	BODu, nitrogenous	Nitrogenous Ultimate Biochemical Oxygen Demand		\N
bodyLength	Body length	Length of the body of an organism		\N
boreholeLogMaterialClassification	Borehole log material classification	Classification of material encountered by a driller at various depths during the drilling of a well and recorded in the borehole log.		\N
boronDissolved	Boron, dissolved	dissolved boron		\N
boronTotal	Boron, total	Total Boron (B)		\N
borrichiaFrutescensCoverage	Borrichia frutescens Coverage	Areal coverage of the plant Borrichia frutescens		\N
bromide	Bromide	A bromide is a chemical compound containing a bromide ion or ligand. This is a bromine atom with an ionic charge of −1 (Br−); for example, in caesium bromide, caesium cations (Cs+) are electrically attracted to bromide anions (Br−) to form the electrically neutral ionic compound CsBr. The term "bromide" can also refer to a bromine atom with an oxidation number of −1 in covalent compounds such as sulfur dibromide (SBr2). 		\N
bromideDissolved	Bromide, dissolved	Dissolved Bromide (Br-)		\N
bromideTotal	Bromide, total	Total Bromide (Br-)		\N
bromine	Bromine	Bromine (Br2)		\N
bromineDissolved	Bromine, dissolved	Dissolved Bromine (Br2)		\N
bromodichloromethane	Bromodichloromethane	Bromodichloromethane (CHBrCl2)		\N
bromoform	Bromoform	Bromoform (CHBr3), a haloform		\N
bromomethane_MethylBromide	Bromomethane (Methyl bromide)	Bromomethane (Methyl bromide) (CH3Br)		\N
bulkDensity	Bulk density	The mass of many particles of the material divided by the total volume they occupy. The total volume includes particle volume, inter-particle void volume and internal pore volume.		\N
bulkElectricalConductivity	Bulk electrical conductivity	Bulk electrical conductivity of a medium measured using a sensor such as time domain reflectometry (TDR), as a raw sensor response in the measurement of a quantity like soil moisture.		\N
butane	Butane	Butane		\N
butylbenzylphthalate	Butylbenzylphthalate	Butylbenzylphthalate (C19H20O4)		\N
butyricAcid	Butyric Acid	Butyric Acid (C4H8O2)		\N
cadmium	Cadmium	Cadmium is a chemical element with symbol Cd and atomic number 48. This soft, bluish-white metal is chemically similar to the two other stable metals in group 12, zinc and mercury. Like zinc, it demonstrates oxidation state +2 in most of its compounds, and like mercury, it has a lower melting point than the transition metals in groups 3 through 11. Cadmium and its congeners in group 12 are often not considered transition metals, in that they do not have partly filled d or f electron shells in the elemental or common oxidation states. The average concentration of cadmium in Earth's crust is between 0.1 and 0.5 parts per million (ppm).		\N
cadmiumDissolved	Cadmium, dissolved	Cadmium is a chemical element with symbol Cd and atomic number 48. This soft, bluish-white metal is chemically similar to the two other stable metals in group 12, zinc and mercury. Like zinc, it demonstrates oxidation state +2 in most of its compounds, and like mercury, it has a lower melting point than the transition metals in groups 3 through 11. Cadmium and its congeners in group 12 are often not considered transition metals, in that they do not have partly filled d or f electron shells in the elemental or common oxidation states. The average concentration of cadmium in Earth's crust is between 0.1 and 0.5 parts per million (ppm).		\N
cadmiumDistributionCoefficient	Cadmium, distribution coefficient	Ratio of concentrations of cadmium in two phases in equilibrium with each other. Phases must be specified.		\N
cadmiumParticulate	Cadmium, particulate	Particulate cadmium (Cd) in suspension		\N
cadmiumTotal	Cadmium, total	Total Cadmium (Cd). For chemical terms, "total" indciates an unfiltered sample.		\N
calciumOxide	Calcium oxide	Calcium oxide (CaO), commonly known as quicklime or burnt lime, is a widely used chemical compound.		\N
calciumDissolved	Calcium, dissolved	Calcium is a chemical element with symbol Ca and atomic number 20. An alkaline earth metal, calcium is a reactive metal that forms a dark oxide-nitride layer when exposed to air. Its physical and chemical properties are most similar to its heavier homologues strontium and barium. It is the fifth most abundant element in Earth's crust and the third most abundant metal, after iron and aluminium. The most common calcium compound on Earth is calcium carbonate, found in limestone and the fossilised remnants of early sea life; gypsum, anhydrite, fluorite, and apatite are also sources of calcium. The name derives from Latin calx "lime", which was obtained from heating limestone.		\N
calciumTotal	Calcium, total	Total Calcium (Ca)		\N
canopyClosure	Canopy closure	Crown closure is a term used in forestry. Crown closure and crown cover are two slightly different measures of the forest canopy and that determine the amount of light able to penetrate to the forest floor.		\N
canopyHeight	Canopy height	Forest canopy density and height are used as variables in a number of environmental applications, such as biomass estimation, vegetation coverage, and biodiversity determination. Canopy density, or canopy cover, is the ratio of vegetation to ground as seen from the air. Canopy height measures how far above the ground the top of the canopy is. Lidar can be used to determine both of these variables.		\N
canthaxanthin	Canthaxanthin	The phytoplankton pigment Canthaxanthin		\N
carbaryl	Carbaryl	Carbaryl (C12H11NO2)		\N
carbazole	Carbazole	Carbazole (C12H9N)		\N
carbon	Carbon	Carbon is a chemical element with symbol C and atomic number 6. It is nonmetallic and tetravalent—making four electrons available to form covalent chemical bonds. It belongs to group 14 of the periodic table. Three isotopes occur naturally, 12C and 13C being stable, while 14C is a radionuclide, decaying with a half-life of about 5,730 years. Carbon is one of the few elements known since antiquity.		\N
carbonDioxide	Carbon dioxide	Carbon dioxide		\N
carbonDioxideFlux	Carbon dioxide flux	Carbon dioxide (CO2) flux		\N
carbonDioxideStorageFlux	Carbon dioxide storage flux	Carbon dioxide (CO2) storage flux		\N
carbonDioxideDissolved	Carbon Dioxide, dissolved	Dissolved Carbon dioxide (CO2)		\N
carbonDioxideTransducerSignal	Carbon dioxide, transducer signal	Carbon dioxide (CO2), raw data from sensor		\N
carbonDisulfide	Carbon disulfide	Carbon disulfide (CS2)		\N
carbonMonoxideDissolved	Carbon monoxide, dissolved	Dissolved carbon monoxide (CO)		\N
carbonTetrachloride	Carbon tetrachloride	Carbon tetrachloride (CCl4)		\N
carbonToNitrogenMassRatio	Carbon to nitrogen mass ratio	Carbon to nitrogen (C:N) mass ratio		\N
carbonToNitrogenMolarRatio	Carbon to nitrogen molar ratio	Carbon to nitrogen (C:N) molar ratio		\N
carbonDissolvedInorganic	Carbon, dissolved inorganic	Dissolved Inorganic Carbon		\N
carbonDissolvedOrganic	Carbon, dissolved organic	Dissolved Organic Carbon		\N
carbonDissolvedTotal	Carbon, dissolved total	Dissolved Total (Organic+Inorganic) Carbon		\N
carbonOrganicExtractable	Carbon, organic extractable	Mass of carbon extractable by water from soil or forest floor samples, also known as water-extractable organic carbon (WEOC)		\N
carbonParticulateOrganic	Carbon, particulate organic	Particulate organic carbon in suspension		\N
carbonSuspendedInorganic	Carbon, suspended inorganic	Suspended Inorganic Carbon		\N
carbonSuspendedOrganic	Carbon, suspended organic	DEPRECATED -- The use of this term is discouraged in favor of the use of the synonymous term "Carbon, particulate organic".		\N
carbonSuspendedTotal	Carbon, suspended total	Suspended Total (Organic+Inorganic) Carbon		\N
carbonTotal	Carbon, total	Total (Dissolved+Particulate) Carbon		\N
carbonTotalInorganic	Carbon, total inorganic	Total (Dissolved+Particulate) Inorganic Carbon		\N
carbonTotalOrganic	Carbon, total organic	Total (Dissolved+Particulate) Organic Carbon		\N
carbonTotalSolidPhase	Carbon, total solid phase	Total solid phase carbon		\N
coliformTotal	Coliform, total	Total Coliform		\N
carbon_13StableIsotopeRatioDelta	Carbon-13, stable isotope ratio delta	Difference in the 13C:12C ratio between the sample and standard (del C 13)		\N
carbon_14	Carbon-14	A radioactive isotope of carbon which undergoes beta decay		\N
carbonate	Carbonate	Carbonate ion (CO3-2) concentration		\N
cationExchangeCapacity	Cation exchange capacity (CEC)	Cation exchange capacity (CEC) is a measure of the total negative charges within the soil that adsorb plant nutrient cations such as calcium (Ca2+), magnesium (Mg2+) and potassium (K+). As such, the CEC is a property of a soil that describes its capacity to supply nutrient cations to the soil solution for plant uptake.		\N
cellobiohydrolase	Cellobiohydrolase	Exocellulases or cellobiohydrolases cleave two to four units from the ends of the exposed chains produced by endocellulase, resulting in tetrasaccharides or disaccharides, such as cellobiose. Exocellulases are further classified into type I, that work processively from the reducing end of the cellulose chain, and type II, that work processively from the nonreducing end.	Chemistry	\N
cerium	Cerium	Cerium is a chemical element with symbol Ce and atomic number 58. Cerium is a soft, ductile and silvery-white metal that tarnishes when exposed to air, and it is soft enough to be cut with a knife.		\N
ceriumDissolved	Cerium, dissolved	Dissolved Cerium (Ce). "Dissolved " indicates a the measurement was made on a filtered sample.		\N
cesium	Cesium	Caesium (IUPAC spelling) or cesium (American spelling) is a chemical element with symbol Cs and atomic number 55. It is a soft, silvery-gold alkali metal with a melting point of 28.5 °C (83.3 °F), which makes it one of only five elemental metals that are liquid at or near room temperature.		\N
cesiumDissolved	Cesium, dissolved	Dissolved Cesium (Cs)		\N
cesiumTotal	Cesium, total	Total Cesium (Cs)		\N
cesium_137	Cesium-137	A radioactive isotope of cesium which is formed as a fission product by nuclear fission of uranium or plutonium.		\N
chloride	Chloride	Chloride (Cl-)		\N
chlorideDissolved	Chloride, dissolved	Dissolved Chloride (Cl-)		\N
chlorideTotal	Chloride, total	Total Chloride (Cl-)		\N
chlorine	Chlorine	Chlorine (Cl2)		\N
chlorineDissolved	Chlorine, dissolved	Dissolved Chlorine (Cl2)		\N
chlorobenzene	Chlorobenzene	Chlorobenzene (C6H5Cl)		\N
chlorobenzilate	Chlorobenzilate	Chlorobenzilate (C16H14Cl2O3)		\N
chloroethane	Chloroethane	Chloroethane (C2H5Cl)		\N
chloroethene	Chloroethene	Chloroethene (C2H3Cl)		\N
chloroform	Chloroform	Chloroform (CHCl3), a haloform		\N
chloromethane	Chloromethane	Chloromethane (CH3Cl)		\N
chlorophyll_a_b_c	Chlorophyll (a+b+c)	Chlorophyll (a+b+c)		\N
chlorophyll_a	Chlorophyll a	Chlorophyll a		\N
chlorophyll_a_Allomer	Chlorophyll a allomer	The phytoplankton pigment Chlorophyll a allomer		\N
chlorophyll_a_CorrectedForPheophytin	Chlorophyll a, corrected for pheophytin	Chlorphyll a corrected for pheophytin		\N
chlorophyll_a_UncorrectedForPheophytin	Chlorophyll a, uncorrected for pheophytin	Chlorophyll a uncorrected for pheophytin		\N
chlorophyll_b	Chlorophyll b	Chlorophyll b		\N
chlorophyll_c	Chlorophyll c	Chlorophyll c		\N
chlorophyll_c1_And_c2	Chlorophyll c1 and c2	Chlorophyll c1 and c2		\N
chlorophyllFluorescence	Chlorophyll fluorescence	Chlorophyll Fluorescence		\N
chromium	Chromium	Chromium is a chemical element with symbol Cr and atomic number 24. It is the first element in group 6. It is a steely-grey, lustrous, hard and brittle transition metal. Chromium boasts a high usage rate as a metal that is able to be highly polished while resisting tarnishing. Chromium is also the main component of stainless steel, a popular steel alloy due to its uncommonly high specular reflection. Simple polished chromium reflects almost 70% of the visible spectrum, with almost 90% of infrared light waves being reflected. The name of the element is derived from the Greek word χρῶμα, chrōma, meaning color, because many chromium compounds are intensely colored. 		\N
chromium_III	Chromium (III)	Trivalent Chromium		\N
chromium_VI	Chromium (VI)	Hexavalent Chromium		\N
chromium_VI_Dissolved	Chromium (VI), dissolved	Dissolved Hexavalent Chromium		\N
chromiumDissolved	Chromium, dissolved	Dissolved Chromium		\N
chromiumDistributionCoefficient	Chromium, distribution coefficient	Ratio of concentrations of chromium in two phases in equilibrium with each other. Phases must be specified.		\N
chromiumParticulate	Chromium, particulate	Particulate chromium (Cr) in suspension		\N
chromiumTotal	Chromium, total	Total chromium (Cr). Total indicates was measured on a whole water (unfiltered) sample.		\N
chrysene	Chrysene	Chrysene (C18H12), a polycyclic aromatic hydrocarbon (PAH)		\N
circumference	Circumference	In geometry, the circumference (from Latin circumferens, meaning "carrying around") of a circle is the (linear) distance around it. That is, the circumference would be the length of the circle if it were opened up and straightened out to a line segment. Since a circle is the edge (boundary) of a disk, circumference is a special case of perimeter. The perimeter is the length around any closed figure and is the term used for most figures excepting the circle and some circular-like figures such as ellipses. Informally, "circumference" may also refer to the edge itself rather than to the length of the edge.		\N
cis_1_2_Dichloroethene	cis-1,2-Dichloroethene	cis-1,2-Dichloroethene (C2H2Cl2)		\N
cis_1_3_Dichloropropene	cis-1,3-Dichloropropene	cis-1,3-Dichloropropene (C3H4Cl2)		\N
Clay	Clay	USDA particle size distribution category. Less then 0.002 mm diameter fine earth particles. \n		\N
clinoptilolite	Clinoptilolite	Clinoptilolite is a natural zeolite comprising a microporous arrangement of silica and alumina tetrahedra. It has the complex formula: (Na,K,Ca)2-3Al3(Al,Si)2Si13O36·12H2O. 		\N
cloudCover	Cloud cover	Cloud cover (also known as cloudiness, cloudage, or cloud amount) refers to the fraction of the sky obscured by clouds when observed from a particular location.		\N
cobalt	Cobalt	Cobalt is a chemical element with symbol Co and atomic number 27. Like nickel, cobalt is found in the Earth's crust only in chemically combined form, save for small deposits found in alloys of natural meteoric iron. The free element, produced by reductive smelting, is a hard, lustrous, silver-gray metal.		\N
cobaltDissolved	Cobalt, dissolved	Dissolved Cobalt (Co)		\N
cobaltTotal	Cobalt, total	Total Cobalt (Co)		\N
cobalt_60	Cobalt-60	A synthetic radioactive isotope of cobalt with a half-life of 5.27 years.		\N
COD	COD	Chemical oxygen demand		\N
coliformFecal	Coliform, fecal	Fecal Coliform		\N
color	Color	Color in quantified in color units		\N
coloredDissolvedOrganicMatter	Colored dissolved organic matter	The concentration of colored dissolved organic matter (humic substances)		\N
containerNumber	Container number	The identifying number for a water sampler container.		\N
copper	Copper	Copper is a chemical element with symbol Cu and atomic number 29. It is a soft, malleable, and ductile metal with very high thermal and electrical conductivity. A freshly exposed surface of pure copper has a pinkish-orange color. Copper is used as a conductor of heat and electricity, as a building material, and as a constituent of various metal alloys, such as sterling silver used in jewelry, cupronickel used to make marine hardware and coins, and constantan used in strain gauges and thermocouples for temperature measurement.		\N
copperDissolved	Copper, dissolved	Dissolved Copper (Cu)		\N
copperDistributionCoefficient	Copper, distribution coefficient	Ratio of concentrations of copper in two phases in equilibrium with each other. Phases must be specified.		\N
copperParticulate	Copper, particulate	Particulate copper (Cu) in suspension		\N
copperTotal	Copper, total	Total copper (Cu). "Total" indicates was measured on a whole water (unfiltered) sample.		\N
countAreal	Count, areal	Counts per area		\N
counter	Counter	The total number of events within the measurement period		\N
cristobalite	Cristobalite	The mineral cristobalite is a high-temperature polymorph of silica, meaning that it has the same chemical formula as quartz, SiO2, but a distinct crystal structure.		\N
cryptophytes	Cryptophytes	The chlorophyll a concentration contributed by cryptophytes		\N
curvature	Curvature	Curvature of a DEM measures the shape or curvature of the slope. A part of a surface can be concave or convex; you can tell that by looking at the curvature value. The curvature is calculated by computing the second derivative of the surface.		\N
cuscutaSppCoverage	Cuscuta spp. coverage	Areal coverage of the plant Cuscuta spp.		\N
cyanide	Cyanide	Cyanide (CN)		\N
cyclohexane	Cyclohexane	Cyclohexane (C6H6Cl6)		\N
cytochromeP450Family1SubfamilyAPolypeptide1DeltaCycleThreshold	Cytochrome P450, family 1, subfamily A, polypeptide 1, delta cycle threshold	Delta cycle threshold for Cytochrome P450, family 1, subfamily A, polypeptide 1 (cyp1a1). Cycle threshold is the PCR cycle number at which the fluorescent signal of the gene being amplified crosses the set threshold. Delta cycle threshold for cyp1a1 is the difference between the cycle threshold (Ct) of cyp1a1 gene expression and the cycle threshold (Ct) for the gene expression of the reference gene (e.g., beta-actin).		\N
cytosolicProtein	Cytosolic protein	The total protein concentration within the cytosolic fraction of cells. The cytosol refers to the intracellular fluid or cytoplasmic matrix of a eukaryotic cell.		\N
d_Limonene	d-Limonene	d-Limonene (C10H16)		\N
dataShuttleAttached	Data shuttle attached	A categorical variable marking the attachment of a coupler or data shuttle to a logger. This is used for quality control.		\N
dataShuttleDetached	Data shuttle detached	A categorical variable marking the detatchment of a coupler or data shuttle to a logger. This is used for quality control.		\N
delta_13COfC2H6	delta-13C of C2H6	Isotope 13C of ethane		\N
delta_13COfC3H8	delta-13C of C3H8	Isotope 13C of propane		\N
delta_13COfC4H10	delta-13C of C4H10	Isotope 13C of butane		\N
delta_13COfCH4	delta-13C of CH4	Isotope 13C of methane		\N
delta_13COfCO2	delta-13C of CO2	Isotope 13C of carbon dioxide		\N
delta_13COfDIC	delta-13C of DIC	Isotope 13C of dissolved inorganic carbon (DIC)		\N
delta_18OOfH2O	delta-18O of H2O	Isotope 18O of water		\N
delta_DOfCH4	delta-D of CH4	hydrogen isotopes of methane		\N
delta_DOfH2O	delta-D of H2O	hydrogen isotopes of water		\N
density	Density	Density		\N
depth	Depth	The perpendicular measurement downward from a surface		\N
depthSnow	Depth, snow	Depth of snow		\N
soilDepth	Depth, soil 	Depth of soil		\N
depthUnsaturatedZone	Depth, unsaturated zone 	Depth of the Unsaturated zone. The vadose zone, also termed the unsaturated zone, is the part of Earth between the land surface and the top of the phreatic zone, the position at which the groundwater (the water in the soil's pores) is at atmospheric pressure ("vadose" is from the Latin for "shallow"). Hence, the vadose zone extends from the top of the ground surface to the water table.		\N
deuterium	Deuterium	Deuterium (2H), Delta D		\N
di_n_Butylphthalate	Di-n-butylphthalate	Di-n-butylphthalate (C16H22O4)		\N
di_n_OctylPhthalate	Di-n-octyl phthalate	Di-n-octyl phthalate (C24H38O4)		\N
diadinoxanthin	Diadinoxanthin	The phytoplankton pigment Diadinoxanthin		\N
diallate_CisOrTrans	Diallate (cis or trans)	Diallate (cis or trans) (C10H17Cl2NOS)		\N
diameter	Diameter	A diameter of a circle is any straight line segment that passes through the center of the circle and whose endpoints lie on the circle. It can also be defined as the longest chord of the circle. Both definitions are also valid for the diameter of a sphere. In more modern usage, the length of a diameter is also called the diameter. In this sense one speaks of the diameter rather than a diameter (which refers to the line itself), because all diameters of a circle or sphere have the same length, this being twice the radius r.		\N
diameterAtBreastHeight	Diameter at breast height (DBH)	Diameter at breast height, or DBH, is the standard for measuring trees. DBH refers to the tree diameter measured at 4.5 feet above the ground.		\N
diatoxanthin	Diatoxanthin	The phytoplankton pigment Diatoxanthin		\N
dibenz_a_h_anthracene	Dibenz(a,h)anthracene	Dibenz(a,h)anthracene (C22H14), a polycyclic aromatic hydrocarbon (PAH)		\N
dibenzofuran	Dibenzofuran	Dibenzofuran (C12H8O)		\N
dibenzothiophene	Dibenzothiophene	Dibenzothiophene (C12H8S), a polycyclic aromatic hydrocarbon (PAH)		\N
dibromochloromethane	Dibromochloromethane	Dibromochloromethane (CHBr2Cl)		\N
dieldrin	Dieldrin	Dieldrin (C12H8Cl6O)		\N
flashMemoryErrorCount	Flash memory error count	A counter which counts the number of  datalogger flash memory errors		\N
fluoranthene	Fluoranthene	Fluoranthene (C16H10), a polycyclic aromatic hydrocarbon (PAH)		\N
fluorene	Fluorene	Fluorene (C13H10), a polycyclic aromatic hydrocarbon (PAH)		\N
fluorescenceIndex	Fluorescence index	Fluorescence index for measuring fluorescent dissolved organic matter (FDOM). Ratio of emission intensity at 470nm to intensity at 520nm at excitation 370nm.		\N
dielectricConstant	Dielectric constant	The relative permittivity of a material is its (absolute) permittivity expressed as a ratio relative to the permittivity of vacuum. Permittivity is a material property that affects the Coulomb force between two point charges in the material. Relative permittivity is the factor by which the electric field between the charges is decreased relative to vacuum. Likewise, relative permittivity is the ratio of the capacitance of a capacitor using that material as a dielectric, compared with a similar capacitor that has vacuum as its dielectric. Relative permittivity is also commonly known as dielectric constant, a term deprecated in engineering as well as in chemistry.		\N
diethylPhthalate	Diethyl phthalate	Diethyl phthalate (C12H14O4)		\N
diethyleneGlycol	Diethylene glycol	Diethylene glycol (C4H10O3)		\N
diffractionXRay	Diffraction, X-ray (XRD)	X-ray crystallography (XRC) is a technique used for determining the atomic and molecular structure of a crystal, in which the crystalline structure causes a beam of incident X-rays to diffract into many specific directions.		\N
diisopropylEther	Diisopropyl Ether	Diisopropyl Ether (C6H14O)		\N
dimethylPhthalate	Dimethyl Phthalate	Dimethyl Phthalate (C10H10O4)		\N
dimethylphenanthrene	Dimethylphenanthrene	Dimethylphenanthrene (C16H14)		\N
dinoflagellates	Dinoflagellates	The chlorophyll a concentration contributed by Dinoflagellates		\N
dinoseb	Dinoseb	Dinoseb (C10H12N2O5)		\N
discharge	Discharge	Discharge		\N
distance	Distance	Distance measured from a sensor to a target object such as the surface of a water body or snow surface.		\N
distichlisSpicataCoverage	Distichlis spicata Coverage	Areal coverage of the plant Distichlis spicata		\N
disulfoton	Disulfoton	Disulfoton (C8H19O2PS3)		\N
DNADamageOliveDailMoment	DNA damage, olive tail moment	In a single cell gel electrophoresis assay (comet assay), olive tail moment is the product of the percentage of DNA in the tail and the distance between the intesity centroids of the head and tail along the x-axis (Olive, et al., 1990)		\N
DNADamagePercentTailDNA	DNA damage, percent tail DNA	In a single cell gel electrophoresis assay (comet assay), percent tail DNA is the ratio of fluorescent intensity of the tail over the total fluorescent intensity of the head (nuclear core) and tail multiplied by 100.		\N
DNADamageTailLength	DNA damage, tail length	In a single cell gel electrophoresis assay (comet assay), tail length is the distance of DNA migration from the body of the nuclear core		\N
dysprosium	Dysprosium	Dysprosium is a chemical element with symbol Dy and atomic number 66. It is a rare earth element with a metallic silver luster. Dysprosium is never found in nature as a free element, though it is found in various minerals, such as xenotime. Naturally occurring dysprosium is composed of seven isotopes, the most abundant of which is 164Dy.		\N
dysprosiumDissolved	Dysprosium, dissolved	Dissolved dysprosium (Dy). "Dissolved " indicates a the measurement was made on a filtered sample.		\N
e_coli	E-coli	Escherichia coli		\N
effectiveEnergyAndMassTransfer	Effective energy and mass transfer (EEMT)	Effective energy and mass transfer (EEMT) couples energy and mass flux to the subsurface in the form of effective precipitation and net primary production in a common energy unit.		\N
electricCurrent	Electric Current	A flow of electric charge		\N
electricEnergy	Electric Energy	Electric Energy		\N
electricPower	Electric Power	Electric Power		\N
electricalConductivity	Electrical conductivity	Electrical conductivity		\N
endOfFile	End of file	A categorical variable marking the end of a data file. This is used for quality control.		\N
endosulfan_I_Alpha	Endosulfan I (alpha)	Endosulfan I (alpha) (C9H6Cl6O3S)		\N
endosulfan_II_Beta	Endosulfan II (beta)	Endosulfan II (beta) (C9H6Cl6O3S)		\N
endosulfanSulfate	Endosulfan Sulfate	Endosulfan Sulfate (C9H6Cl6O4S)		\N
endrin	Endrin	Endrin (C12H8Cl6O)		\N
endrinAldehyde	Endrin aldehyde	Endrin aldehyde (C12H8Cl6O)		\N
endrinKetone	Endrin Ketone	Endrin Ketone (C12H9Cl5O)		\N
enterococci	Enterococci	Enterococcal bacteria		\N
erbium	Erbium	Erbium is a chemical element with symbol Er and atomic number 68. A silvery-white solid metal when artificially isolated, natural erbium is always found in chemical combination with other elements. It is a lanthanide, a rare earth element, originally found in the gadolinite mine in Ytterby in Sweden, from which it got its name.		\N
erbiumDissolved	Erbium, dissolved	Dissolved Erbium (Er). "Dissolved " indicates a the measurement was made on a filtered sample.		\N
erosionRate	Erosion rate	In earth science, erosion is the action of surface processes (such as water flow or wind) that removes soil, rock, or dissolved material from one location on the Earth's crust, and then transports it to another location (not to be confused with weathering which involves no movement).		\N
ethane	Ethane	Ethane		\N
ethaneDissolved	Ethane, dissolved	Dissolved Ethane (C2H6)		\N
ethanol	Ethanol	Ethanol (C2H6O)		\N
ethoxyresorufin_O_DeethylaseActivity	Ethoxyresorufin O-deethylase, activity	Ethoxyresorufin O-deethylase (EROD) activity		\N
ethylTert_ButylEther	Ethyl tert-Butyl Ether	Ethyl tert-Butyl Ether (C6H14O)		\N
ethylbenzene	Ethylbenzene	Ethylbenzene (C8H10)		\N
ethylene	Ethylene	Ethylene (C2H4)		\N
ethyleneGlycol	Ethylene glycol	Ethlene Glycol (C2H4(OH)2)		\N
ethyleneDissolved	Ethylene, dissolved	Dissolved ethylene		\N
ethyne	Ethyne	Ethyne (C2H2)		\N
europium	Europium	Europium is a chemical element with symbol Eu and atomic number 63. It was isolated in 1901 and is named after the continent of Europe. It is a moderately hard, silvery metal which readily oxidizes in air and water.		\N
europiumDissolved	Europium, dissolved	Dissolved Europium (Eu). "Dissolved " indicates a the measurement was made on a filtered sample.		\N
evaporation	Evaporation	Evaporation		\N
evapotranspiration	Evapotranspiration	Evapotranspiration		\N
evapotranspirationPotential	Evapotranspiration, potential	The amount of water that could be evaporated and transpired if there was sufficient water available.		\N
extracellularEnzymeActivity	Extracellular enzyme activity	Extracellular enzymes or exoenzymes are synthesized inside the cell and then secreted outside the cell, where their function is to break down complex macromolecules into smaller units to be taken up by the cell for growth and assimilation.		\N
fishDetections	Fish detections	The number of fish identified by the detection equipment		\N
fluorescenceDissolvedOrganicCarbon	Fluorescence, dissolved organic carbon (DOC)	Fluorescence of dissolved organic carbon (DOC). DOC is an element specific fraction of dissolved organic matter (DOM).		\N
fluorescenceDissolvedOrganicMatter	Fluorescence, dissolved organic matter (DOM)	Fluorescence of dissolved organic matter (DOM).		\N
fluorescenceXRay	Fluorescence, X-ray (XRF)	X-ray fluorescence (XRF) is the emission of characteristic "secondary" (or fluorescent) X-rays from a material that has been excited by bombarding with high-energy X-rays or gamma rays.		\N
fluoride	Fluoride	Fluoride (F-)		\N
fluorideDissolved	Fluoride, dissolved	Dissolved Fluoride (F-)		\N
fluorine	Fluorine	Fluorine (F2)		\N
fluorineDissolved	Fluorine, dissolved	Dissolved Fluorine (F2)		\N
formate	Formate	Formate		\N
formicAcid	Formic acid	Formic acid (CH2O2)		\N
frequencyOfRotation	Frequency of Rotation	Number of rotations within a time period		\N
frictionVelocity	Friction velocity	Friction velocity		\N
gadolinium	Gadolinium	Gadolinium is a chemical element with symbol Gd and atomic number 64. Gadolinium is a silvery-white, malleable, and ductile rare earth metal. It is found in nature only in oxidized form, and even when separated, it usually has impurities of the other rare earths.		\N
gadoliniumDissolved	Gadolinium, dissolved	Dissolved Gadolinium (Gd). "Dissolved " indicates a the measurement was made on a filtered sample.		\N
gageHeight	Gage height	Water level with regard to an arbitrary gage datum (also see Water depth for comparison)		\N
gallium	Gallium	Gallium is a chemical element with symbol Ga and atomic number 31. It is in group 13 of the periodic table, and thus has similarities to the other metals of the group, aluminium, indium, and thallium.		\N
gammaCounts	Gamma counts	The radioactivity of rocks has been used for many years to help derive lithologies. Natural occurring radioactive materials (NORM) include the elements uranium, thorium, potassium, radium, and radon, along with the minerals that contain them. There is usually no fundamental connection between different rock types and measured gamma ray intensity, but there exists a strong general correlation between the radioactive isotope content and mineralogy. Logging tools have been developed to read the gamma rays emitted by these elements and interpret lithology from the information collected.		\N
geologicUnit	Geologic unit	Geologic units consists primarily of identifying physiographic units and determining the rock lithology or coarse stratigraphy of exposed units.		\N
germanium	Germanium	Germanium is a chemical element with symbol Ge and atomic number 32. It is a lustrous, hard, grayish-white metalloid in the carbon group, chemically similar to its group neighbors tin and silicon. Pure germanium is a semiconductor with an appearance similar to elemental silicon. Like silicon, germanium naturally reacts and forms complexes with oxygen in nature.		\N
germaniumDissolved	Germanium, dissolved	Dissolved Germanium (Ge). "Dissolved " indicates a the measurement was made on a filtered sample.		\N
gibbsite	Gibbsite	Gibbsite, Al(OH)3, is one of the mineral forms of aluminium hydroxide. It is often designated as γ-Al(OH)3 (but sometimes as α-Al(OH)3.[1]). It is also sometimes called hydrargillite (or hydrargyllite). 		\N
globalRadiation	Global Radiation	Solar radiation, direct and diffuse, received from a solid angle of 2p steradians on a horizontal surface. Source: World Meteorological Organization, Meteoterm		\N
glucosidase	Glucosidase	Glucosidases are glycoside hydrolase enzymes categorized under the EC number 3.2.1.		\N
glutaraldehyde	Glutaraldehyde	Glutaraldehyde (C5H8O2)		\N
glutathione_S_TransferaseActivity	Glutathione S-transferase, activity	Glutathione S-transferase (GST) activity		\N
glutathione_S_TransferaseDeltaCycleThreshold	Glutathione S-transferase, delta cycle threshold	Delta cycle threshold for glutathione S-transferase (gst). Cycle threshold is the PCR cycle number at which the fluorescent signal of the gene being amplified crosses the set threshold. Delta cycle threshold for gst is the difference between the cycle threshold (Ct) of gst gene expression and the cycle threshold (Ct) for the gene expression of the reference gene (e.g., beta-actin).		\N
goethite	Goethite	Goethite, FeO(OH), is an iron-bearing hydroxide mineral of the diaspore group. It is found in soil and other low-temperature environments. 		\N
grainSize	Grain size	Grain size (or particle size) is the diameter of individual grains of sediment, or the lithified particles in clastic rocks. The term may also be applied to other granular materials.		\N
grossAlphaRadionuclides	Gross alpha radionuclides	Gross Alpha Radionuclides		\N
grossBetaRadionuclides	Gross beta radionuclides	Gross Beta Radionuclides		\N
groundHeatFlux	Ground heat flux	Ground heat flux		\N
groundwaterDepth	Groundwater Depth	Groundwater depth is the distance between the water surface and the ground surface at a specific location specified by the site location and offset.		\N
hafnium	Hafnium	Hafnium is a chemical element with symbol Hf and atomic number 72. A lustrous, silvery gray, tetravalent transition metal, hafnium chemically resembles zirconium and is found in many zirconium minerals.		\N
hail	Hail	Hail is a form of solid precipitation. It is distinct from ice pellets (American English "sleet"), though the two are often confused. It consists of balls or irregular lumps of ice, each of which is called a hailstone.		\N
halloysite	Halloysite	Halloysite is an aluminosilicate clay mineral with the empirical formula Al2Si2O5(OH)4. Its main constituents are aluminium (20.90%), silicon (21.76%) and hydrogen (1.56%).		\N
hardnessCalcium	Hardness, Calcium	Hardness of calcium		\N
hardnessCarbonate	Hardness, carbonate	Carbonate hardness also known as temporary hardness		\N
hardnessMagnesium	Hardness, Magnesium	Hardness of magnesium		\N
hardnessNonCarbonate	Hardness, non-carbonate	Non-carbonate hardness		\N
hardnessTotal	Hardness, total	Total hardness		\N
heatIndex	Heat index	The combination effect of heat and humidity on the temperature felt by people.		\N
height	Height	Height is measure of vertical distance, either vertical extent or vertical position		\N
heightAboveSeaFloor	height, above sea floor	Vertical distance from the sea floor to a point.		\N
helium	Helium	Helium		\N
heliumDissolved	Helium, dissolved	Dissolved Helium (He)		\N
heptachlor	Heptachlor	Heptachlor (C10H5Cl7)		\N
heptachlorEpoxide	Heptachlor epoxide	Heptachlor epoxide (C10H5Cl7O)		\N
hexachlorobenzene	Hexachlorobenzene	Hexachlorobenzene (C6Cl6)		\N
hexachlorobutadiene	Hexachlorobutadiene	Hexachlorobutadiene (C4Cl6)		\N
hexachlorocyclopentadiene	Hexachlorocyclopentadiene	Hexachlorocyclopentadiene (C5Cl6)		\N
hexachloroethane	Hexachloroethane	Hexachloroethane (C2Cl6)		\N
hexane	Hexane	Hexane		\N
holmium	Holmium	Holmium is a chemical element with symbol Ho and atomic number 67. Part of the lanthanide series, holmium is a rare-earth element. Holmium was discovered by Swedish chemist Per Theodor Cleve.		\N
holmiumDissolved	Holmium, dissolved	Dissolved Holmium (Ho). "Dissolved " indicates a the measurement was made on a filtered sample.		\N
hostConnected	Host connected	A categorical variable marking the attachment of a host computer to a logger. This is used for quality control.		\N
humificationIndex	Humification index	Humification index. Hummification is the processes by which organic matter decomposes to form humus. In humus the initial structures or shapes can no longer be recognized. See also humus.		\N
hydraulicConductivity	Hydraulic conductivity	Hydraulic conductivity, symbolically represented as K, is a property of vascular plants, soils and rocks, that describes the ease with which a fluid (usually water) can move through pore spaces or fractures. It depends on the intrinsic permeability of the material, the degree of saturation, and on the density and viscosity of the fluid.		\N
hydrogen	Hydrogen	Hydrogen		\N
hydrogenSulfide	Hydrogen sulfide	Hydrogen sulfide (H2S)		\N
hydrogenDissolved	Hydrogen, dissolved	Dissolved Hydrogen		\N
hydrogen_2_StableIsotopeRatioDelta	Hydrogen-2, stable isotope ratio delta	Difference in the 2H:1H ratio between the sample and standard		\N
imaginaryDielectricConstant	Imaginary dielectric constant	Soil reponse of a reflected standing electromagnetic wave of a particular frequency which is related to the dissipation (or loss) of energy within the medium. This is the imaginary portion of the complex dielectric constant.		\N
indeno_1_2_3_cd_Pyrene	Indeno(1,2,3-cd)pyrene	Indeno(1,2,3-cd)pyrene (C22H12)		\N
indicator	Indicator	Binary status to indicate the status of an instrument or other piece of equipment.		\N
indium	Indium	Indium is a chemical element with symbol In and atomic number 49. It is a post-transition metal that makes up 0.21 parts per million of the Earth's crust. Very soft and malleable, indium has a melting point higher than sodium and gallium, but lower than lithium and tin.		\N
instrumentStatusCode	Instrument status code	Code value recorded by instrument indicating some information regarding the status of the instrument		\N
intercept	Intercept	The point at which one of the variables in a function equals 0.		\N
iodideDissolved	Iodide, dissolved	Dissolved Iodide (I-)		\N
Iron	Iron	Iron is a chemical element with symbol Fe (from Latin: ferrum) and atomic number 26. It is a metal in the first transition series.		\N
ironSulfide	Iron sulfide	Iron sulfide (FeS2)		\N
ironDissolved	Iron, dissolved	Dissolved Iron (Fe)		\N
ironFerric	Iron, ferric	Ferric Iron (Fe+3)		\N
ironFerrous	Iron, ferrous	Ferrous Iron (Fe+2)		\N
ironParticulate	Iron, particulate	Particulate iron (Fe) in suspension		\N
ironTotal	Iron, total	Total Iron (Fe)		\N
isobutane	Isobutane	Isobutane		\N
isobutyricAcid	Isobutyric acid	Isobutyric acid (C4H8O2)		\N
isopentane	Isopentane	Isopentane		\N
isophorone	Isophorone	Isophorone (C9H14O)		\N
isopropylAlcohol	Isopropyl alcohol	Isopropyl alcohol (C3H8O)		\N
isopropylbenzene	Isopropylbenzene	Isopropylbenzene (C9H12)		\N
ivaFrutescenscoverage	Iva frutescens coverage	Areal coverage of the plant Iva frutescens		\N
lacticAcid	Lactic Acid	Lactic Acid (C3H6O3)		\N
landClassification	Land classification	Geographical land classification- genetically homogeneous territorial unit within natural boundaries with a certain structure and a certain character of interrelationships of considered components		\N
lanthanum	Lanthanum	lanthanum is a chemical element with symbol La and atomic number 57. It is a soft, ductile, silvery-white metal that tarnishes rapidly when exposed to air and is soft enough to be cut with a knife.		\N
lanthanumDissolved	Lanthanum, dissolved	Dissolved Lanthanum (La). "Dissolved " indicates a the measurement was made on a filtered sample.		\N
latentHeatFlux	Latent heat flux	Latent Heat Flux		\N
latitude	Latitude	Latitude as a variable measurement or observation (Spatial reference to be designated in methods).  This is distinct from the latitude of a site which is a site attribute.		\N
lead	Lead	Lead is a chemical element with symbol Pb (from the Latin plumbum) and atomic number 82. It is a heavy metal that is denser than most common materials. Lead is soft and malleable, and has a relatively low melting point. When freshly cut, lead is silvery with a hint of blue; it tarnishes to a dull gray color when exposed to air. Lead has the highest atomic number of any stable element and three of its isotopes each conclude a major decay chain of heavier elements.		\N
leadDissolved	Lead, dissolved	Dissolved Lead (Pb). For chemical terms, dissolved indicates a filtered sample		\N
leadDistributionCoefficient	Lead, distribution coefficient	Ratio of concentrations of lead in two phases in equilibrium with each other. Phases must be specified.		\N
leadParticulate	Lead, particulate	Particulate lead (Pb) in suspension		\N
leadTotal	Lead, total	Total Lead (Pb). For chemical terms, total indicates an unfiltered sample.		\N
lead_208	Lead-208	Stable isotope of lead. The term stable isotope has a meaning similar to stable nuclide, but is preferably used when speaking of nuclides of a specific element. Hence, the plural form stable isotopes usually refers to isotopes of the same element. The relative abundance of such stable isotopes can be measured experimentally (isotope analysis), yielding an isotope ratio that can be used as a research tool.		\N
leafAreaIndex	Leaf area index (LAI)	Leaf area index (LAI) is a dimensionless quantity that characterizes plant canopies. It is defined as the one-sided green leaf area per unit ground surface area (LAI = leaf area / ground area, m2 / m2) in broadleaf canopies.		\N
leafWetness	Leaf wetness	The effect of moisture settling on the surface of a leaf as a result of either condensation or rainfall.		\N
length	Length	Length is a measure of distance.		\N
lightAttenuationCoefficient	Light attenuation coefficient	Light attenuation coefficient		\N
limoniumNashiiCoverage	Limonium nashii Coverage	Areal coverage of the plant Limonium nashii		\N
lithiumDissolved	Lithium, dissolved	Dissolved Lithium (Li). For chemical terms, dissolved indicates a filtered sample.		\N
lithiumTotal	Lithium, total	Total Lithium (Li). For chemical terms, total indicates an unfiltered sample.		\N
litterPlant	Litter, plant	Litterfall, plant litter, leaf litter, tree litter, soil litter, or duff, is dead plant material (such as leaves, bark, needles, twigs, and cladodes) that have fallen to the ground.		\N
liverMass	Liver, mass	Mass of the sample of liver tissue used for analyses		\N
loadSuspended	Load, suspended	The suspended load of a flow of fluid, such as a river, is the portion of its sediment uplifted by the fluid's flow in the process of sediment transportation. It is kept suspended by the fluid's turbulence. The suspended load generally consists of smaller particles, like clay, silt, and fine sands.		\N
loggerStopped	Logger stopped	A categorical variable indicating that a logger was told to stop recording data. This is used for quality control.		\N
longitude	Longitude	Longitude as a variable measurement or observation (Spatial reference to be designated in methods). This is distinct from the longitude of a site which is a site attribute.		\N
lossOnIgnition	Loss on ignition	Loss on ignition is a test used in inorganic analytical chemistry, particularly in the analysis of minerals. It consists of strongly heating ("igniting") a sample of the material at a specified temperature, allowing volatile substances to escape, until its mass ceases to change.		\N
lowBatteryCount	Low battery count	A counter of the number of times the battery voltage dropped below a minimum threshold		\N
LSI	LSI	Langelier Saturation Index is an indicator of the degree of saturation of water with respect to calcium carbonate		\N
luminousFlux	Luminous Flux	A measure of the total amount of visible light present		\N
lutetium	Lutetium	Lutetium is a chemical element with symbol Lu and atomic number 71. It is a silvery white metal, which resists corrosion in dry air, but not in moist air. Lutetium is the last element in the lanthanide series, and it is traditionally counted among the rare earths.		\N
lutetiumDissolved	Lutetium, dissolved	Dissolved Lutetium (Lu). "Dissolved " indicates a the measurement was made on a filtered sample.		\N
lyciumCarolinianumCoverage	Lycium carolinianum Coverage	Areal coverage of the plant Lycium carolinianum		\N
magnesium	Magnesium	Magnesium is a chemical element with symbol Mg and atomic number 12. It is a shiny gray solid which bears a close physical resemblance to the other five elements in the second column (Group 2, or alkaline earth metals) of the periodic table: they each have the same electron configuration in their outer electron shell producing a similar crystal structure.		\N
magnesiumDissolved	Magnesium, dissolved	Dissolved Magnesium (Mg)		\N
magnesiumTotal	Magnesium, total	Total Magnesium (Mg)		\N
malathion	Malathion	Butanedioic acid, [(dimethoxyphosphinothioyl)thio]-, diethyl ester (C10H19O6PS2)		\N
manganese	Manganese	Manganese is a chemical element with symbol Mn and atomic number 25. It is not found as a free element in nature; it is often found in combination with iron, and in many minerals. Manganese is a metal with important industrial metal alloy uses, particularly in stainless steels.		\N
manganeseDissolved	Manganese, dissolved	Dissolved Manganese (Mn)		\N
manganeseParticulate	Manganese, particulate	Particulate manganese (Mn) in suspension		\N
manganeseTotal	Manganese, total	Total manganese (Mn). "Total" indicates was measured on a whole water (unfiltered) sample.		\N
mass	Mass	Mass is a property of a physical body. It is generally a measure of an object's resistance to changing its state of motion when a force is applied.	Physical Property	\N
melanovanadite	Melanovanadite	melanovanadite a mineral Ca2V10O25 that is a complex oxide of calcium and vanadium		\N
mercuryDissolved	Mercury, dissolved	Dissolved Mercury (Hg). For chemical terms, dissolved indicates a filtered sample.		\N
mercuryTotal	Mercury, total	Total Mercury (Hg). For chemical terms, total represents an unfiltered sample.		\N
methane	Methane	Methane (CH4)		\N
methaneDissolved	Methane, dissolved	Dissolved Methane (CH4)		\N
methanol	Methanol	Methanol (CH3OH)		\N
methoxychlor	Methoxychlor	Methoxychlor (C16H15Cl3O2)		\N
methylTert_ButylEther_MTBE	Methyl tert-butyl ether (MTBE)	Methyl tert-butyl ether (MTBE) (C5H12O)		\N
methylchrysene	Methylchrysene	Methylchrysene (C19H14)		\N
methyleneBlueActiveSubstances	Methylene blue active substances	Methylene Blue Active Substances (MBAS)		\N
methyleneChloride_Dichloromethane	Methylene chloride (Dichloromethane)	Methylene chloride (Dichloromethane) (CH2Cl2)		\N
methylfluoranthene	Methylfluoranthene	Methylfluoranthene (C17H12)		\N
methylfluorene	Methylfluorene	Methylfluorene (C14H12)		\N
methylmercury	Methylmercury	Methylmercury (CH3Hg)		\N
methylpyrene	Methylpyrene	Methylpyrene (C17H12)		\N
mevinphos	Mevinphos	Mevinphos (C7H13O6P)		\N
mica	Mica	The mica group of sheet silicate minerals includes several closely related materials having nearly perfect basal cleavage. All are monoclinic, with a tendency towards pseudohexagonal crystals, and are similar in chemical composition.		\N
michaelisConstant	Michaelis constant	The Michaelis constant is the substrate concentration at which the reaction rate is half of Vmax. Vmax represents the maximum rate achieved by the system, at saturating substrate concentration		\N
microsomalProtein	Microsomal protein	The total protein concentration within the microsomal fraction of cells. Microsomes refer to vesicle-like artifacts reformed from pieces of endoplasmic reticulum when eukaryotic cells are broken up in a laboratory.		\N
molbydenumDissolved	Molbydenum, dissolved	Dissolved Molbydenum (Mo). For chemical terms, dissolved indicates a filtered sample.		\N
molybdenumDissolved	Molybdenum, dissolved	Dissolved Molybdenum (Mo). "Dissolved " indicates a the measurement was made on a filtered sample.		\N
molybdenumTotal	Molybdenum, total	total Molybdenum (Mo). For chemical terms, total represents an unfiltered sample.		\N
momentumFlux	Momentum flux	Momentum flux		\N
monanthochloeLittoralisCoverage	Monanthochloe littoralis Coverage	Areal coverage of the plant Monanthochloe littoralis		\N
NAlbuminoid	N, albuminoid	Albuminoid Nitrogen		\N
n_Alkane_C15	n-alkane, C15	C15 alkane, normal (i.e. straight-chain) isomer, common name: n-Pentadecane, formula : C15H32		\N
n_Alkane_C16	n-alkane, C16	C16 alkane, normal (i.e. straight-chain) isomer, common name: n-Hexadecane, formula: C16H34. Synonym: cetane		\N
n_Alkane_C17	n-alkane, C17	C17 alkane, normal (i.e. straight-chain) isomer, common name: n-Heptadecane, formula : C17H36		\N
n_Alkane_C18	n-alkane, C18	C18 alkane, normal (i.e. straight-chain) isomer, common name: n-Octadecane, formula : C18H38		\N
n_Alkane_C19	n-alkane, C19	C19 alkane, normal (i.e. straight-chain) isomer, common name: n-Nonadecane, formula : C19H40		\N
n_Alkane_C20	n-alkane, C20	C20 alkane, normal (i.e. straight-chain) isomer, common name: n-Icosane, formula : C20H42. Synonyms: didecyl, eicosane.		\N
n_Alkane_C21	n-alkane, C21	C21 alkane, normal (i.e. straight-chain) isomer, common name: n-Henicosane, formula : C21H44.		\N
n_Alkane_C22	n-alkane, C22	C22 alkane, normal (i.e. straight-chain) isomer, common name: n-Docosane, formula : C22H46		\N
n_Alkane_C23	n-alkane, C23	C23 alkane, normal (i.e. straight-chain) isomer, common name: n-Tricosane, formula : C23H48		\N
n_Alkane_C24	n-alkane, C24	C24 alkane, normal (i.e. straight-chain) isomer, common name: n-Tetracosane, formula : C24H50		\N
n_Alkane_C25	n-alkane, C25	C25 alkane, normal (i.e. straight-chain) isomer, common name: n-Pentacosane, formula : C25H52		\N
n_Alkane_C26	n-alkane, C26	C26 alkane, normal (i.e. straight-chain) isomer, common name: n-Hexacosane, formula : C26H54, synonyms: cerane, hexeikosane		\N
n_Alkane_C27	n-alkane, C27	C27 alkane, normal (i.e. straight-chain) isomer, common name: n-Heptacosane, formula : C27H56		\N
n_Alkane_C28	n-alkane, C28	C28 alkane, normal (i.e. straight-chain) isomer, common name: n-Octacosane, formula : C28H58		\N
n_Alkane_C29	n-alkane, C29	C29 alkane, normal (i.e. straight-chain) isomer, common name: n-Nonacosane, formula : C29H60		\N
n_Alkane_C30	n-alkane, C30	C30 alkane, normal (i.e. straight-chain) isomer, common name: n-Triacontane, formula : C30H62		\N
n_Alkane_C31	n-alkane, C31	C31 alkane,normal (i.e. straight-chain) isomer, common name: n-Hentriacontane, formula : C31H64, Synonym: untriacontane		\N
n_Alkane_C32	n-alkane, C32	C32 alkane, normal (i.e. straight-chain) isomer, common name: n-Dotriacontane, formula : C32H66, Synonym: dicetyl		\N
n_Alkane_C33	n-alkane, C33	C33 alkane, (i.e. straight-chain) isomer, common name: n-Tritriacontane, formula : C33H68		\N
n_AlkaneLongChain	n-alkane, long-chain	long-chain alkanes, normal (i.e. straight chain) isomer (isomer range of alkanes measured should be specified)		\N
n_AlkaneShortChain	n-alkane, short-chain	short-chain alkanes, normal (i.e. straight chain) isomer (isomer range of alkanes measured should be specified)		\N
n_AlkaneTotal	n-alkane, total	Total alkane, normal (i.e. straight chain) isomer (isomer range of alkanes measured should be specified)		\N
N_Nitrosodi_n_Butylamine	N-Nitrosodi-n-butylamine	N-Nitrosodi-n-butylamine (C8H18N2O)		\N
N_Nitrosodi_n_Propylamine	N-Nitrosodi-n-propylamine	N-Nitrosodi-n-propylamine (C6H14N2O)		\N
N_Nitrosodiethylamine	N-Nitrosodiethylamine	N-Nitrosodiethylamine (C4H10N2O)		\N
N_Nitrosodimethylamine	N-Nitrosodimethylamine	N-Nitrosodimethylamine (C2H6N2O)		\N
N_Nitrosodiphenylamine	N-Nitrosodiphenylamine	N-Nitrosodiphenylamine (C12H10N2O)		\N
N_Nitrosomethylethylamine	N-Nitrosomethylethylamine	N-Nitrosomethylethylamine (C3H8N2O)		\N
nacrite	Nacrite	Nacrite Al2Si2O5(OH)4 is a clay mineral that is polymorphous (or polytypic) with kaolinite. It crystallizes in the monoclinic system. X-ray diffraction analysis is required for positive identification. Nacrite was first described in 1807 for an occurrence in Saxony, Germany. The name is from nacre in reference to the mother of pearl luster of nacrite masses.		\N
naphthalene	Naphthalene	Naphthalene (C10H8)		\N
NDVI	NDVI	Normalized difference vegetation index		\N
neodymium	Neodymium	Neodymium is a chemical element with symbol Nd and atomic number 60. It is a soft silvery metal that tarnishes in air. Neodymium was discovered in 1885 by the Austrian chemist Carl Auer von Welsbach.		\N
neodymiumDissolved	Neodymium, dissolved	Dissolved Neodymium (Nd). "Dissolved " indicates a the measurement was made on a filtered sample.		\N
netHeatFlux	Net heat flux	Outgoing rate of heat energy transfer minus the incoming rate of heat energy transfer through a given area		\N
neutronCount	Neutron Count	Neutron counts of the naturally occurring cosmic rays.		\N
nickel	Nickel	Nickel is a chemical element with symbol Ni and atomic number 28. It is a silvery-white lustrous metal with a slight golden tinge. Nickel belongs to the transition metals and is hard and ductile. Pure nickel, powdered to maximize the reactive surface area, shows a significant chemical activity, but larger pieces are slow to react with air under standard conditions because an oxide layer forms on the surface and prevents further corrosion (passivation). Even so, pure native nickel is found in Earth's crust only in tiny amounts, usually in ultramafic rocks, and in the interiors of larger nickel–iron meteorites that were not exposed to oxygen when outside Earth's atmosphere. 		\N
nickelDissolved	Nickel, dissolved	Dissolved Nickel (Ni)		\N
nickelDistributionCoefficient	Nickel, distribution coefficient	Ratio of concentrations of nickel in two phases in equilibrium with each other. Phases must be specified.		\N
nickelParticulate	Nickel, particulate	Particulate nickel (Ni) in suspension		\N
nickelTotal	Nickel, total	Total Nickel (Ni). "Total" indicates was measured on a whole water (unfiltered) sample.		\N
niobiumDissolved	Niobium, dissolved	Niobium, formerly known as columbium, is a chemical element with symbol Nb (formerly Cb) and atomic number 41. It is a soft, grey, crystalline, ductile transition metal, often found in the minerals pyrochlore and columbite, hence the former name "columbium". Its name comes from Greek mythology, specifically Niobe, who was the daughter of Tantalus, the namesake of tantalum		\N
niobiumTotal	Niobium, total	Niobium, formerly known as columbium, is a chemical element with symbol Nb (formerly Cb) and atomic number 41. It is a soft, grey, crystalline, ductile transition metal, often found in the minerals pyrochlore and columbite, hence the former name "columbium". Its name comes from Greek mythology, specifically Niobe, who was the daughter of Tantalus, the namesake of tantalum		\N
nitrobenzene	Nitrobenzene	Nitrobenzene (C6H5NO2)		\N
petroleumHydrocarbonTotal	Petroleum hydrocarbon, total	Total petroleum hydrocarbon		\N
pH	pH	pH is the measure of the acidity or alkalinity of a solution. pH is formally a measure of the activity of dissolved hydrogen ions (H+). Solutions in which the concentration of H+ exceeds that of OH- have a pH value lower than 7.0 and are known as acids.		\N
phenanthrene	Phenanthrene	Phenanthrene (C14H10), a polycyclic aromatic hydrocarbon (PAH)		\N
phenol	Phenol	Phenol (C6H5OH)		\N
phenolicsTotal	Phenolics, total	Total Phenolics		\N
pheophytin	Pheophytin	Pheophytin (Chlorophyll which has lost the central Mg ion) is a degradation product of Chlorophyll		\N
nitrogen	Nitrogen	Nitrogen is a chemical element with symbol N and atomic number 7. It was first discovered and isolated by Scottish physician Daniel Rutherford in 1772. Although Carl Wilhelm Scheele and Henry Cavendish had independently done so at about the same time, Rutherford is generally accorded the credit because his work was published first. The name nitrogène was suggested by French chemist Jean-Antoine-Claude Chaptal in 1790, when it was found that nitrogen was present in nitric acid and nitrates. Antoine Lavoisier suggested instead the name azote, from the Greek άζωτικός "no life", as it is an asphyxiant gas; this name is instead used in many languages, such as French, Russian, and Turkish, and appears in the English names of some nitrogen compounds such as hydrazine, azides and azo compounds. 		\N
nitrogenDissolved_Free_Ionized_Ammonia_NH3_NH4	Nitrogen, dissolved (free+ionized) Ammonia (NH3) + (NH4)	Dissolved (free+ionized) Ammonia		\N
nitrogenDissolvedInorganic	Nitrogen, dissolved inorganic	Dissolved inorganic nitrogen		\N
nitrogenDissolvedKjeldahl	Nitrogen, dissolved Kjeldahl	Dissolved Kjeldahl (organic nitrogen + ammonia (NH3) + ammonium (NH4))nitrogen		\N
nitrogenDissolvedNitrate_NO3	Nitrogen, dissolved nitrate (NO3)	Dissolved nitrate (NO3) nitrogen		\N
nitrogenDissolvedNitrite_NO2	Nitrogen, dissolved nitrite (NO2)	Dissolved nitrite (NO2) nitrogen		\N
nitrogenDissolvedNitrite_NO2_Nitrate_NO3	Nitrogen, dissolved nitrite (NO2) + nitrate (NO3)	Dissolved nitrite (NO2) + nitrate (NO3) nitrogen		\N
nitrogenDissolvedOrganic	Nitrogen, dissolved organic	Dissolved Organic Nitrogen		\N
nitrogenGas	Nitrogen, gas	Gaseous Nitrogen (N2)		\N
nitrogenInorganic	Nitrogen, inorganic	Total Inorganic Nitrogen		\N
nitrogen_NH3	Nitrogen, NH3	Free Ammonia (NH3)		\N
nitrogenNH3_NH4	Nitrogen, NH3 + NH4	Total (free+ionized) Ammonia		\N
nitrogen_NH4	Nitrogen, NH4	Ammonium (NH4)		\N
nitrogenNitrate_NO3	Nitrogen, nitrate (NO3)	Nitrate (NO3) Nitrogen		\N
nitrogenNitrite_NO2	Nitrogen, nitrite (NO2)	Nitrite (NO2) Nitrogen		\N
nitrogenNitrite_NO2_Nitrate_NO3	Nitrogen, nitrite (NO2) + nitrate (NO3)	Nitrite (NO2) + Nitrate (NO3) Nitrogen		\N
nitrogenOrganic	Nitrogen, organic	Organic Nitrogen		\N
nitrogenOrganicKjeldahl	Nitrogen, organic kjeldahl	Organic Kjeldahl (organic nitrogen + ammonia (NH3) + ammonium (NH4)) nitrogen		\N
nitrogenParticulateOrganic	Nitrogen, particulate organic	Particulate Organic Nitrogen		\N
nitrogenTotal	Nitrogen, total	Total Nitrogen (NO3+NO2+NH4+NH3+Organic)		\N
nitrogenTotalDissolved	Nitrogen, total dissolved	Total dissolved nitrogen		\N
nitrogenTotalKjeldahl	Nitrogen, total kjeldahl	Total Kjeldahl Nitrogen (Ammonia+Organic)		\N
nitrogenTotalNitrite	Nitrogen, total nitrite	Total nitrite (NO2)		\N
nitrogenTotalOrganic	Nitrogen, total organic	Total (dissolved + particulate) organic nitrogen		\N
nitrogen_15	Nitrogen-15	15 Nitrogen, Delta Nitrogen		\N
nitrogen_15_StableIsotopeRatioDelta	Nitrogen-15, stable isotope ratio delta	Difference in the 15N:14N ratio between the sample and standard (del N 15)		\N
nitrousOxide	Nitrous oxide	Nitrous oxide (N2O)		\N
noVegetationCoverage	No vegetation coverage	Areal coverage of no vegetation		\N
o_Xylene	o-Xylene	o-Xylene (C8H10)		\N
odor	Odor	Odor		\N
offset	Offset	Constant to be added as an offset to a variable of interest.		\N
oilAndGrease	Oil and grease	Oil and grease		\N
organicMatter	Organic matter	The organic matter component of a complex material.		\N
orientation	Orientation	Azimuth orientation of sensor platform		\N
orthoclase	Orthoclase	Orthoclase, or orthoclase feldspar (endmember formula KAlSi3O8), is an important tectosilicate mineral which forms igneous rock. The name is from the Ancient Greek for "straight fracture," because its two cleavage planes are at right angles to each other. It is a type of potassium feldspar, also known as K-feldspar. The gem known as moonstone (see below) is largely composed of orthoclase.		\N
osmoticPressure	Osmotic pressure	Osmotic pressure		\N
oxygen	Oxygen	Oxygen		\N
oxygenFlux	Oxygen flux	Oxygen (O2) flux		\N
oxygenUptake	Oxygen uptake	Consumption of oxygen by biological and/or chemical processes		\N
oxygenDissolved	Oxygen, dissolved	Dissolved oxygen		\N
oxygenDissolvedPercentOfSaturation	Oxygen, dissolved percent of saturation	Dissolved oxygen, percent saturation		\N
oxygenDissolvedTransducerSignal	Oxygen, dissolved, transducer signal	Dissolved oxygen, raw data from sensor		\N
oxygen_18	Oxygen-18	18 O, Delta O		\N
oxygen_18_StableIsotopeRatioDelta	Oxygen-18, stable isotope ratio delta	Difference in the 18O:16O ratio between the sample and standard		\N
ozone	Ozone	Ozone (O3)		\N
parameter	Parameter	Parameter related to a hydrologic process. An example usage would be for a starge-discharge relation parameter.		\N
parathion_Ethyl	Parathion-ethyl	Parathion-ethyl (C10H14NO5PS)		\N
particleCounts	Particle counts	Count of insoluble particles in a liquid like rainwater		\N
pentachlorobenzene	Pentachlorobenzene	Pentachlorobenzene (C6HCl5)		\N
pentachlorophenol	Pentachlorophenol	Pentachlorophenol (C6HCl5O)		\N
pentane	Pentane	Pentane		\N
percentFullScale	Percent full scale	The percent of full scale for an instrument		\N
peridinin	Peridinin	The phytoplankton pigment Peridinin		\N
permethrin	Permethrin	Permethrin (C21H20Cl2O3)		\N
permittivity	Permittivity	Permittivity is a physical quantity that describes how an electric field affects, and is affected by a dielectric medium, and is determined by the ability of a material to polarize in response to the field, and thereby reduce the total electric field inside the material. Thus, permittivity relates to a material's ability to transmit (or "permit") an electric field.		\N
permittivityElectrical	Permittivity, electrical 	In electromagnetism, absolute permittivity, often simply called permittivity, usually denoted by the Greek letter ε (epsilon), is the measure of capacitance that is encountered when forming an electric field in a particular medium. More specifically, permittivity describes the amount of charge needed to generate one unit of electric flux in a particular medium. Accordingly, a charge will yield more electric flux in a medium with low permittivity than in a medium with high permittivity. Permittivity is the measure of a material's ability to store an electric field in the polarization of the medium. 		\N
perylene	Perylene	Perylene (C20H12), a polycyclic aromatic hydrocarbon (PAH)		\N
phorate	Phorate	Phorate (C7H17O2PS3)		\N
phosphorodithioicAcid	Phosphorodithioic acid	Phosphorodithioic acid (C10N12N3O3PS2)		\N
phosphorus	Phosphorus	Phosphorus is a chemical element with symbol P and atomic number 15. Elemental phosphorus exists in two major forms, white phosphorus and red phosphorus, but because it is highly reactive, phosphorus is never found as a free element on Earth. It has a concentration in the Earth's crust of about one gram per kilogram (compare copper at about 0.06 grams). With few exceptions, minerals containing phosphorus are in the maximally oxidized state as inorganic phosphate rocks.		\N
phosphorusPentoxide	Phosphorus pentoxide	Phosphorus pentoxide is a chemical compound with molecular formula P4O10 (with its common name derived from its empirical formula, P2O5). This white crystalline solid is the anhydride of phosphoric acid.		\N
phosphorusDissolved	Phosphorus, dissolved	Dissolved Phosphorus (P)		\N
phosphorusDissolvedOrganic	Phosphorus, dissolved organic	Dissolved organic phosphorus		\N
phosphorusInorganic	Phosphorus, inorganic	Inorganic Phosphorus		\N
phosphorusOrganic	Phosphorus, organic	Organic Phosphorus		\N
phosphorusOrthophosphate	Phosphorus, orthophosphate	Orthophosphate Phosphorus		\N
phosphorusOrthophosphateDissolved	Phosphorus, orthophosphate dissolved	Dissolved orthophosphate phosphorus		\N
phosphorusOrthophosphateTotal	Phosphorus, orthophosphate total	Total orthophosphate phosphorus		\N
phosphorusParticulate	Phosphorus, particulate	Particulate phosphorus		\N
phosphorusParticulateOrganic	Phosphorus, particulate organic	Particulate organic phosphorus in suspension		\N
phosphorusPhosphate_PO4	Phosphorus, phosphate (PO4)	Phosphate phosphorus		\N
hosphorusPhosphateFlux	Phosphorus, phosphate flux	Phosphate (PO4) flux		\N
phosphorusPolyphosphate	Phosphorus, polyphosphate	Polyphosphate Phosphorus		\N
phosphorusTotal	Phosphorus, total	Total Phosphorus		\N
phosphorusTotalDissolved	Phosphorus, total dissolved	Total dissolved phosphorus		\N
photosyntheticPhotonFluxDensity	Photosynthetic photon flux density (PPFD)	The number of photons per unit time and per unit area in the wavelength band 400 to 700 nm		\N
phytoplankton	Phytoplankton	Measurement of phytoplankton with no differentiation between species		\N
piperonylButoxide	Piperonyl Butoxide	Piperonyl Butoxide (C19H30O5)		\N
plagioclase	Plagioclase	Plagioclase is a series of tectosilicate (framework silicate) minerals within the feldspar group. Rather than referring to a particular mineral with a specific chemical composition, plagioclase is a continuous solid solution series, more properly known as the plagioclase feldspar series (from the Ancient Greek for "oblique fracture", in reference to its two cleavage angles)		\N
polycyclicAromaticHydrocarbonAlkyl	Polycyclic aromatic hydrocarbon, alkyl	Polycyclic aromatic hydrocarbon (PAH) having at least one alkyl sidechain (methyl, ethyl or other alkyl group) attached to the aromatic ring structure		\N
polycyclicAromaticHydrocarbonParent	Polycyclic aromatic hydrocarbon, parent	Unsubstituted (i.e., non-alkylated) polycyclic aromatic hydrocarbon (PAH)		\N
polycyclicAromaticHydrocarbonTotal	Polycyclic aromatic hydrocarbon, total	total polycyclic aromatic hydrocarbon (PAH), also known as poly-aromatic hydrocarbons or polynuclear aromatic hydrocarbons		\N
porosity	Porosity	Porosity or void fraction is a measure of the void (i.e. "empty") spaces in a material, and is a fraction of the volume of voids over the total volume, between 0 and 1, or as a percentage between 0 and 100%.		\N
position	Position	Position of an element that interacts with water such as reservoir gates		\N
potassium	Potassium	Potassium is a chemical element with symbol K and atomic number 19. It was first isolated from potash, the ashes of plants, from which its name derives. In the periodic table, potassium is one of the alkali metals. All of the alkali metals have a single valence electron in the outer electron shell, which is easily removed to create an ion with a positive charge – a cation, which combines with anions to form salts. Potassium in nature occurs only in ionic salts. Elemental potassium is a soft silvery-white alkali metal that oxidizes rapidly in air and reacts vigorously with water, generating sufficient heat to ignite hydrogen emitted in the reaction, and burning with a lilac-colored flame. It is found dissolved in sea water (which is 0.04% potassium by weight), and is part of many minerals. 		\N
potassiumOxide	Potassium oxide	Potassium oxide (K2O), or Kalium oxide, is an ionic compound of potassium and oxygen.		\N
potassiumDissolved	Potassium, dissolved	Dissolved Potassium (K)		\N
potassiumTotal	Potassium, total	Total Potassium (K)		\N
praseodymium	Praseodymium	Praseodymium is a chemical element with symbol Pr and atomic number 59. It is the third member of the lanthanide series and is traditionally considered to be one of the rare-earth metals. Praseodymium is a soft, silvery, malleable and ductile metal, valued for its magnetic, electrical, chemical, and optical properties.		\N
praseodymiumDissolved	Praseodymium, dissolved	Dissolved Praseodymium (Pr). "Dissolved " indicates a the measurement was made on a filtered sample.		\N
precipitation	Precipitation	Precipitation such as rainfall. Should not be confused with settling.		\N
pressureAbsolute	Pressure, absolute	Pressure		\N
pressureGauge	Pressure, gauge	Pressure relative to the local atmospheric or ambient pressure		\N
primaryProductivity	Primary productivity	Primary Productivity		\N
primaryProductivityGross	Primary productivity, gross	Rate at which an ecosystem accumulates energy by fixation of sunlight, including that consumed by the ecosystem.		\N
programSignature	Program signature	A unique data recorder program identifier which is useful for knowing when the source code in the data recorder has been modified.		\N
pronamide	Pronamide	Pronamide (C12H11Cl2NO)		\N
propane	Propane	Propane		\N
propaneDissolved	Propane, dissolved	Dissolved Propane (C3H8)		\N
propanoicAcid	Propanoic acid	Propanoic acid (C3H6O2)		\N
propyleneGlycol	Propylene glycol	Propylene glycol (C3H8O2)		\N
pyrene	Pyrene	Pyrene (C16H10), a polycyclic aromatic hydrocarbon (PAH)		\N
pyridine	Pyridine	Pyridine (C5H5N)		\N
quartz	Quartz	Quartz is a type of silicate mineral composed of silicon and oxygen atoms.		\N
radiationIncoming	Radiation, incoming	Incoming radiation		\N
radiationIncomingLongwave	Radiation, incoming longwave	Incoming Longwave Radiation		\N
radiationIncomingPAR	Radiation, incoming PAR	Incoming Photosynthetically-Active Radiation		\N
radiationIncomingShortwave	Radiation, incoming shortwave	Incoming Shortwave Radiation		\N
radiationIncomingUV_A	Radiation, incoming UV-A	Incoming Ultraviolet A Radiation		\N
radiationIncomingUV_B	Radiation, incoming UV-B	Incoming Ultraviolet B Radiation		\N
radiationNet	Radiation, net	Net Radiation		\N
radiationNetLongwave	Radiation, net longwave	Net Longwave Radiation		\N
radiationNetPAR	Radiation, net PAR	Net Photosynthetically-Active Radiation		\N
radiationNetShortwave	Radiation, net shortwave	Net Shortwave radiation		\N
radiationOutgoingLongwave	Radiation, outgoing longwave	Outgoing Longwave Radiation		\N
radiationOutgoingPAR	Radiation, outgoing PAR	Outgoing Photosynthetically-Active Radiation		\N
radiationOutgoingShortwave	Radiation, outgoing shortwave	Outgoing Shortwave Radiation		\N
radiationTotalIncoming	Radiation, total incoming	Total amount of incoming radiation from all frequencies		\N
radiationTotalOutgoing	Radiation, total outgoing	Total amount of outgoing radiation from all frequencies		\N
radiationTotalShortwave	Radiation, total shortwave	Total Shortwave Radiation		\N
radium_226	Radium-226	An isotope of radium in the uranium-238 decay series		\N
radium_228	Radium-228	An isotope of radium in the thorium-232 decay series		\N
radon_222	Radon-222	An isotope of radon		\N
rainfallRate	Rainfall rate	A measure of the intensity of rainfall, calculated as the depth of water to fall over a given time period if the intensity were to remain constant over that time interval (in/hr, mm/hr, etc)		\N
realDielectricConstant	Real dielectric constant	Soil reponse of a reflected standing electromagnetic wave of a particular frequency which is related to the stored energy within the medium. This is the real portion of the complex dielectric constant.		\N
receivedSignalStrenghtIndication	Received signal strength indication	In telecommunications, received signal strength indicator (RSSI) is a measurement of the power present in a received radio signal.	Level	\N
rechargeGroundwater	Recharge, groundwater 	Groundwater recharge or deep drainage or deep percolation is a hydrologic process where water moves downward from surface water to groundwater. Recharge is the primary method through which water enters an aquifer. This process usually occurs in the vadose zone below plant roots and is often expressed as a flux to the water table surface. Recharge occurs both naturally (through the water cycle) and through anthropogenic processes (i.e., "artificial groundwater recharge"), where rainwater and or reclaimed water is routed to the subsurface.		\N
recorderCode	Recorder code	A code used to identifier a data recorder.		\N
reductionPotential	Reduction potential	Oxidation-reduction potential		\N
reflectivity	Reflectivity	dBZ stands for decibel relative to Z. It is a logarithmic dimensionless technical unit used in radar, mostly in weather radar, to compare the equivalent reflectivity factor (Z) of a radar signal reflected off a remote object (in mm6 per m3) to the return of a droplet of rain with a diameter of 1 mm (1 mm6 per m3). It is proportional to the number of drops per unit volume and the sixth power of drops' diameter and is thus used to estimate the rain or snow intensity.		\N
relativeHumidity	Relative humidity	Relative humidity		\N
remark	Remark	Manually added comment field to provide additional information about a particular record.		\N
reservoirStorage	Reservoir storage	Reservoir water volume		\N
resistivityElectrical	Resistivity, electrical	The electrical resistance of an object is a measure of its opposition to the flow of electric current. The inverse quantity is electrical conductance, and is the ease with which an electric current passes.		\N
respirationEcosystem	Respiration, ecosystem	Gross carbon dioxide production by all organisms in an ecosystem. Ecosystem respiration is the sum of all respiration occurring by the living organisms in a specific ecosystem.		\N
respirationNet	Respiration, net	Net respiration		\N
retene	Retene	Retene (C18H18), a polycyclic aromatic hydrocarbon (PAH), also known as methyl isopropyl phenanthrene or 1-methyl-7-isopropyl phenanthrene		\N
rheniumTotal	Rhenium, total	Total Rhenium (Re)		\N
roundness	Roundness	Roundness is the measure of how closely the shape of an object approaches that of a mathematically perfect circle. Roundness applies in two dimensions, such as the cross sectional circles along a cylindrical object such as a shaft or a cylindrical roller for a bearing. In geometric dimensioning and tolerancing, control of a cylinder can also include its fidelity to the longitudinal axis, yielding cylindricity. The analogue of roundness in three dimensions (that is, for spheres) is sphericity.		\N
rubidium	Rubidium	A chemical element with symbol Rb and atomic number 37. Rubidium is a soft, silvery-white metallic element of the alkali metal group, with a standard atomic weight of 85.4678. Elemental rubidium is highly reactive, with properties similar to those of other alkali metals, including rapid oxidation in air. On Earth, natural rubidium comprises two isotopes: 72% is the stable isotope, 85Rb; 28% is the slightly radioactive 87Rb, with a half-life of 49 billion years—more than three times longer than the estimated age of the universe.		\N
ruthenium_106	Ruthenium-106	The most stable isotope of ruthenium with a half life of 373.59 days.		\N
salicorniaBigeloviiCoverage	Salicornia bigelovii coverage	Areal coverage of the plant Salicornia bigelovii		\N
salicorniaVirginicaCoverage	Salicornia virginica coverage	Areal coverage of the plant Salicornia virginica		\N
salinity	Salinity	Salinity		\N
samarium	Samarium	A chemical element with symbol Sm and atomic number 62. It is a moderately hard silvery metal that slowly oxidizes in air. Being a typical member of the lanthanide series, samarium usually assumes the oxidation state +3.		\N
samariumDissolved	Samarium, dissolved	Dissolved Samarium (Sm). "Dissolved " indicates a the measurement was made on a filtered sample.		\N
Sand	Sand	USDA particle size distribution category. 0.5 to 2 mm diameter fine earth particles. 		\N
sapFlow	Sap flow	Movement of xylem sap in trees.		\N
scandium	Scandium	A chemical element with symbol Sc and atomic number 21. A silvery-white metallic d-block element, it has historically been classified as a rare-earth element, together with yttrium and the lanthanides. It was discovered in 1879 by spectral analysis of the minerals euxenite and gadolinite from Scandinavia.		\N
scatterAntiStokes	Scatter, anti-stokes	The material loses energy and the emitted photon has a higher energy than the absorbed photon. This outcome is labeled anti-Stokes Raman scattering.		\N
technetium	Technetium	Technetium is a chemical element with symbol Tc and atomic number 43. It is the lightest element whose isotopes are all radioactive; none are stable, excluding the fully ionized state of 97Tc.		\N
scatterStokes	Scatter, Stokes	The material absorbs energy and the emitted photon has a lower energy than the incident photon. This outcome is labeled Stokes Raman scattering in honor of George Stokes who showed in 1852 that fluorescence is due to light emission at longer wavelength (now known to correspond to lower energy) than the absorbed incident light.		\N
secchiDepth	Secchi depth	Secchi depth		\N
sedimentPassingSieve	Sediment, passing sieve	The amount of sediment passing a sieve in a gradation test		\N
sedimentRetainedOnSieve	Sediment, retained on sieve	The amount of sediment retained on a sieve in a gradation test		\N
sedimentSuspended	Sediment, suspended	Suspended Sediment		\N
seismicRefraction	Seismic refraction	Seismic refraction is a geophysical principle (see refraction) governed by Snell's Law. Used in the fields of engineering geology, geotechnical engineering and exploration geophysics, seismic refraction traverses (seismic lines) are performed using a seismograph(s) and/or geophone(s), in an array and an energy source.		\N
seleniumDissolved	Selenium, dissolved	Dissolved selenium (Se). For chemical terms, dissolved indicates a filtered sample.		\N
seleniumDistributionCoefficient	Selenium, distribution coefficient	Ratio of concentrations of selenium in two phases in equilibrium with each other. Phases must be specified.		\N
seleniumParticulate	Selenium, particulate	Particulate selenium (Se) in suspension		\N
seleniumTotal	Selenium, total	Total Selenium (Se). For chemical terms, total indicates an unfiltered sample		\N
sensibleHeatFlux	Sensible heat flux	Sensible Heat Flux		\N
sequenceNumber	Sequence number	A counter of events in a sequence		\N
shannonDiversityIndex	Shannon diversity index	A diversity index that is based on the number of taxa, and the proportion of individuals in each taxa relative to the entire community, evaluated as entropy. Also known as Shannon-Weaver diversity index, the Shannon-Wiener index, the Shannon index and the Shannon entropy.		\N
shannonEvennessIndex	Shannon evenness index	A dimensionless diversity index, calculated as a ratio of the Shannon diversity index over its maximum. Also known as the Shannon Weaver evenness index		\N
sigma_t	Sigma-t	Density of seawater calculated with in situ salinity and temperature, but pressure equal to zero, rather than the in situ pressure, and 1000 kg/m^3 is subtracted. Defined as (S,T)-1000 kg m-3, where (S,T) is the density of a sample of seawater at temperature T and salinity S, measured in kg m-3, at standard atmospheric pressure.		\N
signalQuality	Signal quality	Internal signature measurent quality		\N
signalToNoiseRatio	Signal-to-noise ratio	Signal-to-noise ratio (often abbreviated SNR or S/N) is defined as the ratio of a signal power to the noise power corrupting the signal. The higher the ratio, the less obtrusive the background noise is.		\N
silica	Silica	Silica (SiO2)		\N
silicaDissolved	Silica, dissolved	Dissolved silica (SiO2)		\N
silicate	Silicate	Silicate. Chemical compound containing silicon, oxygen, and one or more metals, e.g., aluminum, barium, beryllium, calcium, iron, magnesium, manganese, potassium, sodium, or zirconium.		\N
silicicAcid	Silicic acid	Hydrated silica disolved in water		\N
silicicAcidFlux	Silicic acid flux	Silicate acid (H4SiO4) flux		\N
silicon	Silicon	Silicon (Si)		\N
siliconDissolved	Silicon, dissolved	Dissolved Silicon (Si)		\N
siliconTotal	Silicon, total	Total silicon (Si)		\N
Silt	Silt	USDA particle size distribution category. 0.002 to 0.5 mm diameter fine earth particles. 		\N
silver	Silver	A chemical element with symbol Ag (from the Latin argentum, derived from the Proto-Indo-European h₂erǵ: "shiny" or "white") and atomic number 47. A soft, white, lustrous transition metal, it exhibits the highest electrical conductivity, thermal conductivity, and reflectivity of any metal. The metal is found in the Earth's crust in the pure, free elemental form ("native silver"), as an alloy with gold and other metals, and in minerals such as argentite and chlorargyrite. Most silver is produced as a byproduct of copper, gold, lead, and zinc refining.		\N
silverDissolved	Silver, dissolved	Dissolved silver (Ag). For chemical terms, dissolved indicates a filtered sample.		\N
silverTotal	Silver, total	Total Silver (Ag). For chemical terms, total represents an unfiltered sample.		\N
slope	Slope	Ratio between two variables in a linear relationship.		\N
snowDepth	Snow depth	Snow depth		\N
snowLayerHardness	Snow layer hardness	Snow layers within the snowpack are a record of the winter’s weather. Like tree rings or strata of rock, layers can be traced to dates and conditions that formed them. One of the most important characteristics of a layer is its hardness. Harder snow is stronger and cohesive, while softer snow is weaker. 		\N
snowWaterEquivalent	Snow water equivalent	The depth of water if a snow cover is completely melted, expressed in units of depth, on a corresponding horizontal surface area.		\N
sodium	Sodium	A chemical element with symbol Na (from Latin natrium) and atomic number 11. It is a soft, silvery-white, highly reactive metal. Sodium is an alkali metal, being in group 1 of the periodic table, because it has a single electron in its outer shell that it readily donates, creating a positively charged ion—the Na+ cation. Its only stable isotope is 23Na. The free metal does not occur in nature, but must be prepared from compounds. Sodium is the sixth most abundant element in the Earth's crust and exists in numerous minerals such as feldspars, sodalite, and rock salt (NaCl). Many salts of sodium are highly water-soluble: sodium ions have been leached by the action of water from the Earth's minerals over eons, and thus sodium and chlorine are the most common dissolved elements by weight in the oceans. 		\N
sodiumAdsorptionRatio	Sodium adsorption ratio	Sodium adsorption ratio		\N
sodiumPlusPotassium	Sodium plus potassium	Sodium plus potassium		\N
sodiumDissolved	Sodium, dissolved	Dissolved Sodium (Na)		\N
sodiumFractionOfCations	Sodium, fraction of cations	Sodium, fraction of cations		\N
sodiumTotal	Sodium, total	Total Sodium (Na)		\N
soilAggregateStability	Soil aggregate stability	Soil aggregate stability is a measure of the ability of soil aggregates to resist degradation when exposed to external forces such as water erosion and wind erosion, shrinking and swelling processes, and tillage. Soil aggregate stability is a measure of soil structure and can be impacted by soil management.		\N
temperature	Temperature	Temperature		\N
temperatureChange	Temperature change	temperature change		\N
temperatureDatalogger	Temperature, datalogger	Temperature, raw data from datalogger		\N
temperatureDewPoint	Temperature, dew point	Dew point temperature		\N
soilClassification	Soil classification	For soil resources, experience has shown that a natural system approach to classification, i.e. grouping soils by their intrinsic property (soil morphology), behaviour, or genesis, results in classes that can be interpreted for many diverse uses. Differing concepts of pedogenesis, and differences in the significance of morphological features to various land uses can affect the classification approach.		\N
soilCoarseFraction	Soil coarse fraction	Fraction of particles within a soil sample that are greater that 2mm in diameter		\N
soilHorizon	Soil horizon	A soil horizon is a layer parallel to the soil surface, whose physical characteristics differ from the layers above and beneath. Each soil type usually has three or four horizons.		\N
soilOrganicMatter	Soil organic matter (SOM)	Soil organic matter (SOM) is the organic matter component of soil, consisting of plant and animal residues at various stages of decomposition, cells and tissues of soil organisms, and substances synthesized by soil organisms.		\N
soilOrganicMatterDensityFractionation	Soil organic matter (SOM) density fractionation	Density fraction of Soil organic matter (SOM) in soil. Soil organic matter (SOM) is the organic matter component of soil, consisting of plant and animal residues at various stages of decomposition, cells and tissues of soil organisms, and substances synthesized by soil organisms.		\N
soilRespiration	Soil respiration	Soil respiration refers to the production of carbon dioxide when soil organisms respire. This includes respiration of plant roots, the rhizosphere, microbes and fauna.		\N
soilTexture	Soil texture	Soil texture is a classification instrument used both in the field and laboratory to determine soil classes based on their physical texture. Soil texture can be determined using qualitative methods such as texture by feel, and quantitative methods such as the hydrometer method.		\N
solidsRixedDissolved	Solids, fixed dissolved	Fixed Dissolved Solids		\N
solidsFixedSuspended	Solids, fixed suspended	Fixed Suspended Solids		\N
solidsTotal	Solids, total	Total Solids		\N
solidsTotalDissolved	Solids, total dissolved	Total Dissolved Solids		\N
solidsTotalFixed	Solids, total fixed	Total Fixed Solids		\N
solidsTotalSuspended	Solids, total suspended	Total Suspended Solids		\N
solidsTotalVolatile	Solids, total volatile	Total Volatile Solids		\N
solidsVolatileDissolved	Solids, volatile dissolved	Volatile Dissolved Solids		\N
solidsVolatileSuspended	Solids, volatile suspended	Volatile Suspended Solids		\N
spartinaAlternifloraCoverage	Spartina alterniflora coverage	Areal coverage of the plant Spartina alterniflora		\N
spartinaSpartineaCoverage	Spartina spartinea coverage	Areal coverage of the plant Spartina spartinea		\N
specificConductance	Specific conductance	Specific conductance		\N
speedOfSound	Speed of sound	Speed of sound in the medium sampled		\N
squalene	Squalene	Squalene (C30H50)		\N
streamflow	Streamflow	The volume of water flowing past a fixed point.  Equivalent to discharge		\N
streptococciFecal	Streptococci, fecal	Fecal Streptococci		\N
strontium	Strontium	Strontium is the chemical element with symbol Sr and atomic number 38. An alkaline earth metal, strontium is a soft silver-white yellowish metallic element that is highly chemically reactive. The metal forms a dark oxide layer when it is exposed to air. Strontium has physical and chemical properties similar to those of its two vertical neighbors in the periodic table, calcium and barium. It occurs naturally mainly in the minerals celestine and strontianite, and is mostly mined from these. While natural strontium is stable, the synthetic 90Sr isotope is radioactive and is one of the most dangerous components of nuclear fallout, as strontium is absorbed by the body in a similar manner to calcium. Natural stable strontium, on the other hand, is not hazardous to health.		\N
strontiumDissolved	Strontium, dissolved	Dissolved Strontium (Sr)		\N
strontiumTotal	Strontium, total	Total Strontium (Sr)		\N
styrene	Styrene	Styrene (C8H8)		\N
suaedaLinearisCoverage	Suaeda linearis coverage	Areal coverage of the plant Suaeda linearis		\N
suaedaMaritimaCoverage	Suaeda maritima coverage	Areal coverage of the plant Suaeda maritima		\N
sulfate	Sulfate	The sulfate or sulphate (see spelling differences) ion is a polyatomic anion with the empirical formula SO2-\n 4. Sulfate is the spelling recommended by IUPAC, but sulphate is used in British English. Salts, acid derivatives, and peroxides of sulfate are widely used in industry. Sulfates occur widely in everyday life. Sulfates are salts of sulfuric acid and many are prepared from that acid.		\N
sulfateDissolved	Sulfate, dissolved	Dissolved Sulfate (SO4)		\N
sulfateTotal	Sulfate, total	Total Sulfate (SO4)		\N
sulfideDissolved	Sulfide, dissolved	Dissolved Sulfide		\N
sulfideTotal	Sulfide, total	Total sulfide		\N
sulfur	Sulfur	Sulfur (S)		\N
sulfurDioxide	Sulfur dioxide	Sulfur dioxide (SO2)		\N
sulfurDissolved	Sulfur, dissolved	Dissolved Sulfur (S)		\N
sulfurOrganic	Sulfur, organic	Organic Sulfur		\N
sulfurPyritic	Sulfur, pyritic	Pyritic Sulfur		\N
sunshineDuration	Sunshine duration	Sunshine duration		\N
superoxideDismutaseActivity	Superoxide dismutase, activity	Superoxide dismutase (SOD) activity		\N
superoxideDismutaseDeltaCycleThreshold	Superoxide dismutase, delta cycle threshold	Delta cycle threshold for superoxide dismutase (sod). Cycle threshold is the PCR cycle number at which the fluorescent signal of the gene being amplified crosses the set threshold. Delta cycle threshold for sod is the difference between the cycle threshold (Ct) of sod gene expression and the cycle threshold (Ct) for the gene expression of the reference gene (e.g., beta-actin).		\N
SUVA254	SUVA254	Specific ultraviolet absorbance at 254 nm. Determined by absorbance normalized to DOC concentration.		\N
SUVA280	SUVA280	Specific ultraviolet absorbance at 280 nm. Determined by absorbance normalized to dissolved organic carbon (DOC) concentration.		\N
tableOverrunErrorCount	Table overrun error count	A counter which counts the number of datalogger table overrun errors		\N
tantalum	Tantalum	Tantalum is a rare, hard, blue-gray, lustrous transition metal that is highly corrosion-resistant. It is part of the refractory metals group, which are widely used as minor components in alloys.		\N
taxaCount	Taxa count	Count of unique taxa. A taxon (plural: taxa) is a group of one (or more) populations of organism(s), which is judged to be a unit.		\N
TDRWaveformRelativeLength	TDR waveform relative length	Time domain reflextometry, apparent length divided by probe length. Square root of dielectric		\N
temperatureInitial	Temperature, initial	initial temperature before heating		\N
temperatureSensor	Temperature, sensor	Temperature, raw data from sensor		\N
temperatureTransducerSignal	Temperature, transducer signal	Temperature, raw data from sensor		\N
terbium	Terbium	Terbium is a chemical element with symbol Tb and atomic number 65. It is a silvery-white, rare earth metal that is malleable, ductile, and soft enough to be cut with a knife.		\N
terbiumDissolved	Terbium, dissolved	Dissolved Terbium (Tb). "Dissolved " indicates a the measurement was made on a filtered sample.		\N
terbufos	Terbufos	Terbufos (C9H21O2PS3)		\N
terpineol	Terpineol	Terpineol (C10H18O)		\N
tertAmylMethylEther	Tert-Amyl Methyl Ether	Tert-Amyl Methyl Ether (C6H14O)		\N
tertiaryButylAlcohol	Tertiary Butyl Alcohol	Tertiary Butyl Alcohol (C4H10O)		\N
tetracene	Tetracene	Tetracene (C18H12), a polycyclic aromatic hydrocarbon (PAH), also known as naphthacene or benz[b]anthracene		\N
tetrachloroethene	Tetrachloroethene	Tetrachloroethene (C2Cl4)		\N
tetraethyleneGlycol	Tetraethylene glycol	Tetraethylene glycol (C8H18O5)		\N
tetrahydrofuran	Tetrahydrofuran	Tetrahydrofuran (C4H8O)		\N
tetramethylnaphthalene	Tetramethylnaphthalene	Tetramethylnaphthalene (C10H4(CH3)4), a polycyclic aromatic hydrocarbon (PAH)		\N
thallium	Thallium	Thallium is a chemical element with symbol Tl and atomic number 81. It is a gray post-transition metal that is not found free in nature. When isolated, thallium resembles tin, but discolors when exposed to air. Chemists William Crookes and Claude-Auguste Lamy discovered thallium independently in 1861, in residues of sulfuric acid production. Both used the newly developed method of flame spectroscopy, in which thallium produces a notable green spectral line.		\N
thalliumDissolved	Thallium, dissolved	Dissolved thallium (Tl). "dissolved" indicates measurement was made on a filtered sample.		\N
thalliumDistributionCoefficient	Thallium, distribution coefficient	Ratio of concentrations of thallium in two phases in equilibrium with each other. Phases must be specified.		\N
thalliumParticulate	Thallium, particulate	Particulate thallium (Tl) in suspension		\N
thalliumTotal	Thallium, total	Total thallium (Tl). "Total" indicates was measured on a whole water (unfiltered) sample.		\N
thorium	Thorium	Thorium is a weakly radioactive metallic chemical element with symbol Th and atomic number 90. Thorium is silvery and tarnishes black when it is exposed to air, forming thorium dioxide; it is moderately hard, malleable, and has a high melting point.		\N
thoriumDissolved	Thorium, dissolved	Dissolved thorium. For chemical terms, dissolved indicates a filtered sample.		\N
thorium_228	Thorium-228	An isotope of thorium in the thorium-232 decay series		\N
thorium_230	Thorium-230	An isotope of thorium in the thorium-232 decay series		\N
thorium_232	Thorium-232	A radioactive isotope of thorium which undergoes alpha decay		\N
threshold	Threshold	A level above or below which an action is performed.		\N
throughfall	Throughfall	In Hydrology, throughfall is the process which describes how wet leaves shed excess water onto the ground surface. These drops have greater erosive power because they are heavier than rain drops. Furthermore, where there is a high canopy, falling drops may reach terminal velocity, about 8 metres (26 ft), thus maximizing the drop's erosive potential.		\N
THSWIndex	THSW Index	The THSW Index uses temperature, humidity, solar radiation, and wind speed to calculate an apparent temperature.		\N
thulium	Thulium	Thulium is a chemical element with symbol Tm and atomic number 69. It is the thirteenth and third-last element in the lanthanide series. Like the other lanthanides, the most common oxidation state is +3, seen in its oxide, halides and other compounds; because it occurs so late in the series, however, the +2 oxidation state is also stabilized by the nearly full 4f shell that results.		\N
thuliumDissolved	Thulium, dissolved	Dissolved Thulium (Tm). "Dissolved " indicates a the measurement was made on a filtered sample.		\N
THWIndex	THW Index	The THW Index uses temperature, humidity, and wind speed to calculate an apparent temperature.		\N
tideStage	Tide stage	Tidal stage		\N
timeStamp	Time Stamp	The time at which a sensor produces output		\N
timeElapsed	Time, elapsed	Time elapsed since an event occurred		\N
tinDissolved	Tin, dissolved	Dissolved tin (Sn). "Dissolved " indicates a the measurement was made on a filtered sample.		\N
tinTotal	Tin, total	Total tin (Sn)."Total" indicates was measured on a whole water (unfiltered) sample.		\N
titanium	Titanium	Titanium (Ti)		\N
titaniumDioxide	Titanium dioxide	Titanium dioxide, also known as titanium(IV) oxide or titania, is the naturally occurring oxide of titanium, chemical formula TiO\n 2. When used as a pigment, it is called titanium white, Pigment White 6 (PW6), or CI 77891.		\N
titaniumDissolved	Titanium, dissolved	Dissolved Titanium		\N
titaniumTotal	Titanium, total	Total titanium (Ti)		\N
toluene	Toluene	Toluene (C6H5CH3)		\N
topographicWetnessIndex	Topographic Wetness Index (TWI)	Topographic wetness index (TWI), also known as the compound topographic index (CTI), is a steady state wetness index. It is commonly used to quantify topographic control on hydrological processes.		\N
trans_1_2_Dichloroethene	trans-1,2-Dichloroethene	trans-1,2-Dichloroethene (C2H2Cl2)		\N
trans_1_3_Dichloropropene	trans-1,3-Dichloropropene	trans-1,3-Dichloropropene (C3H4Cl2)		\N
transientSpeciesCoverage	Transient species coverage	Areal coverage of transient species		\N
transpiration	Transpiration	Transpiration		\N
tributoxyethylPhosphate	Tributoxyethyl phosphate	Tributoxyethyl phosphate (C42H87O13P)		\N
trichloroethene	Trichloroethene	Trichloroethene (C2HCl3)		\N
triethyleneGlycol	Triethylene glycol	Triethylene glycol (C6H14O4)		\N
trifluralin	Trifluralin	Trifluralin (C13H16F3N3O4)		\N
triphenylene	Triphenylene	Triphenylene (C18H12)		\N
tritium_3H_DeltaTOfH2O	Tritium (3H), Delta T of H2O	Isotope 3H of water		\N
TSI	TSI	Carlson Trophic State Index is a measurement of eutrophication based on Secchi depth		\N
turbidity	Turbidity	Turbidity		\N
yttrium	Yttrium	Yttrium is a chemical element with symbol Y and atomic number 39. It is a silvery-metallic transition metal chemically similar to the lanthanides and has often been classified as a "rare-earth element".		\N
yttriumDissolved	Yttrium, dissolved	Dissolved Yttrium (Y). "Dissolved " indicates a the measurement was made on a filtered sample.		\N
ultravioletRadiationIndex	Ultraviolet Radation Index	The global solar UV index (UVI) was developed as an easy-to-understand measure of biologically effective UV radiation with a view to promote public awareness of the risks of UV radiation exposure and sun protection. In the initial work done on UVI in Canada, a typical midday summer erythemal irradiance of 250 mW.m-2 was found leading to the (arbitrary) definition of one UV index equal to an erythemally weighted irradiance of 25 mW.m-2. This gives a typical range of UVI 0 to 11+.	Biota	\N
ultravioletRadiationDose	Ultraviolet Radiation Dose	A measure of the ability of ultraviolet radiation, as a function of wavelength, to produce just perceptible erythema in human skin.	Biota	\N
uranium	Uranium	Uranium (U)		\N
uraniumDissolved	Uranium, dissolved	Dissolved Uranium. For chemical terms, dissolved indicates a filtered sample.		\N
uranium_234	Uranium-234	An isotope of uranium in the uranium-238 decay series		\N
uranium_235	Uranium-235	An isotope of uranium that can sustain fission chain reaction		\N
uranium_238	Uranium-238	Uranium's most common isotope		\N
urea	Urea	Urea ((NH2)2CO)		\N
ureaFlux	Urea flux	Urea ((NH2)2CO) flux		\N
vanadiumDissolved	Vanadium, dissolved	Dissolved vanadium (V). "Dissolved" indicates the measurement was made on a filtered sample.		\N
vanadiumParticulate	Vanadium, particulate	Particulate vanadium (V) in suspension		\N
vanadiumTotal	Vanadium, total	Total vanadium (V). "Total" indicates was measured on a whole water (unfiltered) sample.		\N
vaporPressure	Vapor pressure	The pressure of a vapor in equilibrium with its non-vapor phases		\N
vaporPressureDeficit	Vapor pressure deficit	The difference between the actual water vapor pressure and the saturation of water vapor pressure at a particular temperature.		\N
vegetationType	Vegetation type	Vegetation is an assemblage of plant species and the ground cover they provide.		\N
velocity	Velocity	The velocity of a substance, fluid or object		\N
vermiculite	Vermiculite	Vermiculite is a hydrous phyllosilicate mineral. It undergoes significant expansion when heated. Exfoliation occurs when the mineral is heated sufficiently, and the effect is routinely produced in commercial furnaces.		\N
visibility	Visibility	Visibility		\N
voltage	Voltage	Voltage or Electrical Potential		\N
volume	Volume	Volume. To quantify discharge or hydrograph volume or some other volume measurement.		\N
volumetricWaterContent	Volumetric water content	Volume of liquid water relative to bulk volume. Used for example to quantify soil moisture		\N
watchdogErrorCount	Watchdog error count	A counter which counts the number of total datalogger watchdog errors		\N
waterColumnEquivalentHeightAbsolute	Water column equivalent height, absolute	The absolute pressure (combined water + barometric) on a sensor expressed as the height of an equivalent column of water.		\N
waterColumnEquivalentHeightBarometric	Water column equivalent height, barometric	Barometric pressure expressed as an equivalent height of water over the sensor.		\N
waterContent	Water Content	Quantity of water contained in a material or organism		\N
waterDepth	Water depth	Water depth is the distance between the water surface and the bottom of the water body at a specific location specified by the site location and offset.		\N
waterDepthAveraged	Water depth, averaged	Water depth averaged over a channel cross-section or water body.  Averaging method to be specified in methods.		\N
waterFlux	Water flux	Water Flux		\N
waterLevel	Water level	Water level relative to datum. The datum may be local or global such as NGVD 1929 and should be specified in the method description for associated data values.		\N
waterPotential	Water potential	Water potential is the potential energy of water relative to pure free water (e.g. deionized water) in reference conditions. It quantifies the tendency of water to move from one area to another due to osmosis, gravity, mechanical pressure, or matrix effects including surface tension.		\N
waterUseAgriculture	Water Use, Agriculture	Water pumped for Agriculture		\N
waterUseCommercialIndustrialPower	Water Use, Commercial + Industrial + Power	Water pumped by commercial, industrial users.		\N
waterUseDomesticWells	Water Use, Domestic wells	Water pumped by domestic wells; residents and landowners not using public supply. Nonagriculture wells.		\N
waterUsePublicSupply	Water Use, Public Supply	Water supplied by a public utility		\N
waterUseRecreation	Water Use, Recreation	Recreational water use, for example golf courses.		\N
waterVaporConcentration	Water vapor concentration	Water vapor concentration		\N
waterVaporDensity	Water vapor density	Water vapor density		\N
waveHeight	Wave height	The height of a surface wave, measured as the difference in elevation between the wave crest and an adjacent trough.		\N
weatherConditions	Weather conditions	Weather conditions		\N
wellFlowRate	Well flow rate	Flow rate from well while pumping		\N
wellheadPressure	Wellhead pressure	The pressure exerted by the fluid at the wellhead or casinghead after the well has been shut off for a period of time, typically 24 hours		\N
windChill	Wind chill	The effect of wind on the temperature felt on human skin.		\N
windDirection	Wind direction	Wind direction		\N
windGustDirection	Wind gust direction	Direction of gusts of wind		\N
windGustSpeed	Wind gust speed	Speed of gusts of wind		\N
windRun	Wind Run	The length of flow of air past a point over a time interval. Windspeed times the interval of time.		\N
windSpeed	Wind speed	Wind speed		\N
windStress	Wind stress	Drag or trangential force per unit area exerted on a surface by the adjacent layer of moving air		\N
wrackCoverage	Wrack coverage	Areal coverage of dead vegetation		\N
xylenesTotal	Xylenes, total	Total xylenes: C6H4(CH3)2		\N
xylosidase	Xylosidase	An enzyme with system name 4-beta-D-xylan xylohydrolase.[1][2] This enzyme catalyses the following chemical reaction: Hydrolysis of (1->4)-beta-D-xylans, to remove successive D-xylose residues from the non-reducing termini.	Chemistry	\N
ytterbium	Ytterbium	Ytterbium is a chemical element with symbol Yb and atomic number 70. It is the fourteenth and penultimate element in the lanthanide series, which is the basis of the relative stability of its +2 oxidation state.		\N
ytterbiumDissolved	Ytterbium, dissolved	Dissolved Ytterbium (Yb). "Dissolved " indicates a the measurement was made on a filtered sample.		\N
zeaxanthin	Zeaxanthin	The phytoplankton pigment Zeaxanthin		\N
zinc	Zinc	Zinc is a chemical element with symbol Zn and atomic number 30. It is the first element in group 12 of the periodic table. In some respects zinc is chemically similar to magnesium: both elements exhibit only one normal oxidation state (+2), and the Zn2+ and Mg2+ ions are of similar size. Zinc is the 24th most abundant element in Earth's crust and has five stable isotopes. The most common zinc ore is sphalerite (zinc blende), a zinc sulfide mineral. The largest workable lodes are in Australia, Asia, and the United States. Zinc is refined by froth flotation of the ore, roasting, and final extraction using electricity (electrowinning).		\N
zincDissolved	Zinc, dissolved	Dissolved Zinc (Zn)		\N
zincDistributionCoefficient	Zinc, distribution coefficient	Ratio of concentrations of zinc in two phases in equilibrium with each other. Phases must be specified.		\N
zincParticulate	Zinc, particulate	Particulate zinc (Zn) in suspension		\N
zincTotal	Zinc, total	Total zinc (Zn)."Total" indicates was measured on a whole water (unfiltered) sample.		\N
zirconDissolved	Zircon, dissolved	Dissolved Zircon (Zr)		\N
zirconium	Zirconium	Zirconium is a chemical element with symbol Zr and atomic number 40. The name zirconium is taken from the name of the mineral zircon, the most important source of zirconium.		\N
zirconiumDissolved	Zirconium, dissolved	Dissolved Zirconium		\N
zirconium_95	Zirconium-95	A radioactive isotope of zirconium with a half-life of 63 days		\N
zooplankton	Zooplankton	Zooplanktonic organisms, non-specific		\N
Raw data produced by Liquid Chromatography coupled to Quadrupole Time of Flight instrument	LC_QTOF_Raw	Raw data produced by Liquid Chromatography coupled to Quadrupole Time of Flight instrument	Chemistry	\N
Data produced by Liquid Chromatography coupled to Quadrupole Time of Flight instrumentand converted to mzXML format	LC_QTOF_mzXML	Data produced by Liquid Chromatography coupled to Quadrupole Time of Flight instrument and converted to mzXML format	Chemistry	\N
Peaks detected by Liquid Chromatography coupled to Quadrupole Time of Flight instrument	LC_QTOF_Peaks	List of peaks and their properties to be further identified as chemicals	Chemistry	\N
Peaks and their fragments detected by Liquid Chromatography coupled to Quadrupole Time of Flight instrument	LC_QTOF_Peaks_and_Fragments	List of peaks, associated peaks and their properties to be further identified as chemicals	Chemistry	\N
Chemicals detected by Liquid Chromatography coupled to Quadrupole Time of Flight instrument	LC_QTOF_Chemicals	List of chemicals identified based on LC_QTOF_Peaks_and_Fragments	Chemistry	\N
lightBackScattering	BackScattering	Backscattering of light measured by ocean observing systems. Used as a proxy for the concentration of water column constituents such as phytoplankton and particulate carbon	oceanography	\N
reflectance	Reflectance	The reflectance of the surface of a material is its effectiveness in reflecting radiant energy. It is the fraction of incident electromagnetic power that is reflected at the boundary	physics	\N
napierianAbsorptionCoefficient	Napierian, absorption coefficient	Napierian absorption coefficient measured at 443 nm in 	\N	\N
\.


--
-- Data for Name: cv_variabletype; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.cv_variabletype (term, name, definition, category, sourcevocabularyuri) FROM stdin;
age	Age	Variables associated with age		\N
Biota	Biota	Variables associated with biological organisms		\N
Chemistry	Chemistry	Variables associated with chemistry, chemical analysis or processes		\N
Climate	Climate	Variables associated with the climate, weather, or atmospheric processes		\N
endMember	End-Member	Variables associated with end members		\N
Geology	Geology	Variables associated with geology or geological processes		\N
Hydrology	Hydrology	Variables associated with hydrologic variables or processes		\N
Instrumentation	Instrumentation	Variables associated with instrumentation and instrument properties such as battery voltages, data logger temperatures, often useful for diagnosis.		\N
majorOxideElement	Major oxide or element	Variables associated with major oxides or elements		\N
modelData	Model data	Variables associated with modeled data		\N
nobleGas	Noble gas	Variables associated with noble gasses		\N
radiogenicIsotopes	Radiogenic isotopes	Variables associated with radiogenic isotopes		\N
rareEarthElement	Rare earth element	Variables associated with rare earth elements		\N
ratio	Ratio	Variables associated with a ratio		\N
rockMode	Rock mode	Variables associated with a rock mode		\N
Soil	Soil	Variables associated with soil variables or processes		\N
speciationRatio	Speciation ratio	Variables associated with a speciation ratio		\N
stableIsotopes	Stable isotopes	Variables associated with stable isotopes		\N
traceElement	Trace element	Variables associated with trace elements		\N
Unknown	Unknown	The VariableType is unknown.		\N
uraniumSeries	Uranium series	Variables associated with uranium series		\N
volatile	Volatile	Variables associated with volatile chemicals		\N
WaterQuality	Water quality	Variables associated with water quality variables or processes		\N
oceanography	Oceanography	Variables associated with oceanography or ocean monitoring		\N
physics	Physics	Variables associated with physical quantity.		\N
\.


--
-- Data for Name: dataloggerfilecolumns; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.dataloggerfilecolumns (dataloggerfilecolumnid, resultid, dataloggerfileid, instrumentoutputvariableid, columnlabel, columndescription, measurementequation, scaninterval, scanintervalunitsid, recordinginterval, recordingintervalunitsid, aggregationstatisticcv) FROM stdin;
\.


--
-- Data for Name: dataloggerfiles; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.dataloggerfiles (dataloggerfileid, programid, dataloggerfilename, dataloggerfiledescription, dataloggerfilelink) FROM stdin;
\.


--
-- Data for Name: dataloggerprogramfiles; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.dataloggerprogramfiles (programid, affiliationid, programname, programdescription, programversion, programfilelink) FROM stdin;
\.


--
-- Data for Name: dataquality; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.dataquality (dataqualityid, dataqualitytypecv, dataqualitycode, dataqualityvalue, dataqualityvalueunitsid, dataqualitydescription, dataqualitylink) FROM stdin;
1	Accuracy	frozen_test	\N	\N	Five (or more) identical consecutive measurements indicates that sensor is mal-functioning (frozen).	\N
2	Accuracy	snowdepth_variability_test	\N	\N	Measurements of snow depth which show high variability of depth gradientover time are inaccurate.	\N
3	Accuracy	range_test	\N	\N	Values outside configurable range are labelled as bad.	\N
4	Accuracy	spike_test	\N	\N	Temporary extreme increase in value is labelled as bad.	\N
\.


--
-- Data for Name: datasetcitations; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.datasetcitations (bridgeid, datasetid, relationshiptypecv, citationid) FROM stdin;
\.


--
-- Data for Name: datasets; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.datasets (datasetid, datasetuuid, datasettypecv, datasetcode, datasettitle, datasetabstract) FROM stdin;
\.


--
-- Data for Name: datasetsresults; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.datasetsresults (bridgeid, datasetid, resultid) FROM stdin;
\.


--
-- Data for Name: derivationequations; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.derivationequations (derivationequationid, derivationequation) FROM stdin;
\.


--
-- Data for Name: directives; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.directives (directiveid, directivetypecv, directivedescription, directivename, onumbers) FROM stdin;
1	Project	This project is used for testing software	mass_spec:test_project	\N
2	Project	non target screening requested by miljødirektoratet	mass_spec:md_screening_2020	\N
3	Project	non target screening within 1000lakes project	mass_spec:1000lakes_2020	\N
4	Project	Non target analysis of chinese drinking water data	mass_spec:ARMOUR_china_test	\N
5	Project	Non target analysis ran by NILU researchers	mass_spec:Processing_at_NILU	\N
6	Project	Non-target processing of mass spectrometer raw files from external partners.	mass_spec:EuSeMe	\N
\.


--
-- Data for Name: equipment; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.equipment (equipmentid, equipmentcode, equipmentname, equipmenttypecv, equipmentmodelid, equipmentserialnumber, equipmentownerid, equipmentvendorid, equipmentpurchasedate, equipmentpurchaseordernumber, equipmentdescription, equipmentdocumentationlink) FROM stdin;
\.


--
-- Data for Name: equipmentannotations; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.equipmentannotations (bridgeid, equipmentid, annotationid) FROM stdin;
\.


--
-- Data for Name: equipmentmodels; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.equipmentmodels (equipmentmodelid, modelmanufacturerid, modelpartnumber, modelname, modeldescription, isinstrument, modelspecificationsfilelink, modellink) FROM stdin;
\.


--
-- Data for Name: equipmentused; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.equipmentused (bridgeid, actionid, equipmentid) FROM stdin;
\.


--
-- Data for Name: extensionproperties; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.extensionproperties (propertyid, propertyname, propertydescription, propertydatatypecv, propertyunitsid) FROM stdin;
\.


--
-- Data for Name: externalidentifiersystems; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.externalidentifiersystems (externalidentifiersystemid, externalidentifiersystemname, identifiersystemorganizationid, externalidentifiersystemdescription, externalidentifiersystemurl) FROM stdin;
1	onprem-active-directory	1	reference to old 3-letter active directory usernames (SamAccountName)	
2	nivabasen	1	Reference to legacy NIVAbasen oracle database.	
\.


--
-- Data for Name: featureactions; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.featureactions (featureactionid, samplingfeatureid, actionid) FROM stdin;
1	2	1
2	2	2
3	2	3
4	2	4
5	2	5
6	2	6
7	2	7
8	2	8
9	2	9
10	2	10
11	2	11
12	4	12
13	4	13
14	4	14
15	4	15
16	4	16
17	4	17
18	4	18
19	4	19
20	4	20
21	3	21
22	3	22
23	3	23
24	3	24
25	3	25
26	3	26
27	5	27
28	5	28
29	5	29
30	5	30
31	5	31
32	5	32
33	5	33
34	5	34
35	5	35
36	5	36
37	5	37
38	5	38
39	6	39
40	6	40
41	6	41
42	6	42
43	6	43
44	6	44
45	6	45
46	6	46
47	6	47
48	6	48
49	6	49
50	6	50
51	7	51
52	7	52
53	7	53
54	7	54
55	7	55
56	7	56
57	7	57
58	7	58
59	9	59
60	9	60
61	9	61
62	9	62
63	9	63
64	8	64
65	8	65
66	8	66
67	8	67
68	8	68
69	8	69
70	10	70
71	10	71
72	10	72
73	10	73
74	10	74
75	10	75
76	10	76
77	10	77
78	11	78
79	11	79
80	11	80
81	11	81
82	11	82
83	11	83
84	11	84
85	11	85
86	12	86
87	12	87
88	12	88
89	12	89
90	12	90
91	12	91
92	12	92
93	13	93
94	13	94
95	13	95
96	13	96
97	13	97
98	13	98
99	13	99
100	13	100
101	14	101
102	14	102
103	14	103
104	14	104
105	14	105
106	14	106
107	14	107
108	14	108
109	19	109
110	19	110
111	19	111
112	19	112
113	19	113
114	19	114
115	19	115
116	19	116
117	19	117
118	19	118
119	19	119
120	19	120
121	20	121
122	20	122
123	20	123
124	20	124
125	20	125
126	20	126
127	20	127
128	20	128
129	15	129
130	15	130
131	15	131
132	16	132
133	16	133
134	15	134
\.


--
-- Data for Name: instrumentoutputvariables; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.instrumentoutputvariables (instrumentoutputvariableid, modelid, variableid, instrumentmethodid, instrumentresolution, instrumentaccuracy, instrumentrawoutputunitsid) FROM stdin;
\.


--
-- Data for Name: kafka_records; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.kafka_records (topic, key, payload) FROM stdin;
\.


--
-- Data for Name: maintenanceactions; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.maintenanceactions (actionid, isfactoryservice, maintenancecode, maintenancereason) FROM stdin;
\.


--
-- Data for Name: measurementresults; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.measurementresults (resultid, xlocation, xlocationunitsid, ylocation, ylocationunitsid, zlocation, zlocationunitsid, spatialreferenceid, censorcodecv, qualitycodecv, aggregationstatisticcv, timeaggregationinterval, timeaggregationintervalunitsid) FROM stdin;
\.


--
-- Data for Name: measurementresultvalueannotations; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.measurementresultvalueannotations (bridgeid, valueid, annotationid) FROM stdin;
\.


--
-- Data for Name: measurementresultvalues; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.measurementresultvalues (valueid, resultid, datavalue, valuedatetime, valuedatetimeutcoffset) FROM stdin;
\.


--
-- Data for Name: methodannotations; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.methodannotations (bridgeid, methodid, annotationid) FROM stdin;
1	8	1
2	9	2
3	14	3
4	15	4
5	16	5
6	17	6
7	18	7
8	19	8
9	20	9
10	21	10
11	22	11
12	23	12
13	24	13
14	25	14
15	26	15
16	27	16
17	28	17
18	29	18
19	30	19
20	31	20
21	32	21
22	33	22
\.


--
-- Data for Name: methodcitations; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.methodcitations (bridgeid, methodid, relationshiptypecv, citationid) FROM stdin;
\.


--
-- Data for Name: methodextensionpropertyvalues; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.methodextensionpropertyvalues (bridgeid, methodid, propertyid, propertyvalue) FROM stdin;
\.


--
-- Data for Name: methodexternalidentifiers; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.methodexternalidentifiers (bridgeid, methodid, externalidentifiersystemid, methodexternalidentifier, methodexternalidentifieruri) FROM stdin;
\.


--
-- Data for Name: methods; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.methods (methodid, methodtypecv, methodcode, methodname, methoddescription, methodlink, organizationid) FROM stdin;
1	Instrument deployment	000	Deploy an Instrument	A method for deploying instruments	\N	1
2	Derivation	001	Derive an adjusted result from a raw result	A method for deriving a result from another result	\N	1
3	Specimen analysis	SpectralAnaCdom	Spectral analysis Cdom	Measure water sample with photo spectrometer and derive cdom related properties.	\N	1
4	Specimen collection	collect_sample	sample collection	Collected water sample in a filed at a given station.	\N	1
5	Specimen collection	mass_spec:collect_sample	collect_sample	Collecting sample in the field	\N	1
6	Specimen fractionation	mass_spec:fractionate_sample	fractionate_sample	Create a set of sub-samples	\N	1
7	Specimen analysis	mass_spec:create_data	ms run	Running mass spectrometer	\N	1
8	Derivation	mass_spec:ms_convert_filter_scanEvent_1_2	ms convert		\N	1
9	Derivation	mass_spec:ms_convert	ms convert		\N	1
10	Derivation	mass_spec:filter_blanks	blank filter	Remove from peak list peaks which replicate in blank sample replicas.	\N	1
11	Derivation	mass_spec:filter_replicas	replica filter	Remove from peak list peaks which do not replicas in all replicas of the parent sample.	\N	1
12	Derivation	mass_spec:filter_replicas_and_blanks	replica and blank filter	Remove from peak list peaks which do not replicas in all replicas of the parent sample. Subsequently remove from peak list peaks which do not replicas in all replicas of the parent sample.	\N	1
13	Derivation	mass_spec:combine_features	feature combination	After feature deconvolution has completed for multiple replicas, a list of peaks is output for each replica. These are combined into a single list of peaks, in which non-replicating peaks are removed and replicating peaks are averaged. This is the input peak list for feature identification.	\N	1
14	Derivation	mass_spec:fd_s3D	feature detection	Detects features in raw data. This is method is a sudo 3D methodwhere 1 gaussian is fit in each direction.	\N	1
15	Derivation	mass_spec:fd_s3D_test	feature detection	Detects features in raw data. This is method is a sudo 3D methodwhere 1 gaussian is fit in each direction.	\N	1
16	Derivation	mass_spec:fd_0.5.22	feature detection	Detects features in raw data. This is method is a sudo 3D methodwhere 1 gaussian is fit in each direction.	\N	1
17	Derivation	mass_spec:fd_0.5.22_int4000	feature detection	Detects features in raw data. This is method is a sudo 3D methodwhere 1 gaussian is fit in each direction.	\N	1
18	Derivation	mass_spec:fd_0.5.22_orbi_int1E5	feature detection	Detects features in raw data. This is method is a sudo 3D methodwhere 1 gaussian is fit in each direction.	\N	1
19	Derivation	mass_spec:fd_0.5.22_orbi_int1E5_10k	feature detection	Detects features in raw data. This is method is a sudo 3D methodwhere 1 gaussian is fit in each direction.	\N	1
20	Derivation	mass_spec:fd_0.5.22_orbi_int1E5_test	feature detection	Detects features in raw data. This is method is a sudo 3D methodwhere 1 gaussian is fit in each direction.	\N	1
21	Derivation	mass_spec:fd_0.5.22_orbitrap	feature detection	Detects features in raw data. This is method is a sudo 3D methodwhere 1 gaussian is fit in each direction.	\N	1
22	Derivation	mass_spec:fd_0.5.22_test	feature detection	Detects features in raw data. This is method is a sudo 3D methodwhere 1 gaussian is fit in each direction.	\N	1
23	Derivation	mass_spec:fdc_comp_DIA	feature deconvolution	Find fragments for peaks detected with fd_* method.Upgraded version of fdc which considers adducts.	\N	1
24	Derivation	mass_spec:fdc_0.8.30	feature deconvolution	Find fragments for peaks detected with fd_* method.Upgraded version of fdc which considers adducts.	\N	1
25	Derivation	mass_spec:fdc_0.9.5	feature deconvolution	Find fragments for peaks detected with fd_* method.Upgraded version of fdc which considers adducts.	\N	1
26	Derivation	mass_spec:fdc_0.9.5_orbi	feature deconvolution	Find fragments for peaks detected with fd_* method.Upgraded version of fdc which considers adducts.	\N	1
27	Derivation	mass_spec:fdc_0.9.5_orbi_int1E5	feature deconvolution	Find fragments for peaks detected with fd_* method.Upgraded version of fdc which considers adducts.	\N	1
28	Derivation	mass_spec:fid_ulsa	feature identification	Identifies features previously detected using a fd_* and fdc methods. 	\N	1
29	Derivation	mass_spec:fid_0.4.7	feature identification	Identifies features previously detected using a fd_* and fdc methods. 	\N	1
30	Derivation	mass_spec:fid_0.4.9	feature identification	Identifies features previously detected using a fd_* and fdc methods. 	\N	1
31	Derivation	mass_spec:fid_0.4.5	feature identification	Identifies features previously detected using a fd_* and fdc methods. 	\N	1
32	Derivation	mass_spec:fid_0.5.8	feature identification	Identifies features previously detected using a fd_* and fdc methods. 	\N	1
33	Derivation	mass_spec:fid_0.5.10	feature identification	Identifies features previously detected using a fd_* and fdc methods. 	\N	1
34	Observation	fish_rfid:register_fish	Registering of tagged fishes	Fishes are caught, tagged with RFID chips and then released to be tracked by oregon RFID sensors	https://github.com/NIVANorge/fish_rfid/blob/master/docs/methods/register_fish.md	1
35	Observation	fish_rfid:observe_fish	Fish observed by rfid-sensor at station	Tagged fish detected near a oregon RFID sensor	https://github.com/NIVANorge/fish_rfid/blob/master/docs/methods/observe_fish.md	1
\.


--
-- Data for Name: modelaffiliations; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.modelaffiliations (bridgeid, modelid, affiliationid, isprimary, roledescription) FROM stdin;
\.


--
-- Data for Name: models; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.models (modelid, modelcode, modelname, modeldescription, version, modellink) FROM stdin;
\.


--
-- Data for Name: organizations; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.organizations (organizationid, organizationtypecv, organizationcode, organizationname, organizationdescription, organizationlink, parentorganizationid) FROM stdin;
1	Research institute	niva-no	Norsk institutt for vannforskning	Norwegian institute for water research	www.niva.no	\N
2	Research institute	niva-akvaplan	Akvaplan-niva	Daughter company of the Norwegian Institute for Water Research (NIVA)	www.akvaplan.niva.no	\N
\.


--
-- Data for Name: people; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.people (personid, personfirstname, personmiddlename, personlastname) FROM stdin;
1	Uknown person	\N	NIVA
\.


--
-- Data for Name: personexternalidentifiers; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.personexternalidentifiers (bridgeid, personid, externalidentifiersystemid, personexternalidentifier, personexternalidentifieruri) FROM stdin;
\.


--
-- Data for Name: pointcoverageresults; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.pointcoverageresults (resultid, zlocation, zlocationunitsid, spatialreferenceid, intendedxspacing, intendedxspacingunitsid, intendedyspacing, intendedyspacingunitsid, aggregationstatisticcv, timeaggregationinterval, timeaggregationintervalunitsid) FROM stdin;
\.


--
-- Data for Name: pointcoverageresultvalueannotations; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.pointcoverageresultvalueannotations (bridgeid, valueid, annotationid) FROM stdin;
\.


--
-- Data for Name: pointcoverageresultvalues; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.pointcoverageresultvalues (valueid, resultid, datavalue, valuedatetime, valuedatetimeutcoffset, xlocation, xlocationunitsid, ylocation, ylocationunitsid, censorcodecv, qualitycodecv) FROM stdin;
\.


--
-- Data for Name: processinglevels; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.processinglevels (processinglevelid, processinglevelcode, definition, explanation) FROM stdin;
1	0	Raw Data	Raw data is defined as unprocessed data and data products that have not undergone quality control. Depending on the data type and data transmission system, raw data may be available within seconds or minutes after real-time. Examples include real time precipitation, streamflow and water quality measurements.
2	0.05	Automated QC	Automated procedures have been applied as an initial quality control. These procedures leave the data as is but flag obviously erroneous values using a qualitycode
3	0.1	First Pass QC	A first quality control pass has been performed to remove out of range and obviously erroneous values. These values are either deleted from the record, or, for short durations, values are interpolated.
4	0.2	Second Pass QC	A second quality control pass has been performed to adjust values for instrument drift. Drift corrections are performed using a linear drift correction algorithm and field notes designating when sensor cleaning and calibration occurred.
5	1	Quality Controlled Data	Quality controlled data have passed quality assurance procedures such as routine estimation of timing and sensor calibration or visual inspection and removal of obvious errors. An example is USGS published streamflow records following parsing through USGS quality control procedures.
6	2	Derived Products	Derived products require scientific and technical interpretation and include multiple-sensor data. An example might be basin average precipitation derived from rain gages using an interpolation procedure.
7	3	Interpreted Products	These products require researcher (PI) driven analysis and interpretation, model-based interpretation using other data and/or strong prior assumptions. An example is basin average precipitation derived from the combination of rain gages and radar return data.
8	4	Knowledge Products	These products require researcher (PI) driven scientific interpretation and multidisciplinary data integration and include model-based interpretation using other data and/or strong prior assumptions. An example is percentages of old or new water in a hydrograph inferred from an isotope analysis.
\.


--
-- Data for Name: profileresults; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.profileresults (resultid, xlocation, xlocationunitsid, ylocation, ylocationunitsid, spatialreferenceid, intendedzspacing, intendedzspacingunitsid, intendedtimespacing, intendedtimespacingunitsid, aggregationstatisticcv) FROM stdin;
\.


--
-- Data for Name: profileresultvalueannotations; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.profileresultvalueannotations (bridgeid, valueid, annotationid) FROM stdin;
\.


--
-- Data for Name: profileresultvalues; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.profileresultvalues (valueid, resultid, datavalue, valuedatetime, valuedatetimeutcoffset, zlocation, zaggregationinterval, zlocationunitsid, censorcodecv, qualitycodecv, timeaggregationinterval, timeaggregationintervalunitsid) FROM stdin;
\.


--
-- Data for Name: projectexternalidentifiers; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.projectexternalidentifiers (bridgeid, projectid, externalidentifiersystemid, projectexternalidentifier, projectexternalidentifieruri) FROM stdin;
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.projects (projectid, projectname, projectdescription, projectnumbers) FROM stdin;
\.


--
-- Data for Name: projectstationexternalidentifiers; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.projectstationexternalidentifiers (bridgeid, projectstationid, externalidentifiersystemid, projectstationexternalidentifier, projectstationexternalidentifieruri) FROM stdin;
\.


--
-- Data for Name: projectstations; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.projectstations (projectstationid, projectstationcode, projectstationname, projectid, samplingfeatureid) FROM stdin;
\.


--
-- Data for Name: referencematerialexternalidentifiers; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.referencematerialexternalidentifiers (bridgeid, referencematerialid, externalidentifiersystemid, referencematerialexternalidentifier, referencematerialexternalidentifieruri) FROM stdin;
\.


--
-- Data for Name: referencematerials; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.referencematerials (referencematerialid, referencematerialmediumcv, referencematerialorganizationid, referencematerialcode, referencemateriallotcode, referencematerialpurchasedate, referencematerialexpirationdate, referencematerialcertificatelink, samplingfeatureid) FROM stdin;
\.


--
-- Data for Name: referencematerialvalues; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.referencematerialvalues (referencematerialvalueid, referencematerialid, referencematerialvalue, referencematerialaccuracy, variableid, unitsid, citationid) FROM stdin;
\.


--
-- Data for Name: relatedactions; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.relatedactions (relationid, actionid, relationshiptypecv, relatedactionid) FROM stdin;
\.


--
-- Data for Name: relatedannotations; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.relatedannotations (relationid, annotationid, relationshiptypecv, relatedannotationid) FROM stdin;
\.


--
-- Data for Name: relatedcitations; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.relatedcitations (relationid, citationid, relationshiptypecv, relatedcitationid) FROM stdin;
\.


--
-- Data for Name: relateddatasets; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.relateddatasets (relationid, datasetid, relationshiptypecv, relateddatasetid, versioncode) FROM stdin;
\.


--
-- Data for Name: relatedequipment; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.relatedequipment (relationid, equipmentid, relationshiptypecv, relatedequipmentid, relationshipstartdatetime, relationshipstartdatetimeutcoffset, relationshipenddatetime, relationshipenddatetimeutcoffset) FROM stdin;
\.


--
-- Data for Name: relatedfeatures; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.relatedfeatures (relationid, samplingfeatureid, relationshiptypecv, relatedfeatureid, spatialoffsetid) FROM stdin;
\.


--
-- Data for Name: relatedmodels; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.relatedmodels (relatedid, modelid, relationshiptypecv, relatedmodelid) FROM stdin;
\.


--
-- Data for Name: relatedresults; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.relatedresults (relationid, resultid, relationshiptypecv, relatedresultid, versioncode, relatedresultsequencenumber) FROM stdin;
\.


--
-- Data for Name: relatedtaxonomicclassifiers; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.relatedtaxonomicclassifiers (relationid, taxonomicclassifierid, relationshiptypecv, relatedtaxonomicclassifierid) FROM stdin;
\.


--
-- Data for Name: resultannotations; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.resultannotations (bridgeid, resultid, annotationid, begindatetime, enddatetime) FROM stdin;
\.


--
-- Data for Name: resultderivationequations; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.resultderivationequations (resultid, derivationequationid) FROM stdin;
\.


--
-- Data for Name: resultextensionpropertyvalues; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.resultextensionpropertyvalues (bridgeid, resultid, propertyid, propertyvalue) FROM stdin;
\.


--
-- Data for Name: resultnormalizationvalues; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.resultnormalizationvalues (resultid, normalizedbyreferencematerialvalueid) FROM stdin;
\.


--
-- Data for Name: results; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.results (resultid, resultuuid, featureactionid, resulttypecv, variableid, unitsid, taxonomicclassifierid, processinglevelid, resultdatetime, resultdatetimeutcoffset, validdatetime, validdatetimeutcoffset, statuscv, sampledmediumcv, valuecount) FROM stdin;
1	6c398ed4-c9fe-435a-89c6-f78b12fdb8c1	1	Time series coverage	17	20	\N	1	2023-01-31 18:25:28.187404	0	2023-01-31 18:25:28.187404	0	Complete	Liquid aqueous	0
2	d24a060b-c816-4a27-8b22-bd18cb4f3124	2	Time series coverage	18	20	\N	1	2023-01-31 18:25:28.194575	0	2023-01-31 18:25:28.194575	0	Complete	Liquid aqueous	0
3	86410b42-7329-426a-b206-1a26eecb8aab	3	Time series coverage	19	21	\N	1	2023-01-31 18:25:28.199179	0	2023-01-31 18:25:28.199179	0	Complete	Liquid aqueous	0
4	3bd920d7-4807-423f-b13f-dccf47f2a64b	4	Time series coverage	20	21	\N	1	2023-01-31 18:25:28.203667	0	2023-01-31 18:25:28.203667	0	Complete	Liquid aqueous	0
5	a883e0a9-a83a-4bb0-a4be-abe0a69af2b3	5	Time series coverage	21	21	\N	1	2023-01-31 18:25:28.208033	0	2023-01-31 18:25:28.208033	0	Complete	Liquid aqueous	0
6	6e8547b2-b9b0-426e-b2ef-5ecbd0d9d036	6	Time series coverage	22	21	\N	1	2023-01-31 18:25:28.212354	0	2023-01-31 18:25:28.212354	0	Complete	Liquid aqueous	0
7	ff023d3c-b02a-4f87-b889-c887a3feb55a	7	Time series coverage	23	21	\N	1	2023-01-31 18:25:28.216201	0	2023-01-31 18:25:28.216201	0	Complete	Liquid aqueous	0
8	48ada1e9-12a7-4a06-becf-8e2316ce846b	8	Time series coverage	24	21	\N	1	2023-01-31 18:25:28.219379	0	2023-01-31 18:25:28.219379	0	Complete	Liquid aqueous	0
9	892c8cc3-f401-4b84-92aa-734a0c8fa0f0	9	Time series coverage	25	21	\N	1	2023-01-31 18:25:28.222481	0	2023-01-31 18:25:28.222481	0	Complete	Liquid aqueous	0
10	44c40b90-5b6c-4f84-a0f1-f6b652eed26b	10	Time series coverage	26	21	\N	1	2023-01-31 18:25:28.225672	0	2023-01-31 18:25:28.225672	0	Complete	Liquid aqueous	0
11	c1270872-b0e8-4945-8bb4-8f2a1ef940e7	11	Time series coverage	51	22	\N	1	2023-01-31 18:25:28.228798	0	2023-01-31 18:25:28.228798	0	Complete	Liquid aqueous	0
12	d1008617-390e-40a9-8ce0-b941dd270164	12	Time series coverage	51	22	\N	1	2023-01-31 18:25:28.231946	0	2023-01-31 18:25:28.231946	0	Complete	Liquid aqueous	0
13	94739165-98f8-4a8a-942e-7ba71bc2a496	13	Time series coverage	28	23	\N	1	2023-01-31 18:25:28.235165	0	2023-01-31 18:25:28.235165	0	Complete	Liquid aqueous	0
14	5e34a638-c514-4a2f-a53d-ac8d85717415	14	Time series coverage	27	24	\N	1	2023-01-31 18:25:28.238289	0	2023-01-31 18:25:28.238289	0	Complete	Liquid aqueous	0
15	0b92148d-adce-45cf-9939-9af9debe355d	15	Time series coverage	29	30	\N	1	2023-01-31 18:25:28.241529	0	2023-01-31 18:25:28.241529	0	Complete	Liquid aqueous	0
16	2045241b-c45f-4727-b1be-a3ed4f079290	16	Time series coverage	30	25	\N	1	2023-01-31 18:25:28.244703	0	2023-01-31 18:25:28.244703	0	Complete	Liquid aqueous	0
17	4c40de09-a180-4999-b1db-1da795d4e10e	17	Time series coverage	32	17	\N	1	2023-01-31 18:25:28.247859	0	2023-01-31 18:25:28.247859	0	Complete	Liquid aqueous	0
18	b580d389-8d87-4d8e-8838-d2b0cbeb228e	18	Time series coverage	35	21	\N	1	2023-01-31 18:25:28.250985	0	2023-01-31 18:25:28.250985	0	Complete	Liquid aqueous	0
19	2c6c193b-025f-40ea-9d52-97d0d7518d51	19	Time series coverage	34	21	\N	1	2023-01-31 18:25:28.254093	0	2023-01-31 18:25:28.254093	0	Complete	Liquid aqueous	0
20	65cbca16-df61-46a1-9025-cca751a0f90e	20	Time series coverage	33	21	\N	1	2023-01-31 18:25:28.257181	0	2023-01-31 18:25:28.257181	0	Complete	Liquid aqueous	0
21	6ca36264-417d-4a1f-8ddf-395924020120	21	Time series coverage	51	22	\N	1	2023-01-31 18:25:28.260311	0	2023-01-31 18:25:28.260311	0	Complete	Liquid aqueous	0
22	f339196c-14bf-4245-9b32-6c6b0f129207	22	Time series coverage	28	23	\N	1	2023-01-31 18:25:28.263532	0	2023-01-31 18:25:28.263532	0	Complete	Liquid aqueous	0
23	486d7214-6811-406a-bf54-0024bb4aeedb	23	Time series coverage	30	25	\N	1	2023-01-31 18:25:28.266683	0	2023-01-31 18:25:28.266683	0	Complete	Liquid aqueous	0
24	6305a61d-bc8d-4f30-bd55-32f05aee829f	24	Time series coverage	34	21	\N	1	2023-01-31 18:25:28.26979	0	2023-01-31 18:25:28.26979	0	Complete	Liquid aqueous	0
25	0c22f265-ce63-4b52-9a5b-ba0f3df5b5da	25	Time series coverage	38	21	\N	1	2023-01-31 18:25:28.272867	0	2023-01-31 18:25:28.272867	0	Complete	Liquid aqueous	0
26	02fc920a-ee8b-41d9-978a-cb596308a055	26	Time series coverage	37	21	\N	1	2023-01-31 18:25:28.27593	0	2023-01-31 18:25:28.27593	0	Complete	Liquid aqueous	0
27	1c717d2b-0d39-491a-bd76-15325354b23a	27	Time series coverage	55	22	\N	1	2023-01-31 18:25:28.279134	0	2023-01-31 18:25:28.279134	0	Complete	Liquid aqueous	0
28	bda2bac6-26ed-4046-8ec8-13f9854a28cc	28	Time series coverage	30	25	\N	1	2023-01-31 18:25:28.282293	0	2023-01-31 18:25:28.282293	0	Complete	Liquid aqueous	0
29	675cff5f-2b09-40ed-91a3-c2daa39c62e8	29	Time series coverage	39	25	\N	1	2023-01-31 18:25:28.285357	0	2023-01-31 18:25:28.285357	0	Complete	Liquid aqueous	0
30	e0e53bc2-835b-42fb-a46c-ff279caaeea9	30	Time series coverage	40	28	\N	1	2023-01-31 18:25:28.288419	0	2023-01-31 18:25:28.288419	0	Complete	Liquid aqueous	0
31	834ce76c-71db-4411-9229-f3b168f0721c	31	Time series coverage	41	20	\N	1	2023-01-31 18:25:28.291482	0	2023-01-31 18:25:28.291482	0	Complete	Liquid aqueous	0
32	d81842d5-e1fb-4c53-9549-62d7bfa69f30	32	Time series coverage	42	21	\N	1	2023-01-31 18:25:28.294601	0	2023-01-31 18:25:28.294601	0	Complete	Liquid aqueous	0
33	bfc75a71-245c-444d-8bfe-c19bf78488e9	33	Time series coverage	43	25	\N	1	2023-01-31 18:25:28.297841	0	2023-01-31 18:25:28.297841	0	Complete	Liquid aqueous	0
34	d9ee7d3e-f1cb-4e9f-98a3-ca6a473cfd5b	34	Time series coverage	44	15	\N	1	2023-01-31 18:25:28.300974	0	2023-01-31 18:25:28.300974	0	Complete	Liquid aqueous	0
35	5a3e6e29-c647-4010-b62a-5f33cd3b26fc	35	Time series coverage	47	15	\N	1	2023-01-31 18:25:28.304076	0	2023-01-31 18:25:28.304076	0	Complete	Liquid aqueous	0
36	01dbc84c-00a0-4562-a883-1001c0b0a514	36	Time series coverage	48	29	\N	1	2023-01-31 18:25:28.307233	0	2023-01-31 18:25:28.307233	0	Complete	Liquid aqueous	0
37	4b6c503f-6ed2-4889-9169-f6ac693406b7	37	Time series coverage	49	25	\N	1	2023-01-31 18:25:28.310499	0	2023-01-31 18:25:28.310499	0	Complete	Liquid aqueous	0
38	92d58470-1bc0-44f8-b900-ed6e07a5e9cb	38	Time series coverage	50	25	\N	1	2023-01-31 18:25:28.313702	0	2023-01-31 18:25:28.313702	0	Complete	Liquid aqueous	0
39	5e1b22fc-6acb-4c9f-8b04-a2b037e63c9d	39	Time series coverage	51	22	\N	1	2023-01-31 18:25:28.318025	0	2023-01-31 18:25:28.318025	0	Complete	Liquid aqueous	0
40	00eea2c4-e91f-41a6-9311-07ab394cb170	40	Time series coverage	35	21	\N	1	2023-01-31 18:25:28.321275	0	2023-01-31 18:25:28.321275	0	Complete	Liquid aqueous	0
41	2232be17-861f-40b6-963f-d73a87e8c27d	41	Time series coverage	56	17	\N	1	2023-01-31 18:25:28.324355	0	2023-01-31 18:25:28.324355	0	Complete	Liquid aqueous	0
42	68d4cdb5-0aaa-4d06-9ab8-919ae6d9b385	42	Time series coverage	57	17	\N	1	2023-01-31 18:25:28.32754	0	2023-01-31 18:25:28.32754	0	Complete	Liquid aqueous	0
43	66afd2ec-589d-4f99-a4bf-842b13eb768e	43	Time series coverage	58	17	\N	1	2023-01-31 18:25:28.330687	0	2023-01-31 18:25:28.330687	0	Complete	Liquid aqueous	0
44	f653109a-b068-4b45-b95c-39bd8ce33433	44	Time series coverage	59	17	\N	1	2023-01-31 18:25:28.33446	0	2023-01-31 18:25:28.33446	0	Complete	Liquid aqueous	0
45	9d787080-4ed1-4d67-8484-1b2b615b2391	45	Time series coverage	29	30	\N	1	2023-01-31 18:25:28.337587	0	2023-01-31 18:25:28.337587	0	Complete	Liquid aqueous	0
46	4ec465be-7325-4f43-bbac-47ed8931866e	46	Time series coverage	60	21	\N	1	2023-01-31 18:25:28.340699	0	2023-01-31 18:25:28.340699	0	Complete	Liquid aqueous	0
47	318ccffc-7c5a-411e-a8fc-9c3f2c1a288d	47	Time series coverage	61	21	\N	1	2023-01-31 18:25:28.344223	0	2023-01-31 18:25:28.344223	0	Complete	Liquid aqueous	0
48	acacc2c2-8f84-418d-aa8d-69e1a11bebdc	48	Time series coverage	62	21	\N	1	2023-01-31 18:25:28.347425	0	2023-01-31 18:25:28.347425	0	Complete	Liquid aqueous	0
49	1a31d842-a9c1-4cd2-9ed2-de1cda090fe9	49	Time series coverage	32	17	\N	1	2023-01-31 18:25:28.350599	0	2023-01-31 18:25:28.350599	0	Complete	Liquid aqueous	0
50	b73e8665-b059-4145-8191-d7c21cf3540a	50	Time series coverage	30	25	\N	1	2023-01-31 18:25:28.353692	0	2023-01-31 18:25:28.353692	0	Complete	Liquid aqueous	0
51	d03c5d53-369a-437d-b4b3-9546cad5e73c	51	Time series coverage	64	17	\N	1	2023-01-31 18:25:28.356888	0	2023-01-31 18:25:28.356888	0	Complete	Liquid aqueous	0
52	1bfaa455-efd7-43ef-b586-f56d9aa8c00f	52	Time series coverage	68	21	\N	1	2023-01-31 18:25:28.360206	0	2023-01-31 18:25:28.360206	0	Complete	Liquid aqueous	0
53	1979cb00-6df3-4e3d-8b8c-8a0457b986ff	53	Time series coverage	63	30	\N	1	2023-01-31 18:25:28.363369	0	2023-01-31 18:25:28.363369	0	Complete	Liquid aqueous	0
54	b228ec57-fecb-4e26-9b24-3f232d6bf97e	54	Time series coverage	65	23	\N	1	2023-01-31 18:25:28.366477	0	2023-01-31 18:25:28.366477	0	Complete	Liquid aqueous	0
55	406b12de-1e2e-42c3-acf7-7abf99ab0a79	55	Time series coverage	66	23	\N	1	2023-01-31 18:25:28.369558	0	2023-01-31 18:25:28.369558	0	Complete	Liquid aqueous	0
56	c966fb80-65ba-4b3e-af4d-2b8e929c6c5d	56	Time series coverage	71	17	\N	1	2023-01-31 18:25:28.372774	0	2023-01-31 18:25:28.372774	0	Complete	Liquid aqueous	0
57	3a6b616d-c258-49c0-9820-68ee1d087b43	57	Time series coverage	67	22	\N	1	2023-01-31 18:25:28.375824	0	2023-01-31 18:25:28.375824	0	Complete	Liquid aqueous	0
58	23572c8e-3b60-4ed1-a048-0e5a50762731	58	Time series coverage	69	11	\N	1	2023-01-31 18:25:28.379173	0	2023-01-31 18:25:28.379173	0	Complete	Liquid aqueous	0
59	ddfef765-4f63-43b8-b900-0104f67eb9a8	59	Time series coverage	64	17	\N	1	2023-01-31 18:25:28.382293	0	2023-01-31 18:25:28.382293	0	Complete	Liquid aqueous	0
60	60845a1f-8c0d-4fb1-bd00-f2af28a1eb41	60	Time series coverage	68	21	\N	1	2023-01-31 18:25:28.385465	0	2023-01-31 18:25:28.385465	0	Complete	Liquid aqueous	0
61	ab44e9ad-f4ea-40a6-979e-ccac28e73092	61	Time series coverage	63	30	\N	1	2023-01-31 18:25:28.388526	0	2023-01-31 18:25:28.388526	0	Complete	Liquid aqueous	0
62	3847e036-99ad-4b4b-a584-5677a3329278	62	Time series coverage	69	11	\N	1	2023-01-31 18:25:28.391572	0	2023-01-31 18:25:28.391572	0	Complete	Liquid aqueous	0
63	db3eabb4-c2b7-4180-b554-cb24a42afbfd	63	Time series coverage	65	23	\N	1	2023-01-31 18:25:28.39466	0	2023-01-31 18:25:28.39466	0	Complete	Liquid aqueous	0
64	52e7e23c-5c18-42ed-bb1e-b7c4bcbad11e	64	Time series coverage	32	17	\N	1	2023-01-31 18:25:28.397732	0	2023-01-31 18:25:28.397732	0	Complete	Liquid aqueous	0
65	04e9936f-5bcc-4589-aaaa-63ea3b6692d7	65	Time series coverage	29	32	\N	1	2023-01-31 18:25:28.400829	0	2023-01-31 18:25:28.400829	0	Complete	Liquid aqueous	0
66	005d0a4c-4fc8-415e-ba81-81f28523aac3	66	Time series coverage	30	25	\N	1	2023-01-31 18:25:28.4041	0	2023-01-31 18:25:28.4041	0	Complete	Liquid aqueous	0
67	2e164a12-9a50-45c9-b001-abb6421ab169	67	Time series coverage	70	11	\N	1	2023-01-31 18:25:28.407274	0	2023-01-31 18:25:28.407274	0	Complete	Liquid aqueous	0
68	870b6f31-b156-4af4-aa42-210fcc8cf736	68	Time series coverage	34	21	\N	1	2023-01-31 18:25:28.410367	0	2023-01-31 18:25:28.410367	0	Complete	Liquid aqueous	0
69	b448db71-468a-4f03-84e4-7ae91d35906b	69	Time series coverage	51	22	\N	1	2023-01-31 18:25:28.413482	0	2023-01-31 18:25:28.413482	0	Complete	Liquid aqueous	0
70	dd2526bb-d464-484b-b26a-8088037595bd	70	Time series coverage	51	22	\N	1	2023-01-31 18:25:28.416602	0	2023-01-31 18:25:28.416602	0	Complete	Liquid aqueous	0
71	8d65556d-e810-4fbe-8177-6083d32d2fa2	71	Time series coverage	35	21	\N	1	2023-01-31 18:25:28.419938	0	2023-01-31 18:25:28.419938	0	Complete	Liquid aqueous	0
72	e0d11c34-a9f0-430e-b449-9adcdcd95f87	72	Time series coverage	65	23	\N	1	2023-01-31 18:25:28.423498	0	2023-01-31 18:25:28.423498	0	Complete	Liquid aqueous	0
73	fa364aad-efc4-48c1-bf6c-c326654cea93	73	Time series coverage	32	17	\N	1	2023-01-31 18:25:28.426723	0	2023-01-31 18:25:28.426723	0	Complete	Liquid aqueous	0
74	ad6d1ecc-a8c4-45d7-b6bb-5009e8c7f904	74	Time series coverage	61	21	\N	1	2023-01-31 18:25:28.429953	0	2023-01-31 18:25:28.429953	0	Complete	Liquid aqueous	0
75	917f569d-33dc-4c52-a254-6d46672587c2	75	Time series coverage	29	32	\N	1	2023-01-31 18:25:28.433233	0	2023-01-31 18:25:28.433233	0	Complete	Liquid aqueous	0
76	c6c6f0ec-92fe-4b8d-8047-271be1a36e5c	76	Time series coverage	72	18	\N	1	2023-01-31 18:25:28.436966	0	2023-01-31 18:25:28.436966	0	Complete	Liquid aqueous	0
77	47380874-76e1-42e6-af05-9dad0da43a8f	77	Time series coverage	70	11	\N	1	2023-01-31 18:25:28.440638	0	2023-01-31 18:25:28.440638	0	Complete	Liquid aqueous	0
78	d914608f-ce0a-465c-a900-93a888fd7c3f	78	Time series coverage	51	22	\N	1	2023-01-31 18:25:28.44434	0	2023-01-31 18:25:28.44434	0	Complete	Liquid aqueous	0
79	7ddb4a9e-e959-4a5e-a33b-f40b1da01083	79	Time series coverage	35	21	\N	1	2023-01-31 18:25:28.448101	0	2023-01-31 18:25:28.448101	0	Complete	Liquid aqueous	0
80	855ffc65-f015-4cd5-a89b-6ca1cd73db19	80	Time series coverage	65	23	\N	1	2023-01-31 18:25:28.4518	0	2023-01-31 18:25:28.4518	0	Complete	Liquid aqueous	0
81	1bd9b771-4074-4f28-b112-43c7d0f3f2e8	81	Time series coverage	32	17	\N	1	2023-01-31 18:25:28.455461	0	2023-01-31 18:25:28.455461	0	Complete	Liquid aqueous	0
82	3f2fca09-6f40-4954-aec0-3513d19e70de	82	Time series coverage	61	21	\N	1	2023-01-31 18:25:28.459229	0	2023-01-31 18:25:28.459229	0	Complete	Liquid aqueous	0
83	b5b7ee6e-503d-449c-bfdb-277c5fbc5929	83	Time series coverage	29	32	\N	1	2023-01-31 18:25:28.46257	0	2023-01-31 18:25:28.46257	0	Complete	Liquid aqueous	0
84	9ff2e719-c915-4295-abbd-30caeced26d0	84	Time series coverage	72	18	\N	1	2023-01-31 18:25:28.465823	0	2023-01-31 18:25:28.465823	0	Complete	Liquid aqueous	0
85	a4a5a4a3-6c98-4628-b778-7d5d2ddda651	85	Time series coverage	70	11	\N	1	2023-01-31 18:25:28.468975	0	2023-01-31 18:25:28.468975	0	Complete	Liquid aqueous	0
86	0303e481-d9ad-4889-a6ba-6605cb23cb7c	86	Time series coverage	55	22	\N	1	2023-01-31 18:25:28.472104	0	2023-01-31 18:25:28.472104	0	Complete	Liquid aqueous	0
87	3a167ac1-f669-4ec2-a978-3c38e94f3901	87	Time series coverage	40	28	\N	1	2023-01-31 18:25:28.475258	0	2023-01-31 18:25:28.475258	0	Complete	Liquid aqueous	0
88	9f779256-ecac-4ae1-8293-be58c4e817ab	88	Time series coverage	41	20	\N	1	2023-01-31 18:25:28.478596	0	2023-01-31 18:25:28.478596	0	Complete	Liquid aqueous	0
89	bc5cf621-6226-423a-8030-05d7e0ade96e	89	Time series coverage	42	21	\N	1	2023-01-31 18:25:28.481784	0	2023-01-31 18:25:28.481784	0	Complete	Liquid aqueous	0
90	bdf0752d-3ef6-4134-b928-723a7c107c01	90	Time series coverage	44	15	\N	1	2023-01-31 18:25:28.484933	0	2023-01-31 18:25:28.484933	0	Complete	Liquid aqueous	0
91	3d0a00aa-46ef-4f9f-a9bb-3e60b895ef19	91	Time series coverage	47	15	\N	1	2023-01-31 18:25:28.488066	0	2023-01-31 18:25:28.488066	0	Complete	Liquid aqueous	0
92	4b410cf2-a033-4d0c-8205-20f2b9e9b495	92	Time series coverage	48	29	\N	1	2023-01-31 18:25:28.491194	0	2023-01-31 18:25:28.491194	0	Complete	Liquid aqueous	0
93	0b7c562c-88ab-4b9d-b3c4-b49c20b6f7e2	93	Time series coverage	51	22	\N	1	2023-01-31 18:25:28.494522	0	2023-01-31 18:25:28.494522	0	Complete	Liquid aqueous	0
94	426de5e4-a000-4678-af2c-8aea0b9536bc	94	Time series coverage	35	21	\N	1	2023-01-31 18:25:28.497727	0	2023-01-31 18:25:28.497727	0	Complete	Liquid aqueous	0
95	dd2763e9-1850-418d-80a7-ce1116f8895e	95	Time series coverage	65	23	\N	1	2023-01-31 18:25:28.500832	0	2023-01-31 18:25:28.500832	0	Complete	Liquid aqueous	0
96	13e693db-893a-46ef-aa0e-64280217e5ad	96	Time series coverage	32	17	\N	1	2023-01-31 18:25:28.503924	0	2023-01-31 18:25:28.503924	0	Complete	Liquid aqueous	0
97	3044bf54-d701-4224-8478-e41843e3179c	97	Time series coverage	61	21	\N	1	2023-01-31 18:25:28.50711	0	2023-01-31 18:25:28.50711	0	Complete	Liquid aqueous	0
98	de474d8e-b483-4fc6-b4a3-667d7ecf72a1	98	Time series coverage	29	32	\N	1	2023-01-31 18:25:28.510405	0	2023-01-31 18:25:28.510405	0	Complete	Liquid aqueous	0
99	29aaff4f-66f1-4707-b5be-ca1c46ea3f4f	99	Time series coverage	72	18	\N	1	2023-01-31 18:25:28.513762	0	2023-01-31 18:25:28.513762	0	Complete	Liquid aqueous	0
100	55f4075f-0489-4c54-b226-59687818ad88	100	Time series coverage	70	11	\N	1	2023-01-31 18:25:28.516941	0	2023-01-31 18:25:28.516941	0	Complete	Liquid aqueous	0
101	32586ffa-5d71-4c34-b978-3dba8416115b	101	Time series coverage	51	22	\N	1	2023-01-31 18:25:28.520082	0	2023-01-31 18:25:28.520082	0	Complete	Liquid aqueous	0
102	f076801b-e935-4fa3-b1c4-f5822858fdef	102	Time series coverage	35	21	\N	1	2023-01-31 18:25:28.523199	0	2023-01-31 18:25:28.523199	0	Complete	Liquid aqueous	0
103	e2547063-3ebb-4583-8a26-87d06a3001da	103	Time series coverage	65	23	\N	1	2023-01-31 18:25:28.526401	0	2023-01-31 18:25:28.526401	0	Complete	Liquid aqueous	0
104	d34627da-744d-4add-825b-7c459f0e22f8	104	Time series coverage	32	17	\N	1	2023-01-31 18:25:28.529558	0	2023-01-31 18:25:28.529558	0	Complete	Liquid aqueous	0
105	6a041f03-0bd7-4856-ac07-fc8710633fd2	105	Time series coverage	61	21	\N	1	2023-01-31 18:25:28.532684	0	2023-01-31 18:25:28.532684	0	Complete	Liquid aqueous	0
106	088ff66e-1811-4410-992d-b92112c53fb3	106	Time series coverage	29	32	\N	1	2023-01-31 18:25:28.535805	0	2023-01-31 18:25:28.535805	0	Complete	Liquid aqueous	0
107	2cce189e-222a-4fa6-a8b0-1687598d9755	107	Time series coverage	72	18	\N	1	2023-01-31 18:25:28.539168	0	2023-01-31 18:25:28.539168	0	Complete	Liquid aqueous	0
108	f3934474-4264-4893-a49a-5deb284684a8	108	Time series coverage	70	11	\N	1	2023-01-31 18:25:28.542374	0	2023-01-31 18:25:28.542374	0	Complete	Liquid aqueous	0
109	199c9af5-a1d5-4ebe-a962-e38701fdd9f3	109	Time series coverage	86	23	\N	1	2023-01-31 18:25:28.545666	0	2023-01-31 18:25:28.545666	0	Complete	Liquid aqueous	0
110	b9789867-ca62-4bd2-8fbf-ad435c338e93	110	Time series coverage	87	23	\N	1	2023-01-31 18:25:28.548901	0	2023-01-31 18:25:28.548901	0	Complete	Liquid aqueous	0
111	d764c4fe-4450-4da3-9c40-3bf785d77f74	111	Time series coverage	88	23	\N	1	2023-01-31 18:25:28.552304	0	2023-01-31 18:25:28.552304	0	Complete	Liquid aqueous	0
112	88856d90-96c6-4729-a337-134c1e7ef7d1	112	Time series coverage	91	23	\N	1	2023-01-31 18:25:28.555506	0	2023-01-31 18:25:28.555506	0	Complete	Liquid aqueous	0
113	b6b97eba-f9aa-4adc-9a6c-85bc75f0f3a4	113	Time series coverage	89	17	\N	1	2023-01-31 18:25:28.55863	0	2023-01-31 18:25:28.55863	0	Complete	Liquid aqueous	0
114	0774e0c7-8c88-4972-86eb-a8c6d8abfd72	114	Time series coverage	90	17	\N	1	2023-01-31 18:25:28.561866	0	2023-01-31 18:25:28.561866	0	Complete	Liquid aqueous	0
115	3ca513b7-7fb2-48fe-ad24-9f4b4df92e2d	115	Time series coverage	92	17	\N	1	2023-01-31 18:25:28.565019	0	2023-01-31 18:25:28.565019	0	Complete	Liquid aqueous	0
116	14e99eeb-5ad2-419a-a27a-04d47b7a40b6	116	Time series coverage	93	17	\N	1	2023-01-31 18:25:28.568113	0	2023-01-31 18:25:28.568113	0	Complete	Liquid aqueous	0
117	721a552e-cd14-422b-9b98-37ba1cef5848	117	Time series coverage	94	17	\N	1	2023-01-31 18:25:28.571183	0	2023-01-31 18:25:28.571183	0	Complete	Liquid aqueous	0
118	33ac75bb-0eac-4c27-954e-a32c611bd531	118	Time series coverage	96	17	\N	1	2023-01-31 18:25:28.574366	0	2023-01-31 18:25:28.574366	0	Complete	Liquid aqueous	0
119	4a3310b5-5850-4894-a725-bd311dd007b5	119	Time series coverage	97	17	\N	1	2023-01-31 18:25:28.578287	0	2023-01-31 18:25:28.578287	0	Complete	Liquid aqueous	0
120	927ad720-ce79-4f2d-8319-b571df078d49	120	Time series coverage	95	17	\N	1	2023-01-31 18:25:28.581607	0	2023-01-31 18:25:28.581607	0	Complete	Liquid aqueous	0
121	f82ce3ae-c1bd-4dca-ad08-e0f3013b4244	121	Time series coverage	98	17	\N	1	2023-01-31 18:25:28.584819	0	2023-01-31 18:25:28.584819	0	Complete	Liquid aqueous	0
122	4216a85b-16e3-4b49-ac3b-843808971259	122	Time series coverage	99	17	\N	1	2023-01-31 18:25:28.588006	0	2023-01-31 18:25:28.588006	0	Complete	Liquid aqueous	0
123	67e6b45d-91ed-4f83-8586-592994f5b609	123	Time series coverage	100	17	\N	1	2023-01-31 18:25:28.591156	0	2023-01-31 18:25:28.591156	0	Complete	Liquid aqueous	0
124	407ea218-076d-46b9-a936-430eafaa333b	124	Time series coverage	101	17	\N	1	2023-01-31 18:25:28.594363	0	2023-01-31 18:25:28.594363	0	Complete	Liquid aqueous	0
125	45647382-1139-4ca0-9f7f-13c1c4b79757	125	Time series coverage	102	17	\N	1	2023-01-31 18:25:28.597793	0	2023-01-31 18:25:28.597793	0	Complete	Liquid aqueous	0
126	afc3400b-7c38-4c38-afe3-bf1f3c3d5f0c	126	Time series coverage	103	17	\N	1	2023-01-31 18:25:28.600925	0	2023-01-31 18:25:28.600925	0	Complete	Liquid aqueous	0
127	516629fa-2faf-44ab-b0d3-13f026258988	127	Time series coverage	104	17	\N	1	2023-01-31 18:25:28.604	0	2023-01-31 18:25:28.604	0	Complete	Liquid aqueous	0
128	89b35524-70b6-4a4f-a82d-d45880597a7e	128	Time series coverage	105	21	\N	1	2023-01-31 18:25:28.607079	0	2023-01-31 18:25:28.607079	0	Complete	Liquid aqueous	0
129	9513c4e6-8f78-47a3-a936-76b9a12e490a	129	Time series coverage	68	21	\N	1	2023-01-31 18:25:28.610292	0	2023-01-31 18:25:28.610292	0	Complete	Liquid aqueous	0
130	23a7cdcc-e61b-4993-a5fe-a18f35f860b2	130	Time series coverage	31	26	\N	1	2023-01-31 18:25:28.61379	0	2023-01-31 18:25:28.61379	0	Complete	Liquid aqueous	0
131	dce884a4-413c-4700-a992-a335ed96f0f1	131	Time series coverage	69	11	\N	1	2023-01-31 18:25:28.616992	0	2023-01-31 18:25:28.616992	0	Complete	Liquid aqueous	0
132	54f2341d-203f-406f-b573-5cd820006e95	132	Time series coverage	69	11	\N	1	2023-01-31 18:25:28.620164	0	2023-01-31 18:25:28.620164	0	Complete	Liquid aqueous	0
133	5a5d0de3-7a4a-48db-923f-1c6fbb8665af	133	Time series coverage	31	26	\N	1	2023-01-31 18:25:28.62328	0	2023-01-31 18:25:28.62328	0	Complete	Liquid aqueous	0
134	dbca0a4b-033f-4cda-afce-c253d3e004af	134	Time series coverage	67	22	\N	1	2023-01-31 18:43:37.094932	0	2023-01-31 18:43:37.094932	0	Complete	Liquid aqueous	0
\.


--
-- Data for Name: resultsdataquality; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.resultsdataquality (bridgeid, resultid, dataqualityid) FROM stdin;
1	38	1
2	38	2
5	51	1
6	51	3
7	51	4
8	52	1
9	52	3
10	52	4
11	53	1
12	53	3
13	53	4
14	54	1
15	54	3
16	54	4
17	55	1
18	55	3
19	55	4
20	58	1
21	58	3
22	58	4
23	64	1
24	64	3
25	64	4
26	65	1
27	65	3
28	65	4
29	67	1
30	67	3
31	67	4
32	68	1
33	68	3
34	68	4
35	59	1
36	59	3
37	59	4
38	60	1
39	60	3
40	60	4
41	61	1
42	61	3
43	61	4
44	62	1
45	62	3
46	62	4
47	63	1
48	63	3
49	63	4
50	129	4
51	130	4
52	130	3
53	131	4
54	131	3
55	132	4
56	132	3
57	133	4
58	133	3
59	104	1
60	104	3
61	104	4
62	105	1
63	105	3
64	105	4
65	106	1
66	106	3
67	106	4
68	103	1
69	103	3
70	103	4
71	108	1
72	108	3
73	108	4
74	73	1
75	73	3
76	73	4
77	74	1
78	74	3
79	74	4
80	75	1
81	75	3
82	75	4
83	72	1
84	72	3
85	72	4
86	77	1
87	77	3
88	77	4
89	96	1
90	96	3
91	96	4
92	97	1
93	97	3
94	97	4
95	98	1
96	98	3
97	98	4
98	95	1
99	95	3
100	95	4
101	100	1
102	100	3
103	100	4
104	81	1
105	81	3
106	81	4
107	82	1
108	82	3
109	82	4
110	83	1
111	83	3
112	83	4
113	80	1
114	80	3
115	80	4
116	85	1
117	85	3
118	85	4
\.


--
-- Data for Name: samplingfeatureannotations; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.samplingfeatureannotations (bridgeid, samplingfeatureid, annotationid) FROM stdin;
\.


--
-- Data for Name: samplingfeatureextensionpropertyvalues; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.samplingfeatureextensionpropertyvalues (bridgeid, samplingfeatureid, propertyid, propertyvalue) FROM stdin;
\.


--
-- Data for Name: samplingfeatureexternalidentifiers; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.samplingfeatureexternalidentifiers (bridgeid, samplingfeatureid, externalidentifiersystemid, samplingfeatureexternalidentifier, samplingfeatureexternalidentifieruri) FROM stdin;
\.


--
-- Data for Name: samplingfeatures; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.samplingfeatures (samplingfeatureid, samplingfeatureuuid, samplingfeaturetypecv, samplingfeaturecode, samplingfeaturename, samplingfeaturedescription, samplingfeaturegeotypecv, featuregeometry, featuregeometrywkt, elevation_m, elevationdatumcv) FROM stdin;
1	3fa85f64-5717-4562-b3fc-2c963f66afa6	Site	901-3-8	Dalsvatnet	Station ID: 3275	\N	\N	\N	\N	\N
2	904fca98-3c36-4902-992f-a18f9da72b1e	Site	Langtjern_boye	\N	\N	\N	\N	\N	\N	\N
3	1bd73c59-fcaa-459f-92a2-b999773c60bb	Site	Langtjern_inlet	\N	\N	\N	\N	\N	\N	\N
4	62d5af54-bee3-4631-a798-9c4ba6f6abf5	Site	Langtjern_outlet	\N	\N	\N	\N	\N	\N	\N
5	62f3a1f4-aa32-4b8e-ae9c-b5e3fc947cd3	Site	Langtjern_weather	\N	\N	\N	\N	\N	\N	\N
6	1a30038f-85b0-4045-a66e-af8504205a4a	Site	Iskoras_outlet	\N	\N	\N	\N	\N	\N	\N
7	2d6dceb2-9769-437a-a20d-b36f41d4ae29	Site	Maalselva	\N	\N	\N	\N	\N	\N	\N
8	ce6cb9fe-0023-445c-ae95-57ad615afc8f	Site	Adventelva	\N	\N	\N	\N	\N	\N	\N
9	33130cf7-78b3-4680-aa0b-539f31f4e0ca	Site	Lundevann	\N	\N	\N	\N	\N	\N	\N
10	da7b2aa0-4f74-4a25-aa8b-7dfa63795339	Site	Svanfoss	\N	\N	\N	\N	\N	\N	\N
11	c8b2270e-64e8-4c20-b98b-7b494f0c1315	Site	Rosten	\N	\N	\N	\N	\N	\N	\N
12	017a9014-3476-4fd1-8dd3-80c4f2a7c644	Site	Kviteberg	\N	\N	\N	\N	\N	\N	\N
13	9e366f0f-56dd-45aa-b2eb-9048c0013cf5	Site	Sjoa	\N	\N	\N	\N	\N	\N	\N
14	528af2ce-394c-446d-9caa-4ac04773091d	Site	Kraakfoss	\N	\N	\N	\N	\N	\N	\N
15	891f9842-1afa-43eb-a40f-cf9de0c40341	Site	MSOURCE1	\N	\N	\N	\N	\N	\N	\N
16	a6a16577-75be-424a-9529-4758f05b217f	Site	MSOURCE2	\N	\N	\N	\N	\N	\N	\N
17	fecc9b83-0020-4120-bb24-a002698a0540	Site	MicroRens_Inlet	\N	\N	\N	\N	\N	\N	\N
18	a4eae442-088d-4e6e-90f1-e6e22b21ed73	Site	MicroRens_Outlet	\N	\N	\N	\N	\N	\N	\N
19	30a4eeea-cda4-4793-a6a7-08ed65a7bdd1	Site	NIVA_lab_matrixFLU	\N	\N	\N	\N	\N	\N	\N
20	9c326ed6-53f3-4210-9cf1-6fae5268d5a4	Site	NIVA_lab_UVvis	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: sectionresults; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.sectionresults (resultid, ylocation, ylocationunitsid, spatialreferenceid, intendedxspacing, intendedxspacingunitsid, intendedzspacing, intendedzspacingunitsid, intendedtimespacing, intendedtimespacingunitsid, aggregationstatisticcv) FROM stdin;
\.


--
-- Data for Name: sectionresultvalueannotations; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.sectionresultvalueannotations (bridgeid, valueid, annotationid) FROM stdin;
\.


--
-- Data for Name: sectionresultvalues; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.sectionresultvalues (valueid, resultid, datavalue, valuedatetime, valuedatetimeutcoffset, xlocation, xaggregationinterval, xlocationunitsid, zlocation, zaggregationinterval, zlocationunitsid, censorcodecv, qualitycodecv, aggregationstatisticcv, timeaggregationinterval, timeaggregationintervalunitsid) FROM stdin;
\.


--
-- Data for Name: simulations; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.simulations (simulationid, actionid, simulationname, simulationdescription, simulationstartdatetime, simulationstartdatetimeutcoffset, simulationenddatetime, simulationenddatetimeutcoffset, timestepvalue, timestepunitsid, inputdatasetid, modelid) FROM stdin;
\.


--
-- Data for Name: sites; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.sites (samplingfeatureid, sitetypecv, latitude, longitude, spatialreferenceid) FROM stdin;
\.


--
-- Data for Name: spatialoffsets; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.spatialoffsets (spatialoffsetid, spatialoffsettypecv, offset1value, offset1unitid, offset2value, offset2unitid, offset3value, offset3unitid) FROM stdin;
\.


--
-- Data for Name: spatialreferenceexternalidentifiers; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.spatialreferenceexternalidentifiers (bridgeid, spatialreferenceid, externalidentifiersystemid, spatialreferenceexternalidentifier, spatialreferenceexternalidentifieruri) FROM stdin;
\.


--
-- Data for Name: spatialreferences; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.spatialreferences (spatialreferenceid, srscode, srsname, srsdescription, srslink) FROM stdin;
\.


--
-- Data for Name: specimenbatchpostions; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.specimenbatchpostions (featureactionid, batchpositionnumber, batchpositionlabel) FROM stdin;
\.


--
-- Data for Name: specimens; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.specimens (samplingfeatureid, specimentypecv, specimenmediumcv, isfieldspecimen) FROM stdin;
\.


--
-- Data for Name: specimentaxonomicclassifiers; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.specimentaxonomicclassifiers (bridgeid, samplingfeatureid, taxonomicclassifierid, citationid) FROM stdin;
\.


--
-- Data for Name: spectraresults; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.spectraresults (resultid, xlocation, xlocationunitsid, ylocation, ylocationunitsid, zlocation, zlocationunitsid, spatialreferenceid, intendedwavelengthspacing, intendedwavelengthspacingunitsid, aggregationstatisticcv) FROM stdin;
\.


--
-- Data for Name: spectraresultvalueannotations; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.spectraresultvalueannotations (bridgeid, valueid, annotationid) FROM stdin;
\.


--
-- Data for Name: spectraresultvalues; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.spectraresultvalues (valueid, resultid, datavalue, valuedatetime, valuedatetimeutcoffset, excitationwavelength, emissionwavelength, wavelengthunitsid, censorcodecv, qualitycodecv, timeaggregationinterval, timeaggregationintervalunitsid) FROM stdin;
\.


--
-- Data for Name: taxonomicclassifierexternalidentifiers; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.taxonomicclassifierexternalidentifiers (bridgeid, taxonomicclassifierid, externalidentifiersystemid, taxonomicclassifierexternalidentifier, taxonomicclassifierexternalidentifieruri) FROM stdin;
\.


--
-- Data for Name: taxonomicclassifiers; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.taxonomicclassifiers (taxonomicclassifierid, taxonomicclassifiertypecv, taxonomicclassifiername, taxonomicclassifiercommonname, taxonomicclassifierdescription, parenttaxonomicclassifierid) FROM stdin;
\.


--
-- Data for Name: taxonomicclassifiersannotations; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.taxonomicclassifiersannotations (bridgeid, taxonomicclassifierid, annotationid) FROM stdin;
\.


--
-- Data for Name: timeseriesresults; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.timeseriesresults (resultid, xlocation, xlocationunitsid, ylocation, ylocationunitsid, zlocation, zlocationunitsid, spatialreferenceid, intendedtimespacing, intendedtimespacingunitsid, aggregationstatisticcv) FROM stdin;
1	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
2	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
3	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
4	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
5	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
6	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
7	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
8	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
9	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
10	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
11	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
12	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
13	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
14	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
15	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
16	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
17	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
18	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
19	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
20	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
21	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
22	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
23	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
24	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
25	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
26	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
27	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
28	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
29	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
30	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
31	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
32	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
33	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
34	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
35	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
36	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
37	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
38	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
39	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
40	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
41	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
42	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
43	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
44	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
45	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
46	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
47	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
48	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
49	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
50	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
51	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
52	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
53	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
54	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
55	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
56	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
57	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
58	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
59	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
60	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
61	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
62	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
63	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
64	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
65	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
66	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
67	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
68	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
69	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
70	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
71	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
72	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
73	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
74	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
75	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
76	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
77	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
78	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
79	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
80	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
81	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
82	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
83	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
84	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
85	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
86	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
87	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
88	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
89	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
90	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
91	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
92	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
93	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
94	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
95	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
96	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
97	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
98	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
99	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
100	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
101	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
102	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
103	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
104	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
105	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
106	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
107	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
108	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
109	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
110	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
111	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
112	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
113	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
114	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
115	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
116	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
117	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
118	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
119	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
120	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
121	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
122	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
123	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
124	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
125	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
126	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
127	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
128	\N	\N	\N	\N	\N	\N	\N	\N	\N	Unknown
129	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
130	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
131	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
132	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
133	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
134	\N	\N	\N	\N	\N	\N	\N	\N	\N	Average
\.


--
-- Data for Name: timeseriesresultvalueannotations; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.timeseriesresultvalueannotations (bridgeid, valueid, annotationid) FROM stdin;
\.


--
-- Data for Name: timeseriesresultvalues; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.timeseriesresultvalues (valueid, resultid, datavalue, valuedatetime, valuedatetimeutcoffset, censorcodecv, qualitycodecv, timeaggregationinterval, timeaggregationintervalunitsid) FROM stdin;
1	129	22.8	2022-09-14 14:20:00	0	Not censored	None	100	21
2	131	0.169	2022-09-14 14:20:00	0	Not censored	None	100	11
3	130	0.128	2022-09-14 14:20:00	0	Not censored	None	100	26
4	134	12	2022-09-14 14:20:00	0	Not censored	None	100	22
5	129	22.1	2022-09-14 17:15:00	0	Not censored	None	100	21
6	131	0.169	2022-09-14 17:15:00	0	Not censored	None	100	11
7	130	0.128	2022-09-14 17:15:00	0	Not censored	None	100	26
8	134	12	2022-09-14 17:15:00	0	Not censored	None	100	22
17	129	22.2	2022-09-19 10:49:30	0	Not censored	None	100	21
18	131	0.169	2022-09-19 10:49:30	0	Not censored	None	100	11
19	130	0.175	2022-09-19 10:49:30	0	Not censored	None	100	26
20	134	12	2022-09-19 10:49:30	0	Not censored	None	100	22
21	129	22.3	2022-09-19 10:50:00	0	Not censored	None	100	21
22	129	22.2	2022-09-19 10:50:30	0	Not censored	None	100	21
23	129	22.3	2022-09-19 10:51:00	0	Not censored	None	100	21
24	129	22.2	2022-09-19 10:51:30	0	Not censored	None	100	21
25	129	22.2	2022-09-19 10:52:00	0	Not censored	None	100	21
26	129	22.2	2022-09-19 10:52:30	0	Not censored	None	100	21
27	131	0.169	2022-09-19 10:50:00	0	Not censored	None	100	11
28	131	0.169	2022-09-19 10:50:30	0	Not censored	None	100	11
29	131	0.169	2022-09-19 10:51:00	0	Not censored	None	100	11
30	131	0.169	2022-09-19 10:51:30	0	Not censored	None	100	11
31	131	0.169	2022-09-19 10:52:00	0	Not censored	None	100	11
32	131	0.169	2022-09-19 10:52:30	0	Not censored	None	100	11
33	130	0.175	2022-09-19 10:50:00	0	Not censored	None	100	26
34	130	0.175	2022-09-19 10:50:30	0	Not censored	None	100	26
35	130	0.175	2022-09-19 10:51:00	0	Not censored	None	100	26
36	130	0.175	2022-09-19 10:51:30	0	Not censored	None	100	26
37	130	0.175	2022-09-19 10:52:00	0	Not censored	None	100	26
38	130	0.175	2022-09-19 10:52:30	0	Not censored	None	100	26
39	134	12	2022-09-19 10:50:00	0	Not censored	None	100	22
40	134	12	2022-09-19 10:50:30	0	Not censored	None	100	22
41	134	12	2022-09-19 10:51:00	0	Not censored	None	100	22
42	134	12	2022-09-19 10:51:30	0	Not censored	None	100	22
43	134	12	2022-09-19 10:52:00	0	Not censored	None	100	22
44	134	12	2022-09-19 10:52:30	0	Not censored	None	100	22
\.


--
-- Data for Name: trackresultlocations; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.trackresultlocations (valuedatetime, trackpoint, qualitycodecv, samplingfeatureid) FROM stdin;
\.


--
-- Data for Name: trackresults; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.trackresults (resultid, intendedtimespacing, intendedtimespacingunitsid, aggregationstatisticcv) FROM stdin;
\.


--
-- Data for Name: trackresultvalues; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.trackresultvalues (valuedatetime, datavalue, qualitycodecv, resultid) FROM stdin;
\.


--
-- Data for Name: trajectoryresults; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.trajectoryresults (resultid, spatialreferenceid, intendedtrajectoryspacing, intendedtrajectoryspacingunitsid, intendedtimespacing, intendedtimespacingunitsid, aggregationstatisticcv) FROM stdin;
\.


--
-- Data for Name: trajectoryresultvalueannotations; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.trajectoryresultvalueannotations (bridgeid, valueid, annotationid) FROM stdin;
\.


--
-- Data for Name: trajectoryresultvalues; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.trajectoryresultvalues (valueid, resultid, datavalue, valuedatetime, valuedatetimeutcoffset, xlocation, xlocationunitsid, ylocation, ylocationunitsid, zlocation, zlocationunitsid, trajectorydistance, trajectorydistanceaggregationinterval, trajectorydistanceunitsid, censorcodecv, qualitycodecv, timeaggregationinterval, timeaggregationintervalunitsid) FROM stdin;
\.


--
-- Data for Name: transectresults; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.transectresults (resultid, zlocation, zlocationunitsid, spatialreferenceid, intendedtransectspacing, intendedtransectspacingunitsid, intendedtimespacing, intendedtimespacingunitsid, aggregationstatisticcv) FROM stdin;
\.


--
-- Data for Name: transectresultvalueannotations; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.transectresultvalueannotations (bridgeid, valueid, annotationid) FROM stdin;
\.


--
-- Data for Name: transectresultvalues; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.transectresultvalues (valueid, resultid, datavalue, valuedatetime, valuedatetimeutcoffset, xlocation, xlocationunitsid, ylocation, ylocationunitsid, transectdistance, transectdistanceaggregationinterval, transectdistanceunitsid, censorcodecv, qualitycodecv, aggregationstatisticcv, timeaggregationinterval, timeaggregationintervalunitsid) FROM stdin;
\.


--
-- Data for Name: units; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.units (unitsid, unitstypecv, unitsabbreviation, unitsname, unitslink) FROM stdin;
1	Salinity	PSU	practical salinity unit	\N
2	Mass temperature	degC	temperature	\N
3	Concentration or density mass per volume	mg/m^3	milligram per cubic meter	\N
4	Concentration or density mass per volume	kg/m^3	kilogram per cubic meter	\N
5	Concentration count per count	ppb	parts per billion	\N
6	Concentration or density mass per volume	μg/m^3	microgram per cubic meter	\N
7	Concentration or density mass per volume	µg/l	microgram per liter	\N
8	Concentration or density mass per volume	mg/l	miligram per liter	\N
9	Concentration or density mass per volume	micro mol/l	microgram mol per liter	\N
10	Turbidity	FTU	formazin turbidity unit	\N
11	Turbidity	NTU	nepphelometric turbidity unit	\N
12	Pressure or stress	bar	bar	\N
13	Electrical conductivity	S/m	siemens per meter	\N
14	Volumetric flow rate	m3/s	cubic meters per second	\N
15	Linear velocity	m/s	meter per second	\N
16	Time	s	second	\N
17	Dimensionless	-	Dimensionless	\N
18	Salinity	ppt	Salinity	\N
19	Dimensionless	PrsAbs	Presence or Absence	http://qwwebservices.usgs.gov/service-domains.html
20	Dimensionless	%	Percent	http://qudt.org/vocab/unit#Percent; http://unitsofmeasure.org/ucum.html#para-29; http://his.cuahsi.org/mastercvreg/edit_cv11.aspx?tbl=Units&id=1125579048; http://www.unidata.ucar.edu/software/udunits/; http://qwwebservices.usgs.gov/service-domains.html
21	Temperature	degC	temperature	\N
22	Electromotive force	Volts	Volts	\N
23	Fluorescence	µg/L	microgram per liter	\N
24	Concentration count per volume	ppmv	parts per million per volume	\N
25	Length	mm	milimeter	\N
26	Length	m	meter	\N
27	Length	nm	nanometer	\N
28	Energy per area	W/m2	Watt per meter squared	\N
29	Angle	deg	degree	\N
30	Electrical conductivity	µS/cm	microsiemens per centimeter	\N
31	Electrical conductivity	mS/cm	milisiemens per centimeter	\N
32	Electrical conductivity	mS/m	milisiemens per meter	\N
33	Inverse length	1/m	one over meter	\N
34	Dimensionless	ml/l	Oxygen concentration	\N
35	Pressure or stress	dB	Decibel	\N
36	Pressure or stress	dbar	Decibar	\N
37	Particle flux	umol photons/m^2/sec	Photon flux	\N
38	Count	counts	Counts	\N
39	Inverse Steradian Meter	1/m*sr	Inverse steradian meter	\N
40	Fluorescence	RFU	Relative Fluorescence Unit	\N
\.


--
-- Data for Name: variableextensionpropertyvalues; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.variableextensionpropertyvalues (bridgeid, variableid, propertyid, propertyvalue) FROM stdin;
\.


--
-- Data for Name: variableexternalidentifiers; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.variableexternalidentifiers (bridgeid, variableid, externalidentifiersystemid, variableexternalidentifer, variableexternalidentifieruri) FROM stdin;
\.


--
-- Data for Name: variables; Type: TABLE DATA; Schema: odm2; Owner: -
--

COPY odm2.variables (variableid, variabletypecv, variablecode, variablenamecv, variabledefinition, speciationcv, nodatavalue) FROM stdin;
1	Chemistry	001	Salinity	salinity	\N	-9999
2	Climate	002	Temperature	temperature	\N	-9999
3	Water quality	003	Chlorophyll fluorescence	fluorescence from  chlorophyll A	\N	-9999
4	Water quality	004	Chlorophyll fluorescence	pah_fluorescence	\N	-9999
5	Water quality	005	Chlorophyll fluorescence	fluorescence from cyanobacteria	\N	-9999
6	Water quality	006	Chlorophyll fluorescence	cdom_fluorescence	\N	-9999
7	Water quality	007	Turbidity	turbidity in water	\N	-9999
8	Climate	008	Barometric pressure	atmospheric pressure	\N	-9999
9	Chemistry	009	Electrical conductivity	electrical conductivity of substance	\N	-9999
10	Biota	010	Abundance	This variable indicates the abundance of the taxon of the result	\N	-9999
11	Chemistry	Absorbance	Absorbance	This variable measures absorption coefficient in a water sample	\N	-9999
12	Chemistry	mass_spec_00	LC_QTOF_Raw	Raw data produced by Liquid Chromatography coupled to Quadrupole Time of Flight instrument	\N	-9999
13	Chemistry	mass_spec_01	LC_QTOF_mzXML	Data produced by Liquid Chromatography coupled to Quadrupole Time of Flight instrument and converted to mzXML format	\N	-9999
14	Chemistry	mass_spec_1	LC_QTOF_Peaks	Peaks detected by Liquid Chromatography coupled to Quadrupole Time of Flight instrument	\N	-9999
15	Chemistry	mass_spec_2	LC_QTOF_Peaks_and_Fragments	Peaks and fragments detected by Liquid Chromatography coupled to Quadrupole Time of Flight instrument	\N	-9999
16	Chemistry	mass_spec_3	LC_QTOF_Chemicals	Peaks identified in Liquid Chromatography coupled to Quadrupole Time of Flight instrument	\N	-9999
17	Chemistry	OxygenSat_1m	Oxygen, dissolved percent of saturation	Oxygen, dissolved percent of saturation at 1m. Last 10 samples.	\N	-9999
18	Chemistry	OxygenSat_6m	Oxygen, dissolved percent of saturation	Oxygen, dissolved percent of saturation at 6m. Last 10 samples.	\N	-9999
19	Chemistry	Temp_0.5m	Temperature, sensor	Temperature, sensor, at depth 0.5m	\N	-9999
20	Chemistry	Temp_1m	Temperature, sensor	Temperature, sensor, at depth 1m	\N	-9999
21	Chemistry	Temp_1.5m	Temperature, sensor	Temperature, sensor, at depth 1.5m	\N	-9999
22	Chemistry	Temp_2m	Temperature, sensor	Temperature, sensor, at depth 2m	\N	-9999
23	Chemistry	Temp_3m	Temperature, sensor	Temperature, sensor, at depth 3m	\N	-9999
24	Chemistry	Temp_4m	Temperature, sensor	Temperature, sensor, at depth 4m	\N	-9999
25	Chemistry	Temp_6m	Temperature, sensor	Temperature, sensor, at depth 6m	\N	-9999
26	Chemistry	Temp_8m	Temperature, sensor	Temperature, sensor, at depth 8m	\N	-9999
27	Chemistry	CO2Value_Avg	Fluorescence, dissolved organic matter (DOM)	Fluorescence of dissolved organic matter (DOM), CDOM sensor	\N	-9999
28	Chemistry	CDOMdigitalFinal_Avg	Carbon dioxide	Carbon dioxide	\N	-9999
29	Chemistry	CondValue_Avg	Electrical conductivity	Electrical conductivity	\N	-9999
30	Climate	LevelValue_Avg	Water level	Water level in a lake - vannstand	\N	-9999
31	Climate	LevelValue	Water level	Water level	\N	-9999
32	Chemistry	PhValue_Avg	pH	pH is the measure of the acidity or alkalinity of a solution. pH is formally a measure of the activity of dissolved hydrogen ions (H+). Solutions in which the concentration of H+ exceeds that of OH- have a pH value lower than 7.0 and are known as acids.	\N	-9999
33	Chemistry	Temp_ground_Avg	Temperature, sensor	Temperature, sensor, ground	\N	-9999
34	Chemistry	Temp_water_Avg	Temperature, sensor	Temperature, sensor, water	\N	-9999
35	Chemistry	Temp_air_Avg	Temperature, sensor	Temperature, sensor, air	\N	-9999
36	Chemistry	Temp_air	Temperature, sensor	Temperature, sensor, air	\N	-9999
37	Chemistry	Temp_ground_15cm_Avg	Temperature, sensor	Temperature, sensor, ground at 15 cm	\N	-9999
38	Chemistry	Temp_ground_20cm_Avg	Temperature, sensor	Temperature, sensor, ground at 20 cm	\N	-9999
39	Climate	BV_mm	Water level	Water level in a bucket	\N	-9999
40	Climate	GS_Wpm2_Avg	Global Radiation	Solar radiation, direct and diffuse, received from a solid angle of 2p steradians on a horizontal surface. Source: World Meteorological Organization, Meteoterm	\N	-9999
41	Climate	LF_psnt_Avg	Relative humidity	Relative humidity	\N	-9999
42	Climate	LT_gr_C_Avg	Temperature, sensor	Temperature, sensor, air	\N	-9999
43	Climate	NB_mm	Precipitation	Precipitation growth last hour	\N	-9999
44	Climate	VH_3_s_Max	Wind speed	Wind speed max	\N	-9999
45	Climate	WaterVelocity	Velocity	Water velocity	\N	-9999
46	Climate	WaterDepth	Depth	Water depth of the multiparameter sonde in the manhole.	\N	-9999
47	Climate	VH_mps_WVc(1)	Wind speed	Wind speed	\N	-9999
48	Climate	VH_mps_WVc(2)	Wind direction	Wind direction	\N	-9999
49	Climate	waterLevel_mm_Avg	Water level	Water level	\N	-9999
50	Climate	snowValue_mm_Avg	Snow depth	Snow depth	\N	-9999
51	Instrumentation	Batt_Volt_Avg	Voltage	Battery voltage	\N	-9999
52	Instrumentation	Batt_Volt_flowmeter	Voltage	Battery voltage in flowmeter	\N	-9999
53	Instrumentation	InputVoltage	Voltage	Input voltage	\N	-9999
54	Chemistry	FlowRate	Streamflow	Flow rate	\N	-9999
55	Instrumentation	Batt_V_Min	Voltage	Battery voltage	\N	-9999
56	Instrumentation	CondTeller	Counter	Signal counter used to check whether all signals which are used as in input to aggregation (average) of conductivity values are present	\N	-9999
57	Instrumentation	PHTeller	Counter	Signal counter used to check whether all signals which are used as in input to aggregation (average) of pH values are present	\N	-9999
58	Instrumentation	LevelTeller	Counter	Signal counter used to check whether all signals which are used as in input to aggregation (average) of level values are present	\N	-9999
59	Instrumentation	TempLevelTeller	Counter	Signal counter used to check weather all signals which are used as in input to aggregation (average) of temperature values are present	\N	-9999
60	Chemistry	TempCond_Avg	Temperature, sensor	Temperature measured by conductivity sensor setup	\N	-9999
61	Chemistry	TempPh_Avg	Temperature, sensor	Temperature measured by Ph sensor	\N	-9999
62	Chemistry	TempLevel_Avg	Temperature, sensor	Temperature measured by Level sensor	\N	-9999
63	Chemistry	CondValue	Electrical conductivity	Electrical conductivity	\N	-9999
64	Chemistry	PhValue	pH	pH is the measure of the acidity or alkalinity of a solution. pH is formally a measure of the activity of dissolved hydrogen ions (H+). Solutions in which the concentration of H+ exceeds that of OH- have a pH value lower than 7.0 and are known as acids.	\N	-9999
65	Chemistry	CDOMdigitalFinal	Fluorescence, dissolved organic matter (DOM)	Fluorescence of dissolved organic matter (DOM), CDOM sensor	\N	-9999
66	Chemistry	CDOManalogFinal	Fluorescence, dissolved organic matter (DOM)	Fluorescence of dissolved organic matter (DOM), CDOM sensor	\N	-9999
67	Instrumentation	Batt_Volt	Voltage	Battery voltage	\N	-9999
68	Chemistry	Temp	Temperature, sensor	Temperature, sensor	\N	-9999
69	Chemistry	Turbidity	Turbidity	Turbidity	\N	-9999
70	Chemistry	Turbidity_Avg	Turbidity	Turbidity	\N	-9999
71	Chemistry	Salinity	Salinity	Salinity	\N	-9999
72	Chemistry	Salinity_Avg	Salinity	Salinity	\N	-9999
73	Chemistry	OxygenSat	Oxygen, dissolved percent of saturation	Oxygen, dissolved percent of saturation	\N	-9999
74	Chemistry	OxygenCon	Oxygen, dissolved	Oxygen concentration	\N	-9999
75	Oceanography	RawBackScattering	BackScattering	Raw backscattering	\N	-9999
76	Oceanography	BackScattering870	BackScattering	Backscattering at 870 nm	\N	-9999
77	Oceanography	fDOM	Fluorescence, dissolved organic matter (DOM)	Fluorescent Dissolved Organic Matter	\N	-9999
78	Oceanography	ChlaValue	Chlorophyll a	Chlorophyll	\N	-9999
79	Physics	Rrs_380	Reflectance	Reflectance measured at wl=380	\N	-9999
80	Physics	Rrs_412	Reflectance	Reflectance measured at wl=412	\N	-9999
81	Physics	Rrs_443	Reflectance	Reflectance measured at wl=443	\N	-9999
82	Physics	Rrs_490	Reflectance	Reflectance measured at wl=490	\N	-9999
83	Physics	Rrs_555	Reflectance	Reflectance measured at wl=555	\N	-9999
84	Physics	Rrs_645	Reflectance	Reflectance measured at wl=645	\N	-9999
85	Physics	Rrs_850	Reflectance	Reflectance measured at wl=850	\N	-9999
86	Chemistry	CDOM1_375_460	Fluorescence, dissolved organic matter (DOM)	Fluorescence measured with matrixFLU, ex/em:375/460	\N	-9999
87	Chemistry	CDOM2_375_655	Fluorescence, dissolved organic matter (DOM)	Fluorescence measured with matrixFLU, ex/em:375/655	\N	-9999
88	Chemistry	CDOM3_375_682	Fluorescence, dissolved organic matter (DOM)	Fluorescence measured with matrixFLU, ex/em:375/682	\N	-9999
89	Chemistry	XX3_375_850	Counter	Fluorescence measured with matrixFLU, ex/em:375/850	\N	-9999
90	Chemistry	scat460_470_460	Counter	Fluorescence measured with matrixFLU, ex/em:470/460	\N	-9999
91	Chemistry	chl-a_470_682	Chlorophyll a	Fluorescence measured with matrixFLU, ex/em:470/682	\N	-9999
92	Chemistry	XX2_470_655	Counter	Fluorescence measured with matrixFLU, ex/em:470/655	\N	-9999
93	Chemistry	XX4_470_850	Counter	Fluorescence measured with matrixFLU, ex/em:470/850	\N	-9999
94	Chemistry	XX1_590_460	Counter	Fluorescence measured with matrixFLU, ex/em:590/460	\N	-9999
95	Chemistry	XX5_590_850	Counter	Fluorescence measured with matrixFLU, ex/em:590/850	\N	-9999
96	Chemistry	blue2_590_682	Counter	Fluorescence measured with matrixFLU, ex/em:590/682	\N	-9999
97	Chemistry	blue1_590_655	Counter	Fluorescence measured with matrixFLU, ex/em:590/655	\N	-9999
98	Chemistry	Abs_219.0	Absorbance	This variable measures absorption coefficient in a water sample	\N	-9999
99	Chemistry	Abs_276.0	Absorbance	This variable measures absorption coefficient in a water sample	\N	-9999
100	Chemistry	Abs_223.8	Absorbance	This variable measures absorption coefficient in a water sample	\N	-9999
101	Chemistry	Abs_269.6	Absorbance	This variable measures absorption coefficient in a water sample	\N	-9999
102	Chemistry	Abs_235.0	Absorbance	This variable measures absorption coefficient in a water sample	\N	-9999
103	Chemistry	Abs_232.6	Absorbance	This variable measures absorption coefficient in a water sample	\N	-9999
104	Chemistry	Abs_310.7	Absorbance	This variable measures absorption coefficient in a water sample	\N	-9999
105	Chemistry	Temp_enclosed_uvvis	Temperature, sensor	Temperature, sensor, air	\N	-9999
106	Chemistry	Absorption_coef_443	Napierian, absorption coefficient	Absorption coefficient measured at 443 nm	\N	-9999
107	Chemistry	SigmaDensity	Density	Measure of thermodynamic property of seawater. σ = ρ/(kg/m3 ) - 1000https://www.nature.com/scitable/knowledge/library/key-physical-variables-in-the-ocean-temperature-102805293/	\N	-9999
108	Instrumentation	ProbeVel	Velocity	Velocity of CTD probe	\N	-9999
109	Hydrology	SoundVel	Velocity	Velocity of sound measured by CTD-type probe	\N	-9999
110	Hydrology	Press	Pressure, gauge	Pressure measured by CTD-type probe	\N	-9999
111	Water quality	PotTemp	Temperature, sensor	Potential Temperature measured by CTD-type probe	\N	-9999
112	Water quality	ChlaFluorescence	Chlorophyll fluorescence	Chlorophyll measured by Seapoint Chlorophyll Fluorometer	\N	-9999
113	Water quality	PAR	Radiation, net PAR	Photosynthetically Active Radiation, the spectral range of solar radiation from 400 to 700 nm. Usedby Phytoplankton for photosynthesis.	\N	-9999
\.


--
-- Name: actionannotations_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.actionannotations_bridgeid_seq', 1, false);


--
-- Name: actionby_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.actionby_bridgeid_seq', 134, true);


--
-- Name: actiondirectives_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.actiondirectives_bridgeid_seq', 1, false);


--
-- Name: actionextensionpropertyvalues_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.actionextensionpropertyvalues_bridgeid_seq', 1, false);


--
-- Name: actions_actionid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.actions_actionid_seq', 134, true);


--
-- Name: affiliations_affiliationid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.affiliations_affiliationid_seq', 1, true);


--
-- Name: annotations_annotationid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.annotations_annotationid_seq', 25, true);


--
-- Name: authorlists_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.authorlists_bridgeid_seq', 1, false);


--
-- Name: calibrationreferenceequipment_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.calibrationreferenceequipment_bridgeid_seq', 1, false);


--
-- Name: calibrationstandards_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.calibrationstandards_bridgeid_seq', 1, false);


--
-- Name: categoricalresultvalueannotations_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.categoricalresultvalueannotations_bridgeid_seq', 1, false);


--
-- Name: categoricalresultvalues_valueid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.categoricalresultvalues_valueid_seq', 1, false);


--
-- Name: citationextensionpropertyvalues_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.citationextensionpropertyvalues_bridgeid_seq', 1, false);


--
-- Name: citationexternalidentifiers_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.citationexternalidentifiers_bridgeid_seq', 1, false);


--
-- Name: citations_citationid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.citations_citationid_seq', 1, false);


--
-- Name: dataloggerfilecolumns_dataloggerfilecolumnid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.dataloggerfilecolumns_dataloggerfilecolumnid_seq', 1, false);


--
-- Name: dataloggerfiles_dataloggerfileid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.dataloggerfiles_dataloggerfileid_seq', 1, false);


--
-- Name: dataloggerprogramfiles_programid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.dataloggerprogramfiles_programid_seq', 1, false);


--
-- Name: dataquality_dataqualityid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.dataquality_dataqualityid_seq', 4, true);


--
-- Name: datasetcitations_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.datasetcitations_bridgeid_seq', 1, false);


--
-- Name: datasets_datasetid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.datasets_datasetid_seq', 1, false);


--
-- Name: datasetsresults_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.datasetsresults_bridgeid_seq', 1, false);


--
-- Name: derivationequations_derivationequationid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.derivationequations_derivationequationid_seq', 1, false);


--
-- Name: directives_directiveid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.directives_directiveid_seq', 6, true);


--
-- Name: equipment_equipmentid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.equipment_equipmentid_seq', 1, false);


--
-- Name: equipmentannotations_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.equipmentannotations_bridgeid_seq', 1, false);


--
-- Name: equipmentmodels_equipmentmodelid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.equipmentmodels_equipmentmodelid_seq', 1, false);


--
-- Name: equipmentused_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.equipmentused_bridgeid_seq', 1, false);


--
-- Name: extensionproperties_propertyid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.extensionproperties_propertyid_seq', 1, false);


--
-- Name: externalidentifiersystems_externalidentifiersystemid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.externalidentifiersystems_externalidentifiersystemid_seq', 2, true);


--
-- Name: featureactions_featureactionid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.featureactions_featureactionid_seq', 134, true);


--
-- Name: instrumentoutputvariables_instrumentoutputvariableid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.instrumentoutputvariables_instrumentoutputvariableid_seq', 1, false);


--
-- Name: measurementresultvalueannotations_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.measurementresultvalueannotations_bridgeid_seq', 1, false);


--
-- Name: measurementresultvalues_valueid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.measurementresultvalues_valueid_seq', 1, false);


--
-- Name: methodannotations_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.methodannotations_bridgeid_seq', 22, true);


--
-- Name: methodcitations_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.methodcitations_bridgeid_seq', 1, false);


--
-- Name: methodextensionpropertyvalues_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.methodextensionpropertyvalues_bridgeid_seq', 1, false);


--
-- Name: methodexternalidentifiers_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.methodexternalidentifiers_bridgeid_seq', 1, false);


--
-- Name: methods_methodid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.methods_methodid_seq', 35, true);


--
-- Name: modelaffiliations_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.modelaffiliations_bridgeid_seq', 1, false);


--
-- Name: models_modelid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.models_modelid_seq', 1, false);


--
-- Name: organizations_organizationid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.organizations_organizationid_seq', 2, true);


--
-- Name: people_personid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.people_personid_seq', 1, true);


--
-- Name: personexternalidentifiers_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.personexternalidentifiers_bridgeid_seq', 1, false);


--
-- Name: pointcoverageresultvalueannotations_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.pointcoverageresultvalueannotations_bridgeid_seq', 1, false);


--
-- Name: pointcoverageresultvalues_valueid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.pointcoverageresultvalues_valueid_seq', 1, false);


--
-- Name: processinglevels_processinglevelid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.processinglevels_processinglevelid_seq', 8, true);


--
-- Name: profileresultvalueannotations_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.profileresultvalueannotations_bridgeid_seq', 1, false);


--
-- Name: profileresultvalues_valueid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.profileresultvalues_valueid_seq', 1, false);


--
-- Name: projectexternalidentifiers_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.projectexternalidentifiers_bridgeid_seq', 1, false);


--
-- Name: projects_projectid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.projects_projectid_seq', 1, false);


--
-- Name: projectstationexternalidentifiers_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.projectstationexternalidentifiers_bridgeid_seq', 1, false);


--
-- Name: projectstations_projectstationid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.projectstations_projectstationid_seq', 1, false);


--
-- Name: referencematerialexternalidentifiers_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.referencematerialexternalidentifiers_bridgeid_seq', 1, false);


--
-- Name: referencematerials_referencematerialid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.referencematerials_referencematerialid_seq', 1, false);


--
-- Name: referencematerialvalues_referencematerialvalueid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.referencematerialvalues_referencematerialvalueid_seq', 1, false);


--
-- Name: relatedactions_relationid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.relatedactions_relationid_seq', 1, false);


--
-- Name: relatedannotations_relationid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.relatedannotations_relationid_seq', 1, false);


--
-- Name: relatedcitations_relationid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.relatedcitations_relationid_seq', 1, false);


--
-- Name: relateddatasets_relationid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.relateddatasets_relationid_seq', 1, false);


--
-- Name: relatedequipment_relationid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.relatedequipment_relationid_seq', 1, false);


--
-- Name: relatedfeatures_relationid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.relatedfeatures_relationid_seq', 1, false);


--
-- Name: relatedmodels_relatedid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.relatedmodels_relatedid_seq', 1, false);


--
-- Name: relatedresults_relationid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.relatedresults_relationid_seq', 1, false);


--
-- Name: relatedtaxonomicclassifiers_relationid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.relatedtaxonomicclassifiers_relationid_seq', 1, false);


--
-- Name: resultannotations_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.resultannotations_bridgeid_seq', 1, false);


--
-- Name: resultextensionpropertyvalues_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.resultextensionpropertyvalues_bridgeid_seq', 1, false);


--
-- Name: results_resultid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.results_resultid_seq', 134, true);


--
-- Name: resultsdataquality_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.resultsdataquality_bridgeid_seq', 118, true);


--
-- Name: samplingfeatureannotations_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.samplingfeatureannotations_bridgeid_seq', 1, false);


--
-- Name: samplingfeatureextensionpropertyvalues_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.samplingfeatureextensionpropertyvalues_bridgeid_seq', 1, false);


--
-- Name: samplingfeatureexternalidentifiers_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.samplingfeatureexternalidentifiers_bridgeid_seq', 1, false);


--
-- Name: samplingfeatures_samplingfeatureid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.samplingfeatures_samplingfeatureid_seq', 20, true);


--
-- Name: sectionresultvalueannotations_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.sectionresultvalueannotations_bridgeid_seq', 1, false);


--
-- Name: sectionresultvalues_valueid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.sectionresultvalues_valueid_seq', 1, false);


--
-- Name: simulations_simulationid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.simulations_simulationid_seq', 1, false);


--
-- Name: spatialoffsets_spatialoffsetid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.spatialoffsets_spatialoffsetid_seq', 1, false);


--
-- Name: spatialreferenceexternalidentifiers_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.spatialreferenceexternalidentifiers_bridgeid_seq', 1, false);


--
-- Name: spatialreferences_spatialreferenceid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.spatialreferences_spatialreferenceid_seq', 1, false);


--
-- Name: specimentaxonomicclassifiers_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.specimentaxonomicclassifiers_bridgeid_seq', 1, false);


--
-- Name: spectraresultvalueannotations_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.spectraresultvalueannotations_bridgeid_seq', 1, false);


--
-- Name: spectraresultvalues_valueid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.spectraresultvalues_valueid_seq', 1, false);


--
-- Name: taxonomicclassifierexternalidentifiers_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.taxonomicclassifierexternalidentifiers_bridgeid_seq', 1, false);


--
-- Name: taxonomicclassifiers_taxonomicclassifierid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.taxonomicclassifiers_taxonomicclassifierid_seq', 1, false);


--
-- Name: taxonomicclassifiersannotations_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.taxonomicclassifiersannotations_bridgeid_seq', 1, false);


--
-- Name: timeseriesresultvalueannotations_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.timeseriesresultvalueannotations_bridgeid_seq', 1, false);


--
-- Name: timeseriesresultvalues_valueid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.timeseriesresultvalues_valueid_seq', 44, true);


--
-- Name: trajectoryresultvalueannotations_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.trajectoryresultvalueannotations_bridgeid_seq', 1, false);


--
-- Name: trajectoryresultvalues_valueid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.trajectoryresultvalues_valueid_seq', 1, false);


--
-- Name: transectresultvalueannotations_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.transectresultvalueannotations_bridgeid_seq', 1, false);


--
-- Name: transectresultvalues_valueid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.transectresultvalues_valueid_seq', 1, false);


--
-- Name: units_unitsid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.units_unitsid_seq', 40, true);


--
-- Name: variableextensionpropertyvalues_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.variableextensionpropertyvalues_bridgeid_seq', 1, false);


--
-- Name: variableexternalidentifiers_bridgeid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.variableexternalidentifiers_bridgeid_seq', 1, false);


--
-- Name: variables_variableid_seq; Type: SEQUENCE SET; Schema: odm2; Owner: -
--

SELECT pg_catalog.setval('odm2.variables_variableid_seq', 113, true);


--
-- Name: actionannotations actionannotations_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.actionannotations
    ADD CONSTRAINT actionannotations_pkey PRIMARY KEY (bridgeid);


--
-- Name: actionby actionby_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.actionby
    ADD CONSTRAINT actionby_pkey PRIMARY KEY (bridgeid);


--
-- Name: actiondirectives actiondirectives_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.actiondirectives
    ADD CONSTRAINT actiondirectives_pkey PRIMARY KEY (bridgeid);


--
-- Name: actionextensionpropertyvalues actionextensionpropertyvalues_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.actionextensionpropertyvalues
    ADD CONSTRAINT actionextensionpropertyvalues_pkey PRIMARY KEY (bridgeid);


--
-- Name: actions actions_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.actions
    ADD CONSTRAINT actions_pkey PRIMARY KEY (actionid);


--
-- Name: affiliations affiliations_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.affiliations
    ADD CONSTRAINT affiliations_pkey PRIMARY KEY (affiliationid);


--
-- Name: affiliations affiliations_primaryemail_key; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.affiliations
    ADD CONSTRAINT affiliations_primaryemail_key UNIQUE (primaryemail);


--
-- Name: annotations annotations_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.annotations
    ADD CONSTRAINT annotations_pkey PRIMARY KEY (annotationid);


--
-- Name: authorlists authorlists_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.authorlists
    ADD CONSTRAINT authorlists_pkey PRIMARY KEY (bridgeid);


--
-- Name: calibrationactions calibrationactions_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.calibrationactions
    ADD CONSTRAINT calibrationactions_pkey PRIMARY KEY (actionid);


--
-- Name: calibrationreferenceequipment calibrationreferenceequipment_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.calibrationreferenceequipment
    ADD CONSTRAINT calibrationreferenceequipment_pkey PRIMARY KEY (bridgeid);


--
-- Name: calibrationstandards calibrationstandards_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.calibrationstandards
    ADD CONSTRAINT calibrationstandards_pkey PRIMARY KEY (bridgeid);


--
-- Name: categoricalresults categoricalresults_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.categoricalresults
    ADD CONSTRAINT categoricalresults_pkey PRIMARY KEY (resultid);


--
-- Name: categoricalresultvalueannotations categoricalresultvalueannotations_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.categoricalresultvalueannotations
    ADD CONSTRAINT categoricalresultvalueannotations_pkey PRIMARY KEY (bridgeid);


--
-- Name: categoricalresultvalues categoricalresultvalues_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.categoricalresultvalues
    ADD CONSTRAINT categoricalresultvalues_pkey PRIMARY KEY (valueid);


--
-- Name: categoricalresultvalues categoricalresultvalues_resultid_datavalue_valuedatetime_va_key; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.categoricalresultvalues
    ADD CONSTRAINT categoricalresultvalues_resultid_datavalue_valuedatetime_va_key UNIQUE (resultid, datavalue, valuedatetime, valuedatetimeutcoffset);


--
-- Name: citationextensionpropertyvalues citationextensionpropertyvalues_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.citationextensionpropertyvalues
    ADD CONSTRAINT citationextensionpropertyvalues_pkey PRIMARY KEY (bridgeid);


--
-- Name: citationexternalidentifiers citationexternalidentifiers_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.citationexternalidentifiers
    ADD CONSTRAINT citationexternalidentifiers_pkey PRIMARY KEY (bridgeid);


--
-- Name: citations citations_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.citations
    ADD CONSTRAINT citations_pkey PRIMARY KEY (citationid);


--
-- Name: cv_actiontype cv_actiontype_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.cv_actiontype
    ADD CONSTRAINT cv_actiontype_pkey PRIMARY KEY (name);


--
-- Name: cv_aggregationstatistic cv_aggregationstatistic_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.cv_aggregationstatistic
    ADD CONSTRAINT cv_aggregationstatistic_pkey PRIMARY KEY (name);


--
-- Name: cv_annotationtype cv_annotationtype_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.cv_annotationtype
    ADD CONSTRAINT cv_annotationtype_pkey PRIMARY KEY (name);


--
-- Name: cv_censorcode cv_censorcode_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.cv_censorcode
    ADD CONSTRAINT cv_censorcode_pkey PRIMARY KEY (name);


--
-- Name: cv_dataqualitytype cv_dataqualitytype_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.cv_dataqualitytype
    ADD CONSTRAINT cv_dataqualitytype_pkey PRIMARY KEY (name);


--
-- Name: cv_datasettype cv_datasettype_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.cv_datasettype
    ADD CONSTRAINT cv_datasettype_pkey PRIMARY KEY (name);


--
-- Name: cv_directivetype cv_directivetype_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.cv_directivetype
    ADD CONSTRAINT cv_directivetype_pkey PRIMARY KEY (name);


--
-- Name: cv_elevationdatum cv_elevationdatum_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.cv_elevationdatum
    ADD CONSTRAINT cv_elevationdatum_pkey PRIMARY KEY (name);


--
-- Name: cv_equipmenttype cv_equipmenttype_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.cv_equipmenttype
    ADD CONSTRAINT cv_equipmenttype_pkey PRIMARY KEY (name);


--
-- Name: cv_medium cv_medium_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.cv_medium
    ADD CONSTRAINT cv_medium_pkey PRIMARY KEY (name);


--
-- Name: cv_methodtype cv_methodtype_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.cv_methodtype
    ADD CONSTRAINT cv_methodtype_pkey PRIMARY KEY (name);


--
-- Name: cv_organizationtype cv_organizationtype_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.cv_organizationtype
    ADD CONSTRAINT cv_organizationtype_pkey PRIMARY KEY (name);


--
-- Name: cv_propertydatatype cv_propertydatatype_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.cv_propertydatatype
    ADD CONSTRAINT cv_propertydatatype_pkey PRIMARY KEY (name);


--
-- Name: cv_qualitycode cv_qualitycode_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.cv_qualitycode
    ADD CONSTRAINT cv_qualitycode_pkey PRIMARY KEY (name);


--
-- Name: cv_relationshiptype cv_relationshiptype_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.cv_relationshiptype
    ADD CONSTRAINT cv_relationshiptype_pkey PRIMARY KEY (name);


--
-- Name: cv_resulttype cv_resulttype_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.cv_resulttype
    ADD CONSTRAINT cv_resulttype_pkey PRIMARY KEY (name);


--
-- Name: cv_samplingfeaturegeotype cv_samplingfeaturegeotype_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.cv_samplingfeaturegeotype
    ADD CONSTRAINT cv_samplingfeaturegeotype_pkey PRIMARY KEY (name);


--
-- Name: cv_samplingfeaturetype cv_samplingfeaturetype_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.cv_samplingfeaturetype
    ADD CONSTRAINT cv_samplingfeaturetype_pkey PRIMARY KEY (name);


--
-- Name: cv_sitetype cv_sitetype_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.cv_sitetype
    ADD CONSTRAINT cv_sitetype_pkey PRIMARY KEY (name);


--
-- Name: cv_spatialoffsettype cv_spatialoffsettype_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.cv_spatialoffsettype
    ADD CONSTRAINT cv_spatialoffsettype_pkey PRIMARY KEY (name);


--
-- Name: cv_speciation cv_speciation_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.cv_speciation
    ADD CONSTRAINT cv_speciation_pkey PRIMARY KEY (name);


--
-- Name: cv_specimentype cv_specimentype_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.cv_specimentype
    ADD CONSTRAINT cv_specimentype_pkey PRIMARY KEY (name);


--
-- Name: cv_status cv_status_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.cv_status
    ADD CONSTRAINT cv_status_pkey PRIMARY KEY (name);


--
-- Name: cv_taxonomicclassifiertype cv_taxonomicclassifiertype_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.cv_taxonomicclassifiertype
    ADD CONSTRAINT cv_taxonomicclassifiertype_pkey PRIMARY KEY (name);


--
-- Name: cv_unitstype cv_unitstype_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.cv_unitstype
    ADD CONSTRAINT cv_unitstype_pkey PRIMARY KEY (name);


--
-- Name: cv_variablename cv_variablename_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.cv_variablename
    ADD CONSTRAINT cv_variablename_pkey PRIMARY KEY (name);


--
-- Name: cv_variabletype cv_variabletype_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.cv_variabletype
    ADD CONSTRAINT cv_variabletype_pkey PRIMARY KEY (name);


--
-- Name: dataloggerfilecolumns dataloggerfilecolumns_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.dataloggerfilecolumns
    ADD CONSTRAINT dataloggerfilecolumns_pkey PRIMARY KEY (dataloggerfilecolumnid);


--
-- Name: dataloggerfiles dataloggerfiles_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.dataloggerfiles
    ADD CONSTRAINT dataloggerfiles_pkey PRIMARY KEY (dataloggerfileid);


--
-- Name: dataloggerprogramfiles dataloggerprogramfiles_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.dataloggerprogramfiles
    ADD CONSTRAINT dataloggerprogramfiles_pkey PRIMARY KEY (programid);


--
-- Name: dataquality dataquality_dataqualitycode_key; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.dataquality
    ADD CONSTRAINT dataquality_dataqualitycode_key UNIQUE (dataqualitycode);


--
-- Name: dataquality dataquality_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.dataquality
    ADD CONSTRAINT dataquality_pkey PRIMARY KEY (dataqualityid);


--
-- Name: datasetcitations datasetcitations_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.datasetcitations
    ADD CONSTRAINT datasetcitations_pkey PRIMARY KEY (bridgeid);


--
-- Name: datasets datasets_datasetcode_key; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.datasets
    ADD CONSTRAINT datasets_datasetcode_key UNIQUE (datasetcode);


--
-- Name: datasets datasets_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.datasets
    ADD CONSTRAINT datasets_pkey PRIMARY KEY (datasetid);


--
-- Name: datasetsresults datasetsresults_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.datasetsresults
    ADD CONSTRAINT datasetsresults_pkey PRIMARY KEY (bridgeid);


--
-- Name: derivationequations derivationequations_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.derivationequations
    ADD CONSTRAINT derivationequations_pkey PRIMARY KEY (derivationequationid);


--
-- Name: directives directives_directivename_key; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.directives
    ADD CONSTRAINT directives_directivename_key UNIQUE (directivename);


--
-- Name: directives directives_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.directives
    ADD CONSTRAINT directives_pkey PRIMARY KEY (directiveid);


--
-- Name: equipment equipment_equipmentcode_key; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.equipment
    ADD CONSTRAINT equipment_equipmentcode_key UNIQUE (equipmentcode);


--
-- Name: equipment equipment_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.equipment
    ADD CONSTRAINT equipment_pkey PRIMARY KEY (equipmentid);


--
-- Name: equipmentannotations equipmentannotations_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.equipmentannotations
    ADD CONSTRAINT equipmentannotations_pkey PRIMARY KEY (bridgeid);


--
-- Name: equipmentmodels equipmentmodels_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.equipmentmodels
    ADD CONSTRAINT equipmentmodels_pkey PRIMARY KEY (equipmentmodelid);


--
-- Name: equipmentused equipmentused_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.equipmentused
    ADD CONSTRAINT equipmentused_pkey PRIMARY KEY (bridgeid);


--
-- Name: extensionproperties extensionproperties_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.extensionproperties
    ADD CONSTRAINT extensionproperties_pkey PRIMARY KEY (propertyid);


--
-- Name: externalidentifiersystems externalidentifiersystems_externalidentifiersystemname_key; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.externalidentifiersystems
    ADD CONSTRAINT externalidentifiersystems_externalidentifiersystemname_key UNIQUE (externalidentifiersystemname);


--
-- Name: externalidentifiersystems externalidentifiersystems_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.externalidentifiersystems
    ADD CONSTRAINT externalidentifiersystems_pkey PRIMARY KEY (externalidentifiersystemid);


--
-- Name: featureactions featureactions_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.featureactions
    ADD CONSTRAINT featureactions_pkey PRIMARY KEY (featureactionid);


--
-- Name: featureactions featureactions_samplingfeatureid_actionid_key; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.featureactions
    ADD CONSTRAINT featureactions_samplingfeatureid_actionid_key UNIQUE (samplingfeatureid, actionid);


--
-- Name: instrumentoutputvariables instrumentoutputvariables_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.instrumentoutputvariables
    ADD CONSTRAINT instrumentoutputvariables_pkey PRIMARY KEY (instrumentoutputvariableid);


--
-- Name: kafka_records kafka_records_topic_key_key; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.kafka_records
    ADD CONSTRAINT kafka_records_topic_key_key UNIQUE (topic, key);


--
-- Name: maintenanceactions maintenanceactions_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.maintenanceactions
    ADD CONSTRAINT maintenanceactions_pkey PRIMARY KEY (actionid);


--
-- Name: measurementresults measurementresults_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.measurementresults
    ADD CONSTRAINT measurementresults_pkey PRIMARY KEY (resultid);


--
-- Name: measurementresultvalueannotations measurementresultvalueannotations_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.measurementresultvalueannotations
    ADD CONSTRAINT measurementresultvalueannotations_pkey PRIMARY KEY (bridgeid);


--
-- Name: measurementresultvalues measurementresultvalues_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.measurementresultvalues
    ADD CONSTRAINT measurementresultvalues_pkey PRIMARY KEY (valueid);


--
-- Name: measurementresultvalues measurementresultvalues_resultid_datavalue_valuedatetime_va_key; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.measurementresultvalues
    ADD CONSTRAINT measurementresultvalues_resultid_datavalue_valuedatetime_va_key UNIQUE (resultid, datavalue, valuedatetime, valuedatetimeutcoffset);


--
-- Name: methodannotations methodannotations_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.methodannotations
    ADD CONSTRAINT methodannotations_pkey PRIMARY KEY (bridgeid);


--
-- Name: methodcitations methodcitations_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.methodcitations
    ADD CONSTRAINT methodcitations_pkey PRIMARY KEY (bridgeid);


--
-- Name: methodextensionpropertyvalues methodextensionpropertyvalues_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.methodextensionpropertyvalues
    ADD CONSTRAINT methodextensionpropertyvalues_pkey PRIMARY KEY (bridgeid);


--
-- Name: methodexternalidentifiers methodexternalidentifiers_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.methodexternalidentifiers
    ADD CONSTRAINT methodexternalidentifiers_pkey PRIMARY KEY (bridgeid);


--
-- Name: methods methods_methodcode_key; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.methods
    ADD CONSTRAINT methods_methodcode_key UNIQUE (methodcode);


--
-- Name: methods methods_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.methods
    ADD CONSTRAINT methods_pkey PRIMARY KEY (methodid);


--
-- Name: modelaffiliations modelaffiliations_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.modelaffiliations
    ADD CONSTRAINT modelaffiliations_pkey PRIMARY KEY (bridgeid);


--
-- Name: models models_modelcode_key; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.models
    ADD CONSTRAINT models_modelcode_key UNIQUE (modelcode);


--
-- Name: models models_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.models
    ADD CONSTRAINT models_pkey PRIMARY KEY (modelid);


--
-- Name: organizations organizations_organizationcode_key; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.organizations
    ADD CONSTRAINT organizations_organizationcode_key UNIQUE (organizationcode);


--
-- Name: organizations organizations_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (organizationid);


--
-- Name: people people_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.people
    ADD CONSTRAINT people_pkey PRIMARY KEY (personid);


--
-- Name: personexternalidentifiers personexternalidentifiers_personexternalidentifier_external_key; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.personexternalidentifiers
    ADD CONSTRAINT personexternalidentifiers_personexternalidentifier_external_key UNIQUE (personexternalidentifier, externalidentifiersystemid);


--
-- Name: personexternalidentifiers personexternalidentifiers_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.personexternalidentifiers
    ADD CONSTRAINT personexternalidentifiers_pkey PRIMARY KEY (bridgeid);


--
-- Name: pointcoverageresults pointcoverageresults_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.pointcoverageresults
    ADD CONSTRAINT pointcoverageresults_pkey PRIMARY KEY (resultid);


--
-- Name: pointcoverageresultvalueannotations pointcoverageresultvalueannotations_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.pointcoverageresultvalueannotations
    ADD CONSTRAINT pointcoverageresultvalueannotations_pkey PRIMARY KEY (bridgeid);


--
-- Name: pointcoverageresultvalues pointcoverageresultvalues_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.pointcoverageresultvalues
    ADD CONSTRAINT pointcoverageresultvalues_pkey PRIMARY KEY (valueid);


--
-- Name: pointcoverageresultvalues pointcoverageresultvalues_resultid_datavalue_valuedatetime__key; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.pointcoverageresultvalues
    ADD CONSTRAINT pointcoverageresultvalues_resultid_datavalue_valuedatetime__key UNIQUE (resultid, datavalue, valuedatetime, valuedatetimeutcoffset, xlocation, xlocationunitsid, ylocation, ylocationunitsid, censorcodecv, qualitycodecv);


--
-- Name: processinglevels processinglevels_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.processinglevels
    ADD CONSTRAINT processinglevels_pkey PRIMARY KEY (processinglevelid);


--
-- Name: processinglevels processinglevels_processinglevelcode_key; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.processinglevels
    ADD CONSTRAINT processinglevels_processinglevelcode_key UNIQUE (processinglevelcode);


--
-- Name: profileresults profileresults_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.profileresults
    ADD CONSTRAINT profileresults_pkey PRIMARY KEY (resultid);


--
-- Name: profileresultvalueannotations profileresultvalueannotations_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.profileresultvalueannotations
    ADD CONSTRAINT profileresultvalueannotations_pkey PRIMARY KEY (bridgeid);


--
-- Name: profileresultvalues profileresultvalues_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.profileresultvalues
    ADD CONSTRAINT profileresultvalues_pkey PRIMARY KEY (valueid);


--
-- Name: profileresultvalues profileresultvalues_resultid_datavalue_valuedatetime_valued_key; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.profileresultvalues
    ADD CONSTRAINT profileresultvalues_resultid_datavalue_valuedatetime_valued_key UNIQUE (resultid, datavalue, valuedatetime, valuedatetimeutcoffset, zlocation, zaggregationinterval, zlocationunitsid, censorcodecv, qualitycodecv, timeaggregationinterval, timeaggregationintervalunitsid);


--
-- Name: projectexternalidentifiers projectexternalidentifiers_externalidentifiersystemid_proje_key; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.projectexternalidentifiers
    ADD CONSTRAINT projectexternalidentifiers_externalidentifiersystemid_proje_key UNIQUE (externalidentifiersystemid, projectexternalidentifier);


--
-- Name: projectexternalidentifiers projectexternalidentifiers_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.projectexternalidentifiers
    ADD CONSTRAINT projectexternalidentifiers_pkey PRIMARY KEY (bridgeid);


--
-- Name: projectexternalidentifiers projectexternalidentifiers_projectexternalidentifier_extern_key; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.projectexternalidentifiers
    ADD CONSTRAINT projectexternalidentifiers_projectexternalidentifier_extern_key UNIQUE (projectexternalidentifier, externalidentifiersystemid);


--
-- Name: projectexternalidentifiers projectexternalidentifiers_projectid_externalidentifiersyst_key; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.projectexternalidentifiers
    ADD CONSTRAINT projectexternalidentifiers_projectid_externalidentifiersyst_key UNIQUE (projectid, externalidentifiersystemid);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (projectid);


--
-- Name: projects projects_projectname_key; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.projects
    ADD CONSTRAINT projects_projectname_key UNIQUE (projectname);


--
-- Name: projectstationexternalidentifiers projectstationexternalidentif_projectstationexternalidentif_key; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.projectstationexternalidentifiers
    ADD CONSTRAINT projectstationexternalidentif_projectstationexternalidentif_key UNIQUE (projectstationexternalidentifier, externalidentifiersystemid);


--
-- Name: projectstationexternalidentifiers projectstationexternalidentif_projectstationid_externaliden_key; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.projectstationexternalidentifiers
    ADD CONSTRAINT projectstationexternalidentif_projectstationid_externaliden_key UNIQUE (projectstationid, externalidentifiersystemid);


--
-- Name: projectstationexternalidentifiers projectstationexternalidentifiers_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.projectstationexternalidentifiers
    ADD CONSTRAINT projectstationexternalidentifiers_pkey PRIMARY KEY (bridgeid);


--
-- Name: projectstations projectstations_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.projectstations
    ADD CONSTRAINT projectstations_pkey PRIMARY KEY (projectstationid);


--
-- Name: projectstations projectstations_projectstationcode_projectid_key; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.projectstations
    ADD CONSTRAINT projectstations_projectstationcode_projectid_key UNIQUE (projectstationcode, projectid);


--
-- Name: referencematerialexternalidentifiers referencematerialexternalidentifiers_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.referencematerialexternalidentifiers
    ADD CONSTRAINT referencematerialexternalidentifiers_pkey PRIMARY KEY (bridgeid);


--
-- Name: referencematerials referencematerials_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.referencematerials
    ADD CONSTRAINT referencematerials_pkey PRIMARY KEY (referencematerialid);


--
-- Name: referencematerials referencematerials_referencematerialcode_key; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.referencematerials
    ADD CONSTRAINT referencematerials_referencematerialcode_key UNIQUE (referencematerialcode);


--
-- Name: referencematerialvalues referencematerialvalues_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.referencematerialvalues
    ADD CONSTRAINT referencematerialvalues_pkey PRIMARY KEY (referencematerialvalueid);


--
-- Name: relatedactions relatedactions_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedactions
    ADD CONSTRAINT relatedactions_pkey PRIMARY KEY (relationid);


--
-- Name: relatedannotations relatedannotations_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedannotations
    ADD CONSTRAINT relatedannotations_pkey PRIMARY KEY (relationid);


--
-- Name: relatedcitations relatedcitations_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedcitations
    ADD CONSTRAINT relatedcitations_pkey PRIMARY KEY (relationid);


--
-- Name: relateddatasets relateddatasets_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relateddatasets
    ADD CONSTRAINT relateddatasets_pkey PRIMARY KEY (relationid);


--
-- Name: relatedequipment relatedequipment_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedequipment
    ADD CONSTRAINT relatedequipment_pkey PRIMARY KEY (relationid);


--
-- Name: relatedfeatures relatedfeatures_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedfeatures
    ADD CONSTRAINT relatedfeatures_pkey PRIMARY KEY (relationid);


--
-- Name: relatedmodels relatedmodels_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedmodels
    ADD CONSTRAINT relatedmodels_pkey PRIMARY KEY (relatedid);


--
-- Name: relatedresults relatedresults_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedresults
    ADD CONSTRAINT relatedresults_pkey PRIMARY KEY (relationid);


--
-- Name: relatedtaxonomicclassifiers relatedtaxonomicclassifiers_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedtaxonomicclassifiers
    ADD CONSTRAINT relatedtaxonomicclassifiers_pkey PRIMARY KEY (relationid);


--
-- Name: resultannotations resultannotations_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.resultannotations
    ADD CONSTRAINT resultannotations_pkey PRIMARY KEY (bridgeid);


--
-- Name: resultderivationequations resultderivationequations_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.resultderivationequations
    ADD CONSTRAINT resultderivationequations_pkey PRIMARY KEY (resultid);


--
-- Name: resultextensionpropertyvalues resultextensionpropertyvalues_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.resultextensionpropertyvalues
    ADD CONSTRAINT resultextensionpropertyvalues_pkey PRIMARY KEY (bridgeid);


--
-- Name: resultnormalizationvalues resultnormalizationvalues_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.resultnormalizationvalues
    ADD CONSTRAINT resultnormalizationvalues_pkey PRIMARY KEY (resultid);


--
-- Name: results results_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.results
    ADD CONSTRAINT results_pkey PRIMARY KEY (resultid);


--
-- Name: resultsdataquality resultsdataquality_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.resultsdataquality
    ADD CONSTRAINT resultsdataquality_pkey PRIMARY KEY (bridgeid);


--
-- Name: resultsdataquality resultsdataquality_resultid_dataqualityid_key; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.resultsdataquality
    ADD CONSTRAINT resultsdataquality_resultid_dataqualityid_key UNIQUE (resultid, dataqualityid);


--
-- Name: samplingfeatureannotations samplingfeatureannotations_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.samplingfeatureannotations
    ADD CONSTRAINT samplingfeatureannotations_pkey PRIMARY KEY (bridgeid);


--
-- Name: samplingfeatureextensionpropertyvalues samplingfeatureextensionpropertyvalues_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.samplingfeatureextensionpropertyvalues
    ADD CONSTRAINT samplingfeatureextensionpropertyvalues_pkey PRIMARY KEY (bridgeid);


--
-- Name: samplingfeatureexternalidentifiers samplingfeatureexternalidenti_samplingfeatureexternalidenti_key; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.samplingfeatureexternalidentifiers
    ADD CONSTRAINT samplingfeatureexternalidenti_samplingfeatureexternalidenti_key UNIQUE (samplingfeatureexternalidentifier, externalidentifiersystemid);


--
-- Name: samplingfeatureexternalidentifiers samplingfeatureexternalidenti_samplingfeatureid_externalide_key; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.samplingfeatureexternalidentifiers
    ADD CONSTRAINT samplingfeatureexternalidenti_samplingfeatureid_externalide_key UNIQUE (samplingfeatureid, externalidentifiersystemid);


--
-- Name: samplingfeatureexternalidentifiers samplingfeatureexternalidentifiers_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.samplingfeatureexternalidentifiers
    ADD CONSTRAINT samplingfeatureexternalidentifiers_pkey PRIMARY KEY (bridgeid);


--
-- Name: samplingfeatures samplingfeatures_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.samplingfeatures
    ADD CONSTRAINT samplingfeatures_pkey PRIMARY KEY (samplingfeatureid);


--
-- Name: samplingfeatures samplingfeatures_samplingfeaturecode_key; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.samplingfeatures
    ADD CONSTRAINT samplingfeatures_samplingfeaturecode_key UNIQUE (samplingfeaturecode);


--
-- Name: samplingfeatures samplingfeatures_samplingfeatureuuid_key; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.samplingfeatures
    ADD CONSTRAINT samplingfeatures_samplingfeatureuuid_key UNIQUE (samplingfeatureuuid);


--
-- Name: samplingfeatures samplingfeatures_samplingfeatureuuid_key1; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.samplingfeatures
    ADD CONSTRAINT samplingfeatures_samplingfeatureuuid_key1 UNIQUE (samplingfeatureuuid);


--
-- Name: sectionresults sectionresults_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.sectionresults
    ADD CONSTRAINT sectionresults_pkey PRIMARY KEY (resultid);


--
-- Name: sectionresultvalueannotations sectionresultvalueannotations_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.sectionresultvalueannotations
    ADD CONSTRAINT sectionresultvalueannotations_pkey PRIMARY KEY (bridgeid);


--
-- Name: sectionresultvalues sectionresultvalues_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.sectionresultvalues
    ADD CONSTRAINT sectionresultvalues_pkey PRIMARY KEY (valueid);


--
-- Name: sectionresultvalues sectionresultvalues_resultid_datavalue_valuedatetime_valued_key; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.sectionresultvalues
    ADD CONSTRAINT sectionresultvalues_resultid_datavalue_valuedatetime_valued_key UNIQUE (resultid, datavalue, valuedatetime, valuedatetimeutcoffset, xlocation, xaggregationinterval, xlocationunitsid, zlocation, zaggregationinterval, zlocationunitsid, censorcodecv, qualitycodecv, aggregationstatisticcv, timeaggregationinterval, timeaggregationintervalunitsid);


--
-- Name: simulations simulations_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.simulations
    ADD CONSTRAINT simulations_pkey PRIMARY KEY (simulationid);


--
-- Name: sites sites_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.sites
    ADD CONSTRAINT sites_pkey PRIMARY KEY (samplingfeatureid);


--
-- Name: spatialoffsets spatialoffsets_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.spatialoffsets
    ADD CONSTRAINT spatialoffsets_pkey PRIMARY KEY (spatialoffsetid);


--
-- Name: spatialreferenceexternalidentifiers spatialreferenceexternalidentifiers_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.spatialreferenceexternalidentifiers
    ADD CONSTRAINT spatialreferenceexternalidentifiers_pkey PRIMARY KEY (bridgeid);


--
-- Name: spatialreferences spatialreferences_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.spatialreferences
    ADD CONSTRAINT spatialreferences_pkey PRIMARY KEY (spatialreferenceid);


--
-- Name: specimenbatchpostions specimenbatchpostions_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.specimenbatchpostions
    ADD CONSTRAINT specimenbatchpostions_pkey PRIMARY KEY (featureactionid);


--
-- Name: specimens specimens_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.specimens
    ADD CONSTRAINT specimens_pkey PRIMARY KEY (samplingfeatureid);


--
-- Name: specimentaxonomicclassifiers specimentaxonomicclassifiers_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.specimentaxonomicclassifiers
    ADD CONSTRAINT specimentaxonomicclassifiers_pkey PRIMARY KEY (bridgeid);


--
-- Name: spectraresults spectraresults_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.spectraresults
    ADD CONSTRAINT spectraresults_pkey PRIMARY KEY (resultid);


--
-- Name: spectraresultvalueannotations spectraresultvalueannotations_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.spectraresultvalueannotations
    ADD CONSTRAINT spectraresultvalueannotations_pkey PRIMARY KEY (bridgeid);


--
-- Name: spectraresultvalues spectraresultvalues_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.spectraresultvalues
    ADD CONSTRAINT spectraresultvalues_pkey PRIMARY KEY (valueid);


--
-- Name: spectraresultvalues spectraresultvalues_resultid_datavalue_valuedatetime_valued_key; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.spectraresultvalues
    ADD CONSTRAINT spectraresultvalues_resultid_datavalue_valuedatetime_valued_key UNIQUE (resultid, datavalue, valuedatetime, valuedatetimeutcoffset, excitationwavelength, emissionwavelength, wavelengthunitsid, censorcodecv, qualitycodecv, timeaggregationinterval, timeaggregationintervalunitsid);


--
-- Name: taxonomicclassifierexternalidentifiers taxonomicclassifierexternalidentifiers_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.taxonomicclassifierexternalidentifiers
    ADD CONSTRAINT taxonomicclassifierexternalidentifiers_pkey PRIMARY KEY (bridgeid);


--
-- Name: taxonomicclassifiers taxonomicclassifiers_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.taxonomicclassifiers
    ADD CONSTRAINT taxonomicclassifiers_pkey PRIMARY KEY (taxonomicclassifierid);


--
-- Name: taxonomicclassifiersannotations taxonomicclassifiersannotations_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.taxonomicclassifiersannotations
    ADD CONSTRAINT taxonomicclassifiersannotations_pkey PRIMARY KEY (bridgeid);


--
-- Name: timeseriesresults timeseriesresults_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.timeseriesresults
    ADD CONSTRAINT timeseriesresults_pkey PRIMARY KEY (resultid);


--
-- Name: timeseriesresultvalueannotations timeseriesresultvalueannotations_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.timeseriesresultvalueannotations
    ADD CONSTRAINT timeseriesresultvalueannotations_pkey PRIMARY KEY (bridgeid);


--
-- Name: timeseriesresultvalues timeseriesresultvalues_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.timeseriesresultvalues
    ADD CONSTRAINT timeseriesresultvalues_pkey PRIMARY KEY (valueid);


--
-- Name: timeseriesresultvalues timeseriesresultvalues_resultid_datavalue_valuedatetime_val_key; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.timeseriesresultvalues
    ADD CONSTRAINT timeseriesresultvalues_resultid_datavalue_valuedatetime_val_key UNIQUE (resultid, datavalue, valuedatetime, valuedatetimeutcoffset, censorcodecv, qualitycodecv, timeaggregationinterval, timeaggregationintervalunitsid);


--
-- Name: trackresultlocations track_result_location_unique; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.trackresultlocations
    ADD CONSTRAINT track_result_location_unique UNIQUE (valuedatetime, samplingfeatureid);


--
-- Name: trackresultvalues track_result_value_unique; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.trackresultvalues
    ADD CONSTRAINT track_result_value_unique UNIQUE (valuedatetime, resultid);


--
-- Name: trackresults trackresults_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.trackresults
    ADD CONSTRAINT trackresults_pkey PRIMARY KEY (resultid);


--
-- Name: trajectoryresults trajectoryresults_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.trajectoryresults
    ADD CONSTRAINT trajectoryresults_pkey PRIMARY KEY (resultid);


--
-- Name: trajectoryresultvalueannotations trajectoryresultvalueannotations_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.trajectoryresultvalueannotations
    ADD CONSTRAINT trajectoryresultvalueannotations_pkey PRIMARY KEY (bridgeid);


--
-- Name: trajectoryresultvalues trajectoryresultvalues_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.trajectoryresultvalues
    ADD CONSTRAINT trajectoryresultvalues_pkey PRIMARY KEY (valueid);


--
-- Name: trajectoryresultvalues trajectoryresultvalues_resultid_datavalue_valuedatetime_val_key; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.trajectoryresultvalues
    ADD CONSTRAINT trajectoryresultvalues_resultid_datavalue_valuedatetime_val_key UNIQUE (resultid, datavalue, valuedatetime, valuedatetimeutcoffset, xlocation, xlocationunitsid, ylocation, ylocationunitsid, zlocation, zlocationunitsid, trajectorydistance, trajectorydistanceaggregationinterval, trajectorydistanceunitsid, censorcodecv, qualitycodecv, timeaggregationinterval, timeaggregationintervalunitsid);


--
-- Name: transectresults transectresults_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.transectresults
    ADD CONSTRAINT transectresults_pkey PRIMARY KEY (resultid);


--
-- Name: transectresultvalueannotations transectresultvalueannotations_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.transectresultvalueannotations
    ADD CONSTRAINT transectresultvalueannotations_pkey PRIMARY KEY (bridgeid);


--
-- Name: transectresultvalues transectresultvalues_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.transectresultvalues
    ADD CONSTRAINT transectresultvalues_pkey PRIMARY KEY (valueid);


--
-- Name: transectresultvalues transectresultvalues_resultid_datavalue_valuedatetime_value_key; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.transectresultvalues
    ADD CONSTRAINT transectresultvalues_resultid_datavalue_valuedatetime_value_key UNIQUE (resultid, datavalue, valuedatetime, valuedatetimeutcoffset, xlocation, xlocationunitsid, ylocation, ylocationunitsid, transectdistance, transectdistanceaggregationinterval, transectdistanceunitsid, censorcodecv, qualitycodecv, aggregationstatisticcv, timeaggregationinterval, timeaggregationintervalunitsid);


--
-- Name: units units_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.units
    ADD CONSTRAINT units_pkey PRIMARY KEY (unitsid);


--
-- Name: units units_unitstypecv_unitsabbreviation_key; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.units
    ADD CONSTRAINT units_unitstypecv_unitsabbreviation_key UNIQUE (unitstypecv, unitsabbreviation);


--
-- Name: timeseriesresultvalues uq_timeseriesresultvalues_all_but_qc; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.timeseriesresultvalues
    ADD CONSTRAINT uq_timeseriesresultvalues_all_but_qc UNIQUE (resultid, valuedatetime, valuedatetimeutcoffset);


--
-- Name: variableextensionpropertyvalues variableextensionpropertyvalues_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.variableextensionpropertyvalues
    ADD CONSTRAINT variableextensionpropertyvalues_pkey PRIMARY KEY (bridgeid);


--
-- Name: variableexternalidentifiers variableexternalidentifiers_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.variableexternalidentifiers
    ADD CONSTRAINT variableexternalidentifiers_pkey PRIMARY KEY (bridgeid);


--
-- Name: variables variables_pkey; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.variables
    ADD CONSTRAINT variables_pkey PRIMARY KEY (variableid);


--
-- Name: variables variables_variablecode_key; Type: CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.variables
    ADD CONSTRAINT variables_variablecode_key UNIQUE (variablecode);


--
-- Name: trackresultlocations_resultid_time_idx; Type: INDEX; Schema: odm2; Owner: -
--

CREATE INDEX trackresultlocations_resultid_time_idx ON odm2.trackresultlocations USING btree (samplingfeatureid, valuedatetime DESC);


--
-- Name: trackresultvalues_resultid_time_idx; Type: INDEX; Schema: odm2; Owner: -
--

CREATE INDEX trackresultvalues_resultid_time_idx ON odm2.trackresultvalues USING btree (resultid, valuedatetime DESC);


--
-- Name: actionannotations fk_actionannotations_actions; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.actionannotations
    ADD CONSTRAINT fk_actionannotations_actions FOREIGN KEY (actionid) REFERENCES odm2.actions(actionid) ON DELETE RESTRICT;


--
-- Name: actionannotations fk_actionannotations_annotations; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.actionannotations
    ADD CONSTRAINT fk_actionannotations_annotations FOREIGN KEY (annotationid) REFERENCES odm2.annotations(annotationid) ON DELETE RESTRICT;


--
-- Name: actiondirectives fk_actiondirectives_actions; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.actiondirectives
    ADD CONSTRAINT fk_actiondirectives_actions FOREIGN KEY (actionid) REFERENCES odm2.actions(actionid) ON DELETE RESTRICT;


--
-- Name: actiondirectives fk_actiondirectives_directives; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.actiondirectives
    ADD CONSTRAINT fk_actiondirectives_directives FOREIGN KEY (directiveid) REFERENCES odm2.directives(directiveid) ON DELETE RESTRICT;


--
-- Name: actionextensionpropertyvalues fk_actionextensionpropertyvalues_actions; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.actionextensionpropertyvalues
    ADD CONSTRAINT fk_actionextensionpropertyvalues_actions FOREIGN KEY (actionid) REFERENCES odm2.actions(actionid) ON DELETE RESTRICT;


--
-- Name: actionextensionpropertyvalues fk_actionextensionpropertyvalues_extensionproperties; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.actionextensionpropertyvalues
    ADD CONSTRAINT fk_actionextensionpropertyvalues_extensionproperties FOREIGN KEY (propertyid) REFERENCES odm2.extensionproperties(propertyid) ON DELETE RESTRICT;


--
-- Name: actionby fk_actionpeople_actions; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.actionby
    ADD CONSTRAINT fk_actionpeople_actions FOREIGN KEY (actionid) REFERENCES odm2.actions(actionid) ON DELETE RESTRICT;


--
-- Name: actionby fk_actionpeople_affiliations; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.actionby
    ADD CONSTRAINT fk_actionpeople_affiliations FOREIGN KEY (affiliationid) REFERENCES odm2.affiliations(affiliationid) ON DELETE RESTRICT;


--
-- Name: actions fk_actions_cv_actiontype; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.actions
    ADD CONSTRAINT fk_actions_cv_actiontype FOREIGN KEY (actiontypecv) REFERENCES odm2.cv_actiontype(name) ON DELETE RESTRICT;


--
-- Name: actions fk_actions_methods; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.actions
    ADD CONSTRAINT fk_actions_methods FOREIGN KEY (methodid) REFERENCES odm2.methods(methodid) ON DELETE RESTRICT;


--
-- Name: affiliations fk_affiliations_organizations; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.affiliations
    ADD CONSTRAINT fk_affiliations_organizations FOREIGN KEY (organizationid) REFERENCES odm2.organizations(organizationid) ON DELETE RESTRICT;


--
-- Name: affiliations fk_affiliations_people; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.affiliations
    ADD CONSTRAINT fk_affiliations_people FOREIGN KEY (personid) REFERENCES odm2.people(personid) ON DELETE RESTRICT;


--
-- Name: annotations fk_annotations_citations; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.annotations
    ADD CONSTRAINT fk_annotations_citations FOREIGN KEY (citationid) REFERENCES odm2.citations(citationid) ON DELETE RESTRICT;


--
-- Name: annotations fk_annotations_cv_annotationtype; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.annotations
    ADD CONSTRAINT fk_annotations_cv_annotationtype FOREIGN KEY (annotationtypecv) REFERENCES odm2.cv_annotationtype(name) ON DELETE RESTRICT;


--
-- Name: annotations fk_annotations_people; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.annotations
    ADD CONSTRAINT fk_annotations_people FOREIGN KEY (annotatorid) REFERENCES odm2.people(personid) ON DELETE RESTRICT;


--
-- Name: authorlists fk_authorlists_citations; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.authorlists
    ADD CONSTRAINT fk_authorlists_citations FOREIGN KEY (citationid) REFERENCES odm2.citations(citationid) ON DELETE RESTRICT;


--
-- Name: authorlists fk_authorlists_people; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.authorlists
    ADD CONSTRAINT fk_authorlists_people FOREIGN KEY (personid) REFERENCES odm2.people(personid) ON DELETE RESTRICT;


--
-- Name: calibrationactions fk_calibrationactions_actions; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.calibrationactions
    ADD CONSTRAINT fk_calibrationactions_actions FOREIGN KEY (actionid) REFERENCES odm2.actions(actionid) ON DELETE RESTRICT;


--
-- Name: calibrationactions fk_calibrationactions_instrumentoutputvariables; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.calibrationactions
    ADD CONSTRAINT fk_calibrationactions_instrumentoutputvariables FOREIGN KEY (instrumentoutputvariableid) REFERENCES odm2.instrumentoutputvariables(instrumentoutputvariableid) ON DELETE RESTRICT;


--
-- Name: calibrationreferenceequipment fk_calibrationreferenceequipment_calibrationactions; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.calibrationreferenceequipment
    ADD CONSTRAINT fk_calibrationreferenceequipment_calibrationactions FOREIGN KEY (actionid) REFERENCES odm2.calibrationactions(actionid) ON DELETE RESTRICT;


--
-- Name: calibrationreferenceequipment fk_calibrationreferenceequipment_equipment; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.calibrationreferenceequipment
    ADD CONSTRAINT fk_calibrationreferenceequipment_equipment FOREIGN KEY (equipmentid) REFERENCES odm2.equipment(equipmentid) ON DELETE RESTRICT;


--
-- Name: calibrationstandards fk_calibrationstandards_calibrationactions; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.calibrationstandards
    ADD CONSTRAINT fk_calibrationstandards_calibrationactions FOREIGN KEY (actionid) REFERENCES odm2.calibrationactions(actionid) ON DELETE RESTRICT;


--
-- Name: categoricalresults fk_categoricalresults_cv_qualitycode; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.categoricalresults
    ADD CONSTRAINT fk_categoricalresults_cv_qualitycode FOREIGN KEY (qualitycodecv) REFERENCES odm2.cv_qualitycode(name) ON DELETE RESTRICT;


--
-- Name: categoricalresults fk_categoricalresults_results; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.categoricalresults
    ADD CONSTRAINT fk_categoricalresults_results FOREIGN KEY (resultid) REFERENCES odm2.results(resultid) ON DELETE RESTRICT;


--
-- Name: categoricalresults fk_categoricalresults_spatialreferences; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.categoricalresults
    ADD CONSTRAINT fk_categoricalresults_spatialreferences FOREIGN KEY (spatialreferenceid) REFERENCES odm2.spatialreferences(spatialreferenceid) ON DELETE RESTRICT;


--
-- Name: categoricalresultvalueannotations fk_categoricalresultvalueannotations_annotations; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.categoricalresultvalueannotations
    ADD CONSTRAINT fk_categoricalresultvalueannotations_annotations FOREIGN KEY (annotationid) REFERENCES odm2.annotations(annotationid) ON DELETE RESTRICT;


--
-- Name: categoricalresultvalueannotations fk_categoricalresultvalueannotations_categoricalresultvalues; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.categoricalresultvalueannotations
    ADD CONSTRAINT fk_categoricalresultvalueannotations_categoricalresultvalues FOREIGN KEY (valueid) REFERENCES odm2.categoricalresultvalues(valueid) ON DELETE RESTRICT;


--
-- Name: categoricalresultvalues fk_categoricalresultvalues_categoricalresults; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.categoricalresultvalues
    ADD CONSTRAINT fk_categoricalresultvalues_categoricalresults FOREIGN KEY (resultid) REFERENCES odm2.categoricalresults(resultid) ON DELETE RESTRICT;


--
-- Name: citationextensionpropertyvalues fk_citationextensionpropertyvalues_citations; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.citationextensionpropertyvalues
    ADD CONSTRAINT fk_citationextensionpropertyvalues_citations FOREIGN KEY (citationid) REFERENCES odm2.citations(citationid) ON DELETE RESTRICT;


--
-- Name: citationextensionpropertyvalues fk_citationextensionpropertyvalues_extensionproperties; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.citationextensionpropertyvalues
    ADD CONSTRAINT fk_citationextensionpropertyvalues_extensionproperties FOREIGN KEY (propertyid) REFERENCES odm2.extensionproperties(propertyid) ON DELETE RESTRICT;


--
-- Name: citationexternalidentifiers fk_citationexternalidentifiers_citations; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.citationexternalidentifiers
    ADD CONSTRAINT fk_citationexternalidentifiers_citations FOREIGN KEY (citationid) REFERENCES odm2.citations(citationid) ON DELETE RESTRICT;


--
-- Name: citationexternalidentifiers fk_citationexternalidentifiers_externalidentifiersystems; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.citationexternalidentifiers
    ADD CONSTRAINT fk_citationexternalidentifiers_externalidentifiersystems FOREIGN KEY (externalidentifiersystemid) REFERENCES odm2.externalidentifiersystems(externalidentifiersystemid) ON DELETE RESTRICT;


--
-- Name: dataloggerfilecolumns fk_dataloggerfilecolumns_cv_aggregationstatistic; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.dataloggerfilecolumns
    ADD CONSTRAINT fk_dataloggerfilecolumns_cv_aggregationstatistic FOREIGN KEY (aggregationstatisticcv) REFERENCES odm2.cv_aggregationstatistic(name) ON DELETE RESTRICT;


--
-- Name: dataloggerfilecolumns fk_dataloggerfilecolumns_dataloggerfiles; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.dataloggerfilecolumns
    ADD CONSTRAINT fk_dataloggerfilecolumns_dataloggerfiles FOREIGN KEY (dataloggerfileid) REFERENCES odm2.dataloggerfiles(dataloggerfileid) ON DELETE RESTRICT;


--
-- Name: dataloggerfilecolumns fk_dataloggerfilecolumns_instrumentoutputvariables; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.dataloggerfilecolumns
    ADD CONSTRAINT fk_dataloggerfilecolumns_instrumentoutputvariables FOREIGN KEY (instrumentoutputvariableid) REFERENCES odm2.instrumentoutputvariables(instrumentoutputvariableid) ON DELETE RESTRICT;


--
-- Name: dataloggerfilecolumns fk_dataloggerfilecolumns_recordingunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.dataloggerfilecolumns
    ADD CONSTRAINT fk_dataloggerfilecolumns_recordingunits FOREIGN KEY (recordingintervalunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: dataloggerfilecolumns fk_dataloggerfilecolumns_results; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.dataloggerfilecolumns
    ADD CONSTRAINT fk_dataloggerfilecolumns_results FOREIGN KEY (resultid) REFERENCES odm2.results(resultid) ON DELETE RESTRICT;


--
-- Name: dataloggerfilecolumns fk_dataloggerfilecolumns_scanunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.dataloggerfilecolumns
    ADD CONSTRAINT fk_dataloggerfilecolumns_scanunits FOREIGN KEY (scanintervalunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: dataloggerfiles fk_dataloggerfiles_dataloggerprogramfiles; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.dataloggerfiles
    ADD CONSTRAINT fk_dataloggerfiles_dataloggerprogramfiles FOREIGN KEY (programid) REFERENCES odm2.dataloggerprogramfiles(programid) ON DELETE RESTRICT;


--
-- Name: dataloggerprogramfiles fk_dataloggerprogramfiles_affiliations; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.dataloggerprogramfiles
    ADD CONSTRAINT fk_dataloggerprogramfiles_affiliations FOREIGN KEY (affiliationid) REFERENCES odm2.affiliations(affiliationid) ON DELETE RESTRICT;


--
-- Name: dataquality fk_dataquality_cv_dataqualitytype; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.dataquality
    ADD CONSTRAINT fk_dataquality_cv_dataqualitytype FOREIGN KEY (dataqualitytypecv) REFERENCES odm2.cv_dataqualitytype(name) ON DELETE RESTRICT;


--
-- Name: dataquality fk_dataquality_units; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.dataquality
    ADD CONSTRAINT fk_dataquality_units FOREIGN KEY (dataqualityvalueunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: datasetcitations fk_datasetcitations_citations; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.datasetcitations
    ADD CONSTRAINT fk_datasetcitations_citations FOREIGN KEY (citationid) REFERENCES odm2.citations(citationid) ON DELETE RESTRICT;


--
-- Name: datasetcitations fk_datasetcitations_cv_relationshiptype; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.datasetcitations
    ADD CONSTRAINT fk_datasetcitations_cv_relationshiptype FOREIGN KEY (relationshiptypecv) REFERENCES odm2.cv_relationshiptype(name) ON DELETE RESTRICT;


--
-- Name: datasetcitations fk_datasetcitations_datasets; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.datasetcitations
    ADD CONSTRAINT fk_datasetcitations_datasets FOREIGN KEY (datasetid) REFERENCES odm2.datasets(datasetid) ON DELETE RESTRICT;


--
-- Name: datasets fk_datasets_cv_datasettypecv; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.datasets
    ADD CONSTRAINT fk_datasets_cv_datasettypecv FOREIGN KEY (datasettypecv) REFERENCES odm2.cv_datasettype(name) ON DELETE RESTRICT;


--
-- Name: datasetsresults fk_datasetsresults_datasets; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.datasetsresults
    ADD CONSTRAINT fk_datasetsresults_datasets FOREIGN KEY (datasetid) REFERENCES odm2.datasets(datasetid) ON DELETE RESTRICT;


--
-- Name: datasetsresults fk_datasetsresults_results; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.datasetsresults
    ADD CONSTRAINT fk_datasetsresults_results FOREIGN KEY (resultid) REFERENCES odm2.results(resultid) ON DELETE RESTRICT;


--
-- Name: directives fk_directives_cv_directivetype; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.directives
    ADD CONSTRAINT fk_directives_cv_directivetype FOREIGN KEY (directivetypecv) REFERENCES odm2.cv_directivetype(name) ON DELETE RESTRICT;


--
-- Name: equipment fk_equipment_cv_equipmenttype; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.equipment
    ADD CONSTRAINT fk_equipment_cv_equipmenttype FOREIGN KEY (equipmenttypecv) REFERENCES odm2.cv_equipmenttype(name) ON DELETE RESTRICT;


--
-- Name: equipment fk_equipment_equipmentmodels; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.equipment
    ADD CONSTRAINT fk_equipment_equipmentmodels FOREIGN KEY (equipmentmodelid) REFERENCES odm2.equipmentmodels(equipmentmodelid) ON DELETE RESTRICT;


--
-- Name: equipment fk_equipment_organizations; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.equipment
    ADD CONSTRAINT fk_equipment_organizations FOREIGN KEY (equipmentvendorid) REFERENCES odm2.organizations(organizationid) ON DELETE RESTRICT;


--
-- Name: equipment fk_equipment_people; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.equipment
    ADD CONSTRAINT fk_equipment_people FOREIGN KEY (equipmentownerid) REFERENCES odm2.people(personid) ON DELETE RESTRICT;


--
-- Name: equipmentused fk_equipmentactions_actions; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.equipmentused
    ADD CONSTRAINT fk_equipmentactions_actions FOREIGN KEY (actionid) REFERENCES odm2.actions(actionid) ON DELETE RESTRICT;


--
-- Name: equipmentused fk_equipmentactions_equipment; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.equipmentused
    ADD CONSTRAINT fk_equipmentactions_equipment FOREIGN KEY (equipmentid) REFERENCES odm2.equipment(equipmentid) ON DELETE RESTRICT;


--
-- Name: equipmentannotations fk_equipmentannotations_annotations; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.equipmentannotations
    ADD CONSTRAINT fk_equipmentannotations_annotations FOREIGN KEY (annotationid) REFERENCES odm2.annotations(annotationid) ON DELETE RESTRICT;


--
-- Name: equipmentannotations fk_equipmentannotations_equipment; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.equipmentannotations
    ADD CONSTRAINT fk_equipmentannotations_equipment FOREIGN KEY (equipmentid) REFERENCES odm2.equipment(equipmentid) ON DELETE RESTRICT;


--
-- Name: equipmentmodels fk_equipmentmodels_organizations; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.equipmentmodels
    ADD CONSTRAINT fk_equipmentmodels_organizations FOREIGN KEY (modelmanufacturerid) REFERENCES odm2.organizations(organizationid) ON DELETE RESTRICT;


--
-- Name: extensionproperties fk_extensionproperties_cv_propertydatatype; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.extensionproperties
    ADD CONSTRAINT fk_extensionproperties_cv_propertydatatype FOREIGN KEY (propertydatatypecv) REFERENCES odm2.cv_propertydatatype(name) ON DELETE RESTRICT;


--
-- Name: extensionproperties fk_extensionproperties_units; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.extensionproperties
    ADD CONSTRAINT fk_extensionproperties_units FOREIGN KEY (propertyunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: externalidentifiersystems fk_externalidentifiersystems_organizations; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.externalidentifiersystems
    ADD CONSTRAINT fk_externalidentifiersystems_organizations FOREIGN KEY (identifiersystemorganizationid) REFERENCES odm2.organizations(organizationid) ON DELETE RESTRICT;


--
-- Name: featureactions fk_featureactions_actions; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.featureactions
    ADD CONSTRAINT fk_featureactions_actions FOREIGN KEY (actionid) REFERENCES odm2.actions(actionid) ON DELETE RESTRICT;


--
-- Name: featureactions fk_featureactions_samplingfeatures; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.featureactions
    ADD CONSTRAINT fk_featureactions_samplingfeatures FOREIGN KEY (samplingfeatureid) REFERENCES odm2.samplingfeatures(samplingfeatureid) ON DELETE RESTRICT;


--
-- Name: relatedfeatures fk_featureparents_featuresparent; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedfeatures
    ADD CONSTRAINT fk_featureparents_featuresparent FOREIGN KEY (relatedfeatureid) REFERENCES odm2.samplingfeatures(samplingfeatureid) ON DELETE RESTRICT;


--
-- Name: relatedfeatures fk_featureparents_samplingfeatures; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedfeatures
    ADD CONSTRAINT fk_featureparents_samplingfeatures FOREIGN KEY (samplingfeatureid) REFERENCES odm2.samplingfeatures(samplingfeatureid) ON DELETE RESTRICT;


--
-- Name: relatedfeatures fk_featureparents_spatialoffsets; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedfeatures
    ADD CONSTRAINT fk_featureparents_spatialoffsets FOREIGN KEY (spatialoffsetid) REFERENCES odm2.spatialoffsets(spatialoffsetid) ON DELETE RESTRICT;


--
-- Name: calibrationstandards fk_fieldcalibrationstandards_referencematerials; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.calibrationstandards
    ADD CONSTRAINT fk_fieldcalibrationstandards_referencematerials FOREIGN KEY (referencematerialid) REFERENCES odm2.referencematerials(referencematerialid) ON DELETE RESTRICT;


--
-- Name: instrumentoutputvariables fk_instrumentoutputvariables_equipmentmodels; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.instrumentoutputvariables
    ADD CONSTRAINT fk_instrumentoutputvariables_equipmentmodels FOREIGN KEY (modelid) REFERENCES odm2.equipmentmodels(equipmentmodelid) ON DELETE RESTRICT;


--
-- Name: instrumentoutputvariables fk_instrumentoutputvariables_methods; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.instrumentoutputvariables
    ADD CONSTRAINT fk_instrumentoutputvariables_methods FOREIGN KEY (instrumentmethodid) REFERENCES odm2.methods(methodid) ON DELETE RESTRICT;


--
-- Name: instrumentoutputvariables fk_instrumentoutputvariables_units; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.instrumentoutputvariables
    ADD CONSTRAINT fk_instrumentoutputvariables_units FOREIGN KEY (instrumentrawoutputunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: instrumentoutputvariables fk_instrumentoutputvariables_variables; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.instrumentoutputvariables
    ADD CONSTRAINT fk_instrumentoutputvariables_variables FOREIGN KEY (variableid) REFERENCES odm2.variables(variableid) ON DELETE RESTRICT;


--
-- Name: maintenanceactions fk_maintenanceactions_actions; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.maintenanceactions
    ADD CONSTRAINT fk_maintenanceactions_actions FOREIGN KEY (actionid) REFERENCES odm2.actions(actionid) ON DELETE RESTRICT;


--
-- Name: measurementresults fk_measurementresults_aiunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.measurementresults
    ADD CONSTRAINT fk_measurementresults_aiunits FOREIGN KEY (timeaggregationintervalunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: measurementresults fk_measurementresults_cv_aggregationstatistic; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.measurementresults
    ADD CONSTRAINT fk_measurementresults_cv_aggregationstatistic FOREIGN KEY (aggregationstatisticcv) REFERENCES odm2.cv_aggregationstatistic(name) ON DELETE RESTRICT;


--
-- Name: measurementresults fk_measurementresults_cv_censorcode; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.measurementresults
    ADD CONSTRAINT fk_measurementresults_cv_censorcode FOREIGN KEY (censorcodecv) REFERENCES odm2.cv_censorcode(name) ON DELETE RESTRICT;


--
-- Name: measurementresults fk_measurementresults_cv_qualitycode; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.measurementresults
    ADD CONSTRAINT fk_measurementresults_cv_qualitycode FOREIGN KEY (qualitycodecv) REFERENCES odm2.cv_qualitycode(name) ON DELETE RESTRICT;


--
-- Name: measurementresults fk_measurementresults_results; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.measurementresults
    ADD CONSTRAINT fk_measurementresults_results FOREIGN KEY (resultid) REFERENCES odm2.results(resultid) ON DELETE RESTRICT;


--
-- Name: measurementresults fk_measurementresults_spatialreferences; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.measurementresults
    ADD CONSTRAINT fk_measurementresults_spatialreferences FOREIGN KEY (spatialreferenceid) REFERENCES odm2.spatialreferences(spatialreferenceid) ON DELETE RESTRICT;


--
-- Name: measurementresults fk_measurementresults_xunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.measurementresults
    ADD CONSTRAINT fk_measurementresults_xunits FOREIGN KEY (xlocationunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: measurementresults fk_measurementresults_yunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.measurementresults
    ADD CONSTRAINT fk_measurementresults_yunits FOREIGN KEY (ylocationunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: measurementresults fk_measurementresults_zunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.measurementresults
    ADD CONSTRAINT fk_measurementresults_zunits FOREIGN KEY (zlocationunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: measurementresultvalueannotations fk_measurementresultvalueannotations_measurementresultvalues; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.measurementresultvalueannotations
    ADD CONSTRAINT fk_measurementresultvalueannotations_measurementresultvalues FOREIGN KEY (valueid) REFERENCES odm2.measurementresultvalues(valueid) ON DELETE RESTRICT;


--
-- Name: measurementresultvalues fk_measurementresultvalues_measurementresults; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.measurementresultvalues
    ADD CONSTRAINT fk_measurementresultvalues_measurementresults FOREIGN KEY (resultid) REFERENCES odm2.measurementresults(resultid) ON DELETE RESTRICT;


--
-- Name: methodannotations fk_methodannotations_annotations; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.methodannotations
    ADD CONSTRAINT fk_methodannotations_annotations FOREIGN KEY (annotationid) REFERENCES odm2.annotations(annotationid) ON DELETE RESTRICT;


--
-- Name: methodannotations fk_methodannotations_methods; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.methodannotations
    ADD CONSTRAINT fk_methodannotations_methods FOREIGN KEY (methodid) REFERENCES odm2.methods(methodid) ON DELETE RESTRICT;


--
-- Name: methodcitations fk_methodcitations_citations; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.methodcitations
    ADD CONSTRAINT fk_methodcitations_citations FOREIGN KEY (citationid) REFERENCES odm2.citations(citationid) ON DELETE RESTRICT;


--
-- Name: methodcitations fk_methodcitations_cv_relationshiptype; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.methodcitations
    ADD CONSTRAINT fk_methodcitations_cv_relationshiptype FOREIGN KEY (relationshiptypecv) REFERENCES odm2.cv_relationshiptype(name) ON DELETE RESTRICT;


--
-- Name: methodcitations fk_methodcitations_methods; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.methodcitations
    ADD CONSTRAINT fk_methodcitations_methods FOREIGN KEY (methodid) REFERENCES odm2.methods(methodid) ON DELETE RESTRICT;


--
-- Name: methodextensionpropertyvalues fk_methodextensionpropertyvalues_extensionproperties; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.methodextensionpropertyvalues
    ADD CONSTRAINT fk_methodextensionpropertyvalues_extensionproperties FOREIGN KEY (propertyid) REFERENCES odm2.extensionproperties(propertyid) ON DELETE RESTRICT;


--
-- Name: methodextensionpropertyvalues fk_methodextensionpropertyvalues_methods; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.methodextensionpropertyvalues
    ADD CONSTRAINT fk_methodextensionpropertyvalues_methods FOREIGN KEY (methodid) REFERENCES odm2.methods(methodid) ON DELETE RESTRICT;


--
-- Name: methodexternalidentifiers fk_methodexternalidentifiers_externalidentifiersystems; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.methodexternalidentifiers
    ADD CONSTRAINT fk_methodexternalidentifiers_externalidentifiersystems FOREIGN KEY (externalidentifiersystemid) REFERENCES odm2.externalidentifiersystems(externalidentifiersystemid) ON DELETE RESTRICT;


--
-- Name: methodexternalidentifiers fk_methodexternalidentifiers_methods; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.methodexternalidentifiers
    ADD CONSTRAINT fk_methodexternalidentifiers_methods FOREIGN KEY (methodid) REFERENCES odm2.methods(methodid) ON DELETE RESTRICT;


--
-- Name: methods fk_methods_cv_methodtype; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.methods
    ADD CONSTRAINT fk_methods_cv_methodtype FOREIGN KEY (methodtypecv) REFERENCES odm2.cv_methodtype(name) ON DELETE RESTRICT;


--
-- Name: methods fk_methods_organizations; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.methods
    ADD CONSTRAINT fk_methods_organizations FOREIGN KEY (organizationid) REFERENCES odm2.organizations(organizationid) ON DELETE RESTRICT;


--
-- Name: modelaffiliations fk_modelaffiliations_affiliations; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.modelaffiliations
    ADD CONSTRAINT fk_modelaffiliations_affiliations FOREIGN KEY (affiliationid) REFERENCES odm2.affiliations(affiliationid) ON DELETE RESTRICT;


--
-- Name: modelaffiliations fk_modelaffiliations_models; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.modelaffiliations
    ADD CONSTRAINT fk_modelaffiliations_models FOREIGN KEY (modelid) REFERENCES odm2.models(modelid) ON DELETE RESTRICT;


--
-- Name: organizations fk_organizations_cv_organizationtype; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.organizations
    ADD CONSTRAINT fk_organizations_cv_organizationtype FOREIGN KEY (organizationtypecv) REFERENCES odm2.cv_organizationtype(name) ON DELETE RESTRICT;


--
-- Name: organizations fk_organizations_organizations; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.organizations
    ADD CONSTRAINT fk_organizations_organizations FOREIGN KEY (parentorganizationid) REFERENCES odm2.organizations(organizationid) ON DELETE RESTRICT;


--
-- Name: taxonomicclassifiers fk_parenttaxon_taxon; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.taxonomicclassifiers
    ADD CONSTRAINT fk_parenttaxon_taxon FOREIGN KEY (parenttaxonomicclassifierid) REFERENCES odm2.taxonomicclassifiers(taxonomicclassifierid) ON DELETE RESTRICT;


--
-- Name: personexternalidentifiers fk_personexternalidentifiers_externalidentifiersystems; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.personexternalidentifiers
    ADD CONSTRAINT fk_personexternalidentifiers_externalidentifiersystems FOREIGN KEY (externalidentifiersystemid) REFERENCES odm2.externalidentifiersystems(externalidentifiersystemid) ON DELETE RESTRICT;


--
-- Name: personexternalidentifiers fk_personexternalidentifiers_people; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.personexternalidentifiers
    ADD CONSTRAINT fk_personexternalidentifiers_people FOREIGN KEY (personid) REFERENCES odm2.people(personid) ON DELETE RESTRICT;


--
-- Name: pointcoverageresults fk_pointcoverageresults_cv_aggregationstatistic; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.pointcoverageresults
    ADD CONSTRAINT fk_pointcoverageresults_cv_aggregationstatistic FOREIGN KEY (aggregationstatisticcv) REFERENCES odm2.cv_aggregationstatistic(name) ON DELETE RESTRICT;


--
-- Name: pointcoverageresults fk_pointcoverageresults_results; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.pointcoverageresults
    ADD CONSTRAINT fk_pointcoverageresults_results FOREIGN KEY (resultid) REFERENCES odm2.results(resultid) ON DELETE RESTRICT;


--
-- Name: pointcoverageresults fk_pointcoverageresults_spatialreferences; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.pointcoverageresults
    ADD CONSTRAINT fk_pointcoverageresults_spatialreferences FOREIGN KEY (spatialreferenceid) REFERENCES odm2.spatialreferences(spatialreferenceid) ON DELETE RESTRICT;


--
-- Name: pointcoverageresults fk_pointcoverageresults_xunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.pointcoverageresults
    ADD CONSTRAINT fk_pointcoverageresults_xunits FOREIGN KEY (intendedxspacingunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: pointcoverageresults fk_pointcoverageresults_yunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.pointcoverageresults
    ADD CONSTRAINT fk_pointcoverageresults_yunits FOREIGN KEY (intendedyspacingunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: pointcoverageresults fk_pointcoverageresults_zunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.pointcoverageresults
    ADD CONSTRAINT fk_pointcoverageresults_zunits FOREIGN KEY (zlocationunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: pointcoverageresultvalueannotations fk_pointcoverageresultvalueannotations_annotations; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.pointcoverageresultvalueannotations
    ADD CONSTRAINT fk_pointcoverageresultvalueannotations_annotations FOREIGN KEY (annotationid) REFERENCES odm2.annotations(annotationid) ON DELETE RESTRICT;


--
-- Name: pointcoverageresultvalueannotations fk_pointcoverageresultvalueannotations_pointcoverageresultvalue; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.pointcoverageresultvalueannotations
    ADD CONSTRAINT fk_pointcoverageresultvalueannotations_pointcoverageresultvalue FOREIGN KEY (valueid) REFERENCES odm2.pointcoverageresultvalues(valueid) ON DELETE RESTRICT;


--
-- Name: pointcoverageresultvalues fk_pointcoverageresultvalues_cv_censorcode; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.pointcoverageresultvalues
    ADD CONSTRAINT fk_pointcoverageresultvalues_cv_censorcode FOREIGN KEY (censorcodecv) REFERENCES odm2.cv_censorcode(name) ON DELETE RESTRICT;


--
-- Name: pointcoverageresultvalues fk_pointcoverageresultvalues_cv_qualitycode; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.pointcoverageresultvalues
    ADD CONSTRAINT fk_pointcoverageresultvalues_cv_qualitycode FOREIGN KEY (qualitycodecv) REFERENCES odm2.cv_qualitycode(name) ON DELETE RESTRICT;


--
-- Name: pointcoverageresultvalues fk_pointcoverageresultvalues_pointcoverageresults; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.pointcoverageresultvalues
    ADD CONSTRAINT fk_pointcoverageresultvalues_pointcoverageresults FOREIGN KEY (resultid) REFERENCES odm2.pointcoverageresults(resultid) ON DELETE RESTRICT;


--
-- Name: pointcoverageresultvalues fk_pointcoverageresultvalues_xunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.pointcoverageresultvalues
    ADD CONSTRAINT fk_pointcoverageresultvalues_xunits FOREIGN KEY (xlocationunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: pointcoverageresultvalues fk_pointcoverageresultvalues_yunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.pointcoverageresultvalues
    ADD CONSTRAINT fk_pointcoverageresultvalues_yunits FOREIGN KEY (ylocationunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: profileresults fk_profileresults_cv_aggregationstatistic; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.profileresults
    ADD CONSTRAINT fk_profileresults_cv_aggregationstatistic FOREIGN KEY (aggregationstatisticcv) REFERENCES odm2.cv_aggregationstatistic(name) ON DELETE RESTRICT;


--
-- Name: profileresults fk_profileresults_dunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.profileresults
    ADD CONSTRAINT fk_profileresults_dunits FOREIGN KEY (intendedzspacingunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: profileresults fk_profileresults_results; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.profileresults
    ADD CONSTRAINT fk_profileresults_results FOREIGN KEY (resultid) REFERENCES odm2.results(resultid) ON DELETE RESTRICT;


--
-- Name: profileresults fk_profileresults_spatialreferences; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.profileresults
    ADD CONSTRAINT fk_profileresults_spatialreferences FOREIGN KEY (spatialreferenceid) REFERENCES odm2.spatialreferences(spatialreferenceid) ON DELETE RESTRICT;


--
-- Name: profileresults fk_profileresults_tunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.profileresults
    ADD CONSTRAINT fk_profileresults_tunits FOREIGN KEY (intendedtimespacingunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: profileresults fk_profileresults_xunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.profileresults
    ADD CONSTRAINT fk_profileresults_xunits FOREIGN KEY (xlocationunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: profileresults fk_profileresults_yunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.profileresults
    ADD CONSTRAINT fk_profileresults_yunits FOREIGN KEY (ylocationunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: profileresultvalueannotations fk_profileresultvalueannotations_annotations; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.profileresultvalueannotations
    ADD CONSTRAINT fk_profileresultvalueannotations_annotations FOREIGN KEY (annotationid) REFERENCES odm2.annotations(annotationid) ON DELETE RESTRICT;


--
-- Name: profileresultvalueannotations fk_profileresultvalueannotations_profileresultvalues; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.profileresultvalueannotations
    ADD CONSTRAINT fk_profileresultvalueannotations_profileresultvalues FOREIGN KEY (valueid) REFERENCES odm2.profileresultvalues(valueid) ON DELETE RESTRICT;


--
-- Name: profileresultvalues fk_profileresultvalues_aiunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.profileresultvalues
    ADD CONSTRAINT fk_profileresultvalues_aiunits FOREIGN KEY (timeaggregationintervalunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: profileresultvalues fk_profileresultvalues_cv_censorcode; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.profileresultvalues
    ADD CONSTRAINT fk_profileresultvalues_cv_censorcode FOREIGN KEY (censorcodecv) REFERENCES odm2.cv_censorcode(name) ON DELETE RESTRICT;


--
-- Name: profileresultvalues fk_profileresultvalues_cv_qualitycode; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.profileresultvalues
    ADD CONSTRAINT fk_profileresultvalues_cv_qualitycode FOREIGN KEY (qualitycodecv) REFERENCES odm2.cv_qualitycode(name) ON DELETE RESTRICT;


--
-- Name: profileresultvalues fk_profileresultvalues_dunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.profileresultvalues
    ADD CONSTRAINT fk_profileresultvalues_dunits FOREIGN KEY (zlocationunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: profileresultvalues fk_profileresultvalues_profileresults; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.profileresultvalues
    ADD CONSTRAINT fk_profileresultvalues_profileresults FOREIGN KEY (resultid) REFERENCES odm2.profileresults(resultid) ON DELETE RESTRICT;


--
-- Name: projectexternalidentifiers fk_projectexternalidentifiers_externalidentifiersystems; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.projectexternalidentifiers
    ADD CONSTRAINT fk_projectexternalidentifiers_externalidentifiersystems FOREIGN KEY (externalidentifiersystemid) REFERENCES odm2.externalidentifiersystems(externalidentifiersystemid) ON DELETE RESTRICT;


--
-- Name: projectexternalidentifiers fk_projectexternalidentifiers_projects; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.projectexternalidentifiers
    ADD CONSTRAINT fk_projectexternalidentifiers_projects FOREIGN KEY (projectid) REFERENCES odm2.projects(projectid) ON DELETE RESTRICT;


--
-- Name: projectstationexternalidentifiers fk_projectstationexternalidentifiers_externalidentifiersystems; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.projectstationexternalidentifiers
    ADD CONSTRAINT fk_projectstationexternalidentifiers_externalidentifiersystems FOREIGN KEY (externalidentifiersystemid) REFERENCES odm2.externalidentifiersystems(externalidentifiersystemid) ON DELETE RESTRICT;


--
-- Name: projectstationexternalidentifiers fk_projectstationexternalidentifiers_projectstations; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.projectstationexternalidentifiers
    ADD CONSTRAINT fk_projectstationexternalidentifiers_projectstations FOREIGN KEY (projectstationid) REFERENCES odm2.projectstations(projectstationid) ON DELETE RESTRICT;


--
-- Name: projectstations fk_projectstations_projects; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.projectstations
    ADD CONSTRAINT fk_projectstations_projects FOREIGN KEY (projectid) REFERENCES odm2.projects(projectid) ON DELETE RESTRICT;


--
-- Name: projectstations fk_projectstations_samplingfeatures; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.projectstations
    ADD CONSTRAINT fk_projectstations_samplingfeatures FOREIGN KEY (samplingfeatureid) REFERENCES odm2.samplingfeatures(samplingfeatureid) ON DELETE RESTRICT;


--
-- Name: referencematerials fk_referencematerials_cv_medium; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.referencematerials
    ADD CONSTRAINT fk_referencematerials_cv_medium FOREIGN KEY (referencematerialmediumcv) REFERENCES odm2.cv_medium(name) ON DELETE RESTRICT;


--
-- Name: referencematerials fk_referencematerials_organizations; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.referencematerials
    ADD CONSTRAINT fk_referencematerials_organizations FOREIGN KEY (referencematerialorganizationid) REFERENCES odm2.organizations(organizationid) ON DELETE RESTRICT;


--
-- Name: referencematerials fk_referencematerials_samplingfeatures; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.referencematerials
    ADD CONSTRAINT fk_referencematerials_samplingfeatures FOREIGN KEY (samplingfeatureid) REFERENCES odm2.samplingfeatures(samplingfeatureid) ON DELETE RESTRICT;


--
-- Name: referencematerialvalues fk_referencematerialvalues_citations; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.referencematerialvalues
    ADD CONSTRAINT fk_referencematerialvalues_citations FOREIGN KEY (citationid) REFERENCES odm2.citations(citationid) ON DELETE RESTRICT;


--
-- Name: referencematerialvalues fk_referencematerialvalues_referencematerials; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.referencematerialvalues
    ADD CONSTRAINT fk_referencematerialvalues_referencematerials FOREIGN KEY (referencematerialid) REFERENCES odm2.referencematerials(referencematerialid) ON DELETE RESTRICT;


--
-- Name: referencematerialvalues fk_referencematerialvalues_units; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.referencematerialvalues
    ADD CONSTRAINT fk_referencematerialvalues_units FOREIGN KEY (unitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: referencematerialvalues fk_referencematerialvalues_variables; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.referencematerialvalues
    ADD CONSTRAINT fk_referencematerialvalues_variables FOREIGN KEY (variableid) REFERENCES odm2.variables(variableid) ON DELETE RESTRICT;


--
-- Name: referencematerialexternalidentifiers fk_refmaterialextidentifiers_extidentifiersystems; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.referencematerialexternalidentifiers
    ADD CONSTRAINT fk_refmaterialextidentifiers_extidentifiersystems FOREIGN KEY (externalidentifiersystemid) REFERENCES odm2.externalidentifiersystems(externalidentifiersystemid) ON DELETE RESTRICT;


--
-- Name: referencematerialexternalidentifiers fk_refmaterialextidentifiers_refmaterials; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.referencematerialexternalidentifiers
    ADD CONSTRAINT fk_refmaterialextidentifiers_refmaterials FOREIGN KEY (referencematerialid) REFERENCES odm2.referencematerials(referencematerialid) ON DELETE RESTRICT;


--
-- Name: relatedactions fk_relatedactions_actions; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedactions
    ADD CONSTRAINT fk_relatedactions_actions FOREIGN KEY (actionid) REFERENCES odm2.actions(actionid) ON DELETE RESTRICT;


--
-- Name: relatedactions fk_relatedactions_actions_arerelated; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedactions
    ADD CONSTRAINT fk_relatedactions_actions_arerelated FOREIGN KEY (relatedactionid) REFERENCES odm2.actions(actionid) ON DELETE RESTRICT;


--
-- Name: relatedactions fk_relatedactions_cv_relationshiptype; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedactions
    ADD CONSTRAINT fk_relatedactions_cv_relationshiptype FOREIGN KEY (relationshiptypecv) REFERENCES odm2.cv_relationshiptype(name) ON DELETE RESTRICT;


--
-- Name: relatedannotations fk_relatedannotations_annotations; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedannotations
    ADD CONSTRAINT fk_relatedannotations_annotations FOREIGN KEY (annotationid) REFERENCES odm2.annotations(annotationid) ON DELETE RESTRICT;


--
-- Name: relatedannotations fk_relatedannotations_annotations_arerelated; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedannotations
    ADD CONSTRAINT fk_relatedannotations_annotations_arerelated FOREIGN KEY (relatedannotationid) REFERENCES odm2.annotations(annotationid) ON DELETE RESTRICT;


--
-- Name: relatedannotations fk_relatedannotations_cv_relationshiptype; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedannotations
    ADD CONSTRAINT fk_relatedannotations_cv_relationshiptype FOREIGN KEY (relationshiptypecv) REFERENCES odm2.cv_relationshiptype(name) ON DELETE RESTRICT;


--
-- Name: relatedcitations fk_relatedcitations_citations; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedcitations
    ADD CONSTRAINT fk_relatedcitations_citations FOREIGN KEY (citationid) REFERENCES odm2.citations(citationid) ON DELETE RESTRICT;


--
-- Name: relatedcitations fk_relatedcitations_citations_arerelated; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedcitations
    ADD CONSTRAINT fk_relatedcitations_citations_arerelated FOREIGN KEY (relatedcitationid) REFERENCES odm2.citations(citationid) ON DELETE RESTRICT;


--
-- Name: relatedcitations fk_relatedcitations_cv_relationshiptype; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedcitations
    ADD CONSTRAINT fk_relatedcitations_cv_relationshiptype FOREIGN KEY (relationshiptypecv) REFERENCES odm2.cv_relationshiptype(name) ON DELETE RESTRICT;


--
-- Name: relateddatasets fk_relateddatasets_cv_relationshiptype; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relateddatasets
    ADD CONSTRAINT fk_relateddatasets_cv_relationshiptype FOREIGN KEY (relationshiptypecv) REFERENCES odm2.cv_relationshiptype(name) ON DELETE RESTRICT;


--
-- Name: relateddatasets fk_relateddatasets_datasets; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relateddatasets
    ADD CONSTRAINT fk_relateddatasets_datasets FOREIGN KEY (datasetid) REFERENCES odm2.datasets(datasetid) ON DELETE RESTRICT;


--
-- Name: relateddatasets fk_relateddatasets_datasets_arerelated; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relateddatasets
    ADD CONSTRAINT fk_relateddatasets_datasets_arerelated FOREIGN KEY (relateddatasetid) REFERENCES odm2.datasets(datasetid) ON DELETE RESTRICT;


--
-- Name: relatedequipment fk_relatedequipment_cv_relationshiptype; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedequipment
    ADD CONSTRAINT fk_relatedequipment_cv_relationshiptype FOREIGN KEY (relationshiptypecv) REFERENCES odm2.cv_relationshiptype(name) ON DELETE RESTRICT;


--
-- Name: relatedequipment fk_relatedequipment_equipment; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedequipment
    ADD CONSTRAINT fk_relatedequipment_equipment FOREIGN KEY (equipmentid) REFERENCES odm2.equipment(equipmentid) ON DELETE RESTRICT;


--
-- Name: relatedequipment fk_relatedequipment_equipment_arerelated; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedequipment
    ADD CONSTRAINT fk_relatedequipment_equipment_arerelated FOREIGN KEY (relatedequipmentid) REFERENCES odm2.equipment(equipmentid) ON DELETE RESTRICT;


--
-- Name: relatedfeatures fk_relatedfeatures_cv_relationshiptype; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedfeatures
    ADD CONSTRAINT fk_relatedfeatures_cv_relationshiptype FOREIGN KEY (relationshiptypecv) REFERENCES odm2.cv_relationshiptype(name) ON DELETE RESTRICT;


--
-- Name: relatedmodels fk_relatedmodels_cv_relationshiptype; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedmodels
    ADD CONSTRAINT fk_relatedmodels_cv_relationshiptype FOREIGN KEY (relationshiptypecv) REFERENCES odm2.cv_relationshiptype(name) ON DELETE RESTRICT;


--
-- Name: relatedmodels fk_relatedmodels_models; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedmodels
    ADD CONSTRAINT fk_relatedmodels_models FOREIGN KEY (modelid) REFERENCES odm2.models(modelid) ON DELETE RESTRICT;


--
-- Name: relatedresults fk_relatedresults_cv_relationshiptype; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedresults
    ADD CONSTRAINT fk_relatedresults_cv_relationshiptype FOREIGN KEY (relationshiptypecv) REFERENCES odm2.cv_relationshiptype(name) ON DELETE RESTRICT;


--
-- Name: relatedresults fk_relatedresults_results; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedresults
    ADD CONSTRAINT fk_relatedresults_results FOREIGN KEY (resultid) REFERENCES odm2.results(resultid) ON DELETE RESTRICT;


--
-- Name: relatedresults fk_relatedresults_results_arerelated; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedresults
    ADD CONSTRAINT fk_relatedresults_results_arerelated FOREIGN KEY (relatedresultid) REFERENCES odm2.results(resultid) ON DELETE RESTRICT;


--
-- Name: relatedtaxonomicclassifiers fk_relatedtaxonomicclassifiers_cv_relationshiptype; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedtaxonomicclassifiers
    ADD CONSTRAINT fk_relatedtaxonomicclassifiers_cv_relationshiptype FOREIGN KEY (relationshiptypecv) REFERENCES odm2.cv_relationshiptype(name) ON DELETE RESTRICT;


--
-- Name: relatedtaxonomicclassifiers fk_relatedtaxonomicclassifiers_taxonomicclassifiers; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedtaxonomicclassifiers
    ADD CONSTRAINT fk_relatedtaxonomicclassifiers_taxonomicclassifiers FOREIGN KEY (taxonomicclassifierid) REFERENCES odm2.taxonomicclassifiers(taxonomicclassifierid) ON DELETE RESTRICT;


--
-- Name: relatedtaxonomicclassifiers fk_relatedtaxonomicclassifiers_taxonomicclassifiers_arerelated; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.relatedtaxonomicclassifiers
    ADD CONSTRAINT fk_relatedtaxonomicclassifiers_taxonomicclassifiers_arerelated FOREIGN KEY (relatedtaxonomicclassifierid) REFERENCES odm2.taxonomicclassifiers(taxonomicclassifierid) ON DELETE RESTRICT;


--
-- Name: resultannotations fk_resultannotations_annotations; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.resultannotations
    ADD CONSTRAINT fk_resultannotations_annotations FOREIGN KEY (annotationid) REFERENCES odm2.annotations(annotationid) ON DELETE RESTRICT;


--
-- Name: resultannotations fk_resultannotations_results; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.resultannotations
    ADD CONSTRAINT fk_resultannotations_results FOREIGN KEY (resultid) REFERENCES odm2.results(resultid) ON DELETE RESTRICT;


--
-- Name: resultderivationequations fk_resultderivationequations_derivationequations; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.resultderivationequations
    ADD CONSTRAINT fk_resultderivationequations_derivationequations FOREIGN KEY (derivationequationid) REFERENCES odm2.derivationequations(derivationequationid) ON DELETE RESTRICT;


--
-- Name: resultderivationequations fk_resultderivationequations_results; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.resultderivationequations
    ADD CONSTRAINT fk_resultderivationequations_results FOREIGN KEY (resultid) REFERENCES odm2.results(resultid) ON DELETE RESTRICT;


--
-- Name: resultextensionpropertyvalues fk_resultextensionpropertyvalues_extensionproperties; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.resultextensionpropertyvalues
    ADD CONSTRAINT fk_resultextensionpropertyvalues_extensionproperties FOREIGN KEY (propertyid) REFERENCES odm2.extensionproperties(propertyid) ON DELETE RESTRICT;


--
-- Name: resultextensionpropertyvalues fk_resultextensionpropertyvalues_results; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.resultextensionpropertyvalues
    ADD CONSTRAINT fk_resultextensionpropertyvalues_results FOREIGN KEY (resultid) REFERENCES odm2.results(resultid) ON DELETE RESTRICT;


--
-- Name: resultnormalizationvalues fk_resultnormalizationvalues_referencematerialvalues; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.resultnormalizationvalues
    ADD CONSTRAINT fk_resultnormalizationvalues_referencematerialvalues FOREIGN KEY (normalizedbyreferencematerialvalueid) REFERENCES odm2.referencematerialvalues(referencematerialvalueid) ON DELETE RESTRICT;


--
-- Name: resultnormalizationvalues fk_resultnormalizationvalues_results; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.resultnormalizationvalues
    ADD CONSTRAINT fk_resultnormalizationvalues_results FOREIGN KEY (resultid) REFERENCES odm2.results(resultid) ON DELETE RESTRICT;


--
-- Name: results fk_results_cv_medium; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.results
    ADD CONSTRAINT fk_results_cv_medium FOREIGN KEY (sampledmediumcv) REFERENCES odm2.cv_medium(name) ON DELETE RESTRICT;


--
-- Name: results fk_results_cv_resulttype; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.results
    ADD CONSTRAINT fk_results_cv_resulttype FOREIGN KEY (resulttypecv) REFERENCES odm2.cv_resulttype(name) ON DELETE RESTRICT;


--
-- Name: results fk_results_cv_status; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.results
    ADD CONSTRAINT fk_results_cv_status FOREIGN KEY (statuscv) REFERENCES odm2.cv_status(name) ON DELETE RESTRICT;


--
-- Name: results fk_results_featureactions; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.results
    ADD CONSTRAINT fk_results_featureactions FOREIGN KEY (featureactionid) REFERENCES odm2.featureactions(featureactionid) ON DELETE RESTRICT;


--
-- Name: results fk_results_processinglevels; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.results
    ADD CONSTRAINT fk_results_processinglevels FOREIGN KEY (processinglevelid) REFERENCES odm2.processinglevels(processinglevelid) ON DELETE RESTRICT;


--
-- Name: results fk_results_taxonomicclassifiers; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.results
    ADD CONSTRAINT fk_results_taxonomicclassifiers FOREIGN KEY (taxonomicclassifierid) REFERENCES odm2.taxonomicclassifiers(taxonomicclassifierid) ON DELETE RESTRICT;


--
-- Name: results fk_results_units; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.results
    ADD CONSTRAINT fk_results_units FOREIGN KEY (unitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: results fk_results_variables; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.results
    ADD CONSTRAINT fk_results_variables FOREIGN KEY (variableid) REFERENCES odm2.variables(variableid) ON DELETE RESTRICT;


--
-- Name: resultsdataquality fk_resultsdataquality_dataquality; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.resultsdataquality
    ADD CONSTRAINT fk_resultsdataquality_dataquality FOREIGN KEY (dataqualityid) REFERENCES odm2.dataquality(dataqualityid) ON DELETE RESTRICT;


--
-- Name: resultsdataquality fk_resultsdataquality_results; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.resultsdataquality
    ADD CONSTRAINT fk_resultsdataquality_results FOREIGN KEY (resultid) REFERENCES odm2.results(resultid) ON DELETE RESTRICT;


--
-- Name: measurementresultvalueannotations fk_resultvalueannotations_annotations; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.measurementresultvalueannotations
    ADD CONSTRAINT fk_resultvalueannotations_annotations FOREIGN KEY (annotationid) REFERENCES odm2.annotations(annotationid) ON DELETE RESTRICT;


--
-- Name: samplingfeatureannotations fk_samplingfeatureannotations_annotations; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.samplingfeatureannotations
    ADD CONSTRAINT fk_samplingfeatureannotations_annotations FOREIGN KEY (annotationid) REFERENCES odm2.annotations(annotationid) ON DELETE RESTRICT;


--
-- Name: samplingfeatureannotations fk_samplingfeatureannotations_samplingfeatures; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.samplingfeatureannotations
    ADD CONSTRAINT fk_samplingfeatureannotations_samplingfeatures FOREIGN KEY (samplingfeatureid) REFERENCES odm2.samplingfeatures(samplingfeatureid) ON DELETE RESTRICT;


--
-- Name: samplingfeatureextensionpropertyvalues fk_samplingfeatureextensionpropertyvalues_extensionproperties; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.samplingfeatureextensionpropertyvalues
    ADD CONSTRAINT fk_samplingfeatureextensionpropertyvalues_extensionproperties FOREIGN KEY (propertyid) REFERENCES odm2.extensionproperties(propertyid) ON DELETE RESTRICT;


--
-- Name: samplingfeatureextensionpropertyvalues fk_samplingfeatureextensionpropertyvalues_samplingfeatures; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.samplingfeatureextensionpropertyvalues
    ADD CONSTRAINT fk_samplingfeatureextensionpropertyvalues_samplingfeatures FOREIGN KEY (samplingfeatureid) REFERENCES odm2.samplingfeatures(samplingfeatureid) ON DELETE RESTRICT;


--
-- Name: samplingfeatureexternalidentifiers fk_samplingfeatureexternalidentifiers_externalidentifiersystems; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.samplingfeatureexternalidentifiers
    ADD CONSTRAINT fk_samplingfeatureexternalidentifiers_externalidentifiersystems FOREIGN KEY (externalidentifiersystemid) REFERENCES odm2.externalidentifiersystems(externalidentifiersystemid) ON DELETE RESTRICT;


--
-- Name: samplingfeatureexternalidentifiers fk_samplingfeatureexternalidentifiers_samplingfeatures; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.samplingfeatureexternalidentifiers
    ADD CONSTRAINT fk_samplingfeatureexternalidentifiers_samplingfeatures FOREIGN KEY (samplingfeatureid) REFERENCES odm2.samplingfeatures(samplingfeatureid) ON DELETE RESTRICT;


--
-- Name: samplingfeatures fk_samplingfeatures_cv_elevationdatum; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.samplingfeatures
    ADD CONSTRAINT fk_samplingfeatures_cv_elevationdatum FOREIGN KEY (elevationdatumcv) REFERENCES odm2.cv_elevationdatum(name) ON DELETE RESTRICT;


--
-- Name: samplingfeatures fk_samplingfeatures_cv_samplingfeaturegeotype; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.samplingfeatures
    ADD CONSTRAINT fk_samplingfeatures_cv_samplingfeaturegeotype FOREIGN KEY (samplingfeaturegeotypecv) REFERENCES odm2.cv_samplingfeaturegeotype(name) ON DELETE RESTRICT;


--
-- Name: samplingfeatures fk_samplingfeatures_cv_samplingfeaturetype; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.samplingfeatures
    ADD CONSTRAINT fk_samplingfeatures_cv_samplingfeaturetype FOREIGN KEY (samplingfeaturetypecv) REFERENCES odm2.cv_samplingfeaturetype(name) ON DELETE RESTRICT;


--
-- Name: sectionresults fk_sectionresults_cv_aggregationstatistic; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.sectionresults
    ADD CONSTRAINT fk_sectionresults_cv_aggregationstatistic FOREIGN KEY (aggregationstatisticcv) REFERENCES odm2.cv_aggregationstatistic(name) ON DELETE RESTRICT;


--
-- Name: sectionresults fk_sectionresults_results; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.sectionresults
    ADD CONSTRAINT fk_sectionresults_results FOREIGN KEY (resultid) REFERENCES odm2.results(resultid) ON DELETE RESTRICT;


--
-- Name: sectionresults fk_sectionresults_spatialreferences; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.sectionresults
    ADD CONSTRAINT fk_sectionresults_spatialreferences FOREIGN KEY (spatialreferenceid) REFERENCES odm2.spatialreferences(spatialreferenceid) ON DELETE RESTRICT;


--
-- Name: sectionresults fk_sectionresults_tmunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.sectionresults
    ADD CONSTRAINT fk_sectionresults_tmunits FOREIGN KEY (intendedtimespacingunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: sectionresults fk_sectionresults_units; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.sectionresults
    ADD CONSTRAINT fk_sectionresults_units FOREIGN KEY (ylocationunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: sectionresults fk_sectionresults_xunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.sectionresults
    ADD CONSTRAINT fk_sectionresults_xunits FOREIGN KEY (intendedxspacingunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: sectionresults fk_sectionresults_zunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.sectionresults
    ADD CONSTRAINT fk_sectionresults_zunits FOREIGN KEY (intendedzspacingunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: sectionresultvalueannotations fk_sectionresultvalueannotations_annotations; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.sectionresultvalueannotations
    ADD CONSTRAINT fk_sectionresultvalueannotations_annotations FOREIGN KEY (annotationid) REFERENCES odm2.annotations(annotationid) ON DELETE RESTRICT;


--
-- Name: sectionresultvalueannotations fk_sectionresultvalueannotations_sectionresultvalues; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.sectionresultvalueannotations
    ADD CONSTRAINT fk_sectionresultvalueannotations_sectionresultvalues FOREIGN KEY (valueid) REFERENCES odm2.sectionresultvalues(valueid) ON DELETE RESTRICT;


--
-- Name: sectionresultvalues fk_sectionresultvalues_aiunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.sectionresultvalues
    ADD CONSTRAINT fk_sectionresultvalues_aiunits FOREIGN KEY (timeaggregationintervalunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: sectionresultvalues fk_sectionresultvalues_cv_aggregationstatistic; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.sectionresultvalues
    ADD CONSTRAINT fk_sectionresultvalues_cv_aggregationstatistic FOREIGN KEY (aggregationstatisticcv) REFERENCES odm2.cv_aggregationstatistic(name) ON DELETE RESTRICT;


--
-- Name: sectionresultvalues fk_sectionresultvalues_cv_censorcode; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.sectionresultvalues
    ADD CONSTRAINT fk_sectionresultvalues_cv_censorcode FOREIGN KEY (censorcodecv) REFERENCES odm2.cv_censorcode(name) ON DELETE RESTRICT;


--
-- Name: sectionresultvalues fk_sectionresultvalues_cv_qualitycode; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.sectionresultvalues
    ADD CONSTRAINT fk_sectionresultvalues_cv_qualitycode FOREIGN KEY (qualitycodecv) REFERENCES odm2.cv_qualitycode(name) ON DELETE RESTRICT;


--
-- Name: sectionresultvalues fk_sectionresultvalues_sectionresults; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.sectionresultvalues
    ADD CONSTRAINT fk_sectionresultvalues_sectionresults FOREIGN KEY (resultid) REFERENCES odm2.sectionresults(resultid) ON DELETE RESTRICT;


--
-- Name: sectionresultvalues fk_sectionresultvalues_xunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.sectionresultvalues
    ADD CONSTRAINT fk_sectionresultvalues_xunits FOREIGN KEY (xlocationunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: sectionresultvalues fk_sectionresultvalues_zunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.sectionresultvalues
    ADD CONSTRAINT fk_sectionresultvalues_zunits FOREIGN KEY (zlocationunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: simulations fk_simulations_actions; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.simulations
    ADD CONSTRAINT fk_simulations_actions FOREIGN KEY (actionid) REFERENCES odm2.actions(actionid) ON DELETE RESTRICT;


--
-- Name: simulations fk_simulations_models; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.simulations
    ADD CONSTRAINT fk_simulations_models FOREIGN KEY (modelid) REFERENCES odm2.models(modelid) ON DELETE RESTRICT;


--
-- Name: sites fk_sites_cv_sitetype; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.sites
    ADD CONSTRAINT fk_sites_cv_sitetype FOREIGN KEY (sitetypecv) REFERENCES odm2.cv_sitetype(name) ON DELETE RESTRICT;


--
-- Name: sites fk_sites_samplingfeatures; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.sites
    ADD CONSTRAINT fk_sites_samplingfeatures FOREIGN KEY (samplingfeatureid) REFERENCES odm2.samplingfeatures(samplingfeatureid) ON DELETE RESTRICT;


--
-- Name: sites fk_sites_spatialreferences; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.sites
    ADD CONSTRAINT fk_sites_spatialreferences FOREIGN KEY (spatialreferenceid) REFERENCES odm2.spatialreferences(spatialreferenceid) ON DELETE RESTRICT;


--
-- Name: spatialoffsets fk_spatialoffsets_cv_spatialoffsettype; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.spatialoffsets
    ADD CONSTRAINT fk_spatialoffsets_cv_spatialoffsettype FOREIGN KEY (spatialoffsettypecv) REFERENCES odm2.cv_spatialoffsettype(name) ON DELETE RESTRICT;


--
-- Name: spatialoffsets fk_spatialoffsets_offset1units; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.spatialoffsets
    ADD CONSTRAINT fk_spatialoffsets_offset1units FOREIGN KEY (offset1unitid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: spatialoffsets fk_spatialoffsets_offset2units; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.spatialoffsets
    ADD CONSTRAINT fk_spatialoffsets_offset2units FOREIGN KEY (offset2unitid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: spatialoffsets fk_spatialoffsets_offset3units; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.spatialoffsets
    ADD CONSTRAINT fk_spatialoffsets_offset3units FOREIGN KEY (offset3unitid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: spatialreferenceexternalidentifiers fk_spatialreferenceexternalidentifiers_externalidentifiersystem; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.spatialreferenceexternalidentifiers
    ADD CONSTRAINT fk_spatialreferenceexternalidentifiers_externalidentifiersystem FOREIGN KEY (externalidentifiersystemid) REFERENCES odm2.externalidentifiersystems(externalidentifiersystemid) ON DELETE RESTRICT;


--
-- Name: spatialreferenceexternalidentifiers fk_spatialreferenceexternalidentifiers_spatialreferences; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.spatialreferenceexternalidentifiers
    ADD CONSTRAINT fk_spatialreferenceexternalidentifiers_spatialreferences FOREIGN KEY (spatialreferenceid) REFERENCES odm2.spatialreferences(spatialreferenceid) ON DELETE RESTRICT;


--
-- Name: specimenbatchpostions fk_specimenbatchpostions_featureactions; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.specimenbatchpostions
    ADD CONSTRAINT fk_specimenbatchpostions_featureactions FOREIGN KEY (featureactionid) REFERENCES odm2.featureactions(featureactionid) ON DELETE RESTRICT;


--
-- Name: specimens fk_specimens_cv_medium; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.specimens
    ADD CONSTRAINT fk_specimens_cv_medium FOREIGN KEY (specimenmediumcv) REFERENCES odm2.cv_medium(name) ON DELETE RESTRICT;


--
-- Name: specimens fk_specimens_cv_specimentype; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.specimens
    ADD CONSTRAINT fk_specimens_cv_specimentype FOREIGN KEY (specimentypecv) REFERENCES odm2.cv_specimentype(name) ON DELETE RESTRICT;


--
-- Name: specimens fk_specimens_samplingfeatures; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.specimens
    ADD CONSTRAINT fk_specimens_samplingfeatures FOREIGN KEY (samplingfeatureid) REFERENCES odm2.samplingfeatures(samplingfeatureid) ON DELETE RESTRICT;


--
-- Name: CONSTRAINT fk_specimens_samplingfeatures ON specimens; Type: COMMENT; Schema: odm2; Owner: -
--

COMMENT ON CONSTRAINT fk_specimens_samplingfeatures ON odm2.specimens IS '@foreignSingleFieldName singleSpecimenBySamplingfeatureid';


--
-- Name: specimentaxonomicclassifiers fk_specimentaxonomicclassifiers_citations; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.specimentaxonomicclassifiers
    ADD CONSTRAINT fk_specimentaxonomicclassifiers_citations FOREIGN KEY (citationid) REFERENCES odm2.citations(citationid) ON DELETE RESTRICT;


--
-- Name: specimentaxonomicclassifiers fk_specimentaxonomicclassifiers_specimens; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.specimentaxonomicclassifiers
    ADD CONSTRAINT fk_specimentaxonomicclassifiers_specimens FOREIGN KEY (samplingfeatureid) REFERENCES odm2.specimens(samplingfeatureid) ON DELETE RESTRICT;


--
-- Name: specimentaxonomicclassifiers fk_specimentaxonomicclassifiers_taxonomicclassifiers; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.specimentaxonomicclassifiers
    ADD CONSTRAINT fk_specimentaxonomicclassifiers_taxonomicclassifiers FOREIGN KEY (taxonomicclassifierid) REFERENCES odm2.taxonomicclassifiers(taxonomicclassifierid) ON DELETE RESTRICT;


--
-- Name: spectraresults fk_spectraresults_cv_aggregationstatistic; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.spectraresults
    ADD CONSTRAINT fk_spectraresults_cv_aggregationstatistic FOREIGN KEY (aggregationstatisticcv) REFERENCES odm2.cv_aggregationstatistic(name) ON DELETE RESTRICT;


--
-- Name: spectraresults fk_spectraresults_results; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.spectraresults
    ADD CONSTRAINT fk_spectraresults_results FOREIGN KEY (resultid) REFERENCES odm2.results(resultid) ON DELETE RESTRICT;


--
-- Name: spectraresults fk_spectraresults_spatialreferences; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.spectraresults
    ADD CONSTRAINT fk_spectraresults_spatialreferences FOREIGN KEY (spatialreferenceid) REFERENCES odm2.spatialreferences(spatialreferenceid) ON DELETE RESTRICT;


--
-- Name: spectraresults fk_spectraresults_units; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.spectraresults
    ADD CONSTRAINT fk_spectraresults_units FOREIGN KEY (intendedwavelengthspacingunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: spectraresults fk_spectraresults_xunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.spectraresults
    ADD CONSTRAINT fk_spectraresults_xunits FOREIGN KEY (xlocationunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: spectraresults fk_spectraresults_yunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.spectraresults
    ADD CONSTRAINT fk_spectraresults_yunits FOREIGN KEY (ylocationunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: spectraresults fk_spectraresults_zunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.spectraresults
    ADD CONSTRAINT fk_spectraresults_zunits FOREIGN KEY (zlocationunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: spectraresultvalueannotations fk_spectraresultvalueannotations_annotations; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.spectraresultvalueannotations
    ADD CONSTRAINT fk_spectraresultvalueannotations_annotations FOREIGN KEY (annotationid) REFERENCES odm2.annotations(annotationid) ON DELETE RESTRICT;


--
-- Name: spectraresultvalueannotations fk_spectraresultvalueannotations_spectraresultvalues; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.spectraresultvalueannotations
    ADD CONSTRAINT fk_spectraresultvalueannotations_spectraresultvalues FOREIGN KEY (valueid) REFERENCES odm2.spectraresultvalues(valueid) ON DELETE RESTRICT;


--
-- Name: spectraresultvalues fk_spectraresultvalues_aiunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.spectraresultvalues
    ADD CONSTRAINT fk_spectraresultvalues_aiunits FOREIGN KEY (timeaggregationintervalunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: spectraresultvalues fk_spectraresultvalues_cv_censorcode; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.spectraresultvalues
    ADD CONSTRAINT fk_spectraresultvalues_cv_censorcode FOREIGN KEY (censorcodecv) REFERENCES odm2.cv_censorcode(name) ON DELETE RESTRICT;


--
-- Name: spectraresultvalues fk_spectraresultvalues_cv_qualitycode; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.spectraresultvalues
    ADD CONSTRAINT fk_spectraresultvalues_cv_qualitycode FOREIGN KEY (qualitycodecv) REFERENCES odm2.cv_qualitycode(name) ON DELETE RESTRICT;


--
-- Name: spectraresultvalues fk_spectraresultvalues_spectraresults; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.spectraresultvalues
    ADD CONSTRAINT fk_spectraresultvalues_spectraresults FOREIGN KEY (resultid) REFERENCES odm2.spectraresults(resultid) ON DELETE RESTRICT;


--
-- Name: spectraresultvalues fk_spectraresultvalues_wunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.spectraresultvalues
    ADD CONSTRAINT fk_spectraresultvalues_wunits FOREIGN KEY (wavelengthunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: taxonomicclassifierexternalidentifiers fk_taxonomicclassifierextids_extidsystems; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.taxonomicclassifierexternalidentifiers
    ADD CONSTRAINT fk_taxonomicclassifierextids_extidsystems FOREIGN KEY (externalidentifiersystemid) REFERENCES odm2.externalidentifiersystems(externalidentifiersystemid) ON DELETE RESTRICT;


--
-- Name: taxonomicclassifierexternalidentifiers fk_taxonomicclassifierextids_taxonomicclassifiers; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.taxonomicclassifierexternalidentifiers
    ADD CONSTRAINT fk_taxonomicclassifierextids_taxonomicclassifiers FOREIGN KEY (taxonomicclassifierid) REFERENCES odm2.taxonomicclassifiers(taxonomicclassifierid) ON DELETE RESTRICT;


--
-- Name: taxonomicclassifiers fk_taxonomicclassifiers_cv_taxonomicclassifiertype; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.taxonomicclassifiers
    ADD CONSTRAINT fk_taxonomicclassifiers_cv_taxonomicclassifiertype FOREIGN KEY (taxonomicclassifiertypecv) REFERENCES odm2.cv_taxonomicclassifiertype(name) ON DELETE RESTRICT;


--
-- Name: taxonomicclassifiersannotations fk_taxonomicclassifiersannotations_actions; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.taxonomicclassifiersannotations
    ADD CONSTRAINT fk_taxonomicclassifiersannotations_actions FOREIGN KEY (taxonomicclassifierid) REFERENCES odm2.taxonomicclassifiers(taxonomicclassifierid) ON DELETE RESTRICT;


--
-- Name: taxonomicclassifiersannotations fk_taxonomicclassifiersannotations_annotations; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.taxonomicclassifiersannotations
    ADD CONSTRAINT fk_taxonomicclassifiersannotations_annotations FOREIGN KEY (annotationid) REFERENCES odm2.annotations(annotationid) ON DELETE RESTRICT;


--
-- Name: timeseriesresults fk_timeseriesresults_cv_aggregationstatistic; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.timeseriesresults
    ADD CONSTRAINT fk_timeseriesresults_cv_aggregationstatistic FOREIGN KEY (aggregationstatisticcv) REFERENCES odm2.cv_aggregationstatistic(name) ON DELETE RESTRICT;


--
-- Name: timeseriesresults fk_timeseriesresults_results; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.timeseriesresults
    ADD CONSTRAINT fk_timeseriesresults_results FOREIGN KEY (resultid) REFERENCES odm2.results(resultid) ON DELETE RESTRICT;


--
-- Name: timeseriesresults fk_timeseriesresults_spatialreferences; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.timeseriesresults
    ADD CONSTRAINT fk_timeseriesresults_spatialreferences FOREIGN KEY (spatialreferenceid) REFERENCES odm2.spatialreferences(spatialreferenceid) ON DELETE RESTRICT;


--
-- Name: timeseriesresults fk_timeseriesresults_tunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.timeseriesresults
    ADD CONSTRAINT fk_timeseriesresults_tunits FOREIGN KEY (intendedtimespacingunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: timeseriesresults fk_timeseriesresults_xunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.timeseriesresults
    ADD CONSTRAINT fk_timeseriesresults_xunits FOREIGN KEY (xlocationunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: timeseriesresults fk_timeseriesresults_yunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.timeseriesresults
    ADD CONSTRAINT fk_timeseriesresults_yunits FOREIGN KEY (ylocationunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: timeseriesresults fk_timeseriesresults_zunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.timeseriesresults
    ADD CONSTRAINT fk_timeseriesresults_zunits FOREIGN KEY (zlocationunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: timeseriesresultvalueannotations fk_timeseriesresultvalueannotations_annotations; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.timeseriesresultvalueannotations
    ADD CONSTRAINT fk_timeseriesresultvalueannotations_annotations FOREIGN KEY (annotationid) REFERENCES odm2.annotations(annotationid) ON DELETE RESTRICT;


--
-- Name: timeseriesresultvalueannotations fk_timeseriesresultvalueannotations_timeseriesresultvalues; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.timeseriesresultvalueannotations
    ADD CONSTRAINT fk_timeseriesresultvalueannotations_timeseriesresultvalues FOREIGN KEY (valueid) REFERENCES odm2.timeseriesresultvalues(valueid) ON DELETE RESTRICT;


--
-- Name: timeseriesresultvalues fk_timeseriesresultvalues_aiunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.timeseriesresultvalues
    ADD CONSTRAINT fk_timeseriesresultvalues_aiunits FOREIGN KEY (timeaggregationintervalunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: timeseriesresultvalues fk_timeseriesresultvalues_cv_censorcode; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.timeseriesresultvalues
    ADD CONSTRAINT fk_timeseriesresultvalues_cv_censorcode FOREIGN KEY (censorcodecv) REFERENCES odm2.cv_censorcode(name) ON DELETE RESTRICT;


--
-- Name: timeseriesresultvalues fk_timeseriesresultvalues_cv_qualitycode; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.timeseriesresultvalues
    ADD CONSTRAINT fk_timeseriesresultvalues_cv_qualitycode FOREIGN KEY (qualitycodecv) REFERENCES odm2.cv_qualitycode(name) ON DELETE RESTRICT;


--
-- Name: timeseriesresultvalues fk_timeseriesresultvalues_timeseriesresults; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.timeseriesresultvalues
    ADD CONSTRAINT fk_timeseriesresultvalues_timeseriesresults FOREIGN KEY (resultid) REFERENCES odm2.timeseriesresults(resultid) ON DELETE RESTRICT;


--
-- Name: trackresultlocations fk_trackresultlocations_cv_qualitycode; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.trackresultlocations
    ADD CONSTRAINT fk_trackresultlocations_cv_qualitycode FOREIGN KEY (qualitycodecv) REFERENCES odm2.cv_qualitycode(name) ON DELETE RESTRICT;


--
-- Name: trackresultlocations fk_trackresultlocations_samplingfeatures; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.trackresultlocations
    ADD CONSTRAINT fk_trackresultlocations_samplingfeatures FOREIGN KEY (samplingfeatureid) REFERENCES odm2.samplingfeatures(samplingfeatureid) ON DELETE RESTRICT;


--
-- Name: trackresults fk_trackresults_results; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.trackresults
    ADD CONSTRAINT fk_trackresults_results FOREIGN KEY (resultid) REFERENCES odm2.results(resultid) ON DELETE RESTRICT;


--
-- Name: trackresultvalues fk_trackresultvalues_cv_qualitycode; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.trackresultvalues
    ADD CONSTRAINT fk_trackresultvalues_cv_qualitycode FOREIGN KEY (qualitycodecv) REFERENCES odm2.cv_qualitycode(name) ON DELETE RESTRICT;


--
-- Name: trackresultvalues fk_trackresultvalues_trackresults; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.trackresultvalues
    ADD CONSTRAINT fk_trackresultvalues_trackresults FOREIGN KEY (resultid) REFERENCES odm2.trackresults(resultid) ON DELETE RESTRICT;


--
-- Name: trajectoryresults fk_trajectoryresults_cv_aggregationstatistic; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.trajectoryresults
    ADD CONSTRAINT fk_trajectoryresults_cv_aggregationstatistic FOREIGN KEY (aggregationstatisticcv) REFERENCES odm2.cv_aggregationstatistic(name) ON DELETE RESTRICT;


--
-- Name: trajectoryresults fk_trajectoryresults_results; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.trajectoryresults
    ADD CONSTRAINT fk_trajectoryresults_results FOREIGN KEY (resultid) REFERENCES odm2.results(resultid) ON DELETE RESTRICT;


--
-- Name: trajectoryresults fk_trajectoryresults_spatialreferences; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.trajectoryresults
    ADD CONSTRAINT fk_trajectoryresults_spatialreferences FOREIGN KEY (spatialreferenceid) REFERENCES odm2.spatialreferences(spatialreferenceid) ON DELETE RESTRICT;


--
-- Name: trajectoryresults fk_trajectoryresults_tsunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.trajectoryresults
    ADD CONSTRAINT fk_trajectoryresults_tsunits FOREIGN KEY (intendedtrajectoryspacingunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: trajectoryresults fk_trajectoryresults_tunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.trajectoryresults
    ADD CONSTRAINT fk_trajectoryresults_tunits FOREIGN KEY (intendedtimespacingunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: trajectoryresultvalueannotations fk_trajectoryresultvalueannotations_annotations; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.trajectoryresultvalueannotations
    ADD CONSTRAINT fk_trajectoryresultvalueannotations_annotations FOREIGN KEY (annotationid) REFERENCES odm2.annotations(annotationid) ON DELETE RESTRICT;


--
-- Name: trajectoryresultvalueannotations fk_trajectoryresultvalueannotations_trajectoryresultvalues; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.trajectoryresultvalueannotations
    ADD CONSTRAINT fk_trajectoryresultvalueannotations_trajectoryresultvalues FOREIGN KEY (valueid) REFERENCES odm2.trajectoryresultvalues(valueid) ON DELETE RESTRICT;


--
-- Name: trajectoryresultvalues fk_trajectoryresultvalues_aiunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.trajectoryresultvalues
    ADD CONSTRAINT fk_trajectoryresultvalues_aiunits FOREIGN KEY (timeaggregationintervalunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: trajectoryresultvalues fk_trajectoryresultvalues_cv_censorcode; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.trajectoryresultvalues
    ADD CONSTRAINT fk_trajectoryresultvalues_cv_censorcode FOREIGN KEY (censorcodecv) REFERENCES odm2.cv_censorcode(name) ON DELETE RESTRICT;


--
-- Name: trajectoryresultvalues fk_trajectoryresultvalues_cv_qualitycode; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.trajectoryresultvalues
    ADD CONSTRAINT fk_trajectoryresultvalues_cv_qualitycode FOREIGN KEY (qualitycodecv) REFERENCES odm2.cv_qualitycode(name) ON DELETE RESTRICT;


--
-- Name: trajectoryresultvalues fk_trajectoryresultvalues_distanceunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.trajectoryresultvalues
    ADD CONSTRAINT fk_trajectoryresultvalues_distanceunits FOREIGN KEY (trajectorydistanceunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: trajectoryresultvalues fk_trajectoryresultvalues_trajectoryresults; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.trajectoryresultvalues
    ADD CONSTRAINT fk_trajectoryresultvalues_trajectoryresults FOREIGN KEY (resultid) REFERENCES odm2.trajectoryresults(resultid) ON DELETE RESTRICT;


--
-- Name: trajectoryresultvalues fk_trajectoryresultvalues_xunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.trajectoryresultvalues
    ADD CONSTRAINT fk_trajectoryresultvalues_xunits FOREIGN KEY (xlocationunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: trajectoryresultvalues fk_trajectoryresultvalues_yunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.trajectoryresultvalues
    ADD CONSTRAINT fk_trajectoryresultvalues_yunits FOREIGN KEY (ylocationunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: trajectoryresultvalues fk_trajectoryresultvalues_zunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.trajectoryresultvalues
    ADD CONSTRAINT fk_trajectoryresultvalues_zunits FOREIGN KEY (zlocationunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: transectresults fk_transectresults_cv_aggregationstatistic; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.transectresults
    ADD CONSTRAINT fk_transectresults_cv_aggregationstatistic FOREIGN KEY (aggregationstatisticcv) REFERENCES odm2.cv_aggregationstatistic(name) ON DELETE RESTRICT;


--
-- Name: transectresults fk_transectresults_results; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.transectresults
    ADD CONSTRAINT fk_transectresults_results FOREIGN KEY (resultid) REFERENCES odm2.results(resultid) ON DELETE RESTRICT;


--
-- Name: transectresults fk_transectresults_spatialreferences; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.transectresults
    ADD CONSTRAINT fk_transectresults_spatialreferences FOREIGN KEY (spatialreferenceid) REFERENCES odm2.spatialreferences(spatialreferenceid) ON DELETE RESTRICT;


--
-- Name: transectresults fk_transectresults_tmunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.transectresults
    ADD CONSTRAINT fk_transectresults_tmunits FOREIGN KEY (intendedtimespacingunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: transectresults fk_transectresults_tsunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.transectresults
    ADD CONSTRAINT fk_transectresults_tsunits FOREIGN KEY (intendedtransectspacingunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: transectresults fk_transectresults_units; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.transectresults
    ADD CONSTRAINT fk_transectresults_units FOREIGN KEY (zlocationunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: transectresultvalueannotations fk_transectresultvalueannotations_annotations; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.transectresultvalueannotations
    ADD CONSTRAINT fk_transectresultvalueannotations_annotations FOREIGN KEY (annotationid) REFERENCES odm2.annotations(annotationid) ON DELETE RESTRICT;


--
-- Name: transectresultvalueannotations fk_transectresultvalueannotations_transectresultvalues; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.transectresultvalueannotations
    ADD CONSTRAINT fk_transectresultvalueannotations_transectresultvalues FOREIGN KEY (valueid) REFERENCES odm2.transectresultvalues(valueid) ON DELETE RESTRICT;


--
-- Name: transectresultvalues fk_transectresultvalues_aiunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.transectresultvalues
    ADD CONSTRAINT fk_transectresultvalues_aiunits FOREIGN KEY (timeaggregationintervalunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: transectresultvalues fk_transectresultvalues_cv_aggregationstatistic; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.transectresultvalues
    ADD CONSTRAINT fk_transectresultvalues_cv_aggregationstatistic FOREIGN KEY (aggregationstatisticcv) REFERENCES odm2.cv_aggregationstatistic(name) ON DELETE RESTRICT;


--
-- Name: transectresultvalues fk_transectresultvalues_cv_censorcode; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.transectresultvalues
    ADD CONSTRAINT fk_transectresultvalues_cv_censorcode FOREIGN KEY (censorcodecv) REFERENCES odm2.cv_censorcode(name) ON DELETE RESTRICT;


--
-- Name: transectresultvalues fk_transectresultvalues_cv_qualitycode; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.transectresultvalues
    ADD CONSTRAINT fk_transectresultvalues_cv_qualitycode FOREIGN KEY (qualitycodecv) REFERENCES odm2.cv_qualitycode(name) ON DELETE RESTRICT;


--
-- Name: transectresultvalues fk_transectresultvalues_distanceunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.transectresultvalues
    ADD CONSTRAINT fk_transectresultvalues_distanceunits FOREIGN KEY (transectdistanceunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: transectresultvalues fk_transectresultvalues_transectresults; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.transectresultvalues
    ADD CONSTRAINT fk_transectresultvalues_transectresults FOREIGN KEY (resultid) REFERENCES odm2.transectresults(resultid) ON DELETE RESTRICT;


--
-- Name: transectresultvalues fk_transectresultvalues_xunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.transectresultvalues
    ADD CONSTRAINT fk_transectresultvalues_xunits FOREIGN KEY (xlocationunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: transectresultvalues fk_transectresultvalues_yunits; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.transectresultvalues
    ADD CONSTRAINT fk_transectresultvalues_yunits FOREIGN KEY (ylocationunitsid) REFERENCES odm2.units(unitsid) ON DELETE RESTRICT;


--
-- Name: units fk_units_cv_unitstype; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.units
    ADD CONSTRAINT fk_units_cv_unitstype FOREIGN KEY (unitstypecv) REFERENCES odm2.cv_unitstype(name) ON DELETE RESTRICT;


--
-- Name: variableextensionpropertyvalues fk_variableextensionpropertyvalues_extensionproperties; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.variableextensionpropertyvalues
    ADD CONSTRAINT fk_variableextensionpropertyvalues_extensionproperties FOREIGN KEY (propertyid) REFERENCES odm2.extensionproperties(propertyid) ON DELETE RESTRICT;


--
-- Name: variableextensionpropertyvalues fk_variableextensionpropertyvalues_variables; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.variableextensionpropertyvalues
    ADD CONSTRAINT fk_variableextensionpropertyvalues_variables FOREIGN KEY (variableid) REFERENCES odm2.variables(variableid) ON DELETE RESTRICT;


--
-- Name: variableexternalidentifiers fk_variableexternalidentifiers_externalidentifiersystems; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.variableexternalidentifiers
    ADD CONSTRAINT fk_variableexternalidentifiers_externalidentifiersystems FOREIGN KEY (externalidentifiersystemid) REFERENCES odm2.externalidentifiersystems(externalidentifiersystemid) ON DELETE RESTRICT;


--
-- Name: variableexternalidentifiers fk_variableexternalidentifiers_variables; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.variableexternalidentifiers
    ADD CONSTRAINT fk_variableexternalidentifiers_variables FOREIGN KEY (variableid) REFERENCES odm2.variables(variableid) ON DELETE RESTRICT;


--
-- Name: variables fk_variables_cv_speciation; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.variables
    ADD CONSTRAINT fk_variables_cv_speciation FOREIGN KEY (speciationcv) REFERENCES odm2.cv_speciation(name) ON DELETE RESTRICT;


--
-- Name: variables fk_variables_cv_variablename; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.variables
    ADD CONSTRAINT fk_variables_cv_variablename FOREIGN KEY (variablenamecv) REFERENCES odm2.cv_variablename(name) ON DELETE RESTRICT;


--
-- Name: variables fk_variables_cv_variabletype; Type: FK CONSTRAINT; Schema: odm2; Owner: -
--

ALTER TABLE ONLY odm2.variables
    ADD CONSTRAINT fk_variables_cv_variabletype FOREIGN KEY (variabletypecv) REFERENCES odm2.cv_variabletype(name) ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

UPDATE odm2.samplingfeatures
SET  samplingfeaturetypecv='Site', samplingfeaturecode='MSOURCE1', samplingfeaturename=NULL, samplingfeaturedescription=NULL, samplingfeaturegeotypecv=NULL, featuregeometry='SRID=4326;POINT (10.7484615 59.943095)'::public.geometry, featuregeometrywkt=NULL, elevation_m=NULL, elevationdatumcv=NULL
WHERE samplingfeatureid=15;