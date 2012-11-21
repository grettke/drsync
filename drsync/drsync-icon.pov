// Credit: Eric Bainville - Mar 2007
// Location: http://www.bealto.com/geo-povray-buttons_sky.html

#include "colors.inc"
#include "metals.inc"
#include "textures.inc"

global_settings {
  assumed_gamma 1        
  ambient_light White
}

// Switched to a perspective camera
#declare camera_distance = 20;
camera {                        
  location <0,0,camera_distance>
  right x up y direction -z
  angle 180*atan(2/camera_distance)/pi
  // Uncomment to render a side view  
  //rotate 50*x
}

light_source { <-30,70,100>, White }  

// Rounded square button
#declare b_rsquare = superellipsoid {
  // Adjust first parameter: 1=circle, 0=square
  <0.6,0.3>
  translate -z scale <1,1,0.2>
}

// Button symbol (start/stop)
#declare c_start = union {
        text {
                ttf "arial.ttf" "Dr" 2, 0  
                translate <-0.5, 0.25, 0>
        }
        text {
                ttf "arial.ttf" "Sync" 2, 0  
                translate <-1, -0.75, 0>
        }
}

// Button finish
#declare f_button = finish {
  ambient 0.2
  diffuse 0.3
  specular 0
  phong 0.6 phong_size 20
  reflection 0.3 // Reflects the sky sphere
}

// Content finish
#declare f_content = finish {
  ambient 0.7 // Large ambient to saturate color
  diffuse 0.3
  specular 0
  phong 0
  reflection 0
}

// Button and contents
difference {
  object { b_rsquare
    texture { pigment { color Blue } finish { f_button } }
    scale <0.9,0.9,1>
  }
  object { c_start
    texture { pigment { color Yellow } finish { f_content } }
    scale <0.7,0.7,0.2> translate <0,0,-0.08>
  }
}

sky_sphere {
    pigment {
      gradient y
      color_map {
        // Sky
        [ 0.0 color Blue ]
        [ 0.4 color Blue*0.3 ]
        [ 0.5 color White*0.4 ]
        [ 0.5 color White*0 ]
        [ 0.7 color White ]
        [ 1.0 color White ]
        // Ground
      }
      scale -2 translate 1.005 // Slight vertical offset
    }
}