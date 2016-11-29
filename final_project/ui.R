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
                   dataTableOutput("datasetTable")),
          
          # About view
          tabPanel("About",
                   br(),
                   h4("Dataset"),
                   p("Data analisys for housing data for 506 census tracts of Boston from the 1970 census. The dataframe BostonHousing contains the original data by Harrison and Rubinfeld (1979).",
                   tags$ol(
                       tags$li(tags$b("crim"), " = per capita crime rate by town"),
                       tags$li(tags$b("zn"), " = proportion of residential land zoned for lots over 25,000 sq.ft"),
                       tags$li(tags$b("indus"), " = proportion of non-retail business acres per town"),
                       tags$li(tags$b("chas"), " = Charles River dummy variable (= 1 if tract bounds river; 0 otherwise)"),
                       tags$li(tags$b("nox"), " = nitric oxides concentration (parts per 10 million)"),
                       tags$li(tags$b("rm"), " = average number of rooms per dwelling"),
                       tags$li(tags$b("age"), " = proportion of owner-occupied units built prior to 1940"),
                       tags$li(tags$b("dis"), " = weighted distances to five Boston employment centres"),
                       tags$li(tags$b("rad"), " = index of accessibility to radial highways"),
                       tags$li(tags$b("tax"), " = full-value property-tax rate per USD 10,000"),
                       tags$li(tags$b("ptratio"), " = pupil-teacher ratio by town"),
                       tags$li(tags$b("b"), " = 1000(B - 0.63)^2 where B is the proportion of blacks by town"),
                       tags$li(tags$b("lstat"), " = percentage of lower status of the population"),
                       tags$li(tags$b("medv"), " = median value of owner-occupied homes in USD 1000's")
                   ),
                   p("The objective of this app is compare the relation between the variables with the mean value and predict a median value by a set of inputs with the best fitted linear model."),
                   br(),
                   tags$nav("An apresentation is available at: "),
                   tags$a("https://schmittjoaopedro.github.io/data-products-peer4/#1", href="https://schmittjoaopedro.github.io/data-products-peer4/#1"),
                   br(),
                   br(),
                   tags$nav("The source code is available at: "),
                   tags$a("https://github.com/schmittjoaopedro/data-products-peer4", href="https://github.com/schmittjoaopedro/data-products-peer4"),
                   br(),
                   br(),
                   br(),
                   tags$nav("Developed by: João Pedro Schmitt"),
                   br()))
      )
  )
  
))
