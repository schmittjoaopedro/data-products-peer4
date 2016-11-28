library(shiny)
library(mlbench)
library(plotly)
library(MASS)
data("BostonHousing")

variables <- c("crim" = "Crime",
               "zn" = "Landed Zones",
               "indus" = "Non-retail business",
               "chas" = "Charles River",
               "nox" = "Nitric Oxides",
               "rm" = "Number rooms",
               "age" = "Owner-occupied units",
               "dis" = "Distance of boston center",
               "rad" = "Radial highways",
               "tax" = "Property-tax",
               "ptratio" = "Pupil-teacher ratio",
               "b" = "Black proportion",
               "lstat" = "Lower status")

bestFit <- stepAIC(lm(medv ~ ., data = BostonHousing), direction="both")

shinyServer(function(input, output, session) {

    updateTextInput(session, "preCrim", value = mean(BostonHousing$crim))
    updateTextInput(session, "preZn", value = mean(BostonHousing$zn))
    updateTextInput(session, "preNox", value = mean(BostonHousing$nox))
    updateTextInput(session, "preRm", value = mean(BostonHousing$rm))
    updateTextInput(session, "preDis", value = mean(BostonHousing$dis))
    updateTextInput(session, "preRad", value = mean(BostonHousing$rad))
    updateTextInput(session, "preTax", value = mean(BostonHousing$tax))
    updateTextInput(session, "prePtratio", value = mean(BostonHousing$ptratio))
    updateTextInput(session, "preB", value = mean(BostonHousing$b))
    updateTextInput(session, "preLstat", value = mean(BostonHousing$lstat))
     
    output$datasetTable <- renderDataTable(BostonHousing, 
                                           options = list(
                                               pageLength = 25,
                                               scrollX = TRUE))
  
    output$comparablePlot <- renderPlotly({
    
        fit <- lm(BostonHousing$medv ~ BostonHousing[,input$comparableX])
        
        plot_ly(x = ~BostonHousing[,input$comparableX],
                y = ~BostonHousing$medv,
                type = "scatter",
                mode = "markers", 
                name = "Raw data") %>%
            add_trace(x = ~BostonHousing[,input$comparableX], 
                        y = ~fitted(fit),
                        type = "scatter",
                        mode = "line", name = "Regression line") %>%
            layout(title = paste("Media value vs", variables[input$comparableX]),
                   yaxis = list(title = "Median value"),
                   xaxis = list(title = variables[input$comparableX]))
    })
    
    output$comparableCoefficients <- renderTable({
        fit <- summary(lm(BostonHousing$medv ~ BostonHousing[,input$comparableX]))$coef
        data.frame(Coefficients = c("Intercept", variables[input$comparableX]), fit)
    })
    
    output$predictCoefficients <- renderTable({
        fit <- summary(bestFit)$coef
        data.frame(Coefficients = rownames(fit), fit)
    })
    
    output$predictPlot <- renderPlotly({
        plot_ly(x = 1:nrow(BostonHousing), 
                y = ~bestFit$residuals, 
                type = "scatter",
                mode = "markers", 
                name = "Difference") %>%
            layout(title = "Residuals")
    })
    
    output$rsquared <- renderText({
      summary(bestFit)$adj.r.squared
    })
    
    output$predictedValue <- renderText({
      predictHouse(bestFit, input)
    })
    
})

predictHouse <- function(bestModel, input) {
  predict(bestModel, data.frame(
    crim = as.numeric(input$preCrim),
    zn = as.numeric(input$preZn),
    chas = as.factor(input$preChas),
    nox = as.numeric(input$preNox),
    rm = as.numeric(input$preRm),
    tax = as.numeric(input$preTax),
    dis = as.numeric(input$preDis),
    rad = as.numeric(input$preRad),
    ptratio = as.numeric(input$prePtratio),
    b = as.numeric(input$preB),
    lstat = as.numeric(input$preLstat)
  ))
}
