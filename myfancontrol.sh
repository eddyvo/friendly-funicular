#!/bin/bash 

input=$(find /sys/devices/platform/coretemp.0 -name "temp1_input")
output=$(find /sys -name "pwm[0-9]")
mintemp=65
maxtemp=82

while [ true ]; do
  temp=$(cat $input)
  pwm=$(echo $temp | 
    gawk -voldpwm=$pwm -vmin=$mintemp -vmax=$maxtemp ' 
    BEGIN {
      tempfactor=255/(max-min)
    }
    {
      temp=$1
      pwm=int(((temp / 1000) - min) * tempfactor) 
      if (pwm <0) { 
        pwm =0
      } 
      if (pwm < oldpwm) {
        pwm = int((19 * oldpwm + pwm) / 20)
      }
      if (pwm > oldpwm) {
        pwm = int((2 * oldpwm + pwm) / 3)
      }
      if (pwm > 255) {
        pwm=255
      }
      print pwm 
    }')
  echo "temp=$temp, pwm=$pwm"
  echo $pwm > $output
  sleep 1
done
