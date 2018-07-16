Shader "Holistic/24 Glass" {
	Properties {
		_Texture ("Glass Texture", 2D) = "white" {}
		_Normal ("Glass Distortion Normal", 2D) = "bump" {}
		_Strength ("Distort Strength", Range(1, 200)) = 1
	}

	SubShader {
		Tags { "Queue" = "Transparent" }
		GrabPass {}
		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc" 

			struct appdata {
				float4 pos : POSITION;
				float4 uv : TEXCOORD0;
			};

			struct v2f {
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
				float4 uvGrab : TEXCOORD1;
				float2 uvBump : TEXCOORD2;
			};

			sampler2D _GrabTexture;
			float4 _GrabTexture_TexelSize;
			sampler2D _Texture;
			float4 _Texture_ST;

			sampler2D _Normal;
			float4 _Normal_ST;

			v2f vert(appdata v) {
				v2f o;
				o.pos = UnityObjectToClipPos(v.pos);

				#if UNITY_UV_STARTS_AT_TOP
					float scale = -1.0;
				#else 
					float scale = 1.0;
				#endif

				o.uvGrab.xy = (float2(o.pos.x, o.pos.y * scale) + o.pos.w) * .5;
				o.uvGrab.zw = o.pos.zw;
				o.uv = TRANSFORM_TEX(v.uv, _Texture);
				o.uvBump = TRANSFORM_TEX(v.uv, _Normal);
				return o;
			}

			half _Strength;

			fixed4 frag(v2f i) : SV_TARGET {
				half2 bumpNormal = UnpackNormal(tex2D(_Normal, i.uvBump)).xy;
				float2 offset = bumpNormal * _Strength * _GrabTexture_TexelSize.xy;
				i.uvGrab.xy += offset * i.uvGrab.z;

				fixed4 grab = tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(i.uvGrab));
				fixed4 c = tex2D(_Texture, i.uv) * grab;
				return c;
			}

			ENDCG
		}
	}
}