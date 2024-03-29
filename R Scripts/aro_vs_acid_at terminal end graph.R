###Make a graph that compares aromatics vs acidics at the end of the sequence

#Use random library first
lib <- random_library %>% 
  filter(nchar(sequence) == 20)

#make empty df to hold distance form n-terminal, live_count, and die_count
aro_distance <- tibble(pos = 1:20,
                       live_count = 0,
                       die_count = 0)

#split seq, find pos of aro, subtract from len, add to either live or die count based on binary
for (i in 1:nrow(lib)) {
seq <- strsplit(lib$sequence[i], '')[[1]]
len <- length(seq)
pos <- grep('[WYF]', seq)
#pos <- (len + 1) - pos #this is position from the end of the molecule

if (lib$binary_stop[i] == 'live') {
  aro_distance$live_count[pos] <- aro_distance$live_count[pos] + 1
} 

if (lib$binary_stop[i] == 'die') {
  aro_distance$die_count[pos] <- aro_distance$die_count[pos] + 1
}
}

#add live percent
aro_distance$live_percent <- aro_distance$live_count/(aro_distance$live_count + aro_distance$die_count) * 100

ggplot(aro_distance, aes(pos, live_percent))+
  geom_smooth()


###same for acidic
#make empty df to hold distance form n-terminal, live_count, and die_count
aci_distance <- tibble(pos = 1:20,
                       live_count = 0,
                       die_count = 0)

#split seq, find pos of aro, subtract from len, add to either live or die count based on binary
for (i in 1:nrow(lib)) {
  seq <- strsplit(lib$sequence[i], '')[[1]]
  len <- length(seq)
  pos <- grep('[STNQ]', seq)
  #pos <- (len + 1) - pos #this is position from the end of the molecule
  
  if (lib$binary_stop[i] == 'live') {
    aci_distance$live_count[pos] <- aci_distance$live_count[pos] + 1
  } 
  
  if (lib$binary_stop[i] == 'die') {
    aci_distance$die_count[pos] <- aci_distance$die_count[pos] + 1
  }
}

#add live percent
aci_distance$live_percent <- aci_distance$live_count/(aci_distance$live_count + aci_distance$die_count) * 100

ggplot(aci_distance, aes(pos, live_percent))+
  geom_bar(stat = 'identity')


#MAKE THIS A GENERAL CLASS OR REGEX SCRIPT
















