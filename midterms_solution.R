#### Challenge 1 ------
library(dplyr)
library(ggplot2)
library(psych)

#### Challenge 2 ------
data <- read.csv("episodes/data/empra_color_intelligence_clean.csv")

#### Challenge 3 ------
colnames(data)
# View(data)

str(data)

# Intelligence Columns:
# everything starting with "item", "fragebogen_der_im_interview_verwendet_wurde",
# maybe "abi" as validation, starting with *dq*

# Physical Activity Columns:
# everything including *sportart*

#### Challenge 4 ------
describe(data)
glimpse(data)

intelligence_data <- data %>%
  select(contains("item"), fragebogen_der_im_interview_verwendet_wurde,
         contains("dq"))

describe(intelligence_data)

# Answers to the items are weird (ranging 1-9 and including -9)

#### Challenge 5 ------
intelligence_data_clean <- intelligence_data %>%
  filter(item_kont == 1)

nrow(intelligence_data) - nrow(intelligence_data_clean)

intelligence_data %>%
  filter(item_kont != 1 | is.na(item_kont)) %>% View()

# 21 participants excluded, some correct answers to other items, but may be chance

#### Challenge 6 ------
intelligence_data_clean <- intelligence_data_clean %>%
  mutate(
    across(
      starts_with("item"),
      ~ ifelse(.x == 1, 1, 0),
      .names = "{.col}_acc"
    )
  )

#### Challenge 7 ------
intelligence_data_clean <- intelligence_data_clean %>%
  mutate(
    heiq_score = rowSums(across(matches("item\\d+_acc")), na.rm = TRUE)
  )

#### Challenge 8 ------
hist(intelligence_data_clean$heiq_score)

# Not normally distributed, some values are 0 or 1

#### Challenge 9 ------
# Random chance would be 12/9 = 1.3 items, exclude all with < 2
intelligence_data_noguessing <- intelligence_data_clean %>%
  filter(heiq_score > 2, dq_distraction != 3, dq_meaningless_responses != 3)

#### Challenge 10 ------
intelligence_data_noguessing %>%
  count(fragebogen_der_im_interview_verwendet_wurde)

#### Challenge 11 ------
intelligence_data_noguessing %>%
  group_by(fragebogen_der_im_interview_verwendet_wurde) %>%
  summarize(
    mean_score = mean(heiq_score),
    n = n(),
    min = min(heiq_score),
    max = max(heiq_score),
    sd = sd(heiq_score)
  )

#### Challenge 12 ------
intelligence_data_noguessing %>%
  ggplot(
    aes(x = fragebogen_der_im_interview_verwendet_wurde,
        y = heiq_score,
        fill = fragebogen_der_im_interview_verwendet_wurde
    )
  ) +
  geom_boxplot()+
  theme_minimal()+
  labs(
    title = "Intelligence test performance by color of test",
    x = "Test Color",
    y = "HeiQ Score",
    fill = "Test color"
  )
