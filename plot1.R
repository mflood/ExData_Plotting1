# plot1.R

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

#hist(df$Global_active_power,
#     col="red",
#     main="Global Active Power",
#     ylab="Frequency",
#     xlab="Global Active Power (kilowatts)")

png(filename = "plot1.png",
    width = 480, height = 480,
    #bg = "white"
)

hist(df$Global_active_power,
    col="red",
    main="Global Active Power",
    ylab="Frequency",
    xlab="Global Active Power (kilowatts)"
)

dev.off()

