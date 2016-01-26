library(shiny)
# library(BH)
library(rCharts)
require(markdown)
require(data.table)
library(dplyr)
# library(DT)

library(googleCharts)
# library(googleVis)

xlim <- list(
    min = 0,
    max = max(mtcars$hp) + 5
)
ylim <- list(
    min = 0,
    max = max(mtcars$mpg) + 2
)


shinyUI(
    navbarPage("Motor Trend Car Road Tests", 
               # multi-page user-interface that includes a navigation bar.
               tabPanel("Explore the Data",
                        sidebarPanel(
                            sliderInput("Cyl", 
                                        "Number of cylinders:", 
                                        min = 4,
                                        max = 8,
                                        value = c(4, 8)),
                            sliderInput("horsepower", 
                                        "Gross horsepower:",
                                        min = 52,
                                        max = 335,
                                        value = c(100, 200) 
                            )

                        ),
                        mainPanel(
                            tabsetPanel(
                                tabPanel(p(icon("line-chart"), "Visualization"),
                                         h4('Miles per galon by transmission type', align = "center"),
                                         googleChartsInit(),
                                         googleScatterChart("scatter", width = "100%", height = "300px", 
                                                            options = list(vAxis=list(title="Miles per galon", 
                                                                                      viewWindow=ylim), 
                                                                           hAxis=list(title="Horsepower",
                                                                                      viewWindow=xlim)))
                                         # htmlOutput("view"),
                                         
                                ), # end of "Visualize the Data" tab panel                               
                                
                                # Data 
                                tabPanel(p(icon("table"), "Data"),
                                         dataTableOutput(outputId="dTable")
                                ) # end of "Dataset" tab panel
                                
                            )
                            
                        )     
               ), # end of "Explore Dataset" tab panel
               tabPanel("Documentation",
                        mainPanel(
                            h3("Motor Trend Car Road Test Explorer"),
                            
                            h5("On the main tab, called Explore the Data, application visualises the mtcars dataset. The graph on the Visualization page shows scatterplot for fuel consumption for different cars in the dataset. Data window shows the tabular data. You can filter the data by two parameters - number of cilinders and gross horsepower using slider inputs on the left side."),
                            
                            h5("Author - Sergey Chigrinov"),
                            h5("January 2016")
                        )
               ),              

               tabPanel("About",
                        mainPanel(
                            h3("The data is part of the R datasets"),
                            h3("Motor Trend Car Road Tests"),
                            h5("The data was extracted from the 1974 Motor Trend US magazine, and comprises"),
                            h5("fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973-74 models)."), 
                            h5(),
                            h5(),
                            h5("Author - Sergey Chigrinov"),
                            h5("January 2016")
                        )
               ) # end of "About" tab panel
               )  
    )