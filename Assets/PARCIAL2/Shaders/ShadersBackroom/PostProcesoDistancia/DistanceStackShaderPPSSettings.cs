// Amplify Shader Editor - Visual Shader Editing Tool
// Copyright (c) Amplify Creations, Lda <info@amplify.pt>
#if UNITY_POST_PROCESSING_STACK_V2
using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

[Serializable]
[PostProcess( typeof( DistanceStackShaderPPSRenderer ), PostProcessEvent.AfterStack, "DistanceStackShader", true )]
public sealed class DistanceStackShaderPPSSettings : PostProcessEffectSettings
{
	[Tooltip( "Intensity" )]
	public FloatParameter _Intensity1 = new FloatParameter { value = 0f };
	[Tooltip( "FallOff" )]
	public FloatParameter _FallOff1 = new FloatParameter { value = 0f };
}

public sealed class DistanceStackShaderPPSRenderer : PostProcessEffectRenderer<DistanceStackShaderPPSSettings>
{
	public override void Render( PostProcessRenderContext context )
	{
		var sheet = context.propertySheets.Get( Shader.Find( "DistanceStackShader" ) );
		sheet.properties.SetFloat( "_Intensity1", settings._Intensity1 );
		sheet.properties.SetFloat( "_FallOff1", settings._FallOff1 );
		context.command.BlitFullscreenTriangle( context.source, context.destination, sheet, 0 );
	}
}
#endif
