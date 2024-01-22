// I have certainly less than 8 layers
#define LAYER_STATE_8BIT

// Once I have a MX lock key, I'll spent those 400 bytes yo.
#undef LOCKING_SUPPORT_ENABLE
#undef LOCKING_RESYNC_ENABLE

// Not using one shot actions so far
#define NO_ACTION_ONESHOT

// Autoshifting fits well with my layout:
// - numerics are shared with top row letters
// - I want = to be autoshifted to + so I enabled the specials
#if defined(AUTO_SHIFT_ENABLE)
  #define AUTO_SHIFT_TIMEOUT 175
  #define NO_AUTO_SHIFT_ALPHA
  #define AUTO_SHIFT_NO_AUTO_REPEAT
#endif // !AUTO_SHIFT_ENABLE

// Why is this here?
#if defined(KEY_OVERRIDE_ENABLE)
#endif // !KEY_OVERRIDE_ENABLE

#if defined(LEADER_ENABLE)
  #define LEADER_PER_KEY_TIMING
  #define LEADER_TIMEOUT 750
#endif // !LEADER_ENABLE


// typing / e in succession often outputs E, thus triggering the modifier instead of the tap
// https://docusaurus.qmk.fm/tap_hold#ignore-mod-tap-interrupt seems the usecase her
// The define is now the default and generates an error when defined again
// #define IGNORE_MOD_TAP_INTERRUPT

// But give the hold some more chance as another key is pressed
#define HOLD_ON_OTHER_KEY_PRESS
