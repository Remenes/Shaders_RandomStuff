Shader "Holistic/26 UVScroll" {
	Properties {
		_MainTex ("Texture", 2D) = "white" {}
		_SecondTex ("Overlaying Texture", 2D) = "white" {}
		_Tint ("Tint Color", Color) = (1,1,1,1)
		_Amp ("Wave Amplitude", Range(0, 5)) = 1
		_Freq ("Wave Frequency", Range(0, 2)) = 1
		_Speed ("Wave Speed", Range(-5, 5)) = 1

		_ScrollX("UV X Offset", Range(-5, 5)) = 0
		_ScrollY("UV Y Offset", Range(-5, 5)) = 0
	}

	SubShader {
		CGPROGRAM
		#pragma surface surf Lambert vertex:vert

		half _Freq;
		half _Speed;
		half _Amp;

		struct appdata {
			float4 vertex : POSITION;
			float3 normal : NORMAL;
			float2 texcoord : TEXCOORD0;
		};

		void vert(inout appdata v) {
			float t = _Time.z * _Speed;
			half waveHeight = (sin(t + v.vertex.x * _Freq) + sin(t*2 + v.vertex.x * _Freq/2)) * _Amp;
			v.vertex.y += waveHeight;
			v.normal = normalize(float3(v.normal.x + waveHeight, v.normal.y, v.normal.z));
		}

		sampler2D _MainTex;
		sampler2D _SecondTex;

		struct Input {
			float2 uv_MainTex;
			float2 uv_SecondTex;
		};

		half _ScrollX;
		half _ScrollY;

		void surf(Input IN, inout SurfaceOutput o) {
			_ScrollX *= _Time;
			_ScrollY *= _Time;
			float2 uvOffset = IN.uv_MainTex + float2(_ScrollX, _ScrollY);
			float2 uvSecondOffset = IN.uv_SecondTex + float2(_ScrollX, _ScrollY)/2;
			float3 first = tex2D(_MainTex, uvOffset).rgb;
			float3 second = tex2D(_SecondTex, uvSecondOffset).rgb;
			o.Albedo = (first + second) / 2;	
			//o.Albedo = first * second;
		}

		ENDCG
	}

	Fallback "Diffuse"
}