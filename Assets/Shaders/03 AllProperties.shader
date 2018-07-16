Shader "Holistic/03 AllProperties" {

	Properties {
		_myColour ("Example Colour", Color) = (1,1,1,1) //fixed4
		_myRange ("Example Range", Range(0,5)) = 2.5 //half
		_myTex ("Example Texture", 2D) = "white" {} //sampler2D
		_myCube ("Example Cube", CUBE) = "" {} //samplerCUBE
		_myFloat ("Example Float", Float) = .5 //float
		_myVector ("Example Vector", Vector) = (.5,1,1,1) //float4
	}

	SubShader {
		CGPROGRAM
			#pragma surface surf Lambert

			fixed4 _myColour;
			half _myRange;
			sampler2D _myTex;
			samplerCUBE _myCube;
			float _myFloat;
			float4 _myVector;

			struct Input {
				float2 uv_myTex; //uv, followed by name of texture
				float3 worldRefl;
			};

			void surf (Input IN, inout SurfaceOutput o) {
				
				o.Albedo = (tex2D(_myTex, IN.uv_myTex) * _myRange * _myColour).rgb;
				o.Emission = texCUBE(_myCube, IN.worldRefl).rgb;
			}

		ENDCG
	}

	FallBack "Diffuse"


}