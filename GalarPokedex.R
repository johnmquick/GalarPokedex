####################
# HEADER
####################

# Data Extraction of Galar Pokedex from Serebii.net
# January 31, 2020
# John M. Quick
# http://johnmquick.com 
# Copyright John M. Quick. All Rights Reserved.

####################
# SETUP
####################

# load packages
library(rvest)
library(stringr)
library(data.table)

####################
# DATA COLLECTION
####################

# custom function: collect the data from the website and place raw html files in a directory
fDataCollect <- function(dir) {
        
        # home URL for serebii.net
        urlHome <- "https://www.serebii.net"
        
        # base URL for Galar Pokedex (Pokemon Sword/Shield)
        urlGalar <- "https://www.serebii.net/pokedex-swsh"
        
        # read the base URL
        htmlGalar <- read_html(urlGalar)
        
        # get the relative URLs for all Pokemon pages
        # get the page content node (id = "content")
        # get the form containing the page names for all Galar Pokemon (name = "galar")
        # get the value (relative URL) of all of the selectable options
        urlGalarPages <- 
                html_nodes(htmlGalar, xpath = ".//*[@id='content']") %>%
                html_nodes(xpath = ".//*[@name = 'galar']/select/option") %>% 
                html_attr("value")
        
        # remove the first item, since it does not lead to a relevant page
        urlGalarPages <- urlGalarPages[-1]
        
        # create a subdirectory to store all of the html pages
        # check whether directory exists
        if (!dir.exists(dir)) {
                
                # create directory
                dir.create(dir)
        }
        
        # iterate through pages
        for (i in 1:length(urlGalarPages)) {
                
                # create a file path in subdirectory with a unique id and leading zeros
                pFilePath <- 
                        str_glue(
                                dir, 
                                "/", 
                                str_pad(
                                        "p", 
                                        width = 5 - str_count(i), 
                                        side = "right", 
                                        pad = "0"
                                ), 
                                i, 
                                ".html"
                        )
                
                # if the file doesn't already exist
                if (!file.exists(pFilePath)) {
                        
                        # form page url
                        pUrl <- str_glue(urlHome, urlGalarPages[i])
                        
                        # read the page html
                        # extract the data from the content node
                        pPageContent <- read_html(pUrl) %>% html_nodes(xpath = "//*[@id='content']")
                        
                        # write page content to html file
                        write_html(pPageContent, pFilePath)
                }
        }
}

####################
# DATA PREPARATION
####################

