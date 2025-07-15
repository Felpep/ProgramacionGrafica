// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Ceil"
{
	Properties
	{
		_Color0("Color 0", Color) = (0.245283,0.245283,0.245283,0)
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _Color0;
		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			o.Albedo = ( _Color0 * tex2D( _TextureSample0, uv_TextureSample0 ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
0;421;1020;253;3751.763;616.6464;4.721488;True;False
Node;AmplifyShaderEditor.CommentaryNode;19;-2336,-304;Inherit;False;840.5376;548.0573;Comment;12;31;30;29;28;27;26;25;24;23;22;21;20;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;4;-2340.731,298.6449;Inherit;False;1070.852;474.5884;Comment;14;18;17;16;15;14;13;12;11;10;9;8;7;6;5;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;2;-604.3815,145.4149;Inherit;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;True;0;0;0;False;0;False;-1;None;e781607505ada31459bee6b20996e35e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;1;-528.6863,-35.9162;Inherit;False;Property;_Color0;Color 0;0;0;Create;True;0;0;0;False;0;False;0.245283,0.245283,0.245283,0;0.5660378,0.4442322,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;34;-2352,-768;Inherit;False;951.3589;419.8382;FRESNEL;9;43;42;41;40;39;38;37;36;35;;1,1,1,1;0;0
Node;AmplifyShaderEditor.StepOpNode;12;-1793.754,372.8948;Inherit;False;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;38;-1872,-448;Inherit;False;Property;_FresnelPower;FresnelPower;8;0;Create;True;0;0;0;False;0;False;7;0.7;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;40;-1840,-672;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;39;-1616,-528;Inherit;False;Property;_Fresnel;Fresnel;12;0;Create;True;0;0;0;False;0;False;0,0,0,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-1664.54,359.6616;Inherit;False;2;2;0;COLOR;0.3333333,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-1663.59,565.3308;Inherit;False;2;2;0;COLOR;0.3333333,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-1663.285,464.0598;Inherit;False;2;2;0;COLOR;0.3333333,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-1872,-512;Inherit;False;Property;_FrenelScale;FrenelScale;6;0;Create;True;0;0;0;False;0;False;7;0.1;-30;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;18;-1499.986,654.5358;Inherit;False;TripleShadow;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WorldNormalVector;36;-2016,-672;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-188.7288,0.9059539;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;25;-1744,-224;Inherit;False;LightShadow;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-2304,-496;Inherit;False;Property;_NormalScale;NormalScale;10;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;-1616,-624;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;13;-1795.416,466.7228;Inherit;False;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;17;-1507.493,443.0248;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;20;-2288,-256;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;10;-2003.461,469.0159;Inherit;True;26;SimpleShadow;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;11;-1797.16,564.2709;Inherit;False;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DotProductOpNode;23;-2048,-192;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-2048,-112;Inherit;False;Constant;_HalfLambert;HalfLambert;0;0;Create;True;0;0;0;False;0;False;0.5;0.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-2048,-32;Inherit;False;Property;_Step;Step;1;0;Create;True;0;0;0;False;0;False;1;0.88;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;24;-1920,-224;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;29;-1744,-144;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;31;-2224,48;Inherit;False;Property;_Light;Light;5;0;Create;True;0;0;0;False;0;False;1,1,1,0;0.5283019,0.5283019,0.5283019,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;27;-1984,48;Inherit;False;Property;_Shadow;Shadow;4;0;Create;True;0;0;0;False;0;False;0.1226415,0.1226415,0.1226415,0;0.2641509,0.2641509,0.2641509,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;30;-1744,-48;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-2308.015,519.2809;Inherit;False;Property;_Step2;Step2;9;0;Create;True;0;0;0;False;0;False;0;0.06996445;0;0.33;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-2308.317,434.7609;Inherit;False;Property;_Step1;Step1;7;0;Create;True;0;0;0;False;0;False;0;0;0;0.33;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;21;-2240,-112;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;26;-1744,80;Inherit;False;SimpleShadow;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-2306.087,604.2158;Inherit;False;Property;_Step3;Step3;11;0;Create;True;0;0;0;False;0;False;0;0.1558506;0;0.33;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;35;-2304,-688;Inherit;True;Property;_NormalMap;NormalMap;3;0;Create;True;0;0;0;False;0;False;-1;None;e781607505ada31459bee6b20996e35e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;9;-1943.443,652.8859;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;42;-1600,-704;Inherit;False;Fresnel;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;7;-1941.122,554.3558;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;442.2642,-9.545271;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Ceil;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;12;0;5;0
WireConnection;12;1;10;0
WireConnection;40;0;36;0
WireConnection;40;2;37;0
WireConnection;40;3;38;0
WireConnection;16;1;12;0
WireConnection;14;1;11;0
WireConnection;15;1;13;0
WireConnection;18;0;17;0
WireConnection;36;0;35;0
WireConnection;3;0;1;0
WireConnection;3;1;2;0
WireConnection;25;0;24;0
WireConnection;41;0;40;0
WireConnection;41;1;39;0
WireConnection;13;0;7;0
WireConnection;13;1;10;0
WireConnection;17;0;16;0
WireConnection;17;1;15;0
WireConnection;17;2;14;0
WireConnection;11;0;9;0
WireConnection;11;1;10;0
WireConnection;23;0;20;0
WireConnection;23;1;21;0
WireConnection;24;0;23;0
WireConnection;24;1;22;0
WireConnection;24;2;22;0
WireConnection;29;0;28;0
WireConnection;29;1;24;0
WireConnection;30;0;27;0
WireConnection;30;1;31;0
WireConnection;30;2;29;0
WireConnection;26;0;30;0
WireConnection;9;0;7;0
WireConnection;9;1;8;0
WireConnection;42;0;41;0
WireConnection;7;0;5;0
WireConnection;7;1;6;0
WireConnection;0;0;3;0
ASEEND*/
//CHKSM=2E4E2A5E02CC91FF8CB989A75AEDD04CAC732A8D