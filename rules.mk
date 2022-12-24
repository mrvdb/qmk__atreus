LTO_ENABLE = yes

KEY_OVERRIDE_ENABLE = yes

SRC += source.c

ifeq ($(strip $(LEADER_ENABLE)), yes)
	SRC += leader.c
endif

ifeq ($(strip $(KEY_OVERRIDE_ENABLE)), yes)
	SRC += override.c
endif