# create a table to store all of the data
# create a typed column for each variable
# table is empty, not filled with any data
data <- data.table(
        NumGal = numeric(), 
        NumNat = numeric(), 
        Name = character(), 
        CanDynamax = logical(), 
        CaptureRate = numeric(), 
        BaseEggSteps = numeric(), 
        PctM = numeric(), 
        PctF = numeric(), 
        Height = numeric(), 
        Weight = numeric(), 
        Variant = character(), 
        Type1 = character(),
        Type2 = character(), 
        WkNorm = numeric(), 
        WkFire = numeric(), 
        WkWater = numeric(), 
        WkElec = numeric(), 
        WkGrass = numeric(), 
        WkIce = numeric(), 
        WkFight = numeric(), 
        WkPoison = numeric(), 
        WkGround = numeric(), 
        WkFly = numeric(), 
        WkPsy = numeric(), 
        WkBug = numeric(), 
        WkRock = numeric(), 
        WkGhost = numeric(), 
        WkDrag = numeric(), 
        WkDark = numeric(), 
        WkSteel = numeric(), 
        WkFairy = numeric(), 
        BaseTotal = numeric(), 
        BaseHp = numeric(), 
        BaseAtk = numeric(), 
        BaseDef = numeric(), 
        BaseSpAtk = numeric(), 
        BaseSpDef = numeric(), 
        BaseSpd = numeric(), 
        HinHpMin50 = numeric(), 
        HinHpMax50 = numeric(), 
        HinAtkMin50 = numeric(), 
        HinAtkMax50 = numeric(), 
        HinDefMin50 = numeric(), 
        HinDefMax50 = numeric(), 
        HinSpAtkMin50 = numeric(), 
        HinSpAtkMax50 = numeric(), 
        HinSpDefMin50 = numeric(), 
        HinSpDefMax50 = numeric(), 
        HinSpdMin50 = numeric(), 
        HinSpdMax50 = numeric(), 
        HinHpMin100 = numeric(), 
        HinHpMax100 = numeric(), 
        HinAtkMin100 = numeric(), 
        HinAtkMax100 = numeric(), 
        HinDefMin100 = numeric(), 
        HinDefMax100 = numeric(), 
        HinSpAtkMin100 = numeric(), 
        HinSpAtkMax100 = numeric(), 
        HinSpDefMin100 = numeric(), 
        HinSpDefMax100 = numeric(), 
        HinSpdMin100 = numeric(), 
        HinSpdMax100 = numeric(), 
        NeuHpMin50 = numeric(), 
        NeuHpMax50 = numeric(), 
        NeuAtkMin50 = numeric(), 
        NeuAtkMax50 = numeric(), 
        NeuDefMin50 = numeric(), 
        NeuDefMax50 = numeric(), 
        NeuSpAtkMin50 = numeric(), 
        NeuSpAtkMax50 = numeric(), 
        NeuSpDefMin50 = numeric(), 
        NeuSpDefMax50 = numeric(), 
        NeuSpdMin50 = numeric(), 
        NeuSpdMax50 = numeric(), 
        NeuHpMin100 = numeric(), 
        NeuHpMax100 = numeric(), 
        NeuAtkMin100 = numeric(), 
        NeuAtkMax100 = numeric(), 
        NeuDefMin100 = numeric(), 
        NeuDefMax100 = numeric(), 
        NeuSpAtkMin100 = numeric(), 
        NeuSpAtkMax100 = numeric(), 
        NeuSpDefMin100 = numeric(), 
        NeuSpDefMax100 = numeric(), 
        NeuSpdMin100 = numeric(), 
        NeuSpdMax100 = numeric(), 
        BenHpMin50 = numeric(), 
        BenHpMax50 = numeric(), 
        BenAtkMin50 = numeric(), 
        BenAtkMax50 = numeric(), 
        BenDefMin50 = numeric(), 
        BenDefMax50 = numeric(), 
        BenSpAtkMin50 = numeric(), 
        BenSpAtkMax50 = numeric(), 
        BenSpDefMin50 = numeric(), 
        BenSpDefMax50 = numeric(), 
        BenSpdMin50 = numeric(), 
        BenSpdMax50 = numeric(), 
        BenHpMin100 = numeric(), 
        BenHpMax100 = numeric(), 
        BenAtkMin100 = numeric(), 
        BenAtkMax100 = numeric(), 
        BenDefMin100 = numeric(), 
        BenDefMax100 = numeric(), 
        BenSpAtkMin100 = numeric(), 
        BenSpAtkMax100 = numeric(), 
        BenSpDefMin100 = numeric(), 
        BenSpDefMax100 = numeric(), 
        BenSpdMin100 = numeric(), 
        BenSpdMax100 = numeric()
)

####################
# DATA CLEANING
####################

# custom function: extract all relevant data from multiple files in a directory and build a clean dataset
fScrape <- function(dir) {
        
        # retrieve variant and non-variant files
        filesByType <- fCheckVariants(dir)
        
        # store variant and non-variant files separately for processing
        # create file path that includes subdirectory for each item
        filesNormal <- unlist(filesByType[1])
        filesVariant <- unlist(filesByType[2])
        
        # iterate through all normal files
        for (i in 1:length(filesNormal)) {

                # the normal function returns complete data for one non-variant
                # this represents one row in the dataset
                fileData <- fGetDataNormal(filesNormal[i])
                
                # add the data to the primary dataset
                data <- rbind(data, fileData, use.names = FALSE)
        }
        
        # iterate through all variant files
        for (j in 1:length(filesVariant)) {

                # the variant function returns complete data for variants
                # this represents multiple rows in the dataset
                fileData <- fGetDataVariant(filesVariant[j])
                
                # add the data to the primary dataset
                data <- rbind(data, fileData, use.names = FALSE)
        }
        
        # fix inconsistent data
        data <- fFixRotom(data)
        
        # return
        return(data)
}

