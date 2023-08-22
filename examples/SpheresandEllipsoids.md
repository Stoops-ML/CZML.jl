# Spheres and Ellipsoids

## CZML File

This example was taken from Cesium Sandcastle [here](https://sandcastle.cesium.com/?src=CZML%20Spheres%20and%20Ellipsoids.html&label=CZML).

```
[
{
  id: "document",
  name: "CZML Geometries: Spheres and Ellipsoids",
  version: "1.0",
},
{
  id: "blueEllipsoid",
  name: "blue ellipsoid",
  position: {
    cartographicDegrees: [-114.0, 40.0, 300000.0],
  },
  ellipsoid: {
    radii: {
      cartesian: [200000.0, 200000.0, 300000.0],
    },
    fill: true,
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
  id: "redSphere",
  name: "Red sphere with black outline",
  position: {
    cartographicDegrees: [-107.0, 40.0, 300000.0],
  },
  ellipsoid: {
    radii: {
      cartesian: [300000.0, 300000.0, 300000.0],
    },
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
      rgbaf: [0, 0, 0, 1],
    },
  },
},
{
  id: "yellowEllipsoid",
  name: "ellipsoid with yellow outline",
  position: {
    cartographicDegrees: [-100.0, 40.0, 300000.0],
  },
  ellipsoid: {
    radii: {
      cartesian: [200000.0, 200000.0, 300000.0],
    },
    fill: false,
    outline: true,
    outlineColor: {
      rgba: [255, 255, 0, 255],
    },
    slicePartitions: 24,
    stackPartitions: 36,
  },
},          ]
```

# Julia Code

The above can be created using CZML in julia:

```julia

p0 = Preamble(; name = "CZML Geometries: Spheres and Ellipsoids")

p1 = Packet(; id = "blueEllipsoid", name = "blue ellipsoid",
    position = Position(; cartographicDegrees = [-114.0, 40.0, 300000.0]),
    ellipsoid = Ellipsoid(;
        radii = EllipsoidRadii(; cartesian = [200000.0, 200000.0, 300000.0]),
        fill = true,
        material = Material(;
            solidColor = SolidColorMaterial(; color = Color(; rgba = [0, 0, 255, 255])),
        )))

p2 = Packet(; id = "redSphere", name = "Red sphere with black outline",
    position = Position(; cartographicDegrees = [-107.0, 40.0, 300000.0]),
    ellipsoid = Ellipsoid(;
        radii = EllipsoidRadii(; cartesian = [300000.0, 300000.0, 300000.0]),
        fill = true,
        material = Material(;
            solidColor = SolidColorMaterial(; color = Color(; rgba = [255, 0, 0, 100])),
        ), outline = true, outlineColor = Color(; rgbaf = [0, 0, 0, 1])))

p3 = Packet(; id = "yellowEllipsoid", name = "ellipsoid with yellow outline",
    position = Position(; cartographicDegrees = [-100.0, 40.0, 300000.0]),
    ellipsoid = Ellipsoid(;
        radii = EllipsoidRadii(; cartesian = [200000.0, 200000.0, 300000.0]),
        fill = false, outline = true,
        outlineColor = Color(; rgba = [255, 255, 0, 255]), slicePartitions = 24,
        stackPartitions = 36))

d = Document(; preamble = p0, packets = [p1, p2, p3])

fileName = tempname() * ".czml"

printCZML(d, fileName)
```
