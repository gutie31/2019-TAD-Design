#2019 library sets, for WD tads
#load libraries
library(tidyverse)

#need a list to hold all the different sequence sets
library_2019 <- list()

##Build G_link_WD library----
#how long will the activity module get to
len <- 11

#all combos of activity modul from 1:11 length
seqset <- list()
for(i in 1:len){
  seqset[[i]] <- c('W', 'D') %>% 
    list() %>% 
    rep(i) %>% 
    expand.grid(stringsAsFactors = F)
}


#Build a dataframe of sequences
seq_number <- lapply(seqset, nrow) %>% unlist() %>% sum()
seq_holder <- data.frame(row.names = 1:seq_number) %>% as_tibble()
seq_holder$module <- ''
row_holder <- 1

for(i in 1:length(seqset)){
  df <- seqset[[i]]
  for(j in 1:nrow(df)){
    seq <- paste(df[j,], collapse = '')
    seq_holder$module[row_holder] <- seq
    row_holder <- row_holder + 1
  }
}

##add "G" before to reach a total length of x (20 is what Im going with)
##Find length of sequence and paste and adequate G
seq_holder$sequence <- ''
for(i in 1:nrow(seq_holder)){
  len_factor <- nchar(seq_holder$module[i])
  geez <- paste(rep('G', 20 - len_factor), collapse = '')
  seq_holder$sequence[i] <- paste(geez, seq_holder$module[i], sep = '') 
}

#ADD this combinatorial set to library_2019 list
library_2019$combinatorial <- seq_holder

#seq_holder has activity module sequence and full g_link_sequence
#I can remove df and seqset, and geex, len, len_factor
rm(list = c('geez', 'df', 'seqset',
            'i', 'j', 'len_factor', 'row_holder',
            'seq', 'seq_number', 'len', 'seq_holder'))


##SETS 3 and 4 studying directionality #better name is W first and D first----
hold <- list()
for(i in 1:10){
  seq <- rep(c('W','D'), each = i) %>% paste(collapse = '')
  geez <-  paste(rep('G', 20 - nchar(seq)), collapse = '')
  geez <- paste(geez, seq, sep = '')
  hold[[i]] <- geez
}
W_first <- tibble(sequence = hold %>% unlist()) %>% 
  mutate(
    is.supp = ifelse(sequence %in% library_2019$combinatorial$sequence, 'no', 'yes')
  )

#rev of above
hold2 <- list()
for(i in 1:10){
  seq <- rep(c('D','W'), each = i) %>% paste(collapse = '')
  geez <-  paste(rep('G', 20 - nchar(seq)), collapse = '')
  geez <- paste(geez, seq, sep = '')
  hold2[[i]] <- geez
}

D_first <- tibble(sequence = hold2 %>% unlist()) %>% 
  mutate(
    is.supp = ifelse(sequence %in% library_2019$combinatorial$sequence, 'no', 'yes')
  )

#add these two sets to library
library_2019$W_first <- W_first
library_2019$D_first <- D_first

#remove variables i don't need
rm(list = c('hold', 'hold2',
            'geez', 'i', 'seq', 'W_first', 'D_first'))




##make g spaces aro_neg library----
a <- 18
b <- 'W'
c <- 0
d <- 'D'

hold3 <- list()
for(i in 1:10){
  a_block <- rep('G', a) %>% paste(collapse = '')
  c_block <- rep('G', c) %>% paste(collapse = '')
  hold3[[i]] <- paste(a_block, b, c_block, d, sep = '')
  a <- a - 1
  c <- c + 1
}

#2 w and 2 d
a <- 16
b <- 'WW'
c <- 0
d <- 'DD'

hold4 <- list()
for(i in 1:10){
  a_block <- rep('G', a) %>% paste(collapse = '')
  c_block <- rep('G', c) %>% paste(collapse = '')
  hold4[[i]] <- paste(a_block, b, c_block, d, sep = '')
  a <- a - 1
  c <- c + 1
}

#3w sand 3d
a <- 14
b <- 'WWW'
c <- 0
d <- 'DDD'

hold5 <- list()
for(i in 1:10){
  a_block <- rep('G', a) %>% paste(collapse = '')
  c_block <- rep('G', c) %>% paste(collapse = '')
  hold5[[i]] <- paste(a_block, b, c_block, d, sep = '')
  a <- a - 1
  c <- c + 1
}

#4w and 4d
a <- 12
b <- 'WWWW'
c <- 0
d <- 'DDDD'

hold6 <- list()
for(i in 1:10){
  a_block <- rep('G', a) %>% paste(collapse = '')
  c_block <- rep('G', c) %>% paste(collapse = '')
  hold6[[i]] <- paste(a_block, b, c_block, d, sep = '')
  a <- a - 1
  c <- c + 1
}

#5w and 5d
a <- 10
b <- 'WWWWW'
c <- 0
d <- 'DDDDD'

hold7 <- list()
for(i in 1:10){
  a_block <- rep('G', a) %>% paste(collapse = '')
  c_block <- rep('G', c) %>% paste(collapse = '')
  hold7[[i]] <- paste(a_block, b, c_block, d, sep = '')
  a <- a - 1
  c <- c + 1
}



##g_spacing
g_spaced_seqs <- map(c(hold3,hold4,hold5,hold6,hold7), unlist) %>% unlist()

set_g_spaced <-tibble(sequence = g_spaced_seqs) %>% 
  mutate(
    is.supp = ifelse(sequence %in% library_2019$combinatorial$sequence, 'no', 'yes')
  )