# custom function: separate directory files into variants and non-variants
fCheckVariants <- function(dir) {
        
        # retrieve all files from subdirectory
        # add subdirectory to create file paths
        files <- paste0(dir, "/", list.files(dir))
        
        # store normal and variant files separately for processing
        filesNormal <- character()
        filesVariant <- character()
        
        # iterate through all files
        for (i in 1:length(files)) {

                # retrieve all relevant page data from the "dextable" class
                pRaw <- read_html(files[i]) %>% html_nodes(xpath = ".//*[@class = 'dextable']")

                # check whether variants exist
                # look for multiple stats tables
                numVariants <- 
                        subset(pRaw, subset = grepl("Stats", pRaw)) %>% 
                        length()
                
                # if there are more than 1 stats tables
                if (numVariants > 1) {
                        
                        # there are variants
                        # add to variant collection
                        filesVariant <- append(filesVariant, files[i])
                }
                
                # if there is only 1 stats table
                else {
                        
                        # there are no variants
                        # add to normal collection
                        filesNormal <- append(filesNormal, files[i])
                }
        }
        
        # create a list to store files by type
        filesByType <- list(filesNormal, filesVariant)

        # return
        return(filesByType)
}

# custom function: extract all relevant data that is in common, regardless of variants
fGetDataCommon <- function(file) {
        
        # retrieve all relevant page data from the "dextable" class
        pRaw <- read_html(file) %>% html_nodes(xpath = ".//*[@class = 'dextable']")
        
        # get the data from the common info table
        pDataCommon <- 
                subset(pRaw, subset = grepl("Other Names", pRaw)) %>% 
                html_nodes(xpath = ".//*[@class = 'fooinfo']") %>% 
                html_text(trim = TRUE)
        
        # name
        pName <- pDataCommon[1]
        
        # number
        pNumNat <- as.numeric(str_extract_all(pDataCommon[3], "\\d+", simplify = TRUE)[1])
        pNumGalar <- as.numeric(str_extract_all(pDataCommon[3], "\\d+", simplify = TRUE)[2])
        
        # check for genderless Pokemon
        if (grepl("Genderless", pDataCommon[4])) {
                
                # set values to 0 to indicate no gender
                pPctM <- 0
                pPctF <- 0
        }
        
        # otherwise, extract gender ratio
        else {
                
                # percentage of males and females
                pPctM <- as.numeric(str_extract_all(pDataCommon[4], "\\d+\\.?\\d*", simplify = TRUE))[1] / 100
                pPctF <- as.numeric(str_extract_all(pDataCommon[4], "\\d+\\.?\\d*", simplify = TRUE))[2] / 100
                
        }
        
        # capture rate
        pCaptureRate <- as.numeric(pDataCommon[8]) / 100
        
        # base egg steps
        pBaseEggSteps <- as.numeric(str_replace(pDataCommon[9], "\\,", ""))
        
        # get the data from the experience growth table
        pDataExp <- 
                subset(pRaw, subset = grepl("Experience Growth", pRaw)) %>% 
                html_nodes(xpath = ".//*[@class = 'fooinfo']") %>% 
                html_text(trim = TRUE)
        
        # whether the Pokemon can Dynamax
        pCanDynamax <- !str_detect(pDataExp[5], "cannot")
        
        # combine the data into a table
        # represents a single row with partial columns in dataset
        pRow <- data.table(
                pNumGalar, 
                pNumNat, 
                pName, 
                pCanDynamax, 
                pCaptureRate, 
                pBaseEggSteps, 
                pPctM, 
                pPctF 
        )
        
        # return
        return(pRow)
}

