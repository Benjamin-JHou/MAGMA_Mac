# install.packages("ggplot2")
library(ggplot2)

# Replace GO_file.csv with the path to csv file.
data <- read.csv("GO_file.csv")

# Draw a lollipop plot for each GO category (BP, CC, MF):
ggplot(data, aes(x=GO, y=P, color=Category)) +
  geom_segment(aes(x=GO, xend=GO, y=0, yend=P)) +
  geom_point(size=3) +
  facet_wrap(~Category, scales = "free_x") +
  scale_color_manual(values = c("Biological Processes" = "purple", 
                                "Cellular Components" = "green", 
                                "Molecular Functions" = "red")) +
  labs(y="-log10(p-value)", title="Classification Lollipop Illustration for GO Terms") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), 
        legend.position = "none") # Hide legend as facets already provide category information
