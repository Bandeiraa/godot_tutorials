shader_type canvas_item;

uniform sampler2D noise_texture;
uniform float dissolve_range: hint_range(0, 1) = 1.0;

void fragment() {
	vec4 image_texture = texture(TEXTURE, UV);
	vec4 current_pixel = texture(noise_texture, UV);
	
	image_texture.a *= floor(
		dissolve_range + min(
			1, current_pixel.x
		)
	);
	
	COLOR = image_texture;
}