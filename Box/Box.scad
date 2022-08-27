//               Box und Deckel 30.04.2022 khf

//************************   Auswahl   *****************************
//                   1:Box  2:Deckel 

                           part = "1";

//******************************************************************


//************************   Parmeter   *****************************
x = 70;  //Breite
y = 100;  //Länge
z = 40;  //Höhe
d1 = 4;   //Wand-Dicke mind. 3mm
b1 = 3;   //Durchmesser Bohrung mind. 3mm
//******************************************************************


a=3;
d= d1<a ? 3 : d1;

c=3;
b= b1<c ? 3 : b1;



print_part();



module print_part() 
 {
	if (part == "1") { 
        

		Box();

       	} 
        
    else if (part == "2") {
 
        Deckel();
 }        

}


include <lib/box_lib.scad>;



















