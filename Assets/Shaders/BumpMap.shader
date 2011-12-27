Shader "Custom/BumpMap" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_HeightMap ("HeightMap (RGB)", 2D) = "black" {}
		//_BumpStrength ("HeightMap strength", Range (0.03, 10)) = 1.0
	}
	SubShader {
      Tags { "RenderType" = "Opaque" }
      CGPROGRAM
      #pragma surface surf BlinnPhong
      
      struct Input {
          float2 uv_MainTex;
      };
      sampler2D _MainTex;
      
      sampler2D _HeightMap;
      uniform float4 _HeightMap_TexelSize;
      
      //uniform float _BumpStrength;
      
      void surf (Input IN, inout SurfaceOutput o) 
      {
      		float3 normal = float3(0, 0, 1);
      	
      		float heightSampleCenter = tex2D (_HeightMap, IN.uv_MainTex).r;
      		float heightSampleRight = tex2D (_HeightMap, IN.uv_MainTex + float2(_HeightMap_TexelSize.x, 0)).r;
      		float heightSampleUp = tex2D (_HeightMap, IN.uv_MainTex + float2(0, _HeightMap_TexelSize.y)).r;
      
      		float sampleDeltaRight = heightSampleRight - heightSampleCenter;
      		float sampleDeltaUp = heightSampleUp - heightSampleCenter;
      
      		//TODO: Expose?
      		float _BumpStrength = 3.0f;
      
      		normal = cross(
      		float3(1, 0, sampleDeltaRight * _BumpStrength), 
      		float3(0, 1, sampleDeltaUp * _BumpStrength));
      
      
      		normal = normalize(normal);
      
          	o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;//*0.001 + normal*0.5 + 0.5;
          	o.Gloss = 0.9;
          	o.Specular = 1;
          	o.Normal = normal;
          
      }
      ENDCG
    }
    
}