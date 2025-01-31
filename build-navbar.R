# Generate the navbar with a custom template. This lets us keep specifying the 
# nav structure in the yaml AND have a custom template for branding.
# These are based on the functionality from the rmarkdown package, and is a 
# horrific hack peeking into the internal bits.
# https://github.com/rstudio/rmarkdown/blob/d23e479017ceec894cc62c6b98f40f4188a4a75f/R/html_document.R

library(rmarkdown)

# parse the yaml for the header
navbar <- rmarkdown:::yaml_load_file("_navbar.yml")

# title and type
if (is.null(navbar$title)) navbar$title <- ""
if (is.null(navbar$type)) navbar$type <- "default"

# menu entries
left <- rmarkdown:::navbar_links_html(navbar$left)
right <- rmarkdown:::navbar_links_html(navbar$right)

# build the navigation bar and return it as a temp file
template <- rmarkdown:::file_string("_navbar_template.html")
navbar_html <- sprintf(template, navbar$type, navbar$title, left, right)

f <- file(file.path("content", "_navbar.html"))
writeLines(navbar_html, f)
close(f)
