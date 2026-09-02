#!/bin/bash
echo "Attempting GPU recovery..."
sudo sh -c 'echo 1 > /sys/kernel/debug/dri/0/amdgpu_gpu_recover'
sleep 2
sudo systemctl restart gdm
