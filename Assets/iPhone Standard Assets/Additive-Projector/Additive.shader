Shader "Projector/Additive" {
  Properties {
  	  _Color ("Main Color", Color) = (1,1,1,1)   	
     _ShadowTex ("Cookie", 2D) = "" { TexGen ObjectLinear }
     _FalloffTex ("FallOff", 2D) = "" { TexGen ObjectLinear }
  }
  Subshader {
     Pass {
        ZWrite off
        //Fog { Color (1, 1, 1) }
        Color [_Color]
        ColorMask RGB
        Blend DstColor One
        SetTexture [_ShadowTex] {
		   combine texture * primary, ONE - texture
           Matrix [_Projector]
        }
        SetTexture [_FalloffTex] {
           constantColor (0,0,0,0)
           combine previous lerp (texture) constant
           Matrix [_ProjectorClip]
        }
     }
  }
}