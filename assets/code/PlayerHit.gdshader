shader_type spatial;
render_mode unshaded, cull_disabled, depth_draw_opaque, depth_prepass_alpha;
// Remove unshaded if you want shading
// Replace cull_disabled if you want to only show one side (cull_front, cull_back)
// Reference for depth ::: https://docs.godotengine.org/en/stable/tutorials/shaders/shader_reference/spatial_shader.html#render-modes

uniform bool active = false; // Sets pixels to flash color when true
uniform vec4 flash_color: source_color = vec4(1.0,1.0,1.0,1.0); // The color to use when active
uniform sampler2D tex: filter_nearest, source_color; // A copy of the texture for the Sprite3D or AnimatedSprite3D 
uniform float scale : hint_range(0.1, 10.0) = 1.0; // Uniform to control scaling

void vertex() {
    vec3 scaled_vertex = VERTEX * scale;
    mat4 modelViewMatrix = VIEW_MATRIX * mat4(INV_VIEW_MATRIX[0] * scale, INV_VIEW_MATRIX[1] * scale, INV_VIEW_MATRIX[2] * scale, MODEL_MATRIX[3]);
    MODELVIEW_MATRIX = modelViewMatrix;
    MODELVIEW_NORMAL_MATRIX = mat3(modelViewMatrix);
}
void fragment() {
	vec4 col = texture(tex,UV);
	vec4 set_col = col;
	if(active == true) {
		set_col = flash_color;
	}
	ALBEDO = vec3(set_col.r,set_col.g,set_col.b);
	ALPHA = col.a;
}