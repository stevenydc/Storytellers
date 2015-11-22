
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(leaflet)
library(rworldmap)
library(RColorBrewer)

colourPalette <- brewer.pal(10,'Reds')

shinyServer(function(input, output) {

  output$distPlot <- renderPlot({

    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)

    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')

  })

  output$attacks_map <- renderPlot({
    print(map("world2",wrap=T,resolution=2))
    attacks = country_attacks %>%
      filter(Year==input$year) %>%
      joinCountryData2Map(joinCode="NAME",nameJoinColumn="Country")
    mapCountryData( attacks, nameColumnToPlot="Freq",catMethod="fixedWidth",
                    colourPalette = colourPalette)
  })

})
