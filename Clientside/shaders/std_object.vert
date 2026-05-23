varying vec3 lightPos0;
varying vec3 lightPos1;
varying vec3 viewV;
varying vec4 ambient;

varying vec3 halfVector0;
varying vec3 halfVector1;

varying float fog;

uniform int celShading;
uniform int silhouette;

void main()
{
	// pass texture coords
	gl_TexCoord[0] = gl_MultiTexCoord0;
	gl_TexCoord[2] = gl_MultiTexCoord2;
	
	vec3 tangent = gl_TexCoord[2].xyz;
    vec3 binormal = normalize(cross(gl_Normal, tangent)) * gl_TexCoord[2].w;
    mat3 tbn_mat = mat3(tangent, binormal, gl_Normal);
	
	float aI = 0.75 + max(0.0, 0.25 * (dot(vec3(0.0, 0.0, 1.0), gl_Normal)));
	ambient = gl_LightModel.ambient * aI;
	gl_FrontColor = gl_Color;
	
	lightPos0 = normalize(vec3(gl_ModelViewMatrixInverse * gl_LightSource[0].position) * tbn_mat);
	lightPos1 = normalize(vec3(gl_ModelViewMatrixInverse * gl_LightSource[1].position) * tbn_mat);
	
	/***** EYE CAM POSITITION *********/
	vec4 eyeWorld = (gl_ModelViewMatrixInverse * vec4(0.0, 0.0, 0.0, 1.0));
	viewV = vec3(-gl_Vertex + eyeWorld);
	
	/***** LINEAR FOG *********/
	float dist = abs(vec4(gl_ModelViewMatrix * gl_Vertex).z); 
	fog = ((gl_Fog.end - dist) / (gl_Fog.end - gl_Fog.start));
	fog = clamp(fog, 0.0, 1.0);

	if (celShading == 0 || silhouette == 0) {
		gl_Position = ftransform();
	} else if (celShading == 1 && silhouette == 1) {
		gl_Position = gl_ProjectionMatrix * gl_ModelViewMatrix * vec4(vec3(gl_Vertex) - 0.05 * viewV, 1.0);
	}
	
	viewV = normalize(viewV * tbn_mat);
	
	// normalized in fragment shader!
	halfVector0 = lightPos0 + viewV;
	halfVector1 = lightPos1 + viewV;
}
