#!/bin/bash
# Task 1: Greeter with Age Check
if [ $# -lt 2 ]; then
    echo "Ussage: $0 <name> <age>"
    exit 1 
fi

name=$1
age=$2

echo "Hello, $name!"

if [ "$age" -ge 18 ]; then
      echo "You are an adult."
else
     echo "You are a minor."
fi




#!/bin/bash
# Task 2: Even or Odd

if [ $# -ne 1 ]; then
   echo "Usage: $0 <number>"
    exit 1
fi

n=$1

if [ $((n % 2)) -eq 0 ]; then
    echo "$n is even"
else
    echo "$n is odd"
fi




#!/bin/bash
# Task 3: File Inspector

if [ $# -ne 1 ]; then
    echo"Usage: $0 <path>"
exit 1
fi

f=$1

if  [ ! -e "$f" ]; then
   echo "Not found: $f"
exit 2
fi

if [ -d "$f" ]; then
     echo "Directory"
else
     echo "File, $(wc -c < "$f") bytes"
fi

if [ -r "$f" ]; then
      echo "Readable"
else
     echo "Not readable"
fi




#!/bin/bash
# Task 4: Mini Calculator

if [ $# -ne 3 ]; then
    echo "Usage: $0 <num1> <op> <num2>"
     exit 1
fi

a=$1
op=$2
b=$3

case $op in 
    +) echo $((a + b));;
    -) echo $((a - b));;
    x) echo $((a * b));;
    /) 
        if [ "$b" -eq 0 ]; then
          echo "Division by zero"
          exit 3
     fi
      echo $((a / b ));;
    *)
      echo "Unknown operator: $op"
      exit 2;;
esac




#!/bin/bash
# Task 5: System Report Tool
# Usage: ./systemreport.sh [basic|disk|user] [directory]
echo "=== System Report ==="

HOST=$(hostname)
USER_NAME=$(whoami)
NOW=$(date +"%Y-%m-%d %H:%M")
echo "Host: $HOST | User: $USER_NAME"
echo "Date: $NOW"

MODE=${1:-basic}
DIR=${2:-/}
echo "Mode: $MODE (args: $#)"

if [ $# -gt 2 ]; then
echo "Usage: $0 [basic|disk|user|mem] [dir]"
exit 1
fi

case "$MODE" in
basic) echo "Kernel: $(uname -r)"
echo "Arch: $(uname -m)"
echo "Uptime: $(uptime -p)";;
disk)
if [ ! -d "$DIR" ]; then
echo "Error: $DIR is not a directory"
exit 3
fi

USED=$(df "$DIR" | awk 'NR==2 {print $5}' | tr -d '%')
echo "Disk usage of $DIR: $USED%"
if [ "$USED" -ge 90 ]; then
echo "Status: CRITICAL"
elif [ "$USED" -ge 70 ]; then
echo "Status: WARNING"
else
echo "Status: OK"
fi 

;;
user)
PROCS=$(ps -u "$USER_NAME" --no-headers | wc -l)
echo "Home: $HOME | Shell: $SHELL"
echo "Processes: $PROCS"
if [ "$(id -u)" -eq 0 ]; then
echo "WARNING: running as root"
fi
;;
mem)
echo "Memory information:"
free -m;;
*) echo "Unknown mode: $MODE"
exit 2;;
esac

echo "=== Report finished ==="
exit 0