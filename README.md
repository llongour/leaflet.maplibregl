# leaflet.mapblibregl

Provides an R interface to extend the [R Leaflet](https://rstudio.github.io/leaflet/) package with the [MapLibre GL Leaflet](https://github.com/maplibre/maplibre-gl-leaflet) plugin.

## Compatibility

WebGL support is required. Most modern web browsers are supported, but IE11 may not work.

RStudio 1.1 on Windows and Linux do not support WebGL and will not work. RStudio 1.1 for Mac should work.

RStudio 1.2 will work if the rendering engine is set to Desktop OpenGL, which is the default on many systems. If your maps fail to render, you can try changing the rendering engine from the default value of "Auto-detect" to "Desktop OpenGL" by going to Tools | Global Options | General | Advanced | Rendering Engine. (Tip: If this puts your IDE into an unusable state, holding Ctrl during startup will bring up a dialog that lets you revert the Rendering Engine setting to "Auto-detect".)

## Installation

This package is not yet available on CRAN.

```r
devtools::install_github("llongour/leaflet.maplibregl")
```

## Usage

Create your Leaflet map, and call the `addMaplibreGL` function.

```r
library(leaflet)
library(leaflet.maplibregl)

leaflet() %>%
  addMaplibreGL(style = "[https://maputnik.github.io/osm-liberty/style.json](https://demotiles.maplibre.org/style.json)")
```

## License

MIT
