// inserire i dati nelle variabili premere F6 per generale il modello
// quindi File->Export->Export as STL..
// in fase di stampa rallentarla al 30-40% quando stampa solo l'asta per il magnete.

d = 2;  		// diametro del foro passante in millimetri
l = 8; 			// larghezza asta magnete in millimetri
al = 55; 		// altezza asta magnete in millimetri


// ================================================================================

r = 35;
x = 24;
a = d*2+1;
b = d*2;
z = 11;
zf = z+9;
c = 4;

$fn = 20;

render(){
translate([0,0,30])
difference(){
	union(){
		// vasca principale
		difference(){
			translate([0,0,5/2]) cube([140,30,35], center =true);

			translate([0,0,5/2+4]) cube([145,26.4,35], center =true);
		}
		
		// separatore vaschette
		translate([-1.8/2,-15,-15]) cube([1.8,29,35]);

		// asta magnete
		//translate([-l/2,13.2,-15]) cube ([l,1.8,al]);
		
		// asta magnete spessa
		translate([-6,7,20]) cube ([12,8,20]);
		
		// rinforzo base
		translate([0,15,-z])
		rotate(90,[1,0,0])
		linear_extrude(30,0)
			polygon(points=[ [0,0], [0,a], [b,0] ], path=[0,1,2]);
		mirror([1,0,0])
		translate([0,15,-z])
		rotate(90,[1,0,0])
		linear_extrude(30,0)
			polygon(points=[ [0,0], [0,a], [b,0] ], path=[0,1,2]);

		translate([4,13.2,20]){
		rotate(180,[1,0,0]) rotate(0,[0,1,0]) rotate(90,[0,0,1]) 
			polyhedron(
			points=[ [0,-2,0],[6.2,-2,0],[6.2,3.1,0],[0,3.1,0], // the four points at base
         [0,3.1,6]  ],                                 // the apex point 
  			faces=[ [0,1,4],[1,2,4],[2,3,4],[3,0,4],          // each triangle side
            [1,0,3],[2,1,3] ]                         // two triangles for square base
		);

		// tagliagoccia
		translate([-4,0,-0.1])
		rotate(90,[1,0,0])
		linear_extrude(28,0)
			polygon(points=[ [-0.9,0], [0.9,0], [0,2] ], path=[0,1,2]);
		}

		mirror([1,0,0])
			translate([4,13.2,20]){
			rotate(180,[1,0,0]) rotate(0,[0,1,0]) rotate(90,[0,0,1]) 
				polyhedron(
				points=[ [0,-2,0],[6.2,-2,0],[6.2,3.1,0],[0,3.1,0], // the four points at base
          [0,3.1,6]  ],                                 // the apex point 
  				faces=[ [0,1,4],[1,2,4],[2,3,4],[3,0,4],          // each triangle side
             [1,0,3],[2,1,3] ]                         // two triangles for square base
			);
		}
	}
	
	translate([0,0,9.7]) union(){
		// taglio obliquo
		translate ([x,-20,11]) rotate(r, [0,1,0])cube([100,50,50]);
		
		mirror([1,0,0])
			translate ([x,-20,11]) rotate(r, [0,1,0])cube([100,50,50]);
		
		// foro passante
		multmatrix([ [1,0,0,0], [0,1,0,0], [0,0,1.1,-zf+d/2], [0,0,0,1] ])
		rotate(90, [1,0,0]) cylinder(50,d/2,d/2, center = true);

		// scanso asta magnete
		translate([-c/2,7,20]) cube ([c,8,20]);
		}
	}
}