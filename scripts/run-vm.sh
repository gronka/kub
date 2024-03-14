#!/bin/bash

filename=../images/debian$1.qcow2

# -cpu host,-rdtscp
sudo qemu-system-x86_64 \
	-accel kvm \
	-cpu host \
	-smp 2 \
	-m 4G \
	-usb \
	-device usb-tablet \
	-vga virtio \
	-display default,show-cursor=on \
	-device virtio-net,netdev=vmnic -netdev user,id=vmnic \
	-drive file=$filename,if=virtio
	# -audiodev coreaudio,id=coreaudio \
	# -device ich9-intel-hda -device hda-output,audiodev=coreaudio \
