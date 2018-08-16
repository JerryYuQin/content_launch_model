# Install:
#   devtools::install_github("jcheng5/googleCharts")
library(googleCharts)

# Use global max/min for axes so the view window stays
# constant as the user moves between years
xlim <- list(
  min = min(data$completion_rate) - 0.1,
  max = max(data$completion_rate) + 0.1
)
ylim <- list(
  min = min(data$series_reach) -0.1,
  max = max(data$series_reach) + 0.1
)

shinyUI(fluidPage(
  # This line loads the Google Charts JS library
  googleChartsInit(),

  # Use the Google webfont "Source Sans Pro"
  tags$link(
    href=paste0("http://fonts.googleapis.com/css?",
                "family=Source+Sans+Pro:300,600,300italic"),
    rel="stylesheet", type="text/css"),
  tags$style(type="text/css",
    "body {font-family: 'Source Sans Pro'}"
  ),

  h2("Series Launch Model Demo"),

  googleBubbleChart("chart",
    width="100%", height = "510px",
    # Set the default options for this chart; they can be
    # overridden in server.R on a per-update basis. See
    # https://developers.google.com/chart/interactive/docs/gallery/bubblechart
    # for option documentation.
    options = list(
      fontName = "Source Sans Pro",
      fontSize = 13,
      # Set axis labels and ranges
      hAxis = list(
        title = "Median Completion Rate, per episode",
        viewWindow = xlim
      ),
      vAxis = list(
        title = "Series Overall Reach",
        viewWindow = ylim
      ),
      # The default padding is a little too spaced out
      chartArea = list(
        top = 50, left = 75,
        height = "75%", width = "75%"
      ),
      # Allow pan/zoom
      explorer = list(),
      
      # Set bubble visual props
      bubble = list(
        opacity = 0.4, stroke = "none",
        # Hide bubble label
        textStyle = list(
          color = "none"
        )
      ),
      # Set fonts
      titleTextStyle = list(
        fontSize = 16
      ),
      tooltip = list(
        textStyle = list(
          fontSize = 12
        )
      )
    )
  ),
  fluidRow(
      shiny::column(4, 
                  selectInput("content_type_2", "Content_Type (Edu vs. Info-tainment)",
                              c("All", "Edu-tainment", "Inspo-tainment") ) ),
      shiny::column(4, 
                    textInput("playlist_name", "Playlist Name contains (e.g. Spark)")  ),
      shiny::column(4, 
                    selectInput("talent_tier", "Talent Tier Featured",
                                c("All", "Celebrity", "Tastemaker", "Rising Star", "Instructor") ) )
    ),
  fluidRow(
    shiny::column(4,offset = 4,
    sliderInput("week_num", "Weeks Since Launch",
                min = min(data$week_num), max = max(data$week_num),
                value = min(data$week_num),step = 1, animate = TRUE) )
  )
  )
)
