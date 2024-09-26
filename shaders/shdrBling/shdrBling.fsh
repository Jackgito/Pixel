varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float time;  // Time variable to control animation
//uniform sampler2D gm_BaseTexture;

void main()
{
    // Sample the texture color
    vec4 baseColor = texture2D(gm_BaseTexture, v_vTexcoord) * v_vColour;

    // Calculate a "shine" effect that moves across the sprite
    float shinePos = mod(time, 1.0);  // Time-based shine position (loops over time)
    float distanceFromShine = abs(v_vTexcoord.x - shinePos);  // Distance from the shine line

    // Create a gradient for the shine (closer to the line, brighter the shine)
    float shineEffect = smoothstep(0.0, 0.1, 1.0 - distanceFromShine);  // Adjust sharpness with the second parameter

    // Combine the shine effect with the base color (additive effect)
    vec4 shineColor = vec4(1.0, 1.0, 1.0, 1.0) * shineEffect * 0.5;  // White shine, half strength

    // Final color is the base color plus the shine effect
    gl_FragColor = baseColor + shineColor;
}