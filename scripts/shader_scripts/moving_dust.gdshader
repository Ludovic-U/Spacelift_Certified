shader_type canvas_item;

uniform vec2 resolution = vec2(1920, 1080);
uniform sampler2D noise_texture: filter_nearest, repeat_enable;
uniform float density: hint_range(0.0, 100.0, 0.1) = 50.0;
uniform float alpha_threshold: hint_range(0.0, 1.0, 0.1) = 0.2;
uniform float layers: hint_range(0.0, 10.0, 1.0);
uniform float speed_difference = 0.2;
uniform float brightness_difference = 0.01;
uniform vec2 direction;

void fragment() {
	vec2 speed = TIME * direction  ;
	vec2 uv = UV;
	uv.x *= resolution.x / resolution.y;
	
	float stars = 0.0;
	for (float i = 0.0; i < layers; i += 1.0){
		stars += pow(texture(noise_texture, uv + (i * 0.2) + speed * (1.0 + i * speed_difference) ).r, density) * (1.0 - i * brightness_difference) ;
	}
	if (stars > alpha_threshold){
		COLOR = vec4(vec3(stars), 1.0) ;
	}
}