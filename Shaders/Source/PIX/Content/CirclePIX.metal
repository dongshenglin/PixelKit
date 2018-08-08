//
//  CirclePIX.metal
//  HxPxE
//
//  Created by Hexagons on 2017-11-17.
//  Copyright © 2017 Hexagons. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

struct VertexOut{
    float4 position [[position]];
    float2 texCoord;
};

struct Uniforms{
    float s;
    float x;
    float y;
    float e;
    float ar;
    float ag;
    float ab;
    float aa;
    float er;
    float eg;
    float eb;
    float ea;
    float br;
    float bg;
    float bb;
    float ba;
    float premultiply;
    float aspect;
};

fragment float4 circlePIX(VertexOut out [[stage_in]],
                          const device Uniforms& in [[ buffer(0) ]],
                          sampler s [[ sampler(0) ]]) {
    
    float u = out.texCoord[0];
    float v = out.texCoord[1];
    
    float4 ac = float4(in.ar, in.ag, in.ab, in.aa);
    float4 ec = float4(in.er, in.eg, in.eb, in.ea);
    float4 bc = float4(in.br, in.bg, in.bb, in.ba);
    
    float4 c = bc;
    
    float e = in.e;
    if (e < 0) {
        e = 0;
    }
    
    float dist = sqrt(pow((u - 0.5) * in.aspect - in.x, 2) + pow(v - 0.5 - in.y, 2));
    if (dist < in.s - e / 2) {
        c = ac;
    } else if (dist < in.s + e / 2) {
        c = ec;
    }
    
    if (in.premultiply) {
        c = float4(c.r * c.a, c.g * c.a, c.b * c.a, c.a);
    }
    
    return c;
}
