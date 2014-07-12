# plot4.R

# Create data directory
#
if (!file.exists("data")) {
    dir.create("data")
}

# Download and extract zip file if needed
#
if (! file.exists("data/household_power_consumption.txt")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                   method="curl",
                   destfile="data/source.zip")
    unzip("data/source.zip", exdir="data")
}

# Only read the fist 69K Rows
#
df = read.csv("data/household_power_consumption.txt",
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
# Convert date column from factor to Date
#
df$Date <- as.Date(df$Date, "%d/%m/%Y")

# Only keep the 2 dates, get rid of the other data
#
valid_date_index <- df$Date == "2007-02-01" | df$Date== "2007-02-02"
df <- df[valid_date_index, ]

# create new datetime column from the date and time columns
#
df$datetime <- strptime(paste(df$Date, df$Time), format="%Y-%m-%d %H:%M:%S")


# This function creates the plot lines, but not the legend
#
plot_submetering <- function() {
    plot(df$datetime, df$Sub_metering_1,
          ylab="Energy sub metering",
          xlab=NA,
          type="n")
            points(df$datetime, df$Sub_metering_1, type="l", col="black")
            points(df$datetime, df$Sub_metering_2, type="l", col="red")
            points(df$datetime, df$Sub_metering_3, type="l", col="blue")

}

do_leg <- function() {
    legend("topright",
    legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
    col=c("black", "red", "blue"),
    lty=1)
}

plot_global_active_power <- function() {
    plot(df$datetime, df$Global_active_power,
          ylab="Global Active Power",
          xlab=NA,
          type="l")
}

plot_global_reactive_power <- function() {
    plot(df$datetime, df$Global_reactive_power,
          ylab="Global_reactive_power",
          xlab="datetime",
          type="l")
}

plot_voltage <- function() {
    plot(df$datetime, df$Voltage,
          ylab="Voltage",
          xlab="datetime",
          type="l")
}

do_plot <- function() {
    # 4 grapsh in a 2 x 2 window
    par(mfrow = c(2,2))
    
    plot_global_active_power()
    plot_voltage()
    plot_submetering()
    do_leg()
    plot_global_reactive_power()
}


# Sends the plot and legend to a file
#
do_png_plot <- function(png_name) {
    png(filename = png_name,
        width = 480,
        height = 480,
        bg = "transparent"
    )

    do_plot()
    dev.off()
}

# Run the plot
do_png_plot("plot4.png")


