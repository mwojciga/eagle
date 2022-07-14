//POVRay-File created by 3d41.ulp v20110101
///home/wcg/eagle/przeplyw_aortalny/schema_v1_1.brd
//12-07-01 12:44

#version 3.5;

//Set to on if the file should be used as .inc
#local use_file_as_inc = off;
#if(use_file_as_inc=off)


//changes the apperance of resistors (1 Blob / 0 real)
#declare global_res_shape = 1;
//randomize color of resistors 1=random 0=same color
#declare global_res_colselect = 0;
//Number of the color for the resistors
//0=Green, 1="normal color" 2=Blue 3=Brown
#declare global_res_col = 1;
//Set to on if you want to render the PCB upside-down
#declare pcb_upsidedown = off;
//Set to x or z to rotate around the corresponding axis (referring to pcb_upsidedown)
#declare pcb_rotdir = x;
//Set the length off short pins over the PCB
#declare pin_length = 2.5;
#declare global_diode_bend_radius = 1;
#declare global_res_bend_radius = 1;
#declare global_solder = on;

#declare global_show_screws = on;
#declare global_show_washers = on;
#declare global_show_nuts = on;

#declare global_use_radiosity = on;

#declare global_ambient_mul = 1;
#declare global_ambient_mul_emit = 0;

//Animation
#declare global_anim = off;
#local global_anim_showcampath = no;

#declare global_fast_mode = off;

#declare col_preset = 2;
#declare pin_short = on;

#declare e3d_environment = off;

#local cam_x = 0;
#local cam_y = 240;
#local cam_z = -114;
#local cam_a = 20;
#local cam_look_x = 0;
#local cam_look_y = -5;
#local cam_look_z = 0;

#local pcb_rotate_x = 0;
#local pcb_rotate_y = 0;
#local pcb_rotate_z = 0;

#local pcb_board = on;
#local pcb_parts = on;
#local pcb_wire_bridges = off;
#if(global_fast_mode=off)
	#local pcb_polygons = on;
	#local pcb_silkscreen = on;
	#local pcb_wires = on;
	#local pcb_pads_smds = on;
#else
	#local pcb_polygons = off;
	#local pcb_silkscreen = off;
	#local pcb_wires = off;
	#local pcb_pads_smds = off;
#end

#local lgt1_pos_x = 28;
#local lgt1_pos_y = 42;
#local lgt1_pos_z = 26;
#local lgt1_intense = 0.753571;
#local lgt2_pos_x = -28;
#local lgt2_pos_y = 42;
#local lgt2_pos_z = 26;
#local lgt2_intense = 0.753571;
#local lgt3_pos_x = 28;
#local lgt3_pos_y = 42;
#local lgt3_pos_z = -18;
#local lgt3_intense = 0.753571;
#local lgt4_pos_x = -28;
#local lgt4_pos_y = 42;
#local lgt4_pos_z = -18;
#local lgt4_intense = 0.753571;

//Do not change these values
#declare pcb_height = 1.500000;
#declare pcb_cuheight = 0.035000;
#declare pcb_x_size = 75.000000;
#declare pcb_y_size = 50.000000;
#declare pcb_layer1_used = 0;
#declare pcb_layer16_used = 1;
#declare inc_testmode = off;
#declare global_seed=seed(515);
#declare global_pcb_layer_dis = array[16]
{
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	1.535000,
}
#declare global_pcb_real_hole = 2.000000;

#include "e3d_tools.inc"
#include "e3d_user.inc"

global_settings{charset utf8}

#if(e3d_environment=on)
sky_sphere {pigment {Navy}
pigment {bozo turbulence 0.65 octaves 7 omega 0.7 lambda 2
color_map {
[0.0 0.1 color rgb <0.85, 0.85, 0.85> color rgb <0.75, 0.75, 0.75>]
[0.1 0.5 color rgb <0.75, 0.75, 0.75> color rgbt <1, 1, 1, 1>]
[0.5 1.0 color rgbt <1, 1, 1, 1> color rgbt <1, 1, 1, 1>]}
scale <0.1, 0.5, 0.1>} rotate -90*x}
plane{y, -10.0-max(pcb_x_size,pcb_y_size)*abs(max(sin((pcb_rotate_x/180)*pi),sin((pcb_rotate_z/180)*pi)))
texture{T_Chrome_2D
normal{waves 0.1 frequency 3000.0 scale 3000.0}} translate<0,0,0>}
#end

//Animation data
#if(global_anim=on)
#declare global_anim_showcampath = no;
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_flight=0;
#warning "No/not enough Animation Data available (min. 3 points) (Flight path)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_view=0;
#warning "No/not enough Animation Data available (min. 3 points) (View path)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#end

#if((global_anim_showcampath=yes)&(global_anim=off))
#end
#if(global_anim=on)
camera
{
	location global_anim_spline_cam_flight(clock)
	#if(global_anim_npoints_cam_view>2)
		look_at global_anim_spline_cam_view(clock)
	#else
		look_at global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	angle 45
}
light_source
{
	global_anim_spline_cam_flight(clock)
	color rgb <1,1,1>
	spotlight point_at 
	#if(global_anim_npoints_cam_view>2)
		global_anim_spline_cam_view(clock)
	#else
		global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	radius 35 falloff  40
}
#else
camera
{
	location <cam_x,cam_y,cam_z>
	look_at <cam_look_x,cam_look_y,cam_look_z>
	angle cam_a
	//translates the camera that <0,0,0> is over the Eagle <0,0>
	//translate<-37.500000,0,-25.000000>
}
#end

background{col_bgr}
light_source{<lgt1_pos_x,lgt1_pos_y,lgt1_pos_z> White*lgt1_intense}
light_source{<lgt2_pos_x,lgt2_pos_y,lgt2_pos_z> White*lgt2_intense}
light_source{<lgt3_pos_x,lgt3_pos_y,lgt3_pos_z> White*lgt3_intense}
light_source{<lgt4_pos_x,lgt4_pos_y,lgt4_pos_z> White*lgt4_intense}
#end


