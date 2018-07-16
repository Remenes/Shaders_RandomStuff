Shader "Holistic/09.3 ToonRampUsingViewDir" {
	Properties {
		_Color ("Albedo (RGB)", Color) = (1,1,1,1)
		_RampTex ("Ramp Texture", 2D) = "white" {}
	}
	SubShader {
		Tags { "Queue" = "Geometry" }

		CGPROGRAM
		#pragma surface surf ToonRamp //The name of the function below must be the name "Lighting" + the name here

		sampler2D _RampTex;

		half4 LightingToonRamp (SurfaceOutput o, half3 lightDir, half atten) {
			//SurfaceOutput is the same output used in surface shader
			//LightDir is the direction of where the light is coming from
			//Attenuation is the intensity of the light as it hits the object (light loses intensity along the way)
			float diff = dot(o.Normal, lightDir);
			float2 texPos = diff * .5 + .5;
			float3 ramp = tex2D(_RampTex, texPos).rgb;

			half4 c;
			//_LightColor0 is the lighting color of the current scene (actually contains all the light that is hitting the object)
			c.rgb = o.Albedo * _LightColor0.rgb * ramp; //Taking off the _LightColor0 would mean that lighting color has no effect on i
			c.a = o.Alpha;
			return c;
		}

		struct Input {
			float2 uv_MainTex;
			float3 viewDir;
		};

		half4 _Color;

		void surf (Input IN, inout SurfaceOutput o) {
			float diff = dot(o.Normal, IN.viewDir);
			float2 texPos = diff * .5 + .5;
			float3 ramp = tex2D(_RampTex, texPos).rgb;

			o.Albedo = _Color.rgb * ramp;

		}
		ENDCG
	}
	FallBack "Diffuse"
}
