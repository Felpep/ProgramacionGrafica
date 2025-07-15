// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ToonLighting"
{
	Properties
	{
		_FrenelScale("FrenelScale", Range( -30 , 50)) = 7
		_FresnelPower("FresnelPower", Range( 0 , 20)) = 7
		_Fresnel("Fresnel", Color) = (0,0,0,0)
		_Step1("Step1", Range( 0 , 0.33)) = 0
		_Step2("Step2", Range( 0 , 0.33)) = 0
		_Step3("Step3", Range( 0 , 0.33)) = 0
		_Color0("Color 0", Color) = (0,0,0,0)
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma surface surf StandardCustomLighting keepalpha noshadow 
		struct Input
		{
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform float _FrenelScale;
		uniform float _FresnelPower;
		uniform float4 _Fresnel;
		uniform float _Step1;
		uniform float _Step2;
		uniform float _Step3;
		uniform float4 _Color0;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float fresnelNdotV36 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode36 = ( 0.0 + _FrenelScale * pow( 1.0 - fresnelNdotV36, _FresnelPower ) );
			float4 Fresnel37 = ( fresnelNode36 * _Fresnel );
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float dotResult6 = dot( ase_worldlightDir , ase_worldNormal );
			float temp_output_10_0 = (dotResult6*0.5 + 0.5);
			float LightShadow26 = temp_output_10_0;
			float temp_output_48_0 = ( _Step1 + _Step2 );
			float TripleShadow62 = ( ( 0.3333333 * step( _Step1 , LightShadow26 ) ) + ( 0.3333333 * step( temp_output_48_0 , LightShadow26 ) ) + ( 0.3333333 * step( ( temp_output_48_0 + _Step3 ) , LightShadow26 ) ) );
			c.rgb = ( ( Fresnel37 + TripleShadow62 ) * _Color0 ).rgb;
			c.a = 1;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
0;454;1020;220;1237.525;-79.55002;2.462953;True;False
Node;AmplifyShaderEditor.CommentaryNode;27;-1676.17,350.7249;Inherit;False;840.5376;548.0573;Comment;12;60;14;16;15;26;58;13;10;6;11;5;3;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldNormalVector;5;-1588.588,539.7957;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;3;-1626.17,400.725;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;63;-1691.397,931.1741;Inherit;False;1070.852;474.5884;Comment;14;62;56;55;52;48;44;53;54;50;49;45;51;46;47;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DotProductOpNode;6;-1386.855,455.8437;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-1390.281,549.7518;Inherit;False;Constant;_HalfLambert;HalfLambert;0;0;Create;True;0;0;0;False;0;False;0.5;0.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;46;-1658.983,1067.29;Inherit;False;Property;_Step1;Step1;7;0;Create;True;0;0;0;False;0;False;0;0.165;0;0.33;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;47;-1658.681,1151.81;Inherit;False;Property;_Step2;Step2;8;0;Create;True;0;0;0;False;0;False;0;0.215;0;0.33;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;10;-1270.807,435.1321;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;48;-1291.788,1186.885;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;51;-1656.753,1236.745;Inherit;False;Property;_Step3;Step3;9;0;Create;True;0;0;0;False;0;False;0;0.237;0;0.33;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;26;-1088.66,433.1911;Inherit;False;LightShadow;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;45;-1354.127,1101.545;Inherit;True;26;LightShadow;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;52;-1294.109,1285.415;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;41;-1680.751,-158.3536;Inherit;False;951.3589;419.8382;FRESNEL;8;37;38;36;35;34;31;40;33;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-1205.605,166.2576;Inherit;False;Property;_FresnelPower;FresnelPower;4;0;Create;True;0;0;0;False;0;False;7;20;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-1205.93,94.8636;Inherit;False;Property;_FrenelScale;FrenelScale;3;0;Create;True;0;0;0;False;0;False;7;-30;-30;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;44;-1144.42,1005.424;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;49;-1146.082,1099.252;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;35;-1348.129,-68.36685;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.StepOpNode;50;-1147.826,1196.8;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;53;-1015.206,992.1908;Inherit;False;2;2;0;FLOAT;0.3333333;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;55;-1014.256,1197.86;Inherit;False;2;2;0;FLOAT;0.3333333;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;40;-943.2883,72.13918;Inherit;False;Property;_Fresnel;Fresnel;6;0;Create;True;0;0;0;False;0;False;0,0,0,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;54;-1013.951,1096.589;Inherit;False;2;2;0;FLOAT;0.3333333;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;36;-1164.301,-67.65024;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;56;-858.1586,1075.554;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;-940.7335,-23.26662;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;37;-938.8468,-97.48108;Inherit;False;Fresnel;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;62;-850.6523,1287.065;Inherit;False;TripleShadow;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;64;-514.9428,493.4981;Inherit;False;62;TripleShadow;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;43;-510.365,320.2206;Inherit;False;37;Fresnel;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;42;-36.89201,330.5982;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;75;-1699.625,1449.523;Inherit;False;1303.778;438.8475;Comment;9;74;68;66;65;71;67;70;69;72;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;78;-13.71283,472.8642;Inherit;False;Property;_Color0;Color 0;13;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.3396226,0.21492,0.09451757,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;14;-1081.768,613.6447;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;16;-1324.73,710.5085;Inherit;False;Property;_Shadow;Shadow;1;0;Create;True;0;0;0;False;0;False;0.1226415,0.1226415,0.1226415,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;31;-1638,114.7272;Inherit;False;Property;_NormalScale;NormalScale;5;0;Create;True;0;0;0;False;0;False;0;0.3463651;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;60;-1087.439,738.7578;Inherit;False;SimpleShadow;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-1388.913,624.1813;Inherit;False;Property;_Step;Step;0;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;74;-1649.248,1773.21;Inherit;False;Property;_BricksNormal;BricksNormal;12;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.IndirectSpecularLight;4;-183.1729,-205.7516;Inherit;False;Tangent;3;0;FLOAT3;0,0,1;False;1;FLOAT;0.5;False;2;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;61;-522.8207,401.0162;Inherit;False;60;SimpleShadow;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;58;-1081.573,512.6809;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;2;-179.4021,-7.539888;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;65;-1337.25,1499.523;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ColorNode;15;-1560.262,710.6592;Inherit;False;Property;_Light;Light;2;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;77;271.2699,327.2751;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;72;-624.9868,1715.431;Inherit;False;NormalToon;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;69;-714.9576,1524.725;Inherit;True;Property;_TextureSample1;Texture Sample 1;11;0;Create;True;0;0;0;False;0;False;-1;None;0ea1aaae175dfd448934e18d9b58190a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScaleAndOffsetNode;70;-943.8104,1554.552;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;71;-1100.776,1667.212;Inherit;False;Constant;_Float0;Float 0;13;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;67;-1097.935,1554.642;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;66;-1299.668,1638.594;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;68;-1649.625,1585.628;Inherit;True;Property;_TextureSample0;Texture Sample 0;10;0;Create;True;0;0;0;False;0;False;-1;None;0ea1aaae175dfd448934e18d9b58190a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LightAttenuation;1;-183.4019,-78.53989;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;73;-33.42796,183.5654;Inherit;False;72;NormalToon;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;495.4004,69.06351;Float;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;ToonLighting;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;6;0;3;0
WireConnection;6;1;5;0
WireConnection;10;0;6;0
WireConnection;10;1;11;0
WireConnection;10;2;11;0
WireConnection;48;0;46;0
WireConnection;48;1;47;0
WireConnection;26;0;10;0
WireConnection;52;0;48;0
WireConnection;52;1;51;0
WireConnection;44;0;46;0
WireConnection;44;1;45;0
WireConnection;49;0;48;0
WireConnection;49;1;45;0
WireConnection;50;0;52;0
WireConnection;50;1;45;0
WireConnection;53;1;44;0
WireConnection;55;1;50;0
WireConnection;54;1;49;0
WireConnection;36;0;35;0
WireConnection;36;2;34;0
WireConnection;36;3;33;0
WireConnection;56;0;53;0
WireConnection;56;1;54;0
WireConnection;56;2;55;0
WireConnection;38;0;36;0
WireConnection;38;1;40;0
WireConnection;37;0;38;0
WireConnection;62;0;56;0
WireConnection;42;0;43;0
WireConnection;42;1;64;0
WireConnection;14;0;16;0
WireConnection;14;1;15;0
WireConnection;14;2;58;0
WireConnection;60;0;14;0
WireConnection;58;0;13;0
WireConnection;58;1;10;0
WireConnection;77;0;42;0
WireConnection;77;1;78;0
WireConnection;72;0;69;1
WireConnection;69;1;70;0
WireConnection;70;0;67;0
WireConnection;70;1;71;0
WireConnection;70;2;71;0
WireConnection;67;0;65;0
WireConnection;67;1;66;0
WireConnection;66;0;68;0
WireConnection;0;13;77;0
ASEEND*/
//CHKSM=2A0BCE6C60241584B486269DD15B769E7E8728B6