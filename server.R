library(shiny)

library(UsingR)
library(MASS)
#library(ggplot2)
# library(rCharts)
# 
# library(DT)
# library(BH)


data("mtcars")
mtcars$am <- as.factor(mtcars$am)
levels(mtcars$am) <- c("Automatic", "Manual")
mtcars$carName <- rownames(mtcars)

shinyServer(
     function(input, output) {
     dataTable    <- reactive({
         mtcars %>% filter(cyl>= input$Cyl[1], cyl<= input$Cyl[2], 
                           hp>=input$horsepower[1], hp<=input$horsepower[2])
     })
         
     output$dTable <-  renderDataTable({
         dataTable()
     })
     
     defaultColors <- c("#3366cc", "#dc3912", "#ff9900", "#109618", "#990099", "#0099c6", "#dd4477")
     series <- structure(
         lapply(defaultColors, function(color) { list(color=color) }),
         names = levels(mtcars$Region)
     )
     
     
     defaultColors <- c("#3366cc", "#dc3912", "#ff9900", "#109618", "#990099", "#0099c6", "#dd4477")
     series <- structure(
         lapply(defaultColors, function(color) { list(color=color) }),
         names = levels(mtcars$am)
     )
     
          
     dat1 <- reactive({
         mtcars %>% filter(cyl>= input$Cyl[1], cyl<= input$Cyl[2], 
                           hp>=input$horsepower[1], hp<=input$horsepower[2]) %>% dplyr::select(hp,mpg)#, carName, am)
     })
     
     output$scatter <- reactive({
         list(data = googleDataTable(dat1()),
              options = list(
                  title = sprintf("MPG"),
                  series = series)
         )})
     
#           require(googleVis)
#      output$view <- renderGvis({
#          gvisScatterChart(dat1(), options=list(width=400, height=450))
#      })
#      

     
    }
)


