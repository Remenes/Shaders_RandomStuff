Shader "Holistic/03.2 AllPropertiesChallenge4" {
	Properties {
		_myDiffuseTexture ("Diffuse Texture", 2D) = "black" {}
		_myEmissiveTexture ("Emmisin Texture", 2D) = "black" {}
	}

	SubShader {
		CGPROGRAM

		#pragma surface surf Lambert

		sampler2D _myDiffuseTexture;
		sampler2D _myEmissiveTexture;

		struct Input {
			fixed2 uv_myDiffuseTexture;
			fixed2 uv_myEmissiveTexture;
		};

		void surf(Input IN, inout SurfaceOutput o) {
			o.Albedo = tex2D(_myDiffuseTexture, IN.uv_myDiffuseTexture).rgb;
			o.Emission = tex2D(_myEmissiveTexture, IN.uv_myEmissiveTexture).rgb;
		}

		ENDCG
	}

	FallBack "Diffuse"
}