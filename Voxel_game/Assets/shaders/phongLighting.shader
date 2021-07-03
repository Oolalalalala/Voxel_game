#type vertex
#version 330 core

layout(location = 0) in vec3 a_Position;
layout(location = 1) in vec2 a_TexCoord;
layout(location = 2) in vec3 a_Normal;

out vec3 FragPos;
out vec2 TexCoord;
out vec3 Normal;
out vec4 FragPosLightSpace;

uniform mat4 u_MVP;
uniform mat4 lightSpaceMatrix; // world space to light space

void main()
{
	FragPos = a_Position;

	Normal = a_Normal;

	TexCoord = a_TexCoord;

	FragPosLightSpace = lightSpaceMatrix * vec4(FragPos, 1.0);

	gl_Position = u_MVP * vec4(a_Position, 1.0);
}


#type fragment
#version 330 core
out vec4 FragColor;

in vec3 FragPos;
in vec2 TexCoord;
in vec3 Normal;
in vec4 FragPosLightSpace;

uniform sampler2D u_Texture;
uniform sampler2D u_ShadowMap;

uniform vec3 lightDirection;
uniform vec3 viewPos;
uniform vec3 lightColor;
uniform float lightStrength;

const float ambientStrength = 0.4;
const float specularStrength = 0.3;

float shadowCalc()
{
	vec3 pos = FragPosLightSpace.xyz * 0.5 + 0.5;
	if (pos.z > 1.0)
		pos.z = 1.0;
	float depth = texture(u_ShadowMap, pos.xy).r;
	return depth + 0.05 < pos.z ? 0.0 : 1.0;
}

void main()
{
	// ambient
	vec3 ambient = ambientStrength * lightColor;

	// diffuse
	vec3 norm = normalize(Normal);
	vec3 lightDir = normalize(lightDirection);
	vec3 diffuse = max(dot(norm, -lightDir), 0.0) * lightColor;

	// specular
	vec3 viewDir = normalize(viewPos - FragPos);
	vec3 reflectDir = reflect(lightDir, norm);
	vec3 specular = specularStrength * pow(max(dot(viewDir, reflectDir), 0.0), 16) * lightColor;

	float shadow = shadowCalc();
	vec3 result = (ambient + (diffuse + specular) * lightStrength * shadow) * texture(u_Texture, TexCoord).rgb;
	FragColor = vec4(result, 1.0);
	//FragColor = vec4(1.0);
}