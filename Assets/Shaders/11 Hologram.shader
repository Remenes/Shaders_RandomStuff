Shader "Holistic/11 Hologram" {
	Properties {
		_RimColor("Rim Color", Color)  = (0,0,0,0)
		_RimStrength("Rim Strength", Range(1, 10)) = 2
	}
	SubShader {
		Tags { "Queue" = "Transparent" }

		Pass {
			ZWrite On
			ColorMask 0

		}

		CGPROGRAM
		#pragma surface surf Lambert alpha:fade

		struct Input {
			float2 uv_MainTex;
			float3 viewDir;
		};

		fixed4 _MainColor;
		fixed4 _RimColor;
		fixed _RimStrength;

		void surf (Input IN, inout SurfaceOutput o) {
			half dotp = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
			half rim = pow(dotp, _RimStrength) * 10;
			o.Emission = _RimColor.rgb * rim;
			o.Alpha = pow(dotp, _RimStrength);
		}
		ENDCG

	}
	FallBack "Diffuse"
}
