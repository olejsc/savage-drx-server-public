varying float fog;
varying vec4 diffuse;
varying vec3 halfVector;
varying vec3 normal;

void main()
{
	gl_Position = ftransform();

	// pass texture coords
	gl_TexCoord[0] = gl_MultiTexCoord0;
		
	/***** EYE CAM POSITITION *********/
	vec4 ecPosition = gl_ModelViewMatrix * gl_Vertex;	
	vec3 ecPosition3 = ecPosition.xyz / ecPosition.w;
	
	gl_FrontColor = gl_Color;
	
	/***** LINEAR FOG *********/
	gl_FogFragCoord = abs(ecPosition3.z);
	fog = (gl_Fog.end - gl_FogFragCoord) * gl_Fog.scale;
	fog = clamp(fog, 0.0, 1.0);
	
	// Light 0
	vec4 lightPos 	= gl_ModelViewMatrixInverse * gl_LightSource[0].position;	
	lightPos.w  	 	= gl_LightSource[0].position.w;
	lightPos			  = normalize(lightPos);

	// Light1
	vec4 lightPos1  = gl_ModelViewMatrixInverse * gl_LightSource[1].position;
	lightPos1.w   	= gl_LightSource[1].position.w;
	lightPos1				= normalize(lightPos1);
	
	// view Vector
	vec3 viewV			= -gl_Vertex.xyz + (gl_ModelViewMatrixInverse * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
	
	// half Vector
	halfVector = lightPos.xyz + normalize(viewV);
	halfVector = normalize(halfVector);
	
	
	normal		= normalize(gl_Normal);
	

	// calculate lighting on per vertex basis
	diffuse = vec4(0.0);

	/********* light 0 ***************/
	float nDotVP 		= max(0.0, dot(normal, lightPos.xyz));
	
	if (nDotVP > 0.0)
		diffuse 			 += gl_LightSource[0].diffuse * nDotVP;				
			
		
	/********* light 1 ***************/
	nDotVP 		 = max(0.0, dot(normal, lightPos1.xyz));		

	if (nDotVP > 0.0)
		diffuse 	+= gl_LightSource[1].diffuse * nDotVP;
		
	// add ambient component		
	float aI = 0.5 + max(0.0, 0.5 * (dot(vec3(0.0, 0.0, 1.0), normal)));	
	diffuse  += (gl_LightModel.ambient * aI);		
	
	normal 	= gl_Normal;
}