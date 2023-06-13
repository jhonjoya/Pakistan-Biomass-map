library(shiny)
library(leaflet)

shinyUI(fluidPage(
      titlePanel("Slider App"),
      sidebarLayout(
            sidebarPanel(
                  h1("Pakistan Biomass Map"),
                  p("Filter by"),
                  numericInput("ElectExport", label = "Energy Export GW/h * yr (more than)",value = 10),
                  numericInput("SourcingRadius", label = "Sourcing radius kms (less than)",value = 1),
                  actionButton("recalc", "Generate Map")
            ),
            mainPanel(
                  h2("Locations with the highest Energy Export"),
                  leafletOutput("myMap"),
                  textOutput("numberOfZones"),
                  p("This map shows the locations of the principal biomass generators in Pakistan, the source is:"),
                  a("https://energydata.info/dataset/pakistan-biomass-mapping"),
                  p("In the search filters you can select from how much energy is generated and the location radius of its source")
            )
      )
))
