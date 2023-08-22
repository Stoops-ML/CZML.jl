# Rectangle

## CZML File

This example was taken from Cesium Sandcastle [here](https://sandcastle.cesium.com/?src=CZML%20Rectangle.html&label=CZML).

```
[          {
id: "document",
name: "CZML Geometries: Rectangle",
version: "1.0",          },          {
id: "redRectangle",
name: "extruded red rectangle with black outline",
rectangle: {
  coordinates: {
    wsenDegrees: [-120, 40, -110, 50],
  },
  height: 600000,
  extrudedHeight: 0,
  fill: true,
  material: {
    solidColor: {
      color: {
        rgba: [255, 0, 0, 100],
      },
    },
  },
  outline: true,
  outlineColor: {
    rgba: [0, 0, 0, 255],
  },
},          },          {
id: "stripeRectangle",
name: "rectangle with blue/green stripes",
rectangle: {
  coordinates: {
    wsenDegrees: [-105, 40, -95, 50],
  },
  height: 0,
  fill: true,
  material: {
    stripe: {
      orientation: "VERTICAL",
      evenColor: { rgba: [0, 255, 0, 255] },
      oddColor: { rgba: [0, 0, 255, 255] },
      repeat: 5,
    },
  },
},          },          {
id: "yellowRectangle",
name: "extruded rectangle with yellow outline",
rectangle: {
  coordinates: {
    wsenDegrees: [-90, 40, -80, 50],
  },
  height: 600000,
  extrudedHeight: 0,
  fill: false,
  outline: true,
  outlineColor: {
    rgba: [255, 255, 0, 255],
  },
  outlineWidth: 2,
  rotation: 0.5,
},          },          {
id: "textureRectangle",
name: "rectangle with image, above surface",
rectangle: {
  coordinates: {
    wsenDegrees: [-75, 40, -50, 45],
  },
  height: 600000,
  fill: true,
  material: {
    image: {
      image: { uri: "../images/Cesium_Logo_Color.jpg" },
      color: {
        rgba: [255, 255, 255, 128],
      },
    },
  },
},          },        ]
```

# Julia Code

The above can be created using CZML in julia:

```julia

p0 = Preamble(; name = "CZML Geometries: Rectangle")

p1 = Packet(; id = "redRectangle", name = "extruded red rectangle with black outline",
    rectangle = Rectangle(;
        coordinates = RectangleCoordinates(; wsenDegrees = [-120, 40, -110, 50]),
        height = 600000, extrudedHeight = 0, fill = true,
        material = Material(;
            solidColor = SolidColorMaterial(; color = Color(; rgba = [255, 0, 0, 100])),
        ), outline = true, outlineColor = Color(; rgba = [0, 0, 0, 255])))

p2 = Packet(; id = "stripeRectangle", name = "rectangle with blue/green stripes",
    rectangle = Rectangle(;
        coordinates = RectangleCoordinates(; wsenDegrees = [-105, 40, -95, 50]),
        height = 0, fill = true,
        material = Material(;
            stripe = StripeMaterial(; orientation = StripeOrientations.VERTICAL,
                evenColor = Color(; rgba = [0, 255, 0, 255]),
                oddColor = Color(; rgba = [0, 0, 255, 255]), repeat = 5))))

p3 = Packet(; id = "yellowRectangle", name = "extruded rectangle with yellow outline",
    rectangle = Rectangle(;
        coordinates = RectangleCoordinates(; wsenDegrees = [-90, 40, -80, 50]),
        height = 600000, extrudedHeight = 0, fill = false, outline = true,
        outlineColor = Color(; rgba = [255, 255, 0, 255]), outlineWidth = 2,
        rotation = 0.5))

p4 = Packet(; id = "textureRectangle", name = "rectangle with image, above surface",
    rectangle = Rectangle(;
        coordinates = RectangleCoordinates(; wsenDegrees = [-75, 40, -50, 45]),
        height = 600000, fill = true,
        material = Material(;
            image = ImageMaterial(;
                image = Uri(; uri = "../images/Cesium_Logo_Color.jpg"),
                color = Color(; rgba = [255, 255, 255, 128])))))

d = Document(; preamble = p0, packets = [p1, p2, p3, p4])

fileName = tempname() * ".czml"

printCZML(d, fileName)
```
