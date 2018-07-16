Shader "Holistic/17 ColorVertexFragment"
{
	SubShader
	{
		Pass //Need to have a pass if using vertex and fragment at once
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION; //"Mesh" space
			};

			struct v2f
			{
				float4 vertex : SV_POSITION; //Screen Space
				float4 color : COLOR;
			};

			v2f vert (appdata v) //Can use a GetComponent<MeshFilter>.mesh and get the .vertices of that to list alll the vertices (returns Vector3[])
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.color.r = (v.vertex.x + 4) / 7; //By using the vertices, the plane's max vertex is +5 (from center)
				o.color.b = (v.vertex.z + 4) / 7;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target //What is returned from the vert function gets passed in here: This has to return a color
			{
				fixed4 col = i.color;
				return col;
			}
			ENDCG
		}
	}
}
