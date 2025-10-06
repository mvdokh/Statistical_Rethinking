#2M4. Suppose you have a deck with only three cards. Each card has two sides, and each side is either
#black or white. One card has two black sides. The second card has one black and one white side. The
#third card has two white sides. Now suppose all three cards are placed in a bag and shuffled. Someone
#reaches into the bag and pulls out a card and places it flat on a table. A black side is shown facing up,
#but you don’t know the color of the side facing down. Show that the probability that the other side is
#also black is 2/3. Use the counting method (Section 2 of the chapter) to approach this problem. This
#means counting up the ways that each card could produce the observed data (a black side facing up
#on the table).

#2M7. Assume again the original card problem, with a single card showing a black side face up. Before
#looking at the other side, we draw another card from the bag and lay it face up on the table. The face
#that is shown on the new card is white. Show that the probability that the first card, the one showing
#a black side, has black on its other side is now 0.75. Use the counting method, if you can. Hint: Treat
#this like the sequence of globe tosses, counting all the ways to see each observation, for each possible
#first card.

# Define the three cards and their two sides (label sides to treat them distinct)
cards <- list(
  BB = c("B1","B2"),   # two distinct black sides
  BW = c("B","W"),     # one black, one white
  WW = c("W1","W2")    # two distinct white sides
)

# Build all possible (card, side_up) pairs for each card
first_sides <- data.frame(card = rep(names(cards), times = sapply(cards,length)),
                          side_up = unlist(cards),
                          stringsAsFactors = FALSE)

# For each possible first draw (card, side_up) produce all possible second draws
all_pairs <- do.call(rbind, lapply(1:nrow(first_sides), function(i) {
  first_card <- first_sides[i, "card"]
  first_side <- first_sides[i, "side_up"]
  # remaining cards (remove the entire first card)
  remaining_cards <- cards[names(cards) != first_card]
  # enumerate remaining card-side pairs
  rem_df <- data.frame(card2 = rep(names(remaining_cards), times = sapply(remaining_cards,length)),
                       side2 = unlist(remaining_cards),
                       stringsAsFactors = FALSE)
  data.frame(card1 = first_card,
             side1 = first_side,
             card2 = rem_df$card2,
             side2 = rem_df$side2,
             stringsAsFactors = FALSE)
}))

nrow(all_pairs)  # should be 6 * 4 = 24 total ordered side-up outcomes

# Select only those outcomes that match the observations:
# first shows black up (side1 is "B" or starts with "B"), second shows white up
is_black <- grepl("^B", all_pairs$side1)
is_white <- grepl("^W", all_pairs$side2)

observed <- all_pairs[is_black & is_white, ]

# How many matching sequences?
n_observed <- nrow(observed)

# Among those, count sequences where the other side of the first card is black:
other_side_black <- observed$card1 == "BB"
n_other_black <- sum(other_side_black)

# Probability:
p_other_black_given_obs <- n_other_black / n_observed

# Print helpful summary
cat("Total ordered side-up outcomes:", nrow(all_pairs), "\n")
cat("Outcomes matching (first black up, second white up):", n_observed, "\n")
cat("Of those, outcomes where first card's other side is black:", n_other_black, "\n\n")
cat("P(other side black | first black up, second white up) =", p_other_black_given_obs, "\n")

# --------------------------
# Plotting function
# --------------------------
plot_probabilities <- function(observed_df, p_value) {
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    install.packages("ggplot2")
  }
  library(ggplot2)
  
  observed_df$other_side <- ifelse(observed_df$card1 == "BB", "Other side = Black", "Other side = White")
  
  p <- ggplot(observed_df, aes(x = card1, fill = other_side)) +
    geom_bar(position = "dodge", color = "gray20") +
    scale_fill_manual(values = c("Other side = Black" = "black", "Other side = White" = "white")) +
    theme_minimal(base_size = 14) +
    labs(
      title = "Outcomes Given: First = Black Up, Second = White Up",
      subtitle = sprintf("P(other side black) = %.2f", p_value),
      x = "First card drawn",
      y = "Count of matching outcomes",
      fill = "First card’s other side"
    ) +
    theme(
      plot.title = element_text(face = "bold"),
      panel.grid.minor = element_blank()
    )
  
  print(p)  # ensures it appears in scripts as well as interactive sessions
}

# Show plot
plot_probabilities(observed, p_other_black_given_obs)


