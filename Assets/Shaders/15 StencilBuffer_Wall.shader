Shader "Holistic/15 StencilBuffer_Wall" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags { "Queue"="Geometry" }

		Stencil {
			Ref 1 //Try to write a one in there
			Comp notequal //Only write a one if what's there not equal to a 1
			Pass keep //Keep this frame pixel if the Comp is true (there is not already a 1 there)
		}

		CGPROGRAM
		#pragma surface surf Lambert 

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
