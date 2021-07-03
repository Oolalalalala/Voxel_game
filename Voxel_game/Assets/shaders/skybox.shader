#type vertex
#version 330 core

layout(location = 0) in vec3 a_Position;

out vec3 texCoords;

uniform mat4 u_VP;

void main()
{
	texCoords = a_Position;

	gl_Position = u_VP * vec4(a_Position, 1.0);
}


#type fragment
#version 330 core
out vec4 FragColor;

in vec3 texCoords;

uniform samplerCube cubeMap;

void main()
{
	FragColor = texture(cubeMap, texCoords);
}