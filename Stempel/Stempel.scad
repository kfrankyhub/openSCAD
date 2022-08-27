
//************************   Auswahl   *****************************

//1:runder Stempel  

//2:eckiger Stempel mit Fassette 

//3:eckiger Stempel mit Rundung 

                           Stempel = "3";

//******************************************************************


//************************  Parameter   *****************************
$fn=100;

//Griff
    griff_dm    = 15;   // Durchmesser der Griffkugel 15
    griff_hoehe = 23;   // Höhe des Griffkugelzentrums über Hauptkörper 23
    griff_rand  = 2.5;  // unterer Steg des Griffes
    griff_vdm   = 5;    // Knubbel

//eckiger Stempel
    l=60; //Länge
    b=40; //Breite
    he=6; //Höhe

//runder Stempel
    r=20;  //Stempel-Radius
    h=3;   //Korpushöhe
    f=18;  //Fassette
//******************************************************************



module kugel(){ 
            //color("RoyalBlue")   
            translate( [0, 0, griff_hoehe])
            sphere(d = griff_dm);  
} 

 module knubbel(){   
            color("Silver")
            translate( [0, griff_dm / 2, griff_hoehe])
            scale( [1, 0.5, 1] )
            sphere(d = griff_vdm);
} 

module hals() {
            //color("RoyalBlue")
            rotate_extrude()
            difference() {
            square( [griff_dm / 2 - griff_rand, griff_hoehe] );  
            translate([griff_dm / 2, griff_hoehe / 2 ])
            scale( [0.4, 1] )
            circle( d = griff_hoehe);
            }
    }


module runderstempel1(){
    color("Gainsboro")
    union(){
    translate([0,0,-1])    
    cylinder(h, r, f, true);
    translate([0,0,-(h+1)])    
    cylinder(  h, r, r, true);
    }
}


module eckigerstempel2(){

module stempel (
   
    var,     
    breite = b,
    laenge =l,
    korpus_hoehe       = he,   // Höhe des Hauptkörpers
    korpus_basis       = 4,    // Höhe der Hauptkörperbasis
    korpus_rand        = 1.6,  // Wandungsstärke der Reliefaufnahme
    korpus_radius      = 2,    // Radius der Außenkanten des Hautpkörpers
    korpus_ruecksprung = 3,    // Rücksprung der oberen Fläche des Hauptkörpers
)
{

    module flaeche() {

        projection()
        intersection(){
            translate( [0,0,-1] )
            rotate([-90,0,0])
            linear_extrude()
            hull()
            projection()
            rotate([90,0,0])
            linear_extrude();
            rotate( [0, -90, 0] )
            linear_extrude( laenge )
            hull()
            projection()    
            rotate( [0, 0, 0] )
            linear_extrude()
            text(
            text = var, 
                size = breite,
                valign = "center", 
                halign = "center",
                $fn = 50
            );
        }
    }


    
    module korpus() {
        
            module basis( ruecksprung = 0) {
                minkowski() {
                    offset(
                        delta = korpus_rand  -
                                korpus_radius - 
                                ruecksprung
                    )        
                    flaeche();
                    if (korpus_radius > 0)
                    circle( r = korpus_radius, $fn = 36);
                }        
            }
            // hauptkörper

                hull(){
                    linear_extrude( height = korpus_basis )basis();
                    translate([0,0,korpus_hoehe])
                    linear_extrude( height = 0.01 )
                    basis( korpus_ruecksprung );
                }
                linear_extrude( height = 3)
 
                flaeche();
            
    }
   
korpus();
}
st = "0";
translate([l/2,0,-he])
color("Silver")
stempel(st);
}

module eckigerstempel3(){
include <lib/std.scad>
                color("Silver")
//color("RoyalBlue")
            translate( [0, 0, -3])        
cuboid(
    [l+0.5,b+0.5,6.1], rounding=3,
    edges=[
    TOP+FRONT,
    TOP+BACK,
    TOP+LEFT,
    TOP+RIGHT,
    FRONT+RIGHT,
    FRONT+LEFT, 
    BACK+LEFT,
    BACK+RIGHT]);
}
//*******************   
    
    print_part();

module print_part() 
 {
	if (Stempel == "1") {
		runderstempel1();
	} 
    else if (Stempel == "2") {

		eckigerstempel2();
	} 
    
        else if (Stempel == "3") {

		eckigerstempel3();
	} 
}
    
kugel();
knubbel();
hals();    

/*
translate([-30,-20,-6])
 cube([60,40,4],false);
*/