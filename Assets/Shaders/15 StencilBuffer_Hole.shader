Shader "Holistic/15 StencilBuffer_Hole" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags { "Queue"="Geometry-1" }

		ColorMask 0
		ZWrite Off
		Stencil {
			Ref 1 //Get ready the value of 1 to check against the stencil buffer
			Comp Always //Check if what is in there "matches" what this computation is.
			Pass replace //REplace what's in the frame buffer with this pixel pass if the comp goes through
		}

		//Blend DstColor Zero

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
