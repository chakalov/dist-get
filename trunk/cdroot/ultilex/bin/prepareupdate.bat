@echo off
SETLOCAL=ENABLEDELAYEDEXPANSION

if (%1) == () goto missingParameter

REM ******************************
REM Check the meta structure BEGIN
REM ******************************
if not exist ..\..\%1\meta\meta goto corruptedOldMetaData
if not exist ..\..\%1\meta\includes goto corruptedOldMetaData
if not exist ..\..\%1\meta\menu.cfg goto corruptedOldMetaData
if not exist ..\..\%1\meta\add.cfg goto corruptedOldMetaData

if not exist ..\..\%1\temp\meta goto corruptedNewMetaData
if not exist ..\..\%1\temp\includes goto corruptedNewMetaData
if not exist ..\..\%1\temp\menu.cfg goto corruptedNewMetaData
if not exist ..\..\%1\temp\add.cfg goto corruptedNewMetaData
REM ****************************
REM Check the meta structure END
REM ****************************

REM ***********************************************
REM Check if distribution needs to be updated BEGIN
REM ***********************************************
set oldMeta=..\..\%1\meta
set newMeta=..\..\%1\temp

for /f %%v in ('readproperty !oldMeta!\meta md5') do set oldMD5=%%v
for /f %%v in ('readproperty !newMeta!\meta md5') do set newMD5=%%v

if !newMD5!==!oldMD5! (
	echo 0 > temp_eq.tmp
) else (
	echo 1 > temp_neq.tmp
)
REM *********************************************
REM Check if distribution needs to be updated END
REM *********************************************

goto end

:corruptedOldMetaData
echo.
call printerror corrupted_old_meta_data %1
echo.
goto end

:corruptedNewMetaData
echo.
call printerror corrupted_new_meta_data %1
echo.
goto end

:missingParameter
echo.
call printerror missing_param
echo.
goto end

:end