shader_type canvas_item;
render_mode unshaded;
uniform sampler2D Scene: filter_nearest;


vec3 posterize(vec3 col){
	//posterize and gamma shamelessly stolen from https://www.shadertoy.com/view/wtcyzX
	const float gamma = 1.0;
	const float colors = 32.0;

	col.rgb = pow(col.rgb,vec3(gamma));
	col.rgb *= colors;
	col.rgb = floor(col.rgb);
	col.rgb /= colors;
	col.rgb = pow(col.rgb, vec3(1.0/gamma));
	return col;
}

void fragment() {
	COLOR = texture(Scene,UV);
}