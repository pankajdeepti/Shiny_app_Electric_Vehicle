shinyServer(function(input, output, session){
   
    

    #######################################   EV INCENTIVES    ##########################################   


    # EV Incentive in different states  (Map using long/lat)(Map)
    output$state_incentive <- renderLeaflet({
        m = leaflet(incen) %>% addTiles() %>%

        addMarkers(lng = ~incen$Longitude,lat = ~incen$Latitude, popup = paste("EV Technology: ", incen$Technology, "<br>",
                                 "State: ", incen$State, "<br>", 
                                 "Incentive Amount: ", incen$Amount, "<br>", "Status: ", incen$Status)
    )})


    #######################################   EV UTILITIES ANALAYTICS    ################################    
    

    # Vehicles in NYS (Map using long/lat)
    output$ev_density_nys <- renderLeaflet({
        n = leaflet(util) %>% addTiles() %>%
          setView(lng = -73.989915, lat = 40.748789, zoom = 11)%>%
          addMarkers(lng = ~util$Longitude,lat = ~util$Latitude, popup = paste("EV Brand: ", util$Vehicle_Name, "<br>",
                                                                                "ZIP: ", util$ZIP_Code, "<br>", "Utility Territory: ", util$EIA_Utility_Name)

    )})
    
    # BAR CHART  horizontal bar chart (Number of Vehicles by utility territories)

      output$evnum_territory <- renderPlot({
      evutil%>%
        filter(Number_EV >=  input$toputility[1]) %>%
        ggplot(mapping = aes(x = Utility_Territory, y = Number_EV))  + geom_bar(stat ="identity", fill="#880011") + ggtitle("Top Utility Territories") + coord_flip() +
        labs(y="Number of Electric Vehicles", x="Utility Companies") + theme(axis.title.x=element_text(size=15),axis.title.y=element_text(size=15), 
        axis.text.x=element_text(size=10), axis.text.y=element_text(size=10)) 
        
    })
    
    #LOAD CYCLE (LINE or scatter CHART)
      output$loadcycle <- renderPlot({
        load%>%
          ggplot(mapping = aes(x = Time, y = Energy_kWh))  + geom_line(colour = "red", size = 1) + xlim(c(2, 24)) + ylim(c(500, 6000)) + labs(y="Energy kWh", x="Hours") + 
          ggtitle("Dataset: 2 Months charging of 50 EVs") + theme(axis.title.x=element_text(size=15),axis.title.y=element_text(size=15), axis.text.x=element_text(size=10), axis.text.y=element_text(size=10))

    })


    ###########################################  EV Charging INFRASTRUCTURE    ############################### 


    # EV Charging Infrastrucure  (MAP)
    
      output$ev_cstations <- renderLeaflet({
      p = leaflet(infra) %>% addTiles() %>%
      setView(lng = -73.989915, lat = 40.748789, zoom = 11)%>%
      addMarkers(lng = ~infra$Longitude,lat = ~infra$Latitude, popup = paste("Connector Type: ", infra$EV_Connector_Types, "<br>",
                                  "Street: ", infra$Street_Address, "<br>", "City: ", infra$City,
                                  "<br>", "State: ", infra$State, "<br>", "ZIP: ", infra$ZIP, "<br>", "Phone: ", infra$Station_Phone)
    )}) 
    
       
    # Horizontal BAR CHART (y-axis top 20 brand only) (If possible Number of EVs by Brand or zip, county, classification)
    
      output$ev_brand <- renderPlot({
      evnum%>%
      filter(number_of_evs >=  input$topbrand[1]) %>%
      ggplot(mapping = aes(x = Make, y = number_of_evs))  + geom_bar(stat ="identity", fill="#880011") + ggtitle("Top EV Brand in NYS") + coord_flip() +
      labs(y="Number of Electric Vehicles", x="Make") + theme(axis.title.x=element_text(size=15),axis.title.y=element_text(size=15), 
        axis.text.x=element_text(size=10), axis.text.y=element_text(size=10))     
   

    })  
  

     #######################################   EV SELECTION   #######################################

    output$findev <- DT::renderDataTable({
      evbrand%>%
        filter(Price >=  input$ev_price[1],
               Price <=  input$ev_price[2],
               Range_miles >=  input$ev_range[1],
               Range_miles <=  input$ev_range[2],
               Battery_kWh >=  input$ev_battery[1],
               Battery_kWh <=  input$ev_battery[2]) %>%
        
        DT::datatable(options = list(lengthMenu = c(5, 10, 15, 20)), width = NULL, height = NULL)
          
      
    })   
})