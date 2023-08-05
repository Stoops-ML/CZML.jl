using JSON
using CZML
using Test

"""
Convert CZML string from Cesium Sandcastle to a Vector of CZML packets.
"""
function CZML_string_to_JSON(str_CZML::String)::Vector{Any}
    str_CZML = replace(str_CZML, r"// (.+)\n" => s"")  # remove comments
    str_CZML = replace(str_CZML, r",\s*([\]}])" => s"\1")  # remove comma before closing bracket
    str_CZML = replace(str_CZML, r"\s*([\[{,])\s*(\w+)\s*:" => s"\1\"\2\":")  # add double quotes to all keywords
    return JSON.parse(str_CZML)
end

#=
Some of the expected results may have been minimally modifed from Cesium Sandcastle in the following ways:
- reduce size of fractional-part of floating point numbers
=#
@testset "CZML.jl" begin
    @testset "CZML Circles and Ellipses" begin
        # https://sandcastle.cesium.com/?src=CZML%20Circles%20and%20Ellipses.html&label=CZML
        str_CZML = """[
            {
              id: "document",
              name: "CZML Geometries: Circles and Ellipses",
              version: "1.0",
            },
            {
              id: "shape1",
              name: "Green circle at height",
              position: {
                cartographicDegrees: [-111.0, 40.0, 150000.0],
              },
              ellipse: {
                semiMinorAxis: 300000.0,
                semiMajorAxis: 300000.0,
                height: 200000.0,
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
              id: "shape2",
              name: "Red ellipse with white outline on surface",
              position: {
                cartographicDegrees: [-103.0, 40.0, 0],
              },
              ellipse: {
                semiMinorAxis: 250000.0,
                semiMajorAxis: 400000.0,
                height: 0,
                material: {
                  solidColor: {
                    color: {
                      rgba: [255, 0, 0, 127],
                    },
                  },
                },
                outline: true, // height must be set for outlines to display
                outlineColor: {
                  rgba: [255, 255, 255, 255],
                },
              },
            },
            {
              id: "shape3",
              name:
                "Blue translucent, rotated, and extruded ellipse with outline",
              position: {
                cartographicDegrees: [-95.0, 40.0, 100000.0],
              },
              ellipse: {
                semiMinorAxis: 150000.0,
                semiMajorAxis: 300000.0,
                extrudedHeight: 200000.0,
                rotation: 0.78539,
                material: {
                  solidColor: {
                    color: {
                      rgba: [0, 0, 255, 127],
                    },
                  },
                },
                outline: true,
              },
            },
          ]"""
        expected_result = CZML_string_to_JSON(str_CZML)

        # recreate using CZML
        p0 = Preamble(; name = "CZML Geometries: Circles and Ellipses")
        p1 = Packet(;
            id = "shape1",
            name = "Green circle at height",
            position = Position(; cartographicDegrees = [-111.0, 40.0, 150000.0]),
            ellipse = Ellipse(;
                semiMinorAxis = 300000.0,
                semiMajorAxis = 300000.0,
                height = 200000.0,
                material = Material(;
                    solidColor = SolidColorMaterial(;
                        color = Color(; rgba = [0, 255, 0, 255]),
                    ),
                ),
            ),
        )
        p2 = Packet(;
            id = "shape2",
            name = "Red ellipse with white outline on surface",
            position = Position(; cartographicDegrees = [-103.0, 40.0, 0.0]),
            ellipse = Ellipse(;
                semiMinorAxis = 250000.0,
                semiMajorAxis = 400000.0,
                height = 0.0,
                material = Material(;
                    solidColor = SolidColorMaterial(;
                        color = Color(; rgba = [255, 0, 0, 127]),
                    ),
                ),
                outline = true,
                outlineColor = Color(; rgba = [255, 255, 255, 255]),
            ),
        )
        p3 = Packet(;
            id = "shape3",
            name = "Blue translucent, rotated, and extruded ellipse with outline",
            position = Position(; cartographicDegrees = [-95.0, 40.0, 100000.0]),
            ellipse = Ellipse(;
                semiMinorAxis = 150000.0,
                semiMajorAxis = 300000.0,
                extrudedHeight = 200000.0,
                rotation = 0.78539,
                material = Material(;
                    solidColor = SolidColorMaterial(;
                        color = Color(; rgba = [0, 0, 255, 127]),
                    ),
                ),
                outline = true,
            ),
        )
        d = Document([p0, p1, p2, p3])
        fileName = tempname() * ".czml"
        printCZML(d, fileName)

        # tests
        @test isfile(fileName)
        @test expected_result == JSON.parsefile(fileName)
    end

    @testset "CZML Box" begin
        # https://sandcastle.cesium.com/?src=CZML%20Box.html&label=CZML
        str_CZML = """[
            {
              id: "document",
              name: "box",
              version: "1.0",
            },
            {
              id: "shape1",
              name: "Blue box",
              position: {
                cartographicDegrees: [-114.0, 40.0, 300000.0],
              },
              box: {
                dimensions: {
                  cartesian: [400000.0, 300000.0, 500000.0],
                },
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
              name: "Red box with black outline",
              position: {
                cartographicDegrees: [-107.0, 40.0, 300000.0],
              },
              box: {
                dimensions: {
                  cartesian: [400000.0, 300000.0, 500000.0],
                },
                material: {
                  solidColor: {
                    color: {
                      rgba: [255, 0, 0, 128],
                    },
                  },
                },
                outline: true,
                outlineColor: {
                  rgba: [0, 0, 0, 255],
                },
              },
            },
            {
              id: "shape3",
              name: "Yellow box outline",
              position: {
                cartographicDegrees: [-100.0, 40.0, 300000.0],
              },
              box: {
                dimensions: {
                  cartesian: [400000.0, 300000.0, 500000.0],
                },
                fill: false,
                outline: true,
                outlineColor: {
                  rgba: [255, 255, 0, 255],
                },
              },
            },
          ]"""
        expected_result = CZML_string_to_JSON(str_CZML)

        # recreate using CZML
        p0 = Preamble(; name = "box")
        p1 = Packet(;
            id = "shape1",
            name = "Blue box",
            position = Position(; cartographicDegrees = [-114.0, 40.0, 300000.0]),
            box = Box(;
                dimensions = BoxDimensions(; cartesian = [400000.0, 300000.0, 500000.0]),
                material = Material(;
                    solidColor = SolidColorMaterial(;
                        color = Color(; rgba = [0, 0, 255, 255]),
                    ),
                )),
        )
        p2 = Packet(;
            id = "shape2",
            name = "Red box with black outline",
            position = Position(; cartographicDegrees = [-107.0, 40.0, 300000.0]),
            box = Box(;
                dimensions = BoxDimensions(; cartesian = [400000.0, 300000.0, 500000.0]),
                material = Material(;
                    solidColor = SolidColorMaterial(;
                        color = Color(; rgba = [255, 0, 0, 128]),
                    ),
                ),
                outline = true,
                outlineColor = Color(; rgba = [0, 0, 0, 255]),
            ),
        )
        p3 = Packet(;
            id = "shape3",
            name = "Yellow box outline",
            position = Position(; cartographicDegrees = [-100.0, 40.0, 300000.0]),
            box = Box(;
                dimensions = BoxDimensions(; cartesian = [400000.0, 300000.0, 500000.0]),
                fill = false,
                outline = true,
                outlineColor = Color(; rgba = [255, 255, 0, 255]),
            ),
        )
        d = Document([p0, p1, p2, p3])
        fileName = tempname() * ".czml"
        printCZML(d, fileName)

        # tests
        @test isfile(fileName)
        @test expected_result == JSON.parsefile(fileName)
    end

    @testset "CZML Billboard and Label" begin
        # https://sandcastle.cesium.com/?src=CZML%20Billboard%20and%20Label.html&label=CZML
        str_CZML = """[
            {
              id: "document",
              name: "Basic CZML billboard and label",
              version: "1.0",
            },
            {
              id: "some-unique-id",
              name: "AGI",
              description:
                "<p><a href='http://www.agi.com' target='_blank'>Analytical Graphics, Inc.</a> (AGI) founded Cesium.</p>",
              billboard: {
                image:
                  "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAACvSURBVDhPrZDRDcMgDAU9GqN0lIzijw6SUbJJygUeNQgSqepJTyHG91LVVpwDdfxM3T9TSl1EXZvDwii471fivK73cBFFQNTT/d2KoGpfGOpSIkhUpgUMxq9DFEsWv4IXhlyCnhBFnZcFEEuYqbiUlNwWgMTdrZ3JbQFoEVG53rd8ztG9aPJMnBUQf/VFraBJeWnLS0RfjbKyLJA8FkT5seDYS1Qwyv8t0B/5C2ZmH2/eTGNNBgMmAAAAAElFTkSuQmCC",
                scale: 1.5,
              },
              label: {
                fillColor: {
                  rgba: [255, 255, 255, 255],
                },
                font: "12pt Lucida Console",
                horizontalOrigin: "LEFT",
                style: "FILL",
                text: "AGI",
                showBackground: true,
                backgroundColor: {
                  rgba: [112, 89, 57, 200],
                },
              },
              position: {
                cartesian: [
                  1216361.4096,
                  -4736253.1753,
                  4081267.4865,
                ],
              },
            },
          ]"""
        expected_result = CZML_string_to_JSON(str_CZML)

        # recreate using CZML
        p0 = Preamble(; name = "Basic CZML billboard and label")
        p1 = Packet(;
            id = "some-unique-id",
            name = "AGI",
            description = "<p><a href='http://www.agi.com' target='_blank'>Analytical Graphics, Inc.</a> (AGI) founded Cesium.</p>",
            billboard = Billboard(;
                image = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAACvSURBVDhPrZDRDcMgDAU9GqN0lIzijw6SUbJJygUeNQgSqepJTyHG91LVVpwDdfxM3T9TSl1EXZvDwii471fivK73cBFFQNTT/d2KoGpfGOpSIkhUpgUMxq9DFEsWv4IXhlyCnhBFnZcFEEuYqbiUlNwWgMTdrZ3JbQFoEVG53rd8ztG9aPJMnBUQf/VFraBJeWnLS0RfjbKyLJA8FkT5seDYS1Qwyv8t0B/5C2ZmH2/eTGNNBgMmAAAAAElFTkSuQmCC",
                scale = 1.5,
            ),
            label = Label(;
                fillColor = Color(; rgba = [255, 255, 255, 255]),
                font = "12pt Lucida Console",
                horizontalOrigin = HorizontalOrigins.LEFT,
                style = LabelStyles.FILL,
                text = "AGI",
                showBackground = true,
                backgroundColor = Color(; rgba = [112, 89, 57, 200]),
            ),
            position = Position(;
                cartesian = [1216361.4096, -4736253.1753, 4081267.4865],
            ),
        )
        d = Document([p0, p1])
        fileName = tempname() * ".czml"
        printCZML(d, fileName)

        # tests
        @test isfile(fileName)
        @test expected_result == JSON.parsefile(fileName)
    end

    @testset "CZML Colors" begin
        # https://sandcastle.cesium.com/?src=CZML%20Colors.html&label=CZML
        str_CZML = """[
            {
              id: "document",
              name: "CZML Colors",
              version: "1.0",
            },
            {
              id: "rgba",
              name: "Rectangle with outline using RGBA Colors",
              rectangle: {
                coordinates: {
                  wsenDegrees: [-120, 40, -110, 50],
                },
                fill: true,
                material: {
                  solidColor: {
                    color: {
                      rgba: [255, 0, 0, 100],
                    },
                  },
                },
                height: 0, // disables ground clamping, needed for outlines
                outline: true,
                outlineColor: {
                  rgba: [0, 0, 0, 255],
                },
              },
            },
            {
              id: "rgbaf",
              name: "Rectangle using RGBAF Colors",
              rectangle: {
                coordinates: { wsenDegrees: [-100, 40, -90, 50] },
                fill: true,
                material: {
                  solidColor: {
                    color: {
                      rgbaf: [1, 0, 0, 0.39],
                    },
                  },
                },
                height: 0, // disables ground clamping, needed for outlines
                outline: true,
                outlineColor: {
                  rgba: [0, 0, 0, 255],
                },
              },
            },
          ]"""
        expected_result = CZML_string_to_JSON(str_CZML)

        # recreate using CZML
        p0 = Preamble(; name = "CZML Colors")
        p1 = Packet(;
            id = "rgba",
            name = "Rectangle with outline using RGBA Colors",
            rectangle = Rectangle(;
                coordinates = RectangleCoordinates(; wsenDegrees = [-120, 40, -110, 50]),
                fill = true,
                material = Material(;
                    solidColor = SolidColorMaterial(;
                        color = Color(; rgba = [255, 0, 0, 100]),
                    ),
                ),
                height = 0,
                outline = true,
                outlineColor = Color(; rgba = [0, 0, 0, 255]),
            ),
        )
        p2 = Packet(;
            id = "rgbaf",
            name = "Rectangle using RGBAF Colors",
            rectangle = Rectangle(;
                coordinates = RectangleCoordinates(; wsenDegrees = [-100, 40, -90, 50]),
                fill = true,
                material = Material(;
                    solidColor = SolidColorMaterial(;
                        color = Color(; rgbaf = [1, 0, 0, 0.39]),
                    ),
                ),
                height = 0,
                outline = true,
                outlineColor = Color(; rgba = [0, 0, 0, 255]),
            ),
        )
        d = Document([p0, p1, p2])
        fileName = tempname() * ".czml"
        printCZML(d, fileName)

        # tests
        @test isfile(fileName)
        @test expected_result == JSON.parsefile(fileName)
    end

    @testset "CZML Cones and Cylinders" begin
        # https://sandcastle.cesium.com/?src=CZML%20Cones%20and%20Cylinders.html&label=CZML
        str_CZML = """[
            {
              id: "document",
              name: "CZML Geometries: Cones and Cylinders",
              version: "1.0",
            },
            {
              id: "shape1",
              name: "Green cylinder with black outline",
              position: {
                cartographicDegrees: [-100.0, 40.0, 200000.0],
              },
              cylinder: {
                length: 400000.0,
                topRadius: 200000.0,
                bottomRadius: 200000.0,
                material: {
                  solidColor: {
                    color: {
                      rgba: [0, 255, 0, 128],
                    },
                  },
                },
                outline: true,
                outlineColor: {
                  rgba: [0, 0, 0, 255],
                },
              },
            },
            {
              id: "shape2",
              name: "Red cone",
              position: {
                cartographicDegrees: [-105.0, 40.0, 200000.0],
              },
              cylinder: {
                length: 400000.0,
                topRadius: 0.0,
                bottomRadius: 200000.0,
                material: {
                  solidColor: {
                    color: {
                      rgba: [255, 0, 0, 255],
                    },
                  },
                },
              },
            },
          ]"""
        expected_result = CZML_string_to_JSON(str_CZML)

        # recreate using CZML
        p0 = Preamble(; name = "CZML Geometries: Cones and Cylinders")
        p1 = Packet(;
            id = "shape1",
            name = "Green cylinder with black outline",
            position = Position(; cartographicDegrees = [-100.0, 40.0, 200000.0]),
            cylinder = Cylinder(;
                length = 400000.0,
                topRadius = 200000.0,
                bottomRadius = 200000.0,
                material = Material(;
                    solidColor = SolidColorMaterial(;
                        color = Color(; rgba = [0, 255, 0, 128]),
                    ),
                ),
                outline = true,
                outlineColor = Color(; rgba = [0, 0, 0, 255]),
            ),
        )
        p2 = Packet(;
            id = "shape2",
            name = "Red cone",
            position = Position(; cartographicDegrees = [-105.0, 40.0, 200000.0]),
            cylinder = Cylinder(;
                length = 400000.0,
                topRadius = 0.0,
                bottomRadius = 200000.0,
                material = Material(;
                    solidColor = SolidColorMaterial(;
                        color = Color(; rgba = [255, 0, 0, 255]),
                    ),
                ),
            ),
        )
        d = Document([p0, p1, p2])
        fileName = tempname() * ".czml"
        printCZML(d, fileName)

        # tests
        @test isfile(fileName)
        @test expected_result == JSON.parsefile(fileName)
    end

    @testset "srrm2sddm" begin
        srrm_arr = [0, 0.1, 0.2, 10, 1, 0.2, 0.3, 20, 2, 0.3, 0.4, 30]
        expected_result = [
            0,
            rad2deg(0.1),
            rad2deg(0.2),
            10,
            1,
            rad2deg(0.2),
            rad2deg(0.3),
            20,
            2,
            rad2deg(0.3),
            rad2deg(0.4),
            30,
        ]
        @test expected_result == srrm2sddm(srrm_arr)
    end

    @testset "sddm2srrm" begin
        sddm_arr = [0.0, 10.0, 20.0, 10.0, 1.0, 20.0, 30.0, 20.0, 2.0, 30.0, 40.0, 30.0]
        expected_result = [
            0,
            deg2rad(10),
            deg2rad(20),
            10,
            1,
            deg2rad(20),
            deg2rad(30),
            20,
            2,
            deg2rad(30),
            deg2rad(40),
            30,
        ]
        @test expected_result == sddm2srrm(sddm_arr)
    end

    @testset "rrm2ddm" begin
        rrm_arr = [0.1, 0.2, 10, 0.2, 0.3, 20, 0.3, 0.4, 30]
        expected_result = [
            rad2deg(0.1),
            rad2deg(0.2),
            10,
            rad2deg(0.2),
            rad2deg(0.3),
            20,
            rad2deg(0.3),
            rad2deg(0.4),
            30,
        ]
        @test expected_result == rrm2ddm(rrm_arr)
    end

    @testset "ddm2rrm" begin
        ddm_arr = [10.0, 20.0, 10.0, 20.0, 30.0, 20.0, 30.0, 40.0, 30.0]
        expected_result = [
            deg2rad(10),
            deg2rad(20),
            10,
            deg2rad(20),
            deg2rad(30),
            20,
            deg2rad(30),
            deg2rad(40),
            30,
        ]
        @test expected_result == ddm2rrm(ddm_arr)
    end
end
