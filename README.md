# CZML.jl

[![Build Status](https://github.com/danielstoops25@gmail.com/CZML.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/danielstoops25@gmail.com/CZML.jl/actions/workflows/CI.yml?query=branch%3Amain)

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
d = Document([p0, p1, p2])

# Printing the CZML file
fileName = tempname() * ".czml"
printCZML(d, fileName)
```

## Contributing

CZML.jl is a new package and any help is greatly appreciated. The following is a list of the highest priority items to do:

  - Finish adding unimplemented [CZML properties](https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Packet)
  - Expand testing
  - Add better validation of properties
  - Property validation functions should be executed after property creation
