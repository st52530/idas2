-- Generated by Oracle SQL Developer Data Modeler 17.4.0.355.2121
--   at:        2018-11-20 14:44:25 CET
--   site:      Oracle Database 12c
--   type:      Oracle Database 12c



CREATE TABLE sem_fakulta (
    id        INTEGER NOT NULL,
    zkratka   VARCHAR2(10 CHAR) NOT NULL,
    nazev     VARCHAR2(255 CHAR) NOT NULL
);

ALTER TABLE sem_fakulta ADD CONSTRAINT sem_fakulta_pk PRIMARY KEY ( id );

CREATE TABLE sem_forma_vyuky (
    id      INTEGER NOT NULL,
    nazev   VARCHAR2(50 CHAR) NOT NULL
);

ALTER TABLE sem_forma_vyuky ADD CONSTRAINT sem_forma_vyuky_pk PRIMARY KEY ( id );

CREATE TABLE sem_katedra (
    id           INTEGER NOT NULL,
    zkratka      VARCHAR2(10 CHAR) NOT NULL,
    nazev        VARCHAR2(255 CHAR) NOT NULL,
    fakulta_id   INTEGER NOT NULL
);

ALTER TABLE sem_katedra ADD CONSTRAINT sem_katedra_pk PRIMARY KEY ( id );

CREATE TABLE sem_kategorie (
    id      INTEGER NOT NULL,
    nazev   VARCHAR2(50 CHAR) NOT NULL
);

ALTER TABLE sem_kategorie ADD CONSTRAINT sem_kategorie_pk PRIMARY KEY ( id );

CREATE TABLE sem_mistnost (
    id         INTEGER NOT NULL,
    nazev      VARCHAR2(50 CHAR) NOT NULL,
    kapacita   INTEGER NOT NULL
);

ALTER TABLE sem_mistnost ADD CONSTRAINT sem_mistnost_pk PRIMARY KEY ( id );

CREATE TABLE sem_obor (
    id               INTEGER NOT NULL,
    nazev            VARCHAR2(50 CHAR) NOT NULL,
    odhad_studentu   INTEGER NOT NULL
);

ALTER TABLE sem_obor ADD CONSTRAINT sem_obor_pk PRIMARY KEY ( id );

CREATE TABLE sem_obrazek (
    id          INTEGER NOT NULL,
    obrazek     BLOB NOT NULL,
    pripona     VARCHAR2(10 CHAR) NOT NULL,
    vytvoreno   DATE NOT NULL,
    upraveno    DATE
);

ALTER TABLE sem_obrazek ADD CONSTRAINT sem_obrazek_pk PRIMARY KEY ( id );

CREATE TABLE sem_predm_obor (
    id               INTEGER NOT NULL,
    pocet_studentu   INTEGER NOT NULL,
    rocnik           INTEGER NOT NULL,
    kategorie_id     INTEGER NOT NULL,
    obor_id          INTEGER NOT NULL,
    predmet_id       INTEGER NOT NULL
);

ALTER TABLE sem_predm_obor ADD CONSTRAINT sem_predm_obor_pk PRIMARY KEY ( id );

CREATE TABLE sem_predmet (
    id                    INTEGER NOT NULL,
    zkratka               VARCHAR2(10 CHAR) NOT NULL,
    nazev                 VARCHAR2(255 CHAR) NOT NULL,
    forma_vyuky_id        INTEGER NOT NULL,
    zpusob_zakonceni_id   INTEGER NOT NULL
);

ALTER TABLE sem_predmet ADD CONSTRAINT sem_predmet_pk PRIMARY KEY ( id );

CREATE TABLE sem_role (
    id      INTEGER NOT NULL,
    nazev   VARCHAR2(50 CHAR) NOT NULL
);

ALTER TABLE sem_role ADD CONSTRAINT sem_role_pk PRIMARY KEY ( id );

CREATE TABLE sem_rozvrh (
    id                             INTEGER NOT NULL,
    den                            INTEGER NOT NULL,
    zacatek                        INTEGER NOT NULL,
    mistnost_id                    INTEGER NOT NULL,
    zpusob_zakonceni_predmetu_id   INTEGER NOT NULL,
    uci_id                         INTEGER NOT NULL
);

COMMENT ON COLUMN sem_rozvrh.den IS
    'den v tydnu <0, 6> - 0 znamena pondeli, 6 znamena nedele';

ALTER TABLE sem_rozvrh ADD CONSTRAINT sem_rozvrh_pk PRIMARY KEY ( id );

CREATE TABLE sem_uci (
    id              INTEGER NOT NULL,
    ucitel_id       INTEGER NOT NULL,
    role_id         INTEGER NOT NULL,
    predm_obor_id   INTEGER NOT NULL
);

ALTER TABLE sem_uci ADD CONSTRAINT sem_uci_pk PRIMARY KEY ( id );

CREATE TABLE sem_ucitel (
    id                INTEGER NOT NULL,
    jmeno             VARCHAR2(80 CHAR) NOT NULL,
    prijmeni          VARCHAR2(80 CHAR) NOT NULL,
    titul_pred        VARCHAR2(40 CHAR),
    titul_za          VARCHAR2(40 CHAR),
    telefon           VARCHAR2(13 CHAR),
    mobil             VARCHAR2(13 CHAR),
    kontaktni_email   VARCHAR2(255 CHAR),
    katedra_id        INTEGER NOT NULL,
    obrazek_id        INTEGER
);

