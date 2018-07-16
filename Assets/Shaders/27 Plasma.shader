Shader "Holistic/27 Plasma" {
	Properties {
		_Tint("Tint Color", Color) = (1,1,1,1)
		_Speed ("Speed", Range(.5, 100)) = 1
		_Scale1 ("Scale1", Range(.1, 20)) = 1
		_Scale2 ("Scale2", Range(.1, 20)) = 1
		_Scale3 ("Scale3", Range(.1, 20)) = 1
		_Scale4 ("Scale4", Range(.1, 20)) = 1


	}
	SubShader {
		CGPROGRAM
		#pragma surface surf Lambert
	
		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
			float3 worldPos;
		};

		fixed4 _Tint;
		half _Speed;
		half _Scale1;
		half _Scale2;
		half _Scale3;
		half _Scale4;

		void surf (Input IN, inout SurfaceOutput o) {
			float PI = 3.141459265;
			float t = _Time.x * _Speed;
			//vertical
			float c = sin(t + _Scale1 * IN.worldPos.x);
			//horizontal
			c += sin(t + _Scale2 * IN.worldPos.z);
			//diagonal
			c += sin(t + _Scale3 * (IN.worldPos.z * sin(t/2) * .5 + IN.worldPos.x * cos(t/3) * .5));
			//circular
			float c1 = pow(IN.worldPos.x + .5 * sin(t/5), 2);
			float c2 = pow(IN.worldPos.z + .75 * cos(t/3), 2);
			c += sin(sqrt(_Scale4 * (c1 + c2) + t));

			o.Albedo.r = sin(c * PI / 4 + PI);
			o.Albedo.g = sin(c * PI / 4 + PI/4);
			o.Albedo.b = sin(c * PI / 4 + PI/2);
			o.Albedo *= _Tint;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
