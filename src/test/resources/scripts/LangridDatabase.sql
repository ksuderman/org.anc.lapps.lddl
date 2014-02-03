--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.6
-- Dumped by pg_dump version 9.1.6
-- Started on 2013-12-03 14:49:52 EST

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 2435 (class 1262 OID 81219)
-- Name: langrid; Type: DATABASE; Schema: -; Owner: langrid
--

CREATE DATABASE langrid WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C' LC_CTYPE = 'C';


ALTER DATABASE langrid OWNER TO langrid;

\connect langrid

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 201 (class 3079 OID 11907)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2438 (class 0 OID 0)
-- Dependencies: 201
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 161 (class 1259 OID 81220)
-- Dependencies: 5
-- Name: acceptableremoteaddress; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE acceptableremoteaddress (
    address character varying(255) NOT NULL,
    createddatetime timestamp without time zone,
    updateddatetime timestamp without time zone
);


ALTER TABLE public.acceptableremoteaddress OWNER TO langrid;

--
-- TOC entry 162 (class 1259 OID 81225)
-- Dependencies: 5
-- Name: accesslimit; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE accesslimit (
    limittype integer NOT NULL,
    period integer NOT NULL,
    servicegridid character varying(255) NOT NULL,
    serviceid character varying(255) NOT NULL,
    usergridid character varying(255) NOT NULL,
    userid character varying(255) NOT NULL,
    createddatetime timestamp without time zone,
    updateddatetime timestamp without time zone,
    limitcount integer NOT NULL
);


ALTER TABLE public.accesslimit OWNER TO langrid;

--
-- TOC entry 163 (class 1259 OID 81233)
-- Dependencies: 5
-- Name: accesslog; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE accesslog (
    id integer NOT NULL,
    address character varying(255),
    agent character varying(255),
    callnest integer NOT NULL,
    calltree text,
    datetime timestamp without time zone,
    faultcode character varying(255),
    faultstring text,
    host character varying(255),
    nodeid character varying(255),
    nodelocalid integer NOT NULL,
    protocolid character varying(255),
    referer character varying(255),
    requestbytes integer NOT NULL,
    requesturi character varying(255),
    responsebytes integer NOT NULL,
    responsecode integer NOT NULL,
    responsemillis bigint NOT NULL,
    serviceandnodegridid character varying(255),
    serviceid character varying(255),
    usergridid character varying(255),
    userid character varying(255)
);


ALTER TABLE public.accesslog OWNER TO langrid;

--
-- TOC entry 164 (class 1259 OID 81241)
-- Dependencies: 5
-- Name: accessright; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE accessright (
    servicegridid character varying(255) NOT NULL,
    serviceid character varying(255) NOT NULL,
    usergridid character varying(255) NOT NULL,
    userid character varying(255) NOT NULL,
    createddatetime timestamp without time zone,
    updateddatetime timestamp without time zone,
    permitted boolean NOT NULL
);


ALTER TABLE public.accessright OWNER TO langrid;

--
-- TOC entry 165 (class 1259 OID 81249)
-- Dependencies: 5
-- Name: accessstat; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE accessstat (
    basedatetime timestamp without time zone NOT NULL,
    nodeid character varying(255) NOT NULL,
    period integer NOT NULL,
    serviceandnodegridid character varying(255) NOT NULL,
    serviceid character varying(255) NOT NULL,
    usergridid character varying(255) NOT NULL,
    userid character varying(255) NOT NULL,
    accesscount integer NOT NULL,
    lastaccessdatetime timestamp without time zone,
    requestbytes bigint NOT NULL,
    responsebytes bigint NOT NULL,
    responsemillis bigint NOT NULL
);


ALTER TABLE public.accessstat OWNER TO langrid;

--
-- TOC entry 166 (class 1259 OID 81257)
-- Dependencies: 5
-- Name: domain; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE domain (
    domainid character varying(255) NOT NULL,
    createddatetime timestamp without time zone,
    updateddatetime timestamp without time zone,
    description character varying(255),
    domainname character varying(255),
    ownerusergridid character varying(255),
    owneruserid character varying(255)
);


ALTER TABLE public.domain OWNER TO langrid;

--
-- TOC entry 167 (class 1259 OID 81265)
-- Dependencies: 5
-- Name: federation; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE federation (
    sourcegridid character varying(255) NOT NULL,
    targetgridid character varying(255) NOT NULL,
    createddatetime timestamp without time zone,
    updateddatetime timestamp without time zone,
    connected boolean NOT NULL,
    requesting boolean NOT NULL,
    sourcegridname character varying(255),
    tagetgridname character varying(255),
    targetgridaccesstoken character varying(255),
    targetgridhomepageurlclazz character varying(255),
    targetgridhomepageurlstringvalue character varying(255),
    targetgridorganization character varying(255),
    targetgriduserid character varying(255)
);


ALTER TABLE public.federation OWNER TO langrid;

--
-- TOC entry 168 (class 1259 OID 81273)
-- Dependencies: 5
-- Name: grid; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE grid (
    gridid character varying(255) NOT NULL,
    createddatetime timestamp without time zone,
    updateddatetime timestamp without time zone,
    autoapproveenabled boolean NOT NULL,
    commercialuseallowed boolean NOT NULL,
    gridname character varying(255),
    hosted boolean NOT NULL,
    operatoruserid character varying(255),
    url text
);


ALTER TABLE public.grid OWNER TO langrid;

--
-- TOC entry 170 (class 1259 OID 81289)
-- Dependencies: 5
-- Name: grid_domain; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE grid_domain (
    grid_gridid character varying(255) NOT NULL,
    supporteddomains_domainid character varying(255) NOT NULL
);


ALTER TABLE public.grid_domain OWNER TO langrid;

--
-- TOC entry 169 (class 1259 OID 81281)
-- Dependencies: 5
-- Name: gridattribute; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE gridattribute (
    gridid character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    createddatetime timestamp without time zone,
    updateddatetime timestamp without time zone,
    value text
);


ALTER TABLE public.gridattribute OWNER TO langrid;

--
-- TOC entry 200 (class 1259 OID 81613)
-- Dependencies: 5
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: public; Owner: langrid
--

CREATE SEQUENCE hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hibernate_sequence OWNER TO langrid;

--
-- TOC entry 2439 (class 0 OID 0)
-- Dependencies: 200
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: public; Owner: langrid
--

SELECT pg_catalog.setval('hibernate_sequence', 1, false);


--
-- TOC entry 171 (class 1259 OID 81295)
-- Dependencies: 5
-- Name: invocation; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE invocation (
    invocationname character varying(255) NOT NULL,
    ownerservicegridid character varying(255) NOT NULL,
    ownerserviceid character varying(255) NOT NULL,
    createddatetime timestamp without time zone,
    updateddatetime timestamp without time zone,
    domainid character varying(255),
    servicegridid character varying(255),
    serviceid character varying(255),
    servicename character varying(255),
    servicetypeid character varying(255)
);


ALTER TABLE public.invocation OWNER TO langrid;