# custom function: extract all relevant data for normal (non-variant) Pokemon
fGetDataNormal <- function(file) {
        
        # retrieve all relevant page data from the "dextable" class
        pRaw <- read_html(file) %>% html_nodes(xpath = ".//*[@class = 'dextable']")
        
        # get the data from the common info table
        pDataCommon <- 
                subset(pRaw, subset = grepl("Other Names", pRaw)) %>% 
                html_nodes(xpath = ".//*[@class = 'fooinfo']") %>% 
                html_text(trim = TRUE)
        
        # height (in meters) converted into a numeric value
        # located in row 6
        # look for 1 or more digits, then "m"
        # a decimal point is optional, followed by 0 or more digits
        # non-numeric text is removed
        pHeight <- 
                as.numeric(
                        str_replace_all(
                                unlist(
                                        str_extract_all(
                                                pDataCommon[6], 
                                                "(\\d+\\.?\\d*)m"
                                        )    
                                ), 
                                c("m" = "")
                        )
                )
        
        # weight (in kg) converted into a numeric value
        # located in row 7
        # look for 1 or more digits, then "kg"
        # a decimal point is optional, followed by 0 or more digits
        # non-numeric text is removed
        pWeight <- 
                as.numeric(
                        str_replace_all(
                                unlist(
                                        str_extract_all(
                                                pDataCommon[7], 
                                                "(\\d+\\.?\\d*)kg"
                                        )    
                                ), 
                                c("kg" = "")
                        )
                )
        
        # no variant (normal)
        pVariant <- "Normal"
        
        # extract the type data
        # look for an interior table within the common info table ("cen" class)
        # type identifiers are found in the img alt tag(s)
        # remove unnecessary text from the img alt tags (-type)
        pDataTypes <- 
                subset(pRaw, subset = grepl("Other Names", pRaw)) %>% 
                html_nodes(xpath = ".//*[@class = 'cen']/a/img") %>% 
                html_attr("alt") %>% 
                str_extract("(.*)(?=(-type))")
        
        # assign the first type
        pType1 <- pDataTypes[1]
        
        # assign the second type, if any
        pType2 <- if (length(pDataTypes) > 1) pDataTypes[2] else "None"
        
        # get the data from the weakness info table
        # one weakness multiplier for each type
        # same format for all Pokemon
        pDataWeak <- 
                subset(pRaw, subset = grepl("Weakness", pRaw)) %>% 
                html_nodes(xpath = ".//*[@class = 'footype']") %>% 
                html_text(trim = TRUE)
        
        # convert weakness data to numeric
        # remove non-numeric text
        pWeakValues <- as.numeric(
                str_replace(
                        subset(pDataWeak, pDataWeak[] != ""), 
                        "\\*", 
                        ""
                )
        )
        
        # all Pokemon have complete weakness values across the same variables
        pWeakTable <- transpose(data.table(pWeakValues))
        
        # get the data from the stats info table
        pDataStats <- subset(pRaw, subset = grepl("Stats", pRaw)) 
        
        # convert stats data to numeric
        # extract individual numbers from character string min-max ranges
        pStatsValues <- 
                as.numeric(
                        str_extract_all(
                                html_text(pDataStats), 
                                "\\d+", 
                                simplify = TRUE
                        )
                )
        
        # all Pokemon have complete stats values across the same variables
        # certain level values (50, 100) are skipped, since they are labels
        pStatsTable <- 
                data.table(
                        pStatsValues[1],
                        transpose(data.table(pStatsValues[2:7])), 
                        transpose(data.table(pStatsValues[9:20])), 
                        transpose(data.table(pStatsValues[22:33])), 
                        transpose(data.table(pStatsValues[35:46])), 
                        transpose(data.table(pStatsValues[48:59])), 
                        transpose(data.table(pStatsValues[61:72])), 
                        transpose(data.table(pStatsValues[74:85])) 
                )
        
        # combine the data into a table
        # represents a single row in the dataset
        pData <- data.table(
                fGetDataCommon(file), 
                pHeight, 
                pWeight, 
                pVariant, 
                pType1, 
                pType2, 
                pWeakTable, 
                pStatsTable 
        )
        
        # return
        return(pData)
}

