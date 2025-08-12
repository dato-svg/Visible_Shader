Shader "MyShader/Mask"
{
    Properties
    {
        [IntRange] _StencilRef("StencilRef",Range(0,255)) = 0
    }
    SubShader
    {
        Tags
        {
            "RenderType" = "Opaque"
            "Queue" = "Geometry-1"
        }
        
        Blend Zero One
        ZWrite Off 
        
        Stencil
        {
            Ref [_StencilRef]
            Comp Always
            Pass Replace
        }
        
        Pass {}
    }
}