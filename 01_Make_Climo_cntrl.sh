#!/bin/bash
#PBS -N MakeClimo
#PBS -A NAML0001
#PBS -l walltime=03:00:00
#PBS -o 01_MakeClimo_FLT2000_prelim.ne30pg3_ne30pg3_mg17.TestGustGlobal_cam6_3_112_fullOutput_gustsOFF_withFix_DerchoTest.006.out
#PBS -e 01_MakeClimo_FLT2000_prelim.ne30pg3_ne30pg3_mg17.TestGustGlobal_cam6_3_112_fullOutput_gustsOFF_withFix_DerchoTest.006.out
#PBS -q casper
#PBS -l select=1:ncpus=10:mem=110GB
#PBS -m a
#PBS -M wchapman@ucar.edu

module load conda
conda activate /glade/u/apps/opt/conda/envs/npl-2023b

# Define the base directory for input files

# DIR_IN="/glade/derecho/scratch/wchapman/ADF/ERA5_data/ts/"
# #Array of filenames and corresponding variable names
# declare -a FILES=(
#     "ERA5.h1a.umag10.1979010100000-1993123100000.nc umag10"
# )

DIR_IN="/glade/derecho/scratch/wchapman/ADF/FLT2000_prelim.ne30pg3_ne30pg3_mg17.TestGustGlobal_cam6_3_112_fullOutput_gustsOFF_withFix_DerchoTest.006/ts/"
#Array of filenames and corresponding variable names
declare -a FILES=(
    "FLT2000_prelim.ne30pg3_ne30pg3_mg17.TestGustGlobal_cam6_3_112_fullOutput_gustsOFF_withFix_DerchoTest.006.cam.h1a.V200.0001010200000-0012122400000.nc V200"
    "FLT2000_prelim.ne30pg3_ne30pg3_mg17.TestGustGlobal_cam6_3_112_fullOutput_gustsOFF_withFix_DerchoTest.006.cam.h1a.U850.0001010200000-0012122400000.nc U850"
    "FLT2000_prelim.ne30pg3_ne30pg3_mg17.TestGustGlobal_cam6_3_112_fullOutput_gustsOFF_withFix_DerchoTest.006.cam.h1a.U200.0001010200000-0012122400000.nc U200"
    "FLT2000_prelim.ne30pg3_ne30pg3_mg17.TestGustGlobal_cam6_3_112_fullOutput_gustsOFF_withFix_DerchoTest.006.cam.h1a.FLUT.0001010200000-0012122400000.nc FLUT"
    "FLT2000_prelim.ne30pg3_ne30pg3_mg17.TestGustGlobal_cam6_3_112_fullOutput_gustsOFF_withFix_DerchoTest.006.cam.h1a.Z500.0001010200000-0012122400000.nc Z500"
    "FLT2000_prelim.ne30pg3_ne30pg3_mg17.TestGustGlobal_cam6_3_112_fullOutput_gustsOFF_withFix_DerchoTest.006.cam.h1a.PRECT.0001010200000-0012122400000.nc PRECT"
    "FLT2000_prelim.ne30pg3_ne30pg3_mg17.TestGustGlobal_cam6_3_112_fullOutput_gustsOFF_withFix_DerchoTest.006.cam.h1a.LHFLX.0001010200000-0012122400000.nc LHFLX"
    "FLT2000_prelim.ne30pg3_ne30pg3_mg17.TestGustGlobal_cam6_3_112_fullOutput_gustsOFF_withFix_DerchoTest.006.cam.h1a.U10.0001010200000-0012122400000.nc U10"
    "FLT2000_prelim.ne30pg3_ne30pg3_mg17.TestGustGlobal_cam6_3_112_fullOutput_gustsOFF_withFix_DerchoTest.006.cam.h1a.UBOT.0001010200000-0012122400000.nc UBOT"
    "FLT2000_prelim.ne30pg3_ne30pg3_mg17.TestGustGlobal_cam6_3_112_fullOutput_gustsOFF_withFix_DerchoTest.006.cam.h1a.VBOT.0001010200000-0012122400000.nc VBOT"
    "FLT2000_prelim.ne30pg3_ne30pg3_mg17.TestGustGlobal_cam6_3_112_fullOutput_gustsOFF_withFix_DerchoTest.006.cam.h1a.TBOT.0001010200000-0012122400000.nc TBOT"
    "FLT2000_prelim.ne30pg3_ne30pg3_mg17.TestGustGlobal_cam6_3_112_fullOutput_gustsOFF_withFix_DerchoTest.006.cam.h1a.QREFHT.0001010200000-0012122400000.nc QREFHT"
    "FLT2000_prelim.ne30pg3_ne30pg3_mg17.TestGustGlobal_cam6_3_112_fullOutput_gustsOFF_withFix_DerchoTest.006.cam.h1a.SHFLX.0001010200000-0012122400000.nc SHFLX"
    "FLT2000_prelim.ne30pg3_ne30pg3_mg17.TestGustGlobal_cam6_3_112_fullOutput_gustsOFF_withFix_DerchoTest.006.cam.h1a.OMEGA500.0001010200000-0012122400000.nc OMEGA500"
)

# Loop through the array and execute the Python script for each file and variable
for item in "${FILES[@]}"; do
    # Split item into filename and variable name
    read -r f_in var_name <<< "$item"
    # Execute the Python script
    python 01_Make_Climo.py --dir_in "${DIR_IN}" --f_in "${f_in}" --var_name "${var_name}"
done
