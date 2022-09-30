#!/bin/bash
nohup ./start_master.sh  >/dev/null 2>&1 &
nohup ./start_caves.sh    >/dev/null 2>&1 &

