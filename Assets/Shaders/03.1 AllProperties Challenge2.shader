Shader "Holistic/03.1 AllPropertiesGreenChallenge" {

	Properties {
		_myTexture ("Texture", 2D) = "black" {}
	}

	SubShader {

		CGPROGRAM
			#pragma surface surf Lambert

			sampler2D _myTexture;

			struct Input {
				fixed2 uv_myTexture;
			};

			void surf(Input IN, inout SurfaceOutput o) {
				float4 green = float4(0,1,0,1);
				o.Albedo = (tex2D(_myTexture, IN.uv_myTexture) * green).rgb;

			}

		ENDCG

	}

	FallBack "Diffuse"
}