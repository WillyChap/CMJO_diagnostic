#!/bin/bash
#PBS -N MakeLAG
#PBS -A NAML0001
#PBS -l walltime=03:00:00
#PBS -o XCorr_FLT2000_prelim.ne30pg3_ne30pg3_mg17.TestGustGlobal_cam6_3_112_fullOutput_gustsOFF_withFix_DerchoTest.006.out
#PBS -e XCorr_FLT2000_prelim.ne30pg3_ne30pg3_mg17.TestGustGlobal_cam6_3_112_fullOutput_gustsOFF_withFix_DerchoTest.006_data.out
#PBS -q casper
#PBS -l select=1:ncpus=10:mem=110GB
#PBS -m a
#PBS -M wchapman@ucar.edu

module load conda
conda activate /glade/u/apps/opt/conda/envs/npl-2023b

# Define the base directory for input files
DIR_IN="/glade/derecho/scratch/wchapman/ADF/FLT2000_prelim.ne30pg3_ne30pg3_mg17.TestGustGlobal_cam6_3_112_fullOutput_gustsOFF_withFix_DerchoTest.006/ts/climo"

# Array of filenames and corresponding variable names
declare -a FILES=(
    "FLT2000_prelim.ne30pg3_ne30pg3_mg17.TestGustGlobal_cam6_3_112_fullOutput_gustsOFF_withFix_DerchoTest.006.cam.h1a.LHFLX.anomalies.0001010200000-0012122400000.nc LHFLX FLT2000_prelim.ne30pg3_ne30pg3_mg17.TestGustGlobal_cam6_3_112_fullOutput_gustsOFF_withFix_DerchoTest.006.cam.h1a.U850.anomalies.0001010200000-0012122400000.nc U850"
    "FLT2000_prelim.ne30pg3_ne30pg3_mg17.TestGustGlobal_cam6_3_112_fullOutput_gustsOFF_withFix_DerchoTest.006.cam.h1a.PRECT.anomalies.0001010200000-0012122400000.nc PRECT FLT2000_prelim.ne30pg3_ne30pg3_mg17.TestGustGlobal_cam6_3_112_fullOutput_gustsOFF_withFix_DerchoTest.006.cam.h1a.U850.anomalies.0001010200000-0012122400000.nc U850"
    "FLT2000_prelim.ne30pg3_ne30pg3_mg17.TestGustGlobal_cam6_3_112_fullOutput_gustsOFF_withFix_DerchoTest.006.cam.h1a.FLUT.anomalies.0001010200000-0012122400000.nc FLUT FLT2000_prelim.ne30pg3_ne30pg3_mg17.TestGustGlobal_cam6_3_112_fullOutput_gustsOFF_withFix_DerchoTest.006.cam.h1a.U850.anomalies.0001010200000-0012122400000.nc U850"
)

# Loop through the array and execute the Python script for each file and variable
for item in "${FILES[@]}"; do
    # Split item into filename and variable name
    read -r f_precip_in var_name_precip f_u_in var_name_u <<< "$item"
    # Execute the Python script
    python 09_mjoxcor_lag_season.py --dir_in "${DIR_IN}" --f_precip_in "${f_precip_in}" --var_name_precip "${var_name_precip}" --f_u_in "${f_u_in}" --var_name_u "${var_name_u}"
done
