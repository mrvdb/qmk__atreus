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
