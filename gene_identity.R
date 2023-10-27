# install.packages("ggplot2")
library(ggplot2)

data <- read.csv("gene_identity_data.csv")

# Draw a bar chart:
bonferroni_threshold <- -log10(1.67e-3)

ggplot(data, aes(x = reorder(tissue, -expression), y = expression, 
                 fill = ifelse(expression > bonferroni_threshold, "Exceeds Threshold", "Below Threshold"))) +
  geom_bar(stat="identity") +
  geom_hline(yintercept = bonferroni_threshold, color = "brown", linetype="dashed") +
  scale_fill_manual(values = c("Exceeds Threshold" = "red", "Below Threshold" = "purple")) +
  labs(title = "Gene Expression Levels Across 30 Tissue Types",
       y = "Mean Expression Value") +
  coord_flip() +
  theme_minimal()
