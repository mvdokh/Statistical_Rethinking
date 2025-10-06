#2M4. Suppose you have a deck with only three cards. Each card has two sides, and each side is either
#black or white. One card has two black sides. The second card has one black and one white side. The
#third card has two white sides. Now suppose all three cards are placed in a bag and shuffled. Someone
#reaches into the bag and pulls out a card and places it flat on a table. A black side is shown facing up,
#but you don’t know the color of the side facing down. Show that the probability that the other side is
#also black is 2/3. Use the counting method (Section 2 of the chapter) to approach this problem. This
#means counting up the ways that each card could produce the observed data (a black side facing up
#on the table).

#2M5. Now suppose there are four cards: B/B, B/W, W/W, and another B/B. Again suppose a card is
#drawn from the bag and a black side appears face up. Again calculate the probability that the other
#side is black.

#2M6. Imagine that black ink is heavy, and so cards with black sides are heavier than cards with white
#sides. As a result, it’s less likely that a card with black sides is pulled from the bag. So again assume
#there are three cards: B/B, B/W, and W/W. After experimenting a number of times, you conclude that
#for every way to pull the B/B card from the bag, there are 2 ways to pull the B/W card and 3 ways to
#pull the W/W card. Again suppose that a card is pulled and a black side appears face up. Show that
#the probability the other side is black is now 0.5. Use the counting method, as before.

# Prior: probability of pulling each card (all equally likely)
p_black_black <- 1/6   # the card with two black sides (BB)
p_black_white <- 2/6   # the card with one black and one white side (BW)
p_white_white <- 3/6   # the card with two white sides (WW)

# Probabilities of seeing a black/white face up given the card pulled
# (i.e., P(face up = black | card = X) and P(face up = white | card = X))
p_black_given_black_pulled <- 1   # P(black up | BB)  both sides black -> always black
p_white_given_black_pulled <- 0   # P(white up | BB)

p_black_given_black_white_pulled <- 1/2  # P(black up | BW) one black side -> 1/2
p_white_given_black_white_pulled <- 1/2  # P(white up | BW)

p_black_given_white_pulled <- 0   # P(black up | WW) -> never black
p_white_given_white_pulled <- 1   # P(white up | WW) -> always white

# Probability of observing a black face up (law of total probability)
p_black_up <- (
  p_black_black * p_black_given_black_pulled +
  p_black_white * p_black_given_black_white_pulled +
  p_white_white * p_black_given_white_pulled
)

# Posterior: P(card = BB | observed black up)
p_bb_given_black_up <- (p_black_black * p_black_given_black_pulled) / p_black_up

# Posterior: P(card = BW | observed black up)
p_bw_given_black_up <- (p_black_white * p_black_given_black_white_pulled) / p_black_up

# Posterior: P(card = WW | observed black up)
p_ww_given_black_up <- (p_white_white * p_black_given_white_pulled) / p_black_up

# Probability that the other side is black given we saw black up:
# only the BB card has other side black for sure; the BW card's other side is white.
p_other_side_black_given_black_up <- p_bb_given_black_up * 1 + p_bw_given_black_up * 0 + p_ww_given_black_up * 0

# Print results
cat("P(black up) =", p_black_up, "\n")
cat("P(BB | black up) =", p_bb_given_black_up, "\n")
cat("P(BW | black up) =", p_bw_given_black_up, "\n")
cat("P(WW | black up) =", p_ww_given_black_up, "\n")
cat("P(other side is black | black up) =", p_other_side_black_given_black_up, "\n")
