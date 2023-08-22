using JSON
using JuliaFormatter

function writeexamples()
    FILES_ADDED = false

    open("test/runtests.jl", "r") do tests_file
        while !eof(tests_file)
            line = readline(tests_file)
            m = match(r"@testset \"CZML (.+)\" begin", line)
            if !isnothing(m)
                # get contents of test
                test_contents = []
                while true
                    line = readline(tests_file)
                    if isnothing(match(r"^ *end$", line))
                        push!(test_contents, line)
                    else
                        break
                    end
                end

                # get data
                test_name = m.captures[1]
                data = join(test_contents)
                url = match(r"(https.+label=CZML)", data)
                CZML = match(r"str_CZML = \"\"\"(.+)\"\"\"", data)
                julia_CZML = match(r"# recreate using CZML(.+)# tests", data)
                if isnothing(url) | isnothing(CZML) | isnothing(julia_CZML)
                    error("Could not get data for $test_name")
                end

                # print example
                fname = replace(test_name, r"\W" => "") * ".md"
                tmp_path = tempdir() * "\\" * fname
                str_url = url.captures[1]
                str_julia_CZML =
                    replace(string(julia_CZML.captures[1]), r"    " => s"\n")
                str_CZML = replace(string(CZML.captures[1]), r"            " => s"\n")
                open(tmp_path, "w") do out_file
                    write(
                        out_file,
                        "# ",
                        test_name,
                        "\n",
                        "## CZML File\n\nThis example was taken from Cesium Sandcastle [here](#",
                        str_url,
                        ").\n\n```\n",
                        str_CZML,
                        "\n```\n# Julia Code\nThe above can be created using CZML in julia:\n```julia",
                        str_julia_CZML,
                        "\n```\n",
                    )
                end
                format(
                    tmp_path;
                    always_for_in = true,
                    for_in_replacement = "in",
                    remove_extra_newlines = true,
                    import_to_using = true,
                    pipe_to_function_call = true,
                    format_docstrings = true,
                    join_lines_based_on_source = true,
                    indent_submodule = true,
                    separate_kwargs_with_semicolon = true,
                    format_markdown = true,
                    whitespace_typedefs = false,
                    whitespace_ops_in_indices = false,
                )
                format(
                    tmp_path;
                    always_for_in = true,
                    for_in_replacement = "in",
                    remove_extra_newlines = true,
                    import_to_using = true,
                    pipe_to_function_call = true,
                    format_docstrings = true,
                    join_lines_based_on_source = true,
                    indent_submodule = true,
                    separate_kwargs_with_semicolon = true,
                    format_markdown = true,
                    whitespace_typedefs = false,
                    whitespace_ops_in_indices = false,
                )  # run again to ensure correct formatting

                # copy file to folder
                f_path = "examples/" * fname
                if !isfile(f_path)
                    println("Created $fname")
                    cp(tmp_path, f_path)
                    FILES_ADDED = true
                else
                    copy_file = false
                    open(f_path, "r") do test_file
                        open(tmp_path, "r") do tmp_file
                            current_test_file = read(test_file, String)
                            tmp_test_file = read(tmp_file, String)
                            if current_test_file != tmp_test_file
                                copy_file = true
                            end
                        end
                    end
                    if copy_file
                        println("Reformatted $fname")
                        cp(tmp_path, f_path; force = true)
                        FILES_ADDED = true
                    end
                end
            end
        end
    end

    if FILES_ADDED
        error("Example files added or modified!")
    end
end

writeexamples()
