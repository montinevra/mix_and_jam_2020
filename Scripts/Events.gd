# Global event bus
extends Node


# warning-ignore:unused_signal
signal sig_bullet_spawned(t_bullet)
# warning-ignore:unused_signal
signal sig_enemy_hit(t_enemy)
# warning-ignore:unused_signal
signal sig_core_exploded()
# warning-ignore:unused_signal
signal sig_core_exposed(t_color)
# warning-ignore:unused_signal
signal sig_core_matched(t_color)
# warning-ignore:unused_signal
signal sig_core_unmatched
# warning-ignore:unused_signal
signal sig_enemy_destroyed
