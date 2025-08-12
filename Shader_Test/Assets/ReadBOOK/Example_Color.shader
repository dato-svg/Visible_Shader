Shader "Unlit/Example_Color"
{
    Properties
    {
        _ColorA("Color A", Color) = (0,1,1,1)
        _ColorB("Color B", Color) = (0,1,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            float4 _ColorA;
            float4 _ColorB;
            
            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };
            
            struct v2f
            {
                float4 vertex : SV_POSITION;
                fixed2 uv : TEXCOORD0;
            };
            
            
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }
            
            fixed4 frag (v2f i) : SV_Target
            {
                float4 outColor = lerp(_ColorA, _ColorB, i.uv.x);
                return outColor;
            }
            ENDCG
        }
    }
}
