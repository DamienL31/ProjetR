# Define the server logic
server <- function(input, output, session) {
  
  filtered_data <- reactive({
    spotify_data %>% filter(artist_name %in% input$artist_select)
  })
  
  # Calculate number of streams
  num_streams <- reactive({
    filtered_data() %>%
      summarize(n_streams = sum(streams)) %>%
      pull()
    
    
  })
  
  # Calculate number of tracks
  num_tracks <- reactive({
    filtered_data() %>%
      summarize(n_tracks = n())%>%
                  pull()
                
  })
    
  # Calculate number of artists
  num_artists <- reactive({
    length(input$artist_select)
   
  })
  
  # Calculate number of genre
    num_genre <- reactive({
      filtered_data() %>%
        summarize(n_genre = n_distinct(genre)) %>%
        pull()
    })
  
  
  
  output$numStreams <- renderValueBox({
    valueBox(value = num_streams(), color = "olive",
             subtitle = "Number of streams")
  })
  
  output$numTracks <- renderValueBox({
  valueBox(value = num_tracks(), color = "olive",
           subtitle = "Number of tracks")
  })
  
  
  output$numArtists <- renderValueBox({
    valueBox(value = num_artists(), color = "olive",
             subtitle = "Number of Artists")
  
  })
  
  
  output$numGenre <- renderValueBox({
    valueBox(value = num_genre(), color = "olive",
             subtitle = "Number of Genre")
    
  })
  
  
  output$datatable_track <- renderDT({
    data <- filtered_data() %>% 
      ...
    
    datatable(data, options = list(
      scrollX = TRUE,
      paginate = T,
      lengthMenu = c(5, 10, 15),
      pageLength = 20
    ))
    
  })
  
  output$tracksPerYearArtistPlot <- renderPlotly({
    
    data <- filtered_data() %>%
      group_by(released_year) %>%
      summarize(tracks = n())
    
     ggplot(data, aes(x = released_year, y = tracks, legend = data$id_artists)) +
      geom_line() +
      labs(title = "Number of Tracks per Year",
           x = "Year",
           y = "Number of tracks") +
      theme_minimal()
    
  })
  
  # Render the interactive plotly plot
  output$genrePopularityPlot <- renderPlotly({
    
    data <- filtered_data() %>%
      ...
    
    p <- ggplot()
    ...
    theme_minimal() 
    
    ggplotly(p)
    
  })
  
}





