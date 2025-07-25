# Load required libraries----
library(shiny)
library(shinydashboard)
library(shinyjs)
library(bslib)
library(flextable)
library(plotly)
library(dplyr)

# Define UI----
ui <- dashboardPage(
  dashboardHeader(title = "Pump ROI Analysis Tool - Sales Version"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Configuration", tabName = "config", icon = icon("cog")),
      menuItem("Current Operations", tabName = "current", icon = icon("industry")),
      menuItem("Proposed Solution", tabName = "new", icon = icon("star")),
      menuItem("Value Analysis", tabName = "analysis", icon = icon("chart-line"))
    ),
    br(),
    #Add download button for pdf generation.
    div(style = "padding: 10px;",
        downloadButton("export_pdf", "Export Proposal", icon = icon("file-pdf"), class = "btn-primary w-100 mb-3", )
    ),
    hr(),
    div(style = "padding: 10px;",
        h5("Data Management", style = "margin-bottom: 10px;"),
        downloadButton("save_data", "Save Data", icon = icon("save"), 
                       class = "btn-success w-100 mb-2"),
        fileInput("load_data", "Load Data", accept = ".csv",
                  buttonLabel = "Browse...", placeholder = "Choose CSV file",
                  width = "100%")
    )
    
  ),
  
  dashboardBody(
    tabItems(
      # Configuration Tab
      tabItem(tabName = "config",
              fluidRow(
                box(title = "Project Information", status = "primary", solidHeader = TRUE, width = 12,
                    fluidRow(
                      column(6,
                             textInput("project", "Customer/Project Name:", value = "Customer XYZ"),
                             textInput("country", "Country/Region:", value = "Germany")
                      ),
                      column(width = 6,
                             textInput("product", "Proposed Product:", value = "SuperPump-X"),
                             numericInput("analysis_years", "Analysis Period (Years):", value = 10, min = 1, max = 20)
                      )
                    )
                ),
                
                box(title = "Regional Factors", status = "primary", solidHeader = TRUE, width = 12,
                    fluidRow(
                      column(6,
                             numericInput("labor_cost", "Average Hourly Labor Cost (€):", value = 35, min = 0, step = 0.5),
                             numericInput("electricity_cost", "Electricity Cost (€/kWh):", value = 0.25, min = 0, step = 0.01)
                      ),
                      column(6,
                             numericInput("production_loss_multiplier", "Production Loss Multiplier:", value = 50, min = 1, step = 1,
                                             ) # "Cost multiplier for production downtime per hour"
                      )
                    )
                )
              )
      ),
      
      # Current Operations Tab
      tabItem(tabName = "current",
              fluidRow(
                box(title = "Current Pump - Operational Costs", status = "warning", solidHeader = TRUE, width = 6,
                    h5("Annual Operating Costs", style = "color: #856404; margin-bottom: 15px;"),
                    numericInput("curr_annual_maint", "Annual Maintenance Cost (€):", value = 2000, min = 0),
                    numericInput("curr_power_kw", "Power Consumption (kW):", value = 15, min = 0, step = 0.1),
                    numericInput("curr_operating_hours", "Annual Operating Hours:", value = 4000, min = 0),
                    numericInput("curr_efficiency", "Motor Efficiency (%):", value = 85, min = 0, max = 100),
                    numericInput("curr_downtime_hours", "Annual Downtime (Hours):", value = 48, min = 0),
                    hr(),
                    h5("Maintenance Cycles", style = "color: #856404; margin-bottom: 15px;"),
                    numericInput("curr_major_overhaul", "Major Overhaul Cost (€):", value = 8000, min = 0),
                    numericInput("curr_overhaul_interval", "Overhaul Interval (Years):", value = 4, min = 1, max = 10)
                ),
                
                box(title = "Current Pump - Performance Data", status = "warning", solidHeader = TRUE, width = 6,
                    h5("Reliability Metrics", style = "color: #856404; margin-bottom: 15px;"),
                    numericInput("curr_mtbf", "Mean Time Between Failures (Hours):", value = 8760, min = 0),
                    numericInput("curr_flow_rate", "Flow Rate (m³/h):", value = 100, min = 0),
                    numericInput("curr_pressure", "Pressure (bar):", value = 6, min = 0),
                    hr(),
                    h5("Environmental & Features", style = "color: #856404; margin-bottom: 15px;"),
                    numericInput("curr_noise_level", "Noise Level (dB):", value = 75, min = 0),
                    numericInput("curr_vibration", "Vibration Level (mm/s):", value = 4.5, min = 0),
                    selectInput("curr_vfd_compat", "VFD Compatible:", choices = c("No" = 0, "Yes" = 1), selected = 0),
                    selectInput("curr_smart_controls", "Smart Controls:", choices = c("No" = 0, "Yes" = 1), selected = 0),
                    selectInput("curr_remote_monitor", "Remote Monitoring:", choices = c("No" = 0, "Yes" = 1), selected = 0),
                    numericInput("curr_warranty_years", "Current Warranty (Years):", value = 2, min = 0, max = 10)
                )
              )
      ),
      
      # Proposed Solution Tab
      tabItem(tabName = "new",
              fluidRow(
                box(title = "Proposed Solution - Investment", status = "success", solidHeader = TRUE, width = 6,
                    h5("Initial Investment", style = "color: #155724; margin-bottom: 15px;"),
                    numericInput("new_unit_cost", "Unit Cost (€):", value = 22000, min = 0),
                    numericInput("new_install_cost", "Installation Cost (€):", value = 3500, min = 0),
                    numericInput("new_training_cost", "Training Cost (€):", value = 1500, min = 0),
                    hr(),
                    h5("Operating Costs", style = "color: #155724; margin-bottom: 15px;"),
                    numericInput("new_annual_maint", "Annual Maintenance Cost (€):", value = 1200, min = 0),
                    numericInput("new_power_kw", "Power Consumption (kW):", value = 12, min = 0, step = 0.1),
                    numericInput("new_operating_hours", "Annual Operating Hours:", value = 4000, min = 0),
                    numericInput("new_efficiency", "Motor Efficiency (%):", value = 94, min = 0, max = 100),
                    numericInput("new_downtime_hours", "Expected Annual Downtime (Hours):", value = 42, min = 0),
                    hr(),
                    h5("Maintenance Cycles", style = "color: #155724; margin-bottom: 15px;"),
                    numericInput("new_major_overhaul", "Major Overhaul Cost (€):", value = 6000, min = 0),
                    numericInput("new_overhaul_interval", "Overhaul Interval (Years):", value = 6, min = 1, max = 10)
                ),
                
                box(title = "Proposed Solution - Performance", status = "success", solidHeader = TRUE, width = 6,
                    h5("Enhanced Performance", style = "color: #155724; margin-bottom: 15px;"),
                    numericInput("new_mtbf", "Mean Time Between Failures (Hours):", value = 9500, min = 0),
                    numericInput("new_flow_rate", "Flow Rate (m³/h):", value = 105, min = 0),
                    numericInput("new_pressure", "Pressure (bar):", value = 6.2, min = 0),
                    hr(),
                    h5("Advanced Features", style = "color: #155724; margin-bottom: 15px;"),
                    numericInput("new_noise_level", "Noise Level (dB):", value = 68, min = 0),
                    numericInput("new_vibration", "Vibration Level (mm/s):", value = 2.8, min = 0),
                    selectInput("new_vfd_compat", "VFD Compatible:", choices = c("No" = 0, "Yes" = 1), selected = 1),
                    selectInput("new_smart_controls", "Smart Controls:", choices = c("No" = 0, "Yes" = 1), selected = 1),
                    selectInput("new_remote_monitor", "Remote Monitoring:", choices = c("No" = 0, "Yes" = 1), selected = 1),
                    selectInput("new_predictive_maint", "Predictive Maintenance:", choices = c("No" = 0, "Yes" = 1), selected = 1),
                    numericInput("new_warranty_years", "Warranty Period (Years):", value = 5, min = 0, max = 10)
                )
              )
      ),
      
      # Value Analysis Tab
      tabItem(tabName = "analysis",
              fluidRow(
                box(title = "Investment vs. Savings Summary", status = "info", solidHeader = TRUE, width = 12,
                    div(style = "font-size: 18px; text-align: center;",
                        uiOutput("roi_summary")
                    )
                )
              ),
              
              fluidRow(
                box(title = "Investment Recovery Analysis", status = "primary", solidHeader = TRUE, width = 6,
                    plotlyOutput("investment_recovery_plot", height = "400px")
                ),
                
                box(title = "Value Proposition Metrics", status = "primary", solidHeader = TRUE, width = 6,
                    DT::dataTableOutput("metrics_table")
                )
              ),
              
              fluidRow(
                box(title = "Annual Savings Breakdown", status = "info", solidHeader = TRUE, width = 6,
                    plotlyOutput("savings_breakdown_plot", height = "350px")
                ),
                
                box(title = "Efficiency & Reliability Gains", status = "info", solidHeader = TRUE, width = 6,
                    plotlyOutput("performance_comparison_plot", height = "350px")
                )
              ),
              
              fluidRow(
                box(title = "Detailed Financial Analysis", status = "warning", solidHeader = TRUE, width = 12,
                    DT::dataTableOutput("detailed_analysis")
                )
              )
      )
    )
  )
)

