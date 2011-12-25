Shader "Bumped Specular Rimlight"
{
	Properties 
	{
_Color("_Color", 2D) = "white" {}
_Normal("_Normal", 2D) = "normal" {}
_RimColor("_RimColor", Color) = (0.0597015,0.2503912,1,1)
_RimPower("_RimPower", Range(0.1,3) ) = 1.8
_SpecPower("_SpecPower", Range(0.1,1) ) = 0.9

	}
	
	SubShader 
	{
		Tags
		{
"Queue"="Geometry+0"
"IgnoreProjector"="False"
"RenderType"="Opaque"

		}

		
Cull Back
ZWrite On
ZTest LEqual


		CGPROGRAM
#pragma surface surf BlinnPhongEditor  vertex:vert
#pragma target 2.0

			struct EditorSurfaceOutput {
				half3 Albedo;
				half3 Normal;
				half3 Emission;
				half3 Gloss;
				half Specular;
				half Alpha;
			};
			
			inline half4 LightingBlinnPhongEditor (EditorSurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
			{
				#ifndef USING_DIRECTIONAL_LIGHT
				lightDir = normalize(lightDir);
				#endif
				viewDir = normalize(viewDir);
				half3 h = normalize (lightDir + viewDir);
				
				half diff = max (0, dot (s.Normal, lightDir));
				
				float nh = max (0, dot (s.Normal, h));
				float3 spec = pow (nh, s.Specular*128.0) * s.Gloss;
				
				half4 c;
				c.rgb = (s.Albedo * _LightColor0.rgb * diff + _LightColor0.rgb * spec) * (atten * 2);
				c.a = s.Alpha + _LightColor0.a * Luminance(spec) * atten;
				return c;
			}
			
			inline half4 LightingBlinnPhongEditor_PrePass (EditorSurfaceOutput s, half4 light)
			{
				half3 spec = light.a * s.Gloss;
				
				half4 c;
				c.rgb = (s.Albedo * light.rgb + light.rgb * spec);
				c.a = s.Alpha + Luminance(spec);
				return c;
			}
			
			struct Input {
				float2 uv_Color;
float2 uv_Normal;
float3 viewDir;

			};
			
			void vert (inout appdata_full v, out Input o) {

			}
			
sampler2D _Color;
sampler2D _Normal;
float4 _RimColor;
float _RimPower;
float _SpecPower;



			void surf (Input IN, inout EditorSurfaceOutput o) {
				o.Albedo = 0.0;
				o.Normal = float3(0.0,0.0,1.0);
				o.Emission = 0.0;
				o.Gloss = 0.0;
				o.Specular = 0.0;
				o.Alpha = 1.0;
float4 Tex2D0=tex2D(_Color,(IN.uv_Color.xyxy).xy);
float4 Tex2DNormal0=UnpackNormal( tex2D(_Normal,(IN.uv_Normal.xyxy).xy) );
float4 Fresnel0=float4( 1.0 - dot( normalize( float4(IN.viewDir, 1.0).xyz), normalize( Tex2DNormal0.xyz ) ) );
float4 Pow0=pow(Fresnel0,_RimPower.xxxx);
float4 Multiply0=_RimColor * Pow0;
float4 Master0_5_NoInput = float4(1,1,1,1);
float4 Master0_6_NoInput = float4(1,1,1,1);
o.Albedo = Tex2D0;
o.Normal = Tex2DNormal0;
o.Emission = Multiply0;
o.Specular = _SpecPower.xxxx;
o.Gloss = float4( Tex2D0.a);
o.Alpha = 1.0;

			}
		ENDCG
	}
	Fallback "Bumped Specular"
}