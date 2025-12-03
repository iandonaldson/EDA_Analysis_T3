make_some_data <- function() {
  set.seed(42)  # For reproducibility
  
  data <- data.frame(
    Character = sample(c("Arthur Dent", "Ford Prefect", "Zaphod Beeblebrox", "Trillian", "Marvin", "Slartibartfast", "Deep Thought", "Eddie", "Vogon Jeltz", "Prostetnic Vogon"), 10, replace = FALSE),
    Planet = sample(c("Earth", "Betelgeuse V", "Magrathea", "Vogon Homeworld", "Eadrax", "Damia", "Barnard's Star"), 10, replace = TRUE),
    Probability_of_Survival = round(runif(10, 0, 1), 2),
    Favorite_Number = sample(c(42, 7, 13, 3, 9, 101, 23), 10, replace = TRUE),
    Catchphrase = sample(c("Don't Panic!", "Resistance is useless!", "Life, the Universe, and Everything", "Mostly Harmless", "So long, and thanks for all the fish", "The answer is 42", "Share and Enjoy"), 10, replace = TRUE)
  )
  
  return(data)
}

# Example usage:
# hitchhiker_data <- make_some_data()
# print(hitchhiker_data)