--
-- TOC entry 172 (class 1259 OID 81303)
-- Dependencies: 5
-- Name: news; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE news (
    id integer NOT NULL,
    createddatetime timestamp without time zone,
    updateddatetime timestamp without time zone,
    contents text,
    gridid character varying(255),
    nodeid character varying(255),
    nodelocalid integer NOT NULL
);


ALTER TABLE public.news OWNER TO langrid;

--
-- TOC entry 173 (class 1259 OID 81311)
-- Dependencies: 5
-- Name: node; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE node (
    gridid character varying(255) NOT NULL,
    nodeid character varying(255) NOT NULL,
    createddatetime timestamp without time zone,
    updateddatetime timestamp without time zone,
    accesstoken character varying(255),
    active boolean NOT NULL,
    cpu character varying(255),
    memory character varying(255),
    mirror boolean NOT NULL,
    nodename character varying(255),
    os character varying(255),
    owneruserid character varying(255),
    owneruserorganization character varying(255),
    specialnotes character varying(255),
    urlclazz character varying(255),
    urlstringvalue character varying(255)
);


ALTER TABLE public.node OWNER TO langrid;

--
-- TOC entry 174 (class 1259 OID 81319)
-- Dependencies: 5
-- Name: nodeattribute; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE nodeattribute (
    gridid character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    nodeid character varying(255) NOT NULL,
    createddatetime timestamp without time zone,
    updateddatetime timestamp without time zone,
    value text
);


ALTER TABLE public.nodeattribute OWNER TO langrid;

--
-- TOC entry 175 (class 1259 OID 81327)
-- Dependencies: 5
-- Name: operationrequest; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE operationrequest (
    id integer NOT NULL,
    createddatetime timestamp without time zone,
    updateddatetime timestamp without time zone,
    requesteduserid character varying(255),
    contents text,
    gridid character varying(255),
    nodeid character varying(255),
    nodelocalid integer NOT NULL,
    targetid character varying(255),
    targettype integer
);


ALTER TABLE public.operationrequest OWNER TO langrid;

--
-- TOC entry 176 (class 1259 OID 81335)
-- Dependencies: 5
-- Name: overuselimit; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE overuselimit (
    gridid character varying(255) NOT NULL,
    limittype integer NOT NULL,
    period integer NOT NULL,
    createddatetime timestamp without time zone,
    updateddatetime timestamp without time zone,
    limitcount integer NOT NULL
);


ALTER TABLE public.overuselimit OWNER TO langrid;

--
-- TOC entry 177 (class 1259 OID 81340)
-- Dependencies: 5
-- Name: protocol; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE protocol (
    protocolid character varying(255) NOT NULL,
    createddatetime timestamp without time zone,
    updateddatetime timestamp without time zone,
    description character varying(255),
    ownerusergridid character varying(255),
    owneruserid character varying(255),
    protocolname character varying(255)
);


ALTER TABLE public.protocol OWNER TO langrid;

--
-- TOC entry 178 (class 1259 OID 81348)
-- Dependencies: 5
-- Name: resource; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE resource (
    gridid character varying(255) NOT NULL,
    resourceid character varying(255) NOT NULL,
    createddatetime timestamp without time zone,
    updateddatetime timestamp without time zone,
    active boolean NOT NULL,
    approved boolean NOT NULL,
    copyrightinfo text,
    cpuinfo character varying(255),
    licenseinfo text,
    memoryinfo character varying(255),
    osinfo character varying(255),
    owneruserid character varying(255),
    resourcedescription text,
    resourcename character varying(255),
    resourcetypedomainid character varying(255),
    resourcetypeid character varying(255),
    specialnoteinfo text,
    visible boolean NOT NULL
);


ALTER TABLE public.resource OWNER TO langrid;

--
-- TOC entry 179 (class 1259 OID 81356)
-- Dependencies: 5
-- Name: resourceattribute; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE resourceattribute (
    gridid character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    resourceid character varying(255) NOT NULL,
    createddatetime timestamp without time zone,
    updateddatetime timestamp without time zone,
    value text
);


ALTER TABLE public.resourceattribute OWNER TO langrid;

--
-- TOC entry 180 (class 1259 OID 81364)
-- Dependencies: 5
-- Name: resourcemetaattribute; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE resourcemetaattribute (
    attributeid character varying(255) NOT NULL,
    domainid character varying(255) NOT NULL,
    attributename character varying(255),
    description character varying(255)
);


ALTER TABLE public.resourcemetaattribute OWNER TO langrid;

--
-- TOC entry 181 (class 1259 OID 81372)
-- Dependencies: 5
-- Name: resourcetype; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE resourcetype (
    domainid character varying(255) NOT NULL,
    resourcetypeid character varying(255) NOT NULL,
    createddatetime timestamp without time zone,
    updateddatetime timestamp without time zone,
    description character varying(255),
    resourcetypename character varying(255)
);


ALTER TABLE public.resourcetype OWNER TO langrid;

--
-- TOC entry 182 (class 1259 OID 81380)
-- Dependencies: 5
-- Name: resourcetype_resourcemetaattribute; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE resourcetype_resourcemetaattribute (
    resourcetype_domainid character varying(255) NOT NULL,
    resourcetype_resourcetypeid character varying(255) NOT NULL,
    metaattributes_attributeid character varying(255) NOT NULL,
    metaattributes_domainid character varying(255) NOT NULL
);


ALTER TABLE public.resourcetype_resourcemetaattribute OWNER TO langrid;

--
-- TOC entry 183 (class 1259 OID 81388)
-- Dependencies: 5
-- Name: service; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE service (
    dtype character varying(31) NOT NULL,
    gridid character varying(255) NOT NULL,
    serviceid character varying(255) NOT NULL,
    createddatetime timestamp without time zone,
    updateddatetime timestamp without time zone,
    active boolean NOT NULL,
    alternateserviceid character varying(255),
    appauthkey character varying(255),
    approved boolean NOT NULL,
    containertype character varying(255),
    copyrightinfo character varying(255),
    federateduseallowed boolean NOT NULL,
    howtogetmembershipinfo text,
    instance oid,
    instancesize integer NOT NULL,
    instancetype integer,
    licenseinfo text,
    membersonly boolean NOT NULL,
    owneruserid character varying(255),
    resourceid character varying(255),
    servicedescription text,
    servicename character varying(255),
    servicetypedomainid character varying(255),
    servicetypeid character varying(255),
    streaming boolean,
    timeoutmillis integer NOT NULL,
    usealternateservice boolean NOT NULL,
    visible boolean NOT NULL,
    wrappersourcecodeurlclazz character varying(255),
    wrappersourcecodeurlstringvalue character varying(255),
    wsdl oid,
    deployed boolean,
    deployedid character varying(255)
);


ALTER TABLE public.service OWNER TO langrid;

--
-- TOC entry 192 (class 1259 OID 81460)
-- Dependencies: 5
-- Name: service_allowedappprovision; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE service_allowedappprovision (
    service_gridid character varying(255) NOT NULL,
    service_serviceid character varying(255) NOT NULL,
    element character varying(255)
);


