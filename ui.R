shinyUI(dashboardPage(
    dashboardHeader(title = "Dashboard", titleWidth = '230'),
    dashboardSidebar(
        
        sidebarUserPanel("EcoFleet",
                         image = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRMPGOEnCMjziAdX3P4L0PF44w0_Mt2i7aS-BeTAXQ4qmLZ9TB"),
        sidebarMenu(
            menuItem("Incentives", tabName = "incentive", icon = icon("dollar-sign")),
            menuItem("EV Utility Analytics", tabName = "utilities", icon = icon("bolt")),
            menuItem("EV Infrastructure", tabName = "cstations", icon = icon("building")),
            menuItem("Find EV", tabName = "evbrand", icon = icon("car"))
            #helpText("About Author",  align = "center", icon = icon("pen-fancy")),
            #menuItemOutput("lk_in", icon = icon("linkedin")),
            #menuItemOutput("blg")
            )),
    
    
    dashboardBody(
        tags$head(
            tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")),
        
        tabItems(

            #######################################   EV INCENTIVES TAB   ###########################################  
           
            # MAP
            tabItem(tabName = "incentive",
                    h1("EV Tax Incentives by State"),
                    fluidRow(
                          box(title = "Electric Vehicle State & Federal Incentives",
                          status = "primary",  
                          solidHeader = TRUE,
                          leafletOutput("state_incentive"), width=10, height = 500))),
            
            

            #######################################   EV UTILITIES ANALAYTICS TAB   #################################    

            tabItem(tabName = "utilities",
                    h1("EV Utility Analytics"),
                    fluidRow(
                        #MAP 
                          box(title = "New York State Electric Vehicles Density",
                          status = "primary",  
                          solidHeader = TRUE,
                          leafletOutput("ev_density_nys"), height = 470),
                      

                          
            #BAR CHART  horizontal bar chart (Number of Vehicles by utility territories top 20)
                     
                    column(6,
                           
                          sliderInput("toputility", "Select Number of EVs:",
                                       min = 20, max = 15000, c(2500, 15000))),     
                          
                          box(title = "Number of Electric Vehicles in Utility Territories",
                          status = "primary",  
                          solidHeader = TRUE,
                          plotOutput(outputId = "evnum_territory", height = "300px"), height = 370)),
                    


                    fluidRow(
                        
            #LOAD CYCLE (LINE or scatter CHART)
                      
                          box(title = "24 Hours EV Load Cycle Trend in New York City",
                          status = "primary",  
                          solidHeader = TRUE,
                          plotOutput(outputId = "loadcycle", height = "310px"), height = 375),


            #VALLEY FILING IMAGE
                    
                          box(title = "Electric Grid Valley Filing", status = "primary", solidHeader = TRUE,
                              img(src="https://nycdatascience.com/blog/wp-content/uploads/2016/11/vf.png", width="100%", height = 310)))),
            
           

            #######################################   EV INFRASTRUCTURE TAB   ####################################  

            tabItem(tabName = "cstations",
                    h1("EV Infrastructure"),
                    
                    fluidRow(
                        
                        #MAP
                        
                        box(title = "Electric Vehicle Charging Stations", 
                        status = "primary", 
                        solidHeader = TRUE,
                        leafletOutput("ev_cstations"), height = 475),

                        
                        #BAR CHART (horizontal BCHART  y-axis top 20 brand only)
                        
                        column(6,
                        
                        sliderInput("topbrand", "Select Number of EVs:",
                                    min = 200, max = 12000, c(3000, 12000))),
                        
                        box(title = "Number of Electric Vehicles by Brand in NY",
                        status = "primary",  
                        solidHeader = TRUE,
                        plotOutput(outputId = "ev_brand", height = "300px"), height = 375))),
            
            
            
            #######################################   EV INFRASTRUCTURE TAB   ####################################  

            tabItem(tabName = "evbrand",
                    h1("Find Your EV"),
                    fluidRow(
                      
                      column(3,

                        sliderInput("ev_price", "Price ($):",
                        min = 13000, max = 200000, c(20000, 80000))),
                      
                      column(4,
                        
                        sliderInput("ev_range", "Range(in Miles):",
                        min = 9, max = 335, c(40, 200))),
                      
                      column(4,
                        
                        sliderInput("ev_battery", "Battery(in kWh:)",
                        min = 6.2, max = 100, c(10, 60))),

                        box(title = "Select EV", 
                        status = "primary", 
                        solidHeader = TRUE,
                        dataTableOutput("findev"), width=9, height = 375)))
            )
        )
))