# Define Server----
server <- function(input, output, session) {
  
  # Reactive calculations
  calculations <- reactive({
    years <- input$analysis_years
    
    # New pump investment
    new_total_investment <- input$new_unit_cost + input$new_install_cost + input$new_training_cost
    
    # Annual operational costs and savings
    curr_annual_energy <- input$curr_power_kw * input$curr_operating_hours * input$electricity_cost
    new_annual_energy <- input$new_power_kw * input$new_operating_hours * input$electricity_cost
    annual_energy_savings <- curr_annual_energy - new_annual_energy
    
    # Downtime cost savings
    curr_downtime_cost <- input$curr_downtime_hours * input$labor_cost * input$production_loss_multiplier
    new_downtime_cost <- input$new_downtime_hours * input$labor_cost * input$production_loss_multiplier
    annual_downtime_savings <- curr_downtime_cost - new_downtime_cost
    
    # Maintenance savings
    annual_maintenance_savings <- input$curr_annual_maint - input$new_annual_maint
    
    # Calculate overhaul savings over the period
    curr_overhaul_years <- seq(input$curr_overhaul_interval, years, by = input$curr_overhaul_interval)
    new_overhaul_years <- seq(input$new_overhaul_interval, years, by = input$new_overhaul_interval)
    
    # Calculate savings for each year
    annual_savings <- numeric(years)
    cumulative_savings <- numeric(years)
    net_benefit <- numeric(years)
    
    for(i in 1:years) {
      # Base annual savings
      year_savings <- annual_energy_savings + annual_downtime_savings + annual_maintenance_savings
      
      # Add overhaul savings/costs
      curr_overhaul <- if(i %in% curr_overhaul_years) input$curr_major_overhaul else 0
      new_overhaul <- if(i %in% new_overhaul_years) input$new_major_overhaul else 0
      overhaul_savings <- curr_overhaul - new_overhaul
      
      annual_savings[i] <- year_savings + overhaul_savings
      cumulative_savings[i] <- sum(annual_savings[1:i])
      
      # Net benefit (cumulative savings minus initial investment)
      net_benefit[i] <- cumulative_savings[i] - new_total_investment
    }
    
    # Calculate payback period
    payback_years <- which(net_benefit > 0)[1]
    if(is.na(payback_years)) payback_years <- "Not within analysis period"
    
    # Total savings and ROI
    total_savings <- sum(annual_savings)
    roi_percent <- (total_savings / new_total_investment) * 100
    
    # Environmental impact
    annual_co2_savings <- (annual_energy_savings / input$electricity_cost) * 0.3
    # kg CO2 per kWh (Nordic Europe ave.2024)
    # Carbon intensity of electricity generation
    # datasource: https://ourworldindata.org/grapher/carbon-intensity-electricity?tab=table
    
    list(
      years = 1:years,
      annual_savings = annual_savings,
      cumulative_savings = cumulative_savings,
      net_benefit = net_benefit,
      total_savings = total_savings,
      investment = new_total_investment,
      roi_percent = roi_percent,
      payback_years = payback_years,
      annual_energy_savings = annual_energy_savings,
      annual_downtime_savings = annual_downtime_savings,
      annual_maintenance_savings = annual_maintenance_savings,
      curr_annual_energy = curr_annual_energy,
      new_annual_energy = new_annual_energy,
      annual_co2_savings = annual_co2_savings
      
    )
  })
  

  
  # preparing dataframe for saving
  collect_input_data <- reactive({
    data.frame(
      Parameter = c(
        # Current pump parameters (operational only)
        "curr_annual_maint", "curr_major_overhaul", "curr_overhaul_interval", 
        "curr_power_kw", "curr_operating_hours", "curr_efficiency", "curr_downtime_hours", 
        "curr_mtbf", "curr_flow_rate", "curr_pressure", "curr_noise_level", "curr_vibration",
        "curr_vfd_compat", "curr_smart_controls", "curr_remote_monitor", "curr_warranty_years",
        
        # New pump parameters
        "new_unit_cost", "new_install_cost", "new_training_cost", "new_annual_maint", 
        "new_major_overhaul", "new_overhaul_interval", "new_power_kw", "new_operating_hours",
        "new_efficiency", "new_downtime_hours", "new_mtbf", "new_flow_rate", "new_pressure", 
        "new_noise_level", "new_vibration", "new_vfd_compat", "new_smart_controls", 
        "new_remote_monitor", "new_predictive_maint", "new_warranty_years",
        
        # Configuration parameters
        "project", "product", "country", "labor_cost", "electricity_cost", 
        "production_loss_multiplier", "analysis_years"
      ),
      Value = c(
        # Current pump values (operational only)
        input$curr_annual_maint, input$curr_major_overhaul, input$curr_overhaul_interval,
        input$curr_power_kw, input$curr_operating_hours, input$curr_efficiency, input$curr_downtime_hours,
        input$curr_mtbf, input$curr_flow_rate, input$curr_pressure, input$curr_noise_level, input$curr_vibration,
        as.numeric(input$curr_vfd_compat), as.numeric(input$curr_smart_controls), 
        as.numeric(input$curr_remote_monitor), input$curr_warranty_years,
        
        # New pump values
        input$new_unit_cost, input$new_install_cost, input$new_training_cost, input$new_annual_maint,
        input$new_major_overhaul, input$new_overhaul_interval, input$new_power_kw, input$new_operating_hours,
        input$new_efficiency, input$new_downtime_hours, input$new_mtbf, input$new_flow_rate, input$new_pressure,
        input$new_noise_level, input$new_vibration, as.numeric(input$new_vfd_compat), 
        as.numeric(input$new_smart_controls), as.numeric(input$new_remote_monitor), 
        as.numeric(input$new_predictive_maint), input$new_warranty_years,
        
        # Configuration values
        input$project, input$product, input$country, input$labor_cost, 
        input$electricity_cost, input$production_loss_multiplier, input$analysis_years
      )
    )
  })
  
  # saving data
  output$save_data <- downloadHandler(
    filename = function() {
      paste("pump_proposal_", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      write.csv(collect_input_data(), file, row.names = FALSE)
    }
  )
  
  # Load data
  observeEvent(input$load_data, {
    req(input$load_data)
    
    tryCatch({
      data <- read.csv(input$load_data$datapath, stringsAsFactors = FALSE)
      
      # Function to update input values
      update_input <- function(param_name, value) {
        if (param_name %in% data$Parameter) {
          param_value <- data$Value[data$Parameter == param_name]
          
          # Handle different input types
          if (param_name %in% c("curr_vfd_compat", "curr_smart_controls", "curr_remote_monitor", 
                                "new_vfd_compat", "new_smart_controls", "new_remote_monitor", 
                                "new_predictive_maint")) {
            updateSelectInput(session, param_name, selected = as.character(param_value))
          } else if (param_name %in% c("project", "product", "country")) {
            updateTextInput(session, param_name, value = as.character(param_value))
          } else {
            updateNumericInput(session, param_name, value = as.numeric(param_value))
          }
        }
      }
      
      # Update all parameters
      for (param in data$Parameter) {
        update_input(param, data$Value[data$Parameter == param])
      }
      
      showModal(modalDialog(title = "Success", "Data loaded successfully!", easyClose = TRUE, footer = modalButton("OK")))
      
    }, error = function(e) {
      showModal(modalDialog(
        title = "Error",
        paste("Error loading data:", e$message),
        easyClose = TRUE,
        footer = modalButton("OK")
      ))
    })
  })
  
  # ROI Summary Output
  output$roi_summary <- renderUI({
    calc <- calculations()
    
    div(
      h3(paste("Initial Investment:", format(calc$investment, big.mark = ","), "€")),
      h3(paste("Total Savings over", input$analysis_years, "years:", format(calc$total_savings, big.mark = ","), "€")),
      h4(paste("Return on Investment:", round(calc$roi_percent, 1), "%")),
      h4(paste("Payback Period:", calc$payback_years, "years")),
      h4(paste("Annual CO₂ Reduction:", round(calc$annual_co2_savings), "kg"))
      
    )
  })
  
  #### Investment Recovery Plot ----
  output$investment_recovery_plot <- renderPlotly({
    calc <- calculations()
    
    df <- data.frame(
      Year = calc$years,
      Investment = rep(calc$investment, length(calc$years)),
      Cumulative_Savings = calc$cumulative_savings,
      Net_Benefit = calc$net_benefit
    )
    
    p <- plot_ly(df, x = ~Year) %>%
      add_lines(y = ~Investment, name = "Initial Investment", line = list(color = "red", dash = "dash")) %>%
      add_lines(y = ~Cumulative_Savings, name = "Cumulative Savings", line = list(color = "green")) %>%
      add_lines(y = ~Net_Benefit, name = "Net Benefit", line = list(color = "blue", width = 3)) %>%
      add_lines(x = range(df$Year), y = c(0, 0), name = "Break-even", 
                line = list(color = "black", dash = "dot"), showlegend = FALSE) %>%
      layout(
        xaxis = list(title = "Year"),
        yaxis = list(title = "Amount (€)"),
        hovermode = "x unified",
        legend = list(
          x = 0.5, y = 1, xanchor = "center", yanchor = "bottom", orientation = "h"
        )
      )
    
    p
  })
  
  #### Metrics Comparison Table----
  output$metrics_table <- DT::renderDataTable({
    calc <- calculations()
    
    efficiency_diff <- input$new_efficiency - input$curr_efficiency
    mtbf_improvement <- ((input$new_mtbf - input$curr_mtbf) / input$curr_mtbf) * 100
    downtime_reduction <- ((input$curr_downtime_hours - input$new_downtime_hours) / input$curr_downtime_hours) * 100
    
    metrics <- data.frame(
      Metric = c("Energy Efficiency Gain", "Annual Energy Savings", "MTBF Improvement", 
                 "Downtime Reduction", "Annual Maintenance Savings", "Extended Warranty"),
      Current = c("Base", paste("€", round(calc$curr_annual_energy)), 
                  paste(input$curr_mtbf, "hrs"), paste(input$curr_downtime_hours, "hrs/year"),
                  paste("€", input$curr_annual_maint), paste(input$curr_warranty_years, "years")),
      Proposed = c(paste(input$new_efficiency, "%"), paste("€", round(calc$new_annual_energy)),
                   paste(input$new_mtbf, "hrs"), paste(input$new_downtime_hours, "hrs/year"),
                   paste("€", input$new_annual_maint), paste(input$new_warranty_years, "years")),
      "Annual Savings" = c(paste("+", round(efficiency_diff, 1), "%"),
                          paste("€", round(calc$annual_energy_savings)),
                          paste("+", round(mtbf_improvement, 1), "%"),
                          paste("€", round(calc$annual_downtime_savings)),
                          paste("€", round(calc$annual_maintenance_savings)),
                          paste("+", input$new_warranty_years - input$curr_warranty_years, "years"))
    )
    
    DT::datatable(metrics, 
                  options = list(dom = 't', pageLength = 8, scrollX = TRUE, autoWidth = TRUE), 
                  rownames = FALSE
    )
  })
  
  #### Savings Breakdown Plot----
  output$savings_breakdown_plot <- renderPlotly({
    calc <- calculations()
    
    breakdown <- data.frame(
      Category = c("Energy Savings", "Downtime Reduction", "Maintenance Savings"),
      Annual_Savings = c(calc$annual_energy_savings, calc$annual_downtime_savings, calc$annual_maintenance_savings)
    )
    
    p <- plot_ly(breakdown, x = ~Category, y = ~Annual_Savings, type = 'bar', 
                 marker = list(color = c('#1f77b4', '#ff7f0e', '#2ca02c'), opacity = 0.8)) %>%
                                layout(
                                  xaxis = list(title = "Savings Category"),
                                  yaxis = list(title = "Annual Savings (€)"),
                                  showlegend = FALSE
                                )
                                
                                p
        })
        
        #### Performance Comparison Plot----
        output$performance_comparison_plot <- renderPlotly({
          performance_data <- data.frame(
            Metric = c("Efficiency (%)", "MTBF (×1000 hrs)", "Uptime (%)"),
            Current = c(input$curr_efficiency, input$curr_mtbf/1000, 
                        ((input$curr_operating_hours - input$curr_downtime_hours)/input$curr_operating_hours)*100),
            Proposed = c(input$new_efficiency, input$new_mtbf/1000,
                         ((input$new_operating_hours - input$new_downtime_hours)/input$new_operating_hours)*100)
          )
          
          # Reshape data for grouped bar chart
          df_long <- data.frame(
            Metric = rep(performance_data$Metric, 2),
            Value = c(performance_data$Current, performance_data$Proposed),
            Type = rep(c("Current", "Proposed"), each = 3)
          )
          
          p <- plot_ly(df_long, x = ~Metric, y = ~Value, color = ~Type, type = 'bar',
                       colors = c("Current" = "#d62728", "Proposed" = "#2ca02c")) %>%
            layout(
              xaxis = list(title = "Performance Metrics"),
              yaxis = list(title = "Value"),
              barmode = 'group',
              legend = list(x = 0.5, y = 1, xanchor = "center", yanchor = "bottom", orientation = "h")
            )
          
          p
        })
        
        # Detailed Analysis Table
        output$detailed_analysis <- DT::renderDataTable({
          calc <- calculations()
          
          detailed <- data.frame(
            Year = calc$years,
            Annual_Savings = round(calc$annual_savings),
            Cumulative_Savings = round(calc$cumulative_savings),
            Net_Benefit = round(calc$net_benefit),
            ROI_Cumulative = round((calc$cumulative_savings / calc$investment) * 100, 1)
          )
          
          colnames(detailed) <- c("Year", "Annual Savings (€)", "Cumulative Savings (€)", 
                                  "Net Benefit (€)", "Cumulative ROI (%)")
          
          DT::datatable(detailed, options = list(pageLength = 15, scrollX = TRUE), rownames = FALSE) %>%
            DT::formatCurrency(columns = 2:4, currency = "€", digits = 0) %>%
            DT::formatString(columns = 5, suffix = "%")
        })
        
        ## Reactive dataframes----
        ### Investment Recovery
        investment_recovery <- reactive({
          req(calculations())
          calc <- calculations()
          
          data.frame(
            Year = calc$years,
            Investment = rep(-calc$investment, length(calc$years)),
            Cumulative_Savings = calc$cumulative_savings,
            Net_Benefit = calc$net_benefit
          )
        })
        
        ### Value Proposition Metrics
        metrics <- reactive({
          req(calculations())
          calc <- calculations()
          
          efficiency_diff <- input$new_efficiency - input$curr_efficiency
          mtbf_improvement <- ((input$new_mtbf - input$curr_mtbf) / input$curr_mtbf) * 100
          
          data.frame(
            Metric = c("Energy Efficiency Gain", "Annual Energy Savings", "MTBF Improvement", 
                       "Downtime Reduction", "Annual Maintenance Savings", "Extended Warranty"),
            Current = c("Base", paste("€", round(calc$curr_annual_energy)), 
                        paste(input$curr_mtbf, "hrs"), paste(input$curr_downtime_hours, "hrs/year"),
                        paste("€", input$curr_annual_maint), paste(input$curr_warranty_years, "years")),
            Proposed = c(paste(input$new_efficiency, "%"), paste("€", round(calc$new_annual_energy)),
                         paste(input$new_mtbf, "hrs"), paste(input$new_downtime_hours, "hrs/year"),
                         paste("€", input$new_annual_maint), paste(input$new_warranty_years, "years")),
            "Annual_Savings" = c(paste("+", round(efficiency_diff, 1), "%"),
                                 paste("€", round(calc$annual_energy_savings)),
                                 paste("+", round(mtbf_improvement, 1), "%"),
                                 paste("€", round(calc$annual_downtime_savings)),
                                 paste("€", round(calc$annual_maintenance_savings)),
                                 paste("+", input$new_warranty_years - input$curr_warranty_years, "years"))
          )
        })
        
        ### Savings Breakdown 
        breakdown <- reactive({
          req(calculations())
          calc <- calculations()
          
          data.frame(
            Category = c("Energy Savings", "Downtime Reduction", "Maintenance Savings"),
            Annual_Savings = c(calc$annual_energy_savings, calc$annual_downtime_savings, calc$annual_maintenance_savings)
          )
        })
        
        ### Performance Data
        performance_data <- reactive({
          data.frame(
            Metric = c("Efficiency (%)", "MTBF (×1000 hrs)", "Uptime (%)"),
            Current = c(input$curr_efficiency, input$curr_mtbf/1000, 
                        ((input$curr_operating_hours - input$curr_downtime_hours)/input$curr_operating_hours)*100),
            Proposed = c(input$new_efficiency, input$new_mtbf/1000,
                         ((input$new_operating_hours - input$new_downtime_hours)/input$new_operating_hours)*100)
          )
        })
        
        ## Export PDF handler----
        output$export_pdf <- downloadHandler(
          filename = function() {
            paste("Pump-Value-Proposal", Sys.Date(), ".pdf", sep = "_")
          },
          content = function(file) {
            # Use withProgress to show a progress bar
            withProgress(message = "Creating Proposal: ", value = 0, {
              # Stage 1: Increment progress
              incProgress(0.3, detail = "Collecting inputs...")
              
              # Save data to temporary files----
              temp_file <- tempfile(fileext = ".rds")
              temp_file1 <- tempfile(fileext = ".rds")
              temp_file2 <- tempfile(fileext = ".rds")
              temp_file3 <- tempfile(fileext = ".rds")
              temp_file4 <- tempfile(fileext = ".rds")
              saveRDS(calculations(), temp_file)
              saveRDS(investment_recovery(), temp_file1)
              saveRDS(metrics(), temp_file2)
              saveRDS(breakdown(), temp_file3)
              saveRDS(performance_data(), temp_file4)
              
              # Prepare parameters----
              params <- 
                list(
                  project = input$project,
                  product = input$product,
                  calc = temp_file,
                  investment_recovery = temp_file1,
                  metrics = temp_file2,
                  breakdown = temp_file3,
                  performance_data = temp_file4,
                  years = input$analysis_years,
                  investment = format(calculations()$investment, big.mark = ","),
                  total_savings = format(calculations()$total_savings, big.mark = ","),
                  roi_percent = round(calculations()$roi_percent, 1),
                  payback_years = calculations()$payback_years,
                  # Value proposition improvements
                  efficiency_diff = paste0("", round(input$new_efficiency - input$curr_efficiency, 1), "%"),
                  energy_savings = paste0("€", round(calculations()$annual_energy_savings)),
                  mtbf_improvement = paste0("", round(((input$new_mtbf - input$curr_mtbf) / input$curr_mtbf) * 100, 1), "%"),
                  downtime_savings = paste0("€", round(calculations()$annual_downtime_savings)),
                  maintenance_savings = paste0("€", round(calculations()$annual_maintenance_savings)),
                  warranty = paste0("+", input$new_warranty_years - input$curr_warranty_years, " years")
                )
              
              
              # Stage 2
              incProgress(0.3, detail = "Building...")
              
              # Create a temporary directory for rendering
              tempDir <- tempdir()
              tempReport <- file.path(tempDir, "report.qmd")
              
              # Copy required files
              file.copy("report.qmd", tempReport, overwrite = TRUE)
              dir.create(file.path(tempDir, "assets"), showWarnings = FALSE)
              file.copy("assets/sample_logo.png", file.path(tempDir, "assets/sample_logo.png"), overwrite = TRUE)
              file.copy("typst-show.typ", file.path(tempDir, "typst-show.typ"), overwrite = TRUE)
              file.copy("typst-template.typ", file.path(tempDir, "typst-template.typ"), overwrite = TRUE)
              
              # Render report
              withr::with_dir(tempDir, {
                quarto::quarto_render(
                  input = "report.qmd",
                  output_format = "typst",
                  execute_params = params
                )
                
                # Stage 3
                incProgress(0.95, detail = "Downloading report...")
                
                # Copy the generated PDF
                generatedPDF <- sub("\\.qmd$", ".pdf", tempReport)
                file.copy(generatedPDF, file, overwrite = TRUE)
              })
            })
          }
        )
      }  #server 
      
      # Run the application
 shinyApp(ui = ui, server = server)
      
      