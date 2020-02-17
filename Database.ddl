DROP TABLE contact cascade constraints;
DROP TABLE volunteer_event cascade constraints;
DROP TABLE "Parent/Guardian" cascade constraints;
DROP TABLE buddy cascade constraints;
DROP TABLE volunteer cascade constraints;
DROP TABLE supervisor cascade constraints;
DROP TABLE event cascade constraints;
DROP TABLE adoption cascade constraints;
DROP TABLE location cascade constraints;
DROP TABLE organization cascade constraints;
DROP TABLE road cascade constraints;

CREATE TABLE adoption (
    adoptionnum                   CHAR(10 CHAR) NOT NULL,
    adoptiondate                  DATE,
    organization_organizationid   CHAR(10 CHAR) NOT NULL,
    location_startmile            NUMBER(6,2) NOT NULL,
    location_roadid               VARCHAR2(6 CHAR) NOT NULL
);

CREATE UNIQUE INDEX adoption__idx ON
    adoption (
        location_startmile
    ASC,
        location_roadid
    ASC );

ALTER TABLE adoption ADD CONSTRAINT adoption_pk PRIMARY KEY ( adoptionnum );

CREATE TABLE buddy (
    volunteer_volunteerid    CHAR(10 CHAR) NOT NULL,
    volunteer_volunteerid1   CHAR(10 CHAR) NOT NULL
);

CREATE UNIQUE INDEX buddy__idx ON
    buddy (
        volunteer_volunteerid
    ASC );

CREATE UNIQUE INDEX buddy__idxv1 ON
    buddy (
        volunteer_volunteerid1
    ASC );

ALTER TABLE buddy ADD CONSTRAINT buddy_pk PRIMARY KEY ( volunteer_volunteerid,
                                                        volunteer_volunteerid1 );

CREATE TABLE contact (
    contactid                     CHAR(10 CHAR) NOT NULL,
    name                          VARCHAR2(50 CHAR),
    street                        VARCHAR2(40 CHAR),
    city                          VARCHAR2(40 CHAR),
    state                         CHAR(2),
    ZIP                           CHAR(5),
    phone                         VARCHAR2(12 CHAR),
    email                         VARCHAR2(40 CHAR),
    organization_organizationid   CHAR(10 CHAR) NOT NULL
);

CREATE UNIQUE INDEX contact__idx ON
    contact (
        organization_organizationid
    ASC );

ALTER TABLE contact ADD CONSTRAINT contact_pk PRIMARY KEY ( contactid );

CREATE TABLE event (
    eventid                CHAR(10 CHAR) NOT NULL,
    startdate              DATE,
    length                 NUMBER(4,2),
    bagsfilled             INTEGER,
    adoption_adoptionnum   CHAR(10 CHAR) NOT NULL
);

ALTER TABLE event ADD CONSTRAINT event_pk PRIMARY KEY ( eventid );

CREATE TABLE location (
    startmile     NUMBER(6,2) NOT NULL,
    endmile       NUMBER(6,2),
    signtext      VARCHAR2(50 CHAR),
    road_roadid   VARCHAR2(6 CHAR) NOT NULL
);

ALTER TABLE location ADD CONSTRAINT location_pk PRIMARY KEY ( startmile,
                                                              road_roadid );

CREATE TABLE organization (
    organizationid   CHAR(10 CHAR) NOT NULL,
    name             VARCHAR2(50 CHAR)
);

ALTER TABLE organization ADD CONSTRAINT organization_pk PRIMARY KEY ( organizationid );

CREATE TABLE "Parent/Guardian" (
    parentname              VARCHAR2(50 CHAR) NOT NULL,
    phone                   CHAR(12 CHAR),
    volunteer_volunteerid   CHAR(10 CHAR) NOT NULL
);

CREATE UNIQUE INDEX "Parent/Guardian__IDX" ON
    "Parent/Guardian" (
        volunteer_volunteerid
    ASC );

ALTER TABLE "Parent/Guardian" ADD CONSTRAINT "Parent/Guardian_PK" PRIMARY KEY ( parentname,
                                                                                volunteer_volunteerid );

