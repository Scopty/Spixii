Shader "Example/Diffuse Bump" {
    Properties {
	_Color ("Main Color", Color) = (1,1,1,1)
	_SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1)
	_Shininess ("Shininess", Range (0.01, 1)) = 0.078125
	_ReflectColor ("Reflection Color", Color) = (1,1,1,0.5)
	
      _MainTex ("Texture", 2D) = "white" {}
      _BumpMap ("Bumpmap", 2D) = "bump" {}
	  _BumpMap2 ("Bumpmap 2", 2D) = "bump" {}
	  
	  //_DispMap ("DispMap 2", 2D) = "bump" {}
    }
    SubShader {
      Tags { "RenderType" = "Opaque" }
      CGPROGRAM
      #pragma surface surf SimpleSpecular
	  #pragma target 3.0
      struct Input {
        float2 uv_MainTex;
		//float2 uv_DispMap;
        float2 uv_BumpMap;
		float2 uv_BumpMap2;
      };
	  
	  sampler2D _MainTex;
	  //sampler2D _DispMap;
      sampler2D _BumpMap;
	  sampler2D _BumpMap2;
	  
	  float4 _Color;
	float4 _ReflectColor;
	float _Shininess;
	float _Fresnel;
	  
	 /* void vert (inout appdata_full v) {
          v.vertex.xyz += v.normal * tex2D (_DispMap, IN.uv_MainTex).rgb;;
      }*/
	  
	  

      /*half4 LightingWrapLambert (SurfaceOutput s, half3 lightDir, half atten) {
          half NdotL = dot (s.Normal, lightDir);
          half diff = NdotL * 0.5 + 0.5;
          half4 c;
          c.rgb = s.Albedo * _LightColor0.rgb * (diff * atten * 2);
          c.a = s.Alpha;
          return c;
      }*/
	  
	  half4 LightingSimpleSpecular (SurfaceOutput s, half3 lightDir, half3 viewDir, half atten) {
          half3 h = normalize (lightDir + viewDir);

          half diff = max (0, dot (s.Normal, lightDir));

          float nh = max (0, dot (s.Normal, h));
          float spec = pow (nh, 48.0);

          half4 c;
          c.rgb = (s.Albedo * _LightColor0.rgb * diff + _LightColor0.rgb * spec) * (atten * 2);
          c.a = s.Alpha;
          return c;
      }
	  
      void surf (Input IN, inout SurfaceOutput o) {
        //o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
		half4 tex = tex2D(_MainTex, IN.uv_MainTex);
        half4 c = tex * _Color;
		o.Albedo = c.rgb;
		o.Gloss = tex.a;
        o.Specular = _Shininess;
        o.Normal = UnpackNormal (tex2D (_BumpMap, IN.uv_BumpMap)*1f);
      //+tex2D (_BumpMap2, IN.uv_BumpMap2)
		/*float3 worldRefl = WorldReflectionVector (IN, o.Normal);

        half4 reflcol = texCUBE (_Cube, worldRefl);
        reflcol *= tex.a;*/
		
		//o.Emission = reflcol.rgb * _ReflectColor.rgb;
        //o.Alpha = reflcol.a * _ReflectColor.a;
	  
	  
	  }
      ENDCG
    } 
    Fallback "Diffuse"
  }