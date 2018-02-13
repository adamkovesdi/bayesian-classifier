#!/bin/bash

find -name output.txt | awk -F'/' '{print "cp " $0  " traindata/" $3 ".txt";}' | sh
