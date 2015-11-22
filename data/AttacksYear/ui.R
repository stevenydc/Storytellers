
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(rworldmap)
library(leaflet)

shinyUI(fluidPage(

  # Application title
  titlePanel("Terrorist Attacks per Year"),

    # Show a plot of the generated distribution
  plotOutput("attacks_map",width="100%",height="600px"),
  sliderInput("year",
              "Year",
              width="100%",
              min = 1992,
              max = 2008,
              value = 1992)

))
