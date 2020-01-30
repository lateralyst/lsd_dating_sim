shader_type canvas_item;

uniform float scanline_count : hint_range(0, 400);
uniform float scanline_visibility : hint_range(0, 1);

void fragment() {
	float PI = 3.1415;
	
	float r = texture(SCREEN_TEXTURE, SCREEN_UV + vec2(SCREEN_PIXEL_SIZE.x * 0.0, 0.0)).r;
	float g = texture(SCREEN_TEXTURE, SCREEN_UV + vec2(SCREEN_PIXEL_SIZE.x * 1.5, 0.0)).g;
	float b = texture(SCREEN_TEXTURE, SCREEN_UV + vec2(SCREEN_PIXEL_SIZE.x * -1.5, 0.0)).b;
	vec4 color = vec4(r, g, b, 1.0);
	
	float scan = sin(SCREEN_UV.y * scanline_count * PI * 2.0);
	scan = (scan * 0.5 + 0.5) * 0.9 + (1.0 - scanline_visibility);
	vec4 scanColor = vec4(vec3(pow(scan, 0.1)), 1.0);
	
	COLOR = color * scanColor;
}