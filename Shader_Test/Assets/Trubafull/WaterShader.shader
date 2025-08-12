Shader "Custom/URP_Water"
{
    Properties
    {
        _BaseColor ("Base Color", Color) = (0.2,0.5,0.8,0.6)
        _WaveSpeed ("Wave Speed", Range(0,2)) = 1
        _WaveHeight ("Wave Height", Range(0,1)) = 0.1
        _WaveFrequency ("Wave Frequency", Range(0,10)) = 3
        _NormalMap ("Normal Map", 2D) = "bump" {}
        _NormalStrength ("Normal Strength", Range(0,2)) = 1
    }

    SubShader
    {
        Tags{"RenderType"="Transparent" "Queue"="Transparent"}
        Blend SrcAlpha OneMinusSrcAlpha
        ZWrite Off
        Cull Back

        Pass
        {
            Name "ForwardLit"
            Tags{"LightMode"="UniversalForward"}
            
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            struct Attributes
            {
                float4 positionOS : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct Varyings
            {
                float4 positionHCS : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            CBUFFER_START(UnityPerMaterial)
                half4 _BaseColor;
                float _WaveSpeed;
                float _WaveHeight;
                float _WaveFrequency;
                float _NormalStrength;
            CBUFFER_END

            sampler2D _NormalMap;
            float4 _NormalMap_ST;

            Varyings vert(Attributes IN)
            {
                Varyings OUT;
                float wave = sin(_Time.y * _WaveSpeed + IN.positionOS.x * _WaveFrequency) * _WaveHeight;
                wave += cos(_Time.y * _WaveSpeed + IN.positionOS.z * _WaveFrequency) * _WaveHeight;

                IN.positionOS.y += wave;

                OUT.positionHCS = TransformObjectToHClip(IN.positionOS.xyz);
                OUT.uv = TRANSFORM_TEX(IN.uv, _NormalMap);
                return OUT;
            }

            half4 frag(Varyings IN) : SV_Target
            {
                half4 col = _BaseColor;
                return col;
            }
            ENDHLSL
        }
    }
}
