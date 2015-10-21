# Create a list to store results of our coin flipping expiriment
results <- list()

# Start with a sample size of 10000
for(i in 1:10000) {
	coinTosses <- cumsum(sample(c(-1,1), 1000, replace = TRUE))
	results[[i]] <- coinTosses[length[coinTosses]]
}

# Create a histogram from the List
hist(unlist(results), main = "Title", col = "lightblue", breaks = 100)

# Vertical line at 0 to show average
abline(v = 0, col = "red", lwd = 2)