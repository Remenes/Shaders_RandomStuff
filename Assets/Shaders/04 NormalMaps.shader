Shader "Holistic/04 NormalMapping" {
	Properties {
		_diffuseTexture ("Albedo Texture", 2D) = "white" {}
		_normalTexture ("Normal Map", 2D) = "bump" {}
		_strength ("Strength Multiplier", Range(0, 50)) = 1
	}

	SubShader {
		CGPROGRAM

		#pragma surface surf Lambert

		sampler2D _diffuseTexture;
		sampler2D _normalTexture;
		half _strength;

		struct Input {
			float2 uv_diffuseTexture;
			float2 uv_normalTexture;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = tex2D(_diffuseTexture, IN.uv_diffuseTexture).rgb;
			o.Normal = UnpackNormal(tex2D(_normalTexture, IN.uv_normalTexture));
			o.Normal *= float3(_strength, _strength, 1);
		}

		ENDCG
	}

	FallBack "Diffuse"
}