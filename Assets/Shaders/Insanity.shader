Shader "Insanity" {
Properties {
	_Color ("Main Color", Color) = (1,1,1,1)
	_SpecColor ("Specular Color", Color) = (0.5, 0.5, 0.5, 1)
	_Shininess ("Shininess", Range (0.03, 1)) = 0.078125
	_MainTex1 ("Base (RGB) Gloss (A)", 2D) = "white" {}
	_BumpMap1 ("Normalmap", 2D) = "bump" {}
	//_MainTex2 ("Base (RGB) Gloss (A)", 2D) = "white" {}
	_BumpMap2 ("Normalmap", 2D) = "bump" {}
	_BumpMap3 ("Normalmap", 2D) = "bump" {}
	_Blend ("Blend", Range(0.0,1.0)) = 0.0
	_planePoint ("plane point", Vector) = (0,0,0,0)
	_planeNormal ("plane normal", Vector) = (0,1,0,0)
}
SubShader { 
	Tags { "Queue" = "Geometry" }
	//Tags { "RenderType"="Opaque" }
	Cull Off
	LOD 400
	
CGPROGRAM
#pragma surface surf BlinnPhong
#pragma target 3.0
//#pragma debug

sampler2D _MainTex1;
sampler2D _BumpMap1;
//sampler2D _MainTex2;
sampler2D _BumpMap2;
sampler2D _BumpMap3;
float4 _Color;
float _Shininess;
float _Blend;
float4 _planePoint;
float4 _planeNormal;
	  
struct Input {
	float2 uv_MainTex1;
	float2 uv_BumpMap1;
	//float2 uv_MainTex2;
	float2 uv_BumpMap2;
	float2 uv_BumpMap3;
	float3 worldPos;
};

void surf (Input IN, inout SurfaceOutput o) {
	//clip (frac((IN.worldPos.y+IN.worldPos.z*0.1) * 5) - 0.5);
	//clip ((IN.worldPos.z*0.1 * 5) - 0.5);
	
	clip(dot(IN.worldPos - (float3)_planePoint,(float3)_planeNormal));
	
	half4 tex1 = tex2D(_MainTex1, IN.uv_MainTex1);
	//half4 tex2 = tex2D(_MainTex2, IN.uv_MainTex2); 
	
	
	o.Albedo = tex2D (_MainTex1, IN.uv_MainTex1).rgb;
	o.Albedo = (( tex1.rgb * _Color.rgb )  * ( 1 - _Blend ));
	o.Gloss = ( tex1.a ) * ( 1 - _Blend );
	o.Alpha = ( tex1.a * _Color.a )  * ( 1 - _Blend );
	o.Specular = _Shininess;
	
	//half4 tex2 = tex2D(_MainTex2, IN.uv_MainTex2);
	//o.Albedo += ( tex2.rgb * _Color.rgb )  * ( _Blend );
	//o.Gloss += ( tex2.a ) * ( _Blend );
	//o.Alpha += ( tex2.a * _Color.a )  * ( _Blend );

	//o.Albedo = lerp(tex1,tex2,_Blend) * _Color.rgb;
	//TODO Fade between normalmaps
	o.Normal = UnpackNormal((tex2D(_BumpMap1,IN.uv_BumpMap1)+tex2D(_BumpMap2,IN.uv_BumpMap2))-tex2D(_BumpMap3,IN.uv_BumpMap3));
	//o.Normal = UnpackNormal((tex2D(_BumpMap1,IN.uv_BumpMap1)));
	//return tex2D(_BumpMap1,IN.uv_BumpMap1);
	//o.Normal += UnpackNormal((tex2D(_BumpMap2,IN.uv_BumpMap2)));
	//tex2D(_BumpMap2,IN.uv_BumpMap2)

}
ENDCG
}

FallBack "Specular"
}