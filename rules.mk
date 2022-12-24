LTO_ENABLE		= yes
KEY_OVERRIDE_ENABLE	= yes
AUTO_SHIFT_ENABLE	= yes

ifeq ($(strip $(LEADER_ENABLE)), yes)
	SRC += src/leader.c
endif

ifeq ($(strip $(KEY_OVERRIDE_ENABLE)), yes)
	SRC += src/override.c
endif

ifeq ($(strip $(AUTO_SHIFT_ENABLE)), yes)
	SRC += src/autoshift.c
endif
