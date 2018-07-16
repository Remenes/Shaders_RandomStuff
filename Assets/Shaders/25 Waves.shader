Shader "Holistic/25 Waves" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Speed("Speed", Range(-10, 10)) = 1
		_Amp("Amplitude", Range(-3.5, 3.5)) = 1
		_Freq("Frequency", Range(.1, 10)) = 1
		_Tint("Tint", Color) = (1,1,1,1)
	}
	SubShader {
		CGPROGRAM
		#pragma surface surf Lambert vertex:vert

		sampler2D _MainTex;

		float4 _Tint;
		fixed _Speed;
		fixed _Amp;
		fixed _Freq;

		struct Input {
			float2 uv_MainTex;
			float3 vertColor;
		};

		struct appdata {
			float4 vertex : POSITION;
			float3 normal : NORMAL;
			float4 texcoord : TEXCOORD0;
		};

		void vert(inout appdata v) {
			
			float t = _Time * _Speed * 30;
			float waveHeight = sin(t + v.vertex * _Freq) * _Amp * v.texcoord;
			v.vertex.y += waveHeight;
			v.normal = normalize(float3(v.normal.x + waveHeight, v.normal.y, v.normal.z));
		}

		void surf (Input IN, inout SurfaceOutput o) {
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
		}

		ENDCG
	}
	FallBack "Diffuse"
}
