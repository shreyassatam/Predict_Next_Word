library(shiny)
suppressPackageStartupMessages({
  library(tidyverse)
  library(stringr)
})

source("pred_model.R")

# Define UI for the prediction word
ui <- fluidPage(
  
  # Application title
  titlePanel("Next word prediction based on number of words input"),
  
  # Sidebar with a textbox to input words 
  sidebarLayout(
    sidebarPanel(
      textInput("input_words", "Start typing here:", value = ""),
      submitButton("Submit")
    ),
    
    # Show predicted word along with the ngram selected
    mainPanel(
      tabsetPanel(
      tabPanel("Prediction", br(),
        h3("Predicted word"),
        h4(em(span(textOutput("ngram_output"),style = "color:blue"))),
        br(),
        h4("Ngram used to select the most frequent predicted word"),
        plotOutput("ngram_plot")),
      tabPanel("Top bigrams", br(),
        img(src = "bigrams.png", height = 500, width = 500)
      ),
      tabPanel("Top trigrams", br(),
               img(src = "trigrams.png", height = 500, width = 500)
      ),
      tabPanel("Top quadgrams", br(),
               img(src = "quadgrams.png", height = 500, width = 500)
      ),
      tabPanel("Top quintgrams", br(),
               img(src = "quintgrams.png", height = 500, width = 500)
      ),
      tabPanel("Top sextgrams", br(),
               img(src = "sextgrams.png", height = 500, width = 500)
      )
      )
    )
  )
)

# Define server logic required to predict the word
server <- function(input, output) {
  
  output$ngram_output <- renderText({
    ngrams(input$input_words)
  })
  output$ngram_plot <- renderImage({
    filename <- normalizePath(file.path("./images", paste0(ngram_plot(input$input_words),".png")))
    list(src = filename,width = 600, height = 500)
  },deleteFile = FALSE)
}

# Run the application 
shinyApp(ui = ui, server = server)

