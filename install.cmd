@echo off

rem Installer/updater for the LabNPF_workstation Folder
rem	https://github.com/LabNPF/LabNPF_workstation
rem 	Fernando Ferreira-Santos (Laboratory of Neuropsychophysiology, University of Porto)

echo.
echo ** Installer/updater for the LabNPF_workstation Folder
echo ** https://github.com/LabNPF/LabNPF_workstation

if exist C:\LabNPF_workstation\ (
		echo.
		echo Previous installation of the LabNPF_workstation folder found. If you proceed, the previous folder version and any changes you have made will be replaced, but all matlab toolboxes will be preserved.
		
		choice /M "Proceed with update?"
		rem Note: choice errorlevel options must be in reverse order:
		if errorlevel ==2 goto exit_cancel
		if errorlevel ==1 goto run
				
		:run
		echo.
		
		echo Step 1: renaming previous installation to "_old".
		ren C:\LabNPF_workstation LabNPF_workstation_old
		
		echo Step 2: moving new version of the folder to C:\LabNPF_workstation.
		move "%CD%\LabNPF_workstation" C:\LabNPF_workstation
		
		echo Step 3: moving any existing matlab toolboxes to the new installation.
		del /Q C:\LabNPF_workstation_old\matlab_toolboxes\*.*
		ren C:\LabNPF_workstation\matlab_toolboxes matlab_toolboxes_temp
		move C:\LabNPF_workstation_old\matlab_toolboxes C:\LabNPF_workstation\
		copy C:\LabNPF_workstation\matlab_toolboxes_temp\*.* C:\LabNPF_workstation\matlab_toolboxes
		del /Q C:\LabNPF_workstation\matlab_toolboxes_temp\*.*
		rmdir /Q C:\LabNPF_workstation\matlab_toolboxes_temp\
		
		echo Step 4: delete remnants of "_old" instalation.
		del /S /Q C:\LabNPF_workstation_old\*.*
		rmdir /S /Q C:\LabNPF_workstation_old\
	) 
	
if not exist C:\LabNPF_workstation\ (
		echo.
		echo No previous installation found. The folder "C:\LabNPF_workstation\" will be created.
		move "%CD%\LabNPF_workstation" C:\LabNPF_workstation
		goto exit
	)

:exit
echo.
echo LabNPF_workstation Folder installation completed. The installation/update process moves the new folder so to reinstall/update please download again.
echo.
echo To use, complete the final installation steps (add to MATLAB path) as described: https://github.com/LabNPF/LabNPF_workstation#instalationupdate
echo.
pause
goto :EOF

:exit_cancel
echo.
echo LabNPF_workstation Folder installation canceled.
echo.
pause
