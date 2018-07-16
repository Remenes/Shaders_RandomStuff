Shader "Holistic/02 PackedPractice" {
	Properties {
		_myColour ("Color", Color) = (1,1,1,1)
	}

	SubShader {

		CGPROGRAM
			#pragma surface surf Lambert

			struct Input {
				float2 uvMainTex;
			};

			fixed4 _myColour;

			void surf (Input IN, inout SurfaceOutput o) {
				o.Albedo.y = _myColour.g; //Same as albedo.g = color.g
			}

		ENDCG
	}

	FallBack "Diffuse"
}