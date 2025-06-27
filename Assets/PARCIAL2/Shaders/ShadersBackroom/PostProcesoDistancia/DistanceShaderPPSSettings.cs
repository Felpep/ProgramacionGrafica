// Amplify Shader Editor - Visual Shader Editing Tool
// Copyright (c) Amplify Creations, Lda <info@amplify.pt>
#if UNITY_POST_PROCESSING_STACK_V2
using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

[Serializable]
[PostProcess( typeof( DistanceShaderPPSRenderer ), PostProcessEvent.AfterStack, "DistanceShader", true )]
public sealed class DistanceShaderPPSSettings : PostProcessEffectSettings
{
	[Tooltip( "Screen" )]
	public TextureParameter _MainTex = new TextureParameter {  };
	[Tooltip( "Intensity" )]
	public FloatParameter _Intensity = new FloatParameter { value = 0f };
	[Tooltip( "FallOff" )]
	public FloatParameter _FallOff = new FloatParameter { value = 0f };
}

public sealed class DistanceShaderPPSRenderer : PostProcessEffectRenderer<DistanceShaderPPSSettings>
{
	public override void Render( PostProcessRenderContext context )
	{
		var sheet = context.propertySheets.Get( Shader.Find( "DistanceShader" ) );
		if(settings._MainTex.value != null) sheet.properties.SetTexture( "_MainTex", settings._MainTex );
		sheet.properties.SetFloat( "_Intensity", settings._Intensity );
		sheet.properties.SetFloat( "_FallOff", settings._FallOff );
		context.command.BlitFullscreenTriangle( context.source, context.destination, sheet, 0 );
	}
}
#endif
