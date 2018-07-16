Shader "Unlit/27.1 PlasmaVF"
{
	Properties
	{
		_GrowAmount ("Expansion Amount", Range(0, 5)) = 1
		_GrowSpeed ("Expansion Speed", Range(0, 5)) = 1
		_Speed ("Speed", Range(0, 50)) = 5
		_Scale1 ("Scale1", Range(0, 10)) = 1
		_Scale2 ("Scale2", Range(0, 10)) = 1
		_Scale3 ("Scale3", Range(0, 10)) = 1
		_Scale4 ("Scale4", Range(0, 10)) = 1

	}
	SubShader
	{
		
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
		
			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float4 color : COLOR;
			};

			float _GrowAmount;
			float _GrowSpeed;
			float _Speed;
			float _Scale1;
			float _Scale2;
			float _Scale3;
			float _Scale4;

			v2f vert (appdata v)
			{
				v2f o;
				float t = _Time * _Speed;
				float2 fromUVCenter = (v.uv - float2(.5,.5)) * _GrowAmount;
				float2 vOffset = float2(fromUVCenter.x, fromUVCenter.y) * sin(_Time * _GrowSpeed);
				float4 newVertex = v.vertex;
				newVertex.x -= vOffset.x;
				newVertex.z += vOffset.y;	
				o.vertex = UnityObjectToClipPos(newVertex);

				float4 c = sin(t + _Scale1 * v.uv.x);
				c += sin(t + _Scale2 * v.uv.y);
				c += sin(t + _Scale3 * (v.uv.x * sin(t/4) + v.uv.y * cos(t/3)));
				c += sin(t + _Scale4 * (pow(v.uv.x * sin(t/3), 2) + pow(v.uv.y * cos(t/5), 2)));

				o.color = c;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				return i.color;
			}
			ENDCG
		}
	}
}
