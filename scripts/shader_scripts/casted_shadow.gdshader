//Add light occluders to your tilemap
//Add a big rectangular Polygon2D covering the entire area you want shadows to appear in your main scene
//Change the z-index to make the polygon appear behind your tilemap
//Add the following shader to the polygon


shader_type canvas_item;
render_mode light_only;

uniform vec4 color : source_color;
uniform float angle : hint_range(0,360);
uniform float max_dist : hint_range(0,1000) = 100;
uniform sampler2D gradientTexture;

vec4 get_gradient_color(float position) {
    return texture(gradientTexture, vec2(position, 0.5));
}

void fragment() {
    float ang_rad = angle * 3.1416 / 180.0;
    vec2 light_direction = vec2(sin(ang_rad),cos(ang_rad));
    vec2 at = screen_uv_to_sdf(SCREEN_UV); float accum = 0.0;
    while(accum < max_dist) {
        float d = texture_sdf(at);
        if (d < 0.01) {
            break;
        }
        accum+=d;
        at += d * light_direction;
    }
	float alpha = 1.0-min(1.0,accum/max_dist);
    alpha = get_gradient_color(alpha).r;

    COLOR = vec4(color.rgb,alpha * color.a);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
