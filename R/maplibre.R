#' @importFrom htmltools htmlDependency
#' @importFrom utils packageVersion
htmldeps <- function() {
  list(
    htmlDependency(
      "maplibre-gl",
      "1.15.2",
      src = "node_modules/maplibre-gl/dist",
      package = "leaflet.maplibregl",
      script = "maplibre-gl.js",
      stylesheet = "maplibre-gl.css",
      all_files = FALSE
    ),
    htmlDependency(
      "maplibre-gl-leaflet",
      "0.0.15",
      src = "node_modules/maplibre-gl-leaflet",
      package = "leaflet.maplibregl",
      script = "leaflet-maplibre-gl.js",
      all_files = FALSE
    ),
    htmlDependency(
      "leaflet_maplibregl",
      packageVersion("leaflet.maplibregl"),
      src = "binding",
      package = "leaflet.maplibregl",
      script = "leaflet_maplibregl.js",
      stylesheet = "leaflet_maplibregl.css",
      all_files = FALSE
    )
  )
}

# # Download the style layer (including mapbox URLs) and json-decode
# getStyleLayer <- function(url, accessToken) {
#   match <- regexec("^mapbox://styles/([^/]+)/([^/?]+)$", url)
#   match <- regmatches(url, match)[[1]]
#   if (length(match) > 0) {
#     username <- match[[2]]
#     style_id <- match[[3]]
#     url <- paste0(
#       "https://api.mapbox.com/styles/v1/",
#       username,
#       "/",
#       style_id,
#       "?access_token=",
#       utils::URLencode(accessToken, reserved = TRUE, repeated = TRUE)
#     )
#   }
#
#   jsonlite::fromJSON(url)
# }

#' @param attribution Attribution from service metadata copyright text is automatically displayed in Leaflet's default control. This property can be used for customization.
#' @param layers An array of Layer IDs like [3, 4, 5] to show from the service.
#' @param layerDefs A string representing a query to run against the service before the image is rendered. This can be a string like "3:STATE_NAME="Kansas"" or an object mapping different queries to specific layers {3:"STATE_NAME="Kansas"", 2:"POP2007>25000"}.
#' @param opacity Opacity of the layer. Should be a value between 0 (completely transparent) and 1 (completely opaque).
#' @param position Position of the layer relative to other overlays.
#' @param maxZoom Closest zoom level the layer will be displayed on the map.
#' @param minZoom Furthest zoom level the layer will be displayed on the map.
#' @param dynamicLayers JSON object literal used to manipulate the layer symbology defined in the service itself. Requires a 10.1 (or above) map service which supports dynamicLayers requests.
#' @param token If you pass a token in your options it will be included in all requests to the service.
#' @param useCors If this service should use CORS when making GET requests.
#' @param ... Other options to pass to Maplibre GL JS.
#'
#' @rdname addMaplibreGL
#' @export
maplibreOptions <- function(
  attribution = "",
  layers = NULL,
  layerDefs = NULL,
  opacity = 1,
  position = "front",
  maxZoom = NULL,
  minZoom = NULL,
  dynamicLayers = NULL,
  proxy = NULL,
  useCors = TRUE,
  ...
) {
  leaflet::filterNULL(list(
    attribution = attribution,
    layers = layers,
    layerDefs = layerDefs,
    opacity = opacity,
    position = position,
    maxZoom = maxZoom,
    minZoom = minZoom,
    dynamicLayers = dynamicLayers,
    proxy = proxy,
    useCors = useCors,
    ...

  ))
}

#' Adds a MapLibre GL layer to a Leaflet map
#'
#' Uses the [MapLibre GL Leaflet plugin](https://github.com/maplibre/maplibre-gl-leaflet)
#' to add a MapLibre GL layer to a Leaflet map.
#'
#' @param map The Leaflet R object (see [leaflet::leaflet()]).
#' @param style Tile vector URL; can begin with `http://` or `https://`.
#' @param layerId A layer ID; see
#'   [docs](https://rstudio.github.io/leaflet/showhide.html).
#' @param group The name of the group the newly created layer should belong to
#'   (for [leaflet::clearGroup()] and [leaflet::addLayersControl()] purposes).
#'   (Warning: Due to the way Leaflet and MapLibre GL JS integrate, showing/hiding
#'   a GL layer may give unexpected results.)
#' @param setView If `TRUE` (the default), drive the map to the center/zoom
#'   specified in the style (if any). Note that this will override any
#'   [leaflet::setView()] or [leaflet::fitBounds()] calls that occur between
#'   the `addMaplibreGL` call and when the style finishes loading; use
#'   `setView=FALSE` in those cases.
#' @param options A list of Map options. See the
#'   [MapLibre GL JS documentation](https://maplibre.org/maplibre-gl-js-docs/api/#map)
#'   for more details. Not all options may work in the context of Leaflet.
#' @examples
#'
#' library(leaflet)
#' \donttest{
#' leaflet() %>%
#'   addMaplibreGL(style = "https://demotiles.maplibre.org/style.json")
#' }
#' @export
#' @import leaflet
addMaplibreGL <- function(map, style = "https://maputnik.github.io/osm-liberty/style.json",
                        layerId = NULL, group = NULL, setView = TRUE,
                        options = maplibreOptions()) {

  map$dependencies <- c(
    map$dependencies,
    htmldeps()
  )

  options$style <- style

  invokeMethod(map, getMapData(map), "addMaplibreGL", setView, layerId, group, options)
}
