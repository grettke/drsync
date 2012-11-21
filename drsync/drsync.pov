// Credit: Eric Bainville - Mar 2007
// Location: http://www.bealto.com/geo-povray-buttons_glow.html

#include "colors.inc"
#include "metals.inc"
#include "textures.inc"

global_settings {
  assumed_gamma 1        
  ambient_light White
  photons {
    spacing 0.01
    media 60
  }
}

#declare camera_distance = 20;
camera {                        
  location <0,0,camera_distance>
  right x up y direction -z
  angle 180*atan(2/camera_distance)/pi
  // Uncomment to render a side view  
  //rotate 50*x
}

light_source { <-30,70,100>, White
  photons {
    reflection off
    refraction off
  }
  media_interaction off
}  

// Rounded square button
#declare b_rsquare = superellipsoid {
  // Adjust first parameter: 1=circle, 0=square
  <0.6,0.3>
  translate -z scale <1,1,0.2>
}

// Button symbol (start/stop)
#declare c_start = text {
    ttf "timrom.ttf" "POV-RAY 3.0" 1, 0
    pigment { Red }
  }

// Button texture
#declare t_button = texture {
  finish {
    ambient 0.2
    diffuse 0.3
    specular 0
    phong 0.6 phong_size 20
    reflection 0
  }
  normal { bumps 0.05 scale 0.01 }
  pigment { color Blue }
}

// Button and contents (hole in button for backlight)
#declare final_button = difference {
  object { b_rsquare scale <0.9,0.9,1> }
  object { c_start scale <0.5,0.5,2> translate <0,0,-1> }
}

// Backlight
light_source {
  <0,0,-20>, Yellow
  projected_through { box { <-0.7,-0.7,-1.1>,<0.7,0.7,-1> } }
  photons {
    reflection on
    refraction on
  }
  media_interaction on
}

// Button
object { final_button texture { t_button }
  photons {
    target
    collect on
    reflection on
    refraction on
  }
}

// Media container
cylinder { <0,0,0.01>,<0,0,1>,5
  hollow pigment { color rgbt 1 }
  interior { media {
    scattering { 2,White*0.7 }
    density { spherical scale 2
      density_map {
        // Outside
        [0 rgb 0] [0.55 rgb 0]
        // Inside and center
        [0.65 rgb 1] [1 rgb 1]
      }
  } } }
  photons {
    target
    collect on
    reflection on
    refraction on
  }
}