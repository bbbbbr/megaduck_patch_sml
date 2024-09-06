MACRO WAIT_FOR_HBLANK
.loop\@
	ldh a, [rSTAT]
	and a, %11
	jr nz, .loop\@
ENDM

MACRO FAR_CALL
	SAVE_AND_SWITCH_ROM_BANK \1
	call \2
	RESTORE_ROM_BANK
ENDM

MACRO SAVE_AND_SWITCH_ROM_BANK
	ldh a, [hActiveRomBank]
	ldh [hSavedRomBank], a
	ld a, \1
	ldh [hActiveRomBank], a
	ld [rROMB0], a
ENDM

MACRO RESTORE_ROM_BANK
	ldh a, [hSavedRomBank]
	ldh [hActiveRomBank], a
	ld [rROMB0], a
ENDM
