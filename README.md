# A simple bash script to control the CPU fan.
This script searches for cpu temperature sensors and regulates the CPU fan with a moving average. It ramps up quickly when the CPU gets hot, but slowly decreases speed when the CPUs is cooling down. This way the fan slowly changes speed and is less annoying.
