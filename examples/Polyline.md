# Polyline

## CZML File

This example was taken from Cesium Sandcastle [here](#https://sandcastle.cesium.com/?src=CZML%20Polyline.html&label=CZML).

```
[
{
  id: "document",
  name: "CZML Geometries: Polyline",
  version: "1.0",
},
{
  id: "redLine",
  name: "Red line clamped to terain",
  polyline: {
    positions: {
      cartographicDegrees: [-75, 35, 0, -125, 35, 0],
    },
    material: {
      solidColor: {
        color: {
          rgba: [255, 0, 0, 255],
        },
      },
    },
    width: 5,
    clampToGround: true,
  },
},
{
  id: "blueLine",
  name: "Glowing blue line on the surface",
  polyline: {
    positions: {
      cartographicDegrees: [-75, 37, 0, -125, 37, 0],
    },
    material: {
      polylineGlow: {
        color: {
          rgba: [100, 149, 237, 255],
        },
        glowPower: 0.2,
        taperPower: 0.5,
      },
    },
    width: 10,
  },
},
{
  id: "orangeLine",
  name:
    "Orange line with black outline at height and following the surface",
  polyline: {
    positions: {
      cartographicDegrees: [-75, 39, 250000, -125, 39, 250000],
    },
    material: {
      polylineOutline: {
        color: {
          rgba: [255, 165, 0, 255],
        },
        outlineColor: {
          rgba: [0, 0, 0, 255],
        },
        outlineWidth: 2,
      },
    },
    width: 5,
  },
},
{
  id: "purpleLine",
  name: "Purple arrow at height",
  polyline: {
    positions: {
      cartographicDegrees: [-75, 43, 500000, -125, 43, 500000],
    },
    material: {
      polylineArrow: {
        color: {
          rgba: [148, 0, 211, 255],
        },
      },
    },
    arcType: "NONE",
    width: 10,
  },
},
{
  id: "dashedLine",
  name: "Blue dashed line",
  polyline: {
    positions: {
      cartographicDegrees: [-75, 45, 500000, -125, 45, 500000],
    },
    material: {
      polylineDash: {
        color: {
          rgba: [0, 255, 255, 255],
        },
      },
    },
    width: 4,
  },
},          ]
```

# Julia Code

The above can be created using CZML in julia:

```julia

p0 = Preamble(; name = "CZML Geometries: Polyline")

p1 = Packet(; id = "redLine", name = "Red line clamped to terain",
    polyline = Polyline(;
        positions = PositionList(; cartographicDegrees = [-75, 35, 0, -125, 35, 0]),
        material = PolylineMaterial(;
            solidColor = SolidColorMaterial(; color = Color(; rgba = [255, 0, 0, 255])),
        ), width = 5, clampToGround = true))

p2 = Packet(; id = "blueLine", name = "Glowing blue line on the surface",
    polyline = Polyline(;
        positions = PositionList(; cartographicDegrees = [-75, 37, 0, -125, 37, 0]),
        material = PolylineMaterial(;
            polylineGlow = PolylineGlowMaterial(;
                color = Color(; rgba = [100, 149, 237, 255]), glowPower = 0.2,
                taperPower = 0.5)), width = 10))

p3 = Packet(; id = "orangeLine",
    name =

    "Orange line with black outline at height and following the surface",
    polyline = Polyline(;
        positions = PositionList(;
            cartographicDegrees = [-75, 39, 250000, -125, 39, 250000]),
        material = PolylineMaterial(;
            polylineOutline = PolylineOutlineMaterial(;
                color = Color(; rgba = [255, 165, 0, 255]),
                outlineColor = Color(; rgba = [0, 0, 0, 255]), outlineWidth = 2)), width = 5))

p4 = Packet(; id = "purpleLine", name = "Purple arrow at height",
    polyline = Polyline(;
        positions = PositionList(;
            cartographicDegrees = [-75, 43, 500000, -125, 43, 500000]),
        material = PolylineMaterial(;
            polylineArrow = PolylineArrowMaterial(;
                color = Color(; rgba = [148, 0, 211, 255]))), arcType = ArcTypes.NONE, width = 10))

p5 = Packet(; id = "dashedLine", name = "Blue dashed line",
    polyline = Polyline(;
        positions = PositionList(;
            cartographicDegrees = [-75, 45, 500000, -125, 45, 500000]),
        material = PolylineMaterial(;
            polylineDash = PolylineDashMaterial(;
                color = Color(; rgba = [0, 255, 255, 255]))), width = 4))

d = Document(; preamble = p0, packets = [p1, p2, p3, p4, p5])

fileName = tempname() * ".czml"

printCZML(d, fileName)
```
