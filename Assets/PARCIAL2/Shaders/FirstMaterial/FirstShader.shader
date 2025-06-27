// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "FirstShader"
{
	Properties
	{
		_tri1("tri1", 2D) = "white" {}
		_tri21("tri21", 2D) = "white" {}
		_rei22("rei22", 2D) = "white" {}
		_tri11("tri11", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _tri1;
		uniform float4 _tri1_ST;
		uniform sampler2D _tri21;
		uniform float4 _tri21_ST;
		uniform sampler2D _rei22;
		uniform float4 _rei22_ST;
		uniform sampler2D _tri11;
		uniform float4 _tri11_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_tri1 = i.uv_texcoord * _tri1_ST.xy + _tri1_ST.zw;
			float4 color68 = IsGammaSpace() ? float4(0.01351202,1,0,0) : float4(0.001045822,1,0,0);
			float2 uv_tri21 = i.uv_texcoord * _tri21_ST.xy + _tri21_ST.zw;
			float4 color67 = IsGammaSpace() ? float4(0.01351202,1,0,0) : float4(0.001045822,1,0,0);
			float2 uv_rei22 = i.uv_texcoord * _rei22_ST.xy + _rei22_ST.zw;
			float4 color71 = IsGammaSpace() ? float4(0,0.1509135,1,0) : float4(0,0.01981699,1,0);
			float4 color73 = IsGammaSpace() ? float4(0,0.1086202,1,0) : float4(0,0.01141308,1,0);
			float2 uv_tri11 = i.uv_texcoord * _tri11_ST.xy + _tri11_ST.zw;
			o.Albedo = ( saturate( ( ( tex2D( _tri1, uv_tri1 ) * color68 ) - ( tex2D( _tri21, uv_tri21 ) * color67 ) ) ) + saturate( ( ( tex2D( _rei22, uv_rei22 ) * color71 ) - ( color73 * tex2D( _tri11, uv_tri11 ) ) ) ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
0;450.4;1221.4;319.6;1080.785;25.7571;1.137762;True;False
Node;AmplifyShaderEditor.ColorNode;68;-63.95321,-305.9895;Inherit;False;Constant;_Color3;Color 2;10;0;Create;True;0;0;0;False;0;False;0.01351202,1,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;63;-127.1823,114.3402;Inherit;True;Property;_tri21;tri21;7;0;Create;True;0;0;0;False;0;False;-1;a0b86a46bc69c7446b89409f605bfe04;a0b86a46bc69c7446b89409f605bfe04;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;62;-141.4511,-96.83784;Inherit;True;Property;_tri1;tri1;6;0;Create;True;0;0;0;False;0;False;-1;2bf69ce23ea2a8d4b8e80308d0a941bd;2bf69ce23ea2a8d4b8e80308d0a941bd;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;65;-113.6703,770.08;Inherit;True;Property;_tri11;tri11;9;0;Create;True;0;0;0;False;0;False;-1;2bf69ce23ea2a8d4b8e80308d0a941bd;2bf69ce23ea2a8d4b8e80308d0a941bd;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;64;-105.1564,972.6494;Inherit;True;Property;_rei22;rei22;8;0;Create;True;0;0;0;False;0;False;-1;a0b86a46bc69c7446b89409f605bfe04;a0b86a46bc69c7446b89409f605bfe04;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;67;-75.81503,314.1035;Inherit;False;Constant;_Color2;Color 2;10;0;Create;True;0;0;0;False;0;False;0.01351202,1,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;71;68.33575,1267.091;Inherit;False;Constant;_Color4;Color 4;10;0;Create;True;0;0;0;False;0;False;0,0.1509135,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;73;-65.0435,565.3811;Inherit;False;Constant;_Color5;Color 4;10;0;Create;True;0;0;0;False;0;False;0,0.1086202,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;74;282.4778,800.3246;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;289.4662,171.4156;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;72;305.7271,1029.7;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;69;289.0913,-27.73593;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;75;515.1975,885.1871;Inherit;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;70;521.0931,85.02911;Inherit;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;77;853.7501,381.9291;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;52;-1848.856,663.6417;Inherit;False;1395.651;1010.175;Respuesta4;9;46;45;1;11;43;47;50;49;51;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;10;-662.6079,-211.7458;Inherit;False;216.87;160.16;Clampea solo entre 0 y 1;1;9;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;23;-1754.337,248.642;Inherit;False;317.2693;191.7672;Respuesta2;2;22;21;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;6;-762.9404,-608.5696;Inherit;False;583.08;174.52;Basic Operations;4;5;4;3;2;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;26;-1739.355,470.7797;Inherit;False;213.48;183.32;Respuesta3;1;25;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;8;-694.1404,-423.77;Inherit;False;324.7399;182.48;Limitar valores entre un max y un min;1;7;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;14;-1769.411,1.1624;Inherit;False;347.2799;178.0884;Respuesta1;2;13;12;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;61;-1818.074,1748.638;Inherit;False;1045.88;893.0886;Respuesta5;7;55;53;54;57;56;59;60;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode;78;753.6525,756.798;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;60;-1007.343,2186.008;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;51;-688.3566,1129.01;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;22;-1577.908,298.642;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;76;948.9222,469.8627;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;9;-612.6079,-161.7458;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;49;-966.7123,1197.118;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;12;-1758.258,58.00508;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;4;-456.9404,-555.3699;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;-1283.668,2002.653;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;45;-1798.857,1443.817;Inherit;True;Property;_TextureSample2;Texture Sample 1;5;0;Create;True;0;0;0;False;0;False;-1;a0b86a46bc69c7446b89409f605bfe04;a0b86a46bc69c7446b89409f605bfe04;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;79;-723.8883,159.9048;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;80;-744.9891,311.4483;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;81;-674.0134,-3.148214;Inherit;False;Property;_Float0;Float 0;10;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;59;-1355.978,2266.064;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;1;-1604.152,713.6418;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;2bf69ce23ea2a8d4b8e80308d0a941bd;2bf69ce23ea2a8d4b8e80308d0a941bd;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;47;-1242.939,1237.763;Inherit;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;53;-1635.013,1980.833;Inherit;True;Property;_TextureSample4;Texture Sample 0;1;0;Create;True;0;0;0;False;0;False;-1;2bf69ce23ea2a8d4b8e80308d0a941bd;2bf69ce23ea2a8d4b8e80308d0a941bd;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;7;-644.1404,-373.77;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;-1689.355,520.7797;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;13;-1555.508,64.90131;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2;-749.6877,-551.425;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;50;-948.9448,998.7158;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;82;-456.3809,80.7374;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ColorNode;57;-1580.653,2433.925;Inherit;False;Constant;_Color1;Color 0;6;0;Create;True;0;0;0;False;0;False;0,0.1058824,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;11;-1737.213,944.7684;Inherit;True;Property;_TextureSample1;Texture Sample 1;3;0;Create;True;0;0;0;False;0;False;-1;a0b86a46bc69c7446b89409f605bfe04;a0b86a46bc69c7446b89409f605bfe04;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;54;-1768.074,2211.959;Inherit;True;Property;_TextureSample5;Texture Sample 1;4;0;Create;True;0;0;0;False;0;False;-1;a0b86a46bc69c7446b89409f605bfe04;a0b86a46bc69c7446b89409f605bfe04;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-332.1404,-555.3699;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;46;-1665.796,1212.69;Inherit;True;Property;_TextureSample3;Texture Sample 0;2;0;Create;True;0;0;0;False;0;False;-1;2bf69ce23ea2a8d4b8e80308d0a941bd;2bf69ce23ea2a8d4b8e80308d0a941bd;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;3;-608.9404,-552.9698;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;43;-1222.753,883.8143;Inherit;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;55;-1487.684,1798.638;Inherit;False;Constant;_Color0;Color 0;6;0;Create;True;0;0;0;False;0;False;1,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;21;-1744.448,296.1314;Inherit;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;83;-257.0452,79.82719;Inherit;False;FLOAT;1;0;FLOAT;0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1413.542,360.0123;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;FirstShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;74;0;73;0
WireConnection;74;1;65;0
WireConnection;66;0;63;0
WireConnection;66;1;67;0
WireConnection;72;0;64;0
WireConnection;72;1;71;0
WireConnection;69;0;62;0
WireConnection;69;1;68;0
WireConnection;75;0;72;0
WireConnection;75;1;74;0
WireConnection;70;0;69;0
WireConnection;70;1;66;0
WireConnection;77;0;70;0
WireConnection;78;0;75;0
WireConnection;60;0;56;0
WireConnection;60;1;59;0
WireConnection;51;0;50;0
WireConnection;51;1;49;0
WireConnection;76;0;77;0
WireConnection;76;1;78;0
WireConnection;49;0;47;0
WireConnection;56;0;55;0
WireConnection;56;1;53;0
WireConnection;59;0;54;0
WireConnection;59;1;57;0
WireConnection;47;0;45;0
WireConnection;47;1;46;0
WireConnection;50;0;43;0
WireConnection;43;0;1;0
WireConnection;43;1;11;0
WireConnection;0;0;76;0
ASEEND*/
//CHKSM=1F898248DBB1BA63494D7C3CEC0238D1DBE60286