ALTER TABLE public.service_allowedappprovision OWNER TO langrid;

--
-- TOC entry 193 (class 1259 OID 81466)
-- Dependencies: 5
-- Name: service_alloweduse; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE service_alloweduse (
    service_gridid character varying(255) NOT NULL,
    service_serviceid character varying(255) NOT NULL,
    element character varying(255)
);


ALTER TABLE public.service_alloweduse OWNER TO langrid;

--
-- TOC entry 194 (class 1259 OID 81472)
-- Dependencies: 5
-- Name: service_partnerservicenamespaceuris; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE service_partnerservicenamespaceuris (
    service_gridid character varying(255) NOT NULL,
    service_serviceid character varying(255) NOT NULL,
    element character varying(255)
);


ALTER TABLE public.service_partnerservicenamespaceuris OWNER TO langrid;

--
-- TOC entry 184 (class 1259 OID 81396)
-- Dependencies: 5
-- Name: serviceactionschedule; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE serviceactionschedule (
    id integer NOT NULL,
    createddatetime timestamp without time zone,
    updateddatetime timestamp without time zone,
    actiontype integer,
    bookingdatetime timestamp without time zone,
    gridid character varying(255),
    isrelated boolean NOT NULL,
    nodeid character varying(255),
    nodelocalid integer NOT NULL,
    targetid character varying(255),
    targettype integer
);


ALTER TABLE public.serviceactionschedule OWNER TO langrid;

--
-- TOC entry 185 (class 1259 OID 81404)
-- Dependencies: 5
-- Name: serviceattribute; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE serviceattribute (
    gridid character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    serviceid character varying(255) NOT NULL,
    createddatetime timestamp without time zone,
    updateddatetime timestamp without time zone,
    value text
);


ALTER TABLE public.serviceattribute OWNER TO langrid;

--
-- TOC entry 186 (class 1259 OID 81412)
-- Dependencies: 5
-- Name: servicedeployment; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE servicedeployment (
    gridid character varying(255) NOT NULL,
    nodeid character varying(255) NOT NULL,
    serviceid character varying(255) NOT NULL,
    createddatetime timestamp without time zone,
    updateddatetime timestamp without time zone,
    deployeddatetime timestamp without time zone,
    disabledbyerrordate timestamp without time zone,
    enabled boolean NOT NULL,
    servicepath character varying(255)
);


ALTER TABLE public.servicedeployment OWNER TO langrid;

--
-- TOC entry 187 (class 1259 OID 81420)
-- Dependencies: 5
-- Name: serviceendpoint; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE serviceendpoint (
    gridid character varying(255) NOT NULL,
    protocolid character varying(255) NOT NULL,
    serviceid character varying(255) NOT NULL,
    url text NOT NULL,
    createddatetime timestamp without time zone,
    updateddatetime timestamp without time zone,
    authpassword character varying(255),
    authusername character varying(255),
    averesponsemillis bigint NOT NULL,
    disablereason text,
    disabledbyerrordate timestamp without time zone,
    enabled boolean NOT NULL,
    experience bigint NOT NULL
);


ALTER TABLE public.serviceendpoint OWNER TO langrid;

--
-- TOC entry 188 (class 1259 OID 81428)
-- Dependencies: 5
-- Name: serviceinterfacedefinition; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE serviceinterfacedefinition (
    id integer NOT NULL,
    definition oid,
    protocolid character varying(255),
    servicetype_domainid character varying(255),
    servicetype_servicetypeid character varying(255)
);


ALTER TABLE public.serviceinterfacedefinition OWNER TO langrid;

--
-- TOC entry 189 (class 1259 OID 81436)
-- Dependencies: 5
-- Name: servicemetaattribute; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE servicemetaattribute (
    attributeid character varying(255) NOT NULL,
    domainid character varying(255) NOT NULL,
    createddatetime timestamp without time zone,
    updateddatetime timestamp without time zone,
    attributename character varying(255),
    description character varying(255)
);


ALTER TABLE public.servicemetaattribute OWNER TO langrid;

--
-- TOC entry 190 (class 1259 OID 81444)
-- Dependencies: 5
-- Name: servicetype; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE servicetype (
    domainid character varying(255) NOT NULL,
    servicetypeid character varying(255) NOT NULL,
    createddatetime timestamp without time zone,
    updateddatetime timestamp without time zone,
    description text,
    servicetypename character varying(255)
);


ALTER TABLE public.servicetype OWNER TO langrid;

--
-- TOC entry 191 (class 1259 OID 81452)
-- Dependencies: 5
-- Name: servicetype_servicemetaattribute; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE servicetype_servicemetaattribute (
    servicetype_domainid character varying(255) NOT NULL,
    servicetype_servicetypeid character varying(255) NOT NULL,
    metaattributes_attributeid character varying(255) NOT NULL,
    metaattributes_domainid character varying(255) NOT NULL
);


ALTER TABLE public.servicetype_servicemetaattribute OWNER TO langrid;

