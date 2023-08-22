# Wall

## CZML File

This example was taken from Cesium Sandcastle [here](https://sandcastle.cesium.com/?src=CZML%20Wall.html&label=CZML).

```
[
{
  id: "document",
  name: "CZML Wall",
  version: "1.0",
},
{
  id: "wall",
  wall: {
    positions: {
      cartographicDegrees: [
        -115.0,
        50.0,
        1500000,
        -112.5,
        50.0,
        500000,
        -110.0,
        50.0,
        1500000,
        -107.5,
        50.0,
        500000,
        -105.0,
        50.0,
        1500000,
        -102.5,
        50.0,
        500000,
        -100.0,
        50.0,
        1500000,
        -97.5,
        50.0,
        500000,
        -95.0,
        50.0,
        1500000,
        -92.5,
        50.0,
        500000,
        -90.0,
        50.0,
        1500000,
      ],
    },
    material: {
      solidColor: {
        color: {
          rgba: [255, 0, 0, 150],
        },
      },
    },
  },
},          ]
```

# Julia Code

The above can be created using CZML in julia:

```julia

p0 = Preamble(; name = "CZML Wall")

p1 = Packet(; id = "wall",
    wall = Wall(;
        positions = PositionList(;
            cartographicDegrees = [-115.0, 50.0, 1500000, -112.5, 50.0, 500000, -110.0,
                50.0, 1500000, -107.5, 50.0, 500000, -105.0, 50.0, 1500000, -102.5,
                50.0, 500000, -100.0, 50.0, 1500000, -97.5, 50.0, 500000, -95.0, 50.0,
                1500000, -92.5, 50.0, 500000, -90.0, 50.0, 1500000]),
        material = Material(;
            solidColor = SolidColorMaterial(; color = Color(; rgba = [255, 0, 0, 150])),
        )))

d = Document(; preamble = p0, packets = p1)

fileName = tempname() * ".czml"

printCZML(d, fileName)
```
