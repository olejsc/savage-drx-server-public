varying float			fog;
varying vec4			diffuse;
varying vec3		  halfVector;
varying vec3			normal;

uniform sampler2D	texture0; 	// base texture
uniform sampler2D	texture1; 	// clouds texture
uniform sampler2D	glossMap; 	// glossmap texture

uniform float realbright;

void main()
{
	vec4 color;
	vec4 baseColor;
	vec4 glossColor;
	vec2 newTexcoord = gl_TexCoord[0].st;
		
	baseColor = texture2D(texture0, newTexcoord);
	glossColor = texture2D(glossMap, newTexcoord);
	
	if (baseColor.a < 0.05)
		discard;

	baseColor *= gl_Color;
	
	color  = vec4(baseColor.rgb * diffuse.rgb, baseColor.a);
	
	vec4 specular = vec4(0.0);
	float nDotHV 		= max(0.0, dot(normalize(normal), halfVector));
	
	if (nDotHV > 0.0)
		specular = gl_LightSource[0].diffuse * pow(nDotHV, gl_FrontMaterial.shininess) * gl_FrontMaterial.specular;
	
	color.rgb += glossColor.rgb * specular.rgb;
	
	color.rgb *= realbright;
	
	if (fog < 0.99)
		color.rgb 	= mix(gl_Fog.color.rgb, color.rgb, fog);
		
	gl_FragColor 	= color;
}
