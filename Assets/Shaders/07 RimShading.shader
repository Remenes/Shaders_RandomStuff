Shader "Holistic/07 RimShading" {
	Properties {
		_RimColor("Rim Color", Color) = (1, 0, 0, 0)
		_Texture ("Main Texture", 2D) = "white" {}
		_RimPow("Rim Strength", Range(0.5, 10)) = 1
	}

	SubShader {
		
		CGPROGRAM
		#pragma surface surf Lambert

		float4 _RimColor;
		sampler2D _Texture;
		half _RimPow;

		struct Input {
			float2 uv_Texture;
			float3 viewDir;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = tex2D(_Texture, IN.uv_Texture).rgb;
			half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
			o.Emission = pow(rim, _RimPow * 2) * _RimColor.rgb;
		}
		ENDCG
	}

	FallBack "Diffuse"
}
