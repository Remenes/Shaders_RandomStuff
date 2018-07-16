Shader "Holistic/09 SelfLambert" {
	Properties {
		_Color ("Albedo (RGB)", Color) = (1,1,1,1)
	}
	SubShader {
		Tags { "Queue" = "Geometry" }

		CGPROGRAM
		#pragma surface surf MyLambert //The name of the function below must be the name "Lighting" + the name here

		half4 LightingMyLambert (SurfaceOutput o, half3 lightDir, half atten) {
			//SurfaceOutput is the same output used in surface shader
			//LightDir is the direction of where the light is coming from
			//Attenuation is the intensity of the light as it hits the object (light loses intensity along the way)
			half NormalDotLight = dot(o.Normal, lightDir); //Lambert doesn't need the viewer's direction
			half4 c;
			//_LightColor0 is the lighting color of the current scene (actually contains all the light that is hitting the object)
			c.rgb = o.Albedo * _LightColor0.rgb * (NormalDotLight * atten); //Taking off the _LightColor0 would mean that lighting color has no effect on i
			c.a = o.Alpha;
			return c;
		}

		struct Input {
			float2 uv_MainTex;
		};

		half4 _Color;

		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = _Color.rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
