LTO_ENABLE		= yes
KEY_OVERRIDE_ENABLE	= yes
AUTO_SHIFT_ENABLE	= yes

SRC += source.c

ifeq ($(strip $(LEADER_ENABLE)), yes)
	SRC += leader.c
endif

ifeq ($(strip $(KEY_OVERRIDE_ENABLE)), yes)
	SRC += override.c
endif

ifeq ($(strip $(AUTO_SHIFT_ENABLE)), yes)
	SRC += autoshift.c
endif
