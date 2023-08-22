# Box

## CZML File

This example was taken from Cesium Sandcastle [here](https://sandcastle.cesium.com/?src=CZML%20Box.html&label=CZML).

```
[
{
  id: "document",
  name: "box",
  version: "1.0",
},
{
  id: "shape1",
  name: "Blue box",
  position: {
    cartographicDegrees: [-114.0, 40.0, 300000.0],
  },
  box: {
    dimensions: {
      cartesian: [400000.0, 300000.0, 500000.0],
    },
    material: {
      solidColor: {
        color: {
          rgba: [0, 0, 255, 255],
        },
      },
    },
  },
},
{
  id: "shape2",
  name: "Red box with black outline",
  position: {
    cartographicDegrees: [-107.0, 40.0, 300000.0],
  },
  box: {
    dimensions: {
      cartesian: [400000.0, 300000.0, 500000.0],
    },
    material: {
      solidColor: {
        color: {
          rgba: [255, 0, 0, 128],
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
  id: "shape3",
  name: "Yellow box outline",
  position: {
    cartographicDegrees: [-100.0, 40.0, 300000.0],
  },
  box: {
    dimensions: {
      cartesian: [400000.0, 300000.0, 500000.0],
    },
    fill: false,
    outline: true,
    outlineColor: {
      rgba: [255, 255, 0, 255],
    },
  },
},          ]
```

# Julia Code

The above can be created using CZML in julia:

```julia

p0 = Preamble(; name = "box")

p1 = Packet(; id = "shape1", name = "Blue box",
    position = Position(; cartographicDegrees = [-114.0, 40.0, 300000.0]),
    box = Box(;
        dimensions = BoxDimensions(; cartesian = [400000.0, 300000.0, 500000.0]),
        material = Material(;
            solidColor = SolidColorMaterial(; color = Color(; rgba = [0, 0, 255, 255])
            ))))

p2 = Packet(; id = "shape2", name = "Red box with black outline",
    position = Position(; cartographicDegrees = [-107.0, 40.0, 300000.0]),
    box = Box(;
        dimensions = BoxDimensions(; cartesian = [400000.0, 300000.0, 500000.0]),
        material = Material(;
            solidColor = SolidColorMaterial(; color = Color(; rgba = [255, 0, 0, 128])
            )), outline = true, outlineColor = Color(; rgba = [0, 0, 0, 255])))

p3 = Packet(; id = "shape3", name = "Yellow box outline",
    position = Position(; cartographicDegrees = [-100.0, 40.0, 300000.0]),
    box = Box(;
        dimensions = BoxDimensions(; cartesian = [400000.0, 300000.0, 500000.0]),
        fill = false, outline = true, outlineColor = Color(; rgba = [255, 255, 0, 255]),
    ))

d = Document(; preamble = p0, packets = [p1, p2, p3])

fileName = tempname() * ".czml"

printCZML(d, fileName)
```
