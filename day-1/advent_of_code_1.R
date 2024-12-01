library(dplyr)

christmas_lists <- read.csv("~/Downloads/advent_of_code/christmas_lists", sep="")

# order the lists
list_1 <- christmas_lists[order(christmas_lists$List_1),]$List_1
list_2 <- christmas_lists[order(christmas_lists$List_2),]$List_2

# bind the two ordered lists and create data frame
ordered_christmas_list <- cbind(list_1, list_2)

ordered_christmas_list <- as.data.frame(ordered_christmas_list)

# find the distance between the two lists
ordered_christmas_list$distance <- abs(ordered_christmas_list$list_1 - ordered_christmas_list$list_2)

# add up the total distances
total_distance <- sum(ordered_christmas_list$distance)

### QUESTION 2 ###

# get a tally for each number in list 2
tally_list_1 <- ordered_christmas_list %>% group_by(list_2) %>% tally()

# merge the original list to the tally
ordered_christmas_list_2 <- merge(ordered_christmas_list, tally_list_1, by.x = 'list_1', by.y = 'list_2', all.x = TRUE)

# multiply the tally to the list 1
ordered_christmas_list_2$mult_tally <- ordered_christmas_list_2$list_1*ordered_christmas_list_2$n

total_distance_2 <- sum(na.omit(ordered_christmas_list_2$mult_tally))
