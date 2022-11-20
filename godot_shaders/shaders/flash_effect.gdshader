shader_type canvas_item;

uniform bool is_on_hit = false;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	vec4 flash_white = vec4(color.rgb + (vec3(1, 1, 1) - color.rgb) * 1.0, color.a);
	
	if (is_on_hit) {
		COLOR = flash_white;
	}
}