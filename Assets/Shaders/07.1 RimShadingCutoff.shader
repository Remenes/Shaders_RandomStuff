Shader "Holistic/07.1 RimShadingCutoff" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_RimOuter("Outer Rim Color", Color) = (1, 0, 0, 0)
		_RimInner("Inner Rim Color", Color) = (0, 1, 0, 0)
		_RimStrength("Rim Strength", Range(0.5, 8)) = 1
		_StripeSize("Stripe Length", Range(0.001, 5)) = .45
	}

	SubShader {
		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;
		half4 _RimOuter;
		half4 _RimInner;
		half _RimStrength;
		half _StripeSize;

		struct Input {
			float2 uv_MainTex;
			float3 viewDir;
			float3 worldPos;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
			half dotp = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
			half cutoff = pow(dotp, _RimStrength);
			half4 colorToShow = (cutoff > .5 ? _RimOuter : cutoff > .2 ? _RimInner : 0);
			o.Emission = frac(IN.worldPos.y * 5 / _StripeSize / 2) > .5 ? colorToShow : 0; //frac is like % 1
		}
		ENDCG
	}

	FallBack "Diffuse"
}
