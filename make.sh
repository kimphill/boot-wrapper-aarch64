#!/bin/bash
make distclean
autoreconf -i
./configure  \
--host=aarch64-linux-gnu  \
--with-kernel-dir=/home/kimphi01/git/linux-perf-acme-armspe/arm64/ \
--with-dtb=/home/kimphi01/git/linux-perf-acme-armspe/arm64/arch/arm64/boot/dts/arm/fvp-base.dtb \
--enable-psci \
--enable-gicv3 \
--with-cpu-ids="0x0,0x1,0x2,0x3,0x100,0x101,0x102,0x103"
make

exit
#configure: error: Could not find DTB file: /home/kimphi01/git/linux-perf-acme-armspe/arm64//arch/arm64/boot/dts/rtsm_ve-aemv8a.dtb

#doesn't exist?: forget it, likely only for aarch32: --enable-aarch64-bw \

#--enable-gicv3 fixes this:

aarch64-linux-gnu-gcc   -g -O2  -mgeneral-regs-only -mstrict-align -Iinclude/ -Iarch/aarch64//include/ -Wall -fomit-frame-pointer -ffunction-sections -fdata-sections -DCNTFRQ=0x01800000	 -DCPU_IDS=0x0,0x100,0x200,0x300,0x10000,0x10100,0x10200,0x10300 -DNR_CPUS=8 -DSYSREGS_BASE=0x000000001c010000 -DUART_BASE=0x000000001c090000 -DSTACK_SIZE=256   -DGIC_CPU_BASE= -DGIC_DIST_BASE= -c -o gic.o gic.c
gic.c: In function ‘gic_secure_init’:
gic.c:35:41: error: expected expression before ‘;’ token
  void *gicd_base = (void *)GIC_DIST_BASE;


from README:
Linux boot wrapper with FDT support
===================================

To get started:

$ autoreconf -i
$ ./configure --host=<toolchain-triplet> --with-kernel-dir=<kernel-dir> <other-options>
$ make

Where:
 - <toolchain-triplet>: this is something like aarch64-linux-gnu
 - <kernel-dir>: the directory containing a pre-built aarch64 kernel
   and its sources.
 - <other-options>: see ./configure -h for a list of other options.

