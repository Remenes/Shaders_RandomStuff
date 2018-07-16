Shader "Holistic/05.1 BumpedEnvironmentsChallenge" {
	Properties {
		_normalMap ("Normal", 2D) = "bump" {}
		_cubeMap ("Cube", CUBE) = "white" {}
		_normalStrength ("Normal Strength", Range(0, 2)) = .3
	}

	SubShader {
		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _normalMap;
		samplerCUBE _cubeMap;
		float _normalStrength;

		struct Input {
			float2 uv_normalMap;
			float3 worldRefl; INTERNAL_DATA
		};

		void surf (Input i, inout SurfaceOutput o) {
			o.Normal = UnpackNormal(tex2D(_normalMap, i.uv_normalMap)) * _normalStrength;
			//o.Albedo = texCUBE(_cubeMap, i.worldRefl).rgb;
			o.Albedo = texCUBE(_cubeMap, WorldReflectionVector(i, o.Normal)).rgb;
		}

		ENDCG
	}
	FallBack "Diffuse"
}
