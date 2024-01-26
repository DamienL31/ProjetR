base::source("packages.R")
base::source("global.r")


ui <- dashboardPage(
  skin = "black",
  dbHeader,
  dashboardSidebar(disable = TRUE),
  dashboardBody(
    box(
      title = "Important Informations",
      solidHeader = TRUE, 
      width = 12,
      background = "green", 
      status = "success",
      p("This dashboard presents summarized data for one artist. 
        Note: Only artists with at least 5 songs are included in the analysis
        You can customize the dashboard theme in the theme tab"),
      br(),
      p(
        HTML("<strong> Please select One Artist and discover insights and KPI over the tab"),
      )
    ),
    
    tabsetPanel(
      tabPanel(
        "Home",
        icon = icon("home"),
        box(
          title = "Artist",
          solidHeader = FALSE,
          width = 12,
          pickerInput("artist_select", " ", selected = "BTS", choices = unique(spotify_data$artist_name))
        ),
        box(
          title = "Chat with chatGPT",
          solidHeader = FALSE,
          width = 12,
          textInput("message", "Your message:"),
          actionButton("sendButton", "Send"),
          textOutput("responseText")
        )
      ),
      
      tabPanel(
        "KPI's",
        icon = icon("tachometer"),
        box(
          title = "kpi",
          solidHeader = FALSE,
          width = 12,
          valueBoxOutput("numStreams", width = 6),
          valueBoxOutput("numTracks", width = 6),
          valueBoxOutput("numArtists", width = 6),
          valueBoxOutput("numGenre", width = 6),
          br()
        )
      ),
      
      tabPanel(
        "Graphic",
        icon = icon("bar-chart"),
        plotlyOutput("tracksPerYearArtistPlot"),
        br(),
        br(),
        plotlyOutput("genrePopularityPlot")
      ),
      
      tabPanel(
        "Summary",
        icon = icon("table"),
        dataTableOutput("datatable_track")
      ),
      
      tabPanel("Thèmes",
               icon = icon("cog"),
               fluidRow(
                 themeSelector(),
               )
      )
    )
  )
)





