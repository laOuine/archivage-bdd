@echo off
REM Archivage de Sauvegarde / version 2.3

REM année mois jour depuis fonction date
set annee=%date:~6,4%
set mois=%date:~3,2%
set jour=%date:~0,2%

REM *********************
REM **** PARAMETRAGE ****
REM *********************

REM Repertoire où se trouve le script et 7zip
set reptrav=C:\script_bdd\

REM Repertoire où se trouve le fichier de sauvegarde
set repsauve=C:\sauvegarde_bdd\

REM Dossier d'archivage
set reparch=C:\Archives_bdd

REM Nom du fichier de sauvegarde
set fic=mabase

REM Extension du fichier de sauvegarde
set ext=bak

REM Nom du fichier .zip
set ficzip=mabase

REM Nombres de jours avant nettoyage (entre 1 et 30)
set nbrjours=15

REM ****************************
REM **** FIN DU PARAMETRAGE ****
REM ****************************

REM Deplacement dans le repertoire de travail
cd %reptrav%

REM Zip du fichier bak
7za.exe a -tzip "%reparch%\%fic%_%annee%-%mois%-%jour%".zip "%repsauve%\%fic%.%ext%"

REM Suppression du 0 devant le mois
set /a mois=100%mois%%%100

REM Suppression du 0 devant le jour
set /a jour=100%jour%%%100

REM Application du nombre de jours avant nettoyage
set /a jour=%jour%-%nbrjours%

REM Gestion du mois précédent
if %jour% LSS 1 (set /a jour=%jour%+30& set /a mois=%mois%-1)

REM Gestion de l'année précédente
if %mois% LSS 1 (set /a mois=%mois%+12& set /a annee=%annee%-1)

REM Gestion du mois antéprécédent
set /a mois2=%mois%-1

REM Gestion de l'anneé précédente du mois antéprécédent
set annee2=%annee%
set chgannee=non

REM Gestion de l'année précédente du mois antéprécédent
if %mois2% LSS 1 (set /a mois2=%mois2%+12& set /a annee2=%annee%-1& set chgannee=oui)

REM Ajout du 0 devant le mois
if %mois% LSS 10 set mois=0%mois%

REM Ajout du 0 devant le mois antéprécédent
if %mois2% LSS 10 set mois2=0%mois2%

REM Ajout du 0 devant le jour
if %jour% LSS 10 set jour=0%jour%

REM Nettoyage des anciennes archives
del %reparch%\%ficzip%_%annee%-%mois%-%jour%.zip
if %chgannee% EQU non (del %reparch%\%ficzip%_%annee%-%mois2%-*.zip)
if %chgannee% EQU oui (del %reparch%\%ficzip%_%annee2%-%mois2%-*.zip)

REM FIN
