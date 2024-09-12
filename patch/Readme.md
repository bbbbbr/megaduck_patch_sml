
# MegaDuck Super Mario Land patch

This is a MegaDuck patch based on an extended version of the original disassembly at:
https://github.com/kaspermeerts/supermarioland

The following should be completely patched and working
- Audio registers and bits
- Display registers and bits
- Bank Switching (.md2 style and a build with mbc1/3/5 style)


Use SML with SHA1 checksum: 418203621b887caa090215d97e3f509b79affd3e

Web Patcher: https://www.marcrobledo.com/RomPatcher.js/


# Playing on console hardware, the patched ROM requires either:
- A MegaDuck Flash Cart with "MD2" banking support (16K banks switchable writing to 0x0001) such as the picoDuck by zwenergy​ (Use MD2 patch)
- Or a Game Boy Flash Cart -> to MegaDuck Cart Slot Adapter along with a Game Boy MBC5 flash cart. The adapters are not available right now, but may be in the future. (Use MBC5 patch)

# Playing on console emulators:
At this time all software emulators have slightly incorrect audio for the MegaDuck. The MiSTer MegaDuck core is the only hardware re-implementation where audio should generally sound correct.


Patch by: bbbbbr
