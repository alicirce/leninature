% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/lenin.R
\docType{data}
\name{lenin}
\alias{lenin}
\title{Works by Vladimir Ilyich Ulyanov}
\format{
A data frame, containing four columns:
\describe{
\item{url}{
Link to work online at the Marxists Internet Archive. Prepend the
following text to access: \code{"https://www.marxists.org/archive/lenin/"}.
}
\item{title}{Title of the page}
\item{text_annotation}{
Where available, tags associated with a paragraph of text, depends on the
HTML mark-up of the source material.
}
\item{text}{
Text, usually about one paragraph per row. (This depends on how
the HTML markup was done.)
}
\item{year}{
Year of publication
}
}
}
\source{
\url{https://www.marxists.org/archive/lenin/by-title.htm/}
}
\usage{
lenin
}
\description{
All works written by Lenin available on the Marxists Internet Archive
(marxists.org).
}
\details{
The text is stored as a data frame with five columns. Each row corresponds
approximately to a paragraph. One current limitation is that individual
chapters of longer works (e.g. State And Revolution) are stored with distinct
titles/urls.
}
\keyword{datasets}
