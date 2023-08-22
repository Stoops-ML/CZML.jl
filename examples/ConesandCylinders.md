# Cones and Cylinders

## CZML File

This example was taken from Cesium Sandcastle [here](https://sandcastle.cesium.com/?src=CZML%20Cones%20and%20Cylinders.html&label=CZML).

```
[
{
  id: "document",
  name: "CZML Geometries: Cones and Cylinders",
  version: "1.0",
},
{
  id: "shape1",
  name: "Green cylinder with black outline",
  position: {
    cartographicDegrees: [-100.0, 40.0, 200000.0],
  },
  cylinder: {
    length: 400000.0,
    topRadius: 200000.0,
    bottomRadius: 200000.0,
    material: {
      solidColor: {
        color: {
          rgba: [0, 255, 0, 128],
        },
      },
    },
    outline: true,
    outlineColor: {
      rgba: [0, 0, 0, 255],
    },
  },
},
{
  id: "shape2",
  name: "Red cone",
  position: {
    cartographicDegrees: [-105.0, 40.0, 200000.0],
  },
  cylinder: {
    length: 400000.0,
    topRadius: 0.0,
    bottomRadius: 200000.0,
    material: {
      solidColor: {
        color: {
          rgba: [255, 0, 0, 255],
        },
      },
    },
  },
},          ]
```

# Julia Code

The above can be created using CZML in julia:

```julia

p0 = Preamble(; name = "CZML Geometries: Cones and Cylinders")

p1 = Packet(; id = "shape1", name = "Green cylinder with black outline",
    position = Position(; cartographicDegrees = [-100.0, 40.0, 200000.0]),
    cylinder = Cylinder(; length = 400000.0, topRadius = 200000.0,
        bottomRadius = 200000.0,
        material = Material(;
            solidColor = SolidColorMaterial(; color = Color(; rgba = [0, 255, 0, 128])
            )), outline = true, outlineColor = Color(; rgba = [0, 0, 0, 255])))

p2 = Packet(; id = "shape2", name = "Red cone",
    position = Position(; cartographicDegrees = [-105.0, 40.0, 200000.0]),
    cylinder = Cylinder(; length = 400000.0, topRadius = 0.0, bottomRadius = 200000.0,
        material = Material(;
            solidColor = SolidColorMaterial(; color = Color(; rgba = [255, 0, 0, 255])
            ))))

d = Document(; preamble = p0, packets = [p1, p2])

fileName = tempname() * ".czml"

printCZML(d, fileName)
```
