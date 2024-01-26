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
    valueBox(value = num_streams(), color = "lime",
             subtitle = "Number of streams",
             icon = icon("headphones"))
  })
  
  output$numTracks <- renderValueBox({
  valueBox(value = num_tracks(), color = "olive",
           subtitle = "Number of tracks",
           icon = icon("music"))
  })
  
  
  output$numArtists <- renderValueBox({
    valueBox(value = num_artists(), color = "olive",
             subtitle = "Number of Artists",
             icon = icon("users"))
  
  })
  
  
  output$numGenre <- renderValueBox({
    valueBox(value = num_genre(), color = "lime",
             subtitle = "Number of Genre",
             icon = icon("tag"))
    
  })
  
  
  output$datatable_track <- renderDT({
    data <- filtered_data() %>% 
      select(artist_name,track_name,streams,in_spotify_playlists,
             in_apple_playlists, in_deezer_playlists) %>%
      rename(artist = artist_name, track = track_name, spotify = in_spotify_playlists, 
             apple = in_apple_playlists, deezer = in_deezer_playlists)%>%
      arrange(desc(streams))
    
    datatable(data, options = list(
      scrollX = TRUE,
      paginate = TRUE,
      lengthMenu = c(5, 10, 15),
      pageLength = 20
    ))
    
  })
  
  output$tracksPerYearArtistPlot <- renderPlotly({
    
    data <- filtered_data() %>%
      group_by(released_year, artist_name) %>%
      summarize(tracks = n())
    
     ggplot(data, aes(x = released_year, y = tracks, color = artist_name)) +
      geom_line() +
      labs(title = "Number of Tracks per Year",
           x = "Year",
           y = "Number of tracks") +
      theme_minimal()
    
  })
  
  # Render the interactive plotly plot
  output$genrePopularityPlot <- renderPlotly({
    
    data <- filtered_data() %>%
      group_by(artist_name, genre) %>%
      summarize(count = n())
    
    ggplot(data, aes(x = genre, y = count, fill = genre)) +
      geom_col() +
      scale_fill_manual(values = rainbow(n_distinct(data$genre))) + 
      labs(title = "Popularity of genre",
           x = "Genre",
           y = "Count") +
      theme_classic()
    
  })
  
}





