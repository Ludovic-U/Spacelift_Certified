//Add light occluders to your tilemap
//Add a big rectangular Polygon2D covering the entire area you want shadows to appear in your main scene
//Change the z-index to make the polygon appear behind your tilemap
//Add the following shader to the polygon


shader_type canvas_item;
render_mode unshaded;

uniform vec4 color : source_color; 
uniform float angle : hint_range(0,360); 
uniform float max_dist : hint_range(0,1000) = 100;

void fragment() { 
    float ang_rad = angle * 3.1416 / 180.0; 
    vec2 dir = vec2(sin(ang_rad),cos(ang_rad)); 
    vec2 at = screen_uv_to_sdf(SCREEN_UV); float accum = 0.0;
    while(accum < max_dist) {
        float d = texture_sdf(at);
        accum+=d;
        if (d < 0.01) {
            break;
        }
        at += d * dir;
    }
	float alpha = smoothstep(0.0, 1.0, 1.0 - min(1.0, accum / max_dist));
    
    COLOR = vec4(color.rgb,alpha * color.a);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
