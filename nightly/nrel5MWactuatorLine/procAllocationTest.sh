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

if [ -f $CWD/PASS_PAT ]; then
    # already ran this test
    didSimulationDiffAnywhere=0
else
    mpiexec -np 4 ../../naluX -i procAllocationTest.i -o procAllocationTest.log --pprint &> log.procAllocationTest

    didSimulationDiffAnywhere=0    
    cat procAllocationTest.log.4.0 procAllocationTest.log.4.1 procAllocationTest.log.4.2 procAllocationTest.log.4.3 > allProcAllocationTest.log
    if [ $? -gt 0 ]; then
	echo "Came here 3"	
	didSimulationDiffAnywhere=1
    else
	echo "Came here"
	diff allProcAllocationTest.log allProcAllocationTest.log.gold
	if [ $? -gt 0 ]; then
	    echo "Came here 2"
	    didSimulationDiffAnywhere=1
	fi
    fi
fi

# write the file based on final status
if [ "$didSimulationDiffAnywhere" -gt 0 ]; then
    PASS_STATUS=0
else
    PASS_STATUS=1
    echo $PASS_STATUS > PASS_PAT
fi

# report it; 30 spaces
GlobalPerformanceTime=`grep "STKPERF: Total Time" procAllocationTest.log  | awk '{print $4}'`
if [ $PASS_STATUS -ne 1 ]; then
    echo -e "..procAllocationTest................ FAILED":" " $GlobalPerformanceTime " s" " max diff: " $GlobalMaxSolutionDiff
else
    echo -e "..procAllocationTest................ PASSED":" " $GlobalPerformanceTime " s"
fi

exit
