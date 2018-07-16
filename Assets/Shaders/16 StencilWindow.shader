Shader "Holistic/16 StencilWindow" {
	Properties {
		_SRef ("Stencil Ref", Float) = 1
		[Enum(UnityEngine.Rendering.CompareFunction)] _SComp("Stencil Comp", Float) = 8
		[Enum(UnityEngine.Rendering.StencilOp)] _SOp("Stencil Op", Float) = 2
	}

	SubShader {
		Tags { "Queue" = "Geometry-1" }

		ZWrite Off
		ColorMask 0

		Stencil {
			Ref[_SRef]
			Comp[_SComp]
			Pass[_SOp]	
		}

		CGPROGRAM
		#pragma surface surf Lambert

		struct Input {
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutput o) {

		}

		ENDCG
	}

	Fallback "Diffuse"
}