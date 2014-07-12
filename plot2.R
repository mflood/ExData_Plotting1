df = read.csv("household_power_consumption.txt",
               nrows=69516,
               sep=";",
               na.strings="?",
               colClasses=c( "factor",
                             "factor",
                             "numeric",
                             "numeric",
                             "numeric",
                             "numeric",
                             "numeric",
                             "numeric",
                             "numeric")
             )
df$Date <- as.Date(df$Date, "%d/%m/%Y")
valid_date_index <- df$Date == "2007-02-01" | df$Date== "2007-02-02"
df <- df[valid_date_index, ]

df$datetime <- strptime(paste(df$Date, df$Time), format="%Y-%m-%d %H:%M:%S")


do_plot <- function() {
    plot(df$datetime, df$Global_active_power,
          ylab="Global Active Power (kilowatts)",
          xlab=NA,
          type="l")

}


do_png_plot <- function(png_name) {
    png(filename = png_name,
        width = 480,
        height = 480,
        bg = "white"
    )

    do_plot()
    dev.off()
}


#do_plot()
do_png_plot("plot2.png")

