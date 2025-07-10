// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "MovingPlatform"
{
	Properties
	{
		_FallOff("FallOff", Float) = 0
		_Range("Range", Float) = 0
		_PlayerPos("PlayerPos", Vector) = (0,0,0,0)
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			half filler;
		};

		uniform float3 _PlayerPos;
		uniform float _Range;
		uniform float _FallOff;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float4 transform4 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float lerpResult13 = lerp( 0.0 , -15.0 , saturate( pow( ( distance( (_PlayerPos).xz , (transform4).xz ) / _Range ) , _FallOff ) ));
			v.vertex.xyz += ( lerpResult13 * float3(0,1,0) );
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 color9 = IsGammaSpace() ? float4(0.4156863,0,1,0) : float4(0.1441285,0,1,0);
			o.Albedo = color9.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
0;386.4;1147;383.6;1993.016;170.6359;2.214854;True;False
Node;AmplifyShaderEditor.Vector3Node;1;-1888.567,127.5884;Inherit;False;Property;_PlayerPos;PlayerPos;2;0;Create;True;0;0;0;False;0;False;0,0,0;58.56277,2.219783,202.1153;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;4;-1871.609,348.7479;Inherit;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;10;-1634.209,195.6411;Inherit;False;True;False;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode;11;-1631.236,336.8738;Inherit;False;True;False;True;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DistanceOpNode;2;-1356.396,257.4414;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-1324.395,395.0411;Inherit;False;Property;_Range;Range;1;0;Create;True;0;0;0;False;0;False;0;24.7;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;6;-1105.195,264.6413;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-1077.195,414.2411;Inherit;False;Property;_FallOff;FallOff;0;0;Create;True;0;0;0;False;0;False;0;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;7;-926.7944,272.6413;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;12;-743.6982,298.2206;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;13;-599.4922,188.2078;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;-15;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;14;-533.146,390.1132;Inherit;False;Constant;_Vector0;Vector 0;3;0;Create;True;0;0;0;False;0;False;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-336.4563,264.5162;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;9;-708.5741,-73.59737;Inherit;False;Constant;_Color0;Color 0;3;0;Create;True;0;0;0;False;0;False;0.4156863,0,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;MovingPlatform;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;10;0;1;0
WireConnection;11;0;4;0
WireConnection;2;0;10;0
WireConnection;2;1;11;0
WireConnection;6;0;2;0
WireConnection;6;1;5;0
WireConnection;7;0;6;0
WireConnection;7;1;8;0
WireConnection;12;0;7;0
WireConnection;13;2;12;0
WireConnection;15;0;13;0
WireConnection;15;1;14;0
WireConnection;0;0;9;0
WireConnection;0;11;15;0
ASEEND*/
//CHKSM=CC42B8C02B5E24C610DC16371A6210ED1D0D2FD9