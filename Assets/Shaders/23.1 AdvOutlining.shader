Shader "Holistic/23.1 AdvOutlining" {
	Properties {
		_Color ("Outline Color", Color) = (1,0,0,1)
		_Width ("Outline Width", Range(0, 1.5)) = 0
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
	}
	SubShader {

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

		Pass {
			Cull Front
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct appdata {
				float4 vertex : POSITION;
				float4 normal : NORMAL;	
			};

			struct v2f {
				float4 pos : SV_POSITION;
			};

			half _Width;

			v2f vert(appdata v) {
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				float3 normalInWorldSpace = normalize(mul((float3x3)UNITY_MATRIX_IT_MV, v.normal)); //Makes the local normal a world normal
				float2 offset = TransformViewToProjection(normalInWorldSpace.xy); //Makes this worldNormal a 2d vector in screen space
				o.pos.xy += offset * o.pos.z * _Width;
				return o;
			}

			fixed4 _Color;

			fixed4 frag(v2f i) : SV_TARGET {
				return _Color;
			}


			ENDCG
		}
	}
	FallBack "Diffuse"
}
