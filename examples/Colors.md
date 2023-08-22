# Colors

## CZML File

This example was taken from Cesium Sandcastle [here](#https://sandcastle.cesium.com/?src=CZML%20Colors.html&label=CZML).

```
[
{
  id: "document",
  name: "CZML Colors",
  version: "1.0",
},
{
  id: "rgba",
  name: "Rectangle with outline using RGBA Colors",
  rectangle: {
    coordinates: {
      wsenDegrees: [-120, 40, -110, 50],
    },
    fill: true,
    material: {
      solidColor: {
        color: {
          rgba: [255, 0, 0, 100],
        },
      },
    },
    height: 0, // disables ground clamping, needed for outlines
    outline: true,
    outlineColor: {
      rgba: [0, 0, 0, 255],
    },
  },
},
{
  id: "rgbaf",
  name: "Rectangle using RGBAF Colors",
  rectangle: {
    coordinates: { wsenDegrees: [-100, 40, -90, 50] },
    fill: true,
    material: {
      solidColor: {
        color: {
          rgbaf: [1, 0, 0, 0.39],
        },
      },
    },
    height: 0, // disables ground clamping, needed for outlines
    outline: true,
    outlineColor: {
      rgba: [0, 0, 0, 255],
    },
  },
},          ]
```

# Julia Code

The above can be created using CZML in julia:

```julia

p0 = Preamble(; name = "CZML Colors")

p1 = Packet(; id = "rgba", name = "Rectangle with outline using RGBA Colors",
    rectangle = Rectangle(;
        coordinates = RectangleCoordinates(; wsenDegrees = [-120, 40, -110, 50]),
        fill = true,
        material = Material(;
            solidColor = SolidColorMaterial(; color = Color(; rgba = [255, 0, 0, 100])
            )), height = 0, outline = true, outlineColor = Color(; rgba = [0, 0, 0, 255])))

p2 = Packet(; id = "rgbaf", name = "Rectangle using RGBAF Colors",
    rectangle = Rectangle(;
        coordinates = RectangleCoordinates(; wsenDegrees = [-100, 40, -90, 50]),
        fill = true,
        material = Material(;
            solidColor = SolidColorMaterial(; color = Color(; rgbaf = [1, 0, 0, 0.39])
            )), height = 0, outline = true, outlineColor = Color(; rgba = [0, 0, 0, 255])))

d = Document(; preamble = p0, packets = [p1, p2])

fileName = tempname() * ".czml"

printCZML(d, fileName)
```
