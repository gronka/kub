#!/bin/bash

filename=../images/debian$1.qcow2

# -cpu host,-rdtscp
qemu-system-x86_64 \
	-accel kvm \
	-cpu host \
	-smp 2 \
	-m 4G \
	-usb \
	-device usb-tablet \
	-vga virtio \
	-display default,show-cursor=on \
	-device virtio-net,netdev=vmnic -netdev user,id=vmnic \
	-audiodev coreaudio,id=coreaudio \
	-device ich9-intel-hda -device hda-output,audiodev=coreaudio \
	-cdrom ../images/debian-12.4.0-amd64-DVD-1.iso \
	-drive file=$filename,if=virtio
