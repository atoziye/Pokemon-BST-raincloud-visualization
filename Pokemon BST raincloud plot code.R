# Load packages
library(ggplot2)
library(ggrain)
library(sdamr)
library(RColorBrewer)
library(dplyr)

# Read in data
pokemon <- read.csv("/Users/atoziye/Downloads/pokemon.csv")

## =========================
## Plot 1: BST by generation
## =========================
# Compute box plot values
gen_summary <- pokemon %>%
  group_by(generation) %>%
  summarise(gen_1q = quantile(total, probs = 0.25, na.rm = TRUE),
            gen_3q = quantile(total, probs = 0.75, na.rm = TRUE),
            gen_median = median(total, na.rm = TRUE),
            gen_min = min(total, na.rm = TRUE),
            gen_max = max(total, na.rm = TRUE),
            n = n())

# Expand color palette from 8 to 9 (9 generations)
pokegen.cols <- 9
pokegen.colors <- colorRampPalette(brewer.pal(8, "Set1"))(pokegen.cols)

# Generate raincloud plot
pokegen <- ggplot(pokemon, aes(generation, total, fill = as.factor(generation), color = as.factor(generation))) +
  geom_rain(
    point.args = list(
      alpha = 0.5),
    point.args.pos = list(
      position = position_jitternudge(
        jitter.width = 0.1,
        jitter.height = 0.075,
        nudge.x = -0.2)),
    violin.args = list(
      color = NA, alpha = 0.6),
    violin.args.pos = list(
      side = "r'", 
      width = 0.7, 
      position = position_nudge(x = 0.125)),
    boxplot.args = list(
      color = "black", 
      alpha = 0.4,
      outlier.shape = NA),
    boxplot.args.pos = list(
      width = 0.15, 
      position = position_nudge(x = 0))) +
  geom_text(data = gen_summary, 
            aes(label = gen_median, y = gen_median), 
            vjust = -1.5, size = 3,
            color = "black",
            fontface = "bold") +
  geom_text(data = gen_summary, 
            aes(label = gen_min, y = gen_min), 
            vjust = 0.4, hjust = 1.15, size = 2,
            color = "black",
            fontface = "bold") +
  geom_text(data = gen_summary, 
            aes(label = gen_max, y = gen_max), 
            vjust = 0.4, hjust = -0.175, size = 2,
            color = "black",
            fontface = "bold") +
  theme_classic() +
  scale_fill_manual(values = pokegen.colors) +
  scale_color_manual(values = pokegen.colors) +
  guides(fill = 'none', color = 'none') +
  coord_flip() +
  scale_y_continuous(breaks = 
                       seq(100, 1200, by = 100), 
                     limits = c(0, 1300),
                     expand = c(0,0)) +
  theme(axis.text.x = element_text(face = "bold", size = 9),
        axis.text.y = element_text(face = "bold", size = 14, margin = margin(r=7))) +
  labs(y = "Base stat total", x = "Generation") +
  theme(axis.title.y = element_text(margin = margin(r = 20), face = "bold"),
        axis.title.x = element_text(margin = margin(t = 20), face = "bold"),
        plot.title = element_text(hjust = 0.5, face = "bold", margin = margin(b = 20))) +  
  ggtitle("Pokemon Base Stat Total (BST) Distributions by Generation")

# Print min/max names for each gen
hl_gen <- pokemon %>%
  group_by(generation) %>%
  summarise(highest_total = max(total),
            highest_total_name = name[which.max(total)],
            lowest_total = min(total),
            lowest_total_name = name[which.min(total)])

# Save plot as .svg
ggsave("BST by gen.svg", pokegen, height = 8, width = 12)

## ===================
## Plot 2: BST by type
## ===================
# Compute box plot values
type_summary <- pokemon %>%
  group_by(type1) %>%
  summarise(type_1q = quantile(total, probs = 0.25, na.rm = TRUE),
            type_3q = quantile(total, probs = 0.75, na.rm = TRUE),
            type_median = median(total, na.rm = TRUE),
            type_min = min(total, na.rm = TRUE),
            type_max = max(total, na.rm = TRUE),
            n = n())

# Set color palette 
type_colors <- c(
  "Normal" = "#A8A77A",
  "Fire" = "#EE8130",
  "Water" = "#6390F0",
  "Electric" = "#F7D02C",
  "Grass" = "#7AC74C",
  "Ice" = "#96D9D6",
  "Fighting" = "#C22E28",
  "Poison" = "#A33EA1",
  "Ground" = "#E2BF65",
  "Flying" = "#A98FF3",
  "Psychic" = "#F95587",
  "Bug" = "#A6B91A",
  "Rock" = "#B6A136",
  "Ghost" = "#735797",
  "Dragon" = "#6F35FC",
  "Dark" = "#705746",
  "Steel" = "#B7B7CE",
  "Fairy" = "#D685AD"
)

# Order factor levels by median total value
ordered_type <- type_summary$type1[order(type_summary$type_median, decreasing = TRUE)]
# Reorder factor levels
pokemon$type1 <- factor(pokemon$type1, levels = ordered_type)

# Generate raincloud plot
poketype <- ggplot(pokemon, aes(type1, total, fill = type1, color = type1)) +
  geom_rain(
    point.args = list(
      alpha = 0.5, size=0.75),
    point.args.pos = list(
      position = position_jitternudge(
        jitter.width = 0.1,
        jitter.height = 0.075,
        nudge.x = -0.25)),
    violin.args = list(
      color = NA, alpha = 0.6),
    violin.args.pos = list(
      side = "r'", 
      width = 1, 
      position = position_nudge(x = 0.1)),
    boxplot.args = list(
      color = "black", 
      alpha = 0.7,
      outlier.shape = NA),
    boxplot.args.pos = list(
      width = 0.15, 
      position = position_nudge(x = 0))) +
  geom_text(data = type_summary, 
            aes(label = type_median, y = type_median), 
            vjust = -0.9, size = 2.5,
            color = "black",
            fontface = "bold") +
  geom_text(data = type_summary, 
            aes(label = type_min, y = type_min), 
            vjust = 0.4, hjust = 1.15, size = 2,
            color = "black",
            fontface = "bold") +
  geom_text(data = type_summary, 
            aes(label = type_max, y = type_max), 
            vjust = 0.4, hjust = -0.175, size = 2,
            color = "black",
            fontface = "bold") +
  theme_classic() +
  scale_fill_manual(values = type_colors) +
  scale_color_manual(values = type_colors) +
  guides(fill = 'none', color = 'none') +
  coord_flip() +
  scale_y_continuous(breaks = 
                       seq(100, 1200, by = 100), 
                     limits = c(0, 1300),
                     expand = c(0,0)) +
  theme(axis.text.x = element_text(face = "bold", size = 9),
        axis.text.y = element_text(face = "bold", size = 10, margin = margin(r=7))) +
  labs(y = "Base stat total", x = "Type") +
  theme(axis.title.y = element_text(margin = margin(r = 20), face = "bold"),
        axis.title.x = element_text(margin = margin(t = 20), face = "bold"),
        plot.title = element_text(hjust = 0.5, face = "bold", margin = margin(b = 20))) +  
  ggtitle("Pokemon Base Stat Total (BST) Distributions by Type")

# Print min/max names for each type
hl_type <- pokemon %>%
  group_by(type1) %>%
  summarise(highest_total = max(total),
            highest_total_name = name[which.max(total)],
            lowest_total = min(total),
            lowest_total_name = name[which.min(total)])

# Save as plot .svg
ggsave("BST by type.svg", poketype, height = 8, width = 12)

