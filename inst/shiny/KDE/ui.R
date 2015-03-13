## UI.R

# load example data
data(ExampleData.DeValues)

# pageWithSidebar contains three panels:
# 1 - headerPanel: basically just for a header
# 2 - sidebarPanel: data input
# 3 - mainPanel: data output

pageWithSidebar(  
  # 1 - title = NULL -> Panel will not be shown
  headerPanel(title = NULL),
  
  # 2- width = 5 -> refers to twitters bootstrap grid system
  # where the the maximum width is 12 that is to be shared between all
  # elements
  sidebarPanel(width = 5,
               
               # include a tabs in the input panel for easier navigation
               tabsetPanel(id = "tabs", type = "pill", selected = "Data",
                           
                           # Tab 1: Data input
                           tabPanel("Data",
                                    
                                    # informational text
                                    div(align = "center", h5("Data upload")),
                                    
                                    # file upload button (data set 1)
                                    fileInput(inputId = "file1", 
                                              label = strong("Primary data set"), 
                                              accept="text/plain"),
                                    
                                    # file upload button (data set 2)
                                    fileInput(inputId = "file2", 
                                              label = strong("Secondary data set"), 
                                              accept="text/plain"),
                                    
                                    # logical: should NA values be excluded?
                                    checkboxInput(inputId = "na.exclude", 
                                                  label = "Exclude NA values",
                                                  value = TRUE),
                                    
                                    # logical: file contains headers?
                                    checkboxInput(inputId = "headers", 
                                                  label = "File contains headers", 
                                                  value = FALSE),
                                    
                                    # char: columns separated by tab, space, comma
                                    radioButtons("sep", "Separator", selected = "\t",
                                                 c("Tab" = "\t",
                                                   "Space" = " ",
                                                   "Comma" = ",",
                                                   "Semicolon" = ";")),
                                    
                                    hr(),
                                    
                                    fluidRow(
                                      column(width = 6,
                                             actionButton(inputId = "refresh", label = "Refresh", icon = icon("refresh"))
                                      ),
                                      column(width = 6,
                                             actionButton(inputId = "exit", label = "Exit", class = "btn btn-danger")
                                      )
                                    )
                                    
                           ),##EndOf::Tab_1
                           
                           # Tab 2: Statistical information
                           tabPanel("Statistics",                             
                                    
                                    div(align = "center", h5("Summary")),
                                    
                                    fluidRow(
                                      column(width = 6,
                                             checkboxInput(inputId = "summary",
                                                           label = "Show summary",
                                                           value = FALSE)
                                      ),
                                      column(width = 6,
                                             selectInput(inputId = "sumpos",
                                                         label = "Summary position",
                                                         selected = "topleft",
                                                         choices = list("Subtitle" = "sub",
                                                                        "Center" = "center",
                                                                        Top=c("Top" = "top",
                                                                              "Top left" = "topleft",
                                                                              "Top right"= "topright"),
                                                                        Bottom=c("Bottom" = "bottom",
                                                                                 "Bottom left" = "bottomleft",
                                                                                 "Bottom right" = "bottomright")
                                                         ))
                                      )
                                    ),
                                    

                                             checkboxGroupInput(inputId = "stats", 
                                                                label = "Parameters", 
                                                                selected = c("n","mean"),
                                                                choices = c("n" = "n",
                                                                            "Mean" = "mean",
                                                                            "Median" = "median",
                                                                            "rel. Standard deviation" = "sdrel",
                                                                            "abs. Standard deviation" = "sdabs",
                                                                            "Skewness" = "skewness",
                                                                            "kurtosis" = "kurtosis",
                                                                            "max. KDE" = "kdemax",
                                                                            #"rel. Standard error" = "serel",       currently not supported
                                                                            #"abs. Standard error" = "seabs",       currently not supported
                                                                            "weighted Mean" = "mean.weighted"
                                                                            #"weighted Median" = "weighted.median,  currently not supported
                                                                            )),
                                    
                                    div(align = "center", h5("Additional options")),
                                    
                                    fluidRow(
                                      column(width = 6,
                                             checkboxInput(inputId = "cumulative",
                                                           label = "Show individual data",
                                                           value = TRUE)
                                             ),
                                      column(width = 6,
                                             checkboxInput(inputId = "weights",
                                                           label = "Errors as weights",
                                                           value = FALSE)
                                             ))
                                 
                           ),##EndOf::Tab_2
                           
                           # Tab 3: input that refer to the plot rather than the data
                           tabPanel("Plot", 
                                    
                                    div(align = "center", h5("Title")),
                                    
                                    textInput(inputId = "main", 
                                              label = "Title", 
                                              value = "KDE Plot"),
                                    
                                    # inject sliderInput from Server.R
                                    uiOutput(outputId = "bw"),
                                    
                                    
                                    selectInput(inputId = "centrality", 
                                                label = "Centrality",
                                                list("Mean" = "mean",
                                                     "Median" = "median", 
                                                     "Weighted mean" = "mean.weighted", 
                                                     "Weighted median" = "median.weighted",
                                                     "max. KDE" = "kdemax")),
                                    
                                    
                                    div(align = "center", h5("Dispersion")),
                                    
                                    selectInput(inputId = "dispersion", 
                                                label = "Measure of dispersion",
                                                list("1 sigma" = "sd",
                                                     "2 sigma" = "2sd", 
                                                     "Quartile range" = "qr")),
                                    
                                    fluidRow(
                                      column(width = 6,
                                             selectInput(inputId = "polygon", 
                                                         label = "Polygon color #1",
                                                         choices = list("Grey" = "grey80",
                                                                        "Red" = "#b22222", 
                                                                        "Green" = "#6E8B3D", 
                                                                        "Blue" = "#428bca",
                                                                        "Custom" = "custom",
                                                                        "None" = "none"))
                                      ),
                                      column(width = 6,
                                             # show only if custom color is desired
                                             conditionalPanel(condition = "input.polygon == 'custom'",
                                                              textInput(inputId = "rgb.polygon",
                                                                        label = "Color name or RGB Code",
                                                                        value = "#000000"))
                                      )
                                    ),
                                    
                                    fluidRow(
                                      column(width = 6,
                                             selectInput(inputId = "polygon2", 
                                                         label = "Polygon color #2",
                                                         choices = list("Grey" = "grey80",
                                                                        "Red" = "#b22222", 
                                                                        "Green" = "#6E8B3D", 
                                                                        "Blue" = "#428bca",
                                                                        "Custom" = "custom",
                                                                        "None" = "none"))
                                      ),
                                      column(width = 6,
                                             # show only if custom color is desired
                                             conditionalPanel(condition = "input.polygon2 == 'custom'",
                                                              textInput(inputId = "rgb.polygon2",
                                                                        label = "Color name or RGB Code",
                                                                        value = "#000000"))
                                      )
                                    ),
                 
                                    sliderInput(inputId = "alpha.polygon", 
                                                label = "Polygon transparency", 
                                                min = 0, max = 100, 
                                                step = 1, value = 66),
                                    
                                    br(),
                                    
                                    div(align = "center", h5("Scaling")),
                                    
                                    sliderInput(inputId = "cex", 
                                                label = "Scaling factor",
                                                min = 0.5, max = 2, 
                                                value = 1.0, step = 0.1)
                           ),##EndOf::Tab_3
                           
                           # Tab 4: modify axis parameters
                           tabPanel("Axis",
                                    
                                    div(align = "center", h5("X-axis")),
                                    
                                    checkboxInput(inputId = "logx",
                                                  label = "Logarithmic x-axis",
                                                  value = FALSE),
                                    
                                    textInput(inputId = "xlab", 
                                              label = "Label x-axis",
                                              value = "Equivalent dose [Gy]"),
                                    
                                    # inject sliderInput from Server.R
                                    uiOutput(outputId = "xlim"),
                                    
                                    br(),
                                    
                                    div(align = "center", h5("Y-axis")),
                                    
                                    fluidRow(
                                      column(width = 6,
                                             textInput(inputId = "ylab1", 
                                                       label = "Label y-axis (left)",
                                                       value = "Density")
                                             ),
                                      column(width = 6,
                                             textInput(inputId = "ylab2", 
                                                       label = "Label y-axis (right)",
                                                       value = "Cumulative frequency")
                                             ))
                           ),##EndOf::Tab_4
                           
                           
                           # Tab 5: modify data point representation
                           tabPanel("Datapoints",              
                                    
                                    div(align = "center", h5("Primary data set")),
                                    
                                    fluidRow(
                                      column(width = 6,
                                             selectInput(inputId = "color", label = "Datapoint color",
                                                         choices = list("Black" = "black",
                                                                        "Grey" = "grey50",
                                                                        "Red" = "#b22222", 
                                                                        "Green" = "#6E8B3D", 
                                                                        "Blue" = "#428bca",
                                                                        "Custom" = "custom"))
                                      ),
                                      column(width = 6,
                                             # show only if custom color is desired
                                             conditionalPanel(condition = "input.color == 'custom'",
                                                              textInput(inputId = "rgb",
                                                                        label = "Color name or RGB Code",
                                                                        value = "#000000"))
                                      )
                                    ),
                                    
                                    div(align = "center", h5("Secondary data set")),
                                    
                            
                                    fluidRow(
                                      column(width = 6,
                                             selectInput(inputId = "color2", label = "Datapoint color", 
                                                         selected = "#b22222",
                                                         choices = list("Black" = "black",
                                                                        "Grey" = "grey50",
                                                                        "Red" = "#b22222", 
                                                                        "Green" = "#6E8B3D", 
                                                                        "Blue" = "#428bca",
                                                                        "Custom" = "custom"))
                                      ),
                                      column(width = 6,
                                             # show only if custom color is desired
                                             conditionalPanel(condition = "input.color2 == 'custom'",
                                                              textInput(inputId = "rgb2",
                                                                        label = "Color name or RGB Code",
                                                                        value = "#000000"))
                                      )
                                    )
                                    
                           ),##EndOf::Tab_5
                           
                           
                           # Tab 9: save plot as pdf, wmf or eps
                           tabPanel("Export",
                                    
                                    radioButtons(inputId = "fileformat", 
                                                 label = "Fileformat", 
                                                 choices = c("PDF   (Portable Document Format)" = "pdf",
                                                             "SVG   (Scalable Vector Graphics)" = "svg",
                                                             "EPS   (Encapsulated Postscript)" = "eps")),
                                    
                                    textInput(inputId = "filename", 
                                              label = "Filename", 
                                              value = "Abanico Plot"),
                                    
                                    fluidRow(
                                      column(width = 6,
                                             numericInput(inputId = "imgheight",
                                                          label =  "Image height", 
                                                          value = 7)
                                      ),
                                      column(width = 6,
                                             numericInput(inputId = "imgwidth",
                                                          label = "Image width", 
                                                          value = 7)
                                      )
                                    ),
                                    
                                    selectInput(inputId = "fontfamily", 
                                                label = "Font", 
                                                selected = "Helvetica",
                                                choices = c("Helvetica" = "Helvetica",
                                                            "Helvetica Narrow" = "Helvetica Narrow",
                                                            "Times" = "Times",
                                                            "Courier" = "Courier",
                                                            "Bookman" = "Bookman",
                                                            "Palatino" = "Palatino")),
                                    
                                    tags$hr(),
                                    
                                    downloadButton(outputId = "exportFile", 
                                                   label = "Download plot"),
                                    
                                    tags$hr(),
                                    
                                    helpText("Additionally, you can download a corresponding .R file that contains",
                                             "a fully functional script to reproduce the plot in your R environment!"),
                                    
                                    downloadButton(outputId = "exportScript", 
                                                   label = "Download R script")
                                    
                                    
                           ),##EndOf::Tab_8
                           
                           # Tab 10: further information
                           tabPanel("About",
                                    hr(),
                                    div(align = "center",
                                        # HTML code to include a .png file in the tab; the image file must be in
                                        # a subfolder called "wwww"
                                        img(src="RL_Logo.png", height = 100, width = 100, alt = "R.Lum"),
                                        br(),
                                        a(href = "http://www.r-luminescence.de", "http://www.r-luminescence.de", target="_blank"),
                                        br(),
                                        a(href = "https://forum.r-luminescence.de", "https://forum.r-luminescence.de", target="_blank"),
                                        br(),br(),hr(),
                                        p("See the R code of this app on GitHub:"),
                                        a(href = "https://github.com/tzerk/shiny-KDEplot/tree/master",
                                          "https://github.com/tzerk/shiny-KDEplot/tree/master", target="_blank")
                                    )#/div
                           )##EndOf::Tab_9
               )##EndOf::tabsetPanel
  ),##EndOf::sidebarPanel
  
  # 3 - output panel
  mainPanel(width = 7,
            
            # insert css code inside <head></head> of the generated HTML file:
            # allow open dropdown menus to reach over the container
            tags$head(tags$style(type="text/css",".tab-content {overflow: visible;}")),
            tags$head(includeCSS("www/style.css")),
            
            # include js code that activates bootstraps tooltip plugin (opt-in)
            # the .js file also contains all the content of the tooltips
            tags$head(includeScript("www/tooltip.js")),
            
            # divide output in separate tabs via tabsetPanel
            # 1 - show Abanico Plot
            # 2 - print the data set that is plotted
            # 3 - show the results of the central age model (CAM) for primary data set
            # 4 - show the results of the central age model (CAM) for secondary  data set
            # 5 - generate and print the R code that is used for the plot in tab 1
            tabsetPanel(
              tabPanel("Plot", plotOutput(outputId = "main_plot", height = "500px")),
              tabPanel("Primary data set", dataTableOutput("dataset")),
              tabPanel("Secondary data set", dataTableOutput("dataset2")),
              tabPanel("Central Age Model", dataTableOutput("CAM")),
              tabPanel("R plot code", verbatimTextOutput("plotCode"))
            )###EndOf::tabsetPanel
  )##EndOf::mainPanel
)##EndOf::shinyUI(pageWithSidebar)