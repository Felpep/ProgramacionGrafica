// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Burning"
{
	Properties
	{
		_Texture0("Texture 0", 2D) = "white" {}
		_Texture1("Texture 1", 2D) = "white" {}
		_Float0("Float 0", Range( 0 , 1)) = 0
		_Speed("Speed", Range( 0 , 1)) = 0
		_Float2("Float 2", Float) = 0
		_Burn("Burn", Range( 0 , 1.1)) = 0
		_TextureSample3("Texture Sample 3", 2D) = "white" {}
		_DivideAmount("DivideAmount", Float) = 0
		_HeatWave("HeatWave", Range( 0 , 1)) = 0
		_WigglePower("WigglePower", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		AlphaToMask On
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
		};

		uniform sampler2D _Texture1;
		uniform float _Speed;
		uniform sampler2D _Texture0;
		uniform float _HeatWave;
		uniform float _Burn;
		uniform float _WigglePower;
		uniform sampler2D _TextureSample3;
		uniform float4 _TextureSample3_ST;
		uniform float4 _Texture1_ST;
		uniform float _Float0;
		uniform float _Float2;
		uniform float _DivideAmount;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float temp_output_16_0 = ( _Time.y * _Speed );
			float2 panner35 = ( temp_output_16_0 * float2( 0,1 ) + v.texcoord.xy);
			float3 tex2DNode34 = UnpackNormal( tex2Dlod( _Texture1, float4( panner35, 0, 0.0) ) );
			float3 NormalFlow69 = tex2DNode34;
			float2 TextureFlow55 = ( ( (tex2DNode34).xy * _HeatWave ) + v.texcoord.xy );
			float TextureRed58 = tex2Dlod( _Texture0, float4( TextureFlow55, 0, 0.0) ).r;
			float temp_output_25_0 = step( TextureRed58 , _Burn );
			float Step79 = temp_output_25_0;
			float3 VertexOffset77 = ( ( ( ase_worldPos * ase_vertex3Pos ) * NormalFlow69 * Step79 ) * _WigglePower );
			v.vertex.xyz += VertexOffset77;
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TextureSample3 = i.uv_texcoord * _TextureSample3_ST.xy + _TextureSample3_ST.zw;
			float4 Albedo64 = tex2D( _TextureSample3, uv_TextureSample3 );
			float4 color68 = IsGammaSpace() ? float4(0.6037736,0.2711865,0,0) : float4(0.3229691,0.05977401,0,0);
			o.Albedo = ( Albedo64 * color68 ).rgb;
			float4 color18 = IsGammaSpace() ? float4(0.8588235,0.6082754,0,0) : float4(0.7083758,0.3282914,0,0);
			float4 color19 = IsGammaSpace() ? float4(0.2641509,0,0,0) : float4(0.05672633,0,0,0);
			float2 uv_Texture1 = i.uv_texcoord * _Texture1_ST.xy + _Texture1_ST.zw;
			float temp_output_16_0 = ( _Time.y * _Speed );
			float2 panner13 = ( temp_output_16_0 * float2( 0,-1 ) + float2( 0,0 ));
			float2 uv_TexCoord12 = i.uv_texcoord + panner13;
			float2 BurnFlow53 = ( ( (UnpackNormal( tex2D( _Texture1, uv_Texture1 ) )).xy * _Float0 ) + uv_TexCoord12 );
			float4 lerpResult20 = lerp( color18 , color19 , tex2D( _Texture0, BurnFlow53 ));
			float4 temp_cast_1 = (_Float2).xxxx;
			float4 ColorFlow62 = ( pow( lerpResult20 , temp_cast_1 ) * _Float2 );
			float2 panner35 = ( temp_output_16_0 * float2( 0,1 ) + i.uv_texcoord);
			float3 tex2DNode34 = UnpackNormal( tex2D( _Texture1, panner35 ) );
			float2 TextureFlow55 = ( ( (tex2DNode34).xy * _HeatWave ) + i.uv_texcoord );
			float TextureRed58 = tex2D( _Texture0, TextureFlow55 ).r;
			float temp_output_25_0 = step( TextureRed58 , _Burn );
			float temp_output_29_0 = ( _Burn / _DivideAmount );
			float temp_output_44_0 = step( TextureRed58 , ( 1.0 - temp_output_29_0 ) );
			float temp_output_47_0 = ( temp_output_44_0 - step( TextureRed58 , ( 1.0 - _Burn ) ) );
			float4 temp_cast_2 = (temp_output_47_0).xxxx;
			float4 temp_cast_3 = (temp_output_47_0).xxxx;
			float4 Emission82 = ( ( ( ColorFlow62 * ( temp_output_25_0 + ( temp_output_25_0 - step( TextureRed58 , temp_output_29_0 ) ) ) ) - temp_cast_2 ) - temp_cast_3 );
			o.Emission = Emission82.rgb;
			float Opacity84 = temp_output_44_0;
			o.Alpha = Opacity84;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			AlphaToMask Off
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
0;453;1020;221;-178.5894;-1352.774;1.570216;True;False
Node;AmplifyShaderEditor.CommentaryNode;57;-3020.861,-35.38849;Inherit;False;1894.19;926.48;Comment;23;15;17;6;7;13;8;10;9;12;11;53;14;36;16;35;34;37;39;41;38;40;55;69;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-2970.861,638.6116;Inherit;False;Property;_Speed;Speed;5;0;Create;True;0;0;0;False;0;False;0;0.11;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;15;-2874.861,574.6115;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-2698.861,574.6115;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;36;-2506.861,558.6115;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;35;-2282.861,558.6115;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;6;-2730.861,14.61149;Inherit;True;Property;_Texture1;Texture 1;2;0;Create;True;0;0;0;False;0;False;None;ec135754276666d429959130a174f673;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SamplerNode;34;-2074.861,542.6115;Inherit;True;Property;_TextureSample4;Texture Sample 4;10;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;7;-2730.861,206.6115;Inherit;True;Property;_TextureSample1;Texture Sample 1;3;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;13;-2506.861,398.6115;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,-1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode;8;-2378.861,206.6115;Inherit;False;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-2442.861,302.6115;Inherit;False;Property;_Float0;Float 0;3;0;Create;True;0;0;0;False;0;False;0;0.69;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;37;-1770.861,542.6115;Inherit;False;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;39;-1754.861,638.6116;Inherit;False;Property;_HeatWave;HeatWave;10;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;-1546.861,542.6115;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-2325.666,400.2419;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-2170.861,254.6115;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;41;-1642.861,734.6116;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;40;-1354.861,542.6115;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;11;-1994.861,302.6115;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;55;-1354.861,638.6116;Inherit;False;TextureFlow;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;53;-1994.861,398.6115;Inherit;False;BurnFlow;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;87;-1008,-64;Inherit;False;1496.814;934.9449;Comment;13;56;5;54;19;18;24;2;58;23;20;21;22;62;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;54;-944,464;Inherit;False;53;BurnFlow;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;56;-624,656;Inherit;False;55;TextureFlow;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;5;-720,160;Inherit;True;Property;_Texture0;Texture 0;1;0;Create;True;0;0;0;False;0;False;None;ec135754276666d429959130a174f673;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.ColorNode;18;-512,-16;Inherit;False;Constant;_Color0;Color 0;6;0;Create;True;0;0;0;False;0;False;0.8588235,0.6082754,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-720,352;Inherit;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;86;-3184,1616;Inherit;False;2047.463;751.6002;Comment;23;26;30;29;59;25;31;43;42;61;32;33;44;45;79;63;47;27;48;50;84;82;52;51;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;24;-400,560;Inherit;True;Property;_TextureSample2;Texture Sample 2;8;0;Create;True;0;0;0;False;0;False;-1;None;ec135754276666d429959130a174f673;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;19;-704,-16;Inherit;False;Constant;_Color1;Color 1;6;0;Create;True;0;0;0;False;0;False;0.2641509,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;23;96,432;Inherit;False;Property;_Float2;Float 2;6;0;Create;True;0;0;0;False;0;False;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-3024,2096;Inherit;False;Property;_DivideAmount;DivideAmount;9;0;Create;True;0;0;0;False;0;False;0;1.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;58;-304,752;Inherit;False;TextureRed;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-3136,1952;Inherit;False;Property;_Burn;Burn;7;0;Create;True;0;0;0;False;0;False;0;0;0;1.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;20;-224,304;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;59;-3040,1840;Inherit;False;58;TextureRed;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;21;96,320;Inherit;False;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;29;-2752,1968;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;256,320;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;31;-2496,1904;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;25;-2496,1792;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;81;-2128,960;Inherit;False;1004.702;556.1935;Comment;9;71;70;74;72;80;73;76;75;77;;1,1,1,1;0;0
Node;AmplifyShaderEditor.OneMinusNode;42;-2480,2192;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;32;-2320,1872;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;61;-2496,2048;Inherit;False;58;TextureRed;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;43;-2480,2256;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;62;272,544;Inherit;False;ColorFlow;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;33;-2112,1792;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;79;-2496,1712;Inherit;False;Step;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;71;-2080,1152;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;69;-1983.679,735.517;Inherit;False;NormalFlow;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;63;-2304,1664;Inherit;False;62;ColorFlow;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;45;-2192,2176;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;70;-2080,1008;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.StepOpNode;44;-2192,2064;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;80;-2049.3,1396.8;Inherit;False;79;Step;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;47;-1952,2016;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;65;-1024,976;Inherit;False;370.8494;357.9362;Comment;2;28;64;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;72;-1872,1088;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-1984,1680;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;74;-2064,1312;Inherit;False;69;NormalFlow;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;48;-1696,1840;Inherit;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;76;-1664,1392;Inherit;False;Property;_WigglePower;WigglePower;12;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;28;-976,1024;Inherit;True;Property;_TextureSample3;Texture Sample 3;8;0;Create;True;0;0;0;False;0;False;-1;None;9905734fd9f2fa946aa941b41f1db9b4;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;-1632,1280;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;64;-880,1216;Inherit;False;Albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;75;-1488,1344;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;50;-1536,1840;Inherit;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;66;848,1360;Inherit;False;64;Albedo;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;82;-1360,1824;Inherit;False;Emission;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;68;816,1440;Inherit;False;Constant;_Color2;Color 2;12;0;Create;True;0;0;0;False;0;False;0.6037736,0.2711865,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;84;-1968,2160;Inherit;False;Opacity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;77;-1360,1344;Inherit;False;VertexOffset;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;78;1328,1856;Inherit;False;77;VertexOffset;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;52;-2816,2144;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;83;1344,1696;Inherit;False;82;Emission;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;14;-2698.861,414.6115;Inherit;False;Property;_Vector0;Vector 0;4;0;Create;True;0;0;0;False;0;False;0,0;0,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;67;1136,1456;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;85;1344,1776;Inherit;False;84;Opacity;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;51;-3040,2192;Inherit;False;Property;_DissolveAmount;DissolveAmount;11;0;Create;True;0;0;0;False;0;False;0;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1568,1504;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Burning;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Transparent;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;True;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;16;0;15;0
WireConnection;16;1;17;0
WireConnection;35;0;36;0
WireConnection;35;1;16;0
WireConnection;34;0;6;0
WireConnection;34;1;35;0
WireConnection;7;0;6;0
WireConnection;13;1;16;0
WireConnection;8;0;7;0
WireConnection;37;0;34;0
WireConnection;38;0;37;0
WireConnection;38;1;39;0
WireConnection;12;1;13;0
WireConnection;9;0;8;0
WireConnection;9;1;10;0
WireConnection;40;0;38;0
WireConnection;40;1;41;0
WireConnection;11;0;9;0
WireConnection;11;1;12;0
WireConnection;55;0;40;0
WireConnection;53;0;11;0
WireConnection;2;0;5;0
WireConnection;2;1;54;0
WireConnection;24;0;5;0
WireConnection;24;1;56;0
WireConnection;58;0;24;1
WireConnection;20;0;18;0
WireConnection;20;1;19;0
WireConnection;20;2;2;0
WireConnection;21;0;20;0
WireConnection;21;1;23;0
WireConnection;29;0;26;0
WireConnection;29;1;30;0
WireConnection;22;0;21;0
WireConnection;22;1;23;0
WireConnection;31;0;59;0
WireConnection;31;1;29;0
WireConnection;25;0;59;0
WireConnection;25;1;26;0
WireConnection;42;0;29;0
WireConnection;32;0;25;0
WireConnection;32;1;31;0
WireConnection;43;0;26;0
WireConnection;62;0;22;0
WireConnection;33;0;25;0
WireConnection;33;1;32;0
WireConnection;79;0;25;0
WireConnection;69;0;34;0
WireConnection;45;0;61;0
WireConnection;45;1;43;0
WireConnection;44;0;61;0
WireConnection;44;1;42;0
WireConnection;47;0;44;0
WireConnection;47;1;45;0
WireConnection;72;0;70;0
WireConnection;72;1;71;0
WireConnection;27;0;63;0
WireConnection;27;1;33;0
WireConnection;48;0;27;0
WireConnection;48;1;47;0
WireConnection;73;0;72;0
WireConnection;73;1;74;0
WireConnection;73;2;80;0
WireConnection;64;0;28;0
WireConnection;75;0;73;0
WireConnection;75;1;76;0
WireConnection;50;0;48;0
WireConnection;50;1;47;0
WireConnection;82;0;50;0
WireConnection;84;0;44;0
WireConnection;77;0;75;0
WireConnection;52;0;30;0
WireConnection;52;1;51;0
WireConnection;67;0;66;0
WireConnection;67;1;68;0
WireConnection;0;0;67;0
WireConnection;0;2;83;0
WireConnection;0;9;85;0
WireConnection;0;11;78;0
ASEEND*/
//CHKSM=C2622988A7DD09ABAEE653494B60932E8FA440AE