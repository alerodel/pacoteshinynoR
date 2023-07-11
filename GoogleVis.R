getwd()

#Veremos várias formas de plotar gráficos com o GoogleVis
'https://cran.r-project.org/web/packages/googleVis/vignettes/googleVis_intro.html'
'https://www.youtube.com/watch?v=PTti7OMbURo&list=WL&index=1&t=33s'
'https://libguides.rutgers.edu/data'
install.packages("googleVis")
library(googleVis)

search()

demo(googleVis)

#Vamos fazer o primeiro gráfico
?gvisGeoChart
data("Exports")
View(Exports)
gchart <- gvisGeoChart(data = Exports, locationvar = 'Country',
                       colorvar = 'Profit', 
                       options = list(projection = "kavrayskiy-vii"))
plot(gchart)

#Se eu quiser plotar apenas os EUA
eua <- data.frame(state.name, state.x77)

Agchart <- gvisGeoChart(data = eua, locationvar = 'state.name',
                        colorvar = 'Illiteracy', 
                        options = list(region = 'US', displayMode = 'regions',
                                       resolution = 'provinces',
                        width = 600, height = 400))
plot(Agchart)

tempdir() #Pasta onde se localizam os arquivos temporários dos gráficos gerados na web em html


################################################################################

### Podemos inclusive usar o pacote shiny juntamente com o googleVis
### com isso montamos app's
#Usando appShiny
shinyServer(function(input, output) {
  datasetInput <- reactive({
    switch(input$dataset,
           "rock" = rock,
           "pressure" = pressure,
           "cars" = cars)
  })
  
  output$view <- renderGvis({
    gvisScatterChart(datasetInput())
  })
})

# ui.R
shinyUI(pageWithSidebar(
  headerPanel("googleVis on Shiny"),
  sidebarPanel(
    selectInput("dataset", "Choose a dataset:", 
                choices = c("rock", "pressure", "cars"))
  ),
  mainPanel(
    htmlOutput("view")
  )
))

#You can run the example locally with the following statement.

library(shiny)
runApp(system.file("shiny/", package="googleVis"))