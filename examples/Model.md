# Model

## CZML File

This example was taken from Cesium Sandcastle [here](#https://sandcastle.cesium.com/?src=CZML%20Model.html&label=CZML).

```
[
{
  id: "document",
  name: "CZML Model",
  version: "1.0",
},
{
  id: "aircraft model",
  name: "Cesium Air",
  position: {
    cartographicDegrees: [-77, 37, 10000],
  },
  model: {
    gltf: "../SampleData/models/CesiumAir/Cesium_Air.glb",
    scale: 2.0,
    minimumPixelSize: 128,
  },
},          ]
```

# Julia Code

The above can be created using CZML in julia:

```julia

p0 = Preamble(; name = "CZML Model")

p1 = Packet(; id = "aircraft model", name = "Cesium Air",
    position = Position(; cartographicDegrees = [-77, 37, 10000]),
    model = Model(; gltf = "../SampleData/models/CesiumAir/Cesium_Air.glb", scale = 2.0,
        minimumPixelSize = 128))

d = Document(; preamble = p0, packets = p1)

fileName = tempname() * ".czml"

printCZML(d, fileName)
```
