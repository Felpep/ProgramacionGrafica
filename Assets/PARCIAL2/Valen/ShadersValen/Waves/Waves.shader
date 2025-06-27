// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Waves"
{
	Properties
	{
		_EdgeLength ( "Edge length", Range( 2, 50 ) ) = 15
		_Steepness("Steepness", Range( 0 , 1)) = 0
		_NumOfWaves("Num Of Waves", Float) = 0
		_HighColor("HighColor", Color) = (0.2295745,0.4276968,0.6320754,0)
		_Range("Range", Float) = 1
		_DepthFadeColor("DepthFadeColor", Color) = (0.8867924,0.8148451,0.8148451,0)
		_Power("Power", Float) = 0
		_LowColor("LowColor", Color) = (0.4198113,0.7986241,1,0)
		_Amplitude("Amplitude", Float) = 0
		_HeightOffset("HeightOffset", Float) = 0
		_HeightDiference("HeightDiference", Float) = 1
		_WaveLenght("WaveLenght", Float) = 0
		_Speed("Speed", Float) = 0
		_Dir1("Dir1", Vector) = (0,0,0,0)
		_Smoothness("Smoothness", Range( 0 , 1)) = 0
		_FakeNormalIntensity("FakeNormalIntensity", Range( 0 , 1)) = 0
		[Normal]_BigNormalTex("BigNormalTex", 2D) = "bump" {}
		_Float1("Float 1", Range( 0 , 1)) = 0
		_Dir2("Dir2", Vector) = (0,0,0,0)
		_BigNormalTiling("BigNormalTiling", Float) = 0
		_SmallNormalTiling("SmallNormalTiling", Float) = 0
		[Normal]_SmallNormalTex("SmallNormalTex", 2D) = "bump" {}
		_OpacityDepthRange("OpacityDepthRange", Float) = 1
		_SmallNormalSpeed("SmallNormalSpeed", Vector) = (0,0,0,0)
		_OpacityDepthFallOff("OpacityDepthFallOff", Float) = 1
		_HeightDepthRange("HeightDepthRange", Float) = 1
		_OpacityMultiplier("OpacityMultiplier", Range( 0 , 1)) = 0
		_HeightDepthOffset("HeightDepthOffset", Float) = 1
		_Metallic("Metallic", Range( 0 , 1)) = 0
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_FresnelScale("FresnelScale", Float) = 0
		_FresnelPower("FresnelPower", Float) = 0
		_Vector1("Vector 1", Vector) = (0,0,0,0)
		_BigNormalSpeed("BigNormalSpeed", Vector) = (0,0,0,0)
		_Vector0("Vector 0", Vector) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "Tessellation.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 4.6
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
			float3 worldNormal;
			INTERNAL_DATA
			float4 screenPos;
		};

		uniform float _WaveLenght;
		uniform float _Speed;
		uniform float3 _Dir1;
		uniform float _Steepness;
		uniform float _Amplitude;
		uniform float _NumOfWaves;
		uniform float3 _Dir2;
		uniform float3 _Vector1;
		uniform float3 _Vector0;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _HeightDepthRange;
		uniform float _HeightDepthOffset;
		uniform float _FakeNormalIntensity;
		uniform sampler2D _BigNormalTex;
		uniform float2 _BigNormalSpeed;
		uniform float _BigNormalTiling;
		uniform sampler2D _SmallNormalTex;
		uniform float2 _SmallNormalSpeed;
		uniform float _SmallNormalTiling;
		uniform float _Float1;
		uniform float4 _DepthFadeColor;
		uniform float4 _HighColor;
		uniform float4 _LowColor;
		uniform float _HeightOffset;
		uniform float _HeightDiference;
		uniform sampler2D _TextureSample0;
		uniform float _FresnelScale;
		uniform float _FresnelPower;
		uniform float _Range;
		uniform float _Power;
		uniform float _Metallic;
		uniform float _Smoothness;
		uniform float _OpacityDepthRange;
		uniform float _OpacityDepthFallOff;
		uniform float _OpacityMultiplier;
		uniform float _EdgeLength;

		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			return UnityEdgeLengthBasedTess (v0.vertex, v1.vertex, v2.vertex, _EdgeLength);
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float WaveLenght34 = _WaveLenght;
			float temp_output_25_0_g10 = WaveLenght34;
			float Speed43 = _Speed;
			float w38_g10 = sqrt( ( ( 6.28318548202515 / temp_output_25_0_g10 ) * 9.8 ) );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 temp_output_26_0_g10 = _Dir1;
			float dotResult18_g10 = dot( ase_worldPos , temp_output_26_0_g10 );
			float temp_output_21_0_g10 = ( ( ( ( 2.0 / temp_output_25_0_g10 ) * Speed43 ) * _Time.y ) + ( w38_g10 * dotResult18_g10 ) );
			float temp_output_23_0_g10 = cos( temp_output_21_0_g10 );
			float3 break33_g10 = temp_output_26_0_g10;
			float Steepness40 = _Steepness;
			float Amplitude32 = _Amplitude;
			float temp_output_28_0_g10 = Amplitude32;
			float NumOfWaves41 = _NumOfWaves;
			float temp_output_43_0_g10 = ( ( Steepness40 / ( w38_g10 * temp_output_28_0_g10 * NumOfWaves41 ) ) * temp_output_28_0_g10 );
			float3 appendResult24_g10 = (float3(( temp_output_23_0_g10 * break33_g10.x * temp_output_43_0_g10 ) , ( sin( temp_output_21_0_g10 ) * temp_output_28_0_g10 ) , ( temp_output_23_0_g10 * break33_g10.z * temp_output_43_0_g10 )));
			float temp_output_25_0_g9 = WaveLenght34;
			float w38_g9 = sqrt( ( ( 6.28318548202515 / temp_output_25_0_g9 ) * 9.8 ) );
			float3 temp_output_26_0_g9 = _Dir2;
			float dotResult18_g9 = dot( ase_worldPos , temp_output_26_0_g9 );
			float temp_output_21_0_g9 = ( ( ( ( 2.0 / temp_output_25_0_g9 ) * Speed43 ) * _Time.y ) + ( w38_g9 * dotResult18_g9 ) );
			float temp_output_23_0_g9 = cos( temp_output_21_0_g9 );
			float3 break33_g9 = temp_output_26_0_g9;
			float temp_output_28_0_g9 = Amplitude32;
			float temp_output_43_0_g9 = ( ( Steepness40 / ( w38_g9 * temp_output_28_0_g9 * NumOfWaves41 ) ) * temp_output_28_0_g9 );
			float3 appendResult24_g9 = (float3(( temp_output_23_0_g9 * break33_g9.x * temp_output_43_0_g9 ) , ( sin( temp_output_21_0_g9 ) * temp_output_28_0_g9 ) , ( temp_output_23_0_g9 * break33_g9.z * temp_output_43_0_g9 )));
			float temp_output_25_0_g12 = ( WaveLenght34 * 3.0 );
			float w38_g12 = sqrt( ( ( 6.28318548202515 / temp_output_25_0_g12 ) * 9.8 ) );
			float3 temp_output_26_0_g12 = _Vector1;
			float dotResult18_g12 = dot( ase_worldPos , temp_output_26_0_g12 );
			float temp_output_21_0_g12 = ( ( ( ( 2.0 / temp_output_25_0_g12 ) * Speed43 ) * _Time.y ) + ( w38_g12 * dotResult18_g12 ) );
			float temp_output_23_0_g12 = cos( temp_output_21_0_g12 );
			float3 break33_g12 = temp_output_26_0_g12;
			float temp_output_28_0_g12 = Amplitude32;
			float temp_output_43_0_g12 = ( ( Steepness40 / ( w38_g12 * temp_output_28_0_g12 * NumOfWaves41 ) ) * temp_output_28_0_g12 );
			float3 appendResult24_g12 = (float3(( temp_output_23_0_g12 * break33_g12.x * temp_output_43_0_g12 ) , ( sin( temp_output_21_0_g12 ) * temp_output_28_0_g12 ) , ( temp_output_23_0_g12 * break33_g12.z * temp_output_43_0_g12 )));
			float temp_output_25_0_g11 = ( WaveLenght34 * 0.5 );
			float w38_g11 = sqrt( ( ( 6.28318548202515 / temp_output_25_0_g11 ) * 9.8 ) );
			float3 temp_output_26_0_g11 = _Vector0;
			float dotResult18_g11 = dot( ase_worldPos , temp_output_26_0_g11 );
			float temp_output_21_0_g11 = ( ( ( ( 2.0 / temp_output_25_0_g11 ) * Speed43 ) * _Time.y ) + ( w38_g11 * dotResult18_g11 ) );
			float temp_output_23_0_g11 = cos( temp_output_21_0_g11 );
			float3 break33_g11 = temp_output_26_0_g11;
			float temp_output_28_0_g11 = ( Amplitude32 * 0.5 );
			float temp_output_43_0_g11 = ( ( Steepness40 / ( w38_g11 * temp_output_28_0_g11 * NumOfWaves41 ) ) * temp_output_28_0_g11 );
			float3 appendResult24_g11 = (float3(( temp_output_23_0_g11 * break33_g11.x * temp_output_43_0_g11 ) , ( sin( temp_output_21_0_g11 ) * temp_output_28_0_g11 ) , ( temp_output_23_0_g11 * break33_g11.z * temp_output_43_0_g11 )));
			float3 GerrstnerWaves101 = ( appendResult24_g10 + appendResult24_g9 + appendResult24_g12 + appendResult24_g11 );
			float4 ase_screenPos = ComputeScreenPos( UnityObjectToClipPos( v.vertex ) );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth47 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE_LOD( _CameraDepthTexture, float4( ase_screenPosNorm.xy, 0, 0 ) ));
			float distanceDepth47 = abs( ( screenDepth47 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( 1.0 ) );
			float HeightDepth113 = saturate( pow( ( distanceDepth47 / _HeightDepthRange ) , _HeightDepthOffset ) );
			v.vertex.xyz += ( GerrstnerWaves101 * HeightDepth113 );
			v.vertex.w = 1;
			float3 ase_vertexNormal = v.normal.xyz;
			float3 lerpResult115 = lerp( ase_vertexNormal , GerrstnerWaves101 , _FakeNormalIntensity);
			float3 WavesNormal116 = lerpResult115;
			v.normal = WavesNormal116;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 temp_cast_0 = (_BigNormalTiling).xx;
			float2 uv_TexCoord18 = i.uv_texcoord * temp_cast_0;
			float2 panner23 = ( 1.0 * _Time.y * _BigNormalSpeed + uv_TexCoord18);
			float3 tex2DNode25 = UnpackNormal( tex2D( _BigNormalTex, panner23 ) );
			float2 temp_cast_1 = (_SmallNormalTiling).xx;
			float2 uv_TexCoord17 = i.uv_texcoord * temp_cast_1;
			float2 panner22 = ( 1.0 * _Time.y * _SmallNormalSpeed + uv_TexCoord17);
			float3 tex2DNode26 = UnpackNormal( tex2D( _SmallNormalTex, panner22 ) );
			float3 appendResult42 = (float3(( tex2DNode25.r + tex2DNode26.r ) , ( tex2DNode25.g + tex2DNode26.g ) , ( ( tex2DNode25.b * tex2DNode26.b ) - _Float1 )));
			float3 TextureNormals50 = appendResult42;
			o.Normal = TextureNormals50;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float4 lerpResult111 = lerp( _HighColor , _LowColor , saturate( ( ( ase_vertex3Pos.y + _HeightOffset ) / _HeightDiference ) ));
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 newWorldNormal86 = (WorldNormalVector( i , TextureNormals50 ));
			float fresnelNdotV100 = dot( newWorldNormal86, ase_worldViewDir );
			float fresnelNode100 = ( 0.0 + _FresnelScale * pow( 1.0 - fresnelNdotV100, _FresnelPower ) );
			float4 lerpResult114 = lerp( lerpResult111 , tex2D( _TextureSample0, reflect( -ase_worldViewDir , newWorldNormal86 ).xy ) , saturate( fresnelNode100 ));
			float4 HeightColor120 = lerpResult114;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth140 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth140 = abs( ( screenDepth140 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( 1.0 ) );
			float4 lerpResult145 = lerp( _DepthFadeColor , HeightColor120 , saturate( pow( ( distanceDepth140 / _Range ) , _Power ) ));
			o.Albedo = lerpResult145.rgb;
			o.Metallic = _Metallic;
			o.Smoothness = _Smoothness;
			float screenDepth47 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth47 = abs( ( screenDepth47 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( 1.0 ) );
			float DepthOpacity119 = saturate( ( saturate( pow( ( distanceDepth47 / _OpacityDepthRange ) , _OpacityDepthFallOff ) ) + _OpacityMultiplier ) );
			o.Alpha = DepthOpacity119;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard alpha:fade keepalpha fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.6
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
				float4 screenPos : TEXCOORD2;
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
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
				vertexDataFunc( v );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				o.screenPos = ComputeScreenPos( o.pos );
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
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				surfIN.screenPos = IN.screenPos;
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
0;453;1020;221;3313.16;-504.1124;1.389663;False;False
Node;AmplifyShaderEditor.CommentaryNode;138;-5602.16,-239.5363;Inherit;False;1815.101;907.7493;NORMALS;20;15;18;16;23;19;24;17;22;20;21;25;26;122;31;38;29;37;28;42;50;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-5542.13,259.1118;Inherit;False;Property;_SmallNormalTiling;SmallNormalTiling;26;0;Create;True;0;0;0;False;0;False;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-5489.13,-78.88832;Inherit;False;Property;_BigNormalTiling;BigNormalTiling;25;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;18;-5489.238,-189.5363;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;19;-5266.292,-77.52638;Inherit;False;Property;_BigNormalSpeed;BigNormalSpeed;39;0;Create;True;0;0;0;False;0;False;0,0;-0.1,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;17;-5552.16,145.3553;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;20;-5296.404,260.5078;Inherit;False;Property;_SmallNormalSpeed;SmallNormalSpeed;29;0;Create;True;0;0;0;False;0;False;0,0;-0.1,0.2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.PannerNode;23;-5265.292,-188.5265;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;22;-5281.045,145.569;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;26;-4988.983,217.9004;Inherit;True;Property;_SmallNormalTex;SmallNormalTex;27;1;[Normal];Create;True;0;0;0;False;0;False;-1;None;c2b58cf0fa9a6154388ba33da184a1b8;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;25;-4988.368,-114.5066;Inherit;True;Property;_BigNormalTex;BigNormalTex;20;1;[Normal];Create;True;0;0;0;False;0;False;-1;None;f5173c0fff3a25f4e9a8d8610ce66b9d;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-4599.08,227.3747;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;130;-5595.913,-1734.602;Inherit;False;1143.399;244.1627;VARIABLES;10;41;35;32;27;34;30;36;40;43;33;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-4469.913,321.9948;Inherit;False;Property;_Float1;Float 1;23;0;Create;True;0;0;0;False;0;False;0;0.05;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;31;-4594.878,133.6394;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-4850.67,-1681.97;Inherit;False;Property;_WaveLenght;WaveLenght;15;0;Create;True;0;0;0;False;0;False;0;200;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-5042.989,-1677.327;Inherit;False;Property;_Amplitude;Amplitude;12;0;Create;True;0;0;0;False;0;False;0;0.01;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;38;-4590.9,36.56563;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;37;-4413.613,228.9951;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;42;-4221.239,26.10152;Inherit;True;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;32;-5070.339,-1605.6;Inherit;False;Amplitude;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;131;-5583.413,-1423.3;Inherit;False;1315.696;1135.291;HEIGHT;21;75;86;77;94;99;109;100;88;90;110;114;120;53;49;80;89;76;98;102;103;111;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;136;-2219.306,-173.4113;Inherit;False;790.2813;512.5734;Comment;9;81;63;61;56;55;45;66;39;60;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;135;-3067.262,-406.6607;Inherit;False;785.8982;518.3754;Comment;8;85;74;64;44;67;59;54;68;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-5267.447,-1682.159;Inherit;False;Property;_NumOfWaves;Num Of Waves;6;0;Create;True;0;0;0;False;0;False;0;3.88;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;34;-4872.8,-1606.123;Inherit;False;WaveLenght;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-5545.913,-1684.602;Inherit;False;Property;_Steepness;Steepness;5;0;Create;True;0;0;0;False;0;False;0;0.08;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-4650.896,-1681.647;Inherit;False;Property;_Speed;Speed;16;0;Create;True;0;0;0;False;0;False;0;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;45;-2156.012,48.14729;Inherit;False;32;Amplitude;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;50;-4019.651,27.09969;Inherit;False;TextureNormals;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;43;-4680.704,-1606.886;Inherit;False;Speed;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;133;-2204.885,-1282.765;Inherit;False;718.3071;529.377;Comment;7;79;52;57;71;58;69;72;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;137;-5600.7,712.3425;Inherit;False;1317.836;425.8479;DEPTH;16;47;91;78;83;48;93;82;97;104;96;112;119;95;92;105;113;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;41;-5281.455,-1606.297;Inherit;False;NumOfWaves;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;134;-2958.206,-962.0231;Inherit;False;680.3481;536.9691;Comment;7;84;65;73;51;70;62;46;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;39;-2169.306,146.5269;Inherit;False;34;WaveLenght;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;40;-5472.771,-1609.773;Inherit;False;Steepness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;53;-5516.926,-1027.051;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;44;-3017.262,-117.5118;Inherit;False;34;WaveLenght;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;49;-5501.112,-888.7947;Inherit;False;Property;_HeightOffset;HeightOffset;13;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;65;-2620.977,-609.6941;Inherit;False;Property;_Dir2;Dir2;24;0;Create;True;0;0;0;False;0;False;0,0,0;0.2,0,-1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;68;-2882.385,-356.6606;Inherit;False;40;Steepness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;70;-2885.553,-757.3688;Inherit;False;32;Amplitude;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;55;-1992.229,35.22301;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;-1989.747,129.0106;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;62;-2908.206,-833.8389;Inherit;False;41;NumOfWaves;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;54;-2896.703,-279.5828;Inherit;False;41;NumOfWaves;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;74;-2629.958,-72.92491;Inherit;False;Property;_Vector1;Vector 1;38;0;Create;True;0;0;0;False;0;False;0,0,0;0.2,0,-1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;63;-1772.083,146.3687;Inherit;False;Property;_Vector0;Vector 0;40;0;Create;True;0;0;0;False;0;False;0,0,0;0.3,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;64;-2839.353,-129.8787;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;71;-2136.028,-1076.213;Inherit;False;32;Amplitude;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;67;-2871.152,-35.17266;Inherit;False;43;Speed;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;46;-2891.022,-912.0231;Inherit;False;40;Steepness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;51;-2897.532,-682.1849;Inherit;False;34;WaveLenght;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-5303.452,1019.754;Inherit;False;Property;_OpacityDepthRange;OpacityDepthRange;28;0;Create;True;0;0;0;False;0;False;1;14.59;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;60;-2022.409,224.0022;Inherit;False;43;Speed;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;77;-5497.603,-810.1843;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;76;-5093.521,-883.1033;Inherit;False;Property;_HeightDiference;HeightDiference;14;0;Create;True;0;0;0;False;0;False;1;3.51;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;73;-2880.265,-605.6569;Inherit;False;43;Speed;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;57;-2154.885,-1154.581;Inherit;False;41;NumOfWaves;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;47;-5550.7,916.8666;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;58;-2146.11,-997.2324;Inherit;False;34;WaveLenght;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;72;-1837.293,-938.0277;Inherit;False;Property;_Dir1;Dir1;17;0;Create;True;0;0;0;False;0;False;0,0,0;0.1,0,-1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;52;-2137.702,-1232.765;Inherit;False;40;Steepness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;61;-2032.782,-123.4112;Inherit;False;40;Steepness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;80;-5317.513,-944.9796;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;69;-2130.743,-916.9086;Inherit;False;43;Speed;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;75;-5509.167,-665.3528;Inherit;False;50;TextureNormals;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;56;-2049.174,-44.22142;Inherit;False;41;NumOfWaves;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;59;-2877.229,-203.4269;Inherit;False;32;Amplitude;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;82;-5091.404,1021.691;Inherit;False;Property;_OpacityDepthFallOff;OpacityDepthFallOff;30;0;Create;True;0;0;0;False;0;False;1;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;78;-5120.965,855.5513;Inherit;False;Property;_HeightDepthRange;HeightDepthRange;31;0;Create;True;0;0;0;False;0;False;1;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;85;-2627.864,-257.1918;Inherit;False;Inner Waves Function;-1;;12;7d7672e142756fd488f82876d9ed566a;0;6;36;FLOAT;0;False;37;FLOAT;0;False;28;FLOAT;0;False;25;FLOAT;0;False;26;FLOAT3;0,0,0;False;27;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;81;-1775.525,-37.82488;Inherit;False;Inner Waves Function;-1;;11;7d7672e142756fd488f82876d9ed566a;0;6;36;FLOAT;0;False;37;FLOAT;0;False;28;FLOAT;0;False;25;FLOAT;0;False;26;FLOAT3;0,0,0;False;27;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;79;-1833.078,-1123.906;Inherit;False;Inner Waves Function;-1;;10;7d7672e142756fd488f82876d9ed566a;0;6;36;FLOAT;0;False;37;FLOAT;0;False;28;FLOAT;0;False;25;FLOAT;0;False;26;FLOAT3;0,0,0;False;27;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;84;-2624.357,-799.3688;Inherit;False;Inner Waves Function;-1;;9;7d7672e142756fd488f82876d9ed566a;0;6;36;FLOAT;0;False;37;FLOAT;0;False;28;FLOAT;0;False;25;FLOAT;0;False;26;FLOAT3;0,0,0;False;27;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;90;-4897.422,-403.1706;Inherit;False;Property;_FresnelPower;FresnelPower;37;0;Create;True;0;0;0;False;0;False;0;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;88;-4893.288,-475.6191;Inherit;False;Property;_FresnelScale;FresnelScale;36;0;Create;True;0;0;0;False;0;False;0;8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;94;-5330.121,-806.0759;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;89;-5040.311,-975.2999;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;86;-5267.77,-643.3132;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleDivideOpNode;83;-5254.773,931.8903;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;100;-4890.477,-640.1269;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;103;-5533.413,-1373.3;Inherit;False;Property;_HighColor;HighColor;7;0;Create;True;0;0;0;False;0;False;0.2295745,0.4276968,0.6320754,0;0.1611337,0.4811321,0.2072135,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ReflectOpNode;99;-5072.472,-802.9275;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;98;-4919.624,-977.1258;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;102;-5532.673,-1200.41;Inherit;False;Property;_LowColor;LowColor;11;0;Create;True;0;0;0;False;0;False;0.4198113,0.7986241,1,0;0.2069241,0.5849056,0.5570617,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;87;-1234.966,-538.1097;Inherit;False;4;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;92;-4905.954,852.5851;Inherit;False;Property;_HeightDepthOffset;HeightDepthOffset;33;0;Create;True;0;0;0;False;0;False;1;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;93;-5054.193,933.6194;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;91;-5083.451,763.2264;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;96;-4840.058,1023.03;Inherit;False;Property;_OpacityMultiplier;OpacityMultiplier;32;0;Create;True;0;0;0;False;0;False;0;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;101;-1121.723,-537.3502;Inherit;False;GerrstnerWaves;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;97;-4901.608,934.9098;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;132;-5605.584,1185.991;Inherit;False;755.6346;380.1196;NORMAL;5;107;106;108;115;116;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;139;-2944,816;Inherit;False;Property;_Range;Range;8;0;Create;True;0;0;0;False;0;False;1;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;95;-4880.334,763.4728;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;110;-4664.356,-634.9699;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;109;-4886.038,-831.6484;Inherit;True;Property;_TextureSample0;Texture Sample 0;35;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DepthFade;140;-3040,720;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;111;-4768.862,-1083.845;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;142;-2800,752;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;141;-2656,848;Inherit;False;Property;_Power;Power;10;0;Create;True;0;0;0;False;0;False;0;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;108;-5462.855,1235.992;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;114;-4494.554,-837.7825;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;104;-4763.002,934.6921;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;107;-5492.461,1374.339;Inherit;False;101;GerrstnerWaves;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;106;-5555.585,1450.951;Inherit;False;Property;_FakeNormalIntensity;FakeNormalIntensity;19;0;Create;True;0;0;0;False;0;False;0;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;105;-4740.514,763.6041;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;120;-4495.907,-720.1932;Inherit;False;HeightColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;113;-4610.991,762.3425;Inherit;False;HeightDepth;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;115;-5224.556,1329.274;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;112;-4646.759,935.2836;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;143;-2656,752;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;117;-2513.08,1202.197;Inherit;False;101;GerrstnerWaves;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;128;-2578.456,643.2305;Inherit;False;120;HeightColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;119;-4511.051,939.3773;Inherit;False;DepthOpacity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;116;-5078.143,1330.711;Inherit;False;WavesNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;144;-2496,752;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;146;-2592,432;Inherit;False;Property;_DepthFadeColor;DepthFadeColor;9;0;Create;True;0;0;0;False;0;False;0.8867924,0.8148451,0.8148451,0;0.5849056,0.5849056,0.5849056,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;118;-2495.348,1276.564;Inherit;False;113;HeightDepth;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;129;-2276.851,1211.708;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-5363.113,384.7024;Inherit;False;Property;_SmalNormalIntensity;SmalNormalIntensity;21;0;Create;True;0;0;0;False;0;False;0;0.1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;125;-2418.791,934.1137;Inherit;False;Property;_Metallic;Metallic;34;0;Create;True;0;0;0;False;0;False;0;0.3;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;127;-2352.57,857.3031;Inherit;False;50;TextureNormals;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;126;-2415.191,1011.445;Inherit;False;Property;_Smoothness;Smoothness;18;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BlendNormalsNode;122;-4964.302,415.0531;Inherit;True;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;123;-2293.718,1346.797;Inherit;False;116;WavesNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;124;-2357.601,1097.542;Inherit;False;119;DepthOpacity;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-5344.993,49.21016;Inherit;False;Property;_BigNormalIntensity;BigNormalIntensity;22;0;Create;True;0;0;0;False;0;False;0;0.5;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;145;-2352,592;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-1896.762,862.5019;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;Waves;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;0;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;18;0;16;0
WireConnection;17;0;15;0
WireConnection;23;0;18;0
WireConnection;23;2;19;0
WireConnection;22;0;17;0
WireConnection;22;2;20;0
WireConnection;26;1;22;0
WireConnection;25;1;23;0
WireConnection;29;0;25;3
WireConnection;29;1;26;3
WireConnection;31;0;25;2
WireConnection;31;1;26;2
WireConnection;38;0;25;1
WireConnection;38;1;26;1
WireConnection;37;0;29;0
WireConnection;37;1;28;0
WireConnection;42;0;38;0
WireConnection;42;1;31;0
WireConnection;42;2;37;0
WireConnection;32;0;27;0
WireConnection;34;0;30;0
WireConnection;50;0;42;0
WireConnection;43;0;33;0
WireConnection;41;0;35;0
WireConnection;40;0;36;0
WireConnection;55;0;45;0
WireConnection;66;0;39;0
WireConnection;64;0;44;0
WireConnection;80;0;53;2
WireConnection;80;1;49;0
WireConnection;85;36;68;0
WireConnection;85;37;54;0
WireConnection;85;28;59;0
WireConnection;85;25;64;0
WireConnection;85;26;74;0
WireConnection;85;27;67;0
WireConnection;81;36;61;0
WireConnection;81;37;56;0
WireConnection;81;28;55;0
WireConnection;81;25;66;0
WireConnection;81;26;63;0
WireConnection;81;27;60;0
WireConnection;79;36;52;0
WireConnection;79;37;57;0
WireConnection;79;28;71;0
WireConnection;79;25;58;0
WireConnection;79;26;72;0
WireConnection;79;27;69;0
WireConnection;84;36;46;0
WireConnection;84;37;62;0
WireConnection;84;28;70;0
WireConnection;84;25;51;0
WireConnection;84;26;65;0
WireConnection;84;27;73;0
WireConnection;94;0;77;0
WireConnection;89;0;80;0
WireConnection;89;1;76;0
WireConnection;86;0;75;0
WireConnection;83;0;47;0
WireConnection;83;1;48;0
WireConnection;100;0;86;0
WireConnection;100;2;88;0
WireConnection;100;3;90;0
WireConnection;99;0;94;0
WireConnection;99;1;86;0
WireConnection;98;0;89;0
WireConnection;87;0;79;0
WireConnection;87;1;84;0
WireConnection;87;2;85;0
WireConnection;87;3;81;0
WireConnection;93;0;83;0
WireConnection;93;1;82;0
WireConnection;91;0;47;0
WireConnection;91;1;78;0
WireConnection;101;0;87;0
WireConnection;97;0;93;0
WireConnection;95;0;91;0
WireConnection;95;1;92;0
WireConnection;110;0;100;0
WireConnection;109;1;99;0
WireConnection;111;0;103;0
WireConnection;111;1;102;0
WireConnection;111;2;98;0
WireConnection;142;0;140;0
WireConnection;142;1;139;0
WireConnection;114;0;111;0
WireConnection;114;1;109;0
WireConnection;114;2;110;0
WireConnection;104;0;97;0
WireConnection;104;1;96;0
WireConnection;105;0;95;0
WireConnection;120;0;114;0
WireConnection;113;0;105;0
WireConnection;115;0;108;0
WireConnection;115;1;107;0
WireConnection;115;2;106;0
WireConnection;112;0;104;0
WireConnection;143;0;142;0
WireConnection;143;1;141;0
WireConnection;119;0;112;0
WireConnection;116;0;115;0
WireConnection;144;0;143;0
WireConnection;129;0;117;0
WireConnection;129;1;118;0
WireConnection;122;0;25;0
WireConnection;122;1;26;0
WireConnection;145;0;146;0
WireConnection;145;1;128;0
WireConnection;145;2;144;0
WireConnection;0;0;145;0
WireConnection;0;1;127;0
WireConnection;0;3;125;0
WireConnection;0;4;126;0
WireConnection;0;9;124;0
WireConnection;0;11;129;0
WireConnection;0;12;123;0
ASEEND*/
//CHKSM=18AE022D6719C68F4800F7D06D611715B46ABB68