Shader "Holistic/08 StandardPhysicallyBasedRendering" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MetallicTex ("Metallic Texture (2D)", 2D) = "white" {} //It's a map to figure out which parts of the model that will be shiny: Grayscaled
		_Metallic ("Metallic", Range (0, 1)) = .5
		_Emissive ("Emissive Slider", Range(0, 1)) = 0
	}
	//Specular vs Metallic: Specular is the light bouncing off of object while Metallic changes the surface itself
	SubShader {
		Tags { "Queue" = "Geometry" }

		CGPROGRAM
		#pragma surface surf Standard

		float4 _Color;
		sampler2D _MetallicTex;
		half _Metallic;
		half _Emissive;

		struct Input {
			float2 uv_MetallicTex;	
		};

		void surf(Input IN, inout SurfaceOutputStandard o) {
			o.Albedo = _Color.rgb;
			o.Smoothness = tex2D(_MetallicTex, IN.uv_MetallicTex).r;
			o.Metallic = _Metallic;
			o.Emission = _Emissive * o.Smoothness;
		}

		ENDCG
	}

	FallBack "Diffuse"
}
