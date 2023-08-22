# Point - Time Dynamic

## CZML File

This example was taken from Cesium Sandcastle [here](https://sandcastle.cesium.com/?src=CZML%20Point%20-%20Time%20Dynamic.html&label=CZML).

```
[
{
  id: "document",
  name: "CZML Point - Time Dynamic",
  version: "1.0",
},
{
  id: "point",
  availability: "2012-08-04T16:00:00Z/2012-08-04T16:05:00Z",
  position: {
    epoch: "2012-08-04T16:00:00Z",
    cartographicDegrees: [
      0,
      -70,
      20,
      150000,
      100,
      -80,
      44,
      150000,
      200,
      -90,
      18,
      150000,
      300,
      -98,
      52,
      150000,
    ],
  },
  point: {
    color: {
      rgba: [255, 255, 255, 128],
    },
    outlineColor: {
      rgba: [255, 0, 0, 128],
    },
    outlineWidth: 3,
    pixelSize: 15,
  },
},          ]
```

# Julia Code

The above can be created using CZML in julia:

```julia

p0 = Preamble(; name = "CZML Point - Time Dynamic")

p1 = Packet(; id = "point",
    availability = TimeInterval(; startTime = DateTime(2012, 8, 4, 16, 0, 0),
        endTime = DateTime(DateTime(2012, 8, 4, 16, 5, 0))),
    position = PositionList(; epoch = DateTime(2012, 8, 4, 16, 0, 0),
        cartographicDegrees = [0, -70, 20, 150000, 100, -80, 44, 150000, 200, -90, 18,
            150000, 300, -98, 52, 150000]),
    point = Point(;
        color = Color(; rgba = [255, 255, 255, 128]),
        outlineColor = Color(; rgba = [255, 0, 0, 128]),
        outlineWidth = 3,
        pixelSize = 15,
    ))

d = Document(; preamble = p0, packets = p1)

fileName = tempname() * ".czml"

printCZML(d, fileName)
```
