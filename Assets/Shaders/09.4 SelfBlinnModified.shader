Shader "Holistic/09.4 SelfBlinnModified" {
	Properties {
		_Color ("Albedo (RGB)", Color) = (1,1,1,1)
	}
	SubShader {
		Tags { "Queue" = "Geometry" }

		CGPROGRAM
		#pragma surface surf MyBlinn //The name of the function below must be the name "Lighting" + the name here

		half4 LightingMyBlinn (SurfaceOutput o, half3 lightDir, half3 viewDir, half atten) {
			//SurfaceOutput is the same output used in surface shader
			//LightDir is the direction of where the light is coming from
			//ViewDir is the direction of the viewer
			//Attenuation is the intensity of the light as it hits the object (light loses intensity along the way)
			half3 halfwayVector = normalize(viewDir + lightDir);

			half diff = max(0, dot(o.Normal, lightDir)); //This will be stronger when the lightDir and the Normal are closer together

			half normalHalf = max(0, dot(o.Normal, halfwayVector)); //How much strength the specular will have. The closer, the stronger
			float spec = pow(normalHalf, 48);

			half4 c;
			//_LightColor0 is the lighting color of the current scene (actually contains all the light that is hitting the object)
			//c.rgb = (o.Albedo * _LightColor0.rgb * diff + _LightColor0.rgb * spec) * atten; //Taking off the _LightColor0 would mean that lighting color has no effect on i
			c.rgb = (o.Albedo * _LightColor0.rgb * diff + _LightColor0.rgb * spec) * atten * _SinTime;
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
