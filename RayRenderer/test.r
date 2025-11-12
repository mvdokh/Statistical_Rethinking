#install.packages("devtools", dependencies = TRUE)
#devtools::install_github("tylermorganwall/rayrender")

#library(rayrender)
#scene = generate_ground(material=diffuse(checkercolor="grey20")) %>%
  #add_object(sphere(y=0.2,material=glossy(color="#ff0000ff",reflectance=0.1))) 
#render_scene(scene, parallel = TRUE, width = 800, height = 800, samples = 150)

scene = generate_cornell()
render_scene(scene, lookfrom=c(278,278,-800),lookat = c(278,278,0), aperture=0, fov=40, samples = 64,
             ambient_light=FALSE, parallel=TRUE, width=1000, height=800)