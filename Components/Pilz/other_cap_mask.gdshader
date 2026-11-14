shader_type canvas_item;

uniform sampler2D mask_sampler;
uniform vec2 mask_offset = vec2(0,0);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	ivec2 orig_size = textureSize(TEXTURE,0);
	ivec2 mask_size = textureSize(mask_sampler,0);
	vec2 orig_size_to_mask_size_ratio = vec2(orig_size)/vec2(mask_size);
	vec2 mask_offset_pixel_converted = mask_offset * TEXTURE_PIXEL_SIZE * orig_size_to_mask_size_ratio * -1.0;
	vec4 mask_color = texture(mask_sampler, UV * orig_size_to_mask_size_ratio + mask_offset_pixel_converted);
	vec4 orig_color = texture(TEXTURE, UV);
	if (mask_color.a != 0.0 && orig_color.a != 0.0) {
		orig_color.a = 0.3;
		COLOR.rgba = orig_color;
	}  
	else COLOR.a = 0.0;
	
	//float alpha = clamp(orig_color.a - mask_color.a, 0.0, 1.0);
	//COLOR.a = alpha;
	//COLOR.rgb = orig_color.rgb;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
