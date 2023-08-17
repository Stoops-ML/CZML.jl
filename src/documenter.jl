using Gumbo
using Cascadia

function makedoc(url::String)::String
    page = parsehtml(read(download(url), String))
    propertyname = match(r"\w+$", url).match
    id = replace(lowercase(propertyname), r"value$" => s"-value")
    s = Selector("#user-content-" * id)
    description = eachmatch(s, page.root)[1].parent.parent.children[3].children[1].text
    return """
    # $propertyname
    $description

    See here for more details: $url
    """
end
