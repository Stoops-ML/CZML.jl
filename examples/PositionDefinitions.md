# Position Definitions

## CZML File

This example was taken from Cesium Sandcastle [here](https://sandcastle.cesium.com/?src=CZML%20Position%20Definitions.html&label=CZML).

```
[
{
  id: "document",
  name: "CZML Position Definitions",
  version: "1.0",
},
{
  id: "point1",
  name: "point in cartographic degrees",
  position: {
    cartographicDegrees: [-111.0, 40.0, 150000.0],
  },
  point: {
    color: {
      rgba: [100, 0, 200, 255],
    },
    outlineColor: {
      rgba: [200, 0, 200, 255],
    },
    pixelSize: {
      number: 10,
    },
  },
},
{
  id: "point2",
  name: "point in cartesian coordinates",
  position: {
    cartesian: [
      1216469.9357990976,
      -4736121.71856379,
      4081386.8856866374,
    ],
  },
  point: {
    color: {
      rgba: [0, 100, 200, 255],
    },
    outlineColor: {
      rgba: [200, 0, 200, 255],
    },
    pixelSize: {
      number: 10,
    },
  },
},
{
  id: "point 3",
  name: "point in cartographic radians",
  position: {
    cartographicRadians: [Math.PI, Math.PI, 150000],
  },
  point: {
    color: {
      rgba: [10, 200, 10, 255],
    },
    outlineColor: {
      rgba: [200, 0, 200, 255],
    },
    pixelSize: {
      number: 10,
    },
  },
},          ]
```

# Julia Code

The above can be created using CZML in julia:

```julia

p0 = Preamble(; name = "CZML Position Definitions")

p1 = Packet(; id = "point1", name = "point in cartographic degrees",
    position = Position(; cartographicDegrees = [-111.0, 40.0, 150000.0]),
    point = Point(;
        color = Color(; rgba = [100, 0, 200, 255]),
        outlineColor = Color(; rgba = [200, 0, 200, 255]),
        pixelSize = 10,
    ))

p2 = Packet(; id = "point2", name = "point in cartesian coordinates",
    position = Position(;
        cartesian = [1216469.9357990976, -4736121.71856379, 4081386.8856866374]),
    point = Point(;
        color = Color(; rgba = [0, 100, 200, 255]),
        outlineColor = Color(; rgba = [200, 0, 200, 255]),
        pixelSize = 10,
    ))

p3 = Packet(; id = "point 3", name = "point in cartographic radians",
    position = Position(; cartographicRadians = [FIXED_PI, FIXED_PI, 150000]),
    point = Point(;
        color = Color(; rgba = [10, 200, 10, 255]),
        outlineColor = Color(; rgba = [200, 0, 200, 255]),
        pixelSize = 10,
    ))

d = Document(; preamble = p0, packets = [p1, p2, p3])

fileName = tempname() * ".czml"

printCZML(d, fileName)
```
