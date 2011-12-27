Shader "Test Clip" {
    Properties {
      _MainTex ("Texture", 2D) = "white" {}
      _BumpMap ("Bumpmap", 2D) = "bump" {}
	  _planePoint ("plane point", Vector) = (0,0,0,0)
	  _planeNormal ("plane normal", Vector) = (0,1,0,0)
    }
    SubShader {
      Tags { "RenderType" = "Opaque" }
      Cull Off
      CGPROGRAM
      #pragma surface surf Lambert
      struct Input {
          float2 uv_MainTex;
          float2 uv_BumpMap;
          float3 worldPos;
      };
      sampler2D _MainTex;
      sampler2D _BumpMap;
	  float4 _planePoint;
	  float4 _planeNormal;
      void surf (Input IN, inout SurfaceOutput o) {
		 clip(dot(IN.worldPos - (float3)_planePoint,(float3)_planeNormal));
          o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
          o.Normal = UnpackNormal (tex2D (_BumpMap, IN.uv_BumpMap));
      }
      ENDCG
    } 
    Fallback "Diffuse"
  }
