# Point

## CZML File

This example was taken from Cesium Sandcastle [here](#https://sandcastle.cesium.com/?src=CZML%20Point.html&label=CZML).

```
[
{
  id: "document",
  name: "CZML Point",
  version: "1.0",
},
{
  id: "point 1",
  name: "point",
  position: {
    cartographicDegrees: [-111.0, 40.0, 0],
  },
  point: {
    color: {
      rgba: [255, 255, 255, 255],
    },
    outlineColor: {
      rgba: [255, 0, 0, 255],
    },
    outlineWidth: 4,
    pixelSize: 20,
  },
},          ]
```

# Julia Code

The above can be created using CZML in julia:

```julia

p0 = Preamble(; name = "CZML Point")

p1 = Packet(; id = "point 1", name = "point",
    position = Position(; cartographicDegrees = [-111.0, 40.0, 0]),
    point = Point(;
        color = Color(; rgba = [255, 255, 255, 255]),
        outlineColor = Color(; rgba = [255, 0, 0, 255]),
        outlineWidth = 4,
        pixelSize = 20,
    ))

d = Document(; preamble = p0, packets = p1)

fileName = tempname() * ".czml"

printCZML(d, fileName)
```
