Shader "Masked/Mask" {
	Properties {
		//_MainTex ("Base (RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="TransparentCutOut" }
		//Tags {"Queue" = "Overlay"}
		//LOD 200
		
		Lighting Off

        // Draw into the depth buffer in the usual way.  This is probably the default,
        // but it doesn't hurt to be explicit.

        ZTest LEqual
        ZWrite On

        // Don't draw anything into the RGBA channels. This is an undocumented
        // argument to ColorMask which lets us avoid writing to anything except
        // the depth buffer.

        ColorMask A

        // Do nothing specific in the pass:

        Pass {}
	} 
	//FallBack "Diffuse"
}
