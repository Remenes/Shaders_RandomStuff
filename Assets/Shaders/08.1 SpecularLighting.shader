Shader "Holistic/08.1 SpecularLighting" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_SpecTex ("Specular Texture (2D)", 2D) = "black" {}
		_SpecColor ("Specular", Color) = (1,1,1,1)

	}
	//Specular vs Metallic: Specular is the light bouncing off of object while Metallic changes the surface itself
	SubShader {
		Tags { "Queue" = "Geometry" }

		CGPROGRAM
		#pragma surface surf StandardSpecular

		sampler2D _SpecTex;

		struct Input {
			float2 uv_SpecTex;
		};

		fixed4 _Color;

		void surf (Input IN, inout SurfaceOutputStandardSpecular o) {
			o.Albedo = _Color.rgb;
			// Metallic and smoothness come from slider variables
			o.Smoothness = tex2D(_SpecTex, IN.uv_SpecTex).r;
			o.Specular = _SpecColor.rgb; //Specular is actually a fixed 3 of rgb values
		}
		ENDCG
	}
	FallBack "Diffuse"
}
