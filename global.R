data <- readRDS("data.Rds")
data$playlist_name <- as.factor(data$playlist_name)
data$episode_name <-as.factor(data$episode_name)