#add set to library
library_2019$set_g_spacing <- set_g_spaced

#remove junk from environment
rm(list = c('a', 'a_block', 'b', 'c', 'c_block', 'd', 'i',
            'hold3', 'hold4', 'hold5', 'hold6', 'hold7', 'g_spaced_seqs', 'set_g_spaced'))

###G in and G out-----
ref_seq <- 'WDWDWDWDWDWDWDWDWDWD'

replacement_order <- c(10,11,9,12,8,13,7,14,6,15,5,16,4,17,3,18,2,19,1,20)
t <- 1
hold <- list()
for (i in replacement_order) {
  seq <- strsplit(ref_seq,'')[[1]]
  seq[i] <- 'G'
  seq <- paste(seq, collapse = '')
  ref_seq <- seq
  hold[[t]] <- seq
  t <- t + 1
}

g_out <- tibble(sequence = hold %>% unlist()) %>% 
  mutate(
    is.supp = ifelse(sequence %in% library_2019$combinatorial$sequence, 'no', 'yes')
  )

#G_in
ref_seq <- 'WDWDWDWDWDWDWDWDWDWD'

replacement_order <- c(10,11,9,12,8,13,7,14,6,15,5,16,4,17,3,18,2,19,1,20) %>% rev()
t <- 1
hold2 <- list()
for (i in replacement_order) {
  seq <- strsplit(ref_seq,'')[[1]]
  seq[i] <- 'G'
  seq <- paste(seq, collapse = '')
  ref_seq <- seq
  hold2[[t]] <- seq
  t <- t + 1
}

g_in <- tibble(sequence = hold2 %>% unlist()) %>% 
  mutate(
    is.supp = ifelse(sequence %in% library_2019$combinatorial$sequence, 'no', 'yes')
  )

##add g_in and g_out sets to library list
library_2019$g_in <- g_in
library_2019$g_out <- g_out

rm(list = c('g_in', 'g_out', 'hold', 'hold2',
            'i', 'ref_seq', 'replacement_order', 'seq', 't'))


##set1 and set2----
ref_seq <- 'WDWDWDWDWDWDWDWDWDWD'

terminal_wd <- list()

for(i in 1:20){
  seq <- strsplit(ref_seq, '')[[1]]
  seq[i] <- 'G'
  ref_seq <- paste(seq, sep = '', collapse = '')
  terminal_wd[[i]] <- ref_seq
}

terminal_wd <- tibble(sequence = terminal_wd %>% unlist()) %>% 
  mutate(
    is.supp = ifelse(sequence %in% library_2019$combinatorial$sequence, 'no', 'yes')
  )


#internal_wd is reverse of terminal_wd
internal_wd <- list()
for(i in 1:nrow(terminal_wd)){
  internal_wd[[i]] <- strsplit(terminal_wd$sequence[i], '')[[1]] %>% 
    rev() %>% 
    paste(collapse = '')
}

internal_wd <- tibble(sequence = internal_wd %>% unlist()) %>% 
  mutate(
    is.supp = ifelse(sequence %in% library_2019$combinatorial$sequence, 'no', 'yes')
  )

#add to 2019 library
library_2019$temrinal_wd <- terminal_wd
library_2019$internal_wd <- internal_wd

#remove junk
rm('internal_wd', 'terminal_wd', 'i', 'ref_seq', 'seq')

#Make R scanning for 1R 2r and 3r----
ref_seq <- 'GGGGGGGGGGWDWDWDWDWD'

oneR <- list()
for(i in 1:20){
  seq <- strsplit(ref_seq, '')[[1]]
  seq[i] <- 'R'
  oneR[[i]] <- paste(seq, sep = '', collapse = '')
}

oneR <- tibble(sequence = oneR %>% unlist()) %>% 
  mutate(
    is.supp = ifelse(sequence %in% library_2019$combinatorial$sequence, 'no', 'yes')
  )

twoR <- list()
for(i in 1:19){
  seq <- strsplit(ref_seq, '')[[1]]
  seq[i:(i+1)] <- 'R'
  twoR[[i]] <- paste(seq, sep = '', collapse = '')
}

twoR <- tibble(sequence = twoR %>% unlist()) %>% 
  mutate(
    is.supp = ifelse(sequence %in% library_2019$combinatorial$sequence, 'no', 'yes')
  )

threeR <- list()
for(i in 1:18){
  seq <- strsplit(ref_seq, '')[[1]]
  seq[i:(i+2)] <- 'R'
  threeR[[i]] <- paste(seq, sep = '', collapse = '')
}

threeR <- tibble(sequence = threeR %>% unlist()) %>% 
  mutate(
    is.supp = ifelse(sequence %in% library_2019$combinatorial$sequence, 'no', 'yes')
  )

#add 1r 2r and 3r to library_2019
library_2019$oneR <- oneR
library_2019$twoR <- twoR
library_2019$threeR <- threeR

rm(list = c('oneR', 'twoR', 'threeR', 'i', 'ref_seq', 'seq'))

############################################################################
#Future sets
#make the set, turn it into a tibble, add as a new element in the library_2019 list

############################################################################
#Export library as excel where each set is its own sheet
library(xlsx)

#for(i in 1:length(library_2019)){
#  write.xlsx(library_2019[[i]], file = 'Library_2019.xlsx', sheetName = names(library_2019)[i],
#             append = T)
#}

#Use append = T in write.xlsx() to add on to this file in the future











