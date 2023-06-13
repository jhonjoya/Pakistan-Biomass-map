library(shiny)
library(dplyr)
library(leaflet)
library(stringr)

shinyServer(function(input, output) {
      df <- eventReactive(input$recalc, {read.csv("https://energydata.info/dataset/a27a9b60-706b-4c81-8608-c913d2ed998f/resource/fdf8d9ba-4454-4e07-a132-3e2e2a329a36/download/pakistanbiomassindustrial.csv") %>%
            mutate(lat = as.numeric(gsub(",", "",substr(Coordinates, 2,str_locate(pattern = ",", Coordinates)[,1]))),
                               lng = as.numeric(substr(Coordinates, str_locate(pattern = " ", Coordinates)[,1]+1, nchar(Coordinates)-1)))%>%
            select(-Coordinates) %>%
            filter(Electricity.export..GWh.yr. >= input$ElectExport) %>%
            filter(Sourcing.radius..km. <= input$SourcingRadius)
            }, ignoreNULL = TRUE)
      output$myMap <- renderLeaflet({
            leaflet() %>%
                  addProviderTiles(providers$Stamen.TonerLite,
                                   options = providerTileOptions(noWrap = TRUE)
                                   ) %>% addMarkers(data = df())
      })
      output$numberOfZones <- renderText({
            paste("Number of zones",nrow(df()))})
})
