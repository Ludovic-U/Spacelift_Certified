shader_type canvas_item;

uniform sampler2D noise_img: filter_nearest, repeat_enable;
uniform vec2 direction_r;
uniform vec2 direction_g;
uniform vec2 direction_b;
uniform float alpha_strength;
uniform vec4 smoke_color: source_color;

void fragment() {
	vec2 uv_r = vec2(UV.x + (TIME * direction_r.x) , UV.y + (TIME * direction_r.y));
	vec2 uv_g = vec2(UV.x + (TIME * direction_g.x) , UV.y + (TIME * direction_g.y));
	vec2 uv_b = vec2(UV.x + (TIME * direction_b.x) , UV.y + (TIME * direction_b.y));
	float noise_r = texture( noise_img, uv_r).r;
	float noise_g = texture( noise_img, uv_g).g;
	float noise_b = texture( noise_img, uv_b).b;

	vec3 new_color = vec3(noise_r, noise_g, noise_b);
	float new_alpha = noise_r * noise_g * noise_b;

	COLOR.rgb = smoke_color.rgb;
	COLOR.a = clamp(new_alpha * alpha_strength * texture(TEXTURE, UV).a, 0.0, 1.0);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