--
-- TOC entry 195 (class 1259 OID 81478)
-- Dependencies: 5
-- Name: systemproperty; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE systemproperty (
    gridid character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.systemproperty OWNER TO langrid;

--
-- TOC entry 196 (class 1259 OID 81486)
-- Dependencies: 5
-- Name: temporaryuser; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE temporaryuser (
    gridid character varying(255) NOT NULL,
    userid character varying(255) NOT NULL,
    createddatetime timestamp without time zone,
    updateddatetime timestamp without time zone,
    beginavailabledatetime timestamp without time zone,
    endavailabledatetime timestamp without time zone,
    parentuserid character varying(255),
    password character varying(255)
);


ALTER TABLE public.temporaryuser OWNER TO langrid;

--
-- TOC entry 197 (class 1259 OID 81494)
-- Dependencies: 5
-- Name: userattribute; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE userattribute (
    gridid character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    userid character varying(255) NOT NULL,
    createddatetime timestamp without time zone,
    updateddatetime timestamp without time zone,
    value text
);


ALTER TABLE public.userattribute OWNER TO langrid;

--
-- TOC entry 198 (class 1259 OID 81502)
-- Dependencies: 5
-- Name: userroles; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE userroles (
    gridid character varying(255) NOT NULL,
    rolename character varying(255) NOT NULL,
    userid character varying(255) NOT NULL
);


ALTER TABLE public.userroles OWNER TO langrid;

--
-- TOC entry 199 (class 1259 OID 81510)
-- Dependencies: 5
-- Name: users; Type: TABLE; Schema: public; Owner: langrid; Tablespace: 
--

CREATE TABLE users (
    gridid character varying(255) NOT NULL,
    userid character varying(255) NOT NULL,
    createddatetime timestamp without time zone,
    updateddatetime timestamp without time zone,
    abletocallservices boolean NOT NULL,
    address character varying(255),
    defaultappprovisiontype character varying(255),
    defaultusetype character varying(255),
    emailaddress character varying(255),
    homepageurlclazz character varying(255),
    homepageurlstringvalue character varying(255),
    organization character varying(255),
    password character varying(255),
    passwordchangeddate timestamp without time zone,
    representative character varying(255),
    visible boolean NOT NULL
);


ALTER TABLE public.users OWNER TO langrid;

--
-- TOC entry 2392 (class 0 OID 81220)
-- Dependencies: 161 2431
-- Data for Name: acceptableremoteaddress; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY acceptableremoteaddress (address, createddatetime, updateddatetime) FROM stdin;
\.


--
-- TOC entry 2393 (class 0 OID 81225)
-- Dependencies: 162 2431
-- Data for Name: accesslimit; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY accesslimit (limittype, period, servicegridid, serviceid, usergridid, userid, createddatetime, updateddatetime, limitcount) FROM stdin;
\.


--
-- TOC entry 2394 (class 0 OID 81233)
-- Dependencies: 163 2431
-- Data for Name: accesslog; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY accesslog (id, address, agent, callnest, calltree, datetime, faultcode, faultstring, host, nodeid, nodelocalid, protocolid, referer, requestbytes, requesturi, responsebytes, responsecode, responsemillis, serviceandnodegridid, serviceid, usergridid, userid) FROM stdin;
\.


--
-- TOC entry 2395 (class 0 OID 81241)
-- Dependencies: 164 2431
-- Data for Name: accessright; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY accessright (servicegridid, serviceid, usergridid, userid, createddatetime, updateddatetime, permitted) FROM stdin;
\.


--
-- TOC entry 2396 (class 0 OID 81249)
-- Dependencies: 165 2431
-- Data for Name: accessstat; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY accessstat (basedatetime, nodeid, period, serviceandnodegridid, serviceid, usergridid, userid, accesscount, lastaccessdatetime, requestbytes, responsebytes, responsemillis) FROM stdin;
\.


--
-- TOC entry 2397 (class 0 OID 81257)
-- Dependencies: 166 2431
-- Data for Name: domain; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY domain (domainid, createddatetime, updateddatetime, description, domainname, ownerusergridid, owneruserid) FROM stdin;
\.


--
-- TOC entry 2398 (class 0 OID 81265)
-- Dependencies: 167 2431
-- Data for Name: federation; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY federation (sourcegridid, targetgridid, createddatetime, updateddatetime, connected, requesting, sourcegridname, tagetgridname, targetgridaccesstoken, targetgridhomepageurlclazz, targetgridhomepageurlstringvalue, targetgridorganization, targetgriduserid) FROM stdin;
\.


--
-- TOC entry 2399 (class 0 OID 81273)
-- Dependencies: 168 2431
-- Data for Name: grid; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY grid (gridid, createddatetime, updateddatetime, autoapproveenabled, commercialuseallowed, gridname, hosted, operatoruserid, url) FROM stdin;
lapps	2013-12-03 14:46:00.053	2013-12-03 14:46:00.053	t	f	lapps	t	operator	http://localhost:8080/service_manager
\.


--
-- TOC entry 2401 (class 0 OID 81289)
-- Dependencies: 170 2431
-- Data for Name: grid_domain; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY grid_domain (grid_gridid, supporteddomains_domainid) FROM stdin;
\.


--
-- TOC entry 2400 (class 0 OID 81281)
-- Dependencies: 169 2431
-- Data for Name: gridattribute; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY gridattribute (gridid, name, createddatetime, updateddatetime, value) FROM stdin;
\.


--
-- TOC entry 2402 (class 0 OID 81295)
-- Dependencies: 171 2431
-- Data for Name: invocation; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY invocation (invocationname, ownerservicegridid, ownerserviceid, createddatetime, updateddatetime, domainid, servicegridid, serviceid, servicename, servicetypeid) FROM stdin;
\.


--
-- TOC entry 2403 (class 0 OID 81303)
-- Dependencies: 172 2431
-- Data for Name: news; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY news (id, createddatetime, updateddatetime, contents, gridid, nodeid, nodelocalid) FROM stdin;
\.


--
-- TOC entry 2404 (class 0 OID 81311)
-- Dependencies: 173 2431
-- Data for Name: node; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY node (gridid, nodeid, createddatetime, updateddatetime, accesstoken, active, cpu, memory, mirror, nodename, os, owneruserid, owneruserorganization, specialnotes, urlclazz, urlstringvalue) FROM stdin;
lapps	anc	2013-12-03 14:46:00.099	2013-12-03 14:46:00.099	\N	t	4x8 2.6Ghz	64GB	f	ANC-Node-1	Ubuntu 12.04.1 LTS	operator	\N	None.	java.net.URL	http://localhost:8080/service_manager
\.


--
-- TOC entry 2405 (class 0 OID 81319)
-- Dependencies: 174 2431
-- Data for Name: nodeattribute; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY nodeattribute (gridid, name, nodeid, createddatetime, updateddatetime, value) FROM stdin;
\.


--
-- TOC entry 2406 (class 0 OID 81327)
-- Dependencies: 175 2431
-- Data for Name: operationrequest; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY operationrequest (id, createddatetime, updateddatetime, requesteduserid, contents, gridid, nodeid, nodelocalid, targetid, targettype) FROM stdin;
\.


--
-- TOC entry 2407 (class 0 OID 81335)
-- Dependencies: 176 2431
-- Data for Name: overuselimit; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY overuselimit (gridid, limittype, period, createddatetime, updateddatetime, limitcount) FROM stdin;
\.


--
-- TOC entry 2408 (class 0 OID 81340)
-- Dependencies: 177 2431
-- Data for Name: protocol; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY protocol (protocolid, createddatetime, updateddatetime, description, ownerusergridid, owneruserid, protocolname) FROM stdin;
\.


--
-- TOC entry 2409 (class 0 OID 81348)
-- Dependencies: 178 2431
-- Data for Name: resource; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY resource (gridid, resourceid, createddatetime, updateddatetime, active, approved, copyrightinfo, cpuinfo, licenseinfo, memoryinfo, osinfo, owneruserid, resourcedescription, resourcename, resourcetypedomainid, resourcetypeid, specialnoteinfo, visible) FROM stdin;
\.


--
-- TOC entry 2410 (class 0 OID 81356)
-- Dependencies: 179 2431
-- Data for Name: resourceattribute; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY resourceattribute (gridid, name, resourceid, createddatetime, updateddatetime, value) FROM stdin;
\.


--
-- TOC entry 2411 (class 0 OID 81364)
-- Dependencies: 180 2431
-- Data for Name: resourcemetaattribute; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY resourcemetaattribute (attributeid, domainid, attributename, description) FROM stdin;
\.


--
-- TOC entry 2412 (class 0 OID 81372)
-- Dependencies: 181 2431
-- Data for Name: resourcetype; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY resourcetype (domainid, resourcetypeid, createddatetime, updateddatetime, description, resourcetypename) FROM stdin;
\.


--
-- TOC entry 2413 (class 0 OID 81380)
-- Dependencies: 182 2431
-- Data for Name: resourcetype_resourcemetaattribute; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY resourcetype_resourcemetaattribute (resourcetype_domainid, resourcetype_resourcetypeid, metaattributes_attributeid, metaattributes_domainid) FROM stdin;
\.


--
-- TOC entry 2414 (class 0 OID 81388)
-- Dependencies: 183 2431
-- Data for Name: service; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY service (dtype, gridid, serviceid, createddatetime, updateddatetime, active, alternateserviceid, appauthkey, approved, containertype, copyrightinfo, federateduseallowed, howtogetmembershipinfo, instance, instancesize, instancetype, licenseinfo, membersonly, owneruserid, resourceid, servicedescription, servicename, servicetypedomainid, servicetypeid, streaming, timeoutmillis, usealternateservice, visible, wrappersourcecodeurlclazz, wrappersourcecodeurlstringvalue, wsdl, deployed, deployedid) FROM stdin;
\.


--
-- TOC entry 2423 (class 0 OID 81460)
-- Dependencies: 192 2431
-- Data for Name: service_allowedappprovision; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY service_allowedappprovision (service_gridid, service_serviceid, element) FROM stdin;
\.


--
-- TOC entry 2424 (class 0 OID 81466)
-- Dependencies: 193 2431
-- Data for Name: service_alloweduse; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY service_alloweduse (service_gridid, service_serviceid, element) FROM stdin;
\.


--
-- TOC entry 2425 (class 0 OID 81472)
-- Dependencies: 194 2431
-- Data for Name: service_partnerservicenamespaceuris; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY service_partnerservicenamespaceuris (service_gridid, service_serviceid, element) FROM stdin;
\.


--
-- TOC entry 2415 (class 0 OID 81396)
-- Dependencies: 184 2431
-- Data for Name: serviceactionschedule; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY serviceactionschedule (id, createddatetime, updateddatetime, actiontype, bookingdatetime, gridid, isrelated, nodeid, nodelocalid, targetid, targettype) FROM stdin;
\.


--
-- TOC entry 2416 (class 0 OID 81404)
-- Dependencies: 185 2431
-- Data for Name: serviceattribute; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY serviceattribute (gridid, name, serviceid, createddatetime, updateddatetime, value) FROM stdin;
\.


--
-- TOC entry 2417 (class 0 OID 81412)
-- Dependencies: 186 2431
-- Data for Name: servicedeployment; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY servicedeployment (gridid, nodeid, serviceid, createddatetime, updateddatetime, deployeddatetime, disabledbyerrordate, enabled, servicepath) FROM stdin;
\.


--
-- TOC entry 2418 (class 0 OID 81420)
-- Dependencies: 187 2431
-- Data for Name: serviceendpoint; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY serviceendpoint (gridid, protocolid, serviceid, url, createddatetime, updateddatetime, authpassword, authusername, averesponsemillis, disablereason, disabledbyerrordate, enabled, experience) FROM stdin;
\.


--
-- TOC entry 2419 (class 0 OID 81428)
-- Dependencies: 188 2431
-- Data for Name: serviceinterfacedefinition; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY serviceinterfacedefinition (id, definition, protocolid, servicetype_domainid, servicetype_servicetypeid) FROM stdin;
\.


--
-- TOC entry 2420 (class 0 OID 81436)
-- Dependencies: 189 2431
-- Data for Name: servicemetaattribute; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY servicemetaattribute (attributeid, domainid, createddatetime, updateddatetime, attributename, description) FROM stdin;
\.


--
-- TOC entry 2421 (class 0 OID 81444)
-- Dependencies: 190 2431
-- Data for Name: servicetype; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY servicetype (domainid, servicetypeid, createddatetime, updateddatetime, description, servicetypename) FROM stdin;
\.


--
-- TOC entry 2422 (class 0 OID 81452)
-- Dependencies: 191 2431
-- Data for Name: servicetype_servicemetaattribute; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY servicetype_servicemetaattribute (servicetype_domainid, servicetype_servicetypeid, metaattributes_attributeid, metaattributes_domainid) FROM stdin;
\.


--
-- TOC entry 2426 (class 0 OID 81478)
-- Dependencies: 195 2431
-- Data for Name: systemproperty; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY systemproperty (gridid, name, value) FROM stdin;
lapps	passwordExpirationDays	90
\.


--
-- TOC entry 2427 (class 0 OID 81486)
-- Dependencies: 196 2431
-- Data for Name: temporaryuser; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY temporaryuser (gridid, userid, createddatetime, updateddatetime, beginavailabledatetime, endavailabledatetime, parentuserid, password) FROM stdin;
\.


--
-- TOC entry 2428 (class 0 OID 81494)
-- Dependencies: 197 2431
-- Data for Name: userattribute; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY userattribute (gridid, name, userid, createddatetime, updateddatetime, value) FROM stdin;
\.


--
-- TOC entry 2429 (class 0 OID 81502)
-- Dependencies: 198 2431
-- Data for Name: userroles; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY userroles (gridid, rolename, userid) FROM stdin;
lapps	langriduser	operator
lapps	langridadmin	operator
\.


--
-- TOC entry 2430 (class 0 OID 81510)
-- Dependencies: 199 2431
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: langrid
--

COPY users (gridid, userid, createddatetime, updateddatetime, abletocallservices, address, defaultappprovisiontype, defaultusetype, emailaddress, homepageurlclazz, homepageurlstringvalue, organization, password, passwordchangeddate, representative, visible) FROM stdin;
lapps	operator	2013-12-03 14:46:00.128	2013-12-03 14:46:00.128	t	New York	CLIENT_CONTROL	NONPROFIT_USE	suderman@anc.org	java.net.URL	http://www.anc.org	American National Corpus	bc87235367eb9b67e1f5ffceb7a1e5506d2c3d92fc655b5b75b7b3892e7e7cdbc0f614147df2e89b44846f18f6d83c9246831b542b92ed5ad49cf1f6fbdcf73f	\N	Keith Suderman	t
\.


--
-- TOC entry 2304 (class 2606 OID 81224)
-- Dependencies: 161 161 2432
-- Name: acceptableremoteaddress_pkey; Type: CONSTRAINT; Schema: public; Owner: langrid; Tablespace: 
--

ALTER TABLE ONLY acceptableremoteaddress
    ADD CONSTRAINT acceptableremoteaddress_pkey PRIMARY KEY (address);


--
-- TOC entry 2306 (class 2606 OID 81232)
-- Dependencies: 162 162 162 162 162 162 162 2432
-- Name: accesslimit_pkey; Type: CONSTRAINT; Schema: public; Owner: langrid; Tablespace: 
--

ALTER TABLE ONLY accesslimit
    ADD CONSTRAINT accesslimit_pkey PRIMARY KEY (limittype, period, servicegridid, serviceid, usergridid, userid);


--
-- TOC entry 2308 (class 2606 OID 81240)
-- Dependencies: 163 163 2432
-- Name: accesslog_pkey; Type: CONSTRAINT; Schema: public; Owner: langrid; Tablespace: 
--

ALTER TABLE ONLY accesslog
    ADD CONSTRAINT accesslog_pkey PRIMARY KEY (id);


--
-- TOC entry 2310 (class 2606 OID 81248)
-- Dependencies: 164 164 164 164 164 2432
-- Name: accessright_pkey; Type: CONSTRAINT; Schema: public; Owner: langrid; Tablespace: 
--

ALTER TABLE ONLY accessright
    ADD CONSTRAINT accessright_pkey PRIMARY KEY (servicegridid, serviceid, usergridid, userid);


--
-- TOC entry 2312 (class 2606 OID 81256)
-- Dependencies: 165 165 165 165 165 165 165 165 2432
-- Name: accessstat_pkey; Type: CONSTRAINT; Schema: public; Owner: langrid; Tablespace: 
--

ALTER TABLE ONLY accessstat
    ADD CONSTRAINT accessstat_pkey PRIMARY KEY (basedatetime, nodeid, period, serviceandnodegridid, serviceid, usergridid, userid);


--
-- TOC entry 2314 (class 2606 OID 81264)
-- Dependencies: 166 166 2432
-- Name: domain_pkey; Type: CONSTRAINT; Schema: public; Owner: langrid; Tablespace: 
--

ALTER TABLE ONLY domain
    ADD CONSTRAINT domain_pkey PRIMARY KEY (domainid);


--
-- TOC entry 2316 (class 2606 OID 81272)
-- Dependencies: 167 167 167 2432
-- Name: federation_pkey; Type: CONSTRAINT; Schema: public; Owner: langrid; Tablespace: 
--

ALTER TABLE ONLY federation
    ADD CONSTRAINT federation_pkey PRIMARY KEY (sourcegridid, targetgridid);


--
-- TOC entry 2318 (class 2606 OID 81280)
-- Dependencies: 168 168 2432
-- Name: grid_pkey; Type: CONSTRAINT; Schema: public; Owner: langrid; Tablespace: 
--

ALTER TABLE ONLY grid
    ADD CONSTRAINT grid_pkey PRIMARY KEY (gridid);


--
-- TOC entry 2320 (class 2606 OID 81288)
-- Dependencies: 169 169 169 2432
-- Name: gridattribute_pkey; Type: CONSTRAINT; Schema: public; Owner: langrid; Tablespace: 
--

ALTER TABLE ONLY gridattribute
    ADD CONSTRAINT gridattribute_pkey PRIMARY KEY (gridid, name);


--
-- TOC entry 2322 (class 2606 OID 81302)
-- Dependencies: 171 171 171 171 2432
-- Name: invocation_pkey; Type: CONSTRAINT; Schema: public; Owner: langrid; Tablespace: 
--

ALTER TABLE ONLY invocation
    ADD CONSTRAINT invocation_pkey PRIMARY KEY (invocationname, ownerservicegridid, ownerserviceid);


--
-- TOC entry 2324 (class 2606 OID 81310)
-- Dependencies: 172 172 2432
-- Name: news_pkey; Type: CONSTRAINT; Schema: public; Owner: langrid; Tablespace: 
--

ALTER TABLE ONLY news
    ADD CONSTRAINT news_pkey PRIMARY KEY (id);


--
-- TOC entry 2326 (class 2606 OID 81318)
-- Dependencies: 173 173 173 2432
-- Name: node_pkey; Type: CONSTRAINT; Schema: public; Owner: langrid; Tablespace: 
--

ALTER TABLE ONLY node
    ADD CONSTRAINT node_pkey PRIMARY KEY (gridid, nodeid);


--
-- TOC entry 2328 (class 2606 OID 81326)
-- Dependencies: 174 174 174 174 2432
-- Name: nodeattribute_pkey; Type: CONSTRAINT; Schema: public; Owner: langrid; Tablespace: 
--

ALTER TABLE ONLY nodeattribute
    ADD CONSTRAINT nodeattribute_pkey PRIMARY KEY (gridid, name, nodeid);


--
-- TOC entry 2330 (class 2606 OID 81334)
-- Dependencies: 175 175 2432
-- Name: operationrequest_pkey; Type: CONSTRAINT; Schema: public; Owner: langrid; Tablespace: 
--

ALTER TABLE ONLY operationrequest
    ADD CONSTRAINT operationrequest_pkey PRIMARY KEY (id);


--
-- TOC entry 2332 (class 2606 OID 81339)
-- Dependencies: 176 176 176 176 2432
-- Name: overuselimit_pkey; Type: CONSTRAINT; Schema: public; Owner: langrid; Tablespace: 
--

ALTER TABLE ONLY overuselimit
    ADD CONSTRAINT overuselimit_pkey PRIMARY KEY (gridid, limittype, period);


--
-- TOC entry 2334 (class 2606 OID 81347)
-- Dependencies: 177 177 2432
-- Name: protocol_pkey; Type: CONSTRAINT; Schema: public; Owner: langrid; Tablespace: 
--

ALTER TABLE ONLY protocol
    ADD CONSTRAINT protocol_pkey PRIMARY KEY (protocolid);


--
-- TOC entry 2336 (class 2606 OID 81355)
-- Dependencies: 178 178 178 2432
-- Name: resource_pkey; Type: CONSTRAINT; Schema: public; Owner: langrid; Tablespace: 
--

ALTER TABLE ONLY resource
    ADD CONSTRAINT resource_pkey PRIMARY KEY (gridid, resourceid);


--
-- TOC entry 2338 (class 2606 OID 81363)
-- Dependencies: 179 179 179 179 2432
-- Name: resourceattribute_pkey; Type: CONSTRAINT; Schema: public; Owner: langrid; Tablespace: 
--

ALTER TABLE ONLY resourceattribute
    ADD CONSTRAINT resourceattribute_pkey PRIMARY KEY (gridid, name, resourceid);


--
-- TOC entry 2340 (class 2606 OID 81371)
-- Dependencies: 180 180 180 2432
-- Name: resourcemetaattribute_pkey; Type: CONSTRAINT; Schema: public; Owner: langrid; Tablespace: 
--

ALTER TABLE ONLY resourcemetaattribute
    ADD CONSTRAINT resourcemetaattribute_pkey PRIMARY KEY (attributeid, domainid);


--
-- TOC entry 2342 (class 2606 OID 81379)
-- Dependencies: 181 181 181 2432
-- Name: resourcetype_pkey; Type: CONSTRAINT; Schema: public; Owner: langrid; Tablespace: 
--

ALTER TABLE ONLY resourcetype
    ADD CONSTRAINT resourcetype_pkey PRIMARY KEY (domainid, resourcetypeid);


--
-- TOC entry 2344 (class 2606 OID 81387)
-- Dependencies: 182 182 182 182 182 2432
-- Name: resourcetype_resourcemetaattribute_pkey; Type: CONSTRAINT; Schema: public; Owner: langrid; Tablespace: 
--

ALTER TABLE ONLY resourcetype_resourcemetaattribute
    ADD CONSTRAINT resourcetype_resourcemetaattribute_pkey PRIMARY KEY (resourcetype_domainid, resourcetype_resourcetypeid, metaattributes_attributeid, metaattributes_domainid);


--
-- TOC entry 2346 (class 2606 OID 81395)
-- Dependencies: 183 183 183 2432
-- Name: service_pkey; Type: CONSTRAINT; Schema: public; Owner: langrid; Tablespace: 
--

ALTER TABLE ONLY service
    ADD CONSTRAINT service_pkey PRIMARY KEY (gridid, serviceid);


--
-- TOC entry 2348 (class 2606 OID 81403)
-- Dependencies: 184 184 2432
-- Name: serviceactionschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: langrid; Tablespace: 
--

ALTER TABLE ONLY serviceactionschedule
    ADD CONSTRAINT serviceactionschedule_pkey PRIMARY KEY (id);


--
-- TOC entry 2350 (class 2606 OID 81411)
-- Dependencies: 185 185 185 185 2432
-- Name: serviceattribute_pkey; Type: CONSTRAINT; Schema: public; Owner: langrid; Tablespace: 
--

ALTER TABLE ONLY serviceattribute
    ADD CONSTRAINT serviceattribute_pkey PRIMARY KEY (gridid, name, serviceid);


--
-- TOC entry 2352 (class 2606 OID 81419)
-- Dependencies: 186 186 186 186 2432
-- Name: servicedeployment_pkey; Type: CONSTRAINT; Schema: public; Owner: langrid; Tablespace: 
--

ALTER TABLE ONLY servicedeployment
    ADD CONSTRAINT servicedeployment_pkey PRIMARY KEY (gridid, nodeid, serviceid);


--
-- TOC entry 2354 (class 2606 OID 81427)
-- Dependencies: 187 187 187 187 187 2432
-- Name: serviceendpoint_pkey; Type: CONSTRAINT; Schema: public; Owner: langrid; Tablespace: 
--

ALTER TABLE ONLY serviceendpoint
    ADD CONSTRAINT serviceendpoint_pkey PRIMARY KEY (gridid, protocolid, serviceid, url);


--
-- TOC entry 2356 (class 2606 OID 81435)
-- Dependencies: 188 188 2432
-- Name: serviceinterfacedefinition_pkey; Type: CONSTRAINT; Schema: public; Owner: langrid; Tablespace: 
--

ALTER TABLE ONLY serviceinterfacedefinition
    ADD CONSTRAINT serviceinterfacedefinition_pkey PRIMARY KEY (id);


--
-- TOC entry 2358 (class 2606 OID 81443)
-- Dependencies: 189 189 189 2432
-- Name: servicemetaattribute_pkey; Type: CONSTRAINT; Schema: public; Owner: langrid; Tablespace: 
--

ALTER TABLE ONLY servicemetaattribute
    ADD CONSTRAINT servicemetaattribute_pkey PRIMARY KEY (attributeid, domainid);


--
-- TOC entry 2360 (class 2606 OID 81451)
-- Dependencies: 190 190 190 2432
-- Name: servicetype_pkey; Type: CONSTRAINT; Schema: public; Owner: langrid; Tablespace: 
--

ALTER TABLE ONLY servicetype
    ADD CONSTRAINT servicetype_pkey PRIMARY KEY (domainid, servicetypeid);


--
-- TOC entry 2362 (class 2606 OID 81459)
-- Dependencies: 191 191 191 191 191 2432
-- Name: servicetype_servicemetaattribute_pkey; Type: CONSTRAINT; Schema: public; Owner: langrid; Tablespace: 
--

ALTER TABLE ONLY servicetype_servicemetaattribute
    ADD CONSTRAINT servicetype_servicemetaattribute_pkey PRIMARY KEY (servicetype_domainid, servicetype_servicetypeid, metaattributes_attributeid, metaattributes_domainid);


--
-- TOC entry 2364 (class 2606 OID 81485)
-- Dependencies: 195 195 195 2432
-- Name: systemproperty_pkey; Type: CONSTRAINT; Schema: public; Owner: langrid; Tablespace: 
--

ALTER TABLE ONLY systemproperty
    ADD CONSTRAINT systemproperty_pkey PRIMARY KEY (gridid, name);


--
-- TOC entry 2366 (class 2606 OID 81493)
-- Dependencies: 196 196 196 2432
-- Name: temporaryuser_pkey; Type: CONSTRAINT; Schema: public; Owner: langrid; Tablespace: 
--

ALTER TABLE ONLY temporaryuser
    ADD CONSTRAINT temporaryuser_pkey PRIMARY KEY (gridid, userid);


--
-- TOC entry 2368 (class 2606 OID 81501)
-- Dependencies: 197 197 197 197 2432
-- Name: userattribute_pkey; Type: CONSTRAINT; Schema: public; Owner: langrid; Tablespace: 
--

ALTER TABLE ONLY userattribute
    ADD CONSTRAINT userattribute_pkey PRIMARY KEY (gridid, name, userid);


--
-- TOC entry 2370 (class 2606 OID 81509)
-- Dependencies: 198 198 198 198 2432
-- Name: userroles_pkey; Type: CONSTRAINT; Schema: public; Owner: langrid; Tablespace: 
--

ALTER TABLE ONLY userroles
    ADD CONSTRAINT userroles_pkey PRIMARY KEY (gridid, rolename, userid);


--
-- TOC entry 2372 (class 2606 OID 81517)
-- Dependencies: 199 199 199 2432
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: langrid; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (gridid, userid);


--
-- TOC entry 2391 (class 2606 OID 81608)
-- Dependencies: 2371 198 198 199 199 2432
-- Name: fk138359b24397de4e; Type: FK CONSTRAINT; Schema: public; Owner: langrid
--

ALTER TABLE ONLY userroles
    ADD CONSTRAINT fk138359b24397de4e FOREIGN KEY (gridid, userid) REFERENCES users(gridid, userid);


--
-- TOC entry 2388 (class 2606 OID 81593)
-- Dependencies: 193 2345 183 183 193 2432
-- Name: fk475482a99f50ea; Type: FK CONSTRAINT; Schema: public; Owner: langrid
--

ALTER TABLE ONLY service_alloweduse
    ADD CONSTRAINT fk475482a99f50ea FOREIGN KEY (service_gridid, service_serviceid) REFERENCES service(gridid, serviceid);


--
-- TOC entry 2377 (class 2606 OID 81538)
-- Dependencies: 173 174 173 174 2325 2432
-- Name: fk47bee9a3769b0fc; Type: FK CONSTRAINT; Schema: public; Owner: langrid
--

ALTER TABLE ONLY nodeattribute
    ADD CONSTRAINT fk47bee9a3769b0fc FOREIGN KEY (gridid, nodeid) REFERENCES node(gridid, nodeid);


--
-- TOC entry 2383 (class 2606 OID 81568)
-- Dependencies: 187 2345 183 183 187 2432
-- Name: fk75b47b4aae317d2a; Type: FK CONSTRAINT; Schema: public; Owner: langrid
--

ALTER TABLE ONLY serviceendpoint
    ADD CONSTRAINT fk75b47b4aae317d2a FOREIGN KEY (gridid, serviceid) REFERENCES service(gridid, serviceid);


--
-- TOC entry 2373 (class 2606 OID 81518)
-- Dependencies: 169 168 2317 2432
-- Name: fk8a29bdd675664ba3; Type: FK CONSTRAINT; Schema: public; Owner: langrid
--

ALTER TABLE ONLY gridattribute
    ADD CONSTRAINT fk8a29bdd675664ba3 FOREIGN KEY (gridid) REFERENCES grid(gridid);


--
-- TOC entry 2374 (class 2606 OID 81523)
-- Dependencies: 2313 166 170 2432
-- Name: fk93f1bfdd1ee372dd; Type: FK CONSTRAINT; Schema: public; Owner: langrid
--

ALTER TABLE ONLY grid_domain
    ADD CONSTRAINT fk93f1bfdd1ee372dd FOREIGN KEY (supporteddomains_domainid) REFERENCES domain(domainid);


--
-- TOC entry 2375 (class 2606 OID 81528)
-- Dependencies: 170 168 2317 2432
-- Name: fk93f1bfdd2b95a2bc; Type: FK CONSTRAINT; Schema: public; Owner: langrid
--

ALTER TABLE ONLY grid_domain
    ADD CONSTRAINT fk93f1bfdd2b95a2bc FOREIGN KEY (grid_gridid) REFERENCES grid(gridid);


--
-- TOC entry 2384 (class 2606 OID 81573)
-- Dependencies: 188 2359 190 190 188 2432
-- Name: fk96b87a9789e2063c; Type: FK CONSTRAINT; Schema: public; Owner: langrid
--

ALTER TABLE ONLY serviceinterfacedefinition
    ADD CONSTRAINT fk96b87a9789e2063c FOREIGN KEY (servicetype_domainid, servicetype_servicetypeid) REFERENCES servicetype(domainid, servicetypeid);


--
-- TOC entry 2390 (class 2606 OID 81603)
-- Dependencies: 197 2371 199 199 197 2432
-- Name: fka57722f14397de4e; Type: FK CONSTRAINT; Schema: public; Owner: langrid
--

ALTER TABLE ONLY userattribute
    ADD CONSTRAINT fka57722f14397de4e FOREIGN KEY (gridid, userid) REFERENCES users(gridid, userid);


--
-- TOC entry 2389 (class 2606 OID 81598)
-- Dependencies: 194 2345 183 183 194 2432
-- Name: fka588be0b87a4cbd5; Type: FK CONSTRAINT; Schema: public; Owner: langrid
--

ALTER TABLE ONLY service_partnerservicenamespaceuris
    ADD CONSTRAINT fka588be0b87a4cbd5 FOREIGN KEY (service_gridid, service_serviceid) REFERENCES service(gridid, serviceid);


--
-- TOC entry 2381 (class 2606 OID 81558)
-- Dependencies: 185 185 2345 183 183 2432
-- Name: fkb0860387ae317d2a; Type: FK CONSTRAINT; Schema: public; Owner: langrid
--

ALTER TABLE ONLY serviceattribute
    ADD CONSTRAINT fkb0860387ae317d2a FOREIGN KEY (gridid, serviceid) REFERENCES service(gridid, serviceid);


--
-- TOC entry 2386 (class 2606 OID 81583)
-- Dependencies: 191 2357 189 189 191 2432
-- Name: fkb825ec52244d194; Type: FK CONSTRAINT; Schema: public; Owner: langrid
--

ALTER TABLE ONLY servicetype_servicemetaattribute
    ADD CONSTRAINT fkb825ec52244d194 FOREIGN KEY (metaattributes_attributeid, metaattributes_domainid) REFERENCES servicemetaattribute(attributeid, domainid);


--
-- TOC entry 2385 (class 2606 OID 81578)
-- Dependencies: 191 2359 190 190 191 2432
-- Name: fkb825ec5289e2063c; Type: FK CONSTRAINT; Schema: public; Owner: langrid
--

ALTER TABLE ONLY servicetype_servicemetaattribute
    ADD CONSTRAINT fkb825ec5289e2063c FOREIGN KEY (servicetype_domainid, servicetype_servicetypeid) REFERENCES servicetype(domainid, servicetypeid);


--
-- TOC entry 2382 (class 2606 OID 81563)
-- Dependencies: 186 183 183 2345 186 2432
-- Name: fkbba77f3aae317d2a; Type: FK CONSTRAINT; Schema: public; Owner: langrid
--

ALTER TABLE ONLY servicedeployment
    ADD CONSTRAINT fkbba77f3aae317d2a FOREIGN KEY (gridid, serviceid) REFERENCES service(gridid, serviceid);


--
-- TOC entry 2387 (class 2606 OID 81588)
-- Dependencies: 192 2345 183 183 192 2432
-- Name: fkc487fcd29f50ea; Type: FK CONSTRAINT; Schema: public; Owner: langrid
--

ALTER TABLE ONLY service_allowedappprovision
    ADD CONSTRAINT fkc487fcd29f50ea FOREIGN KEY (service_gridid, service_serviceid) REFERENCES service(gridid, serviceid);


--
-- TOC entry 2376 (class 2606 OID 81533)
-- Dependencies: 183 171 171 183 2345 2432
-- Name: fkde7454b0f16056f9; Type: FK CONSTRAINT; Schema: public; Owner: langrid
--

ALTER TABLE ONLY invocation
    ADD CONSTRAINT fkde7454b0f16056f9 FOREIGN KEY (ownerservicegridid, ownerserviceid) REFERENCES service(gridid, serviceid);


--
-- TOC entry 2380 (class 2606 OID 81553)
-- Dependencies: 182 182 2341 181 181 2432
-- Name: fkf0fbfc123ea0cd14; Type: FK CONSTRAINT; Schema: public; Owner: langrid
--

ALTER TABLE ONLY resourcetype_resourcemetaattribute
    ADD CONSTRAINT fkf0fbfc123ea0cd14 FOREIGN KEY (resourcetype_domainid, resourcetype_resourcetypeid) REFERENCES resourcetype(domainid, resourcetypeid);


--
-- TOC entry 2379 (class 2606 OID 81548)
-- Dependencies: 180 182 182 2339 180 2432
-- Name: fkf0fbfc12dbe76963; Type: FK CONSTRAINT; Schema: public; Owner: langrid
--

ALTER TABLE ONLY resourcetype_resourcemetaattribute
    ADD CONSTRAINT fkf0fbfc12dbe76963 FOREIGN KEY (metaattributes_attributeid, metaattributes_domainid) REFERENCES resourcemetaattribute(attributeid, domainid);


--
-- TOC entry 2378 (class 2606 OID 81543)
-- Dependencies: 2335 179 179 178 178 2432
-- Name: fkfe52f60e6d276c14; Type: FK CONSTRAINT; Schema: public; Owner: langrid
--

ALTER TABLE ONLY resourceattribute
    ADD CONSTRAINT fkfe52f60e6d276c14 FOREIGN KEY (gridid, resourceid) REFERENCES resource(gridid, resourceid);


--
-- TOC entry 2437 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2013-12-03 14:49:53 EST

--
-- PostgreSQL database dump complete
--

