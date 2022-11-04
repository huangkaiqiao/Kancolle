Shader "Unlit/NewUnlitShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _BorderSize ("BorderSize", Range(1, 10)) = 0
        _Color ("Color", Color) = (0,255,0, 1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            fixed _BorderSize;
            fixed _Color;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float2 coords = i.uv;
                coords.x *= 8;  //Uniform坐标
                float2 pointOnLineSeg = float2 (clamp(coords.x,0.5,7.5),0.5); //取的线段
                float sdf = distance(coords,pointOnLineSeg)* 2 - 1 ;    //计算线段的sdf，并减去径向值1获取内部形状
                clip(-sdf); //裁掉外边的像素

                //border
                float borderSdf = sdf + _BorderSize;    //以一个新的径向距离计算一个新的sdf
                float pd = fwidth(borderSdf);
                float borderMask = step(0,-borderSdf)/pd;  //计算边框遮罩
                
                // sample the texture
                // float3 healthbarColor = tex2D(_MainTex, float2(_Health,i.uv.y)); //用自己定义的坐标采样血条颜色贴图
                
                // float healthbarMask = _Health > i.uv.x ; //血条遮罩
                // if (_Health < 0.2)  // 低血量闪烁效果
                // {
                //     float flash = cos(_Time.y * 4 ) * 0.4 + 1;
                //     healthbarColor *= flash;
                // }

                // return float4(healthbarColor * healthbarMask * borderMask , 1);
                // return float4(_Color * borderMask, 1);
                // return _Color* borderMask;
                return fixed4(0, 1, 0, 1);
                // return fixed4(i.uv, 10, 0);
            }
            ENDCG
        }
    }
}
