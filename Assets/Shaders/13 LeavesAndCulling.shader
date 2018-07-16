Shader "Holistic/13 LeavesAndCulling" {
	Properties {
		_MainTex ("Diffuse Texture", 2D) = "white" {}
	}
	SubShader {
		Tags { "Queue" = "Transparent" }
		//Blend SrcAlpha OneMinusSrcAlpha
		Cull Off //Don't cut off any polygons (Back for cut off polygons facing away from viewer, Front for polygons facing viewer)
		Pass {
			SetTexture [_MainTex] {combine texture}
		}
	}
	FallBack "Diffuse"
}
