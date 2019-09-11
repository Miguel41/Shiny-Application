library(shiny)

# Define a new App
shinyUI(fluidPage(
    
    # Title
    titlePanel("Football Result Prediction"),
    
    # Sidebar with options to generate the data
    sidebarLayout(
        sidebarPanel(
            # Help message
            helpText("This application is a predictor for the result of a football match based in the characteristics of the two teams"),
            h3(helpText("Select the parameters for TEAM 1:")),
            
            # Parameter for the team1
            # Scores
            numericInput("team1_scores", label = h4("Scores by match for Team 1"), step = 1, value = 4),
            
            # Keeper
            selectInput("team1_keeper", label = h4("Keeper performance for Team 1"),
                        choices = list("Bad" = "Bad", "Fair" = "Fair", "Good" = "Good",
                                       "Very_Good" = "Very_Good", "Premium" = "Premium",
                                       "Ideal" = "Ideal")),
            
            h3(helpText("Select the parameters for TEAM 2:")),
            
            # Parameter for the team2
            # Scores
            numericInput("team2_scores", label = h4("Scores by match for Team 2"), step = 1, value = 3),
            
            # Keeper
            selectInput("team2_keeper", label = h4("Keeper performance for Team 2"),
                        choices = list("Bad" = "Bad", "Fair" = "Fair", "Good" = "Good",
                                       "Very Good" = "Very Good", "Premium" = "Premium",
                                       "Ideal" = "Ideal")),
            
            h3(helpText("Select the Luck factor for TEAM 1:")),
            
            # Luck factor for team1
            numericInput("luck_team1", label = h4("Luck factor for Team 1"), step = 0.1, value = 0.5)
            
        ),
        
        # Show a plot with the most suitable results
        mainPanel(
            plotOutput("distPlot"),
            h4("The most suitable result is:"),
            h3(textOutput("result"))
        )
    )
))
