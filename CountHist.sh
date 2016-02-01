#!/bin/bash

Dirs="dqm_testPR12213VSorig_BeamHalowf8p0
dqm_testPR12213VSorig_RunCosmics2011Awf4p22
dqm_testPR12213VSorig_RunHI2011wf140p53
dqm_testPR12213VSorig_RunMinBias2011Awf1000p0
dqm_testPR12213VSorig_RunMinBias2011Awf1001p0
dqm_testPR12213VSorig_RunMinBias2011Awf4p17
dqm_testPR12213VSorig_RunMinBias2011Bwf4p29
dqm_testPR12213VSorig_RunPhoton2012Bwf4p53
dqm_testPR12213VSorig_TTbarFSwf5p1
dqm_testPR12213VSorig_TTbarPUwf50202p0
dqm_testPR12213VSorig_TTbarwf25p0
dqm_testPR12213VSorig_ZEEFS13wf135p4
dqm_testPR12213VSorig_ZEEwf200p0
dqm_testPR12213VSorig_ZMM13TeVwf1330p0
dqm_testPR12213VSorig_ZMuSkim2011Bwf4p37"

for Dir in $Dirs
do
   echo -e "++++++++++++++++++++++++++++++++++++++++++"
   echo -e "$Dir"

   TotL=`cat ${Dir}/${Dir}_0_2.ps.log | grep "Save : " | wc -l`
   gt10L=`cat ${Dir}/${Dir}_0_2.ps.log | grep "Save : " |grep "==>" | wc -l`
   
  ## Basic info is summarized in ${Dir}/${Dir}_0_2.ps.log files,
  ## (ex) Save :/DQMData/XXX/hxPrimaryVertex-DataBase(hName) :176(Eref) :184(Enew) :0.0102582(KS) :234(Diff) :==> 1.3(FC)
  ## count the # of histograms passed different thresholds of P(KS) or Fractional Changes[FC=Diff/(0.5*(Eref+Enew))]
  
   ksL0=`cat ${Dir}/${Dir}_0_2.ps.log | grep "Save : "|awk -F: '{if( 0.00 <= $5 && $5 < 0.01){print $5}}'| wc -l `
   ksL1=`cat ${Dir}/${Dir}_0_2.ps.log | grep "Save : "|awk -F: '{if( 0.01 <= $5 && $5 < 0.03){print $5}}'| wc -l `
   ksL2=`cat ${Dir}/${Dir}_0_2.ps.log | grep "Save : "|awk -F: '{if( 0.03 <= $5 && $5 < 0.05){print $5}}'| wc -l `
   ksL3=`cat ${Dir}/${Dir}_0_2.ps.log | grep "Save : "|awk -F: '{if( 0.05 <= $5 && $5 < 0.07){print $5}}'| wc -l `
   ksL4=`cat ${Dir}/${Dir}_0_2.ps.log | grep "Save : "|awk -F: '{if( 0.07 <= $5 && $5 < 0.1){print $5}}'| wc -l `
   ksL5=`cat ${Dir}/${Dir}_0_2.ps.log | grep "Save : "|awk -F: '{if( 0.1 <= $5 ){print $5}}'| wc -l `

   fcL0=`cat ${Dir}/${Dir}_0_2.ps.log | grep "Save : "|awk -F'==>' '{if( 0.0 <= $2 && $2 < 0.2){print $2}}'| wc -l `
   fcL1=`cat ${Dir}/${Dir}_0_2.ps.log | grep "Save : "|awk -F'==>' '{if( 0.2 <= $2 && $2 < 0.5){print $2}}'| wc -l `
   fcL2=`cat ${Dir}/${Dir}_0_2.ps.log | grep "Save : "|awk -F'==>' '{if( 0.5 <= $2 && $2 < 0.7){print $2}}'| wc -l `
   fcL3=`cat ${Dir}/${Dir}_0_2.ps.log | grep "Save : "|awk -F'==>' '{if( 0.7 <= $2 && $2 < 1.0){print $2}}'| wc -l `
   fcL4=`cat ${Dir}/${Dir}_0_2.ps.log | grep "Save : "|awk -F'==>' '{if( 1.0 <= $2 && $2 < 1.5){print $2}}'| wc -l `
   fcL5=`cat ${Dir}/${Dir}_0_2.ps.log | grep "Save : "|awk -F'==>' '{if( 1.5 <= $2 ){print $2}}'| wc -l `

   echo -e "Total saved Hist Count = ${TotL} , Min(Entry(ref,new))>10 = ${gt10L} "
   echo -e "0.00 <= P(KS)< 0.01 = ${ksL0}, 0.0 <= FractionalChanges < 0.2 = ${fcL0}"
   echo -e "0.01 <= P(KS)< 0.03 = ${ksL1}, 0.2 <= FractionalChanges < 0.5 = ${fcL1}" 
   echo -e "0.03 <= P(KS)< 0.05 = ${ksL2}, 0.5 <= FractionalChanges < 0.7 = ${fcL2}" 
   echo -e "0.05 <= P(KS)< 0.07 = ${ksL3}, 0.7 <= FractionalChanges < 1.0 = ${fcL3}" 
   echo -e "0.07 <= P(KS)< 0.10 = ${ksL4}, 1.0 <= FractionalChanges < 1.5 = ${fcL4}" 
   echo -e "0.10 <= P(KS)       = ${ksL5}, 1.5 <= FractionalChanges       = ${fcL5}"

done
