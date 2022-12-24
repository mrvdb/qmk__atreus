#include QMK_KEYBOARD_H

/* change Shift-( and Shift-) to emit < and > */
const key_override_t lprn_key_override = ko_make_basic(MOD_MASK_SHIFT, KC_LPRN, KC_LT);
const key_override_t rprn_key_override = ko_make_basic(MOD_MASK_SHIFT, KC_RPRN, KC_GT);

// This globally defines all key overrides to be used
const key_override_t **key_overrides = (const key_override_t *[]){
  &lprn_key_override,
  &rprn_key_override,
  NULL // Null terminate the array of overrides!
};
