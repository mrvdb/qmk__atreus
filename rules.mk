# LTO = link time optimization, reduces size
LTO_ENABLE		= yes

# Overriding keys to produce another keycode
# Need this for my parenthesis/braces/hooks config
KEY_OVERRIDE_ENABLE	= yes

# Automatically used shifted keycode on hold, timeout in config.h
AUTO_SHIFT_ENABLE	= yes

# Allow recording macros (2 keys currently)
DYNAMIC_MACRO_ENABLE 	= yes

CONSOLE_ENABLE		= no
COMMAND_ENABLE		= no
MOUSEKEY_ENABLE		= no
EXTRAKEY_ENABLE		= no
SPACE_CADET_ENABLE	= no
GRAVE_ESC_ENABLE	= no
MAGIC_ENABLE		= no

ifeq ($(strip $(LEADER_ENABLE)), yes)
	SRC += src/leader.c
endif

ifeq ($(strip $(KEY_OVERRIDE_ENABLE)), yes)
	SRC += src/override.c
endif

ifeq ($(strip $(AUTO_SHIFT_ENABLE)), yes)
	SRC += src/autoshift.c
endif

ifeq ($(strip $(DYNAMIC_MACRO_ENABLE)), yes)
	SRC += src/macro.c
endif
