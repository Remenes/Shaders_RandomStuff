Shader "Holistic/22 VertexExtrude" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Strength ("Extrude Strength", Range(0,1)) = 0
	}
	SubShader {
		Tags { "Queue"="Geometry" }
		
		CGPROGRAM
		#pragma surface surf Lambert vertex:vert

		half _Strength;

		struct appdata {
			float3 normal : NORMAL;
			float4 vertex : POSITION;
			float4 texcoord : TEXCOORD0; //Required since the surface shader needs to put a uv value; must be named texcoord
		};

		void vert(inout appdata v) {
			v.vertex.xyz += v.normal * _Strength;
		}

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
