// Makes stuff grey
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    // Sample the texture color
    vec4 desaturateOut = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);

    // Calculate average of RGB components for grayscale value
    float desatSimple = (desaturateOut.r + desaturateOut.g + desaturateOut.b) / 3.0;

    // Create grayscale color and blend with original color based on desaturateStrength
    vec3 desaturateVec3 = mix(desaturateOut.rgb, vec3(desatSimple), 1.0);

    // Output the final color with the original alpha
    gl_FragColor = vec4(desaturateVec3, desaturateOut.a);
}