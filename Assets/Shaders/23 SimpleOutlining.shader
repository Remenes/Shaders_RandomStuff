Shader "Holistic/23 SimpleOutlining" {
	Properties {
		_Color ("Outline Color", Color) = (1,0,0,1)
		_Width ("Outline Width", Range(0, 1.5)) = 0
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags { "Queue" = "Transparent" }

		Pass {
			ZWrite Off

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			struct appdata {
				float3 vertex : POSITION;
				float3 normal : NORMAL;
			};

			struct v2f {
				float4 vertex : SV_POSITION;
			};

			half _Width;

			v2f vert(appdata v) {
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex + v.normal * _Width);
				return o;
			}

			fixed4 _Color;

			fixed4 frag(v2f i) : SV_TARGET {
				return _Color;
			}

			ENDCG
		}
		
		CGPROGRAM
		#pragma surface surf Lambert fullforwardshadows

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
