# CZML.jl

[![Build Status](https://github.com/Stoops-ML/CZML.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/Stoops-ML/CZML.jl/actions/workflows/CI.yml?query=branch%3Amain)

Create CZML files in Julia.

## Installation

```Julia
]add CZML
```

## Quick Start

Recreating the [CZML Colors](https=/sandcastle.cesium.com/?src=CZML%20Colors.html&label=CZML) example from Cesium Sandcastle:

```Julia
using CZML

# Creating the packets
p0 = Preamble(name = "CZML Colors")
p1 = Packet(
    id = "rgba",
    name = "Rectangle with outline using RGBA Colors",
    rectangle = Rectangle(
        coordinates = RectangleCoordinates(wsenDegrees = [-120, 40, -110, 50]),
        fill = true,
        material = Material(
            solidColor = SolidColorMaterial(color = Color(rgba = [255, 0, 0, 100])),
        ),
        height = 0,
        outline = true,
        outlineColor = Color(rgba = [0, 0, 0, 255]),
    ),
)
p2 = Packet(
    id = "rgbaf",
    name = "Rectangle using RGBAF Colors",
    rectangle = Rectangle(
        coordinates = RectangleCoordinates(wsenDegrees = [-100, 40, -90, 50]),
        fill = true,
        material = Material(
            solidColor = SolidColorMaterial(color = Color(rgbaf = [1, 0, 0, 0.39])),
        ),
        height = 0,
        outline = true,
        outlineColor = Color(rgba = [0, 0, 0, 255]),
    ),
)

# Creating the document
d = Document(; preamble = p0, packets = [p1, p2])

# Printing the CZML file
fileName = tempname() * ".czml"
printCZML(d, fileName)
```

More examples can be found in the [examples](examples/) folder.

## Contributing

CZML.jl is a new package and any help is greatly appreciated. The following is an unsorted list of the highest priority items to do:

  - Finish adding unimplemented [CZML properties](https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/)

  - Expand validation of properties
  - Expand testing. The following [Cesium Sandcastle](https://sandcastle.cesium.com/) examples are to be added:
    
      + [CZML Polygon - Intervals and Availability](https://sandcastle.cesium.com/?src=CZML%20Polygon%20-%20Intervals%2C%20Availability.html&label=CZML)
      + [CZML Polygon - Interpolating References](https://sandcastle.cesium.com/?src=CZML%20Polygon%20-%20Interpolating%20References.html&label=CZML)
      + [CZML Model Articulations](https://sandcastle.cesium.com/?src=CZML%20Model%20Articulations.html&label=CZML)
      + [CZML Node Transformations](https://sandcastle.cesium.com/?src=CZML%20Model%20-%20Node%20Transformations.html&label=CZML)
