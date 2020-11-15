extends Bullet


#private:
func _collide(t_collision) -> void:
	var collider = t_collision.get_collider()
	
	if collider is Enemy:
		collider.on_hit()
	._collide(t_collision)
