Cross compiling Alpine image built directly from source packages without minirootfs releases.

Supports RiscV64 on edge version.

```bash
# docker run -it --rm --platform=linux/riscv64 tonistiigi/alpine
/ # apk add file
fetch https://dl-cdn.alpinelinux.org/alpine/edge/main/riscv64/APKINDEX.tar.gz
(1/2) Installing libmagic (5.40-r1)
(2/2) Installing file (5.40-r1)
Executing busybox-1.33.1-r2.trigger
OK: 11 MiB in 16 packages
/ # file /bin/busybox
/bin/busybox: ELF 64-bit LSB pie executable, UCB RISC-V, RVC, double-float ABI, version 1 (SYSV), dynamically linked, interpreter /lib/ld-musl-riscv64.so.1, stripped
```

