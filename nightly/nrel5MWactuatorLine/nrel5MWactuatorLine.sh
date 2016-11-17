#!/bin/bash
. ../../pass_fail.sh

CWD=$(pwd)
didSimulationDiffAnywhere=0

# determine tolerance
testTol=0.00000001
platform=`uname`
if [ "$platform" == 'Linux' ]; then
    testTol=0.0000000000000001
fi

# set the global diff
GlobalMaxSolutionDiff=-1000000000.0

if [ -f $CWD/PASS_NREL5MW ]; then
    # already ran this test
    didSimulationDiffAnywhere=0
else
    mpiexec -np 4 ../../naluX -i nrel5MWactuatorLine.i -o nrel5MWactuatorLine.log --pprint &> log.nrel5MWactuatorLine

    didSimulationDiffAnywhere=0    
    if [ -f nrel5MWactuatorLine.log ]; then
	grep Node nrel5MWactuatorLine.log > fastOutput.log
	diff fastOutput.log fastOutput.log.gold
	if [ $? -gt 0 ]; then
	    didSimulationDiffAnywhere=1
	else
	    if [ -f nrel5MWactuatorLine.log.4.0 ]; then
		diff nrel5MWactuatorLine.log.4.0 nrel5MWactuatorLine.log.4.0.gold
		didSimulationDiffAnywhere=$?
	    else
		didSimulationDiffAnywhere=1
	    fi
	fi
    else
	didSimulationDiffAnywhere=1
    fi
fi

# write the file based on final status
if [ "$didSimulationDiffAnywhere" -gt 0 ]; then
    PASS_STATUS=0
else
    PASS_STATUS=1
    echo $PASS_STATUS > PASS_NREL5MW
fi

# report it; 30 spaces
GlobalPerformanceTime=`grep "STKPERF: Total Time" nrel5MWactuatorLine.log  | awk '{print $4}'`
if [ $PASS_STATUS -ne 1 ]; then
    echo -e "..nrel5MWactuatorLine................ FAILED":" " $GlobalPerformanceTime " s" " max diff: " $GlobalMaxSolutionDiff
else
    echo -e "..nrel5MWactuatorLine................ PASSED":" " $GlobalPerformanceTime " s"
fi

exit
