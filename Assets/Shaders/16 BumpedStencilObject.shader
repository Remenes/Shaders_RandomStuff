Shader "Custom/16 BumpedStencilObject" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_BumpTex ("Bump Map", 2D) = "bump" {}
		_BumpStrength ("Bump Strength", Range(0.25, 8)) = 1

		_StencilRef ("Stencil Ref", Float) = 1
		[Enum(UnityEngine.Rendering.CompareFunction)] _SComp ("Stencil Comparison", Float) = 8
		[Enum(UnityEngine.Rendering.StencilOp)] _SOp ("Stencil Operation", Float) = 2
	}
	SubShader {
		Tags { "Queue"="Geometry" }

		Stencil {
			Ref[_StencilRef]
			Comp[_SComp]
			Pass [_SOp]
		}

		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;
		sampler2D _BumpTex;

		struct Input {
			float2 uv_MainTex;
			float2 uv_BumpTex;
		};

		fixed _BumpStrength;

		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
			o.Normal = UnpackNormal(tex2D(_BumpTex, IN.uv_BumpTex));
			o.Normal *= fixed3(_BumpStrength, _BumpStrength, 1);
		}
		ENDCG
	}
	FallBack "Diffuse"
}
