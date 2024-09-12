# MegaDuck SML patch

This is a MegaDuck patch based on an extended version of the original disassembly at https://github.com/kaspermeerts/supermarioland

The following should be completely patched and working
- Audio registers and bits
- Display registers and bits
- Bank Switching (.md2 style and a build with mbc1/3/5 style)

The UPS style patch files are under the `/patch` folder


Original Readme for below:

==================================

# SML Disassembly

This repository builds Super Mario Land (World) (Rev A) with SHA1 checksum `418203621b887caa090215d97e3f509b79affd3e`

As of now it requires a copy of the original ROM named "baserom.gb" to be placed in the repository, to fill in sections which have not been disassembled yet. The goal is to make this step obsolete.


## Requirements

* RGBDS 0.3.5 (updated to 0.6.1)
* pypng

## Coverage

A quick and dirty Python script `coverage.py` is provided to estimate how much of the ROM has been disassembled

* Bank 0: three quarters
* Bank 1: a third
* Bank 2: half
* Bank 3: half
* High RAM: 46 out of 127 bytes identified

