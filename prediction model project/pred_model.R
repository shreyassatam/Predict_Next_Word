library(tidyverse)
library(stringr)

# Load training data
bi_words <- readRDS("./final/bi_words_fast.rds")
tri_words <- readRDS("./final/tri_words_fast.rds")
quad_words <- readRDS("./final/quad_words_fast.rds")
quint_words <- readRDS("./final/quint_words_fast.rds")
sext_words <- readRDS("./final/sext_words_fast.rds")

# n-gram matching function
bigram <- function(input_words){
                    num <- length(input_words)
                    filter(bi_words, word1==input_words[num]) %>% 
                    top_n(1,n) %>%
                    filter(row_number()==1L) %>%
                    select(num_range("word", 2)) %>%
                    as.character() -> out
                    ifelse(out=="character(0)","?",return(out))
}

trigram <- function(input_words){
                     num <- length(input_words)
                     filter(tri_words, word1==input_words[num-1], word2==input_words[num]) %>% 
                     top_n(1,n) %>%
                     filter(row_number()==1L) %>%
                     select(num_range("word", 3)) %>%
                     as.character() -> out
                     ifelse(out=="character(0)","?",return(out))
}

quadgram <- function(input_words){
                    num <- length(input_words)
                    filter(quad_words, word1==input_words[num-2], word2==input_words[num-1],
                           word3==input_words[num]) %>% 
                    top_n(1,n) %>%
                    filter(row_number()==1L) %>%
                    select(num_range("word", 4)) %>%
                    as.character() -> out
                    ifelse(out=="character(0)","?",return(out))
}

quintgram <- function(input_words){
                       num <- length(input_words)
                       filter(quint_words, word1==input_words[num-3], word2==input_words[num-2],
                              word3==input_words[num-1],word4==input_words[num]) %>% 
                       top_n(1,n) %>%
                       filter(row_number()==1L) %>%
                       select(num_range("word", 5)) %>%
                       as.character() -> out
                       ifelse(out=="character(0)","?",return(out))
}

sextgram <- function(input_words){
                      num <- length(input_words)
                      filter(sext_words, word1==input_words[num-4], word2==input_words[num-3],
                             word3==input_words[num-2],word4==input_words[num-1],word5==input_words[num]) %>% 
                      top_n(1,n) %>%
                      filter(row_number()==1L) %>%
                      select(num_range("word", 6)) %>%
                      as.character() -> out
                      ifelse(out=="character(0)","?",return(out))
}

# Call to matching function
ngrams <- function(input){
                    input <- data_frame(text = input)
                    replace_reg <- "[^[:alpha:][:space:]]*"
                    input <- input %>% mutate(text = str_replace_all(text, replace_reg, ""))
                    input_count <- str_count(input, boundary("word"))
                    input_words <- unlist(str_split(input, boundary("word")))
                    input_words <- tolower(input_words)
                    
                    out <- ifelse(input_count==0, "No words input",
                             ifelse(input_count==1, bigram(input_words),
                               ifelse(input_count==2, trigram(input_words), 
                                 ifelse(input_count==3, quadgram(input_words),
                                   ifelse(input_count==4, quintgram(input_words), sextgram(input_words))))))
                    out
}

# n-gram plot function
bi_plot <- function(input_words){
                     num <- length(input_words)
                     filter(bi_words, word1==input_words[num]) %>% 
                     top_n(15,n) %>%
                     ggplot(aes(reorder(paste(word1,word2,sep = " "),n),n)) + geom_col() + 
                                xlab(NULL) + coord_flip() + ggtitle("Bigrams")
                     g <- ggsave("./images/bi_plot.png")
                     return("bi_plot")
}

tri_plot <- function(input_words){
                      num <- length(input_words)
                      filter(tri_words, word1==input_words[num-1], word2==input_words[num]) %>% 
                      top_n(15,n) %>%
                      ggplot(aes(reorder(paste(word1,word2,word3,sep = " "),n),n)) + geom_col() + 
                                 xlab(NULL) + coord_flip() + ggtitle("Trigrams")
                      g <- ggsave("./images/tri_plot.png")
                      return("tri_plot")
}

quad_plot <- function(input_words){
                      num <- length(input_words)
                      filter(quad_words, word1==input_words[num-2], word2==input_words[num-1],
                                         word3==input_words[num]) %>% 
                      top_n(15,n) %>%
                      ggplot(aes(reorder(paste(word1,word2,word3,word4,sep = " "),n),n)) + geom_col() + 
                      xlab(NULL) + coord_flip() + ggtitle("Quadgrams")
                      g <- ggsave("./images/quad_plot.png")
                      return("quad_plot")
}

quint_plot <- function(input_words){
                       num <- length(input_words)
                       filter(quint_words, word1==input_words[num-3], word2==input_words[num-2],
                                           word3==input_words[num-1],word4==input_words[num]) %>% 
                       top_n(15,n) %>%
                       ggplot(aes(reorder(paste(word1,word2,word3,word4,word5,sep = " "),n),n)) + geom_col() + 
                       xlab(NULL) + coord_flip() + ggtitle("Quintgrams")
                       g <- ggsave("./images/quint_plot.png")
                       return(quint_plot)
}

sext_plot <- function(input_words){
                       num <- length(input_words)
                       filter(sext_words, word1==input_words[num-4], word2==input_words[num-3],
                                          word3==input_words[num-2],word4==input_words[num-1],
                                          word5==input_words[num]) %>% 
                       top_n(15,n) %>%
                       ggplot(aes(reorder(paste(word1,word2,word3,word4,word5,word6,sep = " "),n),n)) + 
                       geom_col() + xlab(NULL) + coord_flip() + ggtitle("Sextgrams")
                       g <- ggsave("./images/sext_plot.png")
                       return("sext_plot")
}

# Plotting function
ngram_plot <- function(input){
                  input <- data_frame(text = input)
                  replace_reg <- "[^[:alpha:][:space:]]*"
                  input <- input %>% mutate(text = str_replace_all(text, replace_reg, ""))
                  input_count <- str_count(input, boundary("word"))
                  input_words <- unlist(str_split(input, boundary("word")))
                  input_words <- tolower(input_words)
  
                  out <- ifelse(input_count==0, "empty_plot",
                           ifelse(input_count==1, bi_plot(input_words),
                             ifelse(input_count==2, tri_plot(input_words), 
                               ifelse(input_count==3, quad_plot(input_words),
                                 ifelse(input_count==4, quint_plot(input_words), sext_plot(input_words))))))
                  out
}

