#type vertex
#version 330 core

layout(location = 0) in vec3 a_Position;
layout(location = 1) in vec2 a_TexCoord;
layout(location = 2) in vec3 a_Normal;

uniform mat4 u_ViewSpace;
uniform mat4 u_Transform;

out vec2 TexCoord;

void main()
{
	TexCoord = a_TexCoord;

	gl_Position = u_ViewSpace * u_Transform * vec4(a_Position, 1.0);
}


#type fragment
#version 330 core
out vec4 FragColor;

in vec2 TexCoord;
uniform sampler2D u_Texture;

void main()
{
	FragColor = vec4(texture(u_Texture, TexCoord).rgb, 1.0);
}