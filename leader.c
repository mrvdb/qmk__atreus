/* This config assumes the APP key is the leader key */
#include QMK_KEYBOARD_H

LEADER_EXTERNS();
bool leader_success;

void matrix_scan_user(void) {
  LEADER_DICTIONARY() {
    leader_success = leading = false;

    // Leader was pressed, let's see what has followed:
    // MT and LT are filtered out unless LEADER_KEY_STRICT_KEY_PROCESSING is defined
    SEQ_FOUR_KEYS(KC_T, KC_E, KC_S, KC_T) {
      SEND_STRING("Test passed... your pressed T E S T");
      leader_success = true;
    }
    leader_end();
  }
}

/* Gets called on timeout or after handling a lead sequence */
void leader_end(void) {
  if (!leader_success) {
    // send app key itself when no sequence succeeded
    SEND_STRING(SS_TAP(X_APP));
  }
}
