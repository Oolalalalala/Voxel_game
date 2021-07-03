#type vertex
#version 330 core

layout(location = 0) in vec3 a_Position;
layout(location = 1) in vec2 a_TexCoord;
layout(location = 2) in vec3 a_Normal;

uniform mat4 lightSpaceMatrix;
uniform mat4 model;

void main()
{
	gl_Position = lightSpaceMatrix * model * vec4(a_Position, 1.0);
}



#type fragment
#version 330 core

void main()
{

}