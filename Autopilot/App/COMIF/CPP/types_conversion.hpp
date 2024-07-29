#ifndef __TYPE_CONVERSIONS_HPP__
#define __TYPE_CONVERSIONS_HPP__

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-function"

#ifdef __cplusplus
extern "C" {
#endif

//-----------------------------------
// Fixpoint <-> float conversion
//-----------------------------------
static uint64_t double_to_FP9(double v) {return (uint64_t)(v * double(1024.0) * double(1024.0) * double(1024.0));}
static uint32_t float_to_FP6(float v)   {return (uint32_t)(v * 1024.0 * 1024.0); }
static uint32_t float_to_FP3(float v)   {return (uint32_t)(v * 1024.0); }
static float FP3_to_float(int32_t v)    {return ((float)v) / 1024.0; }
static float FP6_to_float(int32_t v)    {return ((float)v) / (1024.0 * 1024.0); }
static double FP9_to_double(int64_t v)  {return ((double)v) / (double(1024.0) * double(1024.0) * double(1024.0)); }

#define latitude_to_double(V) FP9_to_double(V)
#define double_to_latitude(V) double_to_FP9(V)

#define longitude_to_double(V) FP9_to_double(V)
#define double_to_longitude(V) double_to_FP9(V)

#define altitude_to_float(V) FP3_to_float(V)
#define float_to_altitude(V) float_to_FP3(V)

#define heading_to_float(V) FP6_to_float(V)
#define float_to_heading(V) float_to_FP6(V)

#define hspeed_to_float(V) FP3_to_float(V)
#define float_to_hspeed(V) float_to_FP3(V)

#define vspeed_to_float(V) FP3_to_float(V)
#define float_to_vspeed(V) float_to_FP3(V)

#define roll_to_float(V) FP6_to_float(V)
#define float_to_roll(V) float_to_FP6(V)

#define pitch_to_float(V) FP6_to_float(V)
#define float_to_pitch(V) float_to_FP6(V)

#define control_to_float(V) FP3_to_float(V)
#define float_to_control(V) float_to_FP3(V)

#ifdef __cplusplus
}
#endif

#pragma GCC diagnostic pop


#endif
