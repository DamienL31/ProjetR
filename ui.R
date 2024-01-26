base::source("packages.R")
base::source("global.r")


ui <- dashboardPage(skin = "black",
                    dbHeader,
                    dashboardSidebar(disable = TRUE),
                    dashboardBody(
                      box(
                        title = "Important Informations",
                        solidHeader = TRUE, 
                        width = 12,
                        background = "green", 
                        status = "success",
                        p("This dashboard presents summarized data for one or multiple artists.
                          Note : Only artists with at least 5 songs are included in the analysis")
                      ),
                      
                      box(
                        title = "Artist",
                        solidHeader = FALSE,
                        width = 6,
                        column(3, align = "center"),
                        column(6, align = "center"),
                        column(3, align = "center"),
                        pickerInput("artist_select", " ", 
                                    selected = "BTS", 
                                    choices = unique(spotify_data$artist_name))
                      ),
                      box( title = "chat with chatGPT",
                           solidHeader = FALSE, width = 6,
                           column(3, align = "center"),
                           column(6, align = "center",
                                  textInput("message", "Your message:"),
                                  actionButton("sendButton", "Send"),
                                  textOutput("responseText")
                           ),
                           column(3, align = "center")),
                      box(
                        title = "Stats",
                        solidHeader = FALSE,
                        width = 6,
                        valueBoxOutput("numStreams", width = 6),
                        valueBoxOutput("numTracks", width = 6),
                        valueBoxOutput("numArtists", width = 6),
                        valueBoxOutput("numGenre", width = 6),
                        br(),
                        fluidRow(
                          box(plotlyOutput("tracksPerYearArtistPlot")),
                          box(plotlyOutput("genrePopularityPlot")
                          ))),
                      box(
                        title = "Track Data",
                        dataTableOutput("datatable_track")
                      )
                    ))










