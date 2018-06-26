-- Purpose: Set up the DIRECTORY object for this lesson.
-- This script MUST be executed before you can demo the BFILENAME function 
-- and before the students can complete the practice.
-- Steps:   Execute this script
--  ***   You must login to the Oracle host machine and 
-- detemine the home directory path of the instructor account.
--  ***  You must fill in the location of the COUNTRY_PIC, MEDIA_FILES, and
--        UTL_FILE directories on the SERVER
--  ***  connect as system/manager@    

-- YOU CAN EXECUTE THIS AS TEACH USER BUT MUST REPLACE SUPPLY THE ORACLE_HOME path
-- on the server for your database when prompted. TO demo uncomment the REM's in
-- the CREATE OR REPLACE DIRECTORY STATEMENTS HERE.

-- *********************************************************************
-- NOTE THESE NEED NOT BE DONE AS THE SETUP HAS PROVIDED THESE FOR YOU
-- *********************************************************************

--fill in database connection
REM CREATE OR REPLACE DIRECTORY MEDIA_FILES AS '&&ORACLE_HOME/MEDIA_FILES'; 

-- fill in file location on the server between the quotes
REM CREATE OR REPLACE DIRECTORY COUNTRY_PIC AS '$&ORACLE_HOME/COUNTRY_PIC'; 

-- fill in file location on the server between the quotes
REM CREATE OR REPLACE DIRECTORY UTL_FILE AS '&ORACLE_HOME/UTL_FILE'; 

GRANT READ ON DIRECTORY MEDIA_FILES TO PUBLIC;
GRANT READ ON DIRECTORY COUNTRY_PIC TO PUBLIC;
GRANT READ, WRITE ON DIRECTORY UTL_FILE TO PUBLIC;


