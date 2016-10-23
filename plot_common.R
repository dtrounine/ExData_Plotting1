library(dplyr)
library(tools)

#
# For displaying day of weeks in english
#
Sys.setlocale("LC_TIME", "English")

#
# Scans the current directory recursively for a file having MD5 checksum of the data file we need
# Returns the found file, ot NULL if there are no such file
#
findRawDataFile <- function() {
    allFiles <- list.files(path = ".", all.files = TRUE, recursive = TRUE, include.dirs = FALSE)
    foundFiles <- allFiles[md5sum(allFiles) == "41f51806846b6b567b8ae701a300a3de"]
    if (length(foundFiles) >= 1) {
        foundFiles[[1]]
    } else {
        NULL
    }
}

iswindows <- function() {
    tolower(Sys.info()["sysname"]) == "windows"
}

#
# Finds previously downloaded or, if not found, downloads the raw data file to be used for analysis.
# Returns the file name.
#
getRawFile <- function() {
    filename <- findRawDataFile()
    
    if (!is.null(filename)) {
        print(paste("Using data file: ", filename, sep = ""))
        
    } else {
        if (!file.exists("data")) {
            dir.create("data")
        }
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        filename <- file.path("data", "household_power_consumption_data.zip")
        print(paste("Downloading from ", fileUrl, " to ", filename, sep = ""))
        downloadMethod <- if (iswindows()) "auto" else "curl"
        download.file(fileUrl, filename, method = downloadMethod)
    }
    filename
}

#
# Loads power consumption data
#
loadData <- function(rawFile) {
    con <- unz(description = rawFile, 
               filename = "household_power_consumption.txt")
    data <- read.table(con, 
                       stringsAsFactors = FALSE,
                       colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"),
                       header = TRUE, 
                       sep = ";",
                       na.strings = "?")
    data$DateTime <- as.POSIXlt(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S", tz = "GMT")
    data$Time <- NULL
    
    data
}

#
# Select rows with dates that we are interested in (two days in February, 2007)
#
selectData <- function(data) {
    # Select 2007-02-01 and 2007-02-02
    data <- data[data$Date %in% c("1/2/2007", "2/2/2007"),]
    
    data
}

#
# Function to be used for getting data for making plots
#
getData <- function() {
    rawFile <- getRawFile()
    data <- loadData(rawFile)
    selectedData <- selectData(data)
    
    selectedData
}

