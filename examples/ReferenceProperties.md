# Reference Properties

## CZML File

This example was taken from Cesium Sandcastle [here](https://sandcastle.cesium.com/?src=CZML%20Reference%20Properties.html&label=CZML).

```
[
{
  id: "document",
  name: "CZML Reference Properties",
  version: "1.0",
},
{
  id: "position-reference",
  position: {
    cartographicDegrees: [-110.0, 50.0, 0],
  },
},
{
  id: "fillColor-reference",
  name: "Referencing Position",
  description:
    "<p>For more examples of reference properties, see CZML Polygon - Interpolating References.</p>",
  billboard: {
    image:
      "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAACvSURBVDhPrZDRDcMgDAU9GqN0lIzijw6SUbJJygUeNQgSqepJTyHG91LVVpwDdfxM3T9TSl1EXZvDwii471fivK73cBFFQNTT/d2KoGpfGOpSIkhUpgUMxq9DFEsWv4IXhlyCnhBFnZcFEEuYqbiUlNwWgMTdrZ3JbQFoEVG53rd8ztG9aPJMnBUQf/VFraBJeWnLS0RfjbKyLJA8FkT5seDYS1Qwyv8t0B/5C2ZmH2/eTGNNBgMmAAAAAElFTkSuQmCC",
    scale: 1.5,
  },
  label: {
    fillColor: {
      rgba: [255, 255, 255, 255],
    },
    font: "13pt Lucida Console",
    horizontalOrigin: "LEFT",
    outlineColor: {
      rgba: [150, 0, 150, 255],
    },
    outlineWidth: 3,
    pixelOffset: {
      cartesian2: [20, 0],
    },
    style: "FILL_AND_OUTLINE",
    text: "referencing position",
  },
  position: {
    reference: "position-reference#position",
  },
},
{
  id: "polygon",
  name: "Referencing Fill Color",
  description:
    "<p>For more examples of reference properties, see CZML Polygon - Interpolating References.</p>",
  label: {
    fillColor: {
      rgba: [255, 255, 255, 255],
    },
    font: "13pt Lucida Console",
    horizontalOrigin: "LEFT",
    pixelOffset: {
      cartesian2: [20, 0],
    },
    style: "FILL_AND_OUTLINE",
    text: "referencing fillColor",
  },
  position: {
    cartographicDegrees: [-105, 35, 0],
  },
  polygon: {
    positions: {
      cartographicDegrees: [
        -115.0,
        37.0,
        0,
        -115.0,
        32.0,
        0,
        -107.0,
        33.0,
        0,
        -102.0,
        31.0,
        0,
        -102.0,
        35.0,
        0,
      ],
    },
    height: 0,
    material: {
      solidColor: {
        color: {
          reference: "fillColor-reference#label.outlineColor",
        },
      },
    },
  },
},          ]
```

# Julia Code

The above can be created using CZML in julia:

```julia

p0 = Preamble(; name = "CZML Reference Properties")

p1 = Packet(; id = "position-reference",
    position = Position(; cartographicDegrees = [-110.0, 50.0, 0]))

p2 = Packet(; id = "fillColor-reference", name = "Referencing Position",
    description =

    "<p>For more examples of reference properties, see CZML Polygon - Interpolating References.</p>",
    billboard = Billboard(;
        image =

        "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAACvSURBVDhPrZDRDcMgDAU9GqN0lIzijw6SUbJJygUeNQgSqepJTyHG91LVVpwDdfxM3T9TSl1EXZvDwii471fivK73cBFFQNTT/d2KoGpfGOpSIkhUpgUMxq9DFEsWv4IXhlyCnhBFnZcFEEuYqbiUlNwWgMTdrZ3JbQFoEVG53rd8ztG9aPJMnBUQf/VFraBJeWnLS0RfjbKyLJA8FkT5seDYS1Qwyv8t0B/5C2ZmH2/eTGNNBgMmAAAAAElFTkSuQmCC",
        scale = 1.5),
    label = Label(; fillColor = Color(; rgba = [255, 255, 255, 255]),
        font = "13pt Lucida Console", horizontalOrigin = HorizontalOrigins.LEFT,
        outlineColor = Color(; rgba = [150, 0, 150, 255]), outlineWidth = 3,
        pixelOffset = PixelOffset(; cartesian2 = [20, 0]),
        style = LabelStyles.FILL_AND_OUTLINE, text = "referencing position"), position = Position(; reference = "position-reference#position"))

p3 = Packet(; id = "polygon", name = "Referencing Fill Color",
    description =

    "<p>For more examples of reference properties, see CZML Polygon - Interpolating References.</p>",
    label = Label(; fillColor = Color(; rgba = [255, 255, 255, 255]),
        font = "13pt Lucida Console", horizontalOrigin = HorizontalOrigins.LEFT,
        pixelOffset = PixelOffset(; cartesian2 = [20, 0]),
        style = LabelStyles.FILL_AND_OUTLINE, text = "referencing fillColor"), position = Position(; cartographicDegrees = [-105, 35, 0]),
    polygon = Polygon(;
        positions = PositionList(;
            cartographicDegrees = [-115.0, 37.0, 0, -115.0, 32.0, 0, -107.0, 33.0, 0,
                -102.0, 31.0, 0, -102.0, 35.0, 0]), height = 0,
        material = Material(;
            solidColor = SolidColorMaterial(;
                color = Color(; reference = "fillColor-reference#label.outlineColor")))))

d = Document(; preamble = p0, packets = [p1, p2, p3])

fileName = tempname() * ".czml"

printCZML(d, fileName)
```
