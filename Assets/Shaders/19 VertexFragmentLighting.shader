Shader "Holistic/19 VertexFragmentLighting"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Tags {"LightMode" = "ForwardBase"} //Sets up so it's like Forward Rendering, which is the per model basis instead of the lighting at the end (like deferred)

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			#include "UnityLightingCommon.cginc" //Contains functions for lighting

			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL; //Need normal because it's lighting
				float4 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 diff : COLOR0; //Going to be the color produced in our calculations
				float4 vertex : SV_POSITION;
			};
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				half3 worldNormal = UnityObjectToWorldNormal(v.normal);
				 //_WorlddSpaceLightPos0 gives the vector of the light source
				half nl = max(0, dot(worldNormal, _WorldSpaceLightPos0.xyz));

				o.diff = nl * _LightColor0;

				return o;
			}

			sampler2D _MainTex;

			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col = tex2D(_MainTex, i.uv);
				col *= i.diff;
				return col;
			}
			ENDCG
		}
	}
}
