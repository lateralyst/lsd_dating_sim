shader_type canvas_item;

uniform float scanline_count : hint_range(0, 400);
uniform float scanline_visibility : hint_range(0, 1);

uniform vec4 c1 : hint_color = vec4(1.0);
uniform vec4 c2 : hint_color = vec4(1.0);
uniform vec4 c3 : hint_color = vec4(1.0);
uniform vec4 c4 : hint_color = vec4(1.0);
uniform vec4 c5 : hint_color = vec4(1.0);
uniform float loops : hint_range(0.0, 40.0);

const int num_colors = 5;

const float PI = 3.1415;

void fragment() {
	float threshold = 3.0 / float(num_colors) / loops;
	
	
	float r = texture(SCREEN_TEXTURE, SCREEN_UV + vec2(SCREEN_PIXEL_SIZE.x * 0.0, 0.0)).r;
	float g = texture(SCREEN_TEXTURE, SCREEN_UV + vec2(SCREEN_PIXEL_SIZE.x * 1.5, 0.0)).g;
	float b = texture(SCREEN_TEXTURE, SCREEN_UV + vec2(SCREEN_PIXEL_SIZE.x * -1.5, 0.0)).b;
	vec4 color = vec4(r, g, b, 1.0);
	
	float total = color.r + color.g + color.b;
	int pick = int(int(total / threshold) % num_colors);
	
	if (pick == 0) {
		color = c1;
	}
	else if (pick == 1) {
		color = c2;
	}
	else if (pick == 2) {
		color = c3;
	}
	else if (pick == 3) {
		color = c4;
	}
	else if (pick == 4) {
		color = c5;
	}
	
	float scan = sin(SCREEN_UV.y * scanline_count * PI * 2.0);
	scan = (scan * 0.5 + 0.5) * 0.9 + (1.0 - scanline_visibility);
	vec4 scanColor = vec4(vec3(pow(scan, 0.1)), 1.0);
	
	COLOR = color * scanColor;
}