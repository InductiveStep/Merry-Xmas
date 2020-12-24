#######################################################################
#######################################################################
# A seasonal greeting
#
#   Andi Fugard - 24 Dec 2020
#   @InductiveStep
#######################################################################
#######################################################################


#######################################################################
# Set up the package
#######################################################################

install.packages("tuneR")
library("tuneR")

#######################################################################
# A table of notes and frequencies
# https://pages.mtu.edu/~suits/notefreqs.html
#######################################################################

theFreqs <- read.csv(text = "Note,Freq
c,261.63
c#,277.18
d,293.66
d#,311.13
e,329.63
f,349.23
f#,369.99
g,392.00
g#,415.30
a,440.00
a#,466.16
b,493.88
C,523.26")

#######################################################################
# A tune, extracted and transformed from
# https://github.com/tomds/Arduino-Tunes/blob/master/arduino_tunes.pde
#######################################################################

theTune <- read.csv(text = "Note,Crotchets
d,4
g,4
g,2
a,2
g,2
f#,2
e,4
c,4
e,4
a,4
a,2
b,2
a,2
g,2
f#,4
d,4
f#,4
b,4
b,2
C,2
b,2
a,2
g,4
e,4
d,2
d,2
e,4
a,4
f#,4
g,8")

#######################################################################
# Glue together the notes and frequencies and fiddle with timing
#######################################################################

# Number the tune table rows
theTune$i <- 1:nrow(theTune)

# Merge tune and frequency table
tuneToPlay <- merge(theTune, theFreqs)
tuneToPlay <- tuneToPlay[order(tuneToPlay$i),]

# Transform crotchets to seconds
tuneToPlay$Secs <- tuneToPlay$Crotchets * .1

#######################################################################
# Glue together the different notes and play!
# I have no idea what it will do on Macs, but on Windows it opens
# Media Player
#######################################################################

mySine    <- function(freq, secs) sine(freq = freq,
                                       duration = secs,
                                       xunit = "time")
sine.list <- mapply(mySine, tuneToPlay$Freq, tuneToPlay$Secs)
wave      <- do.call(bind, sine.list)
play(wave)

#######################################################################
# The end.
