Shader "Holistic/14 Blend2Textures" {
	Properties {
		_MainTex ("Diffuse Texture", 2D) = "white" {}
		_Decal ("Decal Texture", 2D) = "white" {}
		[Toggle] _ShowDecal("Show Decal?", Float) = 0

		//It is possible to change any of these variables using a Material's functions
		//SetFloat("[insert exact name of variable here]", [insert number]) will set that float value
	}

	SubShader {
		CGPROGRAM

		#pragma surface surf Lambert

		sampler2D _MainTex;
		sampler2D _Decal;
		fixed _ShowDecal;

		struct Input {
			float2 uv_MainTex;
			float2 uv_Decal;
		};

		void surf(Input IN, inout SurfaceOutput o) {
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			fixed4 decal = tex2D(_Decal, IN.uv_Decal) * _ShowDecal;
			o.Albedo = decal.rgb > .1 ? decal.rgb : c.rgb;
		}

		ENDCG
	}

	FallBack "Diffuse"
}