# custom function: extract all relevant data that varies when variants are included
fGetDataVariant <- function(file) {
        
        # retrieve all relevant page data from the "dextable" class
        pRaw <- read_html(file) %>% html_nodes(xpath = ".//*[@class = 'dextable']")
        
        # get the data from the common info table
        pDataCommon <- 
                subset(pRaw, subset = grepl("Other Names", pRaw)) %>% 
                html_nodes(xpath = ".//*[@class = 'fooinfo']") %>% 
                html_text(trim = TRUE)
        
        # height (in meters) converted into a numeric value
        # located in row 6
        # look for 1 or more digits, then "m"
        # a decimal point is optional, followed by 0 or more digits
        # non-numeric text is removed
        pHeights <- 
                as.numeric(
                        str_replace_all(
                                unlist(
                                        str_extract_all(
                                                pDataCommon[6], 
                                                "(\\d+\\.?\\d*)m"
                                        )    
                                ), 
                                c("m" = "")
                        )
                )
        
        # weight (in kg) converted into a numeric value
        # located in row 7
        # look for 1 or more digits, then "kg"
        # a decimal point is optional, followed by 0 or more digits
        # non-numeric text is removed
        pWeights <- 
                as.numeric(
                        str_replace_all(
                                unlist(
                                        str_extract_all(
                                                pDataCommon[7], 
                                                "(\\d+\\.?\\d*)kg"
                                        )    
                                ), 
                                c("kg" = "")
                        )
                )
        
        # get the data from the weakness info table
        # one weakness multiplier for each type
        # same format for all Pokemon
        pDataWeak <- 
                subset(pRaw, subset = grepl("Weakness", pRaw)) %>% 
                html_nodes(xpath = ".//*[@class = 'footype']") %>% 
                html_text(trim = TRUE)
        
        # convert weakness data to numeric
        # remove non-numeric text
        pWeakValues <- as.numeric(
                str_replace(
                        subset(pDataWeak, pDataWeak[] != ""), 
                        "\\*", 
                        ""
                )
        )
        
        # get the stats data tables for all variants
        pDataStats <- subset(pRaw, subset = grepl("Stats", pRaw)) 
        
        # get the type data for all variants
        # look for an interior table within the common info table ("cen" class)
        # multiple variant names and types, if any, are stored in rows (tr)
        pDataTypes <-
                subset(pRaw, subset = grepl("Other Names", pRaw)) %>%
                html_nodes(xpath = ".//*[@class = 'cen']/table/tr")
        
        # create empty table to store variant data
        # copy the columns from the primary dataset
        pData <- copy(data[0])
        
        # iterate through variants
        # take the max of either the number of stats tables or weakness value sets
        for (i in 1:max(length(pDataStats), length(pWeakValues) / 18)) {
                
                # handle multiple heights and weights
                # if there are multiple heights
                if (length(pHeights) > 1) {
                        
                        # the first variant
                        if (i == 1) {
                                
                                # the first variant always uses the first value
                                pHeight <- pHeights[1]
                        }
                        
                        # all other variants
                        else {
                                
                                # all other variants use the second value
                                pHeight <- pHeights[2]
                        }
                }
                
                # otherwise
                else {
                        
                        # take the only value
                        pHeight <- pHeights
                }
                
                # if there are multiple weights
                if (length(pWeights) > 1) {
                        
                        # the first variant
                        if (i == 1) {
                                
                                # the first variant always uses the first value
                                pWeight <- pWeights[1]
                        }
                        
                        # all other variants
                        else {
                                
                                # all other variants use the second value
                                pWeight <- pWeights[2]
                        }
                }
                
                # otherwise
                else {
                        
                        # take the only value
                        pWeight <- pWeights
                }
                
                # if mutliple types were found
                if (length(pDataTypes) > 0) {
                        
                        # extract the variant type(s) from img alt tags
                        # remove unnecessary text from tags (-type)
                        pTypes <- 
                                str_extract(
                                        pDataTypes[i] %>% 
                                                html_nodes(xpath = ".//*/img") %>% 
                                                html_attr("alt"), 
                                        "(.*)(?=(-type))"
                                )
                        
                        # assign the first type
                        pType1 <- pTypes[1]
                        
                        # assign the second type, if any
                        pType2 <- if (length(pTypes) > 1) pTypes[2] else "None"
                }
                
                # otherwise, variants share the same type(s)
                else {
                        
                        # use the normal procedure to extract the type
                        pTypes <- 
                                subset(pRaw, subset = grepl("Other Names", pRaw)) %>% 
                                html_nodes(xpath = ".//*[@class = 'cen']/a/img") %>% 
                                html_attr("alt") %>% 
                                str_extract("(.*)(?=(-type))")
                        
                        # assign the first type
                        pType1 <- pTypes[1]
                        
                        # assign the second type, if any
                        pType2 <- if (length(pTypes) > 1) pTypes[2] else "None"
                        
                }
                
                # all variants have complete weakness values across the same variables
                # select corresponding weakness values for this iteration
                pWeakTable <- transpose(data.table(pWeakValues[(1 + ((i - 1) * 18)):(18 + ((i - 1) * 18))]))
                
                # some variants share weakness values with the other versions
                # if previous calculation resulted in NA values
                if (is.na(pWeakTable[1, 1])) {
                        
                        # just take the regular weakness values
                        pWeakTable <- transpose(data.table(pWeakValues))
                        
                }
                
                # extract all stat values from the html text
                # if a stats table matches the current variant
                if (length(pDataStats) >= i) {
                        
                        # use the corresponding stats table
                        pStatsValues <- 
                                as.numeric(
                                        str_extract_all(
                                                html_text(pDataStats[i]), 
                                                "\\d+", 
                                                simplify = TRUE
                                        )
                                )
                        
                        # get the variant name from the stats table
                        pVariant <- 
                                str_replace(
                                        str_replace(
                                                str_extract(
                                                        html_text(pDataStats[i]), 
                                                        "^(Stats - )(.*)Â"
                                                ), 
                                                "Stats - ", 
                                                ""
                                        ), 
                                        "Â", 
                                        ""
                                )
                }

                # all other variants (sometimes they share stats tables)
                else {
                        
                        # all other variants use the second stats table
                        pStatsValues <- 
                                as.numeric(
                                        str_extract_all(
                                                html_text(pDataStats[2]), 
                                                "\\d+", 
                                                simplify = TRUE
                                        )
                                )
                        
                        # get the variant name from the stats table
                        pVariant <- 
                                str_replace(
                                        str_replace(
                                                str_extract(
                                                        html_text(pDataStats[2]), 
                                                        "^(Stats - )(.*)Â"
                                                ), 
                                                "Stats - ", 
                                                ""
                                        ), 
                                        "Â", 
                                        ""
                                )
                }
                
                # if the variant name is still NA
                if (is.na(pVariant)) {
                        
                        # it is the normal variant
                        pVariant <- "Normal"
                }
                
                # all variants have complete stats values across the same variables
                # certain level values (50, 100) are skipped, since they are labels and not stats
                pStatsTable <- 
                        data.table(
                                pStatsValues[1],
                                transpose(data.table(pStatsValues[2:7])), 
                                transpose(data.table(pStatsValues[9:20])), 
                                transpose(data.table(pStatsValues[22:33])), 
                                transpose(data.table(pStatsValues[35:46])), 
                                transpose(data.table(pStatsValues[48:59])), 
                                transpose(data.table(pStatsValues[61:72])), 
                                transpose(data.table(pStatsValues[74:85])) 
                        )
                
                # combine the data into a table
                # represents one row in variant dataset
                pRow <- data.table(
                        fGetDataCommon(file), 
                        pHeight, 
                        pWeight, 
                        pVariant, 
                        pType1, 
                        pType2, 
                        pWeakTable, 
                        pStatsTable 
                )
                
                # add the row to the variant dataset
                pData <- rbind(pData, pRow, use.names = FALSE)
        }
        
        # return
        return(pData)
}

# custom function: fix the Rotom data, which are coded inconsistently in the original HTML page
fFixRotom <- function(data) {
        
        # Rotom breaks the mold!
        # problem: in the original page, these inconsistencies appear
        # variant order in the type table: Normal, Frost, Heat, Mow, Fan, Wash
        # variant order in the weakness tables: Normal, Heat, Wash, Frost, Fan, Mow
        # fix: change the variant names to match their corresponding weaknesses
        
        # store the variant names in the proper order
        variantNames <- c("Normal", "Heat", "Wash", "Frost", "Fan", "Mow")
        
        # store the variant types in the proper order
        variantTypes <- c("Ghost", "Fire", "Water", "Ice", "Flying", "Grass")
        
        # update the variant data
        data[Name == "Rotom"]$Variant <- variantNames
        data[Name == "Rotom"]$Type2 <- variantTypes
        
        # return
        return(data)
}

####################
# PROCEDURE
####################

# collect the data
fDataCollect("GalarPages")

# scrape the data and convert it into a cleaned dataset
data <- fScrape("GalarPages")

# write the cleaned dataset to a csv file
fwrite(data, "GalarPokedex.csv")

# The cleaned dataset contains:
# 400+ rows representing individual Pokemon
# 110 columns representing different Pokemon attributes