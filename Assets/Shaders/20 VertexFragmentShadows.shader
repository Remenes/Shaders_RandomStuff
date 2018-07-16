Shader "Holistic/20 VertexFragmentShadows" {
	Properties {
		_MainTex ("Diffuse", 2D) = "white" {}
	}
	SubShader {

		Pass {

			Tags { "LightMode" = "ForwardBase" }

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fwdbase nolightmap nodirlightmap nodynlightmap novertexlight
			#include "UnityCG.cginc"
			#include "UnityLightingCommon.cginc"
			#include "Lighting.cginc"
			#include "AutoLight.cginc"

			struct appdata {
				float2 uv : TEXCOORD0;
				float4 normal : NORMAL;
				float4 vertex : POSITION;
			};

			struct v2f {
				float4 pos : SV_POSITION; //The TRANSFOER_SHADOW code below looks for a "pos" here, which is like the vertexes
				float2 uv : TEXCOORD0;
				float4 diff : COLOR;
				SHADOW_COORDS(1)
			};


			float4 _MainTex_ST;

			v2f vert(appdata v) {
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				half3 worldNormal = UnityObjectToWorldNormal(v.normal);
				half diff = max(0, dot(worldNormal, _WorldSpaceLightPos0.xyz));
				o.diff = diff * _LightColor0;
				TRANSFER_SHADOW(o)
				return o;
			}

			sampler2D _MainTex;

			fixed4 frag(v2f i) : SV_TARGET {
				fixed4 c = tex2D(_MainTex, i.uv);
				fixed shadow = SHADOW_ATTENUATION(i); //Gives positions for where a shadow will be over it
				c.rgb *= i.diff * shadow + fixed3(1 - shadow,0,0);
				return c;
			}

			ENDCG
		}

		Pass {
			Tags { "LightMode" = "ShadowCaster" }

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_shadowcaster
			#include "UnityCG.cginc"

			struct appdata {
				float4 vertex : POSITION;
				float3 normal : NORMAL;

			};

			struct v2f {
				V2F_SHADOW_CASTER; //appdata is transformed to this using the shadow code
			};

			v2f vert(appdata v) {
				v2f o;
				//No semicolon
				TRANSFER_SHADOW_CASTER_NORMALOFFSET(o) 
				return o;
			}

			float4 frag(v2f i) : SV_TARGET {
				SHADOW_CASTER_FRAGMENT(i)
			}

			ENDCG
		}

	}

}
