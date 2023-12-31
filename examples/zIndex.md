# zIndex

## CZML File

This example was taken from Cesium Sandcastle [here](https://sandcastle.cesium.com/?src=CZML%20ZIndex.html&label=CZML).

```
[
{
  id: "document",
  name: "CZML zIndex",
  version: "1.0",
},
{
  id: "shape1",
  name: "Blue circle",
  position: {
    cartographicDegrees: [-105.0, 40.0, 0.0],
  },
  ellipse: {
    semiMinorAxis: 300000.0,
    semiMajorAxis: 300000.0,
    zIndex: 3,
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
  name: "Green corridor",
  corridor: {
    positions: {
      cartographicDegrees: [
        -90.0,
        43.0,
        0,
        -95.0,
        43.0,
        0,
        -95.0,
        38.0,
        0,
      ],
    },
    width: 200000.0,
    zIndex: 3,
    material: {
      solidColor: {
        color: {
          rgba: [0, 255, 0, 255],
        },
      },
    },
  },
},
{
  id: "shape3",
  name: "Red polygon",
  polygon: {
    positions: {
      cartographicDegrees: [
        -115.0,
        47.0,
        0,
        -115.0,
        42.0,
        0,
        -107.0,
        43.0,
        0,
        -102.0,
        41.0,
        0,
        -102.0,
        45.0,
        0,
      ],
    },
    zIndex: 1,
    material: {
      solidColor: {
        color: {
          rgba: [255, 0, 0, 255],
        },
      },
    },
  },
},
{
  id: "shape4",
  name: "Striped rectangle",
  rectangle: {
    coordinates: {
      wsenDegrees: [-105, 40, -95, 50],
    },
    zIndex: 2,
    fill: true,
    material: {
      stripe: {
        orientation: "VERTICAL",
        evenColor: { rgba: [255, 255, 0, 255] },
        oddColor: { rgba: [255, 0, 255, 255] },
        repeat: 5,
      },
    },
  },
},          ]
```

# Julia Code

The above can be created using CZML in julia:

```julia

p0 = Preamble(; name = "CZML zIndex")

p1 = Packet(; id = "shape1", name = "Blue circle",
    position = Position(; cartographicDegrees = [-105.0, 40.0, 0.0]),
    ellipse = Ellipse(; semiMinorAxis = 300000.0, semiMajorAxis = 300000.0, zIndex = 3,
        material = Material(;
            solidColor = SolidColorMaterial(; color = Color(; rgba = [0, 0, 255, 255])),
        )))

p2 = Packet(; id = "shape2", name = "Green corridor",
    corridor = Corridor(;
        positions = PositionList(;
            cartographicDegrees = [-90.0, 43.0, 0, -95.0, 43.0, 0, -95.0, 38.0, 0]), width = 200000.0, zIndex = 3,
        material = Material(;
            solidColor = SolidColorMaterial(; color = Color(; rgba = [0, 255, 0, 255])),
        )))

p3 = Packet(; id = "shape3", name = "Red polygon",
    polygon = Polygon(;
        positions = PositionList(;
            cartographicDegrees = [-115.0, 47.0, 0, -115.0, 42.0, 0, -107.0, 43.0, 0,
                -102.0, 41.0, 0, -102.0, 45.0, 0]), zIndex = 1,
        material = Material(;
            solidColor = SolidColorMaterial(; color = Color(; rgba = [255, 0, 0, 255])),
        )))

p4 = Packet(; id = "shape4", name = "Striped rectangle",
    rectangle = Rectangle(;
        coordinates = RectangleCoordinates(; wsenDegrees = [-105, 40, -95, 50]),
        zIndex = 2, fill = true,
        material = Material(;
            stripe = StripeMaterial(; orientation = StripeOrientations.VERTICAL,
                evenColor = Color(; rgba = [255, 255, 0, 255]),
                oddColor = Color(; rgba = [255, 0, 255, 255]), repeat = 5))))

d = Document(; preamble = p0, packets = [p1, p2, p3, p4])

fileName = tempname() * ".czml"

printCZML(d, fileName)
```
