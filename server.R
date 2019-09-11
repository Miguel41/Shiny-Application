library(shiny)
library(ggplot2)
library(dplyr)
library(rsconnect)

# Define server logic
shinyServer(function(input, output) {
    
    output$distPlot <- renderPlot({
        
        # Verify the quality of the keeper1
        switch(input$team1_keeper,
               
               Bad={keep1 <- 0},
               Fair={keep1 <- 0.2},
               Good={keep1 <- 0.4},
               Very_Good={keep1 <- 0.6},
               Premium={keep1 <- 0.8},
               Ideal={keep1 <- 1},
               stop(keep1 <- 0)
               )
        
        # Verify the quality of the keeper2
        switch(input$team2_keeper,
               
               Bad={keep2 <- 0},
               Fair={keep2 <- 0.2},
               Good={keep2 <- 0.4},
               Very_Good={keep2 <- 0.6},
               Premium={keep2 <- 0.8},
               Ideal={keep2 <- 1},
               stop(keep2 <- 0)
        )
        
        # Modify the equation to generate the simulation
        scale1 = input$team1_scores - keep2
        if(scale1<0){
            scale1<-0
        }
        offset1 = input$luck_team1
        
        scale2 = input$team2_scores - keep1
        if(scale2<0){
            scale2<-0
        }
        offset2 = 1-input$luck_team1
        
        # Generate the data
        data_team1 <- runif(50) * scale1 + offset1
        data_team2 <- runif(50) * scale2 + offset2
        df<-data.frame(team1 = data_team1, team2 = data_team2)
        
        # Draw the plot using ggplot2
        plot <- ggplot(df, aes(x=team1, y=team2)) + geom_point()
        plot
        
    })
    
    # Render the test with the most suitable result
    output$result <- renderText({
        
        # Verify the quality of the keeper1
        switch(input$team1_keeper,
               
               Bad={keep1 <- 0},
               Fair={keep1 <- 0.2},
               Good={keep1 <- 0.4},
               Very_Good={keep1 <- 0.6},
               Premium={keep1 <- 0.8},
               Ideal={keep1 <- 1},
               stop(keep1 <- 0)
        )
        
        # Verify the quality of the keeper2
        switch(input$team2_keeper,
               
               Bad={keep2 <- 0},
               Fair={keep2 <- 0.2},
               Good={keep2 <- 0.4},
               Very_Good={keep2 <- 0.6},
               Premium={keep2 <- 0.8},
               Ideal={keep2 <- 1},
               stop(keep2 <- 0)
        )
        
        # Modify the equation to generate the simulation
        scale1 = input$team1_scores - keep2
        if(scale1<0){
            scale1<-0
        }
        offset1 = input$luck_team1
        
        scale2 = input$team2_scores - keep1
        if(scale2<0){
            scale2<-0
        }
        offset2 = 1-input$luck_team1
        
        # Generate the data
        data_team1 <- runif(50) * scale1 + offset1
        data_team2 <- runif(50) * scale2 + offset2
        
        res <- sprintf("%d - %d", round(max(data_team1)), round(max(data_team2)))
        res
    })
    
})