#version 3.7;

#include "colors.inc"
#include "dem.inc"

global_settings {
    assumed_gamma 1.0
    radiosity {}
}

camera {
    orthographic
    location <0, 2, 0>  // top-down
    //location <0, 0.5, -0.5>  // 45deg oblique
    look_at <0, 0, 0>
    up <0, 1, 0>
    right <1, 0, 0>
}

// sun
light_source {
    <-1, 10, 2>
    color White
    parallel
    point_at <0, 0, 0>
    fade_distance 10
}

// global
light_source {
    <0, 1, 0>
    color rgb<0.1, 0.2, 0.4>
    area_light
    <1, 0, 0>, <0, 0, 1>, 3, 3
    jitter
    adaptive 1
    fade_distance 0.25
}

height_field {
    tiff "localized.tif"
    translate <-0.5, 0, -0.5>
    scale HeightFieldScale
    texture { pigment { color White } }
}
