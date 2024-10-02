library(shiny)

ui <- fluidPage(
  
  titlePanel("Integration of Single-Cell RNA-seq Prostate Data"),
  
  sidebarLayout(
        #Creating the dropdown menu
        sidebarPanel(selectInput("variable", "Variable:",
                             c("Ridge Plot" = "ridgeplot.png",
                               "Heatmap Plot" = "heatmap.png",
                               "Dot Plot" = "dotplot.png",
                               "Violin Plot" = "violinplot.png",
                               "Feature Plot" = "featureplot.png")),
                
                 downloadButton('downloadData', 'Download'),      
                 
                 h4("The following plots were created from integrating multiple single-cell RNA sequencing datasets of prostates (both small and large). The data was then analyzed for the most differentially expressed genes. The top seven differentially expressed genes from the integration were chosen to be displayed. The Ridge Plot and Violin Plot only show the first identities while the Heatmap and Dotplot show all 21 identities.")
                 ),
      
    mainPanel(
      imageOutput("plot")
    ),
   
  )
)


server <- function(input, output) {
  #Display the plot based on what is chosen through the dropdown menu
  output$plot <- renderImage({
    list(src = paste("images/",input$variable, sep=""),
         width = 500,
         height= 500,
         alt = paste("images/",input$variable, sep=""))
  }, deleteFile = FALSE)
  
  #Download the plot based on what is chosen through the dropdown menu
  output$downloadData <- downloadHandler(
     filename = "rplot.png",
     content = function(file) {
       file.copy(paste("images/", input$variable, sep=""), file)
     }
  )
}

shinyApp(ui = ui, server = server)