#macro SCHEMA_V1_1(mac_x_ver,mac_y_ver,mac_z_ver,mac_x_rot,mac_y_rot,mac_z_rot)
union{
#if(pcb_board = on)
difference{
union{
//Board
prism{-1.500000,0.000000,8
<0.000000,0.000000><75.000000,0.000000>
<75.000000,0.000000><75.000000,50.000000>
<75.000000,50.000000><0.000000,50.000000>
<0.000000,50.000000><0.000000,0.000000>
texture{col_brd}}
}//End union(PCB)
//Holes(real)/Parts
cylinder{<24.826000,1,29.000000><24.826000,-5,29.000000>1.651000 texture{col_hls}}
//Holes(real)/Board
cylinder{<37.500000,1,25.000000><37.500000,-5,25.000000>4.000000 texture{col_hls}}
//Holes(real)/Vias
cylinder{<5.000000,0.095000,5.980000><5.000000,-1.595000,5.980000>1.150000 texture{col_hls}}
cylinder{<5.000000,0.095000,18.020000><5.000000,-1.595000,18.020000>1.150000 texture{col_hls}}
}//End difference(reale Bohrungen/Durchbrüche)
#end
#if(pcb_parts=on)//Parts
union{
#ifndef(pack_C1) #declare global_pack_C1=yes; object {CAP_DIS_CERAMIC_25MM_50MM("",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<32.000000,0.000000,31.000000>}#end		//ceramic disc capacitator C1  C025-025X050
#ifndef(pack_C2) #declare global_pack_C2=yes; object {CAP_DIS_CERAMIC_25MM_50MM("",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<41.000000,0.000000,31.000000>}#end		//ceramic disc capacitator C2  C025-025X050
#ifndef(pack_C3) #declare global_pack_C3=yes; object {CAP_DIS_CERAMIC_25MM_50MM("",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<5.000000,0.000000,47.000000>}#end		//ceramic disc capacitator C3  C025-025X050
#ifndef(pack_C4) #declare global_pack_C4=yes; object {CAP_DIS_ELKO_2MM5_5MM("",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<22.000000,0.000000,14.000000>}#end		//Elko 2,5mm Pitch, 5mm  Diameter, 11,2mm High C4  E2,5-5
#ifndef(pack_C5) #declare global_pack_C5=yes; object {CAP_DIS_ELKO_2MM5_5MM("",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<16.000000,0.000000,14.000000>}#end		//Elko 2,5mm Pitch, 5mm  Diameter, 11,2mm High C5  E2,5-5
#ifndef(pack_C6) #declare global_pack_C6=yes; object {CAP_DIS_ELKO_2MM5_5MM("",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<16.000000,0.000000,20.000000>}#end		//Elko 2,5mm Pitch, 5mm  Diameter, 11,2mm High C6  E2,5-5
#ifndef(pack_C7) #declare global_pack_C7=yes; object {CAP_DIS_CERAMIC_25MM_50MM("",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<22.000000,0.000000,18.000000>}#end		//ceramic disc capacitator C7  C025-025X050
#ifndef(pack_C8) #declare global_pack_C8=yes; object {CAP_DIS_CERAMIC_25MM_50MM("",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<21.000000,0.000000,30.000000>}#end		//ceramic disc capacitator C8  C025-025X050
#ifndef(pack_C9) #declare global_pack_C9=yes; object {CAP_DIS_ELKO_2MM5_5MM("",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<29.000000,0.000000,26.000000>}#end		//Elko 2,5mm Pitch, 5mm  Diameter, 11,2mm High C9  E2,5-5
#ifndef(pack_C10) #declare global_pack_C10=yes; object {CAP_DIS_CERAMIC_25MM_50MM("",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<57.000000,0.000000,20.000000>}#end		//ceramic disc capacitator C10  C025-025X050
#ifndef(pack_C11) #declare global_pack_C11=yes; object {CAP_DIS_ELKO_2MM5_5MM("",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<53.000000,0.000000,43.000000>}#end		//Elko 2,5mm Pitch, 5mm  Diameter, 11,2mm High C11  E2,5-5
#ifndef(pack_C12) #declare global_pack_C12=yes; object {CAP_DIS_CERAMIC_25MM_50MM("",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<43.500000,0.000000,4.000000>}#end		//ceramic disc capacitator C12  C025-025X050
#ifndef(pack_D1) #declare global_pack_D1=yes; object {DIODE_DIS_DO41_102MM_H("1N4004",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<67.000000,0.000000,23.000000>}#end		//Diode DO35 10mm hor. D1 1N4004 DO41-10
#ifndef(pack_D2) #declare global_pack_D2=yes; object {DIODE_DIS_DO41_102MM_H("1N4004",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<6.000000,0.000000,27.000000>}#end		//Diode DO35 10mm hor. D2 1N4004 DO41-10
#ifndef(pack_D3) #declare global_pack_D3=yes; object {DIODE_DIS_DO41_102MM_H("1N4004",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<56.000000,0.000000,47.000000>}#end		//Diode DO35 10mm hor. D3 1N4004 DO41-10
#ifndef(pack_IC1) #declare global_pack_IC1=yes; object {IC_DIS_DIP28("MEGA8-P","ATMEL",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<29.000000,0.000000,42.000000>translate<0,3.000000,0> }#end		//DIP28 300mil IC1 MEGA8-P DIL28-3
#ifndef(pack_IC1) object{SOCKET_DIP28()rotate<0,0.000000,0> rotate<0,0,0> translate<29.000000,0.000000,42.000000>}#end					//IC-Sockel 28Pin IC1 MEGA8-P
#ifndef(pack_IC2) #declare global_pack_IC2=yes; object {TR_TO220_3_H("7805T",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<20.000000,0.000000,29.000000>}#end		//TO220 horizontal straight leads IC2 7805T TO220H
#ifndef(pack_JP1) #declare global_pack_JP1=yes; object {CON_PHW_1X3()translate<0,-0,-3.8> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,180> translate<-1.000000,-1.500000,25.000000>}#end		//Header 2,54MM Grid 90deg (con-lstb.lib) JP1  1X03/90
#ifndef(pack_LED1) #declare global_pack_LED1=yes; object {DIODE_DIS_LED_3MM(Red,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<29.500000,0.000000,5.500000>}#end		//Diskrete 3MM LED LED1  LED3MM
#ifndef(pack_LED2) #declare global_pack_LED2=yes; object {DIODE_DIS_LED_3MM(Red,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<34.000000,0.000000,6.000000>}#end		//Diskrete 3MM LED LED2  LED3MM
#ifndef(pack_LED3) #declare global_pack_LED3=yes; object {DIODE_DIS_LED_3MM(Red,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<58.000000,0.000000,8.000000>}#end		//Diskrete 3MM LED LED3  LED3MM
#ifndef(pack_LED4) #declare global_pack_LED4=yes; object {DIODE_DIS_LED_3MM(Red,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<58.000000,0.000000,13.000000>}#end		//Diskrete 3MM LED LED4  LED3MM
#ifndef(pack_LED6) #declare global_pack_LED6=yes; object {DIODE_DIS_LED_3MM(Red,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<47.000000,0.000000,18.000000>}#end		//Diskrete 3MM LED LED6  LED3MM
#ifndef(pack_OK1) #declare global_pack_OK1=yes; object {IC_DIS_DIP4("SFH620A","ATMEL",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<58.000000,0.000000,30.000000>}#end		//DIP4 OK1 SFH620A DIL04
#ifndef(pack_Q1) #declare global_pack_Q1=yes; object {SPC_XTAL_L4("",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<34.000000,0.000000,42.000000>}#end		//Quarz 4,9MM Q1  Q
#ifndef(pack_R1) #declare global_pack_R1=yes; object {RES_DIS_0207_10MM(texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<67.000000,0.000000,19.000000>}#end		//Discrete Resistor 0,3W 10MM Grid R1  0207/10
#ifndef(pack_R2) #declare global_pack_R2=yes; object {RES_DIS_0207_10MM(texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<46.000000,0.000000,28.000000>}#end		//Discrete Resistor 0,3W 10MM Grid R2  0207/10
#ifndef(pack_R3) #declare global_pack_R3=yes; object {RES_DIS_0207_10MM(texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<49.000000,0.000000,28.000000>}#end		//Discrete Resistor 0,3W 10MM Grid R3  0207/10
#ifndef(pack_R4) #declare global_pack_R4=yes; object {RES_DIS_0207_10MM(texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<52.000000,0.000000,28.000000>}#end		//Discrete Resistor 0,3W 10MM Grid R4  0207/10
#ifndef(pack_R5) #declare global_pack_R5=yes; object {RES_DIS_0207_10MM(texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<56.000000,0.000000,38.500000>}#end		//Discrete Resistor 0,3W 10MM Grid R5  0207/10
#ifndef(pack_R6) #declare global_pack_R6=yes; object {RES_DIS_0207_10MM(texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<18.000000,0.000000,30.000000>}#end		//Discrete Resistor 0,3W 10MM Grid R6  0207/10
#ifndef(pack_R7) #declare global_pack_R7=yes; object {RES_DIS_0207_10MM(texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<24.000000,0.000000,30.000000>}#end		//Discrete Resistor 0,3W 10MM Grid R7  0207/10
#ifndef(pack_R8) #declare global_pack_R8=yes; object {RES_DIS_0207_10MM(texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<20.000000,0.000000,7.500000>}#end		//Discrete Resistor 0,3W 10MM Grid R8  0207/10
#ifndef(pack_R9) #declare global_pack_R9=yes; object {RES_DIS_0207_10MM(texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<20.000000,0.000000,4.500000>}#end		//Discrete Resistor 0,3W 10MM Grid R9  0207/10
#ifndef(pack_R10) #declare global_pack_R10=yes; object {RES_DIS_0207_10MM(texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<55.500000,0.000000,2.000000>}#end		//Discrete Resistor 0,3W 10MM Grid R10  0207/10
#ifndef(pack_R11) #declare global_pack_R11=yes; object {RES_DIS_0207_10MM(texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<52.000000,0.000000,15.000000>}#end		//Discrete Resistor 0,3W 10MM Grid R11  0207/10
#ifndef(pack_S1) #declare global_pack_S1=yes; object {SWITCH_B3F_10XX1()translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<67.000000,0.000000,13.000000>}#end		//Tactile Switch-Omron S1  B3F-10XX
#ifndef(pack_S2) #declare global_pack_S2=yes; object {SWITCH_B3F_10XX1()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<67.000000,0.000000,5.000000>}#end		//Tactile Switch-Omron S2  B3F-10XX
#ifndef(pack_T1) #declare global_pack_T1=yes; object {TR_TO92_G("",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<59.000000,0.000000,43.000000>}#end		//TO92 bend vertical T1  TO92
}//End union
#end
#if(pcb_pads_smds=on)
//Pads&SMD/Parts
#ifndef(global_pack_C1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<33.270000,0,31.000000> texture{col_thl}}
#ifndef(global_pack_C1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<30.730000,0,31.000000> texture{col_thl}}
#ifndef(global_pack_C2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<41.000000,0,32.270000> texture{col_thl}}
#ifndef(global_pack_C2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<41.000000,0,29.730000> texture{col_thl}}
#ifndef(global_pack_C3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<6.270000,0,47.000000> texture{col_thl}}
#ifndef(global_pack_C3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<3.730000,0,47.000000> texture{col_thl}}
#ifndef(global_pack_C4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<23.270000,0,14.000000> texture{col_thl}}
#ifndef(global_pack_C4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<20.730000,0,14.000000> texture{col_thl}}
#ifndef(global_pack_C5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<14.730000,0,14.000000> texture{col_thl}}
#ifndef(global_pack_C5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<17.270000,0,14.000000> texture{col_thl}}
#ifndef(global_pack_C6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<14.730000,0,20.000000> texture{col_thl}}
#ifndef(global_pack_C6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<17.270000,0,20.000000> texture{col_thl}}
#ifndef(global_pack_C7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<20.730000,0,18.000000> texture{col_thl}}
#ifndef(global_pack_C7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<23.270000,0,18.000000> texture{col_thl}}
#ifndef(global_pack_C8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<21.000000,0,28.730000> texture{col_thl}}
#ifndef(global_pack_C8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<21.000000,0,31.270000> texture{col_thl}}
#ifndef(global_pack_C9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<27.730000,0,26.000000> texture{col_thl}}
#ifndef(global_pack_C9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<30.270000,0,26.000000> texture{col_thl}}
#ifndef(global_pack_C10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<58.270000,0,20.000000> texture{col_thl}}
#ifndef(global_pack_C10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<55.730000,0,20.000000> texture{col_thl}}
#ifndef(global_pack_C11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<51.730000,0,43.000000> texture{col_thl}}
#ifndef(global_pack_C11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<54.270000,0,43.000000> texture{col_thl}}
#ifndef(global_pack_C12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<44.770000,0,4.000000> texture{col_thl}}
#ifndef(global_pack_C12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<42.230000,0,4.000000> texture{col_thl}}
#ifndef(global_pack_D1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<72.080000,0,23.000000> texture{col_thl}}
#ifndef(global_pack_D1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<61.920000,0,23.000000> texture{col_thl}}
#ifndef(global_pack_D2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<6.000000,0,32.080000> texture{col_thl}}
#ifndef(global_pack_D2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<6.000000,0,21.920000> texture{col_thl}}
#ifndef(global_pack_D3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<61.080000,0,47.000000> texture{col_thl}}
#ifndef(global_pack_D3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<50.920000,0,47.000000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<12.490000,0,38.190000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<15.030000,0,38.190000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<17.570000,0,38.190000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<20.110000,0,38.190000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<22.650000,0,38.190000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<25.190000,0,38.190000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<27.730000,0,38.190000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<30.270000,0,38.190000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<32.810000,0,38.190000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<35.350000,0,38.190000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<37.890000,0,38.190000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<40.430000,0,38.190000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<42.970000,0,38.190000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<45.510000,0,38.190000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<45.510000,0,45.810000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<42.970000,0,45.810000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<40.430000,0,45.810000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<37.890000,0,45.810000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<35.350000,0,45.810000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<32.810000,0,45.810000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<30.270000,0,45.810000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<27.730000,0,45.810000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<25.190000,0,45.810000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<22.650000,0,45.810000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<20.110000,0,45.810000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<17.570000,0,45.810000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<15.030000,0,45.810000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<12.490000,0,45.810000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<9.840000,0,31.540000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<9.840000,0,29.000000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<9.840000,0,26.460000> texture{col_thl}}
#ifndef(global_pack_J1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.000000,1.000000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<8.100000,0,40.000000> texture{col_thl}}
#ifndef(global_pack_J1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.000000,1.000000,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<5.000000,0,35.200000> texture{col_thl}}
#ifndef(global_pack_J1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.000000,1.000000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<2.000000,0,40.000000> texture{col_thl}}
#ifndef(global_pack_JP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<2.810000,0,27.540000> texture{col_thl}}
#ifndef(global_pack_JP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<2.810000,0,25.000000> texture{col_thl}}
#ifndef(global_pack_JP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<2.810000,0,22.460000> texture{col_thl}}
#ifndef(global_pack_LED1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<28.230000,0,5.500000> texture{col_thl}}
#ifndef(global_pack_LED1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<30.770000,0,5.500000> texture{col_thl}}
#ifndef(global_pack_LED2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<34.000000,0,4.730000> texture{col_thl}}
#ifndef(global_pack_LED2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<34.000000,0,7.270000> texture{col_thl}}
#ifndef(global_pack_LED3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<56.730000,0,8.000000> texture{col_thl}}
#ifndef(global_pack_LED3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<59.270000,0,8.000000> texture{col_thl}}
#ifndef(global_pack_LED4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<56.730000,0,13.000000> texture{col_thl}}
#ifndef(global_pack_LED4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<59.270000,0,13.000000> texture{col_thl}}
#ifndef(global_pack_LED6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<48.270000,0,18.000000> texture{col_thl}}
#ifndef(global_pack_LED6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<45.730000,0,18.000000> texture{col_thl}}
#ifndef(global_pack_OK1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<56.730000,0,26.190000> texture{col_thl}}
#ifndef(global_pack_OK1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<59.270000,0,26.190000> texture{col_thl}}
#ifndef(global_pack_OK1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<59.270000,0,33.810000> texture{col_thl}}
#ifndef(global_pack_OK1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<56.730000,0,33.810000> texture{col_thl}}
#ifndef(global_pack_Q1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.117600,0.609600,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<31.460000,0,34.380000> texture{col_thl}}
#ifndef(global_pack_Q1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.117600,0.609600,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<36.540000,0,34.380000> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<72.080000,0,19.000000> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<61.920000,0,19.000000> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<46.000000,0,22.920000> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<46.000000,0,33.080000> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<49.000000,0,22.920000> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<49.000000,0,33.080000> texture{col_thl}}
#ifndef(global_pack_R4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<52.000000,0,22.920000> texture{col_thl}}
#ifndef(global_pack_R4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<52.000000,0,33.080000> texture{col_thl}}
#ifndef(global_pack_R5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<50.920000,0,38.500000> texture{col_thl}}
#ifndef(global_pack_R5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<61.080000,0,38.500000> texture{col_thl}}
#ifndef(global_pack_R6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<18.000000,0,24.920000> texture{col_thl}}
#ifndef(global_pack_R6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<18.000000,0,35.080000> texture{col_thl}}
#ifndef(global_pack_R7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<24.000000,0,24.920000> texture{col_thl}}
#ifndef(global_pack_R7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<24.000000,0,35.080000> texture{col_thl}}
#ifndef(global_pack_R8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<25.080000,0,7.500000> texture{col_thl}}
#ifndef(global_pack_R8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<14.920000,0,7.500000> texture{col_thl}}
#ifndef(global_pack_R9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<25.080000,0,4.500000> texture{col_thl}}
#ifndef(global_pack_R9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<14.920000,0,4.500000> texture{col_thl}}
#ifndef(global_pack_R10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<60.580000,0,2.000000> texture{col_thl}}
#ifndef(global_pack_R10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<50.420000,0,2.000000> texture{col_thl}}
#ifndef(global_pack_R11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<52.000000,0,9.920000> texture{col_thl}}
#ifndef(global_pack_R11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<52.000000,0,20.080000> texture{col_thl}}
#ifndef(global_pack_S1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<63.748800,0,15.260600> texture{col_thl}}
#ifndef(global_pack_S1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<70.251200,0,15.260600> texture{col_thl}}
#ifndef(global_pack_S1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<63.748800,0,10.739400> texture{col_thl}}
#ifndef(global_pack_S1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<70.251200,0,10.739400> texture{col_thl}}
#ifndef(global_pack_S2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<70.251200,0,2.739400> texture{col_thl}}
#ifndef(global_pack_S2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<63.748800,0,2.739400> texture{col_thl}}
#ifndef(global_pack_S2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<70.251200,0,7.260600> texture{col_thl}}
#ifndef(global_pack_S2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<63.748800,0,7.260600> texture{col_thl}}
#ifndef(global_pack_T1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<59.000000,0,41.730000> texture{col_thl}}
#ifndef(global_pack_T1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<60.905000,0,43.000000> texture{col_thl}}
#ifndef(global_pack_T1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<59.000000,0,44.270000> texture{col_thl}}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<31.775000,-1.537000,18.656000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<32.425000,-1.537000,18.656000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<33.075000,-1.537000,18.656000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<33.725000,-1.537000,18.656000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<34.375000,-1.537000,18.656000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<35.025000,-1.537000,18.656000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<35.675000,-1.537000,18.656000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<36.325000,-1.537000,18.656000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<36.975000,-1.537000,18.656000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<37.625000,-1.537000,18.656000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<38.275000,-1.537000,18.656000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<38.925000,-1.537000,18.656000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<39.575000,-1.537000,18.656000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<40.225000,-1.537000,18.656000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<40.225000,-1.537000,11.344000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<39.575000,-1.537000,11.344000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<38.925000,-1.537000,11.344000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<38.275000,-1.537000,11.344000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<37.625000,-1.537000,11.344000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<36.975000,-1.537000,11.344000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<36.325000,-1.537000,11.344000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<35.675000,-1.537000,11.344000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<35.025000,-1.537000,11.344000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<34.375000,-1.537000,11.344000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<33.725000,-1.537000,11.344000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<33.075000,-1.537000,11.344000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<32.425000,-1.537000,11.344000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<31.775000,-1.537000,11.344000>}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.458000,0.950000,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<9.710000,0,10.750000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.458000,0.950000,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<9.710000,0,13.250000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.458000,0.950000,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<7.710000,0,13.250000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.458000,0.950000,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<7.710000,0,10.750000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(3.316000,2.300000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<5.000000,0,18.020000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(3.316000,2.300000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<5.000000,0,5.980000> texture{col_thl}}
#ifndef(global_pack_X2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.790800,1.193800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<67.365000,0,40.460000> texture{col_thl}}
#ifndef(global_pack_X2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.790800,1.193800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<67.365000,0,45.540000> texture{col_thl}}
#ifndef(global_pack_X3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.790800,1.193800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<67.365000,0,28.460000> texture{col_thl}}
#ifndef(global_pack_X3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.790800,1.193800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<67.365000,0,33.540000> texture{col_thl}}
//Pads/Vias
object{TOOLS_PCB_VIA(1.006400,0.600000,1,16,0,0) translate<9.000000,0,23.000000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.006400,0.600000,1,16,0,0) translate<18.500000,0,23.000000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.006400,0.600000,1,16,0,0) translate<42.500000,0,21.500000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.006400,0.600000,1,16,0,0) translate<53.500000,0,21.500000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.006400,0.600000,1,16,0,0) translate<54.000000,0,14.500000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.006400,0.600000,1,16,0,0) translate<54.000000,0,10.500000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.006400,0.600000,1,16,0,0) translate<42.500000,0,15.000000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.006400,0.600000,1,16,0,0) translate<46.000000,0,15.000000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.006400,0.600000,1,16,0,0) translate<46.500000,0,4.000000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.006400,0.600000,1,16,0,0) translate<51.500000,0,4.000000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.006400,0.600000,1,16,0,0) translate<27.500000,0,17.000000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.006400,0.600000,1,16,0,0) translate<27.500000,0,10.500000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.006400,0.600000,1,16,0,0) translate<13.000000,0,30.500000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.006400,0.600000,1,16,0,0) translate<13.000000,0,17.500000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.006400,0.600000,1,16,0,0) translate<55.500000,0,14.500000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.006400,0.600000,1,16,0,0) translate<45.500000,0,6.500000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.006400,0.600000,1,16,0,0) translate<55.500000,0,10.500000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.006400,0.600000,1,16,0,0) translate<53.000000,0,6.500000> texture{col_thl}}
#end
#if(pcb_wires=on)
union{
//Signals
difference{union{
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.000000,-1.535000,5.980000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.710000,-1.535000,8.690000>}
box{<0,0,-0.304800><3.832519,0.035000,0.304800> rotate<0,-44.997030,0> translate<5.000000,-1.535000,5.980000> }
}cylinder{<5.000000,1,5.980000><5.000000,-2.500000,5.980000>1.150000 texture{col_thl}}}
difference{union{
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.000000,-1.535000,18.020000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.480000,-1.535000,18.020000>}
box{<0,0,-0.152400><3.480000,0.035000,0.152400> rotate<0,0.000000,0> translate<5.000000,-1.535000,18.020000> }
}cylinder{<5.000000,1,18.020000><5.000000,-2.500000,18.020000>1.150000 texture{col_thl}}}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<1.000000,-1.535000,3.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<1.000000,-1.535000,10.000000>}
box{<0,0,-0.152400><7.000000,0.035000,0.152400> rotate<0,90.000000,0> translate<1.000000,-1.535000,10.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<2.000000,-1.535000,3.500000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<2.000000,-1.535000,9.000000>}
box{<0,0,-0.152400><5.500000,0.035000,0.152400> rotate<0,90.000000,0> translate<2.000000,-1.535000,9.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<2.000000,-1.535000,16.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<2.000000,-1.535000,22.460000>}
box{<0,0,-0.304800><6.460000,0.035000,0.304800> rotate<0,90.000000,0> translate<2.000000,-1.535000,22.460000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<2.000000,-1.535000,38.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<2.000000,-1.535000,40.000000>}
box{<0,0,-0.304800><1.800000,0.035000,0.304800> rotate<0,90.000000,0> translate<2.000000,-1.535000,40.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<2.000000,-1.535000,40.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<2.000000,-1.535000,47.000000>}
box{<0,0,-0.304800><7.000000,0.035000,0.304800> rotate<0,90.000000,0> translate<2.000000,-1.535000,47.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<2.000000,-1.535000,22.460000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<2.810000,-1.535000,22.460000>}
box{<0,0,-0.152400><0.810000,0.035000,0.152400> rotate<0,0.000000,0> translate<2.000000,-1.535000,22.460000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<1.000000,-1.535000,3.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<3.000000,-1.535000,1.000000>}
box{<0,0,-0.152400><2.828427,0.035000,0.152400> rotate<0,44.997030,0> translate<1.000000,-1.535000,3.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<2.000000,-1.535000,16.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<3.000000,-1.535000,15.000000>}
box{<0,0,-0.304800><1.414214,0.035000,0.304800> rotate<0,44.997030,0> translate<2.000000,-1.535000,16.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<2.000000,-1.535000,3.500000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<3.500000,-1.535000,2.000000>}
box{<0,0,-0.152400><2.121320,0.035000,0.152400> rotate<0,44.997030,0> translate<2.000000,-1.535000,3.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<2.000000,-1.535000,47.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<3.730000,-1.535000,47.000000>}
box{<0,0,-0.304800><1.730000,0.035000,0.304800> rotate<0,0.000000,0> translate<2.000000,-1.535000,47.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<4.000000,-1.535000,31.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<4.000000,-1.535000,34.000000>}
box{<0,0,-0.304800><3.000000,0.035000,0.304800> rotate<0,90.000000,0> translate<4.000000,-1.535000,34.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<3.730000,-1.535000,47.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<4.000000,-1.535000,47.270000>}
box{<0,0,-0.304800><0.381838,0.035000,0.304800> rotate<0,-44.997030,0> translate<3.730000,-1.535000,47.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<4.000000,-1.535000,47.270000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<4.000000,-1.535000,49.000000>}
box{<0,0,-0.304800><1.730000,0.035000,0.304800> rotate<0,90.000000,0> translate<4.000000,-1.535000,49.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<1.000000,-1.535000,10.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<4.250000,-1.535000,13.250000>}
box{<0,0,-0.152400><4.596194,0.035000,0.152400> rotate<0,-44.997030,0> translate<1.000000,-1.535000,10.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<2.000000,-1.535000,9.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.000000,-1.535000,12.000000>}
box{<0,0,-0.152400><4.242641,0.035000,0.152400> rotate<0,-44.997030,0> translate<2.000000,-1.535000,9.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<4.000000,-1.535000,34.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.000000,-1.535000,35.000000>}
box{<0,0,-0.304800><1.414214,0.035000,0.304800> rotate<0,-44.997030,0> translate<4.000000,-1.535000,34.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<2.000000,-1.535000,38.200000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.000000,-1.535000,35.200000>}
box{<0,0,-0.304800><4.242641,0.035000,0.304800> rotate<0,44.997030,0> translate<2.000000,-1.535000,38.200000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.000000,-1.535000,35.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.000000,-1.535000,35.200000>}
box{<0,0,-0.152400><0.200000,0.035000,0.152400> rotate<0,90.000000,0> translate<5.000000,-1.535000,35.200000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<4.000000,-1.535000,31.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<6.000000,-1.535000,29.000000>}
box{<0,0,-0.304800><2.828427,0.035000,0.304800> rotate<0,44.997030,0> translate<4.000000,-1.535000,31.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<6.000000,-1.535000,32.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<6.080000,-1.535000,32.080000>}
box{<0,0,-0.304800><0.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<6.000000,-1.535000,32.080000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<6.270000,-1.535000,46.730000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<6.270000,-1.535000,47.000000>}
box{<0,0,-0.304800><0.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<6.270000,-1.535000,47.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<2.810000,-1.535000,27.540000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<6.460000,-1.535000,27.540000>}
box{<0,0,-0.304800><3.650000,0.035000,0.304800> rotate<0,0.000000,0> translate<2.810000,-1.535000,27.540000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<2.810000,-1.535000,25.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<6.500000,-1.535000,25.000000>}
box{<0,0,-0.304800><3.690000,0.035000,0.304800> rotate<0,0.000000,0> translate<2.810000,-1.535000,25.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<6.000000,-1.535000,21.920000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<6.810000,-1.535000,21.920000>}
box{<0,0,-0.304800><0.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<6.000000,-1.535000,21.920000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<6.460000,-1.535000,27.540000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.540000,-1.535000,26.460000>}
box{<0,0,-0.304800><1.527351,0.035000,0.304800> rotate<0,44.997030,0> translate<6.460000,-1.535000,27.540000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.710000,-1.535000,10.750000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.710000,-1.535000,9.000000>}
box{<0,0,-0.203200><1.750000,0.035000,0.203200> rotate<0,-90.000000,0> translate<7.710000,-1.535000,9.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.710000,-1.535000,8.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.710000,-1.535000,10.750000>}
box{<0,0,-0.304800><2.060000,0.035000,0.304800> rotate<0,90.000000,0> translate<7.710000,-1.535000,10.750000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<4.250000,-1.535000,13.250000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<7.710000,-1.535000,13.250000>}
box{<0,0,-0.152400><3.460000,0.035000,0.152400> rotate<0,0.000000,0> translate<4.250000,-1.535000,13.250000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<6.080000,-1.535000,32.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.000000,-1.535000,34.000000>}
box{<0,0,-0.304800><2.715290,0.035000,0.304800> rotate<0,-44.997030,0> translate<6.080000,-1.535000,32.080000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.000000,-1.535000,34.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.000000,-1.535000,39.900000>}
box{<0,0,-0.304800><5.900000,0.035000,0.304800> rotate<0,90.000000,0> translate<8.000000,-1.535000,39.900000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.000000,-1.535000,39.900000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.100000,-1.535000,40.000000>}
box{<0,0,-0.304800><0.141421,0.035000,0.304800> rotate<0,-44.997030,0> translate<8.000000,-1.535000,39.900000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.000000,-1.535000,12.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.960000,-1.535000,12.000000>}
box{<0,0,-0.152400><3.960000,0.035000,0.152400> rotate<0,0.000000,0> translate<5.000000,-1.535000,12.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<6.500000,-1.535000,25.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.000000,-1.535000,23.000000>}
box{<0,0,-0.304800><3.201562,0.035000,0.304800> rotate<0,38.657257,0> translate<6.500000,-1.535000,25.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.960000,-1.535000,12.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.710000,-1.535000,13.250000>}
box{<0,0,-0.152400><1.457738,0.035000,0.152400> rotate<0,-59.032347,0> translate<8.960000,-1.535000,12.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.710000,-1.535000,10.750000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.750000,-1.535000,10.750000>}
box{<0,0,-0.152400><0.040000,0.035000,0.152400> rotate<0,0.000000,0> translate<9.710000,-1.535000,10.750000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.840000,-1.535000,26.460000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.840000,-1.535000,24.890000>}
box{<0,0,-0.304800><1.570000,0.035000,0.304800> rotate<0,-90.000000,0> translate<9.840000,-1.535000,24.890000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.540000,-1.535000,26.460000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.840000,-1.535000,26.460000>}
box{<0,0,-0.304800><2.300000,0.035000,0.304800> rotate<0,0.000000,0> translate<7.540000,-1.535000,26.460000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.540000,-1.535000,26.460000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.840000,-1.535000,26.460000>}
box{<0,0,-0.304800><1.300000,0.035000,0.304800> rotate<0,0.000000,0> translate<8.540000,-1.535000,26.460000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<6.000000,-1.535000,29.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.840000,-1.535000,29.000000>}
box{<0,0,-0.304800><3.840000,0.035000,0.304800> rotate<0,0.000000,0> translate<6.000000,-1.535000,29.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<3.000000,-1.535000,15.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<10.000000,-1.535000,15.000000>}
box{<0,0,-0.152400><7.000000,0.035000,0.152400> rotate<0,0.000000,0> translate<3.000000,-1.535000,15.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<6.270000,-1.535000,46.730000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.500000,-1.535000,42.500000>}
box{<0,0,-0.304800><5.982123,0.035000,0.304800> rotate<0,44.997030,0> translate<6.270000,-1.535000,46.730000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.500000,-1.535000,35.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.500000,-1.535000,42.500000>}
box{<0,0,-0.304800><7.000000,0.035000,0.304800> rotate<0,90.000000,0> translate<10.500000,-1.535000,42.500000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.750000,-1.535000,10.750000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<11.000000,-1.535000,12.000000>}
box{<0,0,-0.152400><1.767767,0.035000,0.152400> rotate<0,-44.997030,0> translate<9.750000,-1.535000,10.750000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<11.000000,-1.535000,14.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<11.000000,-1.535000,12.000000>}
box{<0,0,-0.152400><2.000000,0.035000,0.152400> rotate<0,-90.000000,0> translate<11.000000,-1.535000,12.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<10.000000,-1.535000,15.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<11.000000,-1.535000,14.000000>}
box{<0,0,-0.152400><1.414214,0.035000,0.152400> rotate<0,44.997030,0> translate<10.000000,-1.535000,15.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.840000,-1.535000,29.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.000000,-1.535000,29.000000>}
box{<0,0,-0.304800><1.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<9.840000,-1.535000,29.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<6.810000,-1.535000,21.920000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.365000,-1.535000,17.365000>}
box{<0,0,-0.304800><6.441743,0.035000,0.304800> rotate<0,44.997030,0> translate<6.810000,-1.535000,21.920000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.365000,-1.535000,17.365000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.500000,-1.535000,17.500000>}
box{<0,0,-0.304800><0.190919,0.035000,0.304800> rotate<0,-44.997030,0> translate<11.365000,-1.535000,17.365000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.840000,-1.535000,31.540000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.960000,-1.535000,31.540000>}
box{<0,0,-0.304800><2.120000,0.035000,0.304800> rotate<0,0.000000,0> translate<9.840000,-1.535000,31.540000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.490000,-1.535000,38.190000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.490000,-1.535000,41.000000>}
box{<0,0,-0.304800><2.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<12.490000,-1.535000,41.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.500000,-1.535000,17.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.000000,-1.535000,17.500000>}
box{<0,0,-0.304800><1.500000,0.035000,0.304800> rotate<0,0.000000,0> translate<11.500000,-1.535000,17.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.000000,-1.535000,29.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.000000,-1.535000,27.000000>}
box{<0,0,-0.304800><2.828427,0.035000,0.304800> rotate<0,44.997030,0> translate<11.000000,-1.535000,29.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.000000,-1.535000,25.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.000000,-1.535000,27.000000>}
box{<0,0,-0.304800><2.000000,0.035000,0.304800> rotate<0,90.000000,0> translate<13.000000,-1.535000,27.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.960000,-1.535000,31.540000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.000000,-1.535000,30.500000>}
box{<0,0,-0.304800><1.470782,0.035000,0.304800> rotate<0,44.997030,0> translate<11.960000,-1.535000,31.540000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.480000,-1.535000,18.020000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.500000,-1.535000,12.000000>}
box{<0,0,-0.152400><8.513566,0.035000,0.152400> rotate<0,44.997030,0> translate<8.480000,-1.535000,18.020000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.365000,-1.535000,17.365000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.730000,-1.535000,14.000000>}
box{<0,0,-0.304800><4.758829,0.035000,0.304800> rotate<0,44.997030,0> translate<11.365000,-1.535000,17.365000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.840000,-1.535000,24.890000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.730000,-1.535000,20.000000>}
box{<0,0,-0.304800><6.915504,0.035000,0.304800> rotate<0,44.997030,0> translate<9.840000,-1.535000,24.890000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.000000,-1.535000,27.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.730000,-1.535000,28.730000>}
box{<0,0,-0.152400><2.446589,0.035000,0.152400> rotate<0,-44.997030,0> translate<13.000000,-1.535000,27.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.500000,-1.535000,35.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.730000,-1.535000,31.270000>}
box{<0,0,-0.304800><5.982123,0.035000,0.304800> rotate<0,44.997030,0> translate<10.500000,-1.535000,35.500000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.920000,-1.535000,4.500000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.920000,-1.535000,3.580000>}
box{<0,0,-0.152400><0.920000,0.035000,0.152400> rotate<0,-90.000000,0> translate<14.920000,-1.535000,3.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.920000,-1.535000,4.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.920000,-1.535000,7.500000>}
box{<0,0,-0.304800><3.000000,0.035000,0.304800> rotate<0,90.000000,0> translate<14.920000,-1.535000,7.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.030000,-1.535000,35.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.030000,-1.535000,38.190000>}
box{<0,0,-0.304800><2.220000,0.035000,0.304800> rotate<0,90.000000,0> translate<15.030000,-1.535000,38.190000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.500000,-1.535000,12.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<15.270000,-1.535000,12.000000>}
box{<0,0,-0.152400><0.770000,0.035000,0.152400> rotate<0,0.000000,0> translate<14.500000,-1.535000,12.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.920000,-1.535000,3.580000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<15.500000,-1.535000,3.000000>}
box{<0,0,-0.152400><0.820244,0.035000,0.152400> rotate<0,44.997030,0> translate<14.920000,-1.535000,3.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.500000,-1.535000,26.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.500000,-1.535000,25.000000>}
box{<0,0,-0.304800><1.500000,0.035000,0.304800> rotate<0,-90.000000,0> translate<15.500000,-1.535000,25.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.500000,-1.535000,26.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.000000,-1.535000,27.000000>}
box{<0,0,-0.304800><0.707107,0.035000,0.304800> rotate<0,-44.997030,0> translate<15.500000,-1.535000,26.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.030000,-1.535000,35.970000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.000000,-1.535000,35.000000>}
box{<0,0,-0.304800><1.371787,0.035000,0.304800> rotate<0,44.997030,0> translate<15.030000,-1.535000,35.970000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<15.270000,-1.535000,12.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.270000,-1.535000,14.000000>}
box{<0,0,-0.152400><2.828427,0.035000,0.152400> rotate<0,-44.997030,0> translate<15.270000,-1.535000,12.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.270000,-1.535000,20.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.270000,-1.535000,14.000000>}
box{<0,0,-0.304800><6.000000,0.035000,0.304800> rotate<0,-90.000000,0> translate<17.270000,-1.535000,14.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.000000,-1.535000,25.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.270000,-1.535000,20.730000>}
box{<0,0,-0.304800><6.038692,0.035000,0.304800> rotate<0,44.997030,0> translate<13.000000,-1.535000,25.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.270000,-1.535000,20.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.270000,-1.535000,20.730000>}
box{<0,0,-0.304800><0.730000,0.035000,0.304800> rotate<0,90.000000,0> translate<17.270000,-1.535000,20.730000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.570000,-1.535000,37.430000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.570000,-1.535000,38.190000>}
box{<0,0,-0.304800><0.760000,0.035000,0.304800> rotate<0,90.000000,0> translate<17.570000,-1.535000,38.190000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.000000,-1.535000,35.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.920000,-1.535000,35.000000>}
box{<0,0,-0.304800><1.920000,0.035000,0.304800> rotate<0,0.000000,0> translate<16.000000,-1.535000,35.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.500000,-1.535000,25.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.000000,-1.535000,23.000000>}
box{<0,0,-0.304800><3.201562,0.035000,0.304800> rotate<0,38.657257,0> translate<15.500000,-1.535000,25.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.920000,-1.535000,35.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.000000,-1.535000,35.080000>}
box{<0,0,-0.304800><0.113137,0.035000,0.304800> rotate<0,-44.997030,0> translate<17.920000,-1.535000,35.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.000000,-1.535000,23.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.500000,-1.535000,23.000000>}
box{<0,0,-0.304800><0.500000,0.035000,0.304800> rotate<0,0.000000,0> translate<18.000000,-1.535000,23.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.270000,-1.535000,20.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.730000,-1.535000,20.000000>}
box{<0,0,-0.304800><1.460000,0.035000,0.304800> rotate<0,0.000000,0> translate<17.270000,-1.535000,20.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<18.000000,-1.535000,24.920000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<19.000000,-1.535000,24.920000>}
box{<0,0,-0.152400><1.000000,0.035000,0.152400> rotate<0,0.000000,0> translate<18.000000,-1.535000,24.920000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.570000,-1.535000,37.430000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.000000,-1.535000,36.000000>}
box{<0,0,-0.304800><2.022325,0.035000,0.304800> rotate<0,44.997030,0> translate<17.570000,-1.535000,37.430000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.000000,-1.535000,27.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.500000,-1.535000,27.000000>}
box{<0,0,-0.304800><3.500000,0.035000,0.304800> rotate<0,0.000000,0> translate<16.000000,-1.535000,27.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.710000,-1.535000,10.750000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.020000,-1.535000,10.750000>}
box{<0,0,-0.304800><10.310000,0.035000,0.304800> rotate<0,0.000000,0> translate<9.710000,-1.535000,10.750000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.730000,-1.535000,18.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.730000,-1.535000,14.000000>}
box{<0,0,-0.304800><4.000000,0.035000,0.304800> rotate<0,-90.000000,0> translate<20.730000,-1.535000,14.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.730000,-1.535000,20.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.730000,-1.535000,18.000000>}
box{<0,0,-0.304800><2.828427,0.035000,0.304800> rotate<0,44.997030,0> translate<18.730000,-1.535000,20.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.710000,-1.535000,9.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.000000,-1.535000,9.000000>}
box{<0,0,-0.304800><13.290000,0.035000,0.304800> rotate<0,0.000000,0> translate<7.710000,-1.535000,9.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.730000,-1.535000,28.730000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<21.000000,-1.535000,28.730000>}
box{<0,0,-0.152400><6.270000,0.035000,0.152400> rotate<0,0.000000,0> translate<14.730000,-1.535000,28.730000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.730000,-1.535000,31.270000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.000000,-1.535000,31.270000>}
box{<0,0,-0.304800><6.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<14.730000,-1.535000,31.270000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.920000,-1.535000,7.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.500000,-1.535000,7.500000>}
box{<0,0,-0.304800><6.580000,0.035000,0.304800> rotate<0,0.000000,0> translate<14.920000,-1.535000,7.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.730000,-1.535000,18.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.730000,-1.535000,20.000000>}
box{<0,0,-0.304800><2.236068,0.035000,0.304800> rotate<0,-63.430762,0> translate<20.730000,-1.535000,18.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.500000,-1.535000,27.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.000000,-1.535000,24.000000>}
box{<0,0,-0.304800><3.905125,0.035000,0.304800> rotate<0,50.191116,0> translate<19.500000,-1.535000,27.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.000000,-1.535000,24.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.000000,-1.535000,26.000000>}
box{<0,0,-0.304800><2.000000,0.035000,0.304800> rotate<0,90.000000,0> translate<22.000000,-1.535000,26.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.000000,-1.535000,31.270000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.230000,-1.535000,31.270000>}
box{<0,0,-0.304800><1.230000,0.035000,0.304800> rotate<0,0.000000,0> translate<21.000000,-1.535000,31.270000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<19.000000,-1.535000,24.920000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.920000,-1.535000,21.000000>}
box{<0,0,-0.152400><5.543717,0.035000,0.152400> rotate<0,44.997030,0> translate<19.000000,-1.535000,24.920000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.000000,-1.535000,36.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.080000,-1.535000,36.000000>}
box{<0,0,-0.304800><4.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<19.000000,-1.535000,36.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.020000,-1.535000,10.750000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.270000,-1.535000,14.000000>}
box{<0,0,-0.304800><4.596194,0.035000,0.304800> rotate<0,-44.997030,0> translate<20.020000,-1.535000,10.750000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.270000,-1.535000,14.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.270000,-1.535000,18.000000>}
box{<0,0,-0.304800><4.000000,0.035000,0.304800> rotate<0,90.000000,0> translate<23.270000,-1.535000,18.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.000000,-1.535000,26.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.500000,-1.535000,27.500000>}
box{<0,0,-0.304800><2.121320,0.035000,0.304800> rotate<0,-44.997030,0> translate<22.000000,-1.535000,26.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.230000,-1.535000,31.270000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.500000,-1.535000,30.000000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<22.230000,-1.535000,31.270000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.500000,-1.535000,27.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.500000,-1.535000,30.000000>}
box{<0,0,-0.304800><2.500000,0.035000,0.304800> rotate<0,90.000000,0> translate<23.500000,-1.535000,30.000000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.000000,-1.535000,24.000000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.000000,-1.535000,22.000000>}
box{<0,0,-0.203200><2.828427,0.035000,0.203200> rotate<0,44.997030,0> translate<22.000000,-1.535000,24.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.080000,-1.535000,36.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.000000,-1.535000,35.080000>}
box{<0,0,-0.304800><1.301076,0.035000,0.304800> rotate<0,44.997030,0> translate<23.080000,-1.535000,36.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.080000,-1.535000,4.500000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.580000,-1.535000,4.000000>}
box{<0,0,-0.152400><0.707107,0.035000,0.152400> rotate<0,44.997030,0> translate<25.080000,-1.535000,4.500000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.000000,-1.535000,24.920000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.920000,-1.535000,23.000000>}
box{<0,0,-0.152400><2.715290,0.035000,0.152400> rotate<0,44.997030,0> translate<24.000000,-1.535000,24.920000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.000000,-1.535000,9.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.000000,-1.535000,14.000000>}
box{<0,0,-0.304800><7.071068,0.035000,0.304800> rotate<0,-44.997030,0> translate<21.000000,-1.535000,9.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.730000,-1.535000,20.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.000000,-1.535000,20.000000>}
box{<0,0,-0.304800><4.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<21.730000,-1.535000,20.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.000000,-1.535000,14.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.000000,-1.535000,20.000000>}
box{<0,0,-0.304800><6.000000,0.035000,0.304800> rotate<0,90.000000,0> translate<26.000000,-1.535000,20.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<4.000000,-1.535000,49.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.000000,-1.535000,49.000000>}
box{<0,0,-0.304800><22.000000,0.035000,0.304800> rotate<0,0.000000,0> translate<4.000000,-1.535000,49.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.080000,-1.535000,7.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.080000,-1.535000,5.500000>}
box{<0,0,-0.304800><2.828427,0.035000,0.304800> rotate<0,44.997030,0> translate<25.080000,-1.535000,7.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.500000,-1.535000,18.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.500000,-1.535000,17.000000>}
box{<0,0,-0.304800><1.500000,0.035000,0.304800> rotate<0,-90.000000,0> translate<27.500000,-1.535000,17.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.000000,-1.535000,20.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.500000,-1.535000,18.500000>}
box{<0,0,-0.304800><2.121320,0.035000,0.304800> rotate<0,44.997030,0> translate<26.000000,-1.535000,20.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.500000,-1.535000,30.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.500000,-1.535000,26.000000>}
box{<0,0,-0.304800><5.656854,0.035000,0.304800> rotate<0,44.997030,0> translate<23.500000,-1.535000,30.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.500000,-1.535000,26.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.730000,-1.535000,26.000000>}
box{<0,0,-0.304800><0.230000,0.035000,0.304800> rotate<0,0.000000,0> translate<27.500000,-1.535000,26.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.730000,-1.535000,26.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.730000,-1.535000,38.190000>}
box{<0,0,-0.304800><12.190000,0.035000,0.304800> rotate<0,90.000000,0> translate<27.730000,-1.535000,38.190000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.730000,-1.535000,47.270000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.730000,-1.535000,45.810000>}
box{<0,0,-0.304800><1.460000,0.035000,0.304800> rotate<0,-90.000000,0> translate<27.730000,-1.535000,45.810000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.000000,-1.535000,49.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.730000,-1.535000,47.270000>}
box{<0,0,-0.304800><2.446589,0.035000,0.304800> rotate<0,44.997030,0> translate<26.000000,-1.535000,49.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.730000,-1.535000,38.190000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<28.000000,-1.535000,38.460000>}
box{<0,0,-0.304800><0.381838,0.035000,0.304800> rotate<0,-44.997030,0> translate<27.730000,-1.535000,38.190000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<28.000000,-1.535000,38.460000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<28.000000,-1.535000,39.000000>}
box{<0,0,-0.304800><0.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<28.000000,-1.535000,39.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.080000,-1.535000,5.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<28.230000,-1.535000,5.500000>}
box{<0,0,-0.304800><1.150000,0.035000,0.304800> rotate<0,0.000000,0> translate<27.080000,-1.535000,5.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.500000,-1.535000,10.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<28.500000,-1.535000,10.500000>}
box{<0,0,-0.304800><1.000000,0.035000,0.304800> rotate<0,0.000000,0> translate<27.500000,-1.535000,10.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.500000,-1.535000,32.730000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.500000,-1.535000,35.500000>}
box{<0,0,-0.304800><2.770000,0.035000,0.304800> rotate<0,90.000000,0> translate<29.500000,-1.535000,35.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.500000,-1.535000,7.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.000000,-1.535000,16.000000>}
box{<0,0,-0.304800><12.020815,0.035000,0.304800> rotate<0,-44.997030,0> translate<21.500000,-1.535000,7.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.270000,-1.535000,26.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.270000,-1.535000,30.540000>}
box{<0,0,-0.304800><4.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<30.270000,-1.535000,30.540000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.500000,-1.535000,35.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.270000,-1.535000,37.270000>}
box{<0,0,-0.304800><1.930233,0.035000,0.304800> rotate<0,-66.485211,0> translate<29.500000,-1.535000,35.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.270000,-1.535000,37.270000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.270000,-1.535000,38.190000>}
box{<0,0,-0.304800><0.920000,0.035000,0.304800> rotate<0,90.000000,0> translate<30.270000,-1.535000,38.190000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.500000,-1.535000,32.730000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.730000,-1.535000,31.000000>}
box{<0,0,-0.304800><2.122687,0.035000,0.304800> rotate<0,54.584230,0> translate<29.500000,-1.535000,32.730000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.270000,-1.535000,30.540000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.730000,-1.535000,31.000000>}
box{<0,0,-0.304800><0.650538,0.035000,0.304800> rotate<0,-44.997030,0> translate<30.270000,-1.535000,30.540000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.770000,-1.535000,5.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.770000,-1.535000,7.270000>}
box{<0,0,-0.304800><1.770000,0.035000,0.304800> rotate<0,90.000000,0> translate<30.770000,-1.535000,7.270000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.920000,-1.535000,21.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.000000,-1.535000,21.000000>}
box{<0,0,-0.152400><8.080000,0.035000,0.152400> rotate<0,0.000000,0> translate<22.920000,-1.535000,21.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.270000,-1.535000,26.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.000000,-1.535000,25.000000>}
box{<0,0,-0.152400><1.238103,0.035000,0.152400> rotate<0,53.867001,0> translate<30.270000,-1.535000,26.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.460000,-1.535000,32.810000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.460000,-1.535000,34.380000>}
box{<0,0,-0.304800><1.570000,0.035000,0.304800> rotate<0,90.000000,0> translate<31.460000,-1.535000,34.380000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.775000,-1.535000,20.225000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.775000,-1.535000,18.656000>}
box{<0,0,-0.152400><1.569000,0.035000,0.152400> rotate<0,-90.000000,0> translate<31.775000,-1.535000,18.656000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.000000,-1.535000,21.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.775000,-1.535000,20.225000>}
box{<0,0,-0.152400><1.096016,0.035000,0.152400> rotate<0,44.997030,0> translate<31.000000,-1.535000,21.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<28.500000,-1.535000,10.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<32.000000,-1.535000,14.000000>}
box{<0,0,-0.304800><4.949747,0.035000,0.304800> rotate<0,-44.997030,0> translate<28.500000,-1.535000,10.500000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.000000,-1.535000,22.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.000000,-1.535000,22.000000>}
box{<0,0,-0.152400><8.000000,0.035000,0.152400> rotate<0,0.000000,0> translate<24.000000,-1.535000,22.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.920000,-1.535000,23.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.000000,-1.535000,23.000000>}
box{<0,0,-0.152400><6.080000,0.035000,0.152400> rotate<0,0.000000,0> translate<25.920000,-1.535000,23.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.730000,-1.535000,31.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<32.000000,-1.535000,29.730000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<30.730000,-1.535000,31.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.770000,-1.535000,7.270000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<32.500000,-1.535000,9.000000>}
box{<0,0,-0.304800><2.446589,0.035000,0.304800> rotate<0,-44.997030,0> translate<30.770000,-1.535000,7.270000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.460000,-1.535000,34.380000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<32.810000,-1.535000,35.730000>}
box{<0,0,-0.304800><1.909188,0.035000,0.304800> rotate<0,-44.997030,0> translate<31.460000,-1.535000,34.380000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<32.810000,-1.535000,35.730000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<32.810000,-1.535000,38.190000>}
box{<0,0,-0.304800><2.460000,0.035000,0.304800> rotate<0,90.000000,0> translate<32.810000,-1.535000,38.190000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<32.000000,-1.535000,14.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.000000,-1.535000,14.000000>}
box{<0,0,-0.304800><1.000000,0.035000,0.304800> rotate<0,0.000000,0> translate<32.000000,-1.535000,14.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.000000,-1.535000,16.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.000000,-1.535000,16.000000>}
box{<0,0,-0.152400><3.000000,0.035000,0.152400> rotate<0,0.000000,0> translate<30.000000,-1.535000,16.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.075000,-1.535000,13.925000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.075000,-1.535000,11.344000>}
box{<0,0,-0.152400><2.581000,0.035000,0.152400> rotate<0,-90.000000,0> translate<33.075000,-1.535000,11.344000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.000000,-1.535000,14.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.075000,-1.535000,13.925000>}
box{<0,0,-0.152400><0.106066,0.035000,0.152400> rotate<0,44.997030,0> translate<33.000000,-1.535000,14.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.460000,-1.535000,32.810000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.270000,-1.535000,31.000000>}
box{<0,0,-0.304800><2.559727,0.035000,0.304800> rotate<0,44.997030,0> translate<31.460000,-1.535000,32.810000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.725000,-1.535000,13.725000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.725000,-1.535000,11.344000>}
box{<0,0,-0.152400><2.381000,0.035000,0.152400> rotate<0,-90.000000,0> translate<33.725000,-1.535000,11.344000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.725000,-1.535000,11.344000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.725000,-1.535000,12.725000>}
box{<0,0,-0.152400><1.381000,0.035000,0.152400> rotate<0,90.000000,0> translate<33.725000,-1.535000,12.725000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.000000,-1.535000,16.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.725000,-1.535000,16.725000>}
box{<0,0,-0.152400><1.025305,0.035000,0.152400> rotate<0,-44.997030,0> translate<33.000000,-1.535000,16.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.725000,-1.535000,16.725000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.725000,-1.535000,18.656000>}
box{<0,0,-0.152400><1.931000,0.035000,0.152400> rotate<0,90.000000,0> translate<33.725000,-1.535000,18.656000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.000000,-1.535000,22.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.725000,-1.535000,20.275000>}
box{<0,0,-0.152400><2.439518,0.035000,0.152400> rotate<0,44.997030,0> translate<32.000000,-1.535000,22.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.725000,-1.535000,18.656000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.725000,-1.535000,20.275000>}
box{<0,0,-0.152400><1.619000,0.035000,0.152400> rotate<0,90.000000,0> translate<33.725000,-1.535000,20.275000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.580000,-1.535000,4.000000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.000000,-1.535000,4.000000>}
box{<0,0,-0.203200><8.420000,0.035000,0.203200> rotate<0,0.000000,0> translate<25.580000,-1.535000,4.000000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.000000,-1.535000,4.000000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.000000,-1.535000,4.730000>}
box{<0,0,-0.203200><0.730000,0.035000,0.203200> rotate<0,90.000000,0> translate<34.000000,-1.535000,4.730000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.000000,-1.535000,14.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.000000,-1.535000,14.000000>}
box{<0,0,-0.304800><1.000000,0.035000,0.304800> rotate<0,0.000000,0> translate<33.000000,-1.535000,14.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.725000,-1.535000,13.725000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.000000,-1.535000,14.000000>}
box{<0,0,-0.152400><0.388909,0.035000,0.152400> rotate<0,-44.997030,0> translate<33.725000,-1.535000,13.725000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.375000,-1.535000,20.625000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.375000,-1.535000,18.656000>}
box{<0,0,-0.152400><1.969000,0.035000,0.152400> rotate<0,-90.000000,0> translate<34.375000,-1.535000,18.656000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.000000,-1.535000,23.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.375000,-1.535000,20.625000>}
box{<0,0,-0.152400><3.358757,0.035000,0.152400> rotate<0,44.997030,0> translate<32.000000,-1.535000,23.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.500000,-1.535000,9.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.500000,-1.535000,9.000000>}
box{<0,0,-0.152400><2.000000,0.035000,0.152400> rotate<0,0.000000,0> translate<32.500000,-1.535000,9.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.500000,-1.535000,9.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.000000,-1.535000,9.500000>}
box{<0,0,-0.152400><0.707107,0.035000,0.152400> rotate<0,-44.997030,0> translate<34.500000,-1.535000,9.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.000000,-1.535000,9.500000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.000000,-1.535000,11.319000>}
box{<0,0,-0.152400><1.819000,0.035000,0.152400> rotate<0,90.000000,0> translate<35.000000,-1.535000,11.319000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.000000,-1.535000,11.319000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.025000,-1.535000,11.344000>}
box{<0,0,-0.152400><0.035355,0.035000,0.152400> rotate<0,-44.997030,0> translate<35.000000,-1.535000,11.319000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.000000,-1.535000,7.270000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.270000,-1.535000,7.270000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<34.000000,-1.535000,7.270000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.350000,-1.535000,35.570000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.350000,-1.535000,38.190000>}
box{<0,0,-0.304800><2.620000,0.035000,0.304800> rotate<0,90.000000,0> translate<35.350000,-1.535000,38.190000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.000000,-1.535000,14.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.500000,-1.535000,14.000000>}
box{<0,0,-0.304800><1.500000,0.035000,0.304800> rotate<0,0.000000,0> translate<34.000000,-1.535000,14.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.675000,-1.535000,7.675000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.675000,-1.535000,11.344000>}
box{<0,0,-0.152400><3.669000,0.035000,0.152400> rotate<0,90.000000,0> translate<35.675000,-1.535000,11.344000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.500000,-1.535000,14.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.675000,-1.535000,14.175000>}
box{<0,0,-0.152400><0.247487,0.035000,0.152400> rotate<0,-44.997030,0> translate<35.500000,-1.535000,14.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.675000,-1.535000,14.175000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.675000,-1.535000,18.656000>}
box{<0,0,-0.152400><4.481000,0.035000,0.152400> rotate<0,90.000000,0> translate<35.675000,-1.535000,18.656000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.000000,-1.535000,25.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.675000,-1.535000,20.325000>}
box{<0,0,-0.152400><6.611448,0.035000,0.152400> rotate<0,44.997030,0> translate<31.000000,-1.535000,25.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.675000,-1.535000,18.656000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.675000,-1.535000,20.325000>}
box{<0,0,-0.152400><1.669000,0.035000,0.152400> rotate<0,90.000000,0> translate<35.675000,-1.535000,20.325000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<36.325000,-1.535000,14.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<36.325000,-1.535000,11.344000>}
box{<0,0,-0.152400><2.656000,0.035000,0.152400> rotate<0,-90.000000,0> translate<36.325000,-1.535000,11.344000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.500000,-1.535000,14.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.325000,-1.535000,14.000000>}
box{<0,0,-0.304800><0.825000,0.035000,0.304800> rotate<0,0.000000,0> translate<35.500000,-1.535000,14.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.350000,-1.535000,35.570000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.540000,-1.535000,34.380000>}
box{<0,0,-0.304800><1.682914,0.035000,0.304800> rotate<0,44.997030,0> translate<35.350000,-1.535000,35.570000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<15.500000,-1.535000,3.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.000000,-1.535000,3.000000>}
box{<0,0,-0.152400><21.500000,0.035000,0.152400> rotate<0,0.000000,0> translate<15.500000,-1.535000,3.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.000000,-1.535000,3.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.000000,-1.535000,9.500000>}
box{<0,0,-0.152400><6.500000,0.035000,0.152400> rotate<0,90.000000,0> translate<37.000000,-1.535000,9.500000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<36.975000,-1.535000,11.344000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.000000,-1.535000,11.319000>}
box{<0,0,-0.152400><0.035355,0.035000,0.152400> rotate<0,44.997030,0> translate<36.975000,-1.535000,11.344000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.000000,-1.535000,9.500000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.000000,-1.535000,11.319000>}
box{<0,0,-0.152400><1.819000,0.035000,0.152400> rotate<0,90.000000,0> translate<37.000000,-1.535000,11.319000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.000000,-1.535000,9.500000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.500000,-1.535000,9.000000>}
box{<0,0,-0.152400><0.707107,0.035000,0.152400> rotate<0,44.997030,0> translate<37.000000,-1.535000,9.500000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.500000,-1.535000,9.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.625000,-1.535000,9.125000>}
box{<0,0,-0.152400><0.176777,0.035000,0.152400> rotate<0,-44.997030,0> translate<37.500000,-1.535000,9.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.625000,-1.535000,9.125000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.625000,-1.535000,11.344000>}
box{<0,0,-0.152400><2.219000,0.035000,0.152400> rotate<0,90.000000,0> translate<37.625000,-1.535000,11.344000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.625000,-1.535000,11.344000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.625000,-1.535000,12.625000>}
box{<0,0,-0.152400><1.281000,0.035000,0.152400> rotate<0,90.000000,0> translate<37.625000,-1.535000,12.625000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.890000,-1.535000,36.110000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.890000,-1.535000,38.190000>}
box{<0,0,-0.304800><2.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<37.890000,-1.535000,38.190000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.625000,-1.535000,12.625000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.000000,-1.535000,13.000000>}
box{<0,0,-0.203200><0.530330,0.035000,0.203200> rotate<0,-44.997030,0> translate<37.625000,-1.535000,12.625000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.275000,-1.535000,9.225000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.275000,-1.535000,11.344000>}
box{<0,0,-0.152400><2.119000,0.035000,0.152400> rotate<0,90.000000,0> translate<38.275000,-1.535000,11.344000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.540000,-1.535000,34.380000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.650000,-1.535000,32.270000>}
box{<0,0,-0.304800><2.983991,0.035000,0.304800> rotate<0,44.997030,0> translate<36.540000,-1.535000,34.380000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.925000,-1.535000,9.575000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.925000,-1.535000,11.344000>}
box{<0,0,-0.152400><1.769000,0.035000,0.152400> rotate<0,90.000000,0> translate<38.925000,-1.535000,11.344000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.575000,-1.535000,9.925000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.575000,-1.535000,11.344000>}
box{<0,0,-0.152400><1.419000,0.035000,0.152400> rotate<0,90.000000,0> translate<39.575000,-1.535000,11.344000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.890000,-1.535000,36.110000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.000000,-1.535000,34.000000>}
box{<0,0,-0.304800><2.983991,0.035000,0.304800> rotate<0,44.997030,0> translate<37.890000,-1.535000,36.110000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.225000,-1.535000,10.275000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.225000,-1.535000,11.344000>}
box{<0,0,-0.152400><1.069000,0.035000,0.152400> rotate<0,90.000000,0> translate<40.225000,-1.535000,11.344000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.430000,-1.535000,37.570000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.430000,-1.535000,38.190000>}
box{<0,0,-0.304800><0.620000,0.035000,0.304800> rotate<0,90.000000,0> translate<40.430000,-1.535000,38.190000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.575000,-1.535000,9.925000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.000000,-1.535000,8.500000>}
box{<0,0,-0.152400><2.015254,0.035000,0.152400> rotate<0,44.997030,0> translate<39.575000,-1.535000,9.925000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.225000,-1.535000,10.275000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.000000,-1.535000,9.500000>}
box{<0,0,-0.152400><1.096016,0.035000,0.152400> rotate<0,44.997030,0> translate<40.225000,-1.535000,10.275000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<32.000000,-1.535000,29.730000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.000000,-1.535000,29.730000>}
box{<0,0,-0.304800><9.000000,0.035000,0.304800> rotate<0,0.000000,0> translate<32.000000,-1.535000,29.730000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.650000,-1.535000,32.270000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.000000,-1.535000,32.270000>}
box{<0,0,-0.304800><2.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<38.650000,-1.535000,32.270000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.325000,-1.535000,14.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.500000,-1.535000,14.000000>}
box{<0,0,-0.304800><5.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<36.325000,-1.535000,14.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.275000,-1.535000,9.225000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.000000,-1.535000,5.500000>}
box{<0,0,-0.152400><5.267946,0.035000,0.152400> rotate<0,44.997030,0> translate<38.275000,-1.535000,9.225000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.925000,-1.535000,9.575000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.000000,-1.535000,6.500000>}
box{<0,0,-0.152400><4.348707,0.035000,0.152400> rotate<0,44.997030,0> translate<38.925000,-1.535000,9.575000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.000000,-1.535000,34.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.000000,-1.535000,34.000000>}
box{<0,0,-0.304800><2.000000,0.035000,0.304800> rotate<0,0.000000,0> translate<40.000000,-1.535000,34.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.230000,-1.535000,4.270000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.230000,-1.535000,4.000000>}
box{<0,0,-0.152400><0.270000,0.035000,0.152400> rotate<0,-90.000000,0> translate<42.230000,-1.535000,4.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.500000,-1.535000,9.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.230000,-1.535000,4.270000>}
box{<0,0,-0.152400><6.689230,0.035000,0.152400> rotate<0,44.997030,0> translate<37.500000,-1.535000,9.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.500000,-1.535000,14.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.500000,-1.535000,15.000000>}
box{<0,0,-0.304800><1.414214,0.035000,0.304800> rotate<0,-44.997030,0> translate<41.500000,-1.535000,14.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.500000,-1.535000,20.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.500000,-1.535000,21.500000>}
box{<0,0,-0.304800><1.500000,0.035000,0.304800> rotate<0,90.000000,0> translate<42.500000,-1.535000,21.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.970000,-1.535000,37.030000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.970000,-1.535000,38.190000>}
box{<0,0,-0.304800><1.160000,0.035000,0.304800> rotate<0,90.000000,0> translate<42.970000,-1.535000,38.190000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.000000,-1.535000,13.000000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<43.000000,-1.535000,13.000000>}
box{<0,0,-0.203200><5.000000,0.035000,0.203200> rotate<0,0.000000,0> translate<38.000000,-1.535000,13.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.430000,-1.535000,37.570000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.000000,-1.535000,35.000000>}
box{<0,0,-0.304800><3.634529,0.035000,0.304800> rotate<0,44.997030,0> translate<40.430000,-1.535000,37.570000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.970000,-1.535000,37.030000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.000000,-1.535000,37.000000>}
box{<0,0,-0.304800><0.042426,0.035000,0.304800> rotate<0,44.997030,0> translate<42.970000,-1.535000,37.030000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.000000,-1.535000,5.500000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.270000,-1.535000,5.500000>}
box{<0,0,-0.152400><1.270000,0.035000,0.152400> rotate<0,0.000000,0> translate<42.000000,-1.535000,5.500000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<43.000000,-1.535000,13.000000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<43.500000,-1.535000,13.500000>}
box{<0,0,-0.203200><0.707107,0.035000,0.203200> rotate<0,-44.997030,0> translate<43.000000,-1.535000,13.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.500000,-1.535000,20.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.500000,-1.535000,19.000000>}
box{<0,0,-0.304800><1.414214,0.035000,0.304800> rotate<0,44.997030,0> translate<42.500000,-1.535000,20.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.500000,-1.535000,13.500000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.500000,-1.535000,19.000000>}
box{<0,0,-0.152400><5.500000,0.035000,0.152400> rotate<0,90.000000,0> translate<43.500000,-1.535000,19.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.000000,-1.535000,37.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.000000,-1.535000,37.000000>}
box{<0,0,-0.304800><1.000000,0.035000,0.304800> rotate<0,0.000000,0> translate<43.000000,-1.535000,37.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.000000,-1.535000,35.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.080000,-1.535000,35.000000>}
box{<0,0,-0.304800><1.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<43.000000,-1.535000,35.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.000000,-1.535000,34.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.500000,-1.535000,31.500000>}
box{<0,0,-0.304800><3.535534,0.035000,0.304800> rotate<0,44.997030,0> translate<42.000000,-1.535000,34.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.500000,-1.535000,13.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.500000,-1.535000,31.500000>}
box{<0,0,-0.304800><18.000000,0.035000,0.304800> rotate<0,90.000000,0> translate<44.500000,-1.535000,31.500000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.270000,-1.535000,5.500000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.770000,-1.535000,4.000000>}
box{<0,0,-0.152400><2.121320,0.035000,0.152400> rotate<0,44.997030,0> translate<43.270000,-1.535000,5.500000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.270000,-1.535000,5.500000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.000000,-1.535000,5.500000>}
box{<0,0,-0.152400><1.730000,0.035000,0.152400> rotate<0,0.000000,0> translate<43.270000,-1.535000,5.500000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.000000,-1.535000,6.500000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.500000,-1.535000,6.500000>}
box{<0,0,-0.152400><3.500000,0.035000,0.152400> rotate<0,0.000000,0> translate<42.000000,-1.535000,6.500000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.730000,-1.535000,18.000000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.000000,-1.535000,18.000000>}
box{<0,0,-0.203200><0.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<45.730000,-1.535000,18.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.080000,-1.535000,35.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.000000,-1.535000,33.080000>}
box{<0,0,-0.304800><2.715290,0.035000,0.304800> rotate<0,44.997030,0> translate<44.080000,-1.535000,35.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.000000,-1.535000,37.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.000000,-1.535000,35.000000>}
box{<0,0,-0.304800><2.828427,0.035000,0.304800> rotate<0,44.997030,0> translate<44.000000,-1.535000,37.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.000000,-1.535000,5.500000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.500000,-1.535000,4.000000>}
box{<0,0,-0.152400><2.121320,0.035000,0.152400> rotate<0,44.997030,0> translate<45.000000,-1.535000,5.500000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.000000,-1.535000,8.500000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.500000,-1.535000,8.500000>}
box{<0,0,-0.152400><5.500000,0.035000,0.152400> rotate<0,0.000000,0> translate<41.000000,-1.535000,8.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.510000,-1.535000,38.190000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.890000,-1.535000,38.190000>}
box{<0,0,-0.304800><1.380000,0.035000,0.304800> rotate<0,0.000000,0> translate<45.510000,-1.535000,38.190000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.000000,-1.535000,9.500000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.000000,-1.535000,9.500000>}
box{<0,0,-0.152400><6.000000,0.035000,0.152400> rotate<0,0.000000,0> translate<41.000000,-1.535000,9.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.000000,-1.535000,15.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.000000,-1.535000,15.000000>}
box{<0,0,-0.304800><1.000000,0.035000,0.304800> rotate<0,0.000000,0> translate<46.000000,-1.535000,15.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.000000,-1.535000,13.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.000000,-1.535000,15.000000>}
box{<0,0,-0.304800><2.000000,0.035000,0.304800> rotate<0,90.000000,0> translate<47.000000,-1.535000,15.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.000000,-1.535000,18.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.000000,-1.535000,17.000000>}
box{<0,0,-0.304800><1.414214,0.035000,0.304800> rotate<0,44.997030,0> translate<46.000000,-1.535000,18.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.000000,-1.535000,15.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.000000,-1.535000,17.000000>}
box{<0,0,-0.304800><2.000000,0.035000,0.304800> rotate<0,90.000000,0> translate<47.000000,-1.535000,17.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.490000,-1.535000,41.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.000000,-1.535000,41.000000>}
box{<0,0,-0.304800><34.510000,0.035000,0.304800> rotate<0,0.000000,0> translate<12.490000,-1.535000,41.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.000000,-1.535000,35.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.080000,-1.535000,35.000000>}
box{<0,0,-0.304800><1.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<46.000000,-1.535000,35.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<3.500000,-1.535000,2.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.000000,-1.535000,2.000000>}
box{<0,0,-0.152400><44.500000,0.035000,0.152400> rotate<0,0.000000,0> translate<3.500000,-1.535000,2.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.500000,-1.535000,8.500000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.000000,-1.535000,7.000000>}
box{<0,0,-0.152400><2.121320,0.035000,0.152400> rotate<0,44.997030,0> translate<46.500000,-1.535000,8.500000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.000000,-1.535000,2.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.000000,-1.535000,7.000000>}
box{<0,0,-0.152400><5.000000,0.035000,0.152400> rotate<0,90.000000,0> translate<48.000000,-1.535000,7.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.270000,-1.535000,13.650000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.270000,-1.535000,18.000000>}
box{<0,0,-0.304800><4.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<48.270000,-1.535000,18.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.000000,-1.535000,41.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.500000,-1.535000,42.500000>}
box{<0,0,-0.304800><2.121320,0.035000,0.304800> rotate<0,-44.997030,0> translate<47.000000,-1.535000,41.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.500000,-1.535000,42.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.500000,-1.535000,48.000000>}
box{<0,0,-0.304800><5.500000,0.035000,0.304800> rotate<0,90.000000,0> translate<48.500000,-1.535000,48.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<3.000000,-1.535000,1.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.000000,-1.535000,1.000000>}
box{<0,0,-0.152400><46.000000,0.035000,0.152400> rotate<0,0.000000,0> translate<3.000000,-1.535000,1.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.000000,-1.535000,9.500000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.000000,-1.535000,7.500000>}
box{<0,0,-0.152400><2.828427,0.035000,0.152400> rotate<0,44.997030,0> translate<47.000000,-1.535000,9.500000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.000000,-1.535000,1.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.000000,-1.535000,7.500000>}
box{<0,0,-0.152400><6.500000,0.035000,0.152400> rotate<0,90.000000,0> translate<49.000000,-1.535000,7.500000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.000000,-1.535000,21.000000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.000000,-1.535000,22.920000>}
box{<0,0,-0.203200><1.920000,0.035000,0.203200> rotate<0,90.000000,0> translate<49.000000,-1.535000,22.920000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.080000,-1.535000,35.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.000000,-1.535000,33.080000>}
box{<0,0,-0.304800><2.715290,0.035000,0.304800> rotate<0,44.997030,0> translate<47.080000,-1.535000,35.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.000000,-1.535000,38.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.000000,-1.535000,41.000000>}
box{<0,0,-0.304800><3.000000,0.035000,0.304800> rotate<0,90.000000,0> translate<49.000000,-1.535000,41.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.500000,-1.535000,48.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.500000,-1.535000,49.000000>}
box{<0,0,-0.304800><1.414214,0.035000,0.304800> rotate<0,-44.997030,0> translate<48.500000,-1.535000,48.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.500000,-1.535000,13.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.000000,-1.535000,8.000000>}
box{<0,0,-0.304800><7.778175,0.035000,0.304800> rotate<0,44.997030,0> translate<44.500000,-1.535000,13.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.000000,-1.535000,2.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.000000,-1.535000,8.000000>}
box{<0,0,-0.304800><5.580000,0.035000,0.304800> rotate<0,90.000000,0> translate<50.000000,-1.535000,8.000000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.000000,-1.535000,22.920000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.000000,-1.535000,18.420000>}
box{<0,0,-0.203200><6.020797,0.035000,0.203200> rotate<0,48.363269,0> translate<46.000000,-1.535000,22.920000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.000000,-1.535000,14.500000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.000000,-1.535000,18.420000>}
box{<0,0,-0.203200><3.920000,0.035000,0.203200> rotate<0,90.000000,0> translate<50.000000,-1.535000,18.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.000000,-1.535000,2.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.420000,-1.535000,2.000000>}
box{<0,0,-0.304800><0.593970,0.035000,0.304800> rotate<0,44.997030,0> translate<50.000000,-1.535000,2.420000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.500000,-1.535000,21.580000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.500000,-1.535000,24.000000>}
box{<0,0,-0.203200><2.420000,0.035000,0.203200> rotate<0,90.000000,0> translate<50.500000,-1.535000,24.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.920000,-1.535000,43.810000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.920000,-1.535000,47.000000>}
box{<0,0,-0.304800><3.190000,0.035000,0.304800> rotate<0,90.000000,0> translate<50.920000,-1.535000,47.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.920000,-1.535000,47.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.920000,-1.535000,47.080000>}
box{<0,0,-0.304800><0.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<50.920000,-1.535000,47.080000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.000000,-1.535000,41.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.365000,-1.535000,43.365000>}
box{<0,0,-0.304800><3.344615,0.035000,0.304800> rotate<0,-44.997030,0> translate<49.000000,-1.535000,41.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.920000,-1.535000,43.810000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.365000,-1.535000,43.365000>}
box{<0,0,-0.304800><0.629325,0.035000,0.304800> rotate<0,44.997030,0> translate<50.920000,-1.535000,43.810000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.500000,-1.535000,4.000000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.500000,-1.535000,7.500000>}
box{<0,0,-0.152400><3.500000,0.035000,0.152400> rotate<0,90.000000,0> translate<51.500000,-1.535000,7.500000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.000000,-1.535000,21.000000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.500000,-1.535000,18.500000>}
box{<0,0,-0.203200><3.535534,0.035000,0.203200> rotate<0,44.997030,0> translate<49.000000,-1.535000,21.000000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.500000,-1.535000,14.500000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.500000,-1.535000,18.500000>}
box{<0,0,-0.203200><4.000000,0.035000,0.203200> rotate<0,90.000000,0> translate<51.500000,-1.535000,18.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.365000,-1.535000,43.365000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.730000,-1.535000,43.000000>}
box{<0,0,-0.304800><0.516188,0.035000,0.304800> rotate<0,44.997030,0> translate<51.365000,-1.535000,43.365000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.000000,-1.535000,13.000000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.000000,-1.535000,8.000000>}
box{<0,0,-0.203200><7.071068,0.035000,0.203200> rotate<0,44.997030,0> translate<47.000000,-1.535000,13.000000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.500000,-1.535000,7.500000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.000000,-1.535000,8.000000>}
box{<0,0,-0.152400><0.707107,0.035000,0.152400> rotate<0,-44.997030,0> translate<51.500000,-1.535000,7.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.270000,-1.535000,13.650000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.000000,-1.535000,9.920000>}
box{<0,0,-0.304800><5.275017,0.035000,0.304800> rotate<0,44.997030,0> translate<48.270000,-1.535000,13.650000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.500000,-1.535000,21.580000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.000000,-1.535000,20.080000>}
box{<0,0,-0.203200><2.121320,0.035000,0.203200> rotate<0,44.997030,0> translate<50.500000,-1.535000,21.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.890000,-1.535000,38.190000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.000000,-1.535000,33.080000>}
box{<0,0,-0.304800><7.226631,0.035000,0.304800> rotate<0,44.997030,0> translate<46.890000,-1.535000,38.190000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.000000,-1.535000,38.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.000000,-1.535000,35.000000>}
box{<0,0,-0.304800><4.242641,0.035000,0.304800> rotate<0,44.997030,0> translate<49.000000,-1.535000,38.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.920000,-1.535000,38.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.000000,-1.535000,38.000000>}
box{<0,0,-0.304800><1.190126,0.035000,0.304800> rotate<0,24.840750,0> translate<50.920000,-1.535000,38.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.000000,-1.535000,22.920000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.080000,-1.535000,23.000000>}
box{<0,0,-0.304800><0.113137,0.035000,0.304800> rotate<0,-44.997030,0> translate<52.000000,-1.535000,22.920000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.000000,-1.535000,8.000000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.500000,-1.535000,8.000000>}
box{<0,0,-0.203200><0.500000,0.035000,0.203200> rotate<0,0.000000,0> translate<52.000000,-1.535000,8.000000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.000000,-1.535000,14.500000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.500000,-1.535000,12.000000>}
box{<0,0,-0.203200><3.535534,0.035000,0.203200> rotate<0,44.997030,0> translate<50.000000,-1.535000,14.500000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.500000,-1.535000,14.500000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.000000,-1.535000,13.000000>}
box{<0,0,-0.203200><2.121320,0.035000,0.203200> rotate<0,44.997030,0> translate<51.500000,-1.535000,14.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.000000,-1.535000,35.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.000000,-1.535000,35.000000>}
box{<0,0,-0.304800><1.000000,0.035000,0.304800> rotate<0,0.000000,0> translate<52.000000,-1.535000,35.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.000000,-1.535000,20.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.420000,-1.535000,21.500000>}
box{<0,0,-0.304800><2.008183,0.035000,0.304800> rotate<0,-44.997030,0> translate<52.000000,-1.535000,20.080000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.420000,-1.535000,21.500000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.500000,-1.535000,21.500000>}
box{<0,0,-0.152400><0.080000,0.035000,0.152400> rotate<0,0.000000,0> translate<53.420000,-1.535000,21.500000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.500000,-1.535000,8.000000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.000000,-1.535000,9.500000>}
box{<0,0,-0.203200><2.121320,0.035000,0.203200> rotate<0,-44.997030,0> translate<52.500000,-1.535000,8.000000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.000000,-1.535000,9.500000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.000000,-1.535000,10.500000>}
box{<0,0,-0.203200><1.000000,0.035000,0.203200> rotate<0,90.000000,0> translate<54.000000,-1.535000,10.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.000000,-1.535000,18.270000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.000000,-1.535000,14.500000>}
box{<0,0,-0.304800><3.770000,0.035000,0.304800> rotate<0,-90.000000,0> translate<54.000000,-1.535000,14.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.080000,-1.535000,23.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.000000,-1.535000,23.000000>}
box{<0,0,-0.304800><1.920000,0.035000,0.304800> rotate<0,0.000000,0> translate<52.080000,-1.535000,23.000000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.500000,-1.535000,24.000000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.500000,-1.535000,28.000000>}
box{<0,0,-0.203200><5.656854,0.035000,0.203200> rotate<0,-44.997030,0> translate<50.500000,-1.535000,24.000000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.000000,-1.535000,6.500000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.500000,-1.535000,9.000000>}
box{<0,0,-0.203200><3.535534,0.035000,0.203200> rotate<0,-44.997030,0> translate<53.000000,-1.535000,6.500000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.500000,-1.535000,9.000000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.500000,-1.535000,10.500000>}
box{<0,0,-0.203200><1.500000,0.035000,0.203200> rotate<0,90.000000,0> translate<55.500000,-1.535000,10.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.500000,-1.535000,14.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.500000,-1.535000,17.230000>}
box{<0,0,-0.304800><2.730000,0.035000,0.304800> rotate<0,90.000000,0> translate<55.500000,-1.535000,17.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.000000,-1.535000,18.270000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.730000,-1.535000,20.000000>}
box{<0,0,-0.304800><2.446589,0.035000,0.304800> rotate<0,-44.997030,0> translate<54.000000,-1.535000,18.270000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.730000,-1.535000,20.730000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.730000,-1.535000,20.000000>}
box{<0,0,-0.203200><0.730000,0.035000,0.203200> rotate<0,-90.000000,0> translate<55.730000,-1.535000,20.000000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.500000,-1.535000,12.000000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.000000,-1.535000,12.000000>}
box{<0,0,-0.203200><3.500000,0.035000,0.203200> rotate<0,0.000000,0> translate<52.500000,-1.535000,12.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.000000,-1.535000,35.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.000000,-1.535000,32.000000>}
box{<0,0,-0.304800><4.242641,0.035000,0.304800> rotate<0,44.997030,0> translate<53.000000,-1.535000,35.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.000000,-1.535000,38.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.190000,-1.535000,33.810000>}
box{<0,0,-0.304800><5.925555,0.035000,0.304800> rotate<0,44.997030,0> translate<52.000000,-1.535000,38.000000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.730000,-1.535000,11.270000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.730000,-1.535000,8.000000>}
box{<0,0,-0.203200><3.270000,0.035000,0.203200> rotate<0,-90.000000,0> translate<56.730000,-1.535000,8.000000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.000000,-1.535000,12.000000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.730000,-1.535000,11.270000>}
box{<0,0,-0.203200><1.032376,0.035000,0.203200> rotate<0,44.997030,0> translate<56.000000,-1.535000,12.000000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.000000,-1.535000,13.000000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.730000,-1.535000,13.000000>}
box{<0,0,-0.203200><3.730000,0.035000,0.203200> rotate<0,0.000000,0> translate<53.000000,-1.535000,13.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.000000,-1.535000,23.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.730000,-1.535000,25.730000>}
box{<0,0,-0.304800><3.860803,0.035000,0.304800> rotate<0,-44.997030,0> translate<54.000000,-1.535000,23.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.730000,-1.535000,25.730000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.730000,-1.535000,26.190000>}
box{<0,0,-0.304800><0.460000,0.035000,0.304800> rotate<0,90.000000,0> translate<56.730000,-1.535000,26.190000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.190000,-1.535000,33.810000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.730000,-1.535000,33.810000>}
box{<0,0,-0.304800><0.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<56.190000,-1.535000,33.810000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.000000,-1.535000,38.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.000000,-1.535000,43.000000>}
box{<0,0,-0.304800><5.000000,0.035000,0.304800> rotate<0,90.000000,0> translate<57.000000,-1.535000,43.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.270000,-1.535000,43.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.270000,-1.535000,46.000000>}
box{<0,0,-0.304800><4.242641,0.035000,0.304800> rotate<0,-44.997030,0> translate<54.270000,-1.535000,43.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.500000,-1.535000,17.230000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.270000,-1.535000,20.000000>}
box{<0,0,-0.304800><3.917372,0.035000,0.304800> rotate<0,-44.997030,0> translate<55.500000,-1.535000,17.230000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.000000,-1.535000,38.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.000000,-1.535000,36.000000>}
box{<0,0,-0.304800><2.828427,0.035000,0.304800> rotate<0,44.997030,0> translate<57.000000,-1.535000,38.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.000000,-1.535000,34.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.000000,-1.535000,36.000000>}
box{<0,0,-0.304800><1.920000,0.035000,0.304800> rotate<0,90.000000,0> translate<59.000000,-1.535000,36.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.270000,-1.535000,8.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.270000,-1.535000,13.000000>}
box{<0,0,-0.304800><5.000000,0.035000,0.304800> rotate<0,90.000000,0> translate<59.270000,-1.535000,13.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.730000,-1.535000,20.730000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.270000,-1.535000,24.270000>}
box{<0,0,-0.304800><5.006316,0.035000,0.304800> rotate<0,-44.997030,0> translate<55.730000,-1.535000,20.730000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.270000,-1.535000,25.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.270000,-1.535000,24.270000>}
box{<0,0,-0.304800><0.730000,0.035000,0.304800> rotate<0,-90.000000,0> translate<59.270000,-1.535000,24.270000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.270000,-1.535000,25.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.270000,-1.535000,26.190000>}
box{<0,0,-0.304800><1.190000,0.035000,0.304800> rotate<0,90.000000,0> translate<59.270000,-1.535000,26.190000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.000000,-1.535000,34.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.270000,-1.535000,33.810000>}
box{<0,0,-0.304800><0.381838,0.035000,0.304800> rotate<0,44.997030,0> translate<59.000000,-1.535000,34.080000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.000000,-1.535000,41.730000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.270000,-1.535000,41.730000>}
box{<0,0,-0.304800><0.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<59.000000,-1.535000,41.730000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.270000,-1.535000,25.000000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.000000,-1.535000,25.000000>}
box{<0,0,-0.203200><0.730000,0.035000,0.203200> rotate<0,0.000000,0> translate<59.270000,-1.535000,25.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.000000,-1.535000,16.291200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.000000,-1.535000,25.000000>}
box{<0,0,-0.304800><8.708800,0.035000,0.304800> rotate<0,90.000000,0> translate<60.000000,-1.535000,25.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.270000,-1.535000,8.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.009400,-1.535000,7.260600>}
box{<0,0,-0.304800><1.045670,0.035000,0.304800> rotate<0,44.997030,0> translate<59.270000,-1.535000,8.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.270000,-1.535000,46.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.270000,-1.535000,46.000000>}
box{<0,0,-0.304800><3.000000,0.035000,0.304800> rotate<0,0.000000,0> translate<57.270000,-1.535000,46.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.000000,-1.535000,44.270000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.270000,-1.535000,46.000000>}
box{<0,0,-0.304800><2.146113,0.035000,0.304800> rotate<0,-53.713912,0> translate<59.000000,-1.535000,44.270000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.270000,-1.535000,46.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.270000,-1.535000,47.190000>}
box{<0,0,-0.304800><1.190000,0.035000,0.304800> rotate<0,90.000000,0> translate<60.270000,-1.535000,47.190000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.500000,-1.535000,28.000000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.500000,-1.535000,28.000000>}
box{<0,0,-0.203200><6.000000,0.035000,0.203200> rotate<0,0.000000,0> translate<54.500000,-1.535000,28.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.270000,-1.535000,41.730000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.500000,-1.535000,40.500000>}
box{<0,0,-0.304800><1.739483,0.035000,0.304800> rotate<0,44.997030,0> translate<59.270000,-1.535000,41.730000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.000000,-1.535000,43.000000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.905000,-1.535000,43.000000>}
box{<0,0,-0.203200><3.905000,0.035000,0.203200> rotate<0,0.000000,0> translate<57.000000,-1.535000,43.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.000000,-1.535000,32.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.000000,-1.535000,30.000000>}
box{<0,0,-0.304800><2.000000,0.035000,0.304800> rotate<0,-90.000000,0> translate<61.000000,-1.535000,30.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.000000,-1.535000,32.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.000000,-1.535000,32.000000>}
box{<0,0,-0.304800><5.000000,0.035000,0.304800> rotate<0,0.000000,0> translate<56.000000,-1.535000,32.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.000000,-1.535000,32.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.080000,-1.535000,32.080000>}
box{<0,0,-0.304800><0.113137,0.035000,0.304800> rotate<0,-44.997030,0> translate<61.000000,-1.535000,32.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.080000,-1.535000,32.080000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.080000,-1.535000,38.500000>}
box{<0,0,-0.304800><6.420000,0.035000,0.304800> rotate<0,90.000000,0> translate<61.080000,-1.535000,38.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.270000,-1.535000,47.190000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.080000,-1.535000,47.000000>}
box{<0,0,-0.304800><0.831986,0.035000,0.304800> rotate<0,13.200216,0> translate<60.270000,-1.535000,47.190000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.580000,-1.535000,2.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.319400,-1.535000,2.739400>}
box{<0,0,-0.304800><1.045670,0.035000,0.304800> rotate<0,-44.997030,0> translate<60.580000,-1.535000,2.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.500000,-1.535000,40.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.500000,-1.535000,40.500000>}
box{<0,0,-0.304800><1.000000,0.035000,0.304800> rotate<0,0.000000,0> translate<60.500000,-1.535000,40.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.270000,-1.535000,13.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.530600,-1.535000,15.260600>}
box{<0,0,-0.304800><3.196971,0.035000,0.304800> rotate<0,-44.997030,0> translate<59.270000,-1.535000,13.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.000000,-1.535000,16.291200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.530600,-1.535000,15.260600>}
box{<0,0,-0.304800><1.845230,0.035000,0.304800> rotate<0,33.951353,0> translate<60.000000,-1.535000,16.291200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.920000,-1.535000,23.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.920000,-1.535000,19.000000>}
box{<0,0,-0.304800><4.000000,0.035000,0.304800> rotate<0,-90.000000,0> translate<61.920000,-1.535000,19.000000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.920000,-1.535000,26.580000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.920000,-1.535000,23.000000>}
box{<0,0,-0.203200><3.580000,0.035000,0.203200> rotate<0,-90.000000,0> translate<61.920000,-1.535000,23.000000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.500000,-1.535000,28.000000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.920000,-1.535000,26.580000>}
box{<0,0,-0.203200><2.008183,0.035000,0.203200> rotate<0,44.997030,0> translate<60.500000,-1.535000,28.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.500000,-1.535000,40.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.000000,-1.535000,39.000000>}
box{<0,0,-0.304800><2.121320,0.035000,0.304800> rotate<0,44.997030,0> translate<61.500000,-1.535000,40.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.000000,-1.535000,32.825000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.000000,-1.535000,39.000000>}
box{<0,0,-0.304800><6.175000,0.035000,0.304800> rotate<0,90.000000,0> translate<63.000000,-1.535000,39.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.319400,-1.535000,2.739400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.748800,-1.535000,2.739400>}
box{<0,0,-0.304800><2.429400,0.035000,0.304800> rotate<0,0.000000,0> translate<61.319400,-1.535000,2.739400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.009400,-1.535000,7.260600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.748800,-1.535000,7.260600>}
box{<0,0,-0.304800><3.739400,0.035000,0.304800> rotate<0,0.000000,0> translate<60.009400,-1.535000,7.260600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.748800,-1.535000,10.739400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.748800,-1.535000,10.748800>}
box{<0,0,-0.304800><0.009400,0.035000,0.304800> rotate<0,90.000000,0> translate<63.748800,-1.535000,10.748800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.530600,-1.535000,15.260600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.748800,-1.535000,15.260600>}
box{<0,0,-0.304800><2.218200,0.035000,0.304800> rotate<0,0.000000,0> translate<61.530600,-1.535000,15.260600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.000000,-1.535000,30.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.500000,-1.535000,26.500000>}
box{<0,0,-0.304800><4.949747,0.035000,0.304800> rotate<0,44.997030,0> translate<61.000000,-1.535000,30.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.080000,-1.535000,47.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.905000,-1.535000,47.000000>}
box{<0,0,-0.304800><4.825000,0.035000,0.304800> rotate<0,0.000000,0> translate<61.080000,-1.535000,47.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.000000,-1.535000,32.825000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.365000,-1.535000,28.460000>}
box{<0,0,-0.304800><6.173042,0.035000,0.304800> rotate<0,44.997030,0> translate<63.000000,-1.535000,32.825000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.365000,-1.535000,33.540000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.365000,-1.535000,40.460000>}
box{<0,0,-0.304800><6.920000,0.035000,0.304800> rotate<0,90.000000,0> translate<67.365000,-1.535000,40.460000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.905000,-1.535000,47.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.365000,-1.535000,45.540000>}
box{<0,0,-0.304800><2.064752,0.035000,0.304800> rotate<0,44.997030,0> translate<65.905000,-1.535000,47.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.365000,-1.535000,33.540000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.960000,-1.535000,33.540000>}
box{<0,0,-0.304800><0.595000,0.035000,0.304800> rotate<0,0.000000,0> translate<67.365000,-1.535000,33.540000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.748800,-1.535000,2.739400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.251200,-1.535000,2.739400>}
box{<0,0,-0.304800><6.502400,0.035000,0.304800> rotate<0,0.000000,0> translate<63.748800,-1.535000,2.739400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.748800,-1.535000,7.260600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.251200,-1.535000,7.260600>}
box{<0,0,-0.304800><6.502400,0.035000,0.304800> rotate<0,0.000000,0> translate<63.748800,-1.535000,7.260600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.748800,-1.535000,10.739400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.251200,-1.535000,10.739400>}
box{<0,0,-0.304800><6.502400,0.035000,0.304800> rotate<0,0.000000,0> translate<63.748800,-1.535000,10.739400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.748800,-1.535000,15.260600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.251200,-1.535000,15.260600>}
box{<0,0,-0.304800><6.502400,0.035000,0.304800> rotate<0,0.000000,0> translate<63.748800,-1.535000,15.260600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.500000,-1.535000,26.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.500000,-1.535000,26.500000>}
box{<0,0,-0.304800><6.000000,0.035000,0.304800> rotate<0,0.000000,0> translate<64.500000,-1.535000,26.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.960000,-1.535000,33.540000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.500000,-1.535000,31.000000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<67.960000,-1.535000,33.540000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.500000,-1.535000,26.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.500000,-1.535000,31.000000>}
box{<0,0,-0.304800><4.500000,0.035000,0.304800> rotate<0,90.000000,0> translate<70.500000,-1.535000,31.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.080000,-1.535000,19.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.080000,-1.535000,18.920000>}
box{<0,0,-0.304800><0.080000,0.035000,0.304800> rotate<0,-90.000000,0> translate<72.080000,-1.535000,18.920000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.080000,-1.535000,23.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.080000,-1.535000,19.000000>}
box{<0,0,-0.304800><4.000000,0.035000,0.304800> rotate<0,-90.000000,0> translate<72.080000,-1.535000,19.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.251200,-1.535000,10.739400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.000000,-1.535000,13.488200>}
box{<0,0,-0.304800><3.887390,0.035000,0.304800> rotate<0,-44.997030,0> translate<70.251200,-1.535000,10.739400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.000000,-1.535000,18.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.000000,-1.535000,13.488200>}
box{<0,0,-0.304800><4.511800,0.035000,0.304800> rotate<0,-90.000000,0> translate<73.000000,-1.535000,13.488200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.080000,-1.535000,18.920000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.000000,-1.535000,18.000000>}
box{<0,0,-0.304800><1.301076,0.035000,0.304800> rotate<0,44.997030,0> translate<72.080000,-1.535000,18.920000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.080000,-1.535000,23.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.500000,-1.535000,24.420000>}
box{<0,0,-0.304800><2.008183,0.035000,0.304800> rotate<0,-44.997030,0> translate<72.080000,-1.535000,23.000000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.500000,-1.535000,49.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.500000,-1.535000,24.420000>}
box{<0,0,-0.304800><24.580000,0.035000,0.304800> rotate<0,-90.000000,0> translate<73.500000,-1.535000,24.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.500000,-1.535000,49.000000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.500000,-1.535000,49.000000>}
box{<0,0,-0.304800><24.000000,0.035000,0.304800> rotate<0,0.000000,0> translate<49.500000,-1.535000,49.000000> }
object{ARC(0.405000,0.304800,270.000000,360.000000,0.036000) translate<35.270000,-1.535000,7.675000>}
//Text
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<46.923800,-1.535000,43.703100>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<46.923800,-1.535000,42.076200>}
box{<0,0,-0.076200><1.626900,0.035000,0.076200> rotate<0,-90.000000,0> translate<46.923800,-1.535000,42.076200> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<46.923800,-1.535000,42.076200>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<46.381500,-1.535000,42.618500>}
box{<0,0,-0.076200><0.766928,0.035000,0.076200> rotate<0,44.997030,0> translate<46.381500,-1.535000,42.618500> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<46.381500,-1.535000,42.618500>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<45.839200,-1.535000,42.076200>}
box{<0,0,-0.076200><0.766928,0.035000,0.076200> rotate<0,-44.997030,0> translate<45.839200,-1.535000,42.076200> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<45.839200,-1.535000,42.076200>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<45.839200,-1.535000,43.703100>}
box{<0,0,-0.076200><1.626900,0.035000,0.076200> rotate<0,90.000000,0> translate<45.839200,-1.535000,43.703100> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<45.015600,-1.535000,42.076200>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<44.473300,-1.535000,42.076200>}
box{<0,0,-0.076200><0.542300,0.035000,0.076200> rotate<0,0.000000,0> translate<44.473300,-1.535000,42.076200> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<44.473300,-1.535000,42.076200>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<44.202100,-1.535000,42.347300>}
box{<0,0,-0.076200><0.383464,0.035000,0.076200> rotate<0,44.986466,0> translate<44.202100,-1.535000,42.347300> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<44.202100,-1.535000,42.347300>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<44.202100,-1.535000,42.889600>}
box{<0,0,-0.076200><0.542300,0.035000,0.076200> rotate<0,90.000000,0> translate<44.202100,-1.535000,42.889600> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<44.202100,-1.535000,42.889600>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<44.473300,-1.535000,43.160800>}
box{<0,0,-0.076200><0.383535,0.035000,0.076200> rotate<0,-44.997030,0> translate<44.202100,-1.535000,42.889600> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<44.473300,-1.535000,43.160800>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<45.015600,-1.535000,43.160800>}
box{<0,0,-0.076200><0.542300,0.035000,0.076200> rotate<0,0.000000,0> translate<44.473300,-1.535000,43.160800> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<45.015600,-1.535000,43.160800>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<45.286700,-1.535000,42.889600>}
box{<0,0,-0.076200><0.383464,0.035000,0.076200> rotate<0,45.007595,0> translate<45.015600,-1.535000,43.160800> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<45.286700,-1.535000,42.889600>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<45.286700,-1.535000,42.347300>}
box{<0,0,-0.076200><0.542300,0.035000,0.076200> rotate<0,-90.000000,0> translate<45.286700,-1.535000,42.347300> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<45.286700,-1.535000,42.347300>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<45.015600,-1.535000,42.076200>}
box{<0,0,-0.076200><0.383393,0.035000,0.076200> rotate<0,-44.997030,0> translate<45.015600,-1.535000,42.076200> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<43.649600,-1.535000,41.533900>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<43.378500,-1.535000,41.533900>}
box{<0,0,-0.076200><0.271100,0.035000,0.076200> rotate<0,0.000000,0> translate<43.378500,-1.535000,41.533900> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<43.378500,-1.535000,41.533900>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<43.107300,-1.535000,41.805100>}
box{<0,0,-0.076200><0.383535,0.035000,0.076200> rotate<0,44.997030,0> translate<43.107300,-1.535000,41.805100> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<43.107300,-1.535000,41.805100>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<43.107300,-1.535000,43.160800>}
box{<0,0,-0.076200><1.355700,0.035000,0.076200> rotate<0,90.000000,0> translate<43.107300,-1.535000,43.160800> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<43.107300,-1.535000,43.974300>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<43.107300,-1.535000,43.703100>}
box{<0,0,-0.076200><0.271200,0.035000,0.076200> rotate<0,-90.000000,0> translate<43.107300,-1.535000,43.703100> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<41.473600,-1.535000,43.160800>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<42.287100,-1.535000,43.160800>}
box{<0,0,-0.076200><0.813500,0.035000,0.076200> rotate<0,0.000000,0> translate<41.473600,-1.535000,43.160800> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<42.287100,-1.535000,43.160800>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<42.558200,-1.535000,42.889600>}
box{<0,0,-0.076200><0.383464,0.035000,0.076200> rotate<0,45.007595,0> translate<42.287100,-1.535000,43.160800> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<42.558200,-1.535000,42.889600>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<42.558200,-1.535000,42.347300>}
box{<0,0,-0.076200><0.542300,0.035000,0.076200> rotate<0,-90.000000,0> translate<42.558200,-1.535000,42.347300> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<42.558200,-1.535000,42.347300>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<42.287100,-1.535000,42.076200>}
box{<0,0,-0.076200><0.383393,0.035000,0.076200> rotate<0,-44.997030,0> translate<42.287100,-1.535000,42.076200> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<42.287100,-1.535000,42.076200>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<41.473600,-1.535000,42.076200>}
box{<0,0,-0.076200><0.813500,0.035000,0.076200> rotate<0,0.000000,0> translate<41.473600,-1.535000,42.076200> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<40.921100,-1.535000,43.160800>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<40.650000,-1.535000,43.160800>}
box{<0,0,-0.076200><0.271100,0.035000,0.076200> rotate<0,0.000000,0> translate<40.650000,-1.535000,43.160800> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<40.650000,-1.535000,43.160800>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<40.650000,-1.535000,42.076200>}
box{<0,0,-0.076200><1.084600,0.035000,0.076200> rotate<0,-90.000000,0> translate<40.650000,-1.535000,42.076200> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<40.921100,-1.535000,42.076200>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<40.378800,-1.535000,42.076200>}
box{<0,0,-0.076200><0.542300,0.035000,0.076200> rotate<0,0.000000,0> translate<40.378800,-1.535000,42.076200> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<40.650000,-1.535000,43.974300>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<40.650000,-1.535000,43.703100>}
box{<0,0,-0.076200><0.271200,0.035000,0.076200> rotate<0,-90.000000,0> translate<40.650000,-1.535000,43.703100> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<39.287400,-1.535000,41.533900>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<39.016300,-1.535000,41.533900>}
box{<0,0,-0.076200><0.271100,0.035000,0.076200> rotate<0,0.000000,0> translate<39.016300,-1.535000,41.533900> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<39.016300,-1.535000,41.533900>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<38.745100,-1.535000,41.805100>}
box{<0,0,-0.076200><0.383535,0.035000,0.076200> rotate<0,44.997030,0> translate<38.745100,-1.535000,41.805100> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<38.745100,-1.535000,41.805100>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<38.745100,-1.535000,43.160800>}
box{<0,0,-0.076200><1.355700,0.035000,0.076200> rotate<0,90.000000,0> translate<38.745100,-1.535000,43.160800> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<38.745100,-1.535000,43.160800>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<39.558600,-1.535000,43.160800>}
box{<0,0,-0.076200><0.813500,0.035000,0.076200> rotate<0,0.000000,0> translate<38.745100,-1.535000,43.160800> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<39.558600,-1.535000,43.160800>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<39.829700,-1.535000,42.889600>}
box{<0,0,-0.076200><0.383464,0.035000,0.076200> rotate<0,45.007595,0> translate<39.558600,-1.535000,43.160800> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<39.829700,-1.535000,42.889600>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<39.829700,-1.535000,42.347300>}
box{<0,0,-0.076200><0.542300,0.035000,0.076200> rotate<0,-90.000000,0> translate<39.829700,-1.535000,42.347300> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<39.829700,-1.535000,42.347300>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<39.558600,-1.535000,42.076200>}
box{<0,0,-0.076200><0.383393,0.035000,0.076200> rotate<0,-44.997030,0> translate<39.558600,-1.535000,42.076200> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<39.558600,-1.535000,42.076200>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<38.745100,-1.535000,42.076200>}
box{<0,0,-0.076200><0.813500,0.035000,0.076200> rotate<0,0.000000,0> translate<38.745100,-1.535000,42.076200> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<37.921500,-1.535000,43.160800>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<37.379200,-1.535000,43.160800>}
box{<0,0,-0.076200><0.542300,0.035000,0.076200> rotate<0,0.000000,0> translate<37.379200,-1.535000,43.160800> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<37.379200,-1.535000,43.160800>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<37.108000,-1.535000,42.889600>}
box{<0,0,-0.076200><0.383535,0.035000,0.076200> rotate<0,-44.997030,0> translate<37.108000,-1.535000,42.889600> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<37.108000,-1.535000,42.889600>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<37.108000,-1.535000,42.076200>}
box{<0,0,-0.076200><0.813400,0.035000,0.076200> rotate<0,-90.000000,0> translate<37.108000,-1.535000,42.076200> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<37.108000,-1.535000,42.076200>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<37.921500,-1.535000,42.076200>}
box{<0,0,-0.076200><0.813500,0.035000,0.076200> rotate<0,0.000000,0> translate<37.108000,-1.535000,42.076200> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<37.921500,-1.535000,42.076200>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<38.192600,-1.535000,42.347300>}
box{<0,0,-0.076200><0.383393,0.035000,0.076200> rotate<0,-44.997030,0> translate<37.921500,-1.535000,42.076200> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<38.192600,-1.535000,42.347300>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<37.921500,-1.535000,42.618500>}
box{<0,0,-0.076200><0.383464,0.035000,0.076200> rotate<0,45.007595,0> translate<37.921500,-1.535000,42.618500> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<37.921500,-1.535000,42.618500>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<37.108000,-1.535000,42.618500>}
box{<0,0,-0.076200><0.813500,0.035000,0.076200> rotate<0,0.000000,0> translate<37.108000,-1.535000,42.618500> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<33.833800,-1.535000,42.076200>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<34.918400,-1.535000,42.076200>}
box{<0,0,-0.076200><1.084600,0.035000,0.076200> rotate<0,0.000000,0> translate<33.833800,-1.535000,42.076200> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<34.918400,-1.535000,42.076200>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<33.833800,-1.535000,43.160800>}
box{<0,0,-0.076200><1.533856,0.035000,0.076200> rotate<0,44.997030,0> translate<33.833800,-1.535000,43.160800> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<33.833800,-1.535000,43.160800>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<33.833800,-1.535000,43.432000>}
box{<0,0,-0.076200><0.271200,0.035000,0.076200> rotate<0,90.000000,0> translate<33.833800,-1.535000,43.432000> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<33.833800,-1.535000,43.432000>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<34.105000,-1.535000,43.703100>}
box{<0,0,-0.076200><0.383464,0.035000,0.076200> rotate<0,-44.986466,0> translate<33.833800,-1.535000,43.432000> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<34.105000,-1.535000,43.703100>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<34.647300,-1.535000,43.703100>}
box{<0,0,-0.076200><0.542300,0.035000,0.076200> rotate<0,0.000000,0> translate<34.105000,-1.535000,43.703100> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<34.647300,-1.535000,43.703100>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<34.918400,-1.535000,43.432000>}
box{<0,0,-0.076200><0.383393,0.035000,0.076200> rotate<0,44.997030,0> translate<34.647300,-1.535000,43.703100> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<33.281300,-1.535000,42.347300>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<33.281300,-1.535000,43.432000>}
box{<0,0,-0.076200><1.084700,0.035000,0.076200> rotate<0,90.000000,0> translate<33.281300,-1.535000,43.432000> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<33.281300,-1.535000,43.432000>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<33.010200,-1.535000,43.703100>}
box{<0,0,-0.076200><0.383393,0.035000,0.076200> rotate<0,44.997030,0> translate<33.010200,-1.535000,43.703100> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<33.010200,-1.535000,43.703100>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<32.467900,-1.535000,43.703100>}
box{<0,0,-0.076200><0.542300,0.035000,0.076200> rotate<0,0.000000,0> translate<32.467900,-1.535000,43.703100> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<32.467900,-1.535000,43.703100>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<32.196700,-1.535000,43.432000>}
box{<0,0,-0.076200><0.383464,0.035000,0.076200> rotate<0,-44.986466,0> translate<32.196700,-1.535000,43.432000> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<32.196700,-1.535000,43.432000>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<32.196700,-1.535000,42.347300>}
box{<0,0,-0.076200><1.084700,0.035000,0.076200> rotate<0,-90.000000,0> translate<32.196700,-1.535000,42.347300> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<32.196700,-1.535000,42.347300>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<32.467900,-1.535000,42.076200>}
box{<0,0,-0.076200><0.383464,0.035000,0.076200> rotate<0,44.986466,0> translate<32.196700,-1.535000,42.347300> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<32.467900,-1.535000,42.076200>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<33.010200,-1.535000,42.076200>}
box{<0,0,-0.076200><0.542300,0.035000,0.076200> rotate<0,0.000000,0> translate<32.467900,-1.535000,42.076200> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<33.010200,-1.535000,42.076200>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<33.281300,-1.535000,42.347300>}
box{<0,0,-0.076200><0.383393,0.035000,0.076200> rotate<0,-44.997030,0> translate<33.010200,-1.535000,42.076200> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<33.281300,-1.535000,42.347300>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<32.196700,-1.535000,43.432000>}
box{<0,0,-0.076200><1.533927,0.035000,0.076200> rotate<0,44.999671,0> translate<32.196700,-1.535000,43.432000> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<31.644200,-1.535000,43.160800>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<31.101900,-1.535000,43.703100>}
box{<0,0,-0.076200><0.766928,0.035000,0.076200> rotate<0,44.997030,0> translate<31.101900,-1.535000,43.703100> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<31.101900,-1.535000,43.703100>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<31.101900,-1.535000,42.076200>}
box{<0,0,-0.076200><1.626900,0.035000,0.076200> rotate<0,-90.000000,0> translate<31.101900,-1.535000,42.076200> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<31.644200,-1.535000,42.076200>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<30.559600,-1.535000,42.076200>}
box{<0,0,-0.076200><1.084600,0.035000,0.076200> rotate<0,0.000000,0> translate<30.559600,-1.535000,42.076200> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<28.922500,-1.535000,42.076200>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<30.007100,-1.535000,42.076200>}
box{<0,0,-0.076200><1.084600,0.035000,0.076200> rotate<0,0.000000,0> translate<28.922500,-1.535000,42.076200> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<30.007100,-1.535000,42.076200>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<28.922500,-1.535000,43.160800>}
box{<0,0,-0.076200><1.533856,0.035000,0.076200> rotate<0,44.997030,0> translate<28.922500,-1.535000,43.160800> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<28.922500,-1.535000,43.160800>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<28.922500,-1.535000,43.432000>}
box{<0,0,-0.076200><0.271200,0.035000,0.076200> rotate<0,90.000000,0> translate<28.922500,-1.535000,43.432000> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<28.922500,-1.535000,43.432000>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<29.193700,-1.535000,43.703100>}
box{<0,0,-0.076200><0.383464,0.035000,0.076200> rotate<0,-44.986466,0> translate<28.922500,-1.535000,43.432000> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<29.193700,-1.535000,43.703100>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<29.736000,-1.535000,43.703100>}
box{<0,0,-0.076200><0.542300,0.035000,0.076200> rotate<0,0.000000,0> translate<29.193700,-1.535000,43.703100> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<29.736000,-1.535000,43.703100>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<30.007100,-1.535000,43.432000>}
box{<0,0,-0.076200><0.383393,0.035000,0.076200> rotate<0,44.997030,0> translate<29.736000,-1.535000,43.703100> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<28.370000,-1.535000,41.533900>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<27.827700,-1.535000,42.076200>}
box{<0,0,-0.076200><0.766928,0.035000,0.076200> rotate<0,44.997030,0> translate<27.827700,-1.535000,42.076200> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<27.827700,-1.535000,42.076200>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<27.827700,-1.535000,42.347300>}
box{<0,0,-0.076200><0.271100,0.035000,0.076200> rotate<0,90.000000,0> translate<27.827700,-1.535000,42.347300> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<27.827700,-1.535000,42.347300>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<28.098900,-1.535000,42.347300>}
box{<0,0,-0.076200><0.271200,0.035000,0.076200> rotate<0,0.000000,0> translate<27.827700,-1.535000,42.347300> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<28.098900,-1.535000,42.347300>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<28.098900,-1.535000,42.076200>}
box{<0,0,-0.076200><0.271100,0.035000,0.076200> rotate<0,-90.000000,0> translate<28.098900,-1.535000,42.076200> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<28.098900,-1.535000,42.076200>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<27.827700,-1.535000,42.076200>}
box{<0,0,-0.076200><0.271200,0.035000,0.076200> rotate<0,0.000000,0> translate<27.827700,-1.535000,42.076200> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<25.641500,-1.535000,42.076200>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<25.641500,-1.535000,43.160800>}
box{<0,0,-0.076200><1.084600,0.035000,0.076200> rotate<0,90.000000,0> translate<25.641500,-1.535000,43.160800> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<25.641500,-1.535000,43.160800>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<25.099200,-1.535000,43.703100>}
box{<0,0,-0.076200><0.766928,0.035000,0.076200> rotate<0,44.997030,0> translate<25.099200,-1.535000,43.703100> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<25.099200,-1.535000,43.703100>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<24.556900,-1.535000,43.160800>}
box{<0,0,-0.076200><0.766928,0.035000,0.076200> rotate<0,-44.997030,0> translate<24.556900,-1.535000,43.160800> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<24.556900,-1.535000,43.160800>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<24.556900,-1.535000,42.076200>}
box{<0,0,-0.076200><1.084600,0.035000,0.076200> rotate<0,-90.000000,0> translate<24.556900,-1.535000,42.076200> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<25.641500,-1.535000,42.889600>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<24.556900,-1.535000,42.889600>}
box{<0,0,-0.076200><1.084600,0.035000,0.076200> rotate<0,0.000000,0> translate<24.556900,-1.535000,42.889600> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<22.919800,-1.535000,43.432000>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<23.191000,-1.535000,43.703100>}
box{<0,0,-0.076200><0.383464,0.035000,0.076200> rotate<0,-44.986466,0> translate<22.919800,-1.535000,43.432000> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<23.191000,-1.535000,43.703100>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<23.733300,-1.535000,43.703100>}
box{<0,0,-0.076200><0.542300,0.035000,0.076200> rotate<0,0.000000,0> translate<23.191000,-1.535000,43.703100> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<23.733300,-1.535000,43.703100>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<24.004400,-1.535000,43.432000>}
box{<0,0,-0.076200><0.383393,0.035000,0.076200> rotate<0,44.997030,0> translate<23.733300,-1.535000,43.703100> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<24.004400,-1.535000,43.432000>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<24.004400,-1.535000,42.347300>}
box{<0,0,-0.076200><1.084700,0.035000,0.076200> rotate<0,-90.000000,0> translate<24.004400,-1.535000,42.347300> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<24.004400,-1.535000,42.347300>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<23.733300,-1.535000,42.076200>}
box{<0,0,-0.076200><0.383393,0.035000,0.076200> rotate<0,-44.997030,0> translate<23.733300,-1.535000,42.076200> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<23.733300,-1.535000,42.076200>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<23.191000,-1.535000,42.076200>}
box{<0,0,-0.076200><0.542300,0.035000,0.076200> rotate<0,0.000000,0> translate<23.191000,-1.535000,42.076200> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<23.191000,-1.535000,42.076200>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<22.919800,-1.535000,42.347300>}
box{<0,0,-0.076200><0.383464,0.035000,0.076200> rotate<0,44.986466,0> translate<22.919800,-1.535000,42.347300> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<22.919800,-1.535000,42.347300>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<22.919800,-1.535000,42.889600>}
box{<0,0,-0.076200><0.542300,0.035000,0.076200> rotate<0,90.000000,0> translate<22.919800,-1.535000,42.889600> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<22.919800,-1.535000,42.889600>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<23.462100,-1.535000,42.889600>}
box{<0,0,-0.076200><0.542300,0.035000,0.076200> rotate<0,0.000000,0> translate<22.919800,-1.535000,42.889600> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<22.367300,-1.535000,42.076200>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<22.367300,-1.535000,43.703100>}
box{<0,0,-0.076200><1.626900,0.035000,0.076200> rotate<0,90.000000,0> translate<22.367300,-1.535000,43.703100> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<22.367300,-1.535000,42.889600>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<21.282700,-1.535000,42.889600>}
box{<0,0,-0.076200><1.084600,0.035000,0.076200> rotate<0,0.000000,0> translate<21.282700,-1.535000,42.889600> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<21.282700,-1.535000,43.703100>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<21.282700,-1.535000,42.076200>}
box{<0,0,-0.076200><1.626900,0.035000,0.076200> rotate<0,-90.000000,0> translate<21.282700,-1.535000,42.076200> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<20.730200,-1.535000,41.533900>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<20.187900,-1.535000,42.076200>}
box{<0,0,-0.076200><0.766928,0.035000,0.076200> rotate<0,44.997030,0> translate<20.187900,-1.535000,42.076200> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<20.187900,-1.535000,42.076200>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<20.187900,-1.535000,42.347300>}
box{<0,0,-0.076200><0.271100,0.035000,0.076200> rotate<0,90.000000,0> translate<20.187900,-1.535000,42.347300> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<20.187900,-1.535000,42.347300>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<20.459100,-1.535000,42.347300>}
box{<0,0,-0.076200><0.271200,0.035000,0.076200> rotate<0,0.000000,0> translate<20.187900,-1.535000,42.347300> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<20.459100,-1.535000,42.347300>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<20.459100,-1.535000,42.076200>}
box{<0,0,-0.076200><0.271100,0.035000,0.076200> rotate<0,-90.000000,0> translate<20.459100,-1.535000,42.076200> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<20.459100,-1.535000,42.076200>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<20.187900,-1.535000,42.076200>}
box{<0,0,-0.076200><0.271200,0.035000,0.076200> rotate<0,0.000000,0> translate<20.187900,-1.535000,42.076200> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<18.001700,-1.535000,42.076200>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<17.459400,-1.535000,42.076200>}
box{<0,0,-0.076200><0.542300,0.035000,0.076200> rotate<0,0.000000,0> translate<17.459400,-1.535000,42.076200> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<17.730600,-1.535000,42.076200>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<17.730600,-1.535000,43.703100>}
box{<0,0,-0.076200><1.626900,0.035000,0.076200> rotate<0,90.000000,0> translate<17.730600,-1.535000,43.703100> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<18.001700,-1.535000,43.703100>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<17.459400,-1.535000,43.703100>}
box{<0,0,-0.076200><0.542300,0.035000,0.076200> rotate<0,0.000000,0> translate<17.459400,-1.535000,43.703100> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<16.910300,-1.535000,42.076200>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<16.910300,-1.535000,43.703100>}
box{<0,0,-0.076200><1.626900,0.035000,0.076200> rotate<0,90.000000,0> translate<16.910300,-1.535000,43.703100> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<16.910300,-1.535000,43.703100>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<16.368000,-1.535000,43.160800>}
box{<0,0,-0.076200><0.766928,0.035000,0.076200> rotate<0,-44.997030,0> translate<16.368000,-1.535000,43.160800> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<16.368000,-1.535000,43.160800>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<15.825700,-1.535000,43.703100>}
box{<0,0,-0.076200><0.766928,0.035000,0.076200> rotate<0,44.997030,0> translate<15.825700,-1.535000,43.703100> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<15.825700,-1.535000,43.703100>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<15.825700,-1.535000,42.076200>}
box{<0,0,-0.076200><1.626900,0.035000,0.076200> rotate<0,-90.000000,0> translate<15.825700,-1.535000,42.076200> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<15.273200,-1.535000,42.076200>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<14.730900,-1.535000,42.076200>}
box{<0,0,-0.076200><0.542300,0.035000,0.076200> rotate<0,0.000000,0> translate<14.730900,-1.535000,42.076200> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<15.002100,-1.535000,42.076200>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<15.002100,-1.535000,43.703100>}
box{<0,0,-0.076200><1.626900,0.035000,0.076200> rotate<0,90.000000,0> translate<15.002100,-1.535000,43.703100> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<15.273200,-1.535000,43.703100>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<14.730900,-1.535000,43.703100>}
box{<0,0,-0.076200><0.542300,0.035000,0.076200> rotate<0,0.000000,0> translate<14.730900,-1.535000,43.703100> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<14.181800,-1.535000,42.076200>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<14.181800,-1.535000,43.703100>}
box{<0,0,-0.076200><1.626900,0.035000,0.076200> rotate<0,90.000000,0> translate<14.181800,-1.535000,43.703100> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<14.181800,-1.535000,43.703100>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<13.639500,-1.535000,43.160800>}
box{<0,0,-0.076200><0.766928,0.035000,0.076200> rotate<0,-44.997030,0> translate<13.639500,-1.535000,43.160800> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<13.639500,-1.535000,43.160800>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<13.097200,-1.535000,43.703100>}
box{<0,0,-0.076200><0.766928,0.035000,0.076200> rotate<0,44.997030,0> translate<13.097200,-1.535000,43.703100> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<13.097200,-1.535000,43.703100>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<13.097200,-1.535000,42.076200>}
box{<0,0,-0.076200><1.626900,0.035000,0.076200> rotate<0,-90.000000,0> translate<13.097200,-1.535000,42.076200> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<10.907600,-1.535000,42.076200>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<10.907600,-1.535000,43.703100>}
box{<0,0,-0.076200><1.626900,0.035000,0.076200> rotate<0,90.000000,0> translate<10.907600,-1.535000,43.703100> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<10.907600,-1.535000,43.703100>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<10.094200,-1.535000,43.703100>}
box{<0,0,-0.076200><0.813400,0.035000,0.076200> rotate<0,0.000000,0> translate<10.094200,-1.535000,43.703100> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<10.094200,-1.535000,43.703100>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<9.823000,-1.535000,43.432000>}
box{<0,0,-0.076200><0.383464,0.035000,0.076200> rotate<0,-44.986466,0> translate<9.823000,-1.535000,43.432000> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<9.823000,-1.535000,43.432000>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<9.823000,-1.535000,42.889600>}
box{<0,0,-0.076200><0.542400,0.035000,0.076200> rotate<0,-90.000000,0> translate<9.823000,-1.535000,42.889600> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<9.823000,-1.535000,42.889600>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<10.094200,-1.535000,42.618500>}
box{<0,0,-0.076200><0.383464,0.035000,0.076200> rotate<0,44.986466,0> translate<9.823000,-1.535000,42.889600> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<10.094200,-1.535000,42.618500>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<10.907600,-1.535000,42.618500>}
box{<0,0,-0.076200><0.813400,0.035000,0.076200> rotate<0,0.000000,0> translate<10.094200,-1.535000,42.618500> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<9.270500,-1.535000,42.076200>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<9.270500,-1.535000,43.160800>}
box{<0,0,-0.076200><1.084600,0.035000,0.076200> rotate<0,90.000000,0> translate<9.270500,-1.535000,43.160800> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<9.270500,-1.535000,43.160800>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<8.728200,-1.535000,43.703100>}
box{<0,0,-0.076200><0.766928,0.035000,0.076200> rotate<0,44.997030,0> translate<8.728200,-1.535000,43.703100> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<8.728200,-1.535000,43.703100>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<8.185900,-1.535000,43.160800>}
box{<0,0,-0.076200><0.766928,0.035000,0.076200> rotate<0,-44.997030,0> translate<8.185900,-1.535000,43.160800> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<8.185900,-1.535000,43.160800>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<8.185900,-1.535000,42.076200>}
box{<0,0,-0.076200><1.084600,0.035000,0.076200> rotate<0,-90.000000,0> translate<8.185900,-1.535000,42.076200> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<9.270500,-1.535000,42.889600>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<8.185900,-1.535000,42.889600>}
box{<0,0,-0.076200><1.084600,0.035000,0.076200> rotate<0,0.000000,0> translate<8.185900,-1.535000,42.889600> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<7.633400,-1.535000,42.076200>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<7.633400,-1.535000,43.703100>}
box{<0,0,-0.076200><1.626900,0.035000,0.076200> rotate<0,90.000000,0> translate<7.633400,-1.535000,43.703100> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<7.633400,-1.535000,43.703100>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<6.548800,-1.535000,42.076200>}
box{<0,0,-0.076200><1.955290,0.035000,0.076200> rotate<0,-56.306216,0> translate<6.548800,-1.535000,42.076200> }
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<6.548800,-1.535000,42.076200>}
cylinder{<0,0,0><0,0.035000,0>0.076200 translate<6.548800,-1.535000,43.703100>}
box{<0,0,-0.076200><1.626900,0.035000,0.076200> rotate<0,90.000000,0> translate<6.548800,-1.535000,43.703100> }
//Rect
union{
texture{col_pds}
}
texture{col_wrs}
}
#end
#if(pcb_polygons=on)
union{
//Polygons
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<0.500000,-1.535000,0.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<0.500000,-1.535000,49.500000>}
box{<0,0,-0.304800><49.000000,0.035000,0.304800> rotate<0,90.000000,0> translate<0.500000,-1.535000,49.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<0.500000,-1.535000,0.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.500000,-1.535000,0.500000>}
box{<0,0,-0.304800><74.000000,0.035000,0.304800> rotate<0,0.000000,0> translate<0.500000,-1.535000,0.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<0.500000,-1.535000,49.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.500000,-1.535000,49.500000>}
box{<0,0,-0.304800><74.000000,0.035000,0.304800> rotate<0,0.000000,0> translate<0.500000,-1.535000,49.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.500000,-1.535000,49.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.500000,-1.535000,0.500000>}
box{<0,0,-0.304800><49.000000,0.035000,0.304800> rotate<0,-90.000000,0> translate<74.500000,-1.535000,0.500000> }
texture{col_pol}
}
#end
union{
cylinder{<33.270000,0.038000,31.000000><33.270000,-1.538000,31.000000>0.406400}
cylinder{<30.730000,0.038000,31.000000><30.730000,-1.538000,31.000000>0.406400}
cylinder{<41.000000,0.038000,32.270000><41.000000,-1.538000,32.270000>0.406400}
cylinder{<41.000000,0.038000,29.730000><41.000000,-1.538000,29.730000>0.406400}
cylinder{<6.270000,0.038000,47.000000><6.270000,-1.538000,47.000000>0.406400}
cylinder{<3.730000,0.038000,47.000000><3.730000,-1.538000,47.000000>0.406400}
cylinder{<23.270000,0.038000,14.000000><23.270000,-1.538000,14.000000>0.406400}
cylinder{<20.730000,0.038000,14.000000><20.730000,-1.538000,14.000000>0.406400}
cylinder{<14.730000,0.038000,14.000000><14.730000,-1.538000,14.000000>0.406400}
cylinder{<17.270000,0.038000,14.000000><17.270000,-1.538000,14.000000>0.406400}
cylinder{<14.730000,0.038000,20.000000><14.730000,-1.538000,20.000000>0.406400}
cylinder{<17.270000,0.038000,20.000000><17.270000,-1.538000,20.000000>0.406400}
cylinder{<20.730000,0.038000,18.000000><20.730000,-1.538000,18.000000>0.406400}
cylinder{<23.270000,0.038000,18.000000><23.270000,-1.538000,18.000000>0.406400}
cylinder{<21.000000,0.038000,28.730000><21.000000,-1.538000,28.730000>0.406400}
cylinder{<21.000000,0.038000,31.270000><21.000000,-1.538000,31.270000>0.406400}
cylinder{<27.730000,0.038000,26.000000><27.730000,-1.538000,26.000000>0.406400}
cylinder{<30.270000,0.038000,26.000000><30.270000,-1.538000,26.000000>0.406400}
cylinder{<58.270000,0.038000,20.000000><58.270000,-1.538000,20.000000>0.406400}
cylinder{<55.730000,0.038000,20.000000><55.730000,-1.538000,20.000000>0.406400}
cylinder{<51.730000,0.038000,43.000000><51.730000,-1.538000,43.000000>0.406400}
cylinder{<54.270000,0.038000,43.000000><54.270000,-1.538000,43.000000>0.406400}
cylinder{<44.770000,0.038000,4.000000><44.770000,-1.538000,4.000000>0.406400}
cylinder{<42.230000,0.038000,4.000000><42.230000,-1.538000,4.000000>0.406400}
cylinder{<72.080000,0.038000,23.000000><72.080000,-1.538000,23.000000>0.558800}
cylinder{<61.920000,0.038000,23.000000><61.920000,-1.538000,23.000000>0.558800}
cylinder{<6.000000,0.038000,32.080000><6.000000,-1.538000,32.080000>0.558800}
cylinder{<6.000000,0.038000,21.920000><6.000000,-1.538000,21.920000>0.558800}
cylinder{<61.080000,0.038000,47.000000><61.080000,-1.538000,47.000000>0.558800}
cylinder{<50.920000,0.038000,47.000000><50.920000,-1.538000,47.000000>0.558800}
cylinder{<12.490000,0.038000,38.190000><12.490000,-1.538000,38.190000>0.406400}
cylinder{<15.030000,0.038000,38.190000><15.030000,-1.538000,38.190000>0.406400}
cylinder{<17.570000,0.038000,38.190000><17.570000,-1.538000,38.190000>0.406400}
cylinder{<20.110000,0.038000,38.190000><20.110000,-1.538000,38.190000>0.406400}
cylinder{<22.650000,0.038000,38.190000><22.650000,-1.538000,38.190000>0.406400}
cylinder{<25.190000,0.038000,38.190000><25.190000,-1.538000,38.190000>0.406400}
cylinder{<27.730000,0.038000,38.190000><27.730000,-1.538000,38.190000>0.406400}
cylinder{<30.270000,0.038000,38.190000><30.270000,-1.538000,38.190000>0.406400}
cylinder{<32.810000,0.038000,38.190000><32.810000,-1.538000,38.190000>0.406400}
cylinder{<35.350000,0.038000,38.190000><35.350000,-1.538000,38.190000>0.406400}
cylinder{<37.890000,0.038000,38.190000><37.890000,-1.538000,38.190000>0.406400}
cylinder{<40.430000,0.038000,38.190000><40.430000,-1.538000,38.190000>0.406400}
cylinder{<42.970000,0.038000,38.190000><42.970000,-1.538000,38.190000>0.406400}
cylinder{<45.510000,0.038000,38.190000><45.510000,-1.538000,38.190000>0.406400}
cylinder{<45.510000,0.038000,45.810000><45.510000,-1.538000,45.810000>0.406400}
cylinder{<42.970000,0.038000,45.810000><42.970000,-1.538000,45.810000>0.406400}
cylinder{<40.430000,0.038000,45.810000><40.430000,-1.538000,45.810000>0.406400}
cylinder{<37.890000,0.038000,45.810000><37.890000,-1.538000,45.810000>0.406400}
cylinder{<35.350000,0.038000,45.810000><35.350000,-1.538000,45.810000>0.406400}
cylinder{<32.810000,0.038000,45.810000><32.810000,-1.538000,45.810000>0.406400}
cylinder{<30.270000,0.038000,45.810000><30.270000,-1.538000,45.810000>0.406400}
cylinder{<27.730000,0.038000,45.810000><27.730000,-1.538000,45.810000>0.406400}
cylinder{<25.190000,0.038000,45.810000><25.190000,-1.538000,45.810000>0.406400}
cylinder{<22.650000,0.038000,45.810000><22.650000,-1.538000,45.810000>0.406400}
cylinder{<20.110000,0.038000,45.810000><20.110000,-1.538000,45.810000>0.406400}
cylinder{<17.570000,0.038000,45.810000><17.570000,-1.538000,45.810000>0.406400}
cylinder{<15.030000,0.038000,45.810000><15.030000,-1.538000,45.810000>0.406400}
cylinder{<12.490000,0.038000,45.810000><12.490000,-1.538000,45.810000>0.406400}
cylinder{<9.840000,0.038000,31.540000><9.840000,-1.538000,31.540000>0.558800}
cylinder{<9.840000,0.038000,29.000000><9.840000,-1.538000,29.000000>0.558800}
cylinder{<9.840000,0.038000,26.460000><9.840000,-1.538000,26.460000>0.558800}
cylinder{<8.100000,0.038000,40.000000><8.100000,-1.538000,40.000000>0.500000}
cylinder{<5.000000,0.038000,35.200000><5.000000,-1.538000,35.200000>0.500000}
cylinder{<2.000000,0.038000,40.000000><2.000000,-1.538000,40.000000>0.500000}
cylinder{<2.810000,0.038000,27.540000><2.810000,-1.538000,27.540000>0.508000}
cylinder{<2.810000,0.038000,25.000000><2.810000,-1.538000,25.000000>0.508000}
cylinder{<2.810000,0.038000,22.460000><2.810000,-1.538000,22.460000>0.508000}
cylinder{<28.230000,0.038000,5.500000><28.230000,-1.538000,5.500000>0.406400}
cylinder{<30.770000,0.038000,5.500000><30.770000,-1.538000,5.500000>0.406400}
cylinder{<34.000000,0.038000,4.730000><34.000000,-1.538000,4.730000>0.406400}
cylinder{<34.000000,0.038000,7.270000><34.000000,-1.538000,7.270000>0.406400}
cylinder{<56.730000,0.038000,8.000000><56.730000,-1.538000,8.000000>0.406400}
cylinder{<59.270000,0.038000,8.000000><59.270000,-1.538000,8.000000>0.406400}
cylinder{<56.730000,0.038000,13.000000><56.730000,-1.538000,13.000000>0.406400}
cylinder{<59.270000,0.038000,13.000000><59.270000,-1.538000,13.000000>0.406400}
cylinder{<48.270000,0.038000,18.000000><48.270000,-1.538000,18.000000>0.406400}
cylinder{<45.730000,0.038000,18.000000><45.730000,-1.538000,18.000000>0.406400}
cylinder{<56.730000,0.038000,26.190000><56.730000,-1.538000,26.190000>0.406400}
cylinder{<59.270000,0.038000,26.190000><59.270000,-1.538000,26.190000>0.406400}
cylinder{<59.270000,0.038000,33.810000><59.270000,-1.538000,33.810000>0.406400}
cylinder{<56.730000,0.038000,33.810000><56.730000,-1.538000,33.810000>0.406400}
cylinder{<31.460000,0.038000,34.380000><31.460000,-1.538000,34.380000>0.304800}
cylinder{<36.540000,0.038000,34.380000><36.540000,-1.538000,34.380000>0.304800}
cylinder{<72.080000,0.038000,19.000000><72.080000,-1.538000,19.000000>0.406400}
cylinder{<61.920000,0.038000,19.000000><61.920000,-1.538000,19.000000>0.406400}
cylinder{<46.000000,0.038000,22.920000><46.000000,-1.538000,22.920000>0.406400}
cylinder{<46.000000,0.038000,33.080000><46.000000,-1.538000,33.080000>0.406400}
cylinder{<49.000000,0.038000,22.920000><49.000000,-1.538000,22.920000>0.406400}
cylinder{<49.000000,0.038000,33.080000><49.000000,-1.538000,33.080000>0.406400}
cylinder{<52.000000,0.038000,22.920000><52.000000,-1.538000,22.920000>0.406400}
cylinder{<52.000000,0.038000,33.080000><52.000000,-1.538000,33.080000>0.406400}
cylinder{<50.920000,0.038000,38.500000><50.920000,-1.538000,38.500000>0.406400}
cylinder{<61.080000,0.038000,38.500000><61.080000,-1.538000,38.500000>0.406400}
cylinder{<18.000000,0.038000,24.920000><18.000000,-1.538000,24.920000>0.406400}
cylinder{<18.000000,0.038000,35.080000><18.000000,-1.538000,35.080000>0.406400}
cylinder{<24.000000,0.038000,24.920000><24.000000,-1.538000,24.920000>0.406400}
cylinder{<24.000000,0.038000,35.080000><24.000000,-1.538000,35.080000>0.406400}
cylinder{<25.080000,0.038000,7.500000><25.080000,-1.538000,7.500000>0.406400}
cylinder{<14.920000,0.038000,7.500000><14.920000,-1.538000,7.500000>0.406400}
cylinder{<25.080000,0.038000,4.500000><25.080000,-1.538000,4.500000>0.406400}
cylinder{<14.920000,0.038000,4.500000><14.920000,-1.538000,4.500000>0.406400}
cylinder{<60.580000,0.038000,2.000000><60.580000,-1.538000,2.000000>0.406400}
cylinder{<50.420000,0.038000,2.000000><50.420000,-1.538000,2.000000>0.406400}
cylinder{<52.000000,0.038000,9.920000><52.000000,-1.538000,9.920000>0.406400}
cylinder{<52.000000,0.038000,20.080000><52.000000,-1.538000,20.080000>0.406400}
cylinder{<63.748800,0.038000,15.260600><63.748800,-1.538000,15.260600>0.508000}
cylinder{<70.251200,0.038000,15.260600><70.251200,-1.538000,15.260600>0.508000}
cylinder{<63.748800,0.038000,10.739400><63.748800,-1.538000,10.739400>0.508000}
cylinder{<70.251200,0.038000,10.739400><70.251200,-1.538000,10.739400>0.508000}
cylinder{<70.251200,0.038000,2.739400><70.251200,-1.538000,2.739400>0.508000}
cylinder{<63.748800,0.038000,2.739400><63.748800,-1.538000,2.739400>0.508000}
cylinder{<70.251200,0.038000,7.260600><70.251200,-1.538000,7.260600>0.508000}
cylinder{<63.748800,0.038000,7.260600><63.748800,-1.538000,7.260600>0.508000}
cylinder{<59.000000,0.038000,41.730000><59.000000,-1.538000,41.730000>0.406400}
cylinder{<60.905000,0.038000,43.000000><60.905000,-1.538000,43.000000>0.406400}
cylinder{<59.000000,0.038000,44.270000><59.000000,-1.538000,44.270000>0.406400}
cylinder{<9.710000,0.038000,10.750000><9.710000,-1.538000,10.750000>0.475000}
cylinder{<9.710000,0.038000,13.250000><9.710000,-1.538000,13.250000>0.475000}
cylinder{<7.710000,0.038000,13.250000><7.710000,-1.538000,13.250000>0.475000}
cylinder{<7.710000,0.038000,10.750000><7.710000,-1.538000,10.750000>0.475000}
cylinder{<67.365000,0.038000,40.460000><67.365000,-1.538000,40.460000>0.596900}
cylinder{<67.365000,0.038000,45.540000><67.365000,-1.538000,45.540000>0.596900}
cylinder{<67.365000,0.038000,28.460000><67.365000,-1.538000,28.460000>0.596900}
cylinder{<67.365000,0.038000,33.540000><67.365000,-1.538000,33.540000>0.596900}
//Holes(fast)/Vias
cylinder{<9.000000,0.038000,23.000000><9.000000,-1.538000,23.000000>0.300000 }
cylinder{<18.500000,0.038000,23.000000><18.500000,-1.538000,23.000000>0.300000 }
cylinder{<42.500000,0.038000,21.500000><42.500000,-1.538000,21.500000>0.300000 }
cylinder{<53.500000,0.038000,21.500000><53.500000,-1.538000,21.500000>0.300000 }
cylinder{<54.000000,0.038000,14.500000><54.000000,-1.538000,14.500000>0.300000 }
cylinder{<54.000000,0.038000,10.500000><54.000000,-1.538000,10.500000>0.300000 }
cylinder{<42.500000,0.038000,15.000000><42.500000,-1.538000,15.000000>0.300000 }
cylinder{<46.000000,0.038000,15.000000><46.000000,-1.538000,15.000000>0.300000 }
cylinder{<46.500000,0.038000,4.000000><46.500000,-1.538000,4.000000>0.300000 }
cylinder{<51.500000,0.038000,4.000000><51.500000,-1.538000,4.000000>0.300000 }
cylinder{<27.500000,0.038000,17.000000><27.500000,-1.538000,17.000000>0.300000 }
cylinder{<27.500000,0.038000,10.500000><27.500000,-1.538000,10.500000>0.300000 }
cylinder{<13.000000,0.038000,30.500000><13.000000,-1.538000,30.500000>0.300000 }
cylinder{<13.000000,0.038000,17.500000><13.000000,-1.538000,17.500000>0.300000 }
cylinder{<55.500000,0.038000,14.500000><55.500000,-1.538000,14.500000>0.300000 }
cylinder{<45.500000,0.038000,6.500000><45.500000,-1.538000,6.500000>0.300000 }
cylinder{<55.500000,0.038000,10.500000><55.500000,-1.538000,10.500000>0.300000 }
cylinder{<53.000000,0.038000,6.500000><53.000000,-1.538000,6.500000>0.300000 }
//Holes(fast)/Board
texture{col_hls}
}
#if(pcb_silkscreen=on)
//Silk Screen
union{
//C1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.159000,0.000000,29.730000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.841000,0.000000,29.730000>}
box{<0,0,-0.076200><4.318000,0.036000,0.076200> rotate<0,0.000000,0> translate<29.841000,0.000000,29.730000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.841000,0.000000,32.270000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.159000,0.000000,32.270000>}
box{<0,0,-0.076200><4.318000,0.036000,0.076200> rotate<0,0.000000,0> translate<29.841000,0.000000,32.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.587000,0.000000,29.984000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.587000,0.000000,32.016000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<29.587000,0.000000,32.016000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.413000,0.000000,29.984000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.413000,0.000000,32.016000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<34.413000,0.000000,32.016000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<29.841000,0.000000,29.984000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<34.159000,0.000000,29.984000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<29.841000,0.000000,32.016000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<34.159000,0.000000,32.016000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.238000,0.000000,31.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.619000,0.000000,31.000000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<31.238000,0.000000,31.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.619000,0.000000,31.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.746000,0.000000,31.000000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<31.619000,0.000000,31.000000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<31.746000,0.000000,31.000000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<31.746000,0.000000,30.238000>}
box{<0,0,-0.127000><0.762000,0.036000,0.127000> rotate<0,-90.000000,0> translate<31.746000,0.000000,30.238000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<31.746000,0.000000,31.000000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<31.746000,0.000000,31.762000>}
box{<0,0,-0.127000><0.762000,0.036000,0.127000> rotate<0,90.000000,0> translate<31.746000,0.000000,31.762000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<32.254000,0.000000,30.238000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<32.254000,0.000000,31.000000>}
box{<0,0,-0.127000><0.762000,0.036000,0.127000> rotate<0,90.000000,0> translate<32.254000,0.000000,31.000000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<32.254000,0.000000,31.000000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<32.254000,0.000000,31.762000>}
box{<0,0,-0.127000><0.762000,0.036000,0.127000> rotate<0,90.000000,0> translate<32.254000,0.000000,31.762000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.254000,0.000000,31.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.381000,0.000000,31.000000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.254000,0.000000,31.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.381000,0.000000,31.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.762000,0.000000,31.000000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.381000,0.000000,31.000000> }
//C2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.270000,0.000000,33.159000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.270000,0.000000,28.841000>}
box{<0,0,-0.076200><4.318000,0.036000,0.076200> rotate<0,-90.000000,0> translate<42.270000,0.000000,28.841000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.730000,0.000000,28.841000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.730000,0.000000,33.159000>}
box{<0,0,-0.076200><4.318000,0.036000,0.076200> rotate<0,90.000000,0> translate<39.730000,0.000000,33.159000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.016000,0.000000,28.587000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.984000,0.000000,28.587000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<39.984000,0.000000,28.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.016000,0.000000,33.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.984000,0.000000,33.413000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<39.984000,0.000000,33.413000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<42.016000,0.000000,28.841000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<42.016000,0.000000,33.159000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<39.984000,0.000000,28.841000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<39.984000,0.000000,33.159000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.000000,0.000000,30.238000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.000000,0.000000,30.619000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<41.000000,0.000000,30.619000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.000000,0.000000,30.619000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.000000,0.000000,30.746000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<41.000000,0.000000,30.746000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<41.000000,0.000000,30.746000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<41.762000,0.000000,30.746000>}
box{<0,0,-0.127000><0.762000,0.036000,0.127000> rotate<0,0.000000,0> translate<41.000000,0.000000,30.746000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<41.000000,0.000000,30.746000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<40.238000,0.000000,30.746000>}
box{<0,0,-0.127000><0.762000,0.036000,0.127000> rotate<0,0.000000,0> translate<40.238000,0.000000,30.746000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<41.762000,0.000000,31.254000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<41.000000,0.000000,31.254000>}
box{<0,0,-0.127000><0.762000,0.036000,0.127000> rotate<0,0.000000,0> translate<41.000000,0.000000,31.254000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<41.000000,0.000000,31.254000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<40.238000,0.000000,31.254000>}
box{<0,0,-0.127000><0.762000,0.036000,0.127000> rotate<0,0.000000,0> translate<40.238000,0.000000,31.254000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.000000,0.000000,31.254000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.000000,0.000000,31.381000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<41.000000,0.000000,31.381000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.000000,0.000000,31.381000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.000000,0.000000,31.762000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<41.000000,0.000000,31.762000> }
//C3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.159000,0.000000,45.730000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.841000,0.000000,45.730000>}
box{<0,0,-0.076200><4.318000,0.036000,0.076200> rotate<0,0.000000,0> translate<2.841000,0.000000,45.730000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.841000,0.000000,48.270000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.159000,0.000000,48.270000>}
box{<0,0,-0.076200><4.318000,0.036000,0.076200> rotate<0,0.000000,0> translate<2.841000,0.000000,48.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.587000,0.000000,45.984000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.587000,0.000000,48.016000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<2.587000,0.000000,48.016000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.413000,0.000000,45.984000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.413000,0.000000,48.016000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<7.413000,0.000000,48.016000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<2.841000,0.000000,45.984000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<7.159000,0.000000,45.984000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<2.841000,0.000000,48.016000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<7.159000,0.000000,48.016000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.238000,0.000000,47.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.619000,0.000000,47.000000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.238000,0.000000,47.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.619000,0.000000,47.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.746000,0.000000,47.000000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.619000,0.000000,47.000000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<4.746000,0.000000,47.000000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<4.746000,0.000000,46.238000>}
box{<0,0,-0.127000><0.762000,0.036000,0.127000> rotate<0,-90.000000,0> translate<4.746000,0.000000,46.238000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<4.746000,0.000000,47.000000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<4.746000,0.000000,47.762000>}
box{<0,0,-0.127000><0.762000,0.036000,0.127000> rotate<0,90.000000,0> translate<4.746000,0.000000,47.762000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<5.254000,0.000000,46.238000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<5.254000,0.000000,47.000000>}
box{<0,0,-0.127000><0.762000,0.036000,0.127000> rotate<0,90.000000,0> translate<5.254000,0.000000,47.000000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<5.254000,0.000000,47.000000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<5.254000,0.000000,47.762000>}
box{<0,0,-0.127000><0.762000,0.036000,0.127000> rotate<0,90.000000,0> translate<5.254000,0.000000,47.762000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.254000,0.000000,47.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.381000,0.000000,47.000000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.254000,0.000000,47.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.381000,0.000000,47.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.762000,0.000000,47.000000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.381000,0.000000,47.000000> }
//C4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.651000,0.000000,12.730000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.397000,0.000000,12.730000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.397000,0.000000,12.730000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.397000,0.000000,12.984000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.397000,0.000000,12.730000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<23.397000,0.000000,12.730000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.397000,0.000000,12.730000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.143000,0.000000,12.730000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.143000,0.000000,12.730000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.397000,0.000000,12.730000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.397000,0.000000,12.476000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<23.397000,0.000000,12.476000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.651000,0.000000,14.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.762000,0.000000,14.000000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.762000,0.000000,14.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.762000,0.000000,14.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.762000,0.000000,15.270000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<22.762000,0.000000,15.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.762000,0.000000,15.270000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.254000,0.000000,15.270000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.254000,0.000000,15.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.254000,0.000000,15.270000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.254000,0.000000,12.730000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<22.254000,0.000000,12.730000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.254000,0.000000,12.730000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.762000,0.000000,12.730000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.254000,0.000000,12.730000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.762000,0.000000,12.730000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.762000,0.000000,14.000000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<22.762000,0.000000,14.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.365000,0.000000,14.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.349000,0.000000,14.000000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<20.349000,0.000000,14.000000> }
difference{
cylinder{<22.000000,0,14.000000><22.000000,0.036000,14.000000>2.616200 translate<0,0.000000,0>}
cylinder{<22.000000,-0.1,14.000000><22.000000,0.135000,14.000000>2.463800 translate<0,0.000000,0>}}
box{<-0.254000,0,-1.270000><0.254000,0.036000,1.270000> rotate<0,-180.000000,0> translate<21.492000,0.000000,14.000000>}
//C5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.349000,0.000000,15.270000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.603000,0.000000,15.270000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.349000,0.000000,15.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.603000,0.000000,15.016000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.603000,0.000000,15.270000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.603000,0.000000,15.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.603000,0.000000,15.270000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.857000,0.000000,15.270000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.603000,0.000000,15.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.603000,0.000000,15.270000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.603000,0.000000,15.524000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.603000,0.000000,15.524000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.349000,0.000000,14.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.238000,0.000000,14.000000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.349000,0.000000,14.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.238000,0.000000,14.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.238000,0.000000,12.730000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<15.238000,0.000000,12.730000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.238000,0.000000,12.730000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.746000,0.000000,12.730000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<15.238000,0.000000,12.730000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.746000,0.000000,12.730000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.746000,0.000000,15.270000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<15.746000,0.000000,15.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.746000,0.000000,15.270000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.238000,0.000000,15.270000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<15.238000,0.000000,15.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.238000,0.000000,15.270000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.238000,0.000000,14.000000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<15.238000,0.000000,14.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.635000,0.000000,14.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.651000,0.000000,14.000000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.635000,0.000000,14.000000> }
difference{
cylinder{<16.000000,0,14.000000><16.000000,0.036000,14.000000>2.616200 translate<0,0.000000,0>}
cylinder{<16.000000,-0.1,14.000000><16.000000,0.135000,14.000000>2.463800 translate<0,0.000000,0>}}
box{<-0.254000,0,-1.270000><0.254000,0.036000,1.270000> rotate<0,-0.000000,0> translate<16.508000,0.000000,14.000000>}
//C6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.349000,0.000000,21.270000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.603000,0.000000,21.270000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.349000,0.000000,21.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.603000,0.000000,21.016000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.603000,0.000000,21.270000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.603000,0.000000,21.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.603000,0.000000,21.270000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.857000,0.000000,21.270000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.603000,0.000000,21.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.603000,0.000000,21.270000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.603000,0.000000,21.524000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.603000,0.000000,21.524000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.349000,0.000000,20.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.238000,0.000000,20.000000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.349000,0.000000,20.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.238000,0.000000,20.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.238000,0.000000,18.730000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<15.238000,0.000000,18.730000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.238000,0.000000,18.730000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.746000,0.000000,18.730000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<15.238000,0.000000,18.730000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.746000,0.000000,18.730000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.746000,0.000000,21.270000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<15.746000,0.000000,21.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.746000,0.000000,21.270000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.238000,0.000000,21.270000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<15.238000,0.000000,21.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.238000,0.000000,21.270000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.238000,0.000000,20.000000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<15.238000,0.000000,20.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.635000,0.000000,20.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.651000,0.000000,20.000000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.635000,0.000000,20.000000> }
difference{
cylinder{<16.000000,0,20.000000><16.000000,0.036000,20.000000>2.616200 translate<0,0.000000,0>}
cylinder{<16.000000,-0.1,20.000000><16.000000,0.135000,20.000000>2.463800 translate<0,0.000000,0>}}
box{<-0.254000,0,-1.270000><0.254000,0.036000,1.270000> rotate<0,-0.000000,0> translate<16.508000,0.000000,20.000000>}
//C7 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.841000,0.000000,19.270000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.159000,0.000000,19.270000>}
box{<0,0,-0.076200><4.318000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.841000,0.000000,19.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.159000,0.000000,16.730000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.841000,0.000000,16.730000>}
box{<0,0,-0.076200><4.318000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.841000,0.000000,16.730000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.413000,0.000000,19.016000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.413000,0.000000,16.984000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<24.413000,0.000000,16.984000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.587000,0.000000,19.016000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.587000,0.000000,16.984000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<19.587000,0.000000,16.984000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<24.159000,0.000000,19.016000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<19.841000,0.000000,19.016000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<24.159000,0.000000,16.984000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<19.841000,0.000000,16.984000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.762000,0.000000,18.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.381000,0.000000,18.000000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.381000,0.000000,18.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.381000,0.000000,18.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.254000,0.000000,18.000000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.254000,0.000000,18.000000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<22.254000,0.000000,18.000000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<22.254000,0.000000,18.762000>}
box{<0,0,-0.127000><0.762000,0.036000,0.127000> rotate<0,90.000000,0> translate<22.254000,0.000000,18.762000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<22.254000,0.000000,18.000000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<22.254000,0.000000,17.238000>}
box{<0,0,-0.127000><0.762000,0.036000,0.127000> rotate<0,-90.000000,0> translate<22.254000,0.000000,17.238000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<21.746000,0.000000,18.762000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<21.746000,0.000000,18.000000>}
box{<0,0,-0.127000><0.762000,0.036000,0.127000> rotate<0,-90.000000,0> translate<21.746000,0.000000,18.000000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<21.746000,0.000000,18.000000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<21.746000,0.000000,17.238000>}
box{<0,0,-0.127000><0.762000,0.036000,0.127000> rotate<0,-90.000000,0> translate<21.746000,0.000000,17.238000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.746000,0.000000,18.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.619000,0.000000,18.000000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.619000,0.000000,18.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.619000,0.000000,18.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.238000,0.000000,18.000000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.238000,0.000000,18.000000> }
//C8 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.730000,0.000000,27.841000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.730000,0.000000,32.159000>}
box{<0,0,-0.076200><4.318000,0.036000,0.076200> rotate<0,90.000000,0> translate<19.730000,0.000000,32.159000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.270000,0.000000,32.159000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.270000,0.000000,27.841000>}
box{<0,0,-0.076200><4.318000,0.036000,0.076200> rotate<0,-90.000000,0> translate<22.270000,0.000000,27.841000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.984000,0.000000,32.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.016000,0.000000,32.413000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.984000,0.000000,32.413000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.984000,0.000000,27.587000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.016000,0.000000,27.587000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.984000,0.000000,27.587000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<19.984000,0.000000,32.159000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<19.984000,0.000000,27.841000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<22.016000,0.000000,32.159000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<22.016000,0.000000,27.841000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.000000,0.000000,30.762000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.000000,0.000000,30.381000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<21.000000,0.000000,30.381000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.000000,0.000000,30.381000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.000000,0.000000,30.254000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<21.000000,0.000000,30.254000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<21.000000,0.000000,30.254000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<20.238000,0.000000,30.254000>}
box{<0,0,-0.127000><0.762000,0.036000,0.127000> rotate<0,0.000000,0> translate<20.238000,0.000000,30.254000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<21.000000,0.000000,30.254000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<21.762000,0.000000,30.254000>}
box{<0,0,-0.127000><0.762000,0.036000,0.127000> rotate<0,0.000000,0> translate<21.000000,0.000000,30.254000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<20.238000,0.000000,29.746000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<21.000000,0.000000,29.746000>}
box{<0,0,-0.127000><0.762000,0.036000,0.127000> rotate<0,0.000000,0> translate<20.238000,0.000000,29.746000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<21.000000,0.000000,29.746000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<21.762000,0.000000,29.746000>}
box{<0,0,-0.127000><0.762000,0.036000,0.127000> rotate<0,0.000000,0> translate<21.000000,0.000000,29.746000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.000000,0.000000,29.746000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.000000,0.000000,29.619000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<21.000000,0.000000,29.619000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.000000,0.000000,29.619000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.000000,0.000000,29.238000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<21.000000,0.000000,29.238000> }
//C9 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.349000,0.000000,27.270000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.603000,0.000000,27.270000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.349000,0.000000,27.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.603000,0.000000,27.016000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.603000,0.000000,27.270000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<27.603000,0.000000,27.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.603000,0.000000,27.270000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.857000,0.000000,27.270000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.603000,0.000000,27.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.603000,0.000000,27.270000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.603000,0.000000,27.524000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<27.603000,0.000000,27.524000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.349000,0.000000,26.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.238000,0.000000,26.000000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.349000,0.000000,26.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.238000,0.000000,26.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.238000,0.000000,24.730000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<28.238000,0.000000,24.730000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.238000,0.000000,24.730000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.746000,0.000000,24.730000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<28.238000,0.000000,24.730000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.746000,0.000000,24.730000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.746000,0.000000,27.270000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<28.746000,0.000000,27.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.746000,0.000000,27.270000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.238000,0.000000,27.270000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<28.238000,0.000000,27.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.238000,0.000000,27.270000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.238000,0.000000,26.000000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<28.238000,0.000000,26.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.635000,0.000000,26.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.651000,0.000000,26.000000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<29.635000,0.000000,26.000000> }
difference{
cylinder{<29.000000,0,26.000000><29.000000,0.036000,26.000000>2.616200 translate<0,0.000000,0>}
cylinder{<29.000000,-0.1,26.000000><29.000000,0.135000,26.000000>2.463800 translate<0,0.000000,0>}}
box{<-0.254000,0,-1.270000><0.254000,0.036000,1.270000> rotate<0,-0.000000,0> translate<29.508000,0.000000,26.000000>}
//C10 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.159000,0.000000,18.730000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.841000,0.000000,18.730000>}
box{<0,0,-0.076200><4.318000,0.036000,0.076200> rotate<0,0.000000,0> translate<54.841000,0.000000,18.730000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.841000,0.000000,21.270000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.159000,0.000000,21.270000>}
box{<0,0,-0.076200><4.318000,0.036000,0.076200> rotate<0,0.000000,0> translate<54.841000,0.000000,21.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.587000,0.000000,18.984000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.587000,0.000000,21.016000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<54.587000,0.000000,21.016000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.413000,0.000000,18.984000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.413000,0.000000,21.016000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<59.413000,0.000000,21.016000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<54.841000,0.000000,18.984000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<59.159000,0.000000,18.984000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<54.841000,0.000000,21.016000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<59.159000,0.000000,21.016000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.238000,0.000000,20.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.619000,0.000000,20.000000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<56.238000,0.000000,20.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.619000,0.000000,20.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.746000,0.000000,20.000000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<56.619000,0.000000,20.000000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<56.746000,0.000000,20.000000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<56.746000,0.000000,19.238000>}
box{<0,0,-0.127000><0.762000,0.036000,0.127000> rotate<0,-90.000000,0> translate<56.746000,0.000000,19.238000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<56.746000,0.000000,20.000000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<56.746000,0.000000,20.762000>}
box{<0,0,-0.127000><0.762000,0.036000,0.127000> rotate<0,90.000000,0> translate<56.746000,0.000000,20.762000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<57.254000,0.000000,19.238000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<57.254000,0.000000,20.000000>}
box{<0,0,-0.127000><0.762000,0.036000,0.127000> rotate<0,90.000000,0> translate<57.254000,0.000000,20.000000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<57.254000,0.000000,20.000000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<57.254000,0.000000,20.762000>}
box{<0,0,-0.127000><0.762000,0.036000,0.127000> rotate<0,90.000000,0> translate<57.254000,0.000000,20.762000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.254000,0.000000,20.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.381000,0.000000,20.000000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<57.254000,0.000000,20.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.381000,0.000000,20.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.762000,0.000000,20.000000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<57.381000,0.000000,20.000000> }
//C11 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.349000,0.000000,44.270000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.603000,0.000000,44.270000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<51.349000,0.000000,44.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.603000,0.000000,44.016000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.603000,0.000000,44.270000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<51.603000,0.000000,44.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.603000,0.000000,44.270000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.857000,0.000000,44.270000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<51.603000,0.000000,44.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.603000,0.000000,44.270000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.603000,0.000000,44.524000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<51.603000,0.000000,44.524000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.349000,0.000000,43.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.238000,0.000000,43.000000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<51.349000,0.000000,43.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.238000,0.000000,43.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.238000,0.000000,41.730000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<52.238000,0.000000,41.730000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.238000,0.000000,41.730000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.746000,0.000000,41.730000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<52.238000,0.000000,41.730000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.746000,0.000000,41.730000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.746000,0.000000,44.270000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<52.746000,0.000000,44.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.746000,0.000000,44.270000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.238000,0.000000,44.270000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<52.238000,0.000000,44.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.238000,0.000000,44.270000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.238000,0.000000,43.000000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<52.238000,0.000000,43.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.635000,0.000000,43.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.651000,0.000000,43.000000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.635000,0.000000,43.000000> }
difference{
cylinder{<53.000000,0,43.000000><53.000000,0.036000,43.000000>2.616200 translate<0,0.000000,0>}
cylinder{<53.000000,-0.1,43.000000><53.000000,0.135000,43.000000>2.463800 translate<0,0.000000,0>}}
box{<-0.254000,0,-1.270000><0.254000,0.036000,1.270000> rotate<0,-0.000000,0> translate<53.508000,0.000000,43.000000>}
//C12 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.659000,0.000000,2.730000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.341000,0.000000,2.730000>}
box{<0,0,-0.076200><4.318000,0.036000,0.076200> rotate<0,0.000000,0> translate<41.341000,0.000000,2.730000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.341000,0.000000,5.270000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.659000,0.000000,5.270000>}
box{<0,0,-0.076200><4.318000,0.036000,0.076200> rotate<0,0.000000,0> translate<41.341000,0.000000,5.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.087000,0.000000,2.984000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.087000,0.000000,5.016000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<41.087000,0.000000,5.016000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.913000,0.000000,2.984000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.913000,0.000000,5.016000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<45.913000,0.000000,5.016000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<41.341000,0.000000,2.984000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<45.659000,0.000000,2.984000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<41.341000,0.000000,5.016000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<45.659000,0.000000,5.016000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.738000,0.000000,4.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.119000,0.000000,4.000000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<42.738000,0.000000,4.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.119000,0.000000,4.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.246000,0.000000,4.000000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.119000,0.000000,4.000000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<43.246000,0.000000,4.000000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<43.246000,0.000000,3.238000>}
box{<0,0,-0.127000><0.762000,0.036000,0.127000> rotate<0,-90.000000,0> translate<43.246000,0.000000,3.238000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<43.246000,0.000000,4.000000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<43.246000,0.000000,4.762000>}
box{<0,0,-0.127000><0.762000,0.036000,0.127000> rotate<0,90.000000,0> translate<43.246000,0.000000,4.762000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<43.754000,0.000000,3.238000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<43.754000,0.000000,4.000000>}
box{<0,0,-0.127000><0.762000,0.036000,0.127000> rotate<0,90.000000,0> translate<43.754000,0.000000,4.000000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<43.754000,0.000000,4.000000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<43.754000,0.000000,4.762000>}
box{<0,0,-0.127000><0.762000,0.036000,0.127000> rotate<0,90.000000,0> translate<43.754000,0.000000,4.762000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.754000,0.000000,4.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.881000,0.000000,4.000000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.754000,0.000000,4.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.881000,0.000000,4.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.262000,0.000000,4.000000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.881000,0.000000,4.000000> }
//D1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.032000,0.000000,21.730000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.968000,0.000000,21.730000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,0.000000,0> translate<64.968000,0.000000,21.730000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.032000,0.000000,21.730000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.032000,0.000000,24.270000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<69.032000,0.000000,24.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.968000,0.000000,24.270000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.032000,0.000000,24.270000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,0.000000,0> translate<64.968000,0.000000,24.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.968000,0.000000,24.270000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.968000,0.000000,21.730000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<64.968000,0.000000,21.730000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<72.080000,0.000000,23.000000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<71.064000,0.000000,23.000000>}
box{<0,0,-0.381000><1.016000,0.036000,0.381000> rotate<0,0.000000,0> translate<71.064000,0.000000,23.000000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<61.920000,0.000000,23.000000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<62.936000,0.000000,23.000000>}
box{<0,0,-0.381000><1.016000,0.036000,0.381000> rotate<0,0.000000,0> translate<61.920000,0.000000,23.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.365000,0.000000,23.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.000000,0.000000,23.000000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.365000,0.000000,23.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.016000,0.000000,23.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.016000,0.000000,22.365000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<68.016000,0.000000,22.365000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.016000,0.000000,22.365000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.000000,0.000000,23.000000>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,32.003271,0> translate<67.000000,0.000000,23.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.000000,0.000000,23.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.524000,0.000000,23.000000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.000000,0.000000,23.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.000000,0.000000,23.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.016000,0.000000,23.635000>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,-32.003271,0> translate<67.000000,0.000000,23.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.000000,0.000000,23.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.000000,0.000000,23.000000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.000000,0.000000,23.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.000000,0.000000,23.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.000000,0.000000,22.365000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.000000,0.000000,22.365000> }
box{<-0.254000,0,-1.270000><0.254000,0.036000,1.270000> rotate<0,-0.000000,0> translate<65.603000,0.000000,23.000000>}
box{<-0.952500,0,-0.381000><0.952500,0.036000,0.381000> rotate<0,-0.000000,0> translate<69.984500,0.000000,23.000000>}
box{<-0.952500,0,-0.381000><0.952500,0.036000,0.381000> rotate<0,-0.000000,0> translate<64.015500,0.000000,23.000000>}
//D2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.270000,0.000000,29.032000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.270000,0.000000,24.968000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,-90.000000,0> translate<7.270000,0.000000,24.968000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.270000,0.000000,29.032000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.730000,0.000000,29.032000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.730000,0.000000,29.032000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.730000,0.000000,24.968000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.730000,0.000000,29.032000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,90.000000,0> translate<4.730000,0.000000,29.032000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.730000,0.000000,24.968000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.270000,0.000000,24.968000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.730000,0.000000,24.968000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<6.000000,0.000000,32.080000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<6.000000,0.000000,31.064000>}
box{<0,0,-0.381000><1.016000,0.036000,0.381000> rotate<0,-90.000000,0> translate<6.000000,0.000000,31.064000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<6.000000,0.000000,21.920000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<6.000000,0.000000,22.936000>}
box{<0,0,-0.381000><1.016000,0.036000,0.381000> rotate<0,90.000000,0> translate<6.000000,0.000000,22.936000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.000000,0.000000,26.365000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.000000,0.000000,27.000000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,90.000000,0> translate<6.000000,0.000000,27.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.365000,0.000000,28.016000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.635000,0.000000,28.016000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.365000,0.000000,28.016000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.635000,0.000000,28.016000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.000000,0.000000,27.000000>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,-57.990789,0> translate<6.000000,0.000000,27.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.000000,0.000000,27.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.000000,0.000000,28.524000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<6.000000,0.000000,28.524000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.000000,0.000000,27.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.365000,0.000000,28.016000>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,57.990789,0> translate<5.365000,0.000000,28.016000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.365000,0.000000,27.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.000000,0.000000,27.000000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.365000,0.000000,27.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.000000,0.000000,27.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.635000,0.000000,27.000000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.000000,0.000000,27.000000> }
box{<-0.254000,0,-1.270000><0.254000,0.036000,1.270000> rotate<0,-90.000000,0> translate<6.000000,0.000000,25.603000>}
box{<-0.952500,0,-0.381000><0.952500,0.036000,0.381000> rotate<0,-90.000000,0> translate<6.000000,0.000000,29.984500>}
box{<-0.952500,0,-0.381000><0.952500,0.036000,0.381000> rotate<0,-90.000000,0> translate<6.000000,0.000000,24.015500>}
//D3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.032000,0.000000,45.730000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.968000,0.000000,45.730000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.968000,0.000000,45.730000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.032000,0.000000,45.730000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.032000,0.000000,48.270000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<58.032000,0.000000,48.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.968000,0.000000,48.270000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.032000,0.000000,48.270000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.968000,0.000000,48.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.968000,0.000000,48.270000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.968000,0.000000,45.730000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<53.968000,0.000000,45.730000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<61.080000,0.000000,47.000000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<60.064000,0.000000,47.000000>}
box{<0,0,-0.381000><1.016000,0.036000,0.381000> rotate<0,0.000000,0> translate<60.064000,0.000000,47.000000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<50.920000,0.000000,47.000000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<51.936000,0.000000,47.000000>}
box{<0,0,-0.381000><1.016000,0.036000,0.381000> rotate<0,0.000000,0> translate<50.920000,0.000000,47.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.365000,0.000000,47.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.000000,0.000000,47.000000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<55.365000,0.000000,47.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.016000,0.000000,47.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.016000,0.000000,46.365000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<57.016000,0.000000,46.365000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.016000,0.000000,46.365000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.000000,0.000000,47.000000>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,32.003271,0> translate<56.000000,0.000000,47.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.000000,0.000000,47.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.524000,0.000000,47.000000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<56.000000,0.000000,47.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.000000,0.000000,47.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.016000,0.000000,47.635000>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,-32.003271,0> translate<56.000000,0.000000,47.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.000000,0.000000,47.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.000000,0.000000,47.000000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,-90.000000,0> translate<56.000000,0.000000,47.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.000000,0.000000,47.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.000000,0.000000,46.365000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,-90.000000,0> translate<56.000000,0.000000,46.365000> }
box{<-0.254000,0,-1.270000><0.254000,0.036000,1.270000> rotate<0,-0.000000,0> translate<54.603000,0.000000,47.000000>}
box{<-0.952500,0,-0.381000><0.952500,0.036000,0.381000> rotate<0,-0.000000,0> translate<58.984500,0.000000,47.000000>}
box{<-0.952500,0,-0.381000><0.952500,0.036000,0.381000> rotate<0,-0.000000,0> translate<53.015500,0.000000,47.000000>}
//IC1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.458000,0.000000,41.365000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.458000,0.000000,39.206000>}
box{<0,0,-0.076200><2.159000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.458000,0.000000,39.206000> }
object{ARC(0.635000,0.152400,270.000000,450.000000,0.036000) translate<10.458000,0.000000,42.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.458000,0.000000,39.206000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.542000,0.000000,39.206000>}
box{<0,0,-0.076200><37.084000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.458000,0.000000,39.206000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.458000,0.000000,44.794000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.458000,0.000000,42.635000>}
box{<0,0,-0.076200><2.159000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.458000,0.000000,42.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.458000,0.000000,44.794000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.542000,0.000000,44.794000>}
box{<0,0,-0.076200><37.084000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.458000,0.000000,44.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.542000,0.000000,44.794000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.542000,0.000000,39.206000>}
box{<0,0,-0.076200><5.588000,0.036000,0.076200> rotate<0,-90.000000,0> translate<47.542000,0.000000,39.206000> }
//IC2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.380000,0.000000,34.207000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.380000,0.000000,23.793000>}
box{<0,0,-0.076200><10.414000,0.036000,0.076200> rotate<0,-90.000000,0> translate<12.380000,0.000000,23.793000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.255000,0.000000,23.793000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.255000,0.000000,34.207000>}
box{<0,0,-0.076200><10.414000,0.036000,0.076200> rotate<0,90.000000,0> translate<28.255000,0.000000,34.207000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.380000,0.000000,23.793000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.826000,0.000000,23.793000>}
box{<0,0,-0.076200><12.446000,0.036000,0.076200> rotate<0,0.000000,0> translate<12.380000,0.000000,23.793000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.826000,0.000000,23.793000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.826000,0.000000,24.682000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,90.000000,0> translate<24.826000,0.000000,24.682000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.826000,0.000000,24.682000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.350000,0.000000,24.682000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.826000,0.000000,24.682000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.350000,0.000000,24.682000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.350000,0.000000,23.793000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,-90.000000,0> translate<26.350000,0.000000,23.793000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.350000,0.000000,23.793000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.255000,0.000000,23.793000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<26.350000,0.000000,23.793000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.380000,0.000000,34.207000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.826000,0.000000,34.207000>}
box{<0,0,-0.076200><12.446000,0.036000,0.076200> rotate<0,0.000000,0> translate<12.380000,0.000000,34.207000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.826000,0.000000,34.207000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.826000,0.000000,33.318000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,-90.000000,0> translate<24.826000,0.000000,33.318000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.826000,0.000000,33.318000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.350000,0.000000,33.318000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.826000,0.000000,33.318000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.350000,0.000000,33.318000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.350000,0.000000,34.207000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,90.000000,0> translate<26.350000,0.000000,34.207000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.350000,0.000000,34.207000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.255000,0.000000,34.207000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<26.350000,0.000000,34.207000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<13.015000,0.000000,33.572000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<13.015000,0.000000,24.428000>}
box{<0,0,-0.025400><9.144000,0.036000,0.025400> rotate<0,-90.000000,0> translate<13.015000,0.000000,24.428000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<21.270000,0.000000,24.428000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<13.015000,0.000000,24.428000>}
box{<0,0,-0.025400><8.255000,0.036000,0.025400> rotate<0,0.000000,0> translate<13.015000,0.000000,24.428000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<21.270000,0.000000,24.428000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<21.270000,0.000000,33.572000>}
box{<0,0,-0.025400><9.144000,0.036000,0.025400> rotate<0,90.000000,0> translate<21.270000,0.000000,33.572000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<13.015000,0.000000,33.572000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<21.270000,0.000000,33.572000>}
box{<0,0,-0.025400><8.255000,0.036000,0.025400> rotate<0,0.000000,0> translate<13.015000,0.000000,33.572000> }
difference{
cylinder{<24.826000,0,29.000000><24.826000,0.036000,29.000000>1.879600 translate<0,0.000000,0>}
cylinder{<24.826000,-0.1,29.000000><24.826000,0.135000,29.000000>1.727200 translate<0,0.000000,0>}}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-270.000000,0> translate<9.268500,0.000000,26.460000>}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-270.000000,0> translate<9.268500,0.000000,29.000000>}
box{<-0.381000,0,-0.317500><0.381000,0.036000,0.317500> rotate<0,-270.000000,0> translate<9.268500,0.000000,31.540000>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-270.000000,0> translate<10.983000,0.000000,31.540000>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-270.000000,0> translate<10.983000,0.000000,29.000000>}
box{<-0.635000,0,-1.397000><0.635000,0.036000,1.397000> rotate<0,-270.000000,0> translate<10.983000,0.000000,26.460000>}
//J1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.900000,0.000000,35.700000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.900000,0.000000,44.300000>}
box{<0,0,-0.101600><8.600000,0.036000,0.101600> rotate<0,90.000000,0> translate<8.900000,0.000000,44.300000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.900000,0.000000,42.700000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.900000,0.000000,44.300000>}
box{<0,0,-0.101600><1.600000,0.036000,0.101600> rotate<0,90.000000,0> translate<8.900000,0.000000,44.300000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.900000,0.000000,35.700000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.900000,0.000000,37.300000>}
box{<0,0,-0.101600><1.600000,0.036000,0.101600> rotate<0,90.000000,0> translate<8.900000,0.000000,37.300000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<2.000000,0.000000,37.000000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<2.000000,0.000000,43.000000>}
box{<0,0,-0.101600><6.000000,0.036000,0.101600> rotate<0,90.000000,0> translate<2.000000,0.000000,43.000000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.300000,0.000000,35.700000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.900000,0.000000,35.700000>}
box{<0,0,-0.101600><1.600000,0.036000,0.101600> rotate<0,0.000000,0> translate<7.300000,0.000000,35.700000> }
//JP1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.905000,-1.536000,28.810000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.905000,-1.536000,26.270000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<0.905000,-1.536000,26.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.905000,-1.536000,26.270000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.905000,-1.536000,23.730000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<0.905000,-1.536000,23.730000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.905000,-1.536000,23.730000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.905000,-1.536000,21.190000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<0.905000,-1.536000,21.190000> }
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-270.000000,0> translate<1.413000,-1.536000,27.540000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-270.000000,0> translate<1.413000,-1.536000,25.000000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-270.000000,0> translate<1.413000,-1.536000,22.460000>}
//LED1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<31.074800,0.000000,4.230000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<31.074800,0.000000,6.770000>}
box{<0,0,-0.127000><2.540000,0.036000,0.127000> rotate<0,90.000000,0> translate<31.074800,0.000000,6.770000> }
object{ARC(1.524000,0.152400,140.196354,180.000000,0.036000) translate<29.500000,0.000000,5.500000>}
object{ARC(1.524000,0.152400,179.996240,221.629793,0.036000) translate<29.500000,0.000000,5.499900>}
object{ARC(1.524000,0.152400,0.000000,40.601295,0.036000) translate<29.500000,0.000000,5.500000>}
object{ARC(1.524000,0.152400,320.196354,360.000000,0.036000) translate<29.500000,0.000000,5.500000>}
object{ARC(1.524000,0.152400,35.538115,90.000000,0.036000) translate<29.500000,0.000000,5.500000>}
object{ARC(1.524000,0.152400,90.000000,143.130102,0.036000) translate<29.500000,0.000000,5.500000>}
object{ARC(1.524000,0.152400,270.000000,322.126995,0.036000) translate<29.500000,0.000000,5.500000>}
object{ARC(1.524000,0.152400,217.873005,270.000000,0.036000) translate<29.500000,0.000000,5.500000>}
object{ARC(0.635000,0.152400,90.000000,180.000000,0.036000) translate<29.500000,0.000000,5.500000>}
object{ARC(1.016000,0.152400,90.000000,180.000000,0.036000) translate<29.500000,0.000000,5.500000>}
object{ARC(0.635000,0.152400,270.000000,360.000000,0.036000) translate<29.500000,0.000000,5.500000>}
object{ARC(1.016000,0.152400,270.000000,360.000000,0.036000) translate<29.500000,0.000000,5.500000>}
object{ARC(2.032000,0.254000,39.807015,90.000000,0.036000) translate<29.500000,0.000000,5.500000>}
object{ARC(2.032000,0.254000,90.002820,151.929172,0.036000) translate<29.500100,0.000000,5.500000>}
object{ARC(2.032000,0.254000,270.000000,319.762648,0.036000) translate<29.500000,0.000000,5.500000>}
object{ARC(2.032000,0.254000,209.746980,270.002820,0.036000) translate<29.499900,0.000000,5.500000>}
object{ARC(2.032000,0.254000,151.698289,180.000000,0.036000) translate<29.500000,0.000000,5.500000>}
object{ARC(2.032000,0.254000,179.997180,211.605470,0.036000) translate<29.500000,0.000000,5.499900>}
//LED2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<35.270000,0.000000,7.574800>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<32.730000,0.000000,7.574800>}
box{<0,0,-0.127000><2.540000,0.036000,0.127000> rotate<0,0.000000,0> translate<32.730000,0.000000,7.574800> }
object{ARC(1.524000,0.152400,230.196354,270.000000,0.036000) translate<34.000000,0.000000,6.000000>}
object{ARC(1.524000,0.152400,269.996240,311.629793,0.036000) translate<34.000100,0.000000,6.000000>}
object{ARC(1.524000,0.152400,90.000000,130.601295,0.036000) translate<34.000000,0.000000,6.000000>}
object{ARC(1.524000,0.152400,50.196354,90.000000,0.036000) translate<34.000000,0.000000,6.000000>}
object{ARC(1.524000,0.152400,125.538115,180.000000,0.036000) translate<34.000000,0.000000,6.000000>}
object{ARC(1.524000,0.152400,180.000000,233.130102,0.036000) translate<34.000000,0.000000,6.000000>}
object{ARC(1.524000,0.152400,0.000000,52.126995,0.036000) translate<34.000000,0.000000,6.000000>}
object{ARC(1.524000,0.152400,307.873005,360.000000,0.036000) translate<34.000000,0.000000,6.000000>}
object{ARC(0.635000,0.152400,180.000000,270.000000,0.036000) translate<34.000000,0.000000,6.000000>}
object{ARC(1.016000,0.152400,180.000000,270.000000,0.036000) translate<34.000000,0.000000,6.000000>}
object{ARC(0.635000,0.152400,0.000000,90.000000,0.036000) translate<34.000000,0.000000,6.000000>}
object{ARC(1.016000,0.152400,0.000000,90.000000,0.036000) translate<34.000000,0.000000,6.000000>}
object{ARC(2.032000,0.254000,129.807015,180.000000,0.036000) translate<34.000000,0.000000,6.000000>}
object{ARC(2.032000,0.254000,180.002820,241.929172,0.036000) translate<34.000000,0.000000,6.000100>}
object{ARC(2.032000,0.254000,0.000000,49.762648,0.036000) translate<34.000000,0.000000,6.000000>}
object{ARC(2.032000,0.254000,299.746980,360.002820,0.036000) translate<34.000000,0.000000,5.999900>}
object{ARC(2.032000,0.254000,241.698289,270.000000,0.036000) translate<34.000000,0.000000,6.000000>}
object{ARC(2.032000,0.254000,269.997180,301.605470,0.036000) translate<34.000100,0.000000,6.000000>}
//LED3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<59.574800,0.000000,6.730000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<59.574800,0.000000,9.270000>}
box{<0,0,-0.127000><2.540000,0.036000,0.127000> rotate<0,90.000000,0> translate<59.574800,0.000000,9.270000> }
object{ARC(1.524000,0.152400,140.196354,180.000000,0.036000) translate<58.000000,0.000000,8.000000>}
object{ARC(1.524000,0.152400,179.996240,221.629793,0.036000) translate<58.000000,0.000000,7.999900>}
object{ARC(1.524000,0.152400,0.000000,40.601295,0.036000) translate<58.000000,0.000000,8.000000>}
object{ARC(1.524000,0.152400,320.196354,360.000000,0.036000) translate<58.000000,0.000000,8.000000>}
object{ARC(1.524000,0.152400,35.538115,90.000000,0.036000) translate<58.000000,0.000000,8.000000>}
object{ARC(1.524000,0.152400,90.000000,143.130102,0.036000) translate<58.000000,0.000000,8.000000>}
object{ARC(1.524000,0.152400,270.000000,322.126995,0.036000) translate<58.000000,0.000000,8.000000>}
object{ARC(1.524000,0.152400,217.873005,270.000000,0.036000) translate<58.000000,0.000000,8.000000>}
object{ARC(0.635000,0.152400,90.000000,180.000000,0.036000) translate<58.000000,0.000000,8.000000>}
object{ARC(1.016000,0.152400,90.000000,180.000000,0.036000) translate<58.000000,0.000000,8.000000>}
object{ARC(0.635000,0.152400,270.000000,360.000000,0.036000) translate<58.000000,0.000000,8.000000>}
object{ARC(1.016000,0.152400,270.000000,360.000000,0.036000) translate<58.000000,0.000000,8.000000>}
object{ARC(2.032000,0.254000,39.807015,90.000000,0.036000) translate<58.000000,0.000000,8.000000>}
object{ARC(2.032000,0.254000,90.002820,151.929172,0.036000) translate<58.000100,0.000000,8.000000>}
object{ARC(2.032000,0.254000,270.000000,319.762648,0.036000) translate<58.000000,0.000000,8.000000>}
object{ARC(2.032000,0.254000,209.746980,270.002820,0.036000) translate<57.999900,0.000000,8.000000>}
object{ARC(2.032000,0.254000,151.698289,180.000000,0.036000) translate<58.000000,0.000000,8.000000>}
object{ARC(2.032000,0.254000,179.997180,211.605470,0.036000) translate<58.000000,0.000000,7.999900>}
//LED4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<59.574800,0.000000,11.730000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<59.574800,0.000000,14.270000>}
box{<0,0,-0.127000><2.540000,0.036000,0.127000> rotate<0,90.000000,0> translate<59.574800,0.000000,14.270000> }
object{ARC(1.524000,0.152400,140.196354,180.000000,0.036000) translate<58.000000,0.000000,13.000000>}
object{ARC(1.524000,0.152400,179.996240,221.629793,0.036000) translate<58.000000,0.000000,12.999900>}
object{ARC(1.524000,0.152400,0.000000,40.601295,0.036000) translate<58.000000,0.000000,13.000000>}
object{ARC(1.524000,0.152400,320.196354,360.000000,0.036000) translate<58.000000,0.000000,13.000000>}
object{ARC(1.524000,0.152400,35.538115,90.000000,0.036000) translate<58.000000,0.000000,13.000000>}
object{ARC(1.524000,0.152400,90.000000,143.130102,0.036000) translate<58.000000,0.000000,13.000000>}
object{ARC(1.524000,0.152400,270.000000,322.126995,0.036000) translate<58.000000,0.000000,13.000000>}
object{ARC(1.524000,0.152400,217.873005,270.000000,0.036000) translate<58.000000,0.000000,13.000000>}
object{ARC(0.635000,0.152400,90.000000,180.000000,0.036000) translate<58.000000,0.000000,13.000000>}
object{ARC(1.016000,0.152400,90.000000,180.000000,0.036000) translate<58.000000,0.000000,13.000000>}
object{ARC(0.635000,0.152400,270.000000,360.000000,0.036000) translate<58.000000,0.000000,13.000000>}
object{ARC(1.016000,0.152400,270.000000,360.000000,0.036000) translate<58.000000,0.000000,13.000000>}
object{ARC(2.032000,0.254000,39.807015,90.000000,0.036000) translate<58.000000,0.000000,13.000000>}
object{ARC(2.032000,0.254000,90.002820,151.929172,0.036000) translate<58.000100,0.000000,13.000000>}
object{ARC(2.032000,0.254000,270.000000,319.762648,0.036000) translate<58.000000,0.000000,13.000000>}
object{ARC(2.032000,0.254000,209.746980,270.002820,0.036000) translate<57.999900,0.000000,13.000000>}
object{ARC(2.032000,0.254000,151.698289,180.000000,0.036000) translate<58.000000,0.000000,13.000000>}
object{ARC(2.032000,0.254000,179.997180,211.605470,0.036000) translate<58.000000,0.000000,12.999900>}
//LED6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<45.425200,0.000000,19.270000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<45.425200,0.000000,16.730000>}
box{<0,0,-0.127000><2.540000,0.036000,0.127000> rotate<0,-90.000000,0> translate<45.425200,0.000000,16.730000> }
object{ARC(1.524000,0.152400,320.196354,360.000000,0.036000) translate<47.000000,0.000000,18.000000>}
object{ARC(1.524000,0.152400,359.996240,401.629793,0.036000) translate<47.000000,0.000000,18.000100>}
object{ARC(1.524000,0.152400,180.000000,220.601295,0.036000) translate<47.000000,0.000000,18.000000>}
object{ARC(1.524000,0.152400,140.196354,180.000000,0.036000) translate<47.000000,0.000000,18.000000>}
object{ARC(1.524000,0.152400,215.538115,270.000000,0.036000) translate<47.000000,0.000000,18.000000>}
object{ARC(1.524000,0.152400,270.000000,323.130102,0.036000) translate<47.000000,0.000000,18.000000>}
object{ARC(1.524000,0.152400,90.000000,142.126995,0.036000) translate<47.000000,0.000000,18.000000>}
object{ARC(1.524000,0.152400,37.873005,90.000000,0.036000) translate<47.000000,0.000000,18.000000>}
object{ARC(0.635000,0.152400,270.000000,360.000000,0.036000) translate<47.000000,0.000000,18.000000>}
object{ARC(1.016000,0.152400,270.000000,360.000000,0.036000) translate<47.000000,0.000000,18.000000>}
object{ARC(0.635000,0.152400,90.000000,180.000000,0.036000) translate<47.000000,0.000000,18.000000>}
object{ARC(1.016000,0.152400,90.000000,180.000000,0.036000) translate<47.000000,0.000000,18.000000>}
object{ARC(2.032000,0.254000,219.807015,270.000000,0.036000) translate<47.000000,0.000000,18.000000>}
object{ARC(2.032000,0.254000,270.002820,331.929172,0.036000) translate<46.999900,0.000000,18.000000>}
object{ARC(2.032000,0.254000,90.000000,139.762648,0.036000) translate<47.000000,0.000000,18.000000>}
object{ARC(2.032000,0.254000,29.746980,90.002820,0.036000) translate<47.000100,0.000000,18.000000>}
object{ARC(2.032000,0.254000,331.698289,360.000000,0.036000) translate<47.000000,0.000000,18.000000>}
object{ARC(2.032000,0.254000,359.997180,391.605470,0.036000) translate<47.000000,0.000000,18.000100>}
//OK1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.540000,0.000000,32.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.460000,0.000000,32.921000>}
box{<0,0,-0.076200><5.080000,0.036000,0.076200> rotate<0,0.000000,0> translate<55.460000,0.000000,32.921000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.460000,0.000000,27.079000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.540000,0.000000,27.079000>}
box{<0,0,-0.076200><5.080000,0.036000,0.076200> rotate<0,0.000000,0> translate<55.460000,0.000000,27.079000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.540000,0.000000,32.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.540000,0.000000,27.079000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,-90.000000,0> translate<60.540000,0.000000,27.079000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.460000,0.000000,32.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.460000,0.000000,31.016000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<55.460000,0.000000,31.016000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.460000,0.000000,27.079000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.460000,0.000000,28.984000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<55.460000,0.000000,28.984000> }
object{ARC(1.016000,0.152400,270.000000,450.000000,0.036000) translate<55.460000,0.000000,30.000000>}
//Q1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.080000,0.000000,48.985000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.920000,0.000000,48.985000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,0.000000,0> translate<28.920000,0.000000,48.985000> }
cylinder{<0,0,0><0,0.036000,0>0.203200 translate<39.715000,0.000000,35.650000>}
cylinder{<0,0,0><0,0.036000,0>0.203200 translate<39.080000,0.000000,35.650000>}
box{<0,0,-0.203200><0.635000,0.036000,0.203200> rotate<0,0.000000,0> translate<39.080000,0.000000,35.650000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.080000,0.000000,35.650000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.080000,0.000000,48.985000>}
box{<0,0,-0.076200><13.335000,0.036000,0.076200> rotate<0,90.000000,0> translate<39.080000,0.000000,48.985000> }
cylinder{<0,0,0><0,0.036000,0>0.203200 translate<39.080000,0.000000,35.650000>}
cylinder{<0,0,0><0,0.036000,0>0.203200 translate<36.540000,0.000000,35.650000>}
box{<0,0,-0.203200><2.540000,0.036000,0.203200> rotate<0,0.000000,0> translate<36.540000,0.000000,35.650000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.920000,0.000000,35.650000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.920000,0.000000,48.985000>}
box{<0,0,-0.076200><13.335000,0.036000,0.076200> rotate<0,90.000000,0> translate<28.920000,0.000000,48.985000> }
cylinder{<0,0,0><0,0.036000,0>0.203200 translate<28.920000,0.000000,35.650000>}
cylinder{<0,0,0><0,0.036000,0>0.203200 translate<28.285000,0.000000,35.650000>}
box{<0,0,-0.203200><0.635000,0.036000,0.203200> rotate<0,0.000000,0> translate<28.285000,0.000000,35.650000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.540000,0.000000,35.650000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.540000,0.000000,35.015000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,-90.000000,0> translate<36.540000,0.000000,35.015000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.460000,0.000000,35.650000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.460000,0.000000,35.015000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,-90.000000,0> translate<31.460000,0.000000,35.015000> }
cylinder{<0,0,0><0,0.036000,0>0.203200 translate<36.540000,0.000000,35.650000>}
cylinder{<0,0,0><0,0.036000,0>0.203200 translate<31.460000,0.000000,35.650000>}
box{<0,0,-0.203200><5.080000,0.036000,0.203200> rotate<0,0.000000,0> translate<31.460000,0.000000,35.650000> }
cylinder{<0,0,0><0,0.036000,0>0.203200 translate<31.460000,0.000000,35.650000>}
cylinder{<0,0,0><0,0.036000,0>0.203200 translate<28.920000,0.000000,35.650000>}
box{<0,0,-0.203200><2.540000,0.036000,0.203200> rotate<0,0.000000,0> translate<28.920000,0.000000,35.650000> }
//R1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<61.920000,0.000000,19.000000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<62.936000,0.000000,19.000000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<61.920000,0.000000,19.000000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<72.080000,0.000000,19.000000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<71.064000,0.000000,19.000000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<71.064000,0.000000,19.000000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<69.921000,0.000000,18.111000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<69.921000,0.000000,19.889000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<64.079000,0.000000,19.889000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<64.079000,0.000000,18.111000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.175000,0.000000,19.889000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.175000,0.000000,18.111000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<70.175000,0.000000,18.111000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.921000,0.000000,17.857000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.540000,0.000000,17.857000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<69.540000,0.000000,17.857000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.413000,0.000000,17.984000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.540000,0.000000,17.857000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<69.413000,0.000000,17.984000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.921000,0.000000,20.143000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.540000,0.000000,20.143000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<69.540000,0.000000,20.143000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.413000,0.000000,20.016000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.540000,0.000000,20.143000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<69.413000,0.000000,20.016000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.587000,0.000000,17.984000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.460000,0.000000,17.857000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<64.460000,0.000000,17.857000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.587000,0.000000,17.984000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.413000,0.000000,17.984000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<64.587000,0.000000,17.984000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.587000,0.000000,20.016000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.460000,0.000000,20.143000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<64.460000,0.000000,20.143000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.587000,0.000000,20.016000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.413000,0.000000,20.016000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<64.587000,0.000000,20.016000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.079000,0.000000,17.857000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.460000,0.000000,17.857000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<64.079000,0.000000,17.857000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.079000,0.000000,20.143000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.460000,0.000000,20.143000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<64.079000,0.000000,20.143000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.825000,0.000000,19.889000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.825000,0.000000,18.111000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<63.825000,0.000000,18.111000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<63.393200,0.000000,19.000000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<70.606800,0.000000,19.000000>}
//R2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<46.000000,0.000000,33.080000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<46.000000,0.000000,32.064000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<46.000000,0.000000,32.064000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<46.000000,0.000000,22.920000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<46.000000,0.000000,23.936000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<46.000000,0.000000,23.936000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<45.111000,0.000000,25.079000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<46.889000,0.000000,25.079000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<46.889000,0.000000,30.921000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<45.111000,0.000000,30.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.889000,0.000000,24.825000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.111000,0.000000,24.825000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.111000,0.000000,24.825000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.857000,0.000000,25.079000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.857000,0.000000,25.460000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<44.857000,0.000000,25.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.984000,0.000000,25.587000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.857000,0.000000,25.460000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<44.857000,0.000000,25.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.143000,0.000000,25.079000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.143000,0.000000,25.460000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<47.143000,0.000000,25.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.016000,0.000000,25.587000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.143000,0.000000,25.460000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<47.016000,0.000000,25.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.984000,0.000000,30.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.857000,0.000000,30.540000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<44.857000,0.000000,30.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.984000,0.000000,30.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.984000,0.000000,25.587000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.984000,0.000000,25.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.016000,0.000000,30.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.143000,0.000000,30.540000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<47.016000,0.000000,30.413000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.016000,0.000000,30.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.016000,0.000000,25.587000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<47.016000,0.000000,25.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.857000,0.000000,30.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.857000,0.000000,30.540000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.857000,0.000000,30.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.143000,0.000000,30.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.143000,0.000000,30.540000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<47.143000,0.000000,30.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.889000,0.000000,31.175000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.111000,0.000000,31.175000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.111000,0.000000,31.175000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<46.000000,0.000000,31.606800>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<46.000000,0.000000,24.393200>}
//R3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<49.000000,0.000000,33.080000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<49.000000,0.000000,32.064000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<49.000000,0.000000,32.064000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<49.000000,0.000000,22.920000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<49.000000,0.000000,23.936000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<49.000000,0.000000,23.936000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<48.111000,0.000000,25.079000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<49.889000,0.000000,25.079000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<49.889000,0.000000,30.921000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<48.111000,0.000000,30.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.889000,0.000000,24.825000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.111000,0.000000,24.825000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.111000,0.000000,24.825000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.857000,0.000000,25.079000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.857000,0.000000,25.460000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<47.857000,0.000000,25.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.984000,0.000000,25.587000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.857000,0.000000,25.460000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<47.857000,0.000000,25.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.143000,0.000000,25.079000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.143000,0.000000,25.460000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<50.143000,0.000000,25.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.016000,0.000000,25.587000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.143000,0.000000,25.460000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<50.016000,0.000000,25.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.984000,0.000000,30.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.857000,0.000000,30.540000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<47.857000,0.000000,30.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.984000,0.000000,30.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.984000,0.000000,25.587000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<47.984000,0.000000,25.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.016000,0.000000,30.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.143000,0.000000,30.540000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<50.016000,0.000000,30.413000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.016000,0.000000,30.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.016000,0.000000,25.587000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<50.016000,0.000000,25.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.857000,0.000000,30.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.857000,0.000000,30.540000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<47.857000,0.000000,30.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.143000,0.000000,30.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.143000,0.000000,30.540000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<50.143000,0.000000,30.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.889000,0.000000,31.175000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.111000,0.000000,31.175000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.111000,0.000000,31.175000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<49.000000,0.000000,31.606800>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<49.000000,0.000000,24.393200>}
//R4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<52.000000,0.000000,33.080000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<52.000000,0.000000,32.064000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<52.000000,0.000000,32.064000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<52.000000,0.000000,22.920000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<52.000000,0.000000,23.936000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<52.000000,0.000000,23.936000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<51.111000,0.000000,25.079000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<52.889000,0.000000,25.079000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<52.889000,0.000000,30.921000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<51.111000,0.000000,30.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.889000,0.000000,24.825000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.111000,0.000000,24.825000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<51.111000,0.000000,24.825000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.857000,0.000000,25.079000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.857000,0.000000,25.460000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<50.857000,0.000000,25.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.984000,0.000000,25.587000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.857000,0.000000,25.460000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<50.857000,0.000000,25.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.143000,0.000000,25.079000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.143000,0.000000,25.460000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<53.143000,0.000000,25.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.016000,0.000000,25.587000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.143000,0.000000,25.460000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<53.016000,0.000000,25.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.984000,0.000000,30.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.857000,0.000000,30.540000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<50.857000,0.000000,30.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.984000,0.000000,30.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.984000,0.000000,25.587000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<50.984000,0.000000,25.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.016000,0.000000,30.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.143000,0.000000,30.540000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<53.016000,0.000000,30.413000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.016000,0.000000,30.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.016000,0.000000,25.587000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<53.016000,0.000000,25.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.857000,0.000000,30.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.857000,0.000000,30.540000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<50.857000,0.000000,30.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.143000,0.000000,30.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.143000,0.000000,30.540000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<53.143000,0.000000,30.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.889000,0.000000,31.175000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.111000,0.000000,31.175000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<51.111000,0.000000,31.175000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<52.000000,0.000000,31.606800>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<52.000000,0.000000,24.393200>}
//R5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<61.080000,0.000000,38.500000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<60.064000,0.000000,38.500000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<60.064000,0.000000,38.500000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<50.920000,0.000000,38.500000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<51.936000,0.000000,38.500000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<50.920000,0.000000,38.500000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<53.079000,0.000000,39.389000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<53.079000,0.000000,37.611000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<58.921000,0.000000,37.611000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<58.921000,0.000000,39.389000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.825000,0.000000,37.611000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.825000,0.000000,39.389000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<52.825000,0.000000,39.389000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.079000,0.000000,39.643000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.460000,0.000000,39.643000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.079000,0.000000,39.643000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.587000,0.000000,39.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.460000,0.000000,39.643000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<53.460000,0.000000,39.643000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.079000,0.000000,37.357000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.460000,0.000000,37.357000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.079000,0.000000,37.357000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.587000,0.000000,37.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.460000,0.000000,37.357000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<53.460000,0.000000,37.357000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.413000,0.000000,39.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.540000,0.000000,39.643000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<58.413000,0.000000,39.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.413000,0.000000,39.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.587000,0.000000,39.516000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.587000,0.000000,39.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.413000,0.000000,37.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.540000,0.000000,37.357000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<58.413000,0.000000,37.484000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.413000,0.000000,37.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.587000,0.000000,37.484000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.587000,0.000000,37.484000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.921000,0.000000,39.643000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.540000,0.000000,39.643000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.540000,0.000000,39.643000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.921000,0.000000,37.357000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.540000,0.000000,37.357000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.540000,0.000000,37.357000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.175000,0.000000,37.611000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.175000,0.000000,39.389000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<59.175000,0.000000,39.389000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<59.606800,0.000000,38.500000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<52.393200,0.000000,38.500000>}
//R6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<18.000000,0.000000,35.080000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<18.000000,0.000000,34.064000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<18.000000,0.000000,34.064000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<18.000000,0.000000,24.920000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<18.000000,0.000000,25.936000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<18.000000,0.000000,25.936000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<17.111000,0.000000,27.079000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<18.889000,0.000000,27.079000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<18.889000,0.000000,32.921000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<17.111000,0.000000,32.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.889000,0.000000,26.825000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.111000,0.000000,26.825000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.111000,0.000000,26.825000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.857000,0.000000,27.079000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.857000,0.000000,27.460000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<16.857000,0.000000,27.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.984000,0.000000,27.587000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.857000,0.000000,27.460000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<16.857000,0.000000,27.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.143000,0.000000,27.079000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.143000,0.000000,27.460000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<19.143000,0.000000,27.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.016000,0.000000,27.587000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.143000,0.000000,27.460000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<19.016000,0.000000,27.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.984000,0.000000,32.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.857000,0.000000,32.540000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<16.857000,0.000000,32.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.984000,0.000000,32.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.984000,0.000000,27.587000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<16.984000,0.000000,27.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.016000,0.000000,32.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.143000,0.000000,32.540000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<19.016000,0.000000,32.413000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.016000,0.000000,32.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.016000,0.000000,27.587000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<19.016000,0.000000,27.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.857000,0.000000,32.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.857000,0.000000,32.540000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<16.857000,0.000000,32.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.143000,0.000000,32.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.143000,0.000000,32.540000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<19.143000,0.000000,32.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.889000,0.000000,33.175000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.111000,0.000000,33.175000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.111000,0.000000,33.175000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<18.000000,0.000000,33.606800>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<18.000000,0.000000,26.393200>}
//R7 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<24.000000,0.000000,35.080000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<24.000000,0.000000,34.064000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<24.000000,0.000000,34.064000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<24.000000,0.000000,24.920000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<24.000000,0.000000,25.936000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<24.000000,0.000000,25.936000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<23.111000,0.000000,27.079000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<24.889000,0.000000,27.079000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<24.889000,0.000000,32.921000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<23.111000,0.000000,32.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.889000,0.000000,26.825000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.111000,0.000000,26.825000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.111000,0.000000,26.825000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.857000,0.000000,27.079000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.857000,0.000000,27.460000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<22.857000,0.000000,27.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.984000,0.000000,27.587000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.857000,0.000000,27.460000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<22.857000,0.000000,27.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.143000,0.000000,27.079000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.143000,0.000000,27.460000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<25.143000,0.000000,27.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.016000,0.000000,27.587000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.143000,0.000000,27.460000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<25.016000,0.000000,27.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.984000,0.000000,32.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.857000,0.000000,32.540000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<22.857000,0.000000,32.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.984000,0.000000,32.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.984000,0.000000,27.587000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<22.984000,0.000000,27.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.016000,0.000000,32.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.143000,0.000000,32.540000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<25.016000,0.000000,32.413000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.016000,0.000000,32.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.016000,0.000000,27.587000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<25.016000,0.000000,27.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.857000,0.000000,32.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.857000,0.000000,32.540000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<22.857000,0.000000,32.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.143000,0.000000,32.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.143000,0.000000,32.540000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<25.143000,0.000000,32.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.889000,0.000000,33.175000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.111000,0.000000,33.175000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.111000,0.000000,33.175000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<24.000000,0.000000,33.606800>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<24.000000,0.000000,26.393200>}
//R8 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<14.920000,0.000000,7.500000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<15.936000,0.000000,7.500000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<14.920000,0.000000,7.500000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<25.080000,0.000000,7.500000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<24.064000,0.000000,7.500000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<24.064000,0.000000,7.500000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<22.921000,0.000000,6.611000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<22.921000,0.000000,8.389000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<17.079000,0.000000,8.389000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<17.079000,0.000000,6.611000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.175000,0.000000,8.389000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.175000,0.000000,6.611000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<23.175000,0.000000,6.611000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.921000,0.000000,6.357000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.540000,0.000000,6.357000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.540000,0.000000,6.357000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.413000,0.000000,6.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.540000,0.000000,6.357000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<22.413000,0.000000,6.484000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.921000,0.000000,8.643000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.540000,0.000000,8.643000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.540000,0.000000,8.643000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.413000,0.000000,8.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.540000,0.000000,8.643000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<22.413000,0.000000,8.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.587000,0.000000,6.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.460000,0.000000,6.357000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<17.460000,0.000000,6.357000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.587000,0.000000,6.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.413000,0.000000,6.484000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.587000,0.000000,6.484000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.587000,0.000000,8.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.460000,0.000000,8.643000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<17.460000,0.000000,8.643000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.587000,0.000000,8.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.413000,0.000000,8.516000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.587000,0.000000,8.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.079000,0.000000,6.357000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.460000,0.000000,6.357000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.079000,0.000000,6.357000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.079000,0.000000,8.643000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.460000,0.000000,8.643000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.079000,0.000000,8.643000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.825000,0.000000,8.389000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.825000,0.000000,6.611000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<16.825000,0.000000,6.611000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<16.393200,0.000000,7.500000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<23.606800,0.000000,7.500000>}
//R9 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<14.920000,0.000000,4.500000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<15.936000,0.000000,4.500000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<14.920000,0.000000,4.500000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<25.080000,0.000000,4.500000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<24.064000,0.000000,4.500000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<24.064000,0.000000,4.500000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<22.921000,0.000000,3.611000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<22.921000,0.000000,5.389000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<17.079000,0.000000,5.389000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<17.079000,0.000000,3.611000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.175000,0.000000,5.389000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.175000,0.000000,3.611000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<23.175000,0.000000,3.611000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.921000,0.000000,3.357000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.540000,0.000000,3.357000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.540000,0.000000,3.357000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.413000,0.000000,3.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.540000,0.000000,3.357000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<22.413000,0.000000,3.484000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.921000,0.000000,5.643000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.540000,0.000000,5.643000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.540000,0.000000,5.643000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.413000,0.000000,5.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.540000,0.000000,5.643000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<22.413000,0.000000,5.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.587000,0.000000,3.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.460000,0.000000,3.357000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<17.460000,0.000000,3.357000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.587000,0.000000,3.484000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.413000,0.000000,3.484000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.587000,0.000000,3.484000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.587000,0.000000,5.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.460000,0.000000,5.643000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<17.460000,0.000000,5.643000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.587000,0.000000,5.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.413000,0.000000,5.516000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.587000,0.000000,5.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.079000,0.000000,3.357000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.460000,0.000000,3.357000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.079000,0.000000,3.357000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.079000,0.000000,5.643000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.460000,0.000000,5.643000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.079000,0.000000,5.643000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.825000,0.000000,5.389000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.825000,0.000000,3.611000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<16.825000,0.000000,3.611000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<16.393200,0.000000,4.500000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<23.606800,0.000000,4.500000>}
//R10 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<50.420000,0.000000,2.000000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<51.436000,0.000000,2.000000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<50.420000,0.000000,2.000000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<60.580000,0.000000,2.000000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<59.564000,0.000000,2.000000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<59.564000,0.000000,2.000000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<58.421000,0.000000,1.111000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<58.421000,0.000000,2.889000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<52.579000,0.000000,2.889000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<52.579000,0.000000,1.111000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.675000,0.000000,2.889000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.675000,0.000000,1.111000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<58.675000,0.000000,1.111000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.421000,0.000000,0.857000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.040000,0.000000,0.857000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.040000,0.000000,0.857000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.913000,0.000000,0.984000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.040000,0.000000,0.857000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<57.913000,0.000000,0.984000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.421000,0.000000,3.143000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.040000,0.000000,3.143000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.040000,0.000000,3.143000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.913000,0.000000,3.016000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.040000,0.000000,3.143000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<57.913000,0.000000,3.016000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.087000,0.000000,0.984000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.960000,0.000000,0.857000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<52.960000,0.000000,0.857000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.087000,0.000000,0.984000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.913000,0.000000,0.984000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.087000,0.000000,0.984000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.087000,0.000000,3.016000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.960000,0.000000,3.143000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<52.960000,0.000000,3.143000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.087000,0.000000,3.016000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.913000,0.000000,3.016000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.087000,0.000000,3.016000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.579000,0.000000,0.857000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.960000,0.000000,0.857000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<52.579000,0.000000,0.857000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.579000,0.000000,3.143000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.960000,0.000000,3.143000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<52.579000,0.000000,3.143000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.325000,0.000000,2.889000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.325000,0.000000,1.111000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<52.325000,0.000000,1.111000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<51.893200,0.000000,2.000000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<59.106800,0.000000,2.000000>}
//R11 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<52.000000,0.000000,20.080000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<52.000000,0.000000,19.064000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<52.000000,0.000000,19.064000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<52.000000,0.000000,9.920000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<52.000000,0.000000,10.936000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<52.000000,0.000000,10.936000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<51.111000,0.000000,12.079000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<52.889000,0.000000,12.079000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<52.889000,0.000000,17.921000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<51.111000,0.000000,17.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.889000,0.000000,11.825000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.111000,0.000000,11.825000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<51.111000,0.000000,11.825000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.857000,0.000000,12.079000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.857000,0.000000,12.460000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<50.857000,0.000000,12.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.984000,0.000000,12.587000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.857000,0.000000,12.460000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<50.857000,0.000000,12.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.143000,0.000000,12.079000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.143000,0.000000,12.460000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<53.143000,0.000000,12.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.016000,0.000000,12.587000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.143000,0.000000,12.460000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<53.016000,0.000000,12.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.984000,0.000000,17.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.857000,0.000000,17.540000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<50.857000,0.000000,17.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.984000,0.000000,17.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.984000,0.000000,12.587000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<50.984000,0.000000,12.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.016000,0.000000,17.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.143000,0.000000,17.540000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<53.016000,0.000000,17.413000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.016000,0.000000,17.413000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.016000,0.000000,12.587000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<53.016000,0.000000,12.587000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.857000,0.000000,17.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.857000,0.000000,17.540000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<50.857000,0.000000,17.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.143000,0.000000,17.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.143000,0.000000,17.540000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<53.143000,0.000000,17.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.889000,0.000000,18.175000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.111000,0.000000,18.175000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<51.111000,0.000000,18.175000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<52.000000,0.000000,18.606800>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<52.000000,0.000000,11.393200>}
//S1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.302000,0.000000,12.238000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.048000,0.000000,12.238000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<70.048000,0.000000,12.238000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.302000,0.000000,12.238000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.302000,0.000000,13.762000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<70.302000,0.000000,13.762000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.048000,0.000000,13.762000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.302000,0.000000,13.762000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<70.048000,0.000000,13.762000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.048000,0.000000,14.016000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.048000,0.000000,15.540000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<70.048000,0.000000,15.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.698000,0.000000,13.762000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.952000,0.000000,13.762000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<63.698000,0.000000,13.762000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.698000,0.000000,13.762000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.698000,0.000000,12.238000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<63.698000,0.000000,12.238000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.952000,0.000000,12.238000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.698000,0.000000,12.238000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<63.698000,0.000000,12.238000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.048000,0.000000,15.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.540000,0.000000,16.048000>}
box{<0,0,-0.076200><0.718420,0.036000,0.076200> rotate<0,44.997030,0> translate<69.540000,0.000000,16.048000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.540000,0.000000,9.952000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.048000,0.000000,10.460000>}
box{<0,0,-0.076200><0.718420,0.036000,0.076200> rotate<0,-44.997030,0> translate<69.540000,0.000000,9.952000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.048000,0.000000,10.460000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.048000,0.000000,11.984000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<70.048000,0.000000,11.984000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.460000,0.000000,16.048000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.952000,0.000000,15.540000>}
box{<0,0,-0.076200><0.718420,0.036000,0.076200> rotate<0,-44.997030,0> translate<63.952000,0.000000,15.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.952000,0.000000,15.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.952000,0.000000,14.016000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<63.952000,0.000000,14.016000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.460000,0.000000,9.952000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.952000,0.000000,10.460000>}
box{<0,0,-0.076200><0.718420,0.036000,0.076200> rotate<0,44.997030,0> translate<63.952000,0.000000,10.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.952000,0.000000,10.460000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.952000,0.000000,11.984000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<63.952000,0.000000,11.984000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<65.730000,0.000000,14.270000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<65.730000,0.000000,11.730000>}
box{<0,0,-0.025400><2.540000,0.036000,0.025400> rotate<0,-90.000000,0> translate<65.730000,0.000000,11.730000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.270000,0.000000,11.730000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<65.730000,0.000000,11.730000>}
box{<0,0,-0.025400><2.540000,0.036000,0.025400> rotate<0,0.000000,0> translate<65.730000,0.000000,11.730000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.270000,0.000000,11.730000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.270000,0.000000,14.270000>}
box{<0,0,-0.025400><2.540000,0.036000,0.025400> rotate<0,90.000000,0> translate<68.270000,0.000000,14.270000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<65.730000,0.000000,14.270000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.270000,0.000000,14.270000>}
box{<0,0,-0.025400><2.540000,0.036000,0.025400> rotate<0,0.000000,0> translate<65.730000,0.000000,14.270000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<65.730000,0.000000,16.048000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<65.730000,0.000000,15.794000>}
box{<0,0,-0.025400><0.254000,0.036000,0.025400> rotate<0,-90.000000,0> translate<65.730000,0.000000,15.794000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.270000,0.000000,15.794000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<65.730000,0.000000,15.794000>}
box{<0,0,-0.025400><2.540000,0.036000,0.025400> rotate<0,0.000000,0> translate<65.730000,0.000000,15.794000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.270000,0.000000,15.794000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.270000,0.000000,16.048000>}
box{<0,0,-0.025400><0.254000,0.036000,0.025400> rotate<0,90.000000,0> translate<68.270000,0.000000,16.048000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.143000,0.000000,10.206000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<65.730000,0.000000,10.206000>}
box{<0,0,-0.025400><2.413000,0.036000,0.025400> rotate<0,0.000000,0> translate<65.730000,0.000000,10.206000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.143000,0.000000,10.206000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.143000,0.000000,9.952000>}
box{<0,0,-0.025400><0.254000,0.036000,0.025400> rotate<0,-90.000000,0> translate<68.143000,0.000000,9.952000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<65.730000,0.000000,10.206000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<65.730000,0.000000,9.952000>}
box{<0,0,-0.025400><0.254000,0.036000,0.025400> rotate<0,-90.000000,0> translate<65.730000,0.000000,9.952000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.540000,0.000000,9.952000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.159000,0.000000,9.952000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<69.159000,0.000000,9.952000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.460000,0.000000,9.952000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.841000,0.000000,9.952000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<64.460000,0.000000,9.952000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.841000,0.000000,9.952000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.730000,0.000000,9.952000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<64.841000,0.000000,9.952000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.460000,0.000000,16.048000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.841000,0.000000,16.048000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<64.460000,0.000000,16.048000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.540000,0.000000,16.048000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.159000,0.000000,16.048000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<69.159000,0.000000,16.048000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.159000,0.000000,16.048000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.270000,0.000000,16.048000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<68.270000,0.000000,16.048000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.270000,0.000000,16.048000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.730000,0.000000,16.048000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<65.730000,0.000000,16.048000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.730000,0.000000,16.048000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.841000,0.000000,16.048000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<64.841000,0.000000,16.048000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.730000,0.000000,9.952000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.143000,0.000000,9.952000>}
box{<0,0,-0.076200><2.413000,0.036000,0.076200> rotate<0,0.000000,0> translate<65.730000,0.000000,9.952000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.143000,0.000000,9.952000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.159000,0.000000,9.952000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<68.143000,0.000000,9.952000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.048000,0.000000,12.238000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.048000,0.000000,11.984000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<70.048000,0.000000,11.984000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.048000,0.000000,13.762000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.048000,0.000000,14.016000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<70.048000,0.000000,14.016000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.952000,0.000000,12.238000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.952000,0.000000,11.984000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<63.952000,0.000000,11.984000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.952000,0.000000,13.762000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.952000,0.000000,14.016000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<63.952000,0.000000,14.016000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.730000,0.000000,10.841000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.270000,0.000000,10.841000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<65.730000,0.000000,10.841000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.270000,0.000000,15.286000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.730000,0.000000,15.286000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<65.730000,0.000000,15.286000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.587000,0.000000,14.270000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.587000,0.000000,13.508000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<64.587000,0.000000,13.508000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.587000,0.000000,12.492000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.587000,0.000000,11.730000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<64.587000,0.000000,11.730000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.587000,0.000000,13.508000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.841000,0.000000,12.619000>}
box{<0,0,-0.076200><0.924574,0.036000,0.076200> rotate<0,74.049717,0> translate<64.587000,0.000000,13.508000> }
difference{
cylinder{<67.000000,0,13.000000><67.000000,0.036000,13.000000>1.854200 translate<0,0.000000,0>}
cylinder{<67.000000,-0.1,13.000000><67.000000,0.135000,13.000000>1.701800 translate<0,0.000000,0>}}
difference{
cylinder{<64.841000,0,10.841000><64.841000,0.036000,10.841000>0.584200 translate<0,0.000000,0>}
cylinder{<64.841000,-0.1,10.841000><64.841000,0.135000,10.841000>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<69.159000,0,10.968000><69.159000,0.036000,10.968000>0.584200 translate<0,0.000000,0>}
cylinder{<69.159000,-0.1,10.968000><69.159000,0.135000,10.968000>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<69.159000,0,15.159000><69.159000,0.036000,15.159000>0.584200 translate<0,0.000000,0>}
cylinder{<69.159000,-0.1,15.159000><69.159000,0.135000,15.159000>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<64.841000,0,15.159000><64.841000,0.036000,15.159000>0.584200 translate<0,0.000000,0>}
cylinder{<64.841000,-0.1,15.159000><64.841000,0.135000,15.159000>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<67.000000,0,13.000000><67.000000,0.036000,13.000000>0.660400 translate<0,0.000000,0>}
cylinder{<67.000000,-0.1,13.000000><67.000000,0.135000,13.000000>0.609600 translate<0,0.000000,0>}}
difference{
cylinder{<67.000000,0,13.000000><67.000000,0.036000,13.000000>0.330200 translate<0,0.000000,0>}
cylinder{<67.000000,-0.1,13.000000><67.000000,0.135000,13.000000>0.177800 translate<0,0.000000,0>}}
//S2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.698000,0.000000,5.762000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.952000,0.000000,5.762000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<63.698000,0.000000,5.762000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.698000,0.000000,5.762000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.698000,0.000000,4.238000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<63.698000,0.000000,4.238000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.952000,0.000000,4.238000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.698000,0.000000,4.238000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<63.698000,0.000000,4.238000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.952000,0.000000,3.984000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.952000,0.000000,2.460000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<63.952000,0.000000,2.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.302000,0.000000,4.238000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.048000,0.000000,4.238000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<70.048000,0.000000,4.238000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.302000,0.000000,4.238000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.302000,0.000000,5.762000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<70.302000,0.000000,5.762000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.048000,0.000000,5.762000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.302000,0.000000,5.762000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<70.048000,0.000000,5.762000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.952000,0.000000,2.460000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.460000,0.000000,1.952000>}
box{<0,0,-0.076200><0.718420,0.036000,0.076200> rotate<0,44.997030,0> translate<63.952000,0.000000,2.460000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.460000,0.000000,8.048000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.952000,0.000000,7.540000>}
box{<0,0,-0.076200><0.718420,0.036000,0.076200> rotate<0,-44.997030,0> translate<63.952000,0.000000,7.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.952000,0.000000,7.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.952000,0.000000,6.016000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<63.952000,0.000000,6.016000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.540000,0.000000,1.952000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.048000,0.000000,2.460000>}
box{<0,0,-0.076200><0.718420,0.036000,0.076200> rotate<0,-44.997030,0> translate<69.540000,0.000000,1.952000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.048000,0.000000,2.460000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.048000,0.000000,3.984000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<70.048000,0.000000,3.984000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.540000,0.000000,8.048000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.048000,0.000000,7.540000>}
box{<0,0,-0.076200><0.718420,0.036000,0.076200> rotate<0,44.997030,0> translate<69.540000,0.000000,8.048000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.048000,0.000000,7.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.048000,0.000000,6.016000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<70.048000,0.000000,6.016000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.270000,0.000000,3.730000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.270000,0.000000,6.270000>}
box{<0,0,-0.025400><2.540000,0.036000,0.025400> rotate<0,90.000000,0> translate<68.270000,0.000000,6.270000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<65.730000,0.000000,6.270000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.270000,0.000000,6.270000>}
box{<0,0,-0.025400><2.540000,0.036000,0.025400> rotate<0,0.000000,0> translate<65.730000,0.000000,6.270000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<65.730000,0.000000,6.270000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<65.730000,0.000000,3.730000>}
box{<0,0,-0.025400><2.540000,0.036000,0.025400> rotate<0,-90.000000,0> translate<65.730000,0.000000,3.730000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.270000,0.000000,3.730000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<65.730000,0.000000,3.730000>}
box{<0,0,-0.025400><2.540000,0.036000,0.025400> rotate<0,0.000000,0> translate<65.730000,0.000000,3.730000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.270000,0.000000,1.952000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.270000,0.000000,2.206000>}
box{<0,0,-0.025400><0.254000,0.036000,0.025400> rotate<0,90.000000,0> translate<68.270000,0.000000,2.206000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<65.730000,0.000000,2.206000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.270000,0.000000,2.206000>}
box{<0,0,-0.025400><2.540000,0.036000,0.025400> rotate<0,0.000000,0> translate<65.730000,0.000000,2.206000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<65.730000,0.000000,2.206000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<65.730000,0.000000,1.952000>}
box{<0,0,-0.025400><0.254000,0.036000,0.025400> rotate<0,-90.000000,0> translate<65.730000,0.000000,1.952000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<65.857000,0.000000,7.794000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.270000,0.000000,7.794000>}
box{<0,0,-0.025400><2.413000,0.036000,0.025400> rotate<0,0.000000,0> translate<65.857000,0.000000,7.794000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<65.857000,0.000000,7.794000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<65.857000,0.000000,8.048000>}
box{<0,0,-0.025400><0.254000,0.036000,0.025400> rotate<0,90.000000,0> translate<65.857000,0.000000,8.048000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.270000,0.000000,7.794000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.270000,0.000000,8.048000>}
box{<0,0,-0.025400><0.254000,0.036000,0.025400> rotate<0,90.000000,0> translate<68.270000,0.000000,8.048000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.460000,0.000000,8.048000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.841000,0.000000,8.048000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<64.460000,0.000000,8.048000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.540000,0.000000,8.048000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.159000,0.000000,8.048000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<69.159000,0.000000,8.048000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.159000,0.000000,8.048000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.270000,0.000000,8.048000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<68.270000,0.000000,8.048000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.540000,0.000000,1.952000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.159000,0.000000,1.952000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<69.159000,0.000000,1.952000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.460000,0.000000,1.952000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.841000,0.000000,1.952000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<64.460000,0.000000,1.952000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.841000,0.000000,1.952000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.730000,0.000000,1.952000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<64.841000,0.000000,1.952000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.730000,0.000000,1.952000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.270000,0.000000,1.952000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<65.730000,0.000000,1.952000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.270000,0.000000,1.952000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.159000,0.000000,1.952000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<68.270000,0.000000,1.952000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.270000,0.000000,8.048000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.857000,0.000000,8.048000>}
box{<0,0,-0.076200><2.413000,0.036000,0.076200> rotate<0,0.000000,0> translate<65.857000,0.000000,8.048000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.857000,0.000000,8.048000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.841000,0.000000,8.048000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<64.841000,0.000000,8.048000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.952000,0.000000,5.762000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.952000,0.000000,6.016000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<63.952000,0.000000,6.016000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.952000,0.000000,4.238000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.952000,0.000000,3.984000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<63.952000,0.000000,3.984000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.048000,0.000000,5.762000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.048000,0.000000,6.016000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<70.048000,0.000000,6.016000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.048000,0.000000,4.238000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.048000,0.000000,3.984000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<70.048000,0.000000,3.984000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.270000,0.000000,7.159000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.730000,0.000000,7.159000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<65.730000,0.000000,7.159000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.730000,0.000000,2.714000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.270000,0.000000,2.714000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<65.730000,0.000000,2.714000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.413000,0.000000,3.730000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.413000,0.000000,4.492000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<69.413000,0.000000,4.492000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.413000,0.000000,5.508000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.413000,0.000000,6.270000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<69.413000,0.000000,6.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.413000,0.000000,4.492000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.159000,0.000000,5.381000>}
box{<0,0,-0.076200><0.924574,0.036000,0.076200> rotate<0,74.049717,0> translate<69.159000,0.000000,5.381000> }
difference{
cylinder{<67.000000,0,5.000000><67.000000,0.036000,5.000000>1.854200 translate<0,0.000000,0>}
cylinder{<67.000000,-0.1,5.000000><67.000000,0.135000,5.000000>1.701800 translate<0,0.000000,0>}}
difference{
cylinder{<69.159000,0,7.159000><69.159000,0.036000,7.159000>0.584200 translate<0,0.000000,0>}
cylinder{<69.159000,-0.1,7.159000><69.159000,0.135000,7.159000>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<64.841000,0,7.032000><64.841000,0.036000,7.032000>0.584200 translate<0,0.000000,0>}
cylinder{<64.841000,-0.1,7.032000><64.841000,0.135000,7.032000>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<64.841000,0,2.841000><64.841000,0.036000,2.841000>0.584200 translate<0,0.000000,0>}
cylinder{<64.841000,-0.1,2.841000><64.841000,0.135000,2.841000>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<69.159000,0,2.841000><69.159000,0.036000,2.841000>0.584200 translate<0,0.000000,0>}
cylinder{<69.159000,-0.1,2.841000><69.159000,0.135000,2.841000>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<67.000000,0,5.000000><67.000000,0.036000,5.000000>0.660400 translate<0,0.000000,0>}
cylinder{<67.000000,-0.1,5.000000><67.000000,0.135000,5.000000>0.609600 translate<0,0.000000,0>}}
difference{
cylinder{<67.000000,0,5.000000><67.000000,0.036000,5.000000>0.330200 translate<0,0.000000,0>}
cylinder{<67.000000,-0.1,5.000000><67.000000,0.135000,5.000000>0.177800 translate<0,0.000000,0>}}
//T1 silk screen
object{ARC(2.667000,0.127000,95.462839,128.244104,0.036000) translate<58.999900,0.000000,43.000000>}
object{ARC(2.667000,0.127000,17.146796,95.464977,0.036000) translate<59.000000,0.000000,43.000000>}
object{ARC(2.666900,0.127000,231.752879,342.852571,0.036000) translate<59.000000,0.000000,43.000000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<57.349000,0.000000,45.094500>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<57.349000,0.000000,40.905500>}
box{<0,0,-0.063500><4.189000,0.036000,0.063500> rotate<0,-90.000000,0> translate<57.349000,0.000000,40.905500> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<58.746000,0.000000,45.253700>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<58.746000,0.000000,43.286300>}
box{<0,0,-0.063500><1.967400,0.036000,0.063500> rotate<0,-90.000000,0> translate<58.746000,0.000000,43.286300> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<58.746000,0.000000,45.654900>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<58.746000,0.000000,45.253700>}
box{<0,0,-0.063500><0.401200,0.036000,0.063500> rotate<0,-90.000000,0> translate<58.746000,0.000000,45.253700> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<58.746000,0.000000,43.286300>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<58.746000,0.000000,42.713700>}
box{<0,0,-0.063500><0.572600,0.036000,0.063500> rotate<0,-90.000000,0> translate<58.746000,0.000000,42.713700> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<58.746000,0.000000,40.746300>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<58.746000,0.000000,40.345100>}
box{<0,0,-0.063500><0.401200,0.036000,0.063500> rotate<0,-90.000000,0> translate<58.746000,0.000000,40.345100> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<58.746000,0.000000,42.713700>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<58.746000,0.000000,40.746300>}
box{<0,0,-0.063500><1.967400,0.036000,0.063500> rotate<0,-90.000000,0> translate<58.746000,0.000000,40.746300> }
object{ARC(2.667000,0.127000,342.853204,377.146796,0.036000) translate<59.000000,0.000000,43.000000>}
//U1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.800000,-1.536000,12.075000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.200000,-1.536000,12.075000>}
box{<0,0,-0.076200><10.400000,0.036000,0.076200> rotate<0,0.000000,0> translate<30.800000,-1.536000,12.075000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.200000,-1.536000,12.075000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.200000,-1.536000,17.925000>}
box{<0,0,-0.076200><5.850000,0.036000,0.076200> rotate<0,90.000000,0> translate<41.200000,-1.536000,17.925000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.200000,-1.536000,17.925000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.800000,-1.536000,17.925000>}
box{<0,0,-0.076200><10.400000,0.036000,0.076200> rotate<0,0.000000,0> translate<30.800000,-1.536000,17.925000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.800000,-1.536000,17.925000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.800000,-1.536000,12.075000>}
box{<0,0,-0.076200><5.850000,0.036000,0.076200> rotate<0,-90.000000,0> translate<30.800000,-1.536000,12.075000> }
difference{
cylinder{<31.775000,0,16.950000><31.775000,0.036000,16.950000>0.535800 translate<0,-1.536000,0>}
cylinder{<31.775000,-0.1,16.950000><31.775000,0.135000,16.950000>0.383400 translate<0,-1.536000,0>}}
box{<-0.162500,0,-0.467200><0.162500,0.036000,0.467200> rotate<0,-0.000000,0> translate<31.775000,-1.536000,11.567200>}
box{<-0.162500,0,-0.467200><0.162500,0.036000,0.467200> rotate<0,-0.000000,0> translate<31.775000,-1.536000,18.432800>}
box{<-0.162500,0,-0.467200><0.162500,0.036000,0.467200> rotate<0,-0.000000,0> translate<32.425000,-1.536000,18.432800>}
box{<-0.162500,0,-0.467200><0.162500,0.036000,0.467200> rotate<0,-0.000000,0> translate<33.075000,-1.536000,18.432800>}
box{<-0.162500,0,-0.467200><0.162500,0.036000,0.467200> rotate<0,-0.000000,0> translate<32.425000,-1.536000,11.567200>}
box{<-0.162500,0,-0.467200><0.162500,0.036000,0.467200> rotate<0,-0.000000,0> translate<33.075000,-1.536000,11.567200>}
box{<-0.162500,0,-0.467200><0.162500,0.036000,0.467200> rotate<0,-0.000000,0> translate<33.725000,-1.536000,11.567200>}
box{<-0.162500,0,-0.467200><0.162500,0.036000,0.467200> rotate<0,-0.000000,0> translate<34.375000,-1.536000,11.567200>}
box{<-0.162500,0,-0.467200><0.162500,0.036000,0.467200> rotate<0,-0.000000,0> translate<35.025000,-1.536000,11.567200>}
box{<-0.162500,0,-0.467200><0.162500,0.036000,0.467200> rotate<0,-0.000000,0> translate<35.675000,-1.536000,11.567200>}
box{<-0.162500,0,-0.467200><0.162500,0.036000,0.467200> rotate<0,-0.000000,0> translate<36.325000,-1.536000,11.567200>}
box{<-0.162500,0,-0.467200><0.162500,0.036000,0.467200> rotate<0,-0.000000,0> translate<36.975000,-1.536000,11.567200>}
box{<-0.162500,0,-0.467200><0.162500,0.036000,0.467200> rotate<0,-0.000000,0> translate<37.625000,-1.536000,11.567200>}
box{<-0.162500,0,-0.467200><0.162500,0.036000,0.467200> rotate<0,-0.000000,0> translate<38.275000,-1.536000,11.567200>}
box{<-0.162500,0,-0.467200><0.162500,0.036000,0.467200> rotate<0,-0.000000,0> translate<38.925000,-1.536000,11.567200>}
box{<-0.162500,0,-0.467200><0.162500,0.036000,0.467200> rotate<0,-0.000000,0> translate<39.575000,-1.536000,11.567200>}
box{<-0.162500,0,-0.467200><0.162500,0.036000,0.467200> rotate<0,-0.000000,0> translate<40.225000,-1.536000,11.567200>}
box{<-0.162500,0,-0.467200><0.162500,0.036000,0.467200> rotate<0,-0.000000,0> translate<33.725000,-1.536000,18.432800>}
box{<-0.162500,0,-0.467200><0.162500,0.036000,0.467200> rotate<0,-0.000000,0> translate<34.375000,-1.536000,18.432800>}
box{<-0.162500,0,-0.467200><0.162500,0.036000,0.467200> rotate<0,-0.000000,0> translate<35.025000,-1.536000,18.432800>}
box{<-0.162500,0,-0.467200><0.162500,0.036000,0.467200> rotate<0,-0.000000,0> translate<35.675000,-1.536000,18.432800>}
box{<-0.162500,0,-0.467200><0.162500,0.036000,0.467200> rotate<0,-0.000000,0> translate<36.325000,-1.536000,18.432800>}
box{<-0.162500,0,-0.467200><0.162500,0.036000,0.467200> rotate<0,-0.000000,0> translate<36.975000,-1.536000,18.432800>}
box{<-0.162500,0,-0.467200><0.162500,0.036000,0.467200> rotate<0,-0.000000,0> translate<37.625000,-1.536000,18.432800>}
box{<-0.162500,0,-0.467200><0.162500,0.036000,0.467200> rotate<0,-0.000000,0> translate<38.275000,-1.536000,18.432800>}
box{<-0.162500,0,-0.467200><0.162500,0.036000,0.467200> rotate<0,-0.000000,0> translate<38.925000,-1.536000,18.432800>}
box{<-0.162500,0,-0.467200><0.162500,0.036000,0.467200> rotate<0,-0.000000,0> translate<39.575000,-1.536000,18.432800>}
box{<-0.162500,0,-0.467200><0.162500,0.036000,0.467200> rotate<0,-0.000000,0> translate<40.225000,-1.536000,18.432800>}
//X1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<10.600000,0.000000,6.100000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<10.600000,0.000000,17.900000>}
box{<0,0,-0.127000><11.800000,0.036000,0.127000> rotate<0,90.000000,0> translate<10.600000,0.000000,17.900000> }
object{ARC(0.500000,0.050800,180.000000,360.000000,0.036000) translate<5.230000,0.000000,14.460000>}
object{ARC(0.500000,0.050800,180.000000,360.000000,0.036000) translate<4.230000,0.000000,14.460000>}
object{ARC(0.500000,0.050800,0.000000,180.000000,0.036000) translate<4.730000,0.000000,8.335000>}
object{ARC(1.000000,0.050800,0.000000,180.000000,0.036000) translate<4.730000,0.000000,8.585000>}
object{ARC(1.891600,0.050800,352.405357,367.594643,0.036000) translate<3.355000,0.000000,8.085000>}
object{ARC(3.627700,0.050800,349.832182,361.889316,0.036000) translate<2.104300,0.000000,8.465400>}
object{ARC(2.374900,0.050800,180.250904,198.673740,0.036000) translate<6.104900,0.000000,8.595400>}
object{ARC(0.625000,0.050800,180.000000,360.000000,0.036000) translate<5.105000,0.000000,10.335000>}
object{ARC(0.187500,0.050800,180.000000,360.000000,0.036000) translate<5.042500,0.000000,10.710000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.730000,0.000000,15.835000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<3.730000,0.000000,15.835000>}
box{<0,0,-0.025400><2.000000,0.036000,0.025400> rotate<0,0.000000,0> translate<3.730000,0.000000,15.835000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<3.730000,0.000000,15.835000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<3.730000,0.000000,15.210000>}
box{<0,0,-0.025400><0.625000,0.036000,0.025400> rotate<0,-90.000000,0> translate<3.730000,0.000000,15.210000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<3.730000,0.000000,15.210000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<4.730000,0.000000,15.210000>}
box{<0,0,-0.025400><1.000000,0.036000,0.025400> rotate<0,0.000000,0> translate<3.730000,0.000000,15.210000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<4.730000,0.000000,15.210000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.730000,0.000000,15.210000>}
box{<0,0,-0.025400><1.000000,0.036000,0.025400> rotate<0,0.000000,0> translate<4.730000,0.000000,15.210000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.730000,0.000000,15.210000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.730000,0.000000,15.835000>}
box{<0,0,-0.025400><0.625000,0.036000,0.025400> rotate<0,90.000000,0> translate<5.730000,0.000000,15.835000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.730000,0.000000,15.210000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.230000,0.000000,14.460000>}
box{<0,0,-0.025400><0.901388,0.036000,0.025400> rotate<0,-56.306216,0> translate<5.230000,0.000000,14.460000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.230000,0.000000,14.460000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<4.730000,0.000000,15.210000>}
box{<0,0,-0.025400><0.901388,0.036000,0.025400> rotate<0,56.306216,0> translate<4.730000,0.000000,15.210000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<4.730000,0.000000,15.210000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<4.230000,0.000000,14.460000>}
box{<0,0,-0.025400><0.901388,0.036000,0.025400> rotate<0,-56.306216,0> translate<4.230000,0.000000,14.460000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<4.230000,0.000000,14.460000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<3.730000,0.000000,15.210000>}
box{<0,0,-0.025400><0.901388,0.036000,0.025400> rotate<0,56.306216,0> translate<3.730000,0.000000,15.210000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<3.730000,0.000000,14.460000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<3.730000,0.000000,15.210000>}
box{<0,0,-0.025400><0.750000,0.036000,0.025400> rotate<0,90.000000,0> translate<3.730000,0.000000,15.210000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.730000,0.000000,14.460000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.730000,0.000000,15.210000>}
box{<0,0,-0.025400><0.750000,0.036000,0.025400> rotate<0,90.000000,0> translate<5.730000,0.000000,15.210000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.730000,0.000000,13.710000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<3.730000,0.000000,13.710000>}
box{<0,0,-0.025400><2.000000,0.036000,0.025400> rotate<0,0.000000,0> translate<3.730000,0.000000,13.710000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<3.730000,0.000000,13.710000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<3.730000,0.000000,11.960000>}
box{<0,0,-0.025400><1.750000,0.036000,0.025400> rotate<0,-90.000000,0> translate<3.730000,0.000000,11.960000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<3.730000,0.000000,11.960000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<4.230000,0.000000,11.960000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<3.730000,0.000000,11.960000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<4.230000,0.000000,11.960000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<4.230000,0.000000,13.085000>}
box{<0,0,-0.025400><1.125000,0.036000,0.025400> rotate<0,90.000000,0> translate<4.230000,0.000000,13.085000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<4.230000,0.000000,13.085000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<4.480000,0.000000,13.085000>}
box{<0,0,-0.025400><0.250000,0.036000,0.025400> rotate<0,0.000000,0> translate<4.230000,0.000000,13.085000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<4.480000,0.000000,13.085000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<4.480000,0.000000,11.960000>}
box{<0,0,-0.025400><1.125000,0.036000,0.025400> rotate<0,-90.000000,0> translate<4.480000,0.000000,11.960000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<4.480000,0.000000,11.960000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<4.980000,0.000000,11.960000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<4.480000,0.000000,11.960000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<4.980000,0.000000,11.960000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<4.980000,0.000000,13.085000>}
box{<0,0,-0.025400><1.125000,0.036000,0.025400> rotate<0,90.000000,0> translate<4.980000,0.000000,13.085000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<4.980000,0.000000,13.085000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.230000,0.000000,13.085000>}
box{<0,0,-0.025400><0.250000,0.036000,0.025400> rotate<0,0.000000,0> translate<4.980000,0.000000,13.085000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.230000,0.000000,13.085000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.230000,0.000000,11.960000>}
box{<0,0,-0.025400><1.125000,0.036000,0.025400> rotate<0,-90.000000,0> translate<5.230000,0.000000,11.960000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.230000,0.000000,11.960000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.730000,0.000000,11.960000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<5.230000,0.000000,11.960000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.730000,0.000000,11.960000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.730000,0.000000,13.710000>}
box{<0,0,-0.025400><1.750000,0.036000,0.025400> rotate<0,90.000000,0> translate<5.730000,0.000000,13.710000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.730000,0.000000,11.710000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<3.730000,0.000000,11.710000>}
box{<0,0,-0.025400><2.000000,0.036000,0.025400> rotate<0,0.000000,0> translate<3.730000,0.000000,11.710000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<3.730000,0.000000,11.710000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<3.730000,0.000000,11.085000>}
box{<0,0,-0.025400><0.625000,0.036000,0.025400> rotate<0,-90.000000,0> translate<3.730000,0.000000,11.085000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<3.730000,0.000000,11.085000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<4.480000,0.000000,11.085000>}
box{<0,0,-0.025400><0.750000,0.036000,0.025400> rotate<0,0.000000,0> translate<3.730000,0.000000,11.085000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<4.480000,0.000000,11.085000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<3.730000,0.000000,10.585000>}
box{<0,0,-0.025400><0.901388,0.036000,0.025400> rotate<0,-33.687844,0> translate<3.730000,0.000000,10.585000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<3.730000,0.000000,10.585000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<3.730000,0.000000,9.835000>}
box{<0,0,-0.025400><0.750000,0.036000,0.025400> rotate<0,-90.000000,0> translate<3.730000,0.000000,9.835000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<3.730000,0.000000,9.835000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<4.480000,0.000000,10.335000>}
box{<0,0,-0.025400><0.901388,0.036000,0.025400> rotate<0,-33.687844,0> translate<3.730000,0.000000,9.835000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.230000,0.000000,11.085000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<4.855000,0.000000,11.085000>}
box{<0,0,-0.025400><0.375000,0.036000,0.025400> rotate<0,0.000000,0> translate<4.855000,0.000000,11.085000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.730000,0.000000,11.710000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.730000,0.000000,10.335000>}
box{<0,0,-0.025400><1.375000,0.036000,0.025400> rotate<0,-90.000000,0> translate<5.730000,0.000000,10.335000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.230000,0.000000,11.085000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.230000,0.000000,10.710000>}
box{<0,0,-0.025400><0.375000,0.036000,0.025400> rotate<0,-90.000000,0> translate<5.230000,0.000000,10.710000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<4.855000,0.000000,11.085000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<4.855000,0.000000,10.710000>}
box{<0,0,-0.025400><0.375000,0.036000,0.025400> rotate<0,-90.000000,0> translate<4.855000,0.000000,10.710000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<4.730000,0.000000,8.335000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<4.730000,0.000000,7.835000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,-90.000000,0> translate<4.730000,0.000000,7.835000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<4.730000,0.000000,8.335000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<4.230000,0.000000,8.335000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<4.230000,0.000000,8.335000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.230000,0.000000,7.840000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.675000,0.000000,7.840000>}
box{<0,0,-0.025400><0.445000,0.036000,0.025400> rotate<0,0.000000,0> translate<5.230000,0.000000,7.840000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<4.730000,0.000000,7.835000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<3.855000,0.000000,7.835000>}
box{<0,0,-0.025400><0.875000,0.036000,0.025400> rotate<0,0.000000,0> translate<3.855000,0.000000,7.835000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<6.915000,0.000000,6.100000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<10.600000,0.000000,6.100000>}
box{<0,0,-0.127000><3.685000,0.036000,0.127000> rotate<0,0.000000,0> translate<6.915000,0.000000,6.100000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<10.600000,0.000000,17.900000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<6.915000,0.000000,17.900000>}
box{<0,0,-0.127000><3.685000,0.036000,0.127000> rotate<0,0.000000,0> translate<6.915000,0.000000,17.900000> }
//X2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<66.349000,-1.536000,39.469400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<68.355600,-1.536000,41.476000>}
box{<0,0,-0.127000><2.837761,0.036000,0.127000> rotate<0,-44.997030,0> translate<66.349000,-1.536000,39.469400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<66.323600,-1.536000,44.625600>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<68.355600,-1.536000,46.530600>}
box{<0,0,-0.127000><2.785327,0.036000,0.127000> rotate<0,-43.149542,0> translate<66.323600,-1.536000,44.625600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.191000,-1.536000,37.920000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.191000,-1.536000,48.080000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,90.000000,0> translate<72.191000,-1.536000,48.080000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.174000,-1.536000,48.080000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.587000,-1.536000,48.080000>}
box{<0,0,-0.076200><2.413000,0.036000,0.076200> rotate<0,0.000000,0> translate<63.174000,-1.536000,48.080000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.174000,-1.536000,48.080000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.174000,-1.536000,37.920000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,-90.000000,0> translate<63.174000,-1.536000,37.920000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.191000,-1.536000,37.920000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.587000,-1.536000,37.920000>}
box{<0,0,-0.076200><6.604000,0.036000,0.076200> rotate<0,0.000000,0> translate<65.587000,-1.536000,37.920000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.587000,-1.536000,37.920000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.587000,-1.536000,39.571000>}
box{<0,0,-0.076200><1.651000,0.036000,0.076200> rotate<0,90.000000,0> translate<65.587000,-1.536000,39.571000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.587000,-1.536000,39.571000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.587000,-1.536000,41.349000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<65.587000,-1.536000,41.349000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.587000,-1.536000,41.349000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.587000,-1.536000,44.651000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,90.000000,0> translate<65.587000,-1.536000,44.651000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.587000,-1.536000,46.429000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.587000,-1.536000,48.080000>}
box{<0,0,-0.076200><1.651000,0.036000,0.076200> rotate<0,90.000000,0> translate<65.587000,-1.536000,48.080000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.587000,-1.536000,37.920000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.174000,-1.536000,37.920000>}
box{<0,0,-0.076200><2.413000,0.036000,0.076200> rotate<0,0.000000,0> translate<63.174000,-1.536000,37.920000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.587000,-1.536000,48.080000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.191000,-1.536000,48.080000>}
box{<0,0,-0.076200><6.604000,0.036000,0.076200> rotate<0,0.000000,0> translate<65.587000,-1.536000,48.080000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.191000,-1.536000,37.920000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.445000,-1.536000,37.920000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<72.191000,-1.536000,37.920000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.445000,-1.536000,37.920000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.445000,-1.536000,48.080000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,90.000000,0> translate<72.445000,-1.536000,48.080000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.191000,-1.536000,48.080000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.445000,-1.536000,48.080000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<72.191000,-1.536000,48.080000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.587000,-1.536000,44.651000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.587000,-1.536000,46.429000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<65.587000,-1.536000,46.429000> }
difference{
cylinder{<67.365000,0,40.460000><67.365000,0.036000,40.460000>1.574800 translate<0,-1.536000,0>}
cylinder{<67.365000,-0.1,40.460000><67.365000,0.135000,40.460000>1.422400 translate<0,-1.536000,0>}}
difference{
cylinder{<70.844800,0,40.460000><70.844800,0.036000,40.460000>0.584200 translate<0,-1.536000,0>}
cylinder{<70.844800,-0.1,40.460000><70.844800,0.135000,40.460000>0.431800 translate<0,-1.536000,0>}}
difference{
cylinder{<67.365000,0,45.540000><67.365000,0.036000,45.540000>1.574800 translate<0,-1.536000,0>}
cylinder{<67.365000,-0.1,45.540000><67.365000,0.135000,45.540000>1.422400 translate<0,-1.536000,0>}}
difference{
cylinder{<70.844800,0,45.540000><70.844800,0.036000,45.540000>0.584200 translate<0,-1.536000,0>}
cylinder{<70.844800,-0.1,45.540000><70.844800,0.135000,45.540000>0.431800 translate<0,-1.536000,0>}}
//X3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<66.349000,-1.536000,27.469400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<68.355600,-1.536000,29.476000>}
box{<0,0,-0.127000><2.837761,0.036000,0.127000> rotate<0,-44.997030,0> translate<66.349000,-1.536000,27.469400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<66.323600,-1.536000,32.625600>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<68.355600,-1.536000,34.530600>}
box{<0,0,-0.127000><2.785327,0.036000,0.127000> rotate<0,-43.149542,0> translate<66.323600,-1.536000,32.625600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.191000,-1.536000,25.920000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.191000,-1.536000,36.080000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,90.000000,0> translate<72.191000,-1.536000,36.080000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.174000,-1.536000,36.080000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.587000,-1.536000,36.080000>}
box{<0,0,-0.076200><2.413000,0.036000,0.076200> rotate<0,0.000000,0> translate<63.174000,-1.536000,36.080000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.174000,-1.536000,36.080000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.174000,-1.536000,25.920000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,-90.000000,0> translate<63.174000,-1.536000,25.920000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.191000,-1.536000,25.920000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.587000,-1.536000,25.920000>}
box{<0,0,-0.076200><6.604000,0.036000,0.076200> rotate<0,0.000000,0> translate<65.587000,-1.536000,25.920000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.587000,-1.536000,25.920000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.587000,-1.536000,27.571000>}
box{<0,0,-0.076200><1.651000,0.036000,0.076200> rotate<0,90.000000,0> translate<65.587000,-1.536000,27.571000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.587000,-1.536000,27.571000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.587000,-1.536000,29.349000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<65.587000,-1.536000,29.349000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.587000,-1.536000,29.349000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.587000,-1.536000,32.651000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,90.000000,0> translate<65.587000,-1.536000,32.651000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.587000,-1.536000,34.429000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.587000,-1.536000,36.080000>}
box{<0,0,-0.076200><1.651000,0.036000,0.076200> rotate<0,90.000000,0> translate<65.587000,-1.536000,36.080000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.587000,-1.536000,25.920000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.174000,-1.536000,25.920000>}
box{<0,0,-0.076200><2.413000,0.036000,0.076200> rotate<0,0.000000,0> translate<63.174000,-1.536000,25.920000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.587000,-1.536000,36.080000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.191000,-1.536000,36.080000>}
box{<0,0,-0.076200><6.604000,0.036000,0.076200> rotate<0,0.000000,0> translate<65.587000,-1.536000,36.080000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.191000,-1.536000,25.920000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.445000,-1.536000,25.920000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<72.191000,-1.536000,25.920000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.445000,-1.536000,25.920000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.445000,-1.536000,36.080000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,90.000000,0> translate<72.445000,-1.536000,36.080000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.191000,-1.536000,36.080000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.445000,-1.536000,36.080000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<72.191000,-1.536000,36.080000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.587000,-1.536000,32.651000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.587000,-1.536000,34.429000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<65.587000,-1.536000,34.429000> }
difference{
cylinder{<67.365000,0,28.460000><67.365000,0.036000,28.460000>1.574800 translate<0,-1.536000,0>}
cylinder{<67.365000,-0.1,28.460000><67.365000,0.135000,28.460000>1.422400 translate<0,-1.536000,0>}}
difference{
cylinder{<70.844800,0,28.460000><70.844800,0.036000,28.460000>0.584200 translate<0,-1.536000,0>}
cylinder{<70.844800,-0.1,28.460000><70.844800,0.135000,28.460000>0.431800 translate<0,-1.536000,0>}}
difference{
cylinder{<67.365000,0,33.540000><67.365000,0.036000,33.540000>1.574800 translate<0,-1.536000,0>}
cylinder{<67.365000,-0.1,33.540000><67.365000,0.135000,33.540000>1.422400 translate<0,-1.536000,0>}}
difference{
cylinder{<70.844800,0,33.540000><70.844800,0.036000,33.540000>0.584200 translate<0,-1.536000,0>}
cylinder{<70.844800,-0.1,33.540000><70.844800,0.135000,33.540000>0.431800 translate<0,-1.536000,0>}}
texture{col_slk}
}
#end
translate<mac_x_ver,mac_y_ver,mac_z_ver>
rotate<mac_x_rot,mac_y_rot,mac_z_rot>
}//End union
#end

#if(use_file_as_inc=off)
object{  SCHEMA_V1_1(-37.500000,0,-25.000000,pcb_rotate_x,pcb_rotate_y,pcb_rotate_z)
#if(pcb_upsidedown=on)
rotate pcb_rotdir*180
#end
}
#end


//Parts not found in 3dpack.dat or 3dusrpac.dat are:
//J1	DCJ0202	DCJ0202
//U1		SSOP28DB
//X1	PN61729-S	PN61729-S
//X2		W237-132
//X3		W237-132
