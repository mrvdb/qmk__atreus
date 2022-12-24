LTO_ENABLE = yes
SRC += source.c

ifeq ($(strip $(LEADER_ENABLE)), yes)
	SRC += leader.c
endif
