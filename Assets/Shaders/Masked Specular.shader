// Upgrade NOTE: replaced 'PositionFog()' with multiply of UNITY_MATRIX_MVP by position
// Upgrade NOTE: replaced 'V2F_POS_FOG' with 'float4 pos : SV_POSITION'

Shader "Masked Specular" {
Properties {
	_Color ("Main Color", Color) = (1,1,1,1)
	_SpecColor ("Specular Color", Color) = (0.5, 0.5, 0.5, 1)
	_Shininess ("Shininess", Range (0.03, 1)) = 0.2
	_ColorAmount ("Lightmap Specular Contribution", Range (0.0, 1)) = 0.5
	_MaskStrength ("Masking Strength", Range (0.0, 1)) = 1.0
	_Brightness ("LightMap Strength", Range (0.0, 1)) = 0.5
	_MainTex ("Base (RGB) Gloss (A)", 2D) = "white" {}
	_BumpMap ("Bumpmap (RGB)", 2D) = "bump" {}
	_LightMap ("Lightmap(RGB) Specular Mask(A)",2D) = "white" {}
	_Constant ("Proximity Scaling", Range (0.01, 7)) = 6
	_CubeDimness ("Cubemap Multiplier", Range (0.01, 25)) = 5
	_Cube ("Reflection Cubemap", Cube) = "_Skybox"
	_MainTex2 ("Base (RGB) Gloss (A) 2", 2D) = "white" {}
}

Category {
	Tags { "RenderType"="Opaque" }
	LOD 600
	/* Upgrade NOTE: commented out, possibly part of old style per-pixel lighting: Blend AppSrcAdd AppDstAdd */
	Fog { Color [_AddFog] }
	
	// ------------------------------------------------------------------
	// ARB fragment program
	
	#warning Upgrade NOTE: SubShader commented out; uses Unity 2.x per-pixel lighting. You should rewrite shader into a Surface Shader.
/*SubShader { 
		UsePass "Specular/BASE"
		
		// Pixel lights
		Pass { 
			Name "PPL"	
			Tags { "LightMode" = "Pixel" }
CGPROGRAM
// Upgrade NOTE: excluded shader from Xbox360; has structs without semantics (struct appdata members vertex,texcoord,texcoord1,tangent,normal)
#pragma target 3.0
#pragma exclude_renderers xbox360
#pragma vertex vert
#pragma fragment frag
#pragma multi_compile_builtin
#pragma fragmentoption ARB_fog_exp2
#pragma fragmentoption ARB_precision_hint_fastest 
#include "UnityCG.cginc"
#include "AutoLight.cginc" 

struct v2f {
	float4 pos : SV_POSITION;
	LIGHTING_COORDS
	float3	uvK:TEXCOORD1; // xy = UV, z = specular K
	float2	uv2:TEXCOORD2;
	float3	viewDirT:TEXCOORD3;
	float3	lightDirT:TEXCOORD4;
	float3	I:TEXCOORD5;

}; 

uniform float4 _MainTex_ST, _MainTex2_ST,_LightMap_ST;
uniform float _Shininess;
uniform float _CubeDimness;

struct appdata {
    float4 vertex;
    float2 texcoord;
	float2 texcoord1;
	float4 tangent;
	float3 normal;
};
uniform float _Constant;

v2f vert (appdata v)
{	
	v2f o;
	o.pos = mul (UNITY_MATRIX_MVP, v.vertex);
	float3 viewDir = ObjSpaceViewDir( v.vertex );
	float3 I =mul((float3x3)_Object2World,v.normal);
	float3 worldpos=mul(_Object2World,v.vertex)-mul(_Object2World,_ObjectSpaceCameraPos);
	o.I = normalize(reflect(_Constant *worldpos+I,I)); 
	o.uvK.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
	o.uvK.z = _Shininess * 128;
	o.uv2 = TRANSFORM_TEX(v.texcoord1, _LightMap);
	TANGENT_SPACE_ROTATION;
	o.lightDirT = mul( rotation, ObjSpaceLightDir( v.vertex ) );	
	o.viewDirT = mul( rotation, ObjSpaceViewDir( v.vertex ) );	

	TRANSFER_VERTEX_TO_FRAGMENT(o);	
	return o;
}

float _ColorAmount;
float _MaskStrength;
float _Brightness;
inline half4 SpecularMaskedLight( half3 lightDir, half3 viewDir, half3 normal, half4 color,half4 lightmap,half4 refl, float specK, half atten )
{
	#ifndef USING_DIRECTIONAL_LIGHT
	lightDir = normalize(lightDir);
	#endif
	viewDir = normalize(viewDir);
	half3 h = normalize( lightDir + viewDir );
		float3 white=(1.0,1.0,1.0);
	half diffuse = dot( normal, lightDir );
	float nh = saturate( dot( h, normal ) );
	float3 lightcontribution=mix(white,lightmap.rgb,_ColorAmount);
	float speccontribution=mix(1.0,lightmap.a,_MaskStrength);
	float3 spec = saturate(pow( nh, specK ) )*speccontribution;
	refl.rgb=(refl.rgb)*pow(nh,_CubeDimness)*lightmap.rgb;


	half4 c;
	c.rgb = ((color.rgb+refl.rgb) * _ModelLightColor0.rgb*lightcontribution * diffuse + _SpecularLightColor0.rgb*lightcontribution* spec)* (atten * 2);
	c.a = _SpecularLightColor0.a* spec * atten; // specular passes by default put highlights to overbright
	return c;
}




uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _LightMap;
uniform samplerCUBE _Cube;

float4 frag (v2f i) : COLOR
{		
	float4 texcol = tex2D( _MainTex, i.uvK.xy );
	float4 lightmap =tex2D(_LightMap,i.uv2);
	// get normal from the normal map
	float3 normal = tex2D(_BumpMap, i.uvK.xy).xyz * 2.0 - 1.0;
	float4 reflcol = texCUBE( _Cube,i.I);

	//texcol.rgb =(texcol.rgb+(lightmap.rgb)); 
	//Uncomment for simple lightmapping
	 texcol.rgb =(texcol.rgb*(lightmap.rgb*2.0-(1-_Brightness))); 
	
	half4 c = SpecularMaskedLight( i.lightDirT, i.viewDirT, normal, texcol,lightmap,reflcol, i.uvK.z, LIGHT_ATTENUATION(i) );
	return c;
}
ENDCG  
		}
	}*/
	}
	FallBack "Bumped Specular", 1

}