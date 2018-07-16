Shader "Holistic/05 BumpedEnvironments" {
	Properties {
		_myDiffuse ("Diffuse", 2D) = "white" {}
		_myBump ("Bump", 2D) = "bump" {}
		_myBumpStrength ("Bump Strength", Range(0, 10)) = 1
		_myBrightness ("Brightness", Range(0, 1)) = .5
		_myCube ("Cube Map", CUBE) = "white" {}
	}

	SubShader {

		CGPROGRAM
			#pragma surface surf Lambert
			sampler2D _myDiffuse;
			sampler2D _myBump; 
			half _myBumpStrength;
			float _myBrightness;
			samplerCUBE _myCube;

			struct Input {
				float2 uv_myDiffuse;
				float2 uv_myBump;
				float3 worldRefl; INTERNAL_DATA
			};

			void surf (Input IN, inout SurfaceOutput o) {
				o.Albedo = tex2D(_myDiffuse, IN.uv_myDiffuse).rgb;
				o.Normal = UnpackNormal(tex2D(_myBump, IN.uv_myBump));
				o.Normal *= float3(_myBumpStrength, _myBumpStrength, 1);
				o.Emission = texCUBE(_myCube, WorldReflectionVector (IN, o.Normal)).rgb;
			}

		ENDCG
	}

	Fallback "Diffuse"
}