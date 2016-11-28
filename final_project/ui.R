library(shiny)
library(mlbench)
library(plotly)
library(MASS)

shinyUI(fluidPage(
  
  titlePanel("Value of home by characteristics"),
  
  fluidPage(
      tabsetPanel(
          # Comparable plot view
          tabPanel("Comparable", 
                   br(),
                   h4("Variables comparable plot"),
                   br(),
                   sidebarLayout(
                       sidebarPanel(
                           br(),
                           radioButtons("comparableX", "Variable to compare",
                                        c("Crime" = "crim",
                                          "Landed Zones" = "zn",
                                          "Non-retail business" = "indus",
                                          "Charles River" = "chas",
                                          "Nitric Oxides" = "nox",
                                          "Number rooms" = "rm",
                                          "Owner-occupied units" = "age",
                                          "Distance of boston center" = "dis",
                                          "Radial highways" = "rad",
                                          "Property-tax" = "tax",
                                          "Pupil-teacher ratio" = "ptratio",
                                          "Black proportion" = "b",
                                          "Lower status" = "lstat"))
                       ),
                       mainPanel(
                           br(),
                           plotlyOutput("comparablePlot"),
                           br(),
                           h4("Regression coefficients"),
                           br(),
                           tableOutput("comparableCoefficients")
                       )
                   )),
          
          # Fit the best model
          tabPanel("Prediction", 
                   br(),
                   h4("Predict a value"),
                   br(),
                   sidebarLayout(
                       sidebarPanel(
                           textInput("preCrim", "Crime", value = "0"),
                           textInput("preZn", "Landed Zones"),
                           textInput("preChas", "Charles River", value = "0"),
                           textInput("preNox", "Nitric Oxides"),
                           textInput("preRm", "Number rooms"),
                           textInput("preDis", "Distance of boston center"),
                           textInput("preRad", "Radial highways"),
                           textInput("preTax", "Property-tax"),
                           textInput("prePtratio", "Pupil-teacher ratio"),
                           textInput("preB", "Black proportion"),
                           textInput("preLstat", "Lower status")
                       ),
                       mainPanel(
                           h4("Predicted value of median value of owner-occupied home in 1000 USD: "),
                           textOutput("predictedValue"),
                           br(),
                           h4("Coefficients table: "),
                           tableOutput("predictCoefficients"),
                           br(),
                           h4("R squared: "),
                           textOutput("rsquared"),
                           br(),
                           plotlyOutput("predictPlot")
                       )
                   )),
          
          # Dataset view
          tabPanel("Dataset", 
                   br(), 
                   h4("Dataset table"), 
                   br(), 
                   dataTableOutput("datasetTable"))
      )
  )
  
))