ALTER TABLE sem_ucitel ADD CONSTRAINT sem_ucitel_pk PRIMARY KEY ( id );

CREATE TABLE sem_uzivatel (
    id          INTEGER NOT NULL,
    email       VARCHAR2(255 CHAR) NOT NULL,
    password    CHAR(60 CHAR) NOT NULL,
    admin       NUMBER(1) NOT NULL,
    ucitel_id   INTEGER
);

ALTER TABLE sem_uzivatel ADD CONSTRAINT sem_uzivatel_pk PRIMARY KEY ( id );

CREATE TABLE sem_zpus_predm (
    id                INTEGER NOT NULL,
    pocet_hodin       INTEGER NOT NULL,
    kapacita          INTEGER NOT NULL,
    zpusob_vyuky_id   INTEGER NOT NULL,
    predm_obor_id     INTEGER NOT NULL
);

ALTER TABLE sem_zpus_predm ADD CONSTRAINT sem_zpus_predm_pk PRIMARY KEY ( id );

CREATE TABLE sem_zpus_vyuky (
    id      INTEGER NOT NULL,
    nazev   VARCHAR2(50 CHAR) NOT NULL
);

ALTER TABLE sem_zpus_vyuky ADD CONSTRAINT sem_zpus_vyuky_pk PRIMARY KEY ( id );

CREATE TABLE sem_zpus_zak (
    id      INTEGER NOT NULL,
    nazev   VARCHAR2(50 CHAR) NOT NULL
);

ALTER TABLE sem_zpus_zak ADD CONSTRAINT sem_zpus_zak_pk PRIMARY KEY ( id );

ALTER TABLE sem_katedra
    ADD CONSTRAINT sem_katedra_sem_fakulta_fk FOREIGN KEY ( fakulta_id )
        REFERENCES sem_fakulta ( id );

ALTER TABLE sem_predm_obor
    ADD CONSTRAINT sem_predm_obor_kategorie_fk FOREIGN KEY ( kategorie_id )
        REFERENCES sem_kategorie ( id );

ALTER TABLE sem_predm_obor
    ADD CONSTRAINT sem_predm_obor_sem_obor_fk FOREIGN KEY ( obor_id )
        REFERENCES sem_obor ( id );

ALTER TABLE sem_predm_obor
    ADD CONSTRAINT sem_predm_obor_sem_predmet_fk FOREIGN KEY ( predmet_id )
        REFERENCES sem_predmet ( id );

ALTER TABLE sem_predmet
    ADD CONSTRAINT sem_predmet_sem_forma_vyuky_fk FOREIGN KEY ( forma_vyuky_id )
        REFERENCES sem_forma_vyuky ( id );

ALTER TABLE sem_predmet
    ADD CONSTRAINT sem_predmet_sem_zpus_zak_fk FOREIGN KEY ( zpusob_zakonceni_id )
        REFERENCES sem_zpus_zak ( id );

ALTER TABLE sem_rozvrh
    ADD CONSTRAINT sem_rozvrh_sem_mistnost_fk FOREIGN KEY ( mistnost_id )
        REFERENCES sem_mistnost ( id );

ALTER TABLE sem_rozvrh
    ADD CONSTRAINT sem_rozvrh_sem_uci_fk FOREIGN KEY ( uci_id )
        REFERENCES sem_uci ( id );

ALTER TABLE sem_rozvrh
    ADD CONSTRAINT sem_rozvrh_sem_zpus_predm_fk FOREIGN KEY ( zpusob_zakonceni_predmetu_id )
        REFERENCES sem_zpus_predm ( id );

ALTER TABLE sem_uci
    ADD CONSTRAINT sem_uci_sem_predm_obor_fk FOREIGN KEY ( predm_obor_id )
        REFERENCES sem_predm_obor ( id );

ALTER TABLE sem_uci
    ADD CONSTRAINT sem_uci_sem_role_fk FOREIGN KEY ( role_id )
        REFERENCES sem_role ( id );

ALTER TABLE sem_uci
    ADD CONSTRAINT sem_uci_sem_ucitel_fk FOREIGN KEY ( ucitel_id )
        REFERENCES sem_ucitel ( id );

ALTER TABLE sem_ucitel
    ADD CONSTRAINT sem_ucitel_sem_katedra_fk FOREIGN KEY ( katedra_id )
        REFERENCES sem_katedra ( id );

ALTER TABLE sem_ucitel
    ADD CONSTRAINT sem_ucitel_sem_obrazek_fk FOREIGN KEY ( obrazek_id )
        REFERENCES sem_obrazek ( id );

ALTER TABLE sem_uzivatel
    ADD CONSTRAINT sem_uzivatel_sem_ucitel_fk FOREIGN KEY ( ucitel_id )
        REFERENCES sem_ucitel ( id );

ALTER TABLE sem_zpus_predm
    ADD CONSTRAINT sem_zpus_predm_predm_obor_fk FOREIGN KEY ( predm_obor_id )
        REFERENCES sem_predm_obor ( id );

ALTER TABLE sem_zpus_predm
    ADD CONSTRAINT sem_zpus_predm_vyuky_fk FOREIGN KEY ( zpusob_vyuky_id )
        REFERENCES sem_zpus_vyuky ( id );



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            17
-- CREATE INDEX                             0
-- ALTER TABLE                             34
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- TSDP POLICY                              0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
