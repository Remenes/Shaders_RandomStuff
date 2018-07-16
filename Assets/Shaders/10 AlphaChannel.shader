Shader "Holistic/10 AlphaChannel" {
	Properties {
		_MainTex ("Diffuse Texture", 2D) = "white" {}
	}
	SubShader {
		Tags { "Queue" = "Transparent" }

		CGPROGRAM
		#pragma surface surf Lambert alpha:fade //Transparency doesn't write to Z Buffer, so it will not write to something that already exists in the buffer

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
