﻿
GRANT SELECT ON ISSVOTE.NGUOI_DAN TO ISS_ROLE;

  CREATE OR REPLACE PROCEDURE "ISSVOTE"."CREATE_USER" 
( user_id VARCHAR)
IS
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  EXECUTE IMMEDIATE 'CREATE USER "' || user_id ||
 '" IDENTIFIED BY "' || user_id || '"';
END;
/

  CREATE OR REPLACE PROCEDURE "ISSVOTE"."DROP_USER" 
( user_id VARCHAR)
IS
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  EXECUTE IMMEDIATE 'DROP USER "' || user_id ||
 '" CASCADE';
END;
/

  CREATE OR REPLACE PROCEDURE "ISSVOTE"."GRANT_ROLE" 
( role VARCHAR, user_id VARCHAR)
IS
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  EXECUTE IMMEDIATE 'GRANT  "' || role || '" TO "'|| user_id ||'" ';
END;
/

  CREATE OR REPLACE TRIGGER "ISSVOTE"."NGUOI_DAN_CREATE_USER_TR" 
AFTER INSERT ON NGUOI_DAN
FOR EACH ROW 
BEGIN
  create_user(:new.id_nguoidan);
  grant_role('ISS_ROLE',:new.id_nguoidan);
END;


/
ALTER TRIGGER "ISSVOTE"."NGUOI_DAN_CREATE_USER_TR" ENABLE;
 

  CREATE OR REPLACE TRIGGER "ISSVOTE"."NGUOI_DAN_DROP_USER_TR" 
AFTER DELETE ON NGUOI_DAN
FOR EACH ROW 
BEGIN
  drop_user(:old.id_nguoidan);
END;


/
ALTER TRIGGER "ISSVOTE"."NGUOI_DAN_DROP_USER_TR" ENABLE;

  CREATE OR REPLACE TRIGGER "ISSVOTE"."TO_GIAM_SAT_CREATE_USER_TR" 
AFTER INSERT ON TO_GIAM_SAT
FOR EACH ROW 
BEGIN
  create_user(:new.id_nguoigiamsat);
  grant_role('ISS_ROLE',:new.id_nguoigiamsat);
END;


/
ALTER TRIGGER "ISSVOTE"."TO_GIAM_SAT_CREATE_USER_TR" ENABLE;
 

  CREATE OR REPLACE TRIGGER "ISSVOTE"."TO_GIAM_SAT_DROP_USER_TR" 
AFTER DELETE ON TO_GIAM_SAT
FOR EACH ROW 
BEGIN
  drop_user(:old.id_nguoigiamsat);
END;


/
ALTER TRIGGER "ISSVOTE"."TO_LDS_CREATE_USER_TR" ENABLE;

  CREATE OR REPLACE TRIGGER "ISSVOTE"."TO_LDS_CREATE_USER_TR" 
AFTER INSERT ON TO_LAP_DANH_SACH
FOR EACH ROW 
BEGIN
  create_user(:new.id_nguoilap);
  grant_role('ISS_ROLE',:new.id_nguoilap);
END;


/
ALTER TRIGGER "ISSVOTE"."TO_LDS_CREATE_USER_TR" ENABLE;
 

  CREATE OR REPLACE TRIGGER "ISSVOTE"."TO_LAP_DANH_SACH_DROP_USER_TR" 
AFTER DELETE ON TO_LAP_DANH_SACH
FOR EACH ROW 
BEGIN
  drop_user(:old.id_nguoilap);
END;


/
ALTER TRIGGER "ISSVOTE"."TO_LAP_DANH_SACH_DROP_USER_TR" ENABLE;

  CREATE OR REPLACE TRIGGER "ISSVOTE"."TO_THEO_DOI_CREATE_USER_TR" 
AFTER INSERT ON TO_THEO_DOI
FOR EACH ROW 
BEGIN
  create_user(:new.id_nguoitheodoi);
  grant_role('ISS_ROLE',:new.id_nguoitheodoi);
END;


/
ALTER TRIGGER "ISSVOTE"."TO_THEO_DOI_CREATE_USER_TR" ENABLE;
 

  CREATE OR REPLACE TRIGGER "ISSVOTE"."TO_THEO_DOI_DROP_USER_TR" 
AFTER DELETE ON TO_THEO_DOI
FOR EACH ROW 
BEGIN
  drop_user(:old.id_nguoitheodoi);
END;


/
ALTER TRIGGER "ISSVOTE"."TO_THEO_DOI_DROP_USER_TR" ENABLE;