'''
Author: Daniel Bueno Domingueti
Date: 18/08/2021
'''

#Required packages
require(seminr)
require(DiagrammeR)

library(seminr)
library(DiagrammeR)

# Input: summary(pls_estimation_execution)
# Output: CSV files in the folder PLS_Estimation, according all the data presented in the summary variable
export_pls_data <- function(s) {
   if (!dir.exists("PLS_Estimation")) {
      dir.create("PLS_Estimation")
   }
   
   write.csv(x=s$reliability, file="PLS_Estimation/Reliability.csv")
   write.csv(x=s$loadings, file="PLS_Estimation/Loadings.csv")
   write.csv(x=s$weights, file="PLS_Estimation/Weights.csv")
   write.csv(x=s$total_effects, file="PLS_Estimation/Total_effects.csv")
   write.csv(x=s$total_indirect_effects, file="PLS_Estimation/Total_indirect_effects.csv")
   write.csv(x=s$fSquare, file="PLS_Estimation/F_squared.csv")
   write.csv(x=s$paths, file="PLS_Estimation/Paths.csv")
   write.csv(x=s$composite_scores, file="PLS_Estimation/Composite_scores.csv")
   write.csv(x=s$it_criteria, file="PLS_Estimation/Iteration_criteria.csv")
   write.csv(x=s$iterations, file="PLS_Estimation/Iterations.csv")
   write.csv(x=s$descriptives$statistics$items, file="PLS_Estimation/Descriptives_statistics_items.csv")
   write.csv(x=s$descriptives$statistics$constructs, file="PLS_Estimation/Descriptives_statistics_constructs.csv")
   write.csv(x=s$validity$htmt, file="PLS_Estimation/Validity_htmt.csv")
   write.csv(x=s$validity$fl_criteria, file="PLS_Estimation/Validity_fornel_larcker.csv")
   write.csv(x=s$validity$cross_loadings, file="PLS_Estimation/Validity_cross_loadings.csv")
   
   c <- 0
   base_name <- "PLS_Estimation/Validity_vif_items_"
   for (value in s$validity$vif_items) {
      name <- paste(base_name, c, ".csv", collapse=NULL, sep="")
      write.csv(x=value, file=name)
      c <- c + 1
   }
   
   c <- 0
   base_name <- "PLS_Estimation/Vif_antecedents_"
   for (value in s$vif_antecedents) {
      name = paste(base_name, c, ".csv", collapse=NULL, sep="")
      write.csv(x=value, file=name)
      c <- c + 1
   }
}

#Input: summary(boostrap_estimed_model)
# Output: CSV files in the Folder Bootstrap_Estimation, according all the data presented in the summary variable.
export_bootstrap_data <- function(s) {
   
   if (!dir.exists("Bootstrap_Estimation")) {
      dir.create("Bootstrap_Estimation")
   }
   
   write.csv(x=s$bootstrapped_paths, file="Bootstrap_Estimation/Bootstraped_Paths.csv")
   write.csv(x=s$bootstrapped_weights, file="Bootstrap_Estimation/Bootstraped_Weights.csv")
   write.csv(x=s$bootstrapped_loadings, file="Bootstrap_Estimation/Bootstraped_Loadings.csv")
   write.csv(x=s$bootstrapped_HTMT, file="Bootstrap_Estimation/Bootstraped_HTMT.csv")
   write.csv(x=s$bootstrapped_total_paths, file="Bootstrap_Estimation/Bootstraped_Total_Paths.csv")
}

# Main script
# Set the dataset csv file as your input
utaut2_data <- read.csv("dataset_scaled.csv", sep=',', header=TRUE, encoding = "UTF-8")

# Define the constructs and how to load the data from the file
# Define a composite and define if it is formed by one (single_item("Col_Name")) or multiple items (multi_items("col_name_pattern", index_start:index_end))
utaut2_mm <- constructs(
  composite("EXDE", multi_items("exde", 1:4)),
  composite("EXES", multi_items("exes", 1:4)),
  composite("COFA", multi_items("cofa", 1:4)),
  composite("MOHE", multi_items("mohe", 1:3)),
  composite("PR", multi_items("preco", 1:3)),
  composite("INCO", multi_items("inco", 1:3)),
  composite("Sexo", single_item("sexo")),
  composite("Renda familiar", single_item("Renda_familiar")),
  composite("Idade", single_item("idade"))
)

# Define the relationships between the constructs
utaut2_sm <- relationships(
   paths(from = c("COFA","EXDE","EXES","MOHE","PR"), to = "INCO"),
   paths(from = "Renda familiar", to = c("COFA","MOHE","PR")),
   paths(from = "Sx", to = c("PR", "MOHE", "EXES")),
   paths(from = "Id", to = c("EXES", "EXDE"))
)

# Execute the PLS model estimation, and export the data.
pls_model <- estimate_pls(
   data = utaut2_data,
   measurement_model = utaut2_mm,
   structural_model = utaut2_sm
)

export_pls_data(summary(pls_model))
plot(pls_model)
save_plot("PLS_Estimation/Model_Plot.pdf")

# Execute the bootstrap estimation and export the data. Comment the following lines if not needed
boot_model <- bootstrap_model(pls_model, nboot=10, cores=2)
export_bootstrap_data(summary(boot_model))
plot(boot_model)
save_plot("Bootstrap_Estimation/Model_Bootstrap_Plot.pdf")