Shader "Holistic/18 VertexFragmentMat"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_UVScaleX ("UV Scale X", Range(0.1, 15)) = 1
		_UVScaleY ("UV Scale Y", Range(0.1, 15)) = 1
	}
	SubShader
	{
		Tags { "Queue"="Transparent" } //Transpent because of the GrabPass

		GrabPass {} //This grabs what's already in the frame buffer through the entire screen

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
		
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0; //more TEXCOORD# will depend on multiple textures
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			sampler2D _GrabTexture; //Used with the GrabPass and must be spelled exactly this way
			sampler2D _MainTex;
			float4 _MainTex_ST;
			float _UVScaleX;
			float _UVScaleY;

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				//Can change color based on uv position, which is guarenteed to be between 0 and 1;

				o.uv.x = sin(o.uv.x * _UVScaleX);
				o.uv.y = sin(o.uv.y * _UVScaleY);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = tex2D(_GrabTexture, i.uv);
				 
				return col;
			}
			ENDCG
		}
	}
}
