#! /usr/bin/env Rscript
#
# Copyright (C) 2022 Kevin Glocker

library(stringi)

source("aggregation-helper-functions.R")
source("add-features.R")

# Set up warnings
options(warn=1, error=NULL)

args <- commandArgs(trailingOnly=TRUE)
num_arguments <- length(args)
if (num_arguments != 3) {
    stop("Usage: ./generate_features.R missing_phonemes_path missing_features_path allophoible_path")
}
# Get missing phonemes csv
missing_phonemes = read.csv(args[1])
total_missing <- as.character(missing_phonemes$phoneme)
# Order IPA before processing (might not be necessary for segments that were already in phoible)
total_missing <- order_ipa(total_missing)
# Get individual code points for each character in the IPA segment
code_points <- get_codepoints(total_missing)
# Build features for each code point segment
features <- do.call(rbind, lapply(code_points, build_features_from_id))

# Write generated features
write.csv(features, file = args[2], row.names = FALSE, quote = TRUE, eol="\n", fileEncoding="UTF-8")
phoible <- read.csv(file.path("..", "data", "phoible.csv"), stringsAsFactors = FALSE)
# Rename the segment column
names(features)[names(features) == "segment"] = "Phoneme"
features$Source <- missing_phonemes$source
# Since InventoryIDs start at 1, 0 is free for representing allophones
features$InventoryID <- 0
# Create mapping from allophones to related phoneme classes for resolving ambiguous cases
phonemeSegments <- stack(setNames(strsplit(phoible$Allophones, " "), phoible$SegmentClass))
names(phonemeSegments) <- c("Allophones", "SegmentClass")
phonemeSegments <- phonemeSegments[!is.na(phonemeSegments$Allophones) & !duplicated(phonemeSegments),]
# Create segment classes
features$SegmentClass <- assign_seg_class(features$Phoneme, phonemeSegments)
# Fill all other columns with NA
features[setdiff(names(phoible), names(features))] <- NA
# Remove glyph types which are not included in Phoible
features <- subset(features, select = -GlyphType)
allophoible <- rbind(phoible, features)
write.csv(allophoible, file = args[3], row.names = FALSE, quote = TRUE, eol="\n", fileEncoding="UTF-8")
# Stops if any features are NA
stopifnot(!any(is.na(features[feature_colnames])))
