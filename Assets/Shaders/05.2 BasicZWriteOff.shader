Shader "Holistic/05.2 BasicZWriteOff" {
	Properties {
		_RGB_Albedo ("Albedo", 2D) = "white" {}
	}

	SubShader {
		//Background = 1000, Geometry = 2000, AlphaTest = 2450, Transpart = 3000, Overlay = 4000
		//Objects with a lower render queue are drawn first, and then can be overlayed by others
		Tags { "Queue" = "Geometry+200" } //This means to set this object's render queue to draw after all Geometry has been drawn in
		ZWrite Off

		CGPROGRAM

		#pragma surface surf Lambert

		sampler2D _RGB_Albedo;

		struct Input {
			float2 uv_RGB_Albedo;
		};

		void surf(Input IN, inout SurfaceOutput o) {
			o.Albedo = tex2D(_RGB_Albedo, IN.uv_RGB_Albedo).rgb;
		}

		ENDCG
	}

	FallBack "Diffuse"
}