CREATE TABLE road (
    roadid       VARCHAR2(6 CHAR) NOT NULL,
    roadname     VARCHAR2(30 CHAR),
    roadsuffix   VARCHAR2(10 CHAR),
    roadlength   NUMBER(6,2)
);

ALTER TABLE road ADD CONSTRAINT road_pk PRIMARY KEY ( roadid );

CREATE TABLE supervisor (
    volunteer_volunteerid    CHAR(10 CHAR) NOT NULL,
    volunteer_volunteerid1   CHAR(10 CHAR) NOT NULL
);

CREATE UNIQUE INDEX supervisor__idx ON
    supervisor (
        volunteer_volunteerid1
    ASC );

ALTER TABLE supervisor ADD CONSTRAINT supervisor_pk PRIMARY KEY ( volunteer_volunteerid,
                                                                    volunteer_volunteerid1);

CREATE TABLE volunteer (
    volunteerid   CHAR(10 CHAR) NOT NULL,
    name          VARCHAR2(50 CHAR),
    dob           DATE,
    street        VARCHAR2(40 CHAR),
    city          VARCHAR2(40 CHAR),
    state         CHAR(2),
    ZIP          CHAR(5),
    phone         CHAR(12 CHAR),
    email         VARCHAR2(40 CHAR)
);

ALTER TABLE volunteer ADD CONSTRAINT volunteer_pk PRIMARY KEY ( volunteerid );

CREATE TABLE volunteer_event (
    volunteer_volunteerid   CHAR(10 CHAR) NOT NULL,
    event_eventid           CHAR(10 CHAR) NOT NULL
);

ALTER TABLE volunteer_event ADD CONSTRAINT volunteer_event_pk PRIMARY KEY ( volunteer_volunteerid,
                                                                            event_eventid );

ALTER TABLE adoption
    ADD CONSTRAINT adoption_location_fk FOREIGN KEY ( location_startmile,
                                                      location_roadid )
        REFERENCES location ( startmile,
                              road_roadid );

ALTER TABLE adoption
    ADD CONSTRAINT adoption_organization_fk FOREIGN KEY ( organization_organizationid )
        REFERENCES organization ( organizationid );

ALTER TABLE buddy
    ADD CONSTRAINT buddy_volunteer_fk FOREIGN KEY ( volunteer_volunteerid )
        REFERENCES volunteer ( volunteerid );

ALTER TABLE buddy
    ADD CONSTRAINT buddy_volunteer_fkv2 FOREIGN KEY ( volunteer_volunteerid1 )
        REFERENCES volunteer ( volunteerid );

ALTER TABLE contact
    ADD CONSTRAINT contact_organization_fk FOREIGN KEY ( organization_organizationid )
        REFERENCES organization ( organizationid );

ALTER TABLE event
    ADD CONSTRAINT event_adoption_fk FOREIGN KEY ( adoption_adoptionnum )
        REFERENCES adoption ( adoptionnum );

ALTER TABLE location
    ADD CONSTRAINT location_road_fk FOREIGN KEY ( road_roadid )
        REFERENCES road ( roadid );

ALTER TABLE "Parent/Guardian"
    ADD CONSTRAINT "Parent/Guardian_Volunteer_FK" FOREIGN KEY ( volunteer_volunteerid )
        REFERENCES volunteer ( volunteerid );

ALTER TABLE supervisor
    ADD CONSTRAINT supervisor_volunteer_fk FOREIGN KEY ( volunteer_volunteerid )
        REFERENCES volunteer ( volunteerid );

ALTER TABLE supervisor
    ADD CONSTRAINT supervisor_volunteer_fkv2 FOREIGN KEY ( volunteer_volunteerid1 )
        REFERENCES volunteer ( volunteerid );

ALTER TABLE volunteer_event
    ADD CONSTRAINT volunteer_event_event_fk FOREIGN KEY ( event_eventid )
        REFERENCES event ( eventid );

ALTER TABLE volunteer_event
    ADD CONSTRAINT volunteer_event_volunteer_fk FOREIGN KEY ( volunteer_volunteerid )
        REFERENCES volunteer ( volunteerid );
        
commit;