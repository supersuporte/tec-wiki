-- Execute next line in the O/S command line on server
--    mkdir /temp/data_files
--
-- NOTE: To do this demo, instead of making and referencing the /temp directory here
--       replace <Course-ORACLE_HOME> the full directory of you ORACLE_HOME for 
--       this instance of the course, such as, /home1/teach7/
-- The MEDIA_FILES subdirectory should exists with files whose names match the 
-- first names of employees in department 60.
-- 
-- CREATE DIRECTORY data_files AS '/temp/data_files';
--
REM
REM YOU MUST EXECUTE THIS AS THE TEACH USER OR A DB and remove the
rem COMMENT CHARACTERS.  this is not required FOR THIS COURSE. AS media_files 
rem IS DEFINED. AND CAN BE USED.
REM
-- CREATE DIRECTORY data_files AS '&oracle_home/MEDIA_FILES';
-- GRANT READ ON DIRECTORY data_files TO SCOTT, MANAGER_ROLE, PUBLIC;
