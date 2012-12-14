
CREATE TABLE "QUAN" (
    "ID_QUAN" NVARCHAR2(10) NOT NULL PRIMARY KEY,
    "TEN_QUAN" NVARCHAR2(50)
)
;
CREATE TABLE "NGUOI_DAN" (
    "ID_NGUOIDAN" NVARCHAR2(10) NOT NULL PRIMARY KEY,
    "HO_DEM" NVARCHAR2(50),
    "TEN" NVARCHAR2(50),
    "NGAY_SINH" DATE NOT NULL,
    "QUOC_TICH" NVARCHAR2(2),
    "QUE_QUAN" NVARCHAR2(100),
    "DIA_CHI_THUONG_TRU" NVARCHAR2(100),
    "DIA_CHI_TAM_TRU" NVARCHAR2(100),
    "THU_AN" NUMBER(1) CHECK ("THU_AN" IN (0,1)) NOT NULL,
    "TAM_THAN" NUMBER(1) CHECK ("TAM_THAN" IN (0,1)) NOT NULL,
    "QUAN_ID" NVARCHAR2(10) NOT NULL REFERENCES "QUAN" ("ID_QUAN") DEFERRABLE INITIALLY DEFERRED
)
;
CREATE TABLE "KY_BAU_CU" (
    "ID_KYBAUCU" NVARCHAR2(10) NOT NULL PRIMARY KEY,
    "TEN_KYBAUCU" NVARCHAR2(100),
    "BAT_DAU" TIMESTAMP NOT NULL,
    "KET_THUC" TIMESTAMP NOT NULL
)
;
CREATE TABLE "TO_LAP_DANH_SACH" (
    "ID_NGUOILAP" NVARCHAR2(10) NOT NULL PRIMARY KEY,
    "KYBAUCU_ID" NVARCHAR2(10) NOT NULL REFERENCES "KY_BAU_CU" ("ID_KYBAUCU") DEFERRABLE INITIALLY DEFERRED,
    "QUAN_ID" NVARCHAR2(10) NOT NULL REFERENCES "QUAN" ("ID_QUAN") DEFERRABLE INITIALLY DEFERRED,
    "HO_DEM" NVARCHAR2(50),
    "TEN" NVARCHAR2(50),
    UNIQUE ("KYBAUCU_ID", "ID_NGUOILAP", "QUAN_ID")
)
;
CREATE TABLE "TO_THEO_DOI" (
    "ID_NGUOITHEODOI" NVARCHAR2(10) NOT NULL PRIMARY KEY,
    "KYBAUCU_ID" NVARCHAR2(10) NOT NULL REFERENCES "KY_BAU_CU" ("ID_KYBAUCU") DEFERRABLE INITIALLY DEFERRED,
    "HO_DEM" NVARCHAR2(50),
    "TEN" NVARCHAR2(50),
    UNIQUE ("KYBAUCU_ID", "ID_NGUOITHEODOI")
)
;
CREATE TABLE "TO_GIAM_SAT" (
    "ID_NGUOIGIAMSAT" NVARCHAR2(10) NOT NULL PRIMARY KEY,
    "KYBAUCU_ID" NVARCHAR2(10) NOT NULL REFERENCES "KY_BAU_CU" ("ID_KYBAUCU") DEFERRABLE INITIALLY DEFERRED,
    "HO_DEM" NVARCHAR2(50),
    "TEN" NVARCHAR2(50),
    UNIQUE ("KYBAUCU_ID", "ID_NGUOIGIAMSAT")
)
;
CREATE TABLE "DANH_SACH_UNG_VIEN" (
    "ID" NUMBER(11) NOT NULL PRIMARY KEY,
    "KYBAUCU_ID" NVARCHAR2(10) NOT NULL REFERENCES "KY_BAU_CU" ("ID_KYBAUCU") DEFERRABLE INITIALLY DEFERRED,
    "UNG_VIEN_ID" NVARCHAR2(10) NOT NULL REFERENCES "NGUOI_DAN" ("ID_NGUOIDAN") DEFERRABLE INITIALLY DEFERRED,
    UNIQUE ("KYBAUCU_ID", "UNG_VIEN_ID")
)
;

DECLARE
    i INTEGER;
BEGIN
    SELECT COUNT(*) INTO i FROM USER_CATALOG
        WHERE TABLE_NAME = 'DANH_SACH_UNG_VIEN_SQ' AND TABLE_TYPE = 'SEQUENCE';
    IF i = 0 THEN
        EXECUTE IMMEDIATE 'CREATE SEQUENCE "DANH_SACH_UNG_VIEN_SQ"';
    END IF;
END;
/

CREATE OR REPLACE TRIGGER "DANH_SACH_UNG_VIEN_TR"
BEFORE INSERT ON "DANH_SACH_UNG_VIEN"
FOR EACH ROW
WHEN (new."ID" IS NULL)
    BEGIN
        SELECT "DANH_SACH_UNG_VIEN_SQ".nextval
        INTO :new."ID" FROM dual;
    END;
/
CREATE TABLE "DANH_SACH_CU_TRI" (
    "ID" NUMBER(11) NOT NULL PRIMARY KEY,
    "KYBAUCU_ID" NVARCHAR2(10) NOT NULL REFERENCES "KY_BAU_CU" ("ID_KYBAUCU") DEFERRABLE INITIALLY DEFERRED,
    "NGUOI_DAN_ID" NVARCHAR2(10) NOT NULL REFERENCES "NGUOI_DAN" ("ID_NGUOIDAN") DEFERRABLE INITIALLY DEFERRED,
    "DA_BAU" NUMBER(1) CHECK ("DA_BAU" IN (0,1)) NOT NULL,
    UNIQUE ("KYBAUCU_ID", "NGUOI_DAN_ID")
)
;

DECLARE
    i INTEGER;
BEGIN
    SELECT COUNT(*) INTO i FROM USER_CATALOG
        WHERE TABLE_NAME = 'DANH_SACH_CU_TRI_SQ' AND TABLE_TYPE = 'SEQUENCE';
    IF i = 0 THEN
        EXECUTE IMMEDIATE 'CREATE SEQUENCE "DANH_SACH_CU_TRI_SQ"';
    END IF;
END;
/

CREATE OR REPLACE TRIGGER "DANH_SACH_CU_TRI_TR"
BEFORE INSERT ON "DANH_SACH_CU_TRI"
FOR EACH ROW
WHEN (new."ID" IS NULL)
    BEGIN
        SELECT "DANH_SACH_CU_TRI_SQ".nextval
        INTO :new."ID" FROM dual;
    END;
/
CREATE TABLE "KET_QUA_BAU" (
    "CU_TRI_ID" NUMBER(11) NOT NULL PRIMARY KEY REFERENCES "DANH_SACH_CU_TRI" ("ID") DEFERRABLE INITIALLY DEFERRED,
    "BAU_CHO_ID" NUMBER(11) REFERENCES "DANH_SACH_UNG_VIEN" ("ID") DEFERRABLE INITIALLY DEFERRED
)
;
CREATE TABLE "KET_QUA_UNG_VIEN" (
    "UNG_VIEN_ID" NUMBER(11) NOT NULL PRIMARY KEY REFERENCES "DANH_SACH_UNG_VIEN" ("ID") DEFERRABLE INITIALLY DEFERRED,
    "SOPHIEU" NUMBER(11) NOT NULL
)
;

COMMIT;
