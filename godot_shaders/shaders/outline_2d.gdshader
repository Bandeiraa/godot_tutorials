shader_type canvas_item;

uniform bool is_on_hit = false;
uniform bool is_outline_active = true; //Outline active or not
uniform vec4 line_color: source_color = vec4(1.0); //Line Color
uniform float thickness: hint_range(0.0, 10.0, 1.0) = 1.0; //Line length

void fragment() {
	vec2 size = TEXTURE_PIXEL_SIZE * thickness;
	
	float left = texture(TEXTURE, UV + vec2(-size.x, 0)).a;
	float upper_left = texture(TEXTURE, UV + vec2(-size.x, size.y)).a;
	
	float right = texture(TEXTURE, UV + vec2(size.x, 0)).a;
	float upper_right = texture(TEXTURE, UV + vec2(size.x, size.y)).a;
	
	float up = texture(TEXTURE, UV + vec2(0, size.y)).a;
	float bottom_left = texture(TEXTURE, UV + vec2(-size.x, -size.y)).a;
	
	float down = texture(TEXTURE, UV + vec2(0, -size.y)).a;
	float bottom_right = texture(TEXTURE, UV + vec2(size.x, -size.y)).a;
	
	float four_directions = left + right + up + down;
	float diagonal_directions = upper_left + upper_right + bottom_left + bottom_right;
	
	float outline = min(four_directions + diagonal_directions, 1.0);
	
	vec4 color = texture(TEXTURE, UV);
	vec4 color_with_outline = mix(color, line_color, outline - color.a);
	vec4 flash_white = vec4(color.rgb + (vec3(1, 1, 1) - color.rgb) * 1.0, color.a);
	
	if (is_outline_active && is_on_hit) {
		COLOR = flash_white + color_with_outline;
	} else if (is_outline_active) {
		COLOR = color_with_outline;
	} else if (is_on_hit) {
		COLOR = flash_white;
	}
}