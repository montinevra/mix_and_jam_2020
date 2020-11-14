extends Bullet


#private:
func _collide(t_collision) -> void:
	var collider = t_collision.get_collider()
	
	if collider.name == "Enemy":
		collider.on_hit()
#	print(t_collision.collider)
	._collide(t_collision)

