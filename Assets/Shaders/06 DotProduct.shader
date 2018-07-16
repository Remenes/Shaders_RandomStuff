Shader "Holistic/06 DotProduct" {
	Properties {
		_MainTex ("Albedo", 2D) = "white" {}
	}

	SubShader {
		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;

		struct Input {
			float3 viewDir;
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutput o) {
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex);
			half dotp = 1-dot(IN.viewDir, o.Normal);
			//o.Albedo += dotp;
			o.Emission = dotp;
		}

		ENDCG
	}

	FallBack "Diffuse